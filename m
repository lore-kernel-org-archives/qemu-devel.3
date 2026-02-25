Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3ECFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO9O-0004vW-8A; Wed, 25 Feb 2026 18:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9M-0004po-GT
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:36 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9K-0003CH-QG
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:36 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43992e3f9b8so210144f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061512; x=1772666312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AkKI2RdGaiNs8TMm8UyYiEPvcsxkUPXWk89sTv3xAII=;
 b=Xb+SLGs64q3Y0+o5ZBh1dPcNvXkWScTDaoQxplnEFB8e3X9j/I10aKqpAWnBZYDsGD
 FA/ccVbrCC+b6NKQkZI/HvJkprmUwOUM0Cyw2hyYlE0s1lRieP4oKnGklMr5bbah2Dfp
 azyNoF7o8StcvibPHwy9WNhyjrc0GKThBi2lVd/NMGdFG8CfBXlYeE96iF9EbwXINvxm
 4UL6nyDcx0esq/d+B20SXa0p9apRUFg9IZhxJUkGHSeMnPYTqAXncEOmK51wtG3nCbXz
 cFI2KBaO+AYNS6NTWYrm4q+7C/lyIccTYfhf1xSPL4ApNkHamhIevqQ683B5c5FZOaWb
 RlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061512; x=1772666312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AkKI2RdGaiNs8TMm8UyYiEPvcsxkUPXWk89sTv3xAII=;
 b=a2pmIpCun1Nmfo4Efk/UN1GBmaNLeSkTRyMQoLl5/3G57dJx+o3p/oEkCqFOAjkPZx
 1LHrcS74FVTMtnakeNhgKAFiUvJzW2E9FqXQj5Cji5iZtAFjmdhslnYU+Du8OmADQBPZ
 WyyCi7zYapbDIlKg4HrV9dpd91TphYRIJ1dvuZumwLXWgtJvDrPhTg/TNO/TG3xwPsPP
 HcMUzY5nWX0Fz/rMLigxy7i710F3Kn1Z10WzZr36FF4/Fu/CJCkFRd+IEyIptmLt+dVP
 X7K1CrBEKTAKwvg4u2OgsdAs4O1s7OVO9/SuXxQrPA98bTJ4To7F+LmnEcn/kMof2UON
 l9zw==
X-Gm-Message-State: AOJu0YweRt+rwTpMXQhzo5K0KdImjx/bzKtnd0JguiBMUJpQOvFmLZy3
 phIJkwoPBXg48FsOjEBkYD/sSrzp+6tu/jgg2/sQo/KVn3YySQsZDBRxODh3oyUcSQtoBrZ+0EA
 G6qKqkmQ=
X-Gm-Gg: ATEYQzweOcUDeyNMho8VwUpbi7LaySjnvYpMIFngdYwgosRb7RVMzYRHqhpvNqZ3Frj
 AsAM08dktCp+L0gFFINF8Jhq88bNXESraerGynIAZ7WQIiWDavHjndXRsmsU4/4mUEn5IfYqmex
 6IKcBUtdF3iWc5/iMSnNbD29djpqWgoHNgYk5TljSDacOnmtlpddDgsv/Eq5yNEUez0jM4xcXhE
 LatMZ09oFpN+POhNu9suLTb5WaeYaMzkYwOQfJ3vfd7YBxdYtWpr59tuA86O5hG7LvKTICbk4Ve
 npuSdZMIPZWC5Hh2mUL4ca+RlR+w/L/yMc1YZFRPEYQGd01eaadX7jnaS0V3Bgg6aCOYQeSVAWF
 yk2Nf8jDbrkW0L9dZM/zmU/vBAE9yRRNrioe+rajcJuJfnSLSpoIxwZQAA5LWSa7uYbYpPj+d+c
 vUvcHvKbGeICUUVc4j/N+HCU2cfirba0IpXjPbin2LEnuulDRcF04Au9ZUwhALb6H5QrFF0EEQ
X-Received: by 2002:a05:6000:2511:b0:435:e440:f518 with SMTP id
 ffacd0b85a97d-439942fddd2mr4240829f8f.54.1772061512031; 
 Wed, 25 Feb 2026 15:18:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c00768sm35497765f8f.10.2026.02.25.15.18.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:18:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/70] target/i386: Expand 64-bit definitions when
 TARGET_LONG_BITS == 64
Date: Thu, 26 Feb 2026 00:13:38 +0100
Message-ID: <20260225231411.96482-39-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Where both gdb_read/write_register() functions check for
'TARGET_LONG_BITS == 64' we can expand the following definitions:

  ldtul_p() -> ldq_p()

  gdb_get_regl() -> gdb_get_reg64()

Do the same in i386_cpu_gdb_get_egprs(): check TARGET_LONG_BITS to
effectively inline gdb_get_regl().

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-31-philmd@linaro.org>
---
 target/i386/gdbstub.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f358bcf9e86..f1ce90a046e 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -129,7 +129,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
                 return gdb_get_reg64(mem_buf,
                                      env->regs[gpr_map[n]] & 0xffffffffUL);
             } else {
-                return gdb_get_regl(mem_buf, 0);
+                return gdb_get_reg64(mem_buf, 0);
             }
         } else {
             return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
@@ -283,9 +283,9 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < CPU_NB_REGS) {
         if (TARGET_LONG_BITS == 64) {
             if (env->hflags & HF_CS64_MASK) {
-                env->regs[gpr_map[n]] = ldtul_p(mem_buf);
+                env->regs[gpr_map[n]] = ldq_p(mem_buf);
             } else if (n < CPU_NB_REGS32) {
-                env->regs[gpr_map[n]] = ldtul_p(mem_buf) & 0xffffffffUL;
+                env->regs[gpr_map[n]] = ldq_p(mem_buf) & 0xffffffffUL;
             }
             return sizeof(target_ulong);
         } else if (n < CPU_NB_REGS32) {
@@ -449,8 +449,10 @@ static int i386_cpu_gdb_get_egprs(CPUState *cs, GByteArray *mem_buf, int n)
         /* EGPRs can be only directly accessible in 64-bit mode. */
         if (env->hflags & HF_CS64_MASK) {
             return gdb_get_reg64(mem_buf, env->regs[gpr_map[n + CPU_NB_REGS]]);
+        } else if (TARGET_LONG_BITS == 64) {
+            return gdb_get_reg64(mem_buf, 0);
         } else {
-            return gdb_get_regl(mem_buf, 0);
+            return gdb_get_reg32(mem_buf, 0);
         }
     }
 
-- 
2.52.0


