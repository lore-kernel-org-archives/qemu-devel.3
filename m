Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2640C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErr2-0000zP-5P; Wed, 05 Jun 2024 10:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sErr0-0000yq-Vy; Wed, 05 Jun 2024 10:43:07 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sErqy-0004PT-Se; Wed, 05 Jun 2024 10:43:06 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52b93370ad0so6333153e87.2; 
 Wed, 05 Jun 2024 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717598583; x=1718203383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsVLiVuAn4sxtlhqqkPf8UmG53ookLSzBjac4UXBmbo=;
 b=GYZplCWNusBkvh59pERqxiIcYgJD4UoUQ2daXbzMsdIHZ5qlPCzaWHYc9Yt6sPqva/
 ywgAtm+dBlosBEaJCSMcJB36XM4RJ4YmKFPW6HetvXtfqZipnqYXslq9vLs2fKaGGyHA
 gNN5dKUUt8/bTbE2jPT2YjCTgk40TzlTjcg1t2HRgtUn4C2FInNVaGz9DJFWqBsyp7RP
 hSagT3Of8AskiuzEIldOEYvWtQw4Vsq/obg23B1a3pOtY8x3YUwGaTGdOAh4IaIloEUP
 pNfz9fKp3nSeA6C8Nn82ugJehwEpjGIvP+lOAK+huP8MpPVg5QYnIWZpH2oa5lVCzAdD
 fyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717598583; x=1718203383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IsVLiVuAn4sxtlhqqkPf8UmG53ookLSzBjac4UXBmbo=;
 b=f0OnIOjsR0t9Fo4j5tyD2lKEqoNK6hryU8MfBby/fsdyQxCtI1uOgFl7wWEbzaGWAh
 UB7tfNQ2cwFJYif31KCsEElW3G67UKqfsftGOUiPzfLlOjmCdvm8m+J5M9CUxK4ToudS
 xGAUwkJ9v2ld34KP0MAtdC/tofvm5SEqxZrvpWwMMGjpvjk/2JVZ+Vf5x+iyF3i1LHlK
 kq+0NKW7nYgB6u44aPUq0B8Ig6j2vll22NpwfdBKbCQHUXs1QsRZGc3jsnZOiomfSyJ/
 waT1eOlmKyK74wD157qckcdxGruZjHEP4ChlROLfh+doFoOA9EELjL8XMLDQSSFOuP6R
 B68A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqlrvcq3OaskevIhyS/xIkc5J0TB1BzM7prevjMmphl33ZybSAiKlGvD2tbnW3LwIGtE3rhAABgqdnMgO1mMeLybYaNzJ/llFHAxZK0Lur+d3jNKZLNPF80Tc=
X-Gm-Message-State: AOJu0YyRExSuhC5h8nfu62cnq2Bc2CagFHi63N/pKFkjsQVzondtPaWG
 1GZ2K5EadfutWdXkqIw2iHKnMKM9ZRZdJ1XkT8nnR71LEHS1AAfr
X-Google-Smtp-Source: AGHT+IHdg1ocJTA9GQYAtt4yEKpYQ5V1VwQHuVObavYOMuvzHPc2hzHGD2AWPYP1mVxt3No1AVliAQ==
X-Received: by 2002:a05:6512:3a8d:b0:52b:7c7c:bf4a with SMTP id
 2adb3069b0e04-52bab4c9a16mr2698644e87.10.1717598582619; 
 Wed, 05 Jun 2024 07:43:02 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52b84d7ecbdsm1807334e87.182.2024.06.05.07.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:43:02 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: sstabellini@kernel.org, julien@xen.org, bertrand.marquis@arm.com,
 edgar.iglesias@amd.com
Subject: [PATCH v1 1/1] hw/intc/arm_gic: Fix deactivation of SPI lines
Date: Wed,  5 Jun 2024 16:30:44 +0200
Message-Id: <20240605143044.2029444-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240605143044.2029444-1-edgar.iglesias@gmail.com>
References: <20240605143044.2029444-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Julien reported that he has seen strange behaviour when running
Xen on QEMU using GICv2. When Xen migrates a guest's vCPU from
one pCPU to another while the vCPU is handling an interrupt, the
guest is unable to properly deactivate interrupts.

Looking at it a little closer, our GICv2 model treats
deactivation of SPI lines as if they were PPI's, i.e banked per
CPU core. The state for active interrupts should only be banked
for PPI lines, not for SPI lines.

Make deactivation of SPI lines unbanked, similar to how we
handle writes to GICD_ICACTIVER.

Reported-by: Julien Grall <julien@xen.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/intc/gic_internal.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
index 8d29b40ca1..8ddbf554c6 100644
--- a/hw/intc/gic_internal.h
+++ b/hw/intc/gic_internal.h
@@ -280,6 +280,8 @@ static inline void gic_set_active(GICState *s, int irq, int cpu)
 
 static inline void gic_clear_active(GICState *s, int irq, int cpu)
 {
+    unsigned int cm;
+
     if (gic_is_vcpu(cpu)) {
         uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
         GICH_LR_CLEAR_ACTIVE(*entry);
@@ -301,11 +303,13 @@ static inline void gic_clear_active(GICState *s, int irq, int cpu)
              * the GIC is secure.
              */
             if (!s->security_extn || GIC_DIST_TEST_GROUP(phys_irq, 1 << rcpu)) {
-                GIC_DIST_CLEAR_ACTIVE(phys_irq, 1 << rcpu);
+                cm = phys_irq < GIC_INTERNAL ? 1 << rcpu : ALL_CPU_MASK;
+                GIC_DIST_CLEAR_ACTIVE(phys_irq, cm);
             }
         }
     } else {
-        GIC_DIST_CLEAR_ACTIVE(irq, 1 << cpu);
+        cm = irq < GIC_INTERNAL ? 1 << cpu : ALL_CPU_MASK;
+        GIC_DIST_CLEAR_ACTIVE(irq, cm);
     }
 }
 
-- 
2.40.1


