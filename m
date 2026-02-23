Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AB2E98E10
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSXf-0004hR-JH; Mon, 23 Feb 2026 04:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSXP-0004KB-Qh
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSXN-0006rL-P4
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yil/qSkj5M/csFVMtFlx3NiFAc3Upos8qedBJ8xz6r4=;
 b=VdMCLducP8uZGviwioOsC8TOa+v/HWg0h8aB+fDchW9FTtJ0sWk7BZVFunT7Ekw6TmRPR4
 QOXsznnMXtGlOxIEXv7yZMbvyaTs8WMDrzFbHUNSSTD48YsPhmYS+1WnOGXI5H/jkSAiQ9
 gct1nL5SuwSSjqUHVggNpefNiRjNz7A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-zg83TSB3PamprbsrnWFgPQ-1; Mon,
 23 Feb 2026 04:47:30 -0500
X-MC-Unique: zg83TSB3PamprbsrnWFgPQ-1
X-Mimecast-MFC-AGG-ID: zg83TSB3PamprbsrnWFgPQ_1771840049
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA6781956050; Mon, 23 Feb 2026 09:47:29 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E79041800591; Mon, 23 Feb 2026 09:47:28 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL v2 13/85] scripts/modinfo: use f-strings
Date: Mon, 23 Feb 2026 10:45:31 +0100
Message-ID: <20260223094649.2005118-14-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/modinfo-generate.py | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
index 63093a0f820..8011c842caf 100644
--- a/scripts/modinfo-generate.py
+++ b/scripts/modinfo-generate.py
@@ -9,7 +9,7 @@ def print_array(name: str, values: list[str]) -> None:
     if len(values) == 0:
         return
     list = ", ".join(values)
-    print("    .%s = ((const char*[]){ %s, NULL })," % (name, list))
+    print(f"    .{name} = ((const char*[]){{ {list}, NULL }}),")
 
 def parse_line(line: str) -> tuple[str, str]:
     kind = ""
@@ -53,17 +53,16 @@ def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str
                 # don't add a module which dependency is not enabled
                 # in kconfig
                 if data.strip() not in enabled:
-                    print("    /* module {} isn't enabled in Kconfig. */"
-                          .format(data.strip()))
+                    print(f"    /* module {data.strip()} isn't enabled in Kconfig. */")
                     print("/* },{ */")
                     return None
             else:
                 print("unknown:", kind)
                 exit(1)
 
-    print("    .name = \"%s\"," % name)
+    print(f'    .name = "{name}",')
     if arch != "":
-        print("    .arch = %s," % arch)
+        print(f"    .arch = {arch},")
     print_array("objs", objs)
     print_array("deps", deps)
     print_array("opts", opts)
@@ -100,7 +99,7 @@ def main(args: list[str]) -> None:
     for modinfo in args[2:]:
         with open(modinfo) as f:
             lines = f.readlines()
-        print("    /* %s */" % modinfo)
+        print(f"    /* {modinfo} */")
         (basename, _) = os.path.splitext(modinfo)
         moddeps = generate(basename, lines, enabled)
         if moddeps is not None:
@@ -110,8 +109,7 @@ def main(args: list[str]) -> None:
 
     error = False
     for dep in deps.difference(modules):
-        print("Dependency {} cannot be satisfied".format(dep),
-              file=sys.stderr)
+        print(f"Dependency {dep} cannot be satisfied", file=sys.stderr)
         error = True
 
     if error:
-- 
2.53.0


