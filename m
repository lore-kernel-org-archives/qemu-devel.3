Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0534C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1W9-0007k2-6C; Tue, 07 Jul 2026 04:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wh1W7-0007iv-8s
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wh1W5-0008HG-S9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783414257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FUxLKvQrjXBoERFnuq4rILmrrAKQKBPsHkbH7TgG2Dc=;
 b=KrcpEpHPxBjqwTqkW+pjbVSReGMTDQV3eTuiCkV0zBY9+v2HI7kAnwWZ1dF9yJXPQn6qBY
 FKOTaZP3pN+c3qaberBqT6K1mjUT0PotZn7tfKCUoYPWosTZz6aTxu4CVCJ/nQScFuONcs
 pce+8rG70zizffNKFvrw3wrYVX7RzPk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-FiE92qxEPK6OHxuN392xZQ-1; Tue,
 07 Jul 2026 04:50:54 -0400
X-MC-Unique: FiE92qxEPK6OHxuN392xZQ-1
X-Mimecast-MFC-AGG-ID: FiE92qxEPK6OHxuN392xZQ_1783414252
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6931A1955D57; Tue,  7 Jul 2026 08:50:52 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.50.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FCEB1955F71; Tue,  7 Jul 2026 08:50:47 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com,
 skolothumtho@nvidia.com, nicolinc@nvidia.com, nathanc@nvidia.com,
 philmd@oss.qualcomm.com
Subject: [PATCH v3 3/5] hw/arm/smmuv3: Fix possible overflow in strtab_base
 computation
Date: Tue,  7 Jul 2026 10:49:35 +0200
Message-ID: <20260707085028.165557-4-eric.auger@redhat.com>
In-Reply-To: <20260707085028.165557-1-eric.auger@redhat.com>
References: <20260707085028.165557-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

In the linear stream table mode (FMT = 0), if the guest programs
SMMU_STRTAB_BASE_CFG.LOG2SIZE (8 bits) to something bigger than 58,
MAKE_64BIT_MASK() will overflow. So cap the mask length to 64. We
still comply with the spec ADDR alignment computation:

ADDR[LOG2SIZE + 5:0] = 0.

In the 2 level stream table mode (FMT = 1), we don't have this risk
anymore since SPLIT is sanitized and equals to 6 at minimum.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3632
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c2946d8d23c..3fd1dd7cf81 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -730,6 +730,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
         addr = l2ptr + l2_ste_offset * sizeof(*ste);
     } else {
         strtab_size = log2size + STE_SIZE;
+        strtab_size = MIN(64, strtab_size);
         strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
                       ~MAKE_64BIT_MASK(0, strtab_size);
         addr = strtab_base + sid * sizeof(*ste);
-- 
2.53.0


