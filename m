Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B69C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtSS-0003RI-HO; Fri, 01 Aug 2025 13:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3G-0002fg-H1
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3E-0000yM-Bn
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:09 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b7834f2e72so1518156f8f.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754063526; x=1754668326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qJIK23UyAslwl363cABUZ9a0g5viH1x6Yzu8I+xd/oI=;
 b=RmTozoFBthS1UQZY6b1mi1hv8hxswGUxWr64cfG0ef7IrPXlBiNZBcG+SDl+54F0cM
 Svfl5GlAMmDdD4AUpsZMxPUMNZ3JxEFPfXfRKevKPg7wp0Yr48mkaWOFdBPWEJfOkGfa
 0auivpZnmLbhkbPancUjwZJaWU/dszr7V+PQ+uQSU4BFxfggBJ1xmtNMBpL/CQdSXsAL
 dJBbY2OigFfeC3ipTVGqhvt4GU1QR8jYgcF6NrgD4xBRuqt5ehfAlbxvDPe9I3Vk8gmi
 hlCZsr8cATuOxINZHLiPn1fk0rxfRkHHEzwzy2anJjFOkvwxyF1YFwtJtXlPZJoza3Lh
 0qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754063526; x=1754668326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJIK23UyAslwl363cABUZ9a0g5viH1x6Yzu8I+xd/oI=;
 b=YMhbcFNCfq5n1wSgBzy/j7uGyS2pEtrlYc/HKOT0Q43jPLKBc4f4tpJ2B3zLWxsw4M
 zoT4an563qFSuxux2hOrISK2UdIGDQxKxdMd+MJizYszE/dYE9o11vF+zBQyGDCo6S4P
 HcMMhbebhTDTjnhFX8dqJzRoZog4sitDgHt3CZpiO1UmLe3AoJzUW4JgXdCKewT/8Ymc
 eSCYH6rS5JGbsxJxTc6XjGSnbDZo6vnncbn2LoPMSE/GU0zd6kfe8lJfglSx94PQS8RO
 iqbiUKhSzFlD3wEGLU1ibuZgAP2Va5TS2Ar7ElcMuq5tgVvyAttmQZTPioRu1UuZvNJq
 YRDQ==
X-Gm-Message-State: AOJu0Yy/K6NZDsjBrfh+4Mnw7VVU17zqzvOEfUnN01bmVZUU9mPau3pq
 9dW80WymPpiS5AyyZptM7NhFnKGyIA4rGHBLP427AFQWTkjnGKHRi7stBtMHkV//1tOupxFbWi1
 yXR+5
X-Gm-Gg: ASbGnct960/Fr/xdasaXW7Roe21m3n4zqJ2tbC9htT25Oa9wxm/CmFt8bpml/vQJyKr
 Jroa+FwW8GZsaK+jKyTksv/eymls3Y9SHglrB/2A13qSeviT6581zdXCApWNwiIBZHAKEKkxDoS
 VtmjHK7RtiLYhMR6Nflm5jN893hIj5t8uy8NQ9GqtHd8B+5CDLlfq0z4bFFRHwJsKM7mgxx2GNv
 /VU/p1ygrec/QaIZr/JS1XDUXWGlv7XwGGF+wglrVuLONU930j69vAq0wOCVtwXwAY7McJ5zQ5O
 Jsag1XRwrSiV3TyB4DUZGDMNX9MkEW/05OcC7geyu3B6Z4sQzlbVmG+9YQQYOWG07YV1JejE+mb
 kfE2/gd6OIw6pGh13E5Pwfu0/NTd4
X-Google-Smtp-Source: AGHT+IE9WJkfGLuKzSwUs7GEoGGcxBSukD8rND1tTuXsnr3iMXPOWiVEoqqzft1J1OCf1Gn/64Iazg==
X-Received: by 2002:a5d:64cb:0:b0:3b7:761a:95d9 with SMTP id
 ffacd0b85a97d-3b8d94ce478mr211244f8f.59.1754063526483; 
 Fri, 01 Aug 2025 08:52:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2f03sm6176670f8f.72.2025.08.01.08.52.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 08:52:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] hw/intc/arm_gicv3_kvm: Remove writes to ICPENDR registers
Date: Fri,  1 Aug 2025 16:51:53 +0100
Message-ID: <20250801155159.400947-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801155159.400947-1-peter.maydell@linaro.org>
References: <20250801155159.400947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Zenghui Yu <zenghui.yu@linux.dev>

As per the arm-vgic-v3 kernel doc [1]:

    Accesses to GICD_ICPENDR register region and GICR_ICPENDR0 registers
    have RAZ/WI semantics, meaning that reads always return 0 and writes
    are always ignored.

The state behind these registers (both 0 and 1 bits) is written by
writing to the GICD_ISPENDR and GICR_ISPENDR0 registers, unlike
some of the other set/clear register pairs.

Remove the useless writes to ICPENDR registers in kvm_arm_gicv3_put().

[1] https://docs.kernel.org/virt/kvm/devices/arm-vgic-v3.html

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Message-id: 20250729161650.43758-2-zenghui.yu@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_kvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 8ed88e74299..f798a6e28ca 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -387,8 +387,6 @@ static void kvm_arm_gicv3_put(GICv3State *s)
         reg = c->level;
         kvm_gic_line_level_access(s, 0, ncpu, &reg, true);
 
-        reg = ~0;
-        kvm_gicr_access(s, GICR_ICPENDR0, ncpu, &reg, true);
         reg = c->gicr_ipendr0;
         kvm_gicr_access(s, GICR_ISPENDR0, ncpu, &reg, true);
 
@@ -445,7 +443,7 @@ static void kvm_arm_gicv3_put(GICv3State *s)
     kvm_gic_put_line_level_bmp(s, s->level);
 
     /* s->pending bitmap -> GICD_ISPENDRn */
-    kvm_dist_putbmp(s, GICD_ISPENDR, GICD_ICPENDR, s->pending);
+    kvm_dist_putbmp(s, GICD_ISPENDR, 0, s->pending);
 
     /* s->active bitmap -> GICD_ISACTIVERn */
     kvm_dist_putbmp(s, GICD_ISACTIVER, GICD_ICACTIVER, s->active);
-- 
2.43.0


