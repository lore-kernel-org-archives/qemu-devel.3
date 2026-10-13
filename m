Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97255CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3k-0007rP-SB; Tue, 13 Oct 2026 04:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3V-0007LK-V4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:18 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3T-0007sH-3z
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1543845f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880814; x=1792485614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rsG3TCscVd7PYoqyQA/dMMFq21JiQcdL/3Au5s6HFt4=;
 b=gkuYDE/x+uxQlelbg+HsK0UVNrhrhXPgGLajX387YT3QA2dagnAQSuqrH1AAuz3xEG
 jBx9JN0Pbonw9E+peFB1NVXFgTkVU5Z3iPp9Q7DPX5kTirVMpN9o1hMZ9eXUU9Re8vgs
 slSiL/1dAd9cFmv+mzlyYWtK59QZB77B8wLcCHj+HNq/NtKyihtcQElTac3DAWbUrBbc
 Jn+P4fUTWrK6wkQ4fMIQJsMrSDVJ34Q4wA/tPH9p4qN3uuYxVUZA43h7mAlEngf2GQ3T
 W34gUerG0ltlJZ6efARnS0cK3gM+6Y7qEKyZHoQ3linbpKVLqCqT592qq47da+p8YN1T
 ZugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880814; x=1792485614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rsG3TCscVd7PYoqyQA/dMMFq21JiQcdL/3Au5s6HFt4=;
 b=nJZ3Z9ylEt16hxr7fuAPINH5UrDj0pzQ10xnXkKak8nh0ROB6rCcyypteh+McHI+i4
 hyMTfrdqkwrCN9/tGtLQR48pRhSmkg3lHIOS5jbCF7OjLbcVdHhQZn8dapGqzXcZGw+K
 UnxPcCo59NCF6BgMuGtQMycn2jYCgDv+waSDmN9Mp1re4X66kJy/OQ+SAdmg8XfqUVPr
 LcGOXimYZZYuSRV1noWqCRVwhOF2Zx/LlnBQ9WE9pqf48Neu9Z8Qk3G3QWDq6UmUonTZ
 2XDYklzt9RFBXqhzJVjHVO4W738CpUTn23s5043SSYehz/Oy8q4vOUgpsAxlpcv9UOvw
 1Zqg==
X-Forwarded-Encrypted: i=1;
 AKwUvByUEAz1dbBz2LpKmpPnG99BxJ8SU/Xe6H2Wf1cTJz27SnNIkp2NOAHLZGJ+K4VBA4SvXDF0OaRqHRYU@nongnu.org
X-Gm-Message-State: AFq9FYI5bid4bdnxEEpJK0uFOQ0Kx48WsHzKttH5SNiqTnxdj8ZleWNl
 qW8dLjtVRMDsOiGd+lslLTSK9lByts4ej10sZvxn6nlgZpOp7DFUe0Uix5Ts6kxWqUxO9FT45wK
 4kaOp7nE=
X-Gm-Gg: AYBFou0eeKiDI5Q9VVVB2onWwxgy6EPXUoSFuyLd37ZwWtLBDyJF3tSWoGCggqfWc8w
 TiQG7AO/ZtMfPThMDxOgAUqEDgFFw0EKfkoa0Txz9cK9F7D5uw18tmX8pflI0Wb5aVx3UyNpXpI
 RIpiwIv8A9QHbIPuf8PWsAmopkwPQhh8jqKer+tEXcRGEUO9bHO9ws5U2ETfSZPGFbnFVO1Nip1
 USXakNXNr0byatal10MG7m9YA03DlwQxfbEY9yk5txYrH5EdAEHUJX8Y8h6LfZaDRYM9w2MKqtL
 i300681ypuVZf7YcuXhGZHQXpBIvGGLqPwSufZZtOULy4WQtzfrW7I8Fz/IwoyPKAFdyFNKMdet
 GTCaFJoRGDBo0kS/u+M+9w/17Y+OEsHLVjiThJjM+JVfs42ju6gg3ErWX56Ebt0jsJUFaxiX18K
 abMY9rqTrPnyuXTdkjbY0rVCX8EbNiWheqseJtLSMYaXsVW/XoXd0MR1GikIoxhq1X9rqcNkcBy
 hzgu8CTr4qJBXoUG6mSk7Op51Pcgw/w722vKT+8kCMojsa+FFeQZ6/zaChMkmllCtKM7OgOWPuZ
 UO8=
X-Received: by 2002:a05:600c:c167:b0:4a1:a3cc:3c5c with SMTP id
 5b1f17b1804b1-4a1a3cc3c71mr70078265e9.16.1791880813676; 
 Tue, 13 Oct 2026 01:40:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 27/86] target/arm: GICv5 cpuif: Implement
 ICV_PPI_PRIORITYR<n>_EL1
Date: Tue, 13 Oct 2026 09:38:34 +0100
Message-ID: <20261013083933.1024405-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Implement the redirection of ICC_PPI_PRIORITYR<n>_EL1 to
ICV_PPI_ENABLER<n>_EL1; the data for this is stored in
ICH_PPI_ENABLER<n>_EL2.

The algorithm in gic_ppi_prio_hvi_mask() for expanding 8 mask
bits out into 8 mask bytes is suggested by an AI, but it is
only 4 lines of code, and I wrote the comments.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 64 ++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 2c717b99a0b..e1d3ffb7b1e 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -487,11 +487,70 @@ static void gic_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static int icc_ppi_prio_reg_index(const ARMCPRegInfo *ri)
+{
+    /*
+     * Return the index of the ICC or ICV PPI_PRIORITYR register,
+     * which is CRm[0]:opc2[2:0].
+     */
+    return deposit32(ri->opc2, 3, 1, ri->crm);
+}
+
+static uint64_t gic_ppi_prio_hvi_mask(CPUARMState *env, int idx)
+{
+    /*
+     * Return the mask of which fields in the given priority register
+     * the guest cannot see, which is controlled by the ICH_PPI_HVI
+     * registers.  We need to expand the appropriate 8 bits from
+     * ICH_PPI_HVI out to a mask where each byte is either all-1s or
+     * all-0s.  The return value here is 1s for "do not show the
+     * guest", the same sense as the ICH_PPI_HVI registers.
+     */
+    int regno = idx >> 3;
+    int startbit = idx & 7;
+    /* Extract the relevant 8 HVI bits from the right register */
+    uint64_t mask = extract64(env->gicv5_cpuif.ich_ppi_hvi[regno], startbit, 8);
+
+    /*
+     * Now we're going to distribute those 8 bits so they end up in
+     * bits 0, 8, 16, ... 56 of the mask (i.e. in the LSB of each byte).
+     */
+    /* Split the 8 bits into two 4-bit chunks at bits 0 and 32 */
+    mask = (mask | (mask << 28)) & 0x0000000f0000000fULL;
+    /* Split again into four 2-bit chunks at bits 0, 16, 32, 48 */
+    mask = (mask | (mask << 14)) & 0x0003000300030003ULL;
+    /* Split again into eight 1-bit chunks, at the LSB of each byte */
+    mask = (mask | (mask << 7)) & 0x0101010101010101ULL;
+    /* Finally, the multiply turns each 0x1 byte into 0xFF */
+    mask *= 0xff;
+    return mask;
+}
+
+static uint64_t gic_ppi_priority_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    if (gicv5_icv_access(env)) {
+        int idx = icc_ppi_prio_reg_index(ri);
+        uint64_t r = env->gicv5_cpuif.ich_ppi_priority[idx];
+        uint64_t hvi_mask = gic_ppi_prio_hvi_mask(env, idx);
+
+        return r & ~hvi_mask;
+    } else {
+        return raw_read(env, ri);
+    }
+}
+
 static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
-    raw_write(env, ri, value);
-    gic_recalc_ppi_hppi(env);
+    if (gicv5_icv_access(env)) {
+        int idx = icc_ppi_prio_reg_index(ri);
+        uint64_t hvi_mask = gic_ppi_prio_hvi_mask(env, idx);
+
+        env->gicv5_cpuif.ich_ppi_priority[idx] = value & ~hvi_mask;
+    } else {
+        raw_write(env, ri, value);
+        gic_recalc_ppi_hppi(env);
+    }
 }
 
 static void gic_ich_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1239,6 +1298,7 @@ void define_gicv5_cpuif_regs(ARMCPU *cpu)
                 .fgt = FGT_ICC_PPI_PRIORITYRN_EL1,
                 .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_priority[i]),
                 .writefn = gic_ppi_priority_write, .raw_writefn = raw_write,
+                .readfn = gic_ppi_priority_read,
             };
             define_one_arm_cp_reg(cpu, &ppi_prio);
         }
-- 
2.43.0


