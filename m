Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64E6D49234
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 15:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD3dC-0002p7-BR; Mon, 18 Nov 2024 10:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tD3dB-0002oc-7p; Mon, 18 Nov 2024 10:25:37 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tD3d9-0004b5-Bv; Mon, 18 Nov 2024 10:25:36 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so24456001fa.0; 
 Mon, 18 Nov 2024 07:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731943533; x=1732548333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akSdSGiRTfyLnN0cC+NRUPJFGXfzjIlmKD+aKjcrBGM=;
 b=Wl1Iq80KdRduFpRZvJwfGjVIqkd0SH7cC7QG7x2ExupnUu9meT0LowH0cABu/6vMCh
 b2ZDfQa+HuF2GAE9F4DS5g9Z50yMYEEtr0FkS4F+miZURX3HqIXL11Qt0W909EE18cvo
 FTUXsyaUhv5SGV/rj5X9gTcd76MHIJ9bUrMCqvdN7V0Gi143qun00MTM+0JYNwFVx2he
 UfHEl7wYwQ+zqiwNJRVklmQrLQXcBYIcEFvHHYcCMUpzFEzVXKeQZPXPPjiloN4AtfyQ
 prwcrK8f48cNkkCJWgMF1V8aCubVeh9wlTVdntNe/Oupq4hhIVO9MFf1yE2ybL8CDPNb
 mi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731943533; x=1732548333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akSdSGiRTfyLnN0cC+NRUPJFGXfzjIlmKD+aKjcrBGM=;
 b=CZwo6YV+ejiwBmrkW+YjUoQmN8tiRpyLMY8BStMJkRq4wL5U7An2ucucF5gj5D5CwC
 SvIohUoVCAMxMFy8Ky4LURcy9df/tojmh8Lw6CmGNbTAzBFKTzarj8ckVXz/1wtj1ZgX
 Kz0Y4RIZV+fguqN1ZyCJl1EvjqOyfXSMpkP32tFKjcqpi3Mbz5y8imYImiokXN5hVorF
 nmdYue79rGQzYYa5WhC1hCyjQ5MkK8OPSrsNVWRPg2GszluRpnUFYuAzlKz5I2EpbUgQ
 BLrLTwinRg8ezLWQC6t/11uFT8sWyn/6WEiUWmVAcoIADNJYUiD15NQFcMsU0IqE1j/1
 z//w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF5zz7KjYlUe4TKedhE3//9SR0oACv4R8gTFiZnKmYIfybLc21qYwzbOtiA3WXJPQfWBwnLmZS7wfn@nongnu.org
X-Gm-Message-State: AOJu0YysVl46n4caYttncrR7+VdeQjIhreTGxpPjy+QEmMgBUIi0oDUQ
 uIU4zmkSgSkP/6G7Rx1ZVsiQyJlUnHJQT4e8tTTKGbupmvgRc48ltx+5VySl
X-Google-Smtp-Source: AGHT+IGi/TszPQc/izzt/ZJ4WxK/3rYzzaQAoRe2gFLi17Fgn+41/1128bPDjHJWoBSDfYp2xT+68Q==
X-Received: by 2002:a05:651c:50d:b0:2fa:de13:5c34 with SMTP id
 38308e7fff4ca-2ff60661742mr90143831fa.19.1731943533102; 
 Mon, 18 Nov 2024 07:25:33 -0800 (PST)
Received: from fedora.. ([2a00:1370:8180:90b:d00f:257f:ffb:ac70])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ff69ae7fb8sm9498981fa.87.2024.11.18.07.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 07:25:31 -0800 (PST)
From: Pavel Skripkin <paskripkin@gmail.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 1/2] arm/ptw: make get_S1prot accept decoded AP
Date: Mon, 18 Nov 2024 10:25:26 -0500
Message-ID: <20241118152526.45185-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118152507.45046-1-paskripkin@gmail.com>
References: <20241118152507.45046-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=paskripkin@gmail.com; helo=mail-lj1-x229.google.com
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

AP in armv7 short descriptor mode has 3 bits and also domain, which
makes it incompatible with other arm schemas.

To make it possible to share get_S1prot between armv8, armv7 long
format, armv7 short format and armv6 it's easier to make caller
decode AP.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 target/arm/ptw.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9849949508..86d6255713 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1357,25 +1357,24 @@ static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
  * @env:     CPUARMState
  * @mmu_idx: MMU index indicating required translation regime
  * @is_aa64: TRUE if AArch64
- * @ap:      The 2-bit simple AP (AP[2:1])
+ * @user_rw: Translated AP for user access
+ * @prot_rw: Translated AP for privileged access
  * @xn:      XN (execute-never) bit
  * @pxn:     PXN (privileged execute-never) bit
  * @in_pa:   The original input pa space
  * @out_pa:  The output pa space, modified by NSTable, NS, and NSE
  */
 static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
-                      int ap, int xn, int pxn,
+                      int user_rw, int prot_rw, int xn, int pxn,
                       ARMSecuritySpace in_pa, ARMSecuritySpace out_pa)
 {
     ARMCPU *cpu = env_archcpu(env);
     bool is_user = regime_is_user(env, mmu_idx);
-    int prot_rw, user_rw;
     bool have_wxn;
     int wxn = 0;
 
     assert(!regime_is_stage2(mmu_idx));
 
-    user_rw = simple_ap_to_rw_prot_is_user(ap, true);
     if (is_user) {
         prot_rw = user_rw;
     } else {
@@ -1393,8 +1392,6 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
                    regime_is_pan(env, mmu_idx) &&
                    (regime_sctlr(env, mmu_idx) & SCTLR_EPAN) && !xn) {
             prot_rw = 0;
-        } else {
-            prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
         }
     }
 
@@ -2044,6 +2041,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         int nse, ns = extract32(attrs, 5, 1);
         uint8_t attrindx;
         uint64_t mair;
+        int user_rw, prot_rw;
 
         switch (out_space) {
         case ARMSS_Root:
@@ -2110,11 +2108,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
             xn = 0;
             ap &= ~1;
         }
+
+        user_rw = simple_ap_to_rw_prot_is_user(ap, true);
+        prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
         /*
          * Note that we modified ptw->in_space earlier for NSTable, but
          * result->f.attrs retains a copy of the original security space.
          */
-        result->f.prot = get_S1prot(env, mmu_idx, aarch64, ap, xn, pxn,
+        result->f.prot = get_S1prot(env, mmu_idx, aarch64, user_rw, prot_rw, xn, pxn,
                                     result->f.attrs.space, out_space);
 
         /* Index into MAIR registers for cache attributes */
-- 
2.47.0


