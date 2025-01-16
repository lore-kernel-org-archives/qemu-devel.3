Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E78C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 00:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYE4x-00086z-Lm; Wed, 15 Jan 2025 19:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tYE4q-00084N-ON
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 19:49:41 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tYE4o-00013s-TA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 19:49:40 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so29612235ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 16:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736988577; x=1737593377;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lgkkhzulTnPKcpEBmv5wI+O/YgsMfxY7bx5/eHF5LmE=;
 b=o60CLDO2mvh6NQbaTgsK++qc94WRToo1DBVvQ4UJSYZ4/I3xwb6EKwXToNHsv+lwd+
 bY9HmMT5m4POPLWxiKQZBh+rOfcWg+xQzj8Uz3XeB8LBJ2ZDvJP+FVRQCki5JPl8o1mP
 PyxPWvQFEy2x4tBFgRplQYSwxSgJGLpDpBuRr8qPpGwmlaRp64QtrJHBqVTxnTwi0qQv
 TngzHpPvlFBVMnRs0amvls6iYYDwPwkCleAyPeCKCkihLkKy0WFfRJtkA41QVyNn8hgg
 LNLGi1eFYzAGtB/VRZOlRhNAZ81Hz3zwCRrpXACeshSwkcKeSuv+xE7toLRPD040m4O4
 MEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736988577; x=1737593377;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgkkhzulTnPKcpEBmv5wI+O/YgsMfxY7bx5/eHF5LmE=;
 b=GijW09LnBdx6Mt2R7QjF6CZxLJ1RHSABFcp6uW5GLtKPXlN+Pa2ziHc0Az0EoTl8/I
 GawLc/8chATbmtc/2rWdLkvevWiRdkeBfZVinvyZS7Q75CDlm+0YuWSjYK4O5DvimumL
 R08GMrg87yDlQb07XC2ResXt2oaPiuGbK+E8sSOaxnOi3Bj8QyXJaJzOxYSh/REaaC6i
 f1BVHX8LbyHM5rV+egaYehbUAwG36n61ElZedJvY9qh7Hr0KgifH4JpaGSfQNPPdegGD
 U4rRTNEV/4P0z2Ij4VID6xY6qQKDoRgAqjn+axeXtVeEfONsXd12kPMdaCkgd4STT+hy
 PfAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7BVpAjPA1oIFfea3OWLKNwAlvNMf+n8wKrfecRoOMejNXG3mawQvkLWzusK3tTHDbsk1Cop0qtlCz@nongnu.org
X-Gm-Message-State: AOJu0YzVSKiUlb5H1QmGL5+klNTNYJ3il9rapUUY6LOguecwsmcBr6m1
 u+tEeCyhKIgMRIv4awFpFusm9SQBBDbwViMVK0ZqHq7rj7x+mfjIKlZAehBzxAvttsvsWrDrHdn
 q
X-Gm-Gg: ASbGncsJhVTkIddT31+0A4g2m9ePGpcO8jJq614HW7UcqKUOiir67GSe9s7OwtDv65h
 VuZ04FEfhZ+QBZJohRTdmnjU88sLsb3D0rwcywFIhOmvbq9SIrTDiEFZOdHjFXz/RkrGcbhiZy5
 SYgQWMVz00RtnWwPqNjuQgI5PqNbZFrNmD5URbu0uGngH0xwcscQ6NPWDZVJiJWTBrVH4yVuqwi
 oJ+1reJhF38qXMaa9WQ4lntHrrNDHlzQd6jVyIefb7j8rdZb1BkBqJnI7ps5PaFFAoDXg==
X-Google-Smtp-Source: AGHT+IGjMuzuTMLEd6F0ofghXzioexFDI380SwoYW+3GBbIYYSuSYVbZvijo0NwwH3yZBu3meDqU3A==
X-Received: by 2002:a05:6a20:9188:b0:1e1:9e9f:ae4 with SMTP id
 adf61e73a8af0-1eb0255b580mr7562798637.13.1736988577273; 
 Wed, 15 Jan 2025 16:49:37 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d406587a1sm10036256b3a.105.2025.01.15.16.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 16:49:36 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 15 Jan 2025 16:49:33 -0800
Subject: [PATCH 2/2] target/riscv: Mask out upper sscofpmf bits during
 validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-pmu_minor_fixes-v1-2-c32388defb02@rivosinc.com>
References: <20250115-pmu_minor_fixes-v1-0-c32388defb02@rivosinc.com>
In-Reply-To: <20250115-pmu_minor_fixes-v1-0-c32388defb02@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

As per the ISA definition, the upper 8 bits in hpmevent are defined
by Sscofpmf for privilege mode filtering and overflow bits while the
lower 56 bits are desginated for platform specific hpmevent values.
For the reset case, mhpmevent value should have zero in lower 56 bits.
Software may set the OF bit to indicate disable interrupt.

Ensure that correct value is checked after masking while clearing the
event encodings.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index cf713663ee56..0408f96e6af8 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -390,7 +390,7 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
      * Expected mhpmevent value is zero for reset case. Remove the current
      * mapping.
      */
-    if (!value) {
+    if (!(value & MHPMEVENT_IDX_MASK)) {
         g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
                                     pmu_remove_event_map,
                                     GUINT_TO_POINTER(ctr_idx));

-- 
2.34.1


