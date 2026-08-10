Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07EAC5B567
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUjM-0002TE-M7; Mon, 10 Aug 2026 14:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wtUjK-0002So-Du
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:28:10 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wtUjI-0004t9-Ri
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:28:10 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7eb64085c45so1720659a34.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786386487; x=1786991287; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AArSlpMEx7PTV4ljpysbtb5KP7i/TypfKuE4/wW+iTM=;
 b=H9Gmz8T6tiW8cN4wDUS7JUwKCus0S8nCfYjKgztutyYk7GS3I1nXIepuJkVlWHXtla
 FtrH2A2R+vNYf7wOD8X2t98tLdGK77MISjm8r5r4qyWgzCzGqCiFp7ySynDwCZg/TC0M
 2kz8pWKyY8XH7cJax4hPDsgi1muRQhpCfQ2G+fQr1LTAPz5zO/nJNUtR2DuICu8pGHs9
 vmgWgbjGhmI2RuxwQD5ywUrgXNBn13n1+KlwtFacNGCdF9un/cEU62DWbbhIwB8oovpm
 rfnsbL1+j59lvT4bV/zQhnoPTizCe7ilT5zljK++P4stQ2MoLWXpCxG11XuQ20svuLn3
 fP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786386487; x=1786991287;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AArSlpMEx7PTV4ljpysbtb5KP7i/TypfKuE4/wW+iTM=;
 b=RgaYSd6jZrX36eLvo1NfkWYeFXY1FDX/D33clNxJFQPIzAAom+CfzMEhg/Bb3vAm5M
 z/bxWElreSxx1yLJiciq/lHtcbkHWiRiuud48l5i6Gw4SG767+sms9J2yX4G0LGrRPEL
 TPm1MC+InLbDBsV7GB1IuS1//FzVfbb8+UBtMpI84p2ldiOCKOsW4X3oZShD2Pd65Iyr
 /g05ncDhq6zb/usm2EmRrPsOwe7b6x9lEgE/avKBWq8VZyZ0CUhJC7QNwk8zkQ2F++iv
 QyQOtVWWqDusSke5zan4LbwqRhPKo5pQGJRjJn60mladI0PfmIDTxAI8rW+92xp/rBCa
 8zJw==
X-Gm-Message-State: AOJu0Yzs1tBru02WcD7TbfA/dYYmDkQ7ov8f+AfLKlG1j6yh5+F6mVv/
 MV39NkvJvsx7e1Ap40Lo0upjM/6aQrAHLBci65dNNKHzj/MWxEeVhkV8qQdHDTQF
X-Gm-Gg: AR+sD10hMpX6djy6BwZC7S0Vo6QEldKZolr1Fzh5FIbAf4YMVrmZXrVvvVdtR5UHz7W
 0Y80i0abYrr0CR9U6IRKz7lv2+3QcYvW+EgL1grycRaIBiRj8kDTPgoMJ249D5L6XaYeKxrRv1J
 Y/BrpfI4ikZjrk8VMIodVdcC/rFeIR1jyaRb+pZPeElkduuVaBP0Rl4WexzP9efcw3tzpyIbMyC
 xlXdXoZlYqsL1dwFdMlA2aY+ZrxXHr9Bdla7RKacDxLFAfVU1MllRjEN/F+EQnHULtvLql6Zm94
 nzu/NSJNzSZQArEm1fLrj2MITpES7+R05TI/8GtkwiBIqVkE/mgFSWGihgXhbFKnsH3HIqqAN8E
 tPpFrxwDEJEkze0Ksx9bJ1O4cbx+U0QijUm+MUFXzLVQwNFJXaX+qUUP22Wy38r5shJUehB7vKR
 47A/Cr8Hh3xNlGFf8JCczI558sfTVAOpXUMB6hjL8BfKRG5e8Pqx3U/IhwoK3FCXShgnHLvGVRS
 wQAyyYIqzC+bqeg3p7aEGzZy1jhKgJczV7vcShmQ/ntOUDQ0fCSff4sHfKudqmhqQ==
X-Received: by 2002:a05:6830:67e4:b0:7e9:cce4:803b with SMTP id
 46e09a7af769-7f3691ebc7amr13752025a34.8.1786386487027; 
 Mon, 10 Aug 2026 11:28:07 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b5a6b72sm7757097a34.9.2026.08.10.11.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 11:28:05 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH] Hexagon (target/hexagon) Clean up disassembly of control and
 system regs
Date: Mon, 10 Aug 2026 12:28:04 -0600
Message-ID: <20260810182804.27310-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x331.google.com
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
 target/hexagon/printinsn.c      | 22 ++++++++++++++++++----
 target/hexagon/gen_printinsn.py | 14 ++++++++------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
index a7e46f4bcd..b55d3b0b35 100644
--- a/target/hexagon/printinsn.c
+++ b/target/hexagon/printinsn.c
@@ -23,18 +23,32 @@
 #include "internal.h"
 #include "decode.h"
 
+static char regstr[10];
+
 static const char *sreg2str(unsigned int reg)
 {
-    if (reg < TOTAL_PER_THREAD_REGS) {
-        return hexagon_regnames[reg];
+#ifndef CONFIG_USER_ONLY
+    if (reg < NUM_SREGS) {
+        return hexagon_sregnames[reg];
     } else {
-        return "???";
+        snprintf(regstr, sizeof(regstr), "S%d", reg);
+        return regstr;
     }
+#else
+    snprintf(regstr, sizeof(regstr), "S%d", reg);
+    return regstr;
+#endif
 }
 
 static const char *creg2str(unsigned int reg)
 {
-    return sreg2str(reg + HEX_REG_SA0);
+    unsigned int gpr = reg + HEX_REG_SA0;
+    if (gpr < TOTAL_PER_THREAD_REGS) {
+        return hexagon_regnames[gpr];
+    } else {
+        snprintf(regstr, sizeof(regstr), "C%d", reg);
+        return regstr;
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


