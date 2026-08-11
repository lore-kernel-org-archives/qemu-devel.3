Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DFFC5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtd4A-0005BR-6j; Mon, 10 Aug 2026 23:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wtd48-0005As-8H
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 23:22:12 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wtd46-0006xy-BB
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 23:22:12 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7eb68bdf53aso1001494a34.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 20:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786418529; x=1787023329; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T020/4BbYswuHkzh+5ntHAVJ23VTFJkz44aKre+VgcU=;
 b=nOwA2hu4c7GO4ITIhVKZQfd7/3gNe3lo+HuhuKjsKV48Bbe1IV/oYxllAVbImGpc5O
 zx9KtDRhWmNb0tfX0VCzE5L2hOeWxczqYepgzaX2vMHI29VgU1E5kAoFtQh99fR/1fAB
 bjGzZZYODK+zqcB+ahEVWHEkOfKQeItpBbMkfE5lVccdoAnVnwNDanCeamvZGPZBLbhz
 RuxGFxYa5ieUOSqK71IkG9mWl4eikZ/V58/mrtBVrHojiZlMBRLcejSm1+mw3fI8O+0l
 cdTTVHG17qpVWgjADkI+UnR94Ow9r/KWpYwOAoXj9AvFRn6nr+a03L2QxREq7DJ7uYgj
 +ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786418529; x=1787023329;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T020/4BbYswuHkzh+5ntHAVJ23VTFJkz44aKre+VgcU=;
 b=X01RVZMvUUEqVkqULFATXaQqqRdwxZgtilY3FWrSctPEM5tXt920u8v/QavXp++0RJ
 s8kOvNTMT3iZNZsZgJ1sEVeYWHuTMYW/r/6YZpdL4jpYrqENZIbN2102v751c8YEapan
 s16MitWyuGDQtYfPBiGSvgfcseVyI+flKV3U4Z6AoH4JT5FDYgGIv6ihYVock9pAOmDV
 k47M4e2m6l3cm5aHedN3ran7iRFildIJfOKt73DHRWjZQlwqj6Z/xRTG+g9qwzb/fIwH
 PrHGWR3nDJnXd0FBMSY9O6yKmj0T5TGeFERZjPY/QESQNuo36p9fGiunPeVPb7vQmxJ9
 hbQw==
X-Gm-Message-State: AOJu0YyiFqBCRZngaVgecZz4woT1htuiB8L6uAZ/3eiYsmeUrKTXlwPS
 5xgSCU67zQtFGU2myYpNlo7fFtmUY3EOEO+yJyPDF/V9f7KQbW8/UbWYoWtFrWT1
X-Gm-Gg: AR+sD13QvTLLJhSPPXb8G9gJix2ypV4N+uEUvDgEaOWsgK3ACsBsVxdKhuT1Kwx8GY6
 3yhpYOlHRngRRFXaxDkRo9gUu5sKUPIj0FXRjZqJ3mfTbULQ3bkhNExVVhpnjZbP24DX3vzGgYa
 Hre13R4cMmuwcBj19B9XWzKDf9MqPcp6mt6VOZJy1dJzmaTIJi//skLVg333h6hoAyUxzXLycQ5
 lj2MUdmUqTpt1rE3jxmlO/r9PfGhvFM5pv3gl3Hv9KoeUg/7Nm/FDie3j6T2C+VNhQL4SXaUFFV
 Bm0ZxiaUiDkBvmZQKcH22sIq6K8w3orHV0wj7aApxHOHIN+G4ykWqC4NQQJIlXMI/czjA+FWTWK
 Gl+u0K7MJB+8beYzby+ISBJf4NJDJMGfDOOLZYdgdojr7qXPhEHeF8BB0NRWUbp0R0iw0c8dUAt
 rZ6t6tQLrvHkgkhGfdtV1Mpm8T2bJJDTCuQUoY8GK45HzebalEUolcL5s/6sBWcJjodJpufa+Ab
 2BUyXtRBAfsutM5Rh7SHaZvktl6qf1Q+vtINTkbkvy4y3KRX3sOiEq82kx98i0/
X-Received: by 2002:a05:6820:1885:b0:6a3:d77e:725a with SMTP id
 006d021491bc7-6b0a31af8b3mr11651eaf.20.1786418528753; 
 Mon, 10 Aug 2026 20:22:08 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b09fe54244sm329354eaf.11.2026.08.10.20.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 20:22:07 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2] Hexagon (target/hexagon) Clean up disassembly of control
 and system regs
Date: Mon, 10 Aug 2026 21:22:06 -0600
Message-ID: <20260811032206.58501-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32c.google.com
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

Change disassembly of control regs from C{num}/{name} to {name}
Change disassembly of system regs from S{num}/r{num} to {name}

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/printinsn.c      | 99 +++++++++++++++++++++++++++++++--
 target/hexagon/gen_printinsn.py | 14 +++--
 2 files changed, 101 insertions(+), 12 deletions(-)

diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
index a7e46f4bcd..1673e95421 100644
--- a/target/hexagon/printinsn.c
+++ b/target/hexagon/printinsn.c
@@ -23,18 +23,105 @@
 #include "internal.h"
 #include "decode.h"
 
-static const char *sreg2str(unsigned int reg)
+/*
+ * Used when there is some sort of error and we can't figure out the real
+ * system register name
+ */
+static const char *const generic_sreg_names[256] = {
+    "S000", "S001", "S002", "S003", "S004", "S005", "S006", "S007",
+    "S008", "S009", "S010", "S011", "S012", "S013", "S014", "S015",
+    "S016", "S017", "S018", "S019", "S020", "S021", "S022", "S023",
+    "S024", "S025", "S026", "S027", "S028", "S029", "S030", "S031",
+    "S032", "S033", "S034", "S035", "S036", "S037", "S038", "S039",
+    "S040", "S041", "S042", "S043", "S044", "S045", "S046", "S047",
+    "S048", "S049", "S050", "S051", "S052", "S053", "S054", "S055",
+    "S056", "S057", "S058", "S059", "S060", "S061", "S062", "S063",
+    "S064", "S065", "S066", "S067", "S068", "S069", "S070", "S071",
+    "S072", "S073", "S074", "S075", "S076", "S077", "S078", "S079",
+    "S080", "S081", "S082", "S083", "S084", "S085", "S086", "S087",
+    "S088", "S089", "S090", "S091", "S092", "S093", "S094", "S095",
+    "S096", "S097", "S098", "S099", "S100", "S101", "S102", "S103",
+    "S104", "S105", "S106", "S107", "S108", "S109", "S110", "S111",
+    "S112", "S113", "S114", "S115", "S116", "S117", "S118", "S119",
+    "S120", "S121", "S122", "S123", "S124", "S125", "S126", "S127",
+    "S128", "S129", "S130", "S131", "S132", "S133", "S134", "S135",
+    "S136", "S137", "S138", "S139", "S140", "S141", "S142", "S143",
+    "S144", "S145", "S146", "S147", "S148", "S149", "S150", "S151",
+    "S152", "S153", "S154", "S155", "S156", "S157", "S158", "S159",
+    "S160", "S161", "S162", "S163", "S164", "S165", "S166", "S167",
+    "S168", "S169", "S170", "S171", "S172", "S173", "S174", "S175",
+    "S176", "S177", "S178", "S179", "S180", "S181", "S182", "S183",
+    "S184", "S185", "S186", "S187", "S188", "S189", "S190", "S191",
+    "S192", "S193", "S194", "S195", "S196", "S197", "S198", "S199",
+    "S200", "S201", "S202", "S203", "S204", "S205", "S206", "S207",
+    "S208", "S209", "S210", "S211", "S212", "S213", "S214", "S215",
+    "S216", "S217", "S218", "S219", "S220", "S221", "S222", "S223",
+    "S224", "S225", "S226", "S227", "S228", "S229", "S230", "S231",
+    "S232", "S233", "S234", "S235", "S236", "S237", "S238", "S239",
+    "S240", "S241", "S242", "S243", "S244", "S245", "S246", "S247",
+    "S248", "S249", "S250", "S251", "S252", "S253", "S254", "S255",
+};
+
+static const char *sreg2str(uint8_t reg)
 {
-    if (reg < TOTAL_PER_THREAD_REGS) {
-        return hexagon_regnames[reg];
+#ifndef CONFIG_USER_ONLY
+    if (reg < NUM_SREGS) {
+        return hexagon_sregnames[reg];
     } else {
-        return "???";
+        return generic_sreg_names[reg];
     }
+#else
+    return generic_sreg_names[reg];
+#endif
 }
 
-static const char *creg2str(unsigned int reg)
+/*
+ * Used when there is some sort of error and we can't figure out the real
+ * control register name
+ */
+static const char *const generic_creg_names[256] = {
+    "C000", "C001", "C002", "C003", "C004", "C005", "C006", "C007",
+    "C008", "C009", "C010", "C011", "C012", "C013", "C014", "C015",
+    "C016", "C017", "C018", "C019", "C020", "C021", "C022", "C023",
+    "C024", "C025", "C026", "C027", "C028", "C029", "C030", "C031",
+    "C032", "C033", "C034", "C035", "C036", "C037", "C038", "C039",
+    "C040", "C041", "C042", "C043", "C044", "C045", "C046", "C047",
+    "C048", "C049", "C050", "C051", "C052", "C053", "C054", "C055",
+    "C056", "C057", "C058", "C059", "C060", "C061", "C062", "C063",
+    "C064", "C065", "C066", "C067", "C068", "C069", "C070", "C071",
+    "C072", "C073", "C074", "C075", "C076", "C077", "C078", "C079",
+    "C080", "C081", "C082", "C083", "C084", "C085", "C086", "C087",
+    "C088", "C089", "C090", "C091", "C092", "C093", "C094", "C095",
+    "C096", "C097", "C098", "C099", "C100", "C101", "C102", "C103",
+    "C104", "C105", "C106", "C107", "C108", "C109", "C110", "C111",
+    "C112", "C113", "C114", "C115", "C116", "C117", "C118", "C119",
+    "C120", "C121", "C122", "C123", "C124", "C125", "C126", "C127",
+    "C128", "C129", "C130", "C131", "C132", "C133", "C134", "C135",
+    "C136", "C137", "C138", "C139", "C140", "C141", "C142", "C143",
+    "C144", "C145", "C146", "C147", "C148", "C149", "C150", "C151",
+    "C152", "C153", "C154", "C155", "C156", "C157", "C158", "C159",
+    "C160", "C161", "C162", "C163", "C164", "C165", "C166", "C167",
+    "C168", "C169", "C170", "C171", "C172", "C173", "C174", "C175",
+    "C176", "C177", "C178", "C179", "C180", "C181", "C182", "C183",
+    "C184", "C185", "C186", "C187", "C188", "C189", "C190", "C191",
+    "C192", "C193", "C194", "C195", "C196", "C197", "C198", "C199",
+    "C200", "C201", "C202", "C203", "C204", "C205", "C206", "C207",
+    "C208", "C209", "C210", "C211", "C212", "C213", "C214", "C215",
+    "C216", "C217", "C218", "C219", "C220", "C221", "C222", "C223",
+    "C224", "C225", "C226", "C227", "C228", "C229", "C230", "C231",
+    "C232", "C233", "C234", "C235", "C236", "C237", "C238", "C239",
+    "C240", "C241", "C242", "C243", "C244", "C245", "C246", "C247",
+    "C248", "C249", "C250", "C251", "C252", "C253", "C254", "C255",
+};
+
+static const char *creg2str(uint8_t reg)
 {
-    return sreg2str(reg + HEX_REG_SA0);
+    uint8_t gpr = reg + HEX_REG_SA0;
+    if (gpr < TOTAL_PER_THREAD_REGS) {
+        return hexagon_regnames[gpr];
+    } else {
+        return generic_creg_names[reg];
+    }
 }
 
 static void snprintinsn(GString *buf, Insn *insn)
diff --git a/target/hexagon/gen_printinsn.py b/target/hexagon/gen_printinsn.py
index d5f969960a..cf1a12adbc 100755
--- a/target/hexagon/gen_printinsn.py
+++ b/target/hexagon/gen_printinsn.py
@@ -28,13 +28,14 @@
 ##     Generate data for printing each instruction (format string + operands)
 ##
 def regprinter(m):
-    str = m.group(1)
-    str += ":".join(["%d"] * len(m.group(2)))
-    str += m.group(3)
     if ("S" in m.group(1)) and (len(m.group(2)) == 1):
-        str += "/%s"
+        str = "%s"
     elif ("C" in m.group(1)) and (len(m.group(2)) == 1):
-        str += "/%s"
+        str = "%s"
+    else:
+        str = m.group(1)
+        str += ":".join(["%d"] * len(m.group(2)))
+        str += m.group(3)
     return str
 
 
@@ -142,11 +143,12 @@ def main():
                     else:
                         regno = ri
                     if len(b) == 1:
-                        f.write(f", insn->regno[{regno}]")
                         if "S" in a:
                             f.write(f", sreg2str(insn->regno[{regno}])")
                         elif "C" in a:
                             f.write(f", creg2str(insn->regno[{regno}])")
+                        else:
+                            f.write(f", insn->regno[{regno}]")
                     elif len(b) == 2:
                         f.write(f", insn->regno[{regno}] + 1" f", insn->regno[{regno}]")
                     else:
-- 
2.43.0


