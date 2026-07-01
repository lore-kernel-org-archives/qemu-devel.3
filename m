Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2C7C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wer0c-00019T-Gw; Wed, 01 Jul 2026 05:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weqzn-0000uM-4B
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 05:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weqzl-0007Nv-Ig
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 05:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782897157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UlUWdtEhYgdtN6KjOCbmywf5XaizCagqsN+FcWuwf4=;
 b=F7+PrRQ30C9gn7jDeOh/Rb+WxB7MibZAnO0Kjx2HQX/SBp1IkLySnswj9MPWF8ZkogVlvb
 4Uv7egd3HA4SGB406Ugp62RUnyNSbDBuUQQMBuHJkRVqzEI4Xq7h0S6IQAavUrb8BV7W9q
 hH4N/nMXqFj33EAeFiFvfwzpuLEET9M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-QDFIVG2UMVKh4fvf7Tz87w-1; Wed,
 01 Jul 2026 05:12:31 -0400
X-MC-Unique: QDFIVG2UMVKh4fvf7Tz87w-1
X-Mimecast-MFC-AGG-ID: QDFIVG2UMVKh4fvf7Tz87w_1782897150
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 896191945111; Wed,  1 Jul 2026 09:12:30 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.33.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEBA71800586; Wed,  1 Jul 2026 09:12:27 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com,
 skolothumtho@nvidia.com, nicolinc@nvidia.com, nathanc@nvidia.com
Subject: [PATCH v2 4/5] hw/arm/smmuv3: Check L1STD.SPAN
Date: Wed,  1 Jul 2026 11:11:41 +0200
Message-ID: <20260701091209.2860306-5-eric.auger@redhat.com>
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

Span values above 11 are reserved and behave as 0.

Also span must be within the range of 0 to (SMMU_STRTAB_BASE_CFG.SPLIT + 1),
ie. it must stay within the bounds of the stream table split point.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5ec3700d0d5..f694f832598 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -707,7 +707,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
 
         span = L1STD_SPAN(&l1std);
 
-        if (!span) {
+        if (!span || span > 11) {
             /* l2ptr is not valid */
             if (!event->inval_ste_allowed) {
                 qemu_log_mask(LOG_GUEST_ERROR,
@@ -716,6 +716,16 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
             event->type = SMMU_EVT_C_BAD_STREAMID;
             return -EINVAL;
         }
+
+        if (span > s->sid_split + 1) {
+            if (!event->inval_ste_allowed) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "invalid span (0x%x)\n", span);
+            }
+            event->type = SMMU_EVT_C_BAD_STREAMID;
+            return -EINVAL;
+        }
+
         max_l2_ste = (1 << span) - 1;
         l2ptr = l1std_l2ptr(&l1std);
         trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
-- 
2.53.0


