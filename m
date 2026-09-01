Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10189C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONC-00012T-AS; Tue, 01 Sep 2026 09:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON8-00010u-Gr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:54 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON6-0007Ay-9W
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:54 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c25344a8c6cso640517166b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268671; x=1788873471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IglmI3ZIkNFV+A9WkCcAhwihdAJmoFH/GPtd9JGl38g=;
 b=QezChY4jEnJ3N18CXJndV5cgUHMq9jah0I7Vuv+TJxRNDcBP4Ub2YtvvBzPzU839Xx
 hs5xIjzC0QPUztruoMQJ0RNGK7AQglIlXRroDFL/9BGCv2eyhtpOuORA2j2y8kyd6r78
 1z7nmqaL/n/bCtyGKXxFnh5Ylp9Z56A7XwjoDilFJypdqT0cgBaXy3Mb3EV34q1VFXw3
 s89vOhHbH6F3N3ilDuqh8ezreVg3OmS/CeYbWKKi1ukFN+irWMlKj025quqgfkinC2jl
 umqsamDALKXQgpDf3nIG3lEBCjLLg5fUwEhA/rFuTnKFKo8we3LCQIaViN3gbC1ihuJL
 qu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268671; x=1788873471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IglmI3ZIkNFV+A9WkCcAhwihdAJmoFH/GPtd9JGl38g=;
 b=A2cZStd2VP+hRlOQnsQL9P3K+i8O5NFa/FCHUPcTbACU+novs4nb8tMg2UDUk8hJT/
 5vdojBi5tRvosSslYZcB7xNeZPktSnMJ5oej9qJjEB4Vny/XXB/cQxCTHGc4aAY+q3VU
 zSq/216mTsOkCzDZEcD+XkwrorcLHkNbxS7O9E7Ovo50MKwfEZTzifFm3ncCgegvxHVn
 2TAMqqo8G4Psa9yTnQreqla250SkLJjlA/COmLV0bQ9r1LUMksoA1Ji4kEkFRLoDjebK
 wsRwCwYNecuztpHvBtpCYH3ahrr27Jc0BlazTDy+1OeuqrPF8YlfSkB3dJxxpN0RjzS+
 tcAw==
X-Gm-Message-State: AFuF++k2xdQ4C8yW6cmuxa40OdRxMaYHA/J3tfR0OBDXVBrMdxs8YwJ5
 /sMTpVbqDWPxnma3k7VzHMAunrAkzvpk2FPBfoAB1ClLAbNjF/2WdT1uH/IAYLoeDPGlclwvtyd
 6MUnCoXo=
X-Gm-Gg: AR+sD10Ze621bk3HFhVnSzMClC73yX5De0CQrd3dfueyHsXdYmW2KC1c6sSVyQKyfQd
 QKJGjwLe869TU7P8Qgcuva5Sa2ripJ1XklZCSyFthSRBoxnhVYm7oRI7pqnGarSDe8C154qjWrz
 OBYx4JhDXuYJGtB0dTn5E3/PYeZpf9qGOAaRyuqjESdebphe1rBtdf2LDYKuUSPlh+dyFCQwOE5
 Lc/AIaMj6WYbKZ6GVmFdnbuOlLXADCQs2trhHoQ6Bup3O81NKHEs95SBcLdIjYaR2HVOQYdsxel
 GkNLkR7ZYA8TjXWG4X7N78jZL4+RFyeIO+4cPBK+pcQjKX3VOBHfakevP1PNFPBdMayoYaK98MK
 RB4dlXgkakFSEyEx4Mpr42lUt7dfa4A2RW8SMOKGvH8ZsjFL/q8Gg62FXo/PcoYtiVYuT6BFv/c
 ZRDv0hGsTprWOsJyQyDut4LQ8NImXLfjD/0VYVsgToueX7OJBCqhMAD5s5nMJmyq+TjMcHOfdUY
 0QCwxh/GP328l4FXY42uxGPz3BQKO6MvbPbXDTnuXVHR+RozqfRj+XOOIXhaBHtivNo0Q==
X-Received: by 2002:a17:906:7306:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c2556be194dmr2225500266b.1.1788268670678; 
 Tue, 01 Sep 2026 06:17:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/58] hw/misc/iotkit-sysctl.c: add SSE-310 support
Date: Tue,  1 Sep 2026 14:16:50 +0100
Message-ID: <20260901131732.2263947-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

From: Simon Xu <simonxhy0404@gmail.com>

Add SSE-310 case statements for reads and writes.
Add new SSE-310 PIDR and CLIDR values.
Add new SSE-310 PPUINTSTAT register as RAZ with LOG_UMIMP on reads and
RO on writes.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Message-Id: <20260805153005.9989-4-simonxhy0404@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/iotkit-sysctl.c | 86 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 7 deletions(-)

diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index dff89c677f7..90dde4d4dc9 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -51,6 +51,7 @@ REG32(CPUWAIT, 0x118)
 REG32(NMI_ENABLE, 0x11c) /* BUSWAIT in IoTKit */
 REG32(WICCTRL, 0x120)
 REG32(EWCTRL, 0x124)
+REG32(PPUINTSTAT, 0x128)
 REG32(PWRCTRL, 0x1fc)
     FIELD(PWRCTRL, PPU_ACCESS_UNLOCK, 0, 1)
     FIELD(PWRCTRL, PPU_ACCESS_FILTER, 1, 1)
@@ -87,6 +88,12 @@ static const int sse200_sysctl_id[] = {
     0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
 };
 
+static const int sse310_sysctl_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x54, 0xb8, 0x4b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
 /*
  * Set the initial secure vector table offset address for the core.
  * This will take effect when the CPU next resets.
@@ -118,6 +125,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->scsecctrl;
             break;
         default:
@@ -130,6 +138,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->fclk_div;
             break;
         default:
@@ -142,6 +151,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->sysclk_div;
             break;
         default:
@@ -154,6 +164,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->clock_force;
             break;
         default:
@@ -180,6 +191,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->initsvtor1;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -192,6 +204,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->cpuwait;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             /* In SSE300 this is reserved (for INITSVTOR2) */
             goto bad_offset;
         default:
@@ -208,6 +221,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->nmi_enable;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             /* In SSE300 this is reserved (for INITSVTOR3) */
             goto bad_offset;
         default:
@@ -221,7 +235,8 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->wicctrl;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is CPUWAIT */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is CPUWAIT */
             r = s->cpuwait;
             break;
         default:
@@ -236,19 +251,36 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->ewctrl;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is NMI_ENABLE */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is NMI_ENABLE */
             r = s->nmi_enable;
             break;
         default:
             g_assert_not_reached();
         }
         break;
+    case A_PPUINTSTAT:
+        switch (s->sse_version) {
+        case ARMSSE_IOTKIT:
+        case ARMSSE_SSE200:
+        case ARMSSE_SSE300:
+            goto bad_offset;
+        case ARMSSE_SSE310:
+            qemu_log_mask(LOG_UNIMP,
+                          "IoTKit SysCtl PPUINTSTAT unimplemented\n");
+            r = 0;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
     case A_PWRCTRL:
         switch (s->sse_version) {
         case ARMSSE_IOTKIT:
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pwrctrl;
             break;
         default:
@@ -261,6 +293,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pdcm_pd_sys_sense;
             break;
         default:
@@ -273,6 +306,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pdcm_pd_cpu0_sense;
             break;
         default:
@@ -287,6 +321,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram0_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -300,6 +335,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram1_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -313,6 +349,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram2_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pdcm_pd_vmr0_sense;
             break;
         default:
@@ -327,6 +364,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram3_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pdcm_pd_vmr1_sense;
             break;
         default:
@@ -342,6 +380,9 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
         case ARMSSE_SSE300:
             r = sse200_sysctl_id[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = sse310_sysctl_id[(offset - A_PID4) / 4];
+            break;
         default:
             g_assert_not_reached();
         }
@@ -367,7 +408,8 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
 
 static void cpuwait_write(IoTKitSysCtl *s, uint32_t value)
 {
-    int num_cpus = (s->sse_version == ARMSSE_SSE300) ? 1 : 2;
+    int num_cpus = (s->sse_version == ARMSSE_SSE300 ||
+                    s->sse_version == ARMSSE_SSE310) ? 1 : 2;
     int i;
 
     for (i = 0; i < num_cpus; i++) {
@@ -418,7 +460,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
     case A_INITSVTOR0:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
-            /* SSE300 has a LOCK bit which prevents further writes when set */
+        case ARMSSE_SSE310:
+            /* SSE300, SSE310 have a LOCK bit which prevents further writes */
             if (s->initsvtor0 & R_INITSVTOR0_LOCK_MASK) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "IoTKit INITSVTOR0 write when register locked\n");
@@ -443,6 +486,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             cpuwait_write(s, value);
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             /* In SSE300 this is reserved (for INITSVTOR2) */
             goto bad_offset;
         default:
@@ -457,7 +501,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->wicctrl = value;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is CPUWAIT */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is CPUWAIT */
             cpuwait_write(s, value);
             break;
         default:
@@ -485,6 +530,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl SCSECCTRL unimplemented\n");
             s->scsecctrl = value;
             break;
@@ -498,6 +544,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl FCLK_DIV unimplemented\n");
             s->fclk_div = value;
             break;
@@ -511,6 +558,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl SYSCLK_DIV unimplemented\n");
             s->sysclk_div = value;
             break;
@@ -524,6 +572,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl CLOCK_FORCE unimplemented\n");
             s->clock_force = value;
             break;
@@ -540,6 +589,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             set_init_vtor(1, s->initsvtor1);
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -554,7 +604,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->ewctrl = value;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is NMI_ENABLE */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is NMI_ENABLE */
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl NMI_ENABLE unimplemented\n");
             s->nmi_enable = value;
             break;
@@ -562,12 +613,25 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             g_assert_not_reached();
         }
         break;
+    case A_PPUINTSTAT:
+        switch (s->sse_version) {
+        case ARMSSE_IOTKIT:
+        case ARMSSE_SSE200:
+        case ARMSSE_SSE300:
+            goto bad_offset;
+        case ARMSSE_SSE310:
+            goto ro_offset;
+        default:
+            g_assert_not_reached();
+        }
+        break;
     case A_PWRCTRL:
         switch (s->sse_version) {
         case ARMSSE_IOTKIT:
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             if (!(s->pwrctrl & R_PWRCTRL_PPU_ACCESS_UNLOCK_MASK)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "IoTKit PWRCTRL write when register locked\n");
@@ -585,6 +649,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_SYS_SENSE unimplemented\n");
             s->pdcm_pd_sys_sense = value;
@@ -599,6 +664,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_CPU0_SENSE unimplemented\n");
             s->pdcm_pd_cpu0_sense = value;
@@ -617,6 +683,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram0_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -632,6 +699,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram1_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -647,6 +715,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram2_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_VMR0_SENSE unimplemented\n");
             s->pdcm_pd_vmr0_sense = value;
@@ -665,6 +734,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram3_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_VMR1_SENSE unimplemented\n");
             s->pdcm_pd_vmr1_sense = value;
@@ -683,6 +753,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->nmi_enable = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             /* In SSE300 this is reserved (for INITSVTOR3) */
             goto bad_offset;
         default:
@@ -769,7 +840,8 @@ static bool sse300_needed(void *opaque)
 {
     IoTKitSysCtl *s = IOTKIT_SYSCTL(opaque);
 
-    return s->sse_version == ARMSSE_SSE300;
+    return s->sse_version == ARMSSE_SSE300 ||
+           s->sse_version == ARMSSE_SSE310;
 }
 
 static const VMStateDescription iotkit_sysctl_sse300_vmstate = {
-- 
2.43.0


