Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB2C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 23:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4q89-0002il-4H; Tue, 15 Apr 2025 19:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4q86-0002cR-Ms
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 19:55:50 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4q84-0005xY-Ff
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 19:55:50 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85e15dc8035so201627839f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 16:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744761346; x=1745366146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kJ1d08vVBcU0mhx7ZyhDbcvTv4EofLcKJPMCEY/4DTo=;
 b=AZCV1z765cOcAeykmzI01/LhLEj99vyGY6lOYoHQr4eZPm67EMDLog27ZPxJMXW8+b
 0UriUDZxyaZRa5AtZRogUufPAlDf7D2xpetPJ13ZExfBbmhrCPXFJDXAB+5xV3n4EEuG
 VyZkhMAq+ER3zCksu3BaM7wOZrDE7RXqfIKF60GSfz0blPVjuoOPPAlmwXJ9ITfg77oI
 IKQHDQim3SK+nVmbyp+CUnWPNYbAKfGi/gfrnQLtN+w3yGlJumqv1gBGw1V7i4dvkybk
 29EG6A1ZusLNXtNZqtKoMrFRcBl5pM9DQfpsgSkR+dxDx7yOdb/h2SXjIZ2nMH/ToNjI
 w5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744761346; x=1745366146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kJ1d08vVBcU0mhx7ZyhDbcvTv4EofLcKJPMCEY/4DTo=;
 b=qsihHYKc9123sif1CjeRnqgkvhzR6LAmd16lKdoYHW8J4+cfEf9itYH+j67O1G2t+t
 y5hN+VSIiHqK5ShHsIZe+TXEoaTjpOud8Pvz45eECFM4KP9XpFjIn8oxoAsbFfaN6HXP
 Gedyq6Rh51mMV8XzDQebIvy4oSpujl1JQzSfmNUXvtfLZMomMr3uoEhvg742QjjFDx3I
 KBGDuPgsHB6TF85jHCfQXteT7vEfYN4fWNI7yrM6VXdclyMlaiZj6XbuAvLW2jbfCIN6
 N4y3r4nIv6rAN29EPbnM7IVRlRk5xmPMH9usWfRcm9NLrNjsKTG4BrbBP/AFVol6UcEJ
 ZDPg==
X-Gm-Message-State: AOJu0YzzFEIzmNmsoaGfW3D52j8Jm/qnZvxxEghNVYYJBprAcH0ss9mA
 JmuXR+OJX3zA3Jut5wWAYumWzcPHK/qRsoR3D7+WO6jYbuYqARWWxHiTQRHu
X-Gm-Gg: ASbGncs01KkC6E5UVUFmX24r9spZ/ouSDKXISMFilWEs+BJ+TqhPUbwqBJfoeL7fEfz
 k05r/WwirKJZU3zVOKvhpTqDWUlQ6W/X7a/ODjHUEoNNH4CV7dZSTubi4qh0tVvkf2bTSNcBiO0
 +GsjhcoG4p5wDPPFWfNEPCmFBuM5sg3dX+rUfQLnl5k7OtlCiu7Kh50w5nJtBFZbnXbksQhD6Zd
 s1EmiZPUxiiytH6ILTP6nWLwDWWKFkz2VANSth/cTYvg75JP6oPHS5vANpkwGOHh/tGz3Y9G/Uo
 B20Ibr+KjStVl+Uzful9qC10vOqxy8E0D/vU6A2hvLm1Ocd0nEQQyLtUtAWXmf4d8TOd0IXXeFj
 wtDOB0emo8Qys20T6/VjozJzypBktQ86blODQ
X-Google-Smtp-Source: AGHT+IE+BgPfGNOX1TqTpaAyvLmMeOeh5pKQlMcQRyGNIdVruc7esVqj6LP6kME+lAzcxf0ih/CywA==
X-Received: by 2002:a05:6e02:2381:b0:3d8:1231:5ddf with SMTP id
 e9e14a558f8ab-3d812581264mr15848555ab.22.1744761346290; 
 Tue, 15 Apr 2025 16:55:46 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d7dba85249sm36412735ab.27.2025.04.15.16.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 16:55:45 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, quic_mathbern@quicinc.com,
 sidneym@quicinc.com, quic_mliebel@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH] Hexagon (target/hexagon) Remove gen_tcg_func_table.py
Date: Tue, 15 Apr 2025 17:55:42 -0600
Message-ID: <20250415235542.71703-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This can easily be done in C with opcodes_def_generated.h.inc

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/genptr.c              |  6 ++-
 target/hexagon/README                |  1 -
 target/hexagon/gen_tcg_func_table.py | 66 ----------------------------
 target/hexagon/meson.build           | 10 -----
 4 files changed, 5 insertions(+), 78 deletions(-)
 delete mode 100755 target/hexagon/gen_tcg_func_table.py

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 2c5e15cfcf..330170ab44 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -1453,4 +1453,8 @@ void gen_add_sat_i64(DisasContext *ctx, TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 }
 
 #include "tcg_funcs_generated.c.inc"
-#include "tcg_func_table_generated.c.inc"
+const SemanticInsn opcode_genptr[XX_LAST_OPCODE] = {
+#define OPCODE(X)    [X] = generate_##X
+#include "opcodes_def_generated.h.inc"
+#undef OPCODE
+};
diff --git a/target/hexagon/README b/target/hexagon/README
index ca617e3364..5af298e3ed 100644
--- a/target/hexagon/README
+++ b/target/hexagon/README
@@ -47,7 +47,6 @@ header files in <BUILD_DIR>/target/hexagon
         gen_op_attribs.py               -> op_attribs_generated.h.inc
         gen_helper_protos.py            -> helper_protos_generated.h.inc
         gen_tcg_funcs.py                -> tcg_funcs_generated.c.inc
-        gen_tcg_func_table.py           -> tcg_func_table_generated.c.inc
         gen_helper_funcs.py             -> helper_funcs_generated.c.inc
         gen_idef_parser_funcs.py        -> idef_parser_input.h
         gen_analyze_funcs.py            -> analyze_funcs_generated.c.inc
diff --git a/target/hexagon/gen_tcg_func_table.py b/target/hexagon/gen_tcg_func_table.py
deleted file mode 100755
index 299a39b1aa..0000000000
--- a/target/hexagon/gen_tcg_func_table.py
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/usr/bin/env python3
-
-##
-##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
-##
-##  This program is free software; you can redistribute it and/or modify
-##  it under the terms of the GNU General Public License as published by
-##  the Free Software Foundation; either version 2 of the License, or
-##  (at your option) any later version.
-##
-##  This program is distributed in the hope that it will be useful,
-##  but WITHOUT ANY WARRANTY; without even the implied warranty of
-##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-##  GNU General Public License for more details.
-##
-##  You should have received a copy of the GNU General Public License
-##  along with this program; if not, see <http://www.gnu.org/licenses/>.
-##
-
-import sys
-import re
-import string
-import hex_common
-import argparse
-
-
-def main():
-    parser = argparse.ArgumentParser(
-        "Emit opaque macro calls with instruction semantics"
-    )
-    parser.add_argument("semantics", help="semantics file")
-    parser.add_argument("out", help="output file")
-    args = parser.parse_args()
-    hex_common.read_semantics_file(args.semantics)
-    hex_common.calculate_attribs()
-    tagregs = hex_common.get_tagregs()
-    tagimms = hex_common.get_tagimms()
-
-    with open(args.out, "w") as f:
-        f.write("#ifndef HEXAGON_FUNC_TABLE_H\n")
-        f.write("#define HEXAGON_FUNC_TABLE_H\n\n")
-
-        f.write("const SemanticInsn opcode_genptr[XX_LAST_OPCODE] = {\n")
-        for tag in hex_common.tags:
-            ## Skip the priv instructions
-            if "A_PRIV" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the guest instructions
-            if "A_GUEST" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the diag instructions
-            if tag == "Y6_diag":
-                continue
-            if tag == "Y6_diag0":
-                continue
-            if tag == "Y6_diag1":
-                continue
-
-            f.write(f"    [{tag}] = generate_{tag},\n")
-        f.write("};\n\n")
-
-        f.write("#endif    /* HEXAGON_FUNC_TABLE_H */\n")
-
-
-if __name__ == "__main__":
-    main()
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index bb4ebaae81..b28aeddb85 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -41,20 +41,10 @@ hexagon_ss.add(semantics_generated)
 #
 # Step 2
 # We use Python scripts to generate the following files
-#     tcg_func_table_generated.c.inc
 #     printinsn_generated.h.inc
 #     op_attribs_generated.h.inc
 #     opcodes_def_generated.h.inc
 #
-tcg_func_table_generated = custom_target(
-    'tcg_func_table_generated.c.inc',
-    output: 'tcg_func_table_generated.c.inc',
-    depends: [semantics_generated],
-    depend_files: [hex_common_py],
-    command: [python, files('gen_tcg_func_table.py'), semantics_generated, '@OUTPUT@'],
-)
-hexagon_ss.add(tcg_func_table_generated)
-
 printinsn_generated = custom_target(
     'printinsn_generated.h.inc',
     output: 'printinsn_generated.h.inc',
-- 
2.43.0


