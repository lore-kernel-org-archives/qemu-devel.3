Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACE1109449E
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 23:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w45bJ-0002z7-QR; Sat, 21 Mar 2026 19:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1w45bG-0002yN-S6
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 19:19:22 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1w45bF-0002L2-8c
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 19:19:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439c9bdc1eeso3015861f8f.3
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 16:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774135159; x=1774739959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=taN5i5PqZqqZVzFggF/Qi/FgD648VkuyzwYuJ2FNeCg=;
 b=Rd5Eav4ZUby/GihHQyVAey3mKNhzYZnKhUSjn1qyvo61QeXwi/QOrmiKq/vE6H6/Ue
 M4Fk8ySg0IwtJcQI8P0pYrGC9uC0DFoQJxRCV9fmU71z2TKF7h+UnJpZwj/wItaeaI1I
 bYH61TNhw2N1/qQ9AtJ86lsMhhQYZZx3DJtHn0Hap1+p3LvWAYB3tieOhRA+26bRmddy
 UZNb8B0+xBHA4OdEKkBu/TZBO5NVyQKPV4wZ6bw4AHf1ZdGLGbxoM4P3NqnOigTe5Hz+
 L+/P2SG7ezbbcxDyHGmROW/YpDC3E0rDmNKC0L1iPWzbH72rSVdzMSMr84PfxzGfzOFe
 rwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774135159; x=1774739959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taN5i5PqZqqZVzFggF/Qi/FgD648VkuyzwYuJ2FNeCg=;
 b=B7rYIqF3aKVg54ejtAO5xama5W/iBsKQNUcvtrNGvZRyR3IkSUA5jro1KxoEFRHsGu
 NgQtsW8+cN+h5M+kNB8OppbXPMurwHlBGUDPitz0omTxsF7M6JTsc9UHquCe6RnYV8qQ
 L3UcXoAtgBut/WvK9fZt1GcyfFlIJBq1qao9Kwah9UPMFobaN/OUiOdgFTfXJqC7fezp
 5s8nxkrUBRvhOTu6pqopEJi0gzm2AKsBLzW8g/b4d7/+0bG5AkrM4Jcg7pc3nQBE93EJ
 Sai0lvxBVKq1MsooEKA9UR9YfB2LbvmJyCAsdRdvff4mMGRFXT2Lr9D73loHC1NCxqIZ
 WUVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/eqNE7G8Od7ao/9ZENpBWUQkQTP1YfwJyxgpc3LNEjl5vS0yUmI+IHM/MbsBmr22BhzoqDnMdJ4wE@nongnu.org
X-Gm-Message-State: AOJu0Yx2tSgL/tO5r/THaRPSZ0R8CyKsSieNRsn9XO7KdbPeSxNEQUkx
 s6jXLfAwFRKTQyeDBHAzrzjcVv4r9GYJhmyKwskihTuBSW+cdrzyHKYS
X-Gm-Gg: ATEYQzwiWDjalGl2eLKfw6Rj6b3UX3/Xnq9a3vw9eV0DhsgRecBF5SDTjHvVu3a1J4X
 62g1y7cPrD5Tx4HWfraeh4pCpn7HssWjY00KFXrmEvmOEt/wRL+EEM+50j7BregWA8raZg7W+5y
 KERkD6W8jz+vFYQ5obDhHX79W7reuIlhX9R8VYBBYwRB++HhE1IdL+bcbyG9JIcypbJkXHnFSLf
 8hXNJs7n26Ti0Wd2v8F1M1BcJmKozBisfxLMQNrwskr5SyKo6WEIprJgtNk+5tK4HcTGB5341aS
 07U3fX91duL8ofdOCSRQ6Q0XHxiB21ocFcXVAdUj70fAIgAYQv9GQyn8v0H3++yQ8XUE5Cma3K1
 qKKbD4nw2WimWJmmr93Wlk1FOUxDEcG3tvayM3yq2cW+9bUnzT9tiY2FEBkeMBfEhaXwikAKzmN
 C0/fQDO415QEt2Iel43C/HR+8rCcrBdZGX9b+4WYVV6k07Xr+buxQpgEB1bHRMvyHCXVIZ
X-Received: by 2002:a05:6000:184d:b0:43b:5762:2989 with SMTP id
 ffacd0b85a97d-43b6427b212mr12005836f8f.49.1774135159222; 
 Sat, 21 Mar 2026 16:19:19 -0700 (PDT)
Received: from josecm-msi (a89-153-207-214.cpe.netcabo.pt. [89.153.207.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd923sm20264431f8f.12.2026.03.21.16.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 16:19:18 -0700 (PDT)
From: Jose Martins <josemartins90@gmail.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Jose Martins <josemartins90@gmail.com>
Subject: [PATCH 1/1] target/arm: fix s2prot not set for two-stage PMSA
 translations
Date: Sat, 21 Mar 2026 23:19:16 +0000
Message-ID: <20260321231916.2852653-1-josemartins90@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=josemartins90@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

commit 015cefc0ed65 ("target/arm: Add in_prot_check to S1Translate")
changed get_phys_addr_twostage() to combine stage 1 and stage 2
permissions using the new s2prot field:

  result->f.prot = s1_prot & result->s2prot;

The LPAE stage 2 path sets result->s2prot explicitly, but the PMSA
stage 2 path (get_phys_addr_pmsav8) only sets result->f.prot, leaving
s2prot at zero. This causes the combined permission to be zero,
resulting in addr_read being set to -1 in the TLB entry and triggering
an assertion in atomic_mmu_lookup() when the guest executes an atomic
instruction on a two-stage PMSA platform (e.g. Cortex-R52 with EL2).

Set s2prot from f.prot after the PMSA stage 2 lookup, consistent with
what the LPAE path does.

Fixes: 015cefc0ed65 ("target/arm: Add in_prot_check to S1Translate")
Signed-off-by: Jose Martins <josemartins90@gmail.com>
---
This issue was found while running a Bao hypervisor [1] demo on the
mps3-an536 machine, which features a Cortex-R52 with virtualization
support (PMSAv8 with EL2). Bao uses the stage 2 PMSA MPU to partition
memory between guest VMs. With QEMU >= 10.2.0 the demo crashes
immediately after the first guest VCPU is scheduled, when the guest
executes its first atomic instruction:

  ERROR:../accel/tcg/cputlb.c:1848:atomic_mmu_lookup: \
      code should not be reached

To reproduce, clone the bao-demos repository [2] and follow the
instructions for the mps3-an536 platform and baremetal demo. With this
patch applied, the demo boots successfully.

[1] https://github.com/bao-project/bao-hypervisor
[2] https://github.com/bao-project/bao-demos

 target/arm/ptw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8b8dc09e72..e289f88124 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3200,6 +3200,13 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
 
     ret = pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
                             mmu_idx, secure, result, fi, NULL);
+    /*
+     * For two-stage PMSA translations, s2prot holds the stage 2
+     * permissions to be combined with stage 1 in get_phys_addr_twostage().
+     */
+    if (regime_is_stage2(mmu_idx)) {
+        result->s2prot = result->f.prot;
+    }
     if (sattrs.subpage) {
         result->f.lg_page_size = 0;
     }
-- 
2.53.0


