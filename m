Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E512E7316F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu42-0006kt-DX; Mon, 02 Feb 2026 08:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu40-0006jg-RY
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:00 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu3y-0002ZL-Vk
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:00 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso45950815e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039237; x=1770644037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSrmdhiUgq2SNEfimuA2mrbtB8VoeGQdLMz68iV2+VQ=;
 b=YqjDcM6MEN5XV7FegGG35KqWyUw3dNcH9h/yJufnGykwqTUFRLjb9MA3KOsH5b+nkb
 7U9XOzFaresRclIRLsZgHjSKm07fcQWSNERxzJRil1BFUaYj14utwQljV4IVxfhmRgw8
 nSLiNCvA2jCc9mqcrsdU0rGy/02RiK7WcFE1sUzvEYwK3qSf88AnM9yUXkt+u2SzwAs3
 7foQxTF6FIA842E8xjDPL/WkL7kYgNJ+yLCcmpQ6t1miEFOZRSQC7BAjSAJsIVKH7dQK
 j/jSgL6mMzVJtCisgMUQynQw7yS6ZqPtUFysTR12CLfWjBKtdI0MbZecGiktGIpaj1RP
 f/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039237; x=1770644037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZSrmdhiUgq2SNEfimuA2mrbtB8VoeGQdLMz68iV2+VQ=;
 b=tRqtr/n4Ag5A38W/EC1c9SnhFFeIn6wWxouEs3u3XpDouhLIAa6gr0o2R46x+cv2tO
 CSoZmNv3VsecCPw3JJAyQkA961tMVD1AG5fEiqiS54F+Qyup5fBVZpPaDNcXRk0NlEk3
 bGlbOJr/hWbhQGRRCcNyC/Lf+6vcNRQ5NKt2hy4DJZVuhGHmJidM1ixdQnasvx97LoSV
 ajNp6SgEJTjfVbqb83lR0r3Se+lMNLmeubo13HrIDCkZm5gTfwd3p9tubP6S9E5VrvfO
 Bk40TCvrDF1wjki5jQHUa/TuAACRP4/IyWxwlu44aOP1c9yYMwzcfws/o9s9FX4YaPDw
 cfwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaVfUCt5KvDVB9fLHRgFGYd39Fs2Du79QrFr7I1jB1GcpFm9RZOhYKsqQ/0U78j6IseB0Zes/ikMMA@nongnu.org
X-Gm-Message-State: AOJu0YzuXvlMgWAJLHlWkKtrJf0UtwshL7b/AcxGmq3+0+CFWiXiicru
 1fKCJiKxAkwV0qgxCo3mqfS2w5lJm+qqZjMEe+vbcDAzz4eZwMUJWT5fPqU8a2X909sWW526x5P
 wGCpd
X-Gm-Gg: AZuq6aLgygDTBIJiEplrhwG9gIn2lBqB3Bq136ihzEyuhhsJyaReV3lyt8KLNa1ZLWj
 9Ft55UrLn5+/JMaxcE1Ymxnmkjxv9Nqh7UcC7B3cAwigm9ClYOUIzfvjxr29mMWttBHJuBTJjOI
 8oycVSyw/FcKgYNvY7eoCZuxS/Dzeufrx/ge6msD1QnHy6VQ1DjzMtzuI5MLzYRGLO/8feaLpSo
 bHxm4mUNnxRKCzjmjBNn25i70d87rUhSv1XgpSKvRkwx/P06Z/o1ZKG5u4fsYNF0zzlHAfNBw1r
 q9Gl3I8TrYcPF2AHhCyNHRzfba2T2a9TWnHpHjeWDMf8WD1vkFhYBf1wcN4IdeK4d9XS7VnWjj1
 th9BLbWk4pcYgx1ZxJwp7q8ByWstAegH7pivHuNp2jZMV+GmOiknjDMpfdnK1mkmVtBW+FB7p4C
 XB9YKYUvi33TWAray/nwpfaeSnynCQScgp2WduVmzS
X-Received: by 2002:a05:600c:4e87:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-482db46557cmr165258385e9.12.1770039237462; 
 Mon, 02 Feb 2026 05:33:57 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:33:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 02/15] target/arm: Report correct vector width in gdbstub
 when SME present
Date: Mon,  2 Feb 2026 13:33:40 +0000
Message-ID: <20260202133353.2231685-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
We should make sure we have agreement on the gdb side about
the interpretation of this bit of the protocol. See this
gdb mailing list email:
https://sourceware.org/pipermail/gdb/2026-January/052056.html
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


