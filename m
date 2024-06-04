Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25BDC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQDM-0005ln-Ug; Tue, 04 Jun 2024 05:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sEQDL-0005la-GK; Tue, 04 Jun 2024 05:12:19 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sEQDJ-0001eN-BG; Tue, 04 Jun 2024 05:12:19 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D030A42A29;
 Tue,  4 Jun 2024 11:12:13 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, crosa@redhat.com, jsnow@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com
Subject: [RFC PATCH] block-coroutine-wrapper: support generating wrappers for
 functions without arguments
Date: Tue,  4 Jun 2024 11:12:08 +0200
Message-Id: <20240604091208.39677-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

An alternative would be to detect whether the argument list is 'void'
in FuncDecl's __init__, assign the empty list to self.args there and
special case based on that in the rest of the code.

Not super happy about the introduction of the 'void_value' parameter,
but the different callers seem to make something like it necessary.
Could be avoided if there were a nice way to map a format which
contains no other keys besides '{name}' to the empty list if the
argument's 'name' is 'None'. At least until there is a format that
contains both '{name}' and another key which would require special
handling again.

The generated code unfortunately does contain a few extra blank lines.
Avoiding that would require turning some of the (currently static)
formatting surrounding gen_block() dynamic based upon whether the
argument list is 'void'.

Happy about any feedback/suggestions!

 scripts/block-coroutine-wrapper.py | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index dbbde99e39..533f6dbe12 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -54,6 +54,11 @@ class ParamDecl:
                           r')')
 
     def __init__(self, param_decl: str) -> None:
+        if param_decl.strip() == 'void':
+            self.decl = 'void'
+            self.type = 'void'
+            self.name = None
+            return
         m = self.param_re.match(param_decl.strip())
         if m is None:
             raise ValueError(f'Wrong parameter declaration: "{param_decl}"')
@@ -114,10 +119,14 @@ def gen_ctx(self, prefix: str = '') -> str:
         else:
             return 'qemu_get_aio_context()'
 
-    def gen_list(self, format: str) -> str:
+    def gen_list(self, format: str, void_value='') -> str:
+        if len(self.args) == 1 and self.args[0].type == 'void':
+            return void_value
         return ', '.join(format.format_map(arg.__dict__) for arg in self.args)
 
     def gen_block(self, format: str) -> str:
+        if len(self.args) == 1 and self.args[0].type == 'void':
+            return ''
         return '\n'.join(format.format_map(arg.__dict__) for arg in self.args)
 
 
@@ -158,7 +167,7 @@ def create_mixed_wrapper(func: FuncDecl) -> str:
     graph_assume_lock = 'assume_graph_lock();' if func.graph_rdlock else ''
 
     return f"""\
-{func.return_type} {func.name}({ func.gen_list('{decl}') })
+{func.return_type} {func.name}({ func.gen_list('{decl}', 'void') })
 {{
     if (qemu_in_coroutine()) {{
         {graph_assume_lock}
@@ -186,7 +195,7 @@ def create_co_wrapper(func: FuncDecl) -> str:
     name = func.target_name
     struct_name = func.struct_name
     return f"""\
-{func.return_type} {func.name}({ func.gen_list('{decl}') })
+{func.return_type} {func.name}({ func.gen_list('{decl}', 'void') })
 {{
     {struct_name} s = {{
         .poll_state.ctx = qemu_get_current_aio_context(),
@@ -284,7 +293,7 @@ def gen_no_co_wrapper(func: FuncDecl) -> str:
     aio_co_wake(s->co);
 }}
 
-{func.return_type} coroutine_fn {func.name}({ func.gen_list('{decl}') })
+{func.return_type} coroutine_fn {func.name}({ func.gen_list('{decl}', 'void') })
 {{
     {struct_name} s = {{
         .co = qemu_coroutine_self(),
-- 
2.39.2



