Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5352BE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1MZ-0007Av-CX; Thu, 19 Feb 2026 05:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MO-00074F-Sc
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:18 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MJ-00062I-CM
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:14 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4837907f535so6932725e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497249; x=1772102049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ke4c6OiHVAc47JjS0Vki7YyrrpZ38dBDsvhKeDXkXZ0=;
 b=fodhfn9gks9LAbyCwIm2XGh3nG0HQmwnx1iBoafbTUOcpeP6qNkCr4qjM7tBnCVxQ4
 NtWv9caI9XSfP/o6vC24+cSC/1VGnwnCpoVaRSYLqobMm9Wg/3VVhbp/aEi4bmcXIFCB
 jHiqHNdLO4IWmJEkc8bNQ/FbayxuzcQYArH4FiR+ww8gQ3/UutlHhocmDakB7Yol9RQ2
 GyJG7dUKtPlF28BjdiktWUu62TBFGUifQq0KFaGVcoRrJe6UU6uyR45ESB5n2LhM4GFh
 cuWkIXJh3YQ5l8tu5FWNiYieVnMauZCzydMVsDFY3aG7331OETi8FHidhdREsQuAEg0M
 VaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497249; x=1772102049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ke4c6OiHVAc47JjS0Vki7YyrrpZ38dBDsvhKeDXkXZ0=;
 b=QfABIGBUY3X1tx0436518QuG04WZMmAL8Z2nFV7ilx0pNEepauQOPQDBNvEtXb7k9F
 dUXnlpS8rSL8hu8iBtC9LwLig4JXKmyNyU50TXpMjWPk/Ft+m3qjb5VfA5nGz0akBcyX
 cPqNBwVT/n9uyXmDW0FXmepDAuiBlhOaBvileBkhSy7OLq+ZIcgcd7mJX1azkf8aHynY
 cEauMbm0W7b2/xl54ps6uloLxLJL+DcT710PT85sk5zBeNUn+atUc5jdOuXuDn6GWXQA
 CR3146rMrq5Ky9MPgaXtNKsS3L3fbfGr3mOXtdF05icn/bFAmSumQ85HQb0Ey8TIJlTu
 uIEA==
X-Gm-Message-State: AOJu0YxiIrKhYpjklZ5KIeC5nekMB0x0kn+JjMpMq8iGUrehvHkzb0MM
 VgXH3Q/Dp9fsMX+QlFIE0YxmZLnGnmd9qFL201uw07Ok5SLMW4ZZdFmlw0j7eqZnBp1t7s4itye
 SNN7v
X-Gm-Gg: AZuq6aKobPyLlYWCfz+wG8BNWu2LoXXAk4+Dh+OUSdBImVo9Cr13FuyoxKdKHa0tjMh
 LdlBjuogZneMKKMwpsOmA/w3wJPf5U7Uo/uEBx+RlyC+BqlpE2GA07OxOiSDjrhfzL0+/ZU8Rr1
 4Awv+SEf5bPSc8O4gAC4Ajt48cM+aXO6hwVZspA5JFyXJ9/sOlgEteLbJXDqWiRetqL53jhaBf+
 HU/cJBl7xMA9BHkl3eyQrebCkNd6L0u9fQ7nTWuH41IvBWbZ4vPfD/ghXhxy6AFDQXtcUssTCcW
 kJ8q427wbM93HaZ1LSUq9uYxO+WrjjwVmiwJe+BYhdZR8EBILl/J5aj8alo9ci8o1uqtMwdhDxZ
 NHCblrsFm5F1zFHa7cjGzcSs9PTZl4uGcG03NUnhNYxQ7GZqwrifhc0OQCoDxFx/u4O3g/OfdLA
 oUDlnTsOJnXCSQTT+dOsMKUMZ/P1Jzf/HI/xhu++CHq15gHSh+nJV2AQkt4PmwhHOKhrZaHJCRB
 29TK342D1n9doCn/QgD1a/RKEYR0lI=
X-Received: by 2002:a05:600c:8b82:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-48379b8bff1mr259831845e9.6.1771497249436; 
 Thu, 19 Feb 2026 02:34:09 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/32] target/arm: Report correct vector width in gdbstub when
 SME present
Date: Thu, 19 Feb 2026 10:33:35 +0000
Message-ID: <20260219103405.3793357-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Our gdbstub implementation of the org.gnu.gdb.aarch64.sve feature
doesn't account for SME correctly.  We always report the Zn vector
registers with a width based on the maximum SVE vector register size,
even though SME's maximum size could be larger.

This is particularly bad in the case of a CPU with SME but not SVE,
because there the SVE vector width will be zero.  If we report the Zn
registers in the XML as having a zero width then gdb falls over with
an internal error:

 (gdb) target remote :1234
 Remote debugging using :1234
 /build/gdb-1WjiBe/gdb-15.0.50.20240403/gdb/aarch64-tdep.c:3066: internal-error: aarch64_pseudo_register_type: bad register number 160
 A problem internal to GDB has been detected,
 further debugging may prove unreliable.

Report the Zn registers with their correct size.  This matches how we
already handle the 'vg' pseudoregister in org.gnu.gdb.aarch64.sve: we
call sve_vqm1_for_el(), which returns the vector size accounting for
SME, not the pure SVE vector size.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260202133353.2231685-3-peter.maydell@linaro.org
---
 target/arm/gdbstub64.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index c584e5b4e6..b71666c3a1 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -158,7 +158,7 @@ int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg)
     case 0 ... 31:
     {
         int vq, len = 0;
-        for (vq = 0; vq < cpu->sve_max_vq; vq++) {
+        for (vq = 0; vq < arm_max_vq(cpu); vq++) {
             len += gdb_get_reg128(buf,
                                   env->vfp.zregs[reg].d[vq * 2 + 1],
                                   env->vfp.zregs[reg].d[vq * 2]);
@@ -174,7 +174,7 @@ int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg)
     {
         int preg = reg - 34;
         int vq, len = 0;
-        for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
+        for (vq = 0; vq < arm_max_vq(cpu); vq = vq + 4) {
             len += gdb_get_reg64(buf, env->vfp.pregs[preg].p[vq / 4]);
         }
         return len;
@@ -208,7 +208,7 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
     case 0 ... 31:
     {
         int vq, len = 0;
-        for (vq = 0; vq < cpu->sve_max_vq; vq++) {
+        for (vq = 0; vq < arm_max_vq(cpu); vq++) {
             if (target_big_endian()) {
                 env->vfp.zregs[reg].d[vq * 2 + 1] = ldq_p(buf);
                 buf += 8;
@@ -233,7 +233,7 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
     {
         int preg = reg - 34;
         int vq, len = 0;
-        for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
+        for (vq = 0; vq < arm_max_vq(cpu); vq = vq + 4) {
             env->vfp.pregs[preg].p[vq / 4] = ldq_p(buf);
             buf += 8;
             len += 8;
@@ -540,8 +540,8 @@ static void output_vector_union_type(GDBFeatureBuilder *builder, int reg_width,
 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-    int reg_width = cpu->sve_max_vq * 128;
-    int pred_width = cpu->sve_max_vq * 16;
+    int reg_width = arm_max_vq(cpu) * 128;
+    int pred_width = arm_max_vq(cpu) * 16;
     GDBFeatureBuilder builder;
     char *name;
     int reg = 0;
-- 
2.43.0


