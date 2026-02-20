Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7823CC5ACD3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 16:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtTFP-0000PP-AQ; Fri, 20 Feb 2026 11:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1vtTFO-0000P2-69
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 11:20:54 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1vtTFM-00017J-CN
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 11:20:53 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1A95980855;
 Fri, 20 Feb 2026 19:20:51 +0300 (MSK)
Received: from davydov-max-lin.yandex.net (unknown
 [2a02:6bf:8011:f00:b5ad:46f:80fc:2732])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vJfuXW4AvuQ0-mKVhfrRv; Fri, 20 Feb 2026 19:20:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771604450;
 bh=rh39e7ox5gmtRN14OjKi5+QqX/5k2SEGor/ss5/Ybsc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=mnzthTfVjCi4Tx57MXK75Asd/fauKkcsBFzon85oZYoYTz/lXtLoa6DpVeTbWEU6p
 XBDbBWVtNj7psMR7ZqfyAHDh8jY5TebUBu+gEwk46Zdr+Rjc2QyQL+g1otNl8r+kaN
 dpo5MTDXAqQwadLsJMhEq66hjWIMPTGVRqiqlWLU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: crosa@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 vsementsov@yandex-team.ru, davydov-max@yandex-team.ru
Subject: [PATCH v2 2/2] scripts/compare-mt: stop using global variables
Date: Fri, 20 Feb 2026 19:19:48 +0300
Message-Id: <20260220161948.213380-3-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220161948.213380-1-davydov-max@yandex-team.ru>
References: <20260220161948.213380-1-davydov-max@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All variables inside the main if-structure are global that can be
confusing or be the reason of an issue. So, all code inside this structure
was moved to the separate function to detect all usages of these global
variables. All these usages were deleted.

Also Configuration._qemu_args was removed as unused.

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 scripts/compare-machine-types.py | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/scripts/compare-machine-types.py b/scripts/compare-machine-types.py
index 96ee7e9ee6..5dfaafef89 100755
--- a/scripts/compare-machine-types.py
+++ b/scripts/compare-machine-types.py
@@ -264,7 +264,6 @@ def __init__(self, vm: QEMUMachine,
                  req_mt: List[str], all_mt: bool) -> None:
         self._vm = vm
         self._binary = vm.binary
-        self._qemu_args = args.qemu_args.split(' ')
 
         self._qemu_drivers = VMPropertyGetter(vm)
         self.req_mt = get_req_mt(self._qemu_drivers, vm, req_mt, all_mt)
@@ -482,17 +481,17 @@ def fill_prop_table(configs: List[Configuration],
 
 def print_table(table: pd.DataFrame, table_format: str) -> None:
     if table_format == 'json':
-        print(comp_table.to_json())
+        print(table.to_json())
     elif table_format == 'csv':
-        print(comp_table.to_csv())
+        print(table.to_csv())
     else:
-        print(comp_table.to_markdown(index=False, stralign='center',
-                                     colalign=('center',), headers='keys',
-                                     tablefmt='fancy_grid',
-                                     disable_numparse=True))
+        print(table.to_markdown(index=False, stralign='center',
+                                colalign=('center',), headers='keys',
+                                tablefmt='fancy_grid',
+                                disable_numparse=True))
 
 
-if __name__ == '__main__':
+def main() -> None:
     args = parse_args()
     with ExitStack() as stack:
         vms = [stack.enter_context(QEMUMachine(binary=binary, qmp_timer=15,
@@ -506,3 +505,7 @@ def print_table(table: pd.DataFrame, table_format: str) -> None:
         comp_table = fill_prop_table(configurations, args.raw)
         if not comp_table.empty:
             print_table(comp_table, args.format)
+
+
+if __name__ == '__main__':
+    main()
-- 
2.34.1


