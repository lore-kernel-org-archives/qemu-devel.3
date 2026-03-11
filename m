Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C465FD88D4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08Xb-00046H-MG; Tue, 10 Mar 2026 21:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XT-00041m-5l
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XQ-0004sm-Hx
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:06 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so60584935ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193143; x=1773797943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4Wp7/fhzYKiB17fh69l1UR/8i6fmLxfGHsplNPX9Rc=;
 b=IDhpy3QAsiPxg8DaD9oQHkESPR+lmAnMQZturlH5iuHQ/umZeiBhDJ2MzuQie47OHA
 Q166TTf6qWPcHNJTeyHUN09V6ljVlqmeluwYmONCcx8z5K+6B6Va0xAPVJj7bsSt7nI0
 kwX7ah/w8ux4AWs0igDBCG1BWETPb/XcP5WRR5s31yEQPPc0uA7Eb78lPjWhwWUFVUyo
 2LoXv5apZiGR5Qfa+g0tJSiO0HbnNs9VaFAom+XiySuVSfXX/ySPkWCtNMW/+J7HS+Kv
 QY4wQUDKu0jsfpCCSr3LJ9E7IEdUXst0G9+HzULr4W8z7BL0Zk6FwrGMXSl/b6Rx1MOz
 tmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193143; x=1773797943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A4Wp7/fhzYKiB17fh69l1UR/8i6fmLxfGHsplNPX9Rc=;
 b=SXQZ8y+ghjy3Rzn7QF7eFc6pSO247VxdDVcPIP6M6ltswBnFp/sykDZe9wPKnmuUlY
 levl247/6pIMq/bx6Puyq45e0PqdGfnGY2CLaEGAB77m5li3pOOQs5ib+av6BqtHYyYm
 g43/SwKnz+rEtfLQUD6lHg/OFVmE4VXKlTGUyrEtpl6/Ed/9exm0seXNFyCs95k2GBRk
 saS1UwCGMCqfBp21ePKRKYNF8pnbvexpUtqWt6TkuFN/Er/lB4NViLe3PWoxYDRZSrgc
 xs1V2eNlFMf6ZzDx43EddfHG1IlESCz0pGpHPi6qhWqyL50dB87jvxHAmGYpkZXX4+31
 bwpw==
X-Gm-Message-State: AOJu0YzKgRc+T+4limISbkLh2bF8/yIT6sc1YB9XiEqVSmlOFNd0A7YH
 d4DkHPVRsSz7pjzdLwCb/O6SA7/Teol3TS5JiW3V2IaVJCPf+UwWejAhTMSviAt0kYftmz5NQoD
 bnBt2
X-Gm-Gg: ATEYQzw+Lk+jcbO/fqSuJ1zEx5cBapNlehYH2hNyu917M2Cl/Xpo7DZ4uICcSPCh/eA
 tE9K+AEtG2fGcX9e0qKUbo4GkzvCyZPhSjYF0HGj1APLsBn1erkJjNaSx7I/PL1g7i0rVXECztc
 SqZeHJ1Xt5BOV2LPeAw1kw0Tu2tLnGHqg92RwhutyTKtg947PVbitNW/PNtLKg55TNyuJb4nJvz
 +qtYppUsZwavO85rtZStMP4z3BqQJJQcKm5cP4bCld1t9wUIhWQCtMnQcfN5JBkQm6KmQof7l9q
 xrdDwOxSjm7eOAjIpWT2CubzQCH84XKwgM24TCsRrRUhLnoAttVtpJ4IveDJGBuZREqp8cKko8A
 yRMqKlQZpZwyXdVrd2ftbA2f81uZNMeHNpP8SdXno1cQOc6aACxZYEsCgphdQlh6KSv6qspcMAM
 gPcjngToJLkt06GOV6duDSURTArqZ76R/ctqOWvNqWi/9yg+q5qrVBO/x40ZfgSQI85SY9GnGQt
 EwL
X-Received: by 2002:a17:902:ea04:b0:2ae:8293:74ee with SMTP id
 d9443c01a7336-2aeae8f21b1mr8620065ad.48.1773193143071; 
 Tue, 10 Mar 2026 18:39:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:39:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 16/16] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Date: Tue, 10 Mar 2026 18:38:37 -0700
Message-ID: <20260311013837.69945-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

gdb_static_features[] does not depend on target-specific code.
Instead of generating one file per target, generate a single file
with a single gdb_static_features[] array.

Co-developed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-17-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                               | 14 --------------
 stubs/gdbstub.c => gdbstub/gdb-xml-stub.c |  0
 gdbstub/meson.build                       | 23 +++++++++++++++++++++++
 stubs/meson.build                         |  2 --
 4 files changed, 23 insertions(+), 16 deletions(-)
 rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)

diff --git a/meson.build b/meson.build
index 503cde5ea90..538efb7092d 100644
--- a/meson.build
+++ b/meson.build
@@ -4248,7 +4248,6 @@ if have_rust
 endif
 
 
-feature_to_c = find_program('scripts/feature_to_c.py')
 rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
 
 if host_os == 'darwin'
@@ -4328,19 +4327,6 @@ foreach target : target_dirs
     endif
   endif
 
-  if 'TARGET_XML_FILES' in config_target
-    gdbstub_xml_files = []
-    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
-      gdbstub_xml_files += 'gdbstub/gdb-xml/' + gdbstub_xml
-    endforeach
-    gdbstub_xml = custom_target(target + '-gdbstub-xml.c',
-                                output: target + '-gdbstub-xml.c',
-                                input: files(gdbstub_xml_files),
-                                command: [feature_to_c, '@INPUT@'],
-                                capture: true)
-    arch_srcs += gdbstub_xml
-  endif
-
   if target in config_target_info
     arch_srcs += config_target_info[target]
   else
diff --git a/stubs/gdbstub.c b/gdbstub/gdb-xml-stub.c
similarity index 100%
rename from stubs/gdbstub.c
rename to gdbstub/gdb-xml-stub.c
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index 15c666f5752..b61d2e915c1 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -4,6 +4,29 @@
 # types such as hwaddr.
 #
 
+gdbstub_xml_files = []
+foreach target : target_dirs
+  config_target = config_target_mak[target]
+  if 'TARGET_XML_FILES' in config_target
+    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
+      if not gdbstub_xml_files.contains('gdb-xml/' + gdbstub_xml)
+        gdbstub_xml_files += 'gdb-xml/' + gdbstub_xml
+      endif
+    endforeach
+  endif
+endforeach
+if gdbstub_xml_files.length() > 0
+  feature_to_c = find_program('../scripts/feature_to_c.py')
+  gdbstub_xml = custom_target('gdbstub-xml.c',
+                              output: 'gdbstub-xml.c',
+                              input: files(gdbstub_xml_files),
+                              command: [feature_to_c, '@INPUT@'],
+                              capture: true)
+else
+  gdbstub_xml = files('gdb-xml-stub.c')
+endif
+common_ss.add(gdbstub_xml)
+
 # We build two versions of gdbstub, one for each mode
 user_ss.add(files(
   'gdbstub.c',
diff --git a/stubs/meson.build b/stubs/meson.build
index fad796a49da..7189ff63ed5 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -89,8 +89,6 @@ if have_system
 endif
 
 if have_system or have_user
-  stub_ss.add(files('gdbstub.c'))
-
   # Also included in have_system for --disable-tcg builds
   stub_ss.add(files('replay.c'))
 
-- 
2.47.3


