Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37D2C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wer06-0000z3-Ag; Wed, 01 Jul 2026 05:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weqzi-0000rX-Ka
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 05:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weqzg-0007MT-FX
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 05:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782897151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SeybQdIIWmF3pMhGkURLVzPRIuE7Bsif8FAumNRhLgY=;
 b=JdoW4tj634Ge0KCq/yX+PKUA8l6xN644rH6hBV49c9QSPE6ANyao4E71wDv7bVP3C6FNaE
 E5kGFSpai7hOEQaS8xhkvsmqiBvQE508trnNUiMIkLX3fBg7hHcizETLNoFCrzps7Xiaap
 TkWuapn4hH4oPrO9NZ5cp2J440IAiek=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-cN0DoPIVPeOia7H8uVDJEA-1; Wed,
 01 Jul 2026 05:12:28 -0400
X-MC-Unique: cN0DoPIVPeOia7H8uVDJEA-1
X-Mimecast-MFC-AGG-ID: cN0DoPIVPeOia7H8uVDJEA_1782897147
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4878B1945106; Wed,  1 Jul 2026 09:12:27 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.33.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F215180060F; Wed,  1 Jul 2026 09:12:24 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com,
 skolothumtho@nvidia.com, nicolinc@nvidia.com, nathanc@nvidia.com
Subject: [PATCH v2 3/5] hw/arm/smmuv3: Sanitize SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
Date: Wed,  1 Jul 2026 11:11:40 +0200
Message-ID: <20260701091209.2860306-4-eric.auger@redhat.com>
In-Reply-To: <20260701091209.2860306-1-eric.auger@redhat.com>
References: <20260701091209.2860306-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

STRTAB_BASE_CFG.LOG2SIZE is programmed by the guest through the
emulated SMMUv3 MMIO register interface. Currently the value is
not checked and used directly in smmu_find_ste() for strtab_base
alignment computation with risk that MAKE_64BIT_MASK() runs out
of bounds. On FMT==1 the strtab_size cannot be greater than 64 after
the SPLIT being at minimum 6 (log2size is max 64).

However on FMT=0 path, strtab_size= log2size + 6 can potentially
exceed 64. Let's abort in that case.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3632
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 285e6164a07..5ec3700d0d5 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1696,6 +1696,14 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
                 s->sid_split = 6;
             }
             s->features |= SMMU_FEATURE_2LVL_STE;
+        } else {
+            uint32_t log2size = FIELD_EX32(data, STRTAB_BASE_CFG, LOG2SIZE);
+
+            if (log2size + 6 > 64) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Invalid STRTAB_BASE_CFG.LOG2SIZE: %d", log2size);
+                g_assert_not_reached();
+            }
         }
         break;
     case A_CMDQ_BASE: /* 64b */
-- 
2.53.0


