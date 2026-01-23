Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6061ED72347
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjBwn-00036o-EW; Fri, 23 Jan 2026 02:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBwk-00035Y-Rq
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:51:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBwj-000299-1w
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4JaSHklAUBKq8aqtuaNol+PHqOOKnBqIN80LF2kb2A=;
 b=GTdQssQN9R70bxYGAOSrP/x5D7Dx4Bd/UB6iHhb182Ez7E31keR3JdzVoaWzvX8//nblBB
 CRsCS7jSgV8VCVH7L15BGBViHRTK/RB+lFfEtDl98P+7ZdKYui5/IW27L5UDTzaYHj55Ys
 spHOJF2DhESVwNgU5N6GVCCn8BOMjJE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-6EoPUm0XPVu3uXI0hm0pIQ-1; Fri,
 23 Jan 2026 02:51:04 -0500
X-MC-Unique: 6EoPUm0XPVu3uXI0hm0pIQ-1
X-Mimecast-MFC-AGG-ID: 6EoPUm0XPVu3uXI0hm0pIQ_1769154663
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AE9C1800451; Fri, 23 Jan 2026 07:51:03 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CAD41958DC1; Fri, 23 Jan 2026 07:51:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 12/37] scripts/modinfo: use f-strings
Date: Fri, 23 Jan 2026 11:49:15 +0400
Message-ID: <20260123074945.2563196-13-marcandre.lureau@redhat.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.52.0


