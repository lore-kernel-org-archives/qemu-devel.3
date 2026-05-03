Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDEAFF886F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 07:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJROC-0008U2-VL; Sun, 03 May 2026 03:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJRNj-0008BE-LA
 for qemu-devel@nongnu.org; Sun, 03 May 2026 03:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJRNi-0003ex-9n
 for qemu-devel@nongnu.org; Sun, 03 May 2026 03:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777793809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=557ybO8Fo2cuy3bEAfcP6Q/Qbo00s1S/okkhzC4QXa4=;
 b=iruJI14mqRdN19Y+r1G5fks5yEx3AEde7iU9BeaTJ8/jxLCio6uwZpgC4T87eB4siab3sc
 ce5GLsvyKCWsVfH7NXRvtFj0SF5SO7aVZD6X8V2IR8eGKdEMNVKqdO45zkCW2aUx2wxh/u
 Z17TECHIEt4vhtORaVK+jRGgRyC7m7Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-ljsCbmcJOf-NUPTUsfrLfA-1; Sun,
 03 May 2026 03:36:46 -0400
X-MC-Unique: ljsCbmcJOf-NUPTUsfrLfA-1
X-Mimecast-MFC-AGG-ID: ljsCbmcJOf-NUPTUsfrLfA_1777793805
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF25619560B4; Sun,  3 May 2026 07:36:44 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAF7B1800345; Sun,  3 May 2026 07:36:39 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, cohuck@redhat.com, sebott@redhat.com,
 skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v4 09/17] arm/cpu: accessors for writable id registers
Date: Sun,  3 May 2026 09:33:29 +0200
Message-ID: <20260503073541.790215-10-eric.auger@redhat.com>
In-Reply-To: <20260503073541.790215-1-eric.auger@redhat.com>
References: <20260503073541.790215-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cornelia Huck <cohuck@redhat.com>

Introduce ARM_FEATURE_ID_RANGE_IDX macro that converts opcodes
into the index used to access the 3 * 8 * 8 feature id array.

KVM_ARM_GET_REG_WRITABLE_MASKS populates writable masks with
that indexing.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2aa22360d2..0ac0fd13cf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -886,6 +886,13 @@ typedef struct IdRegMap {
     uint64_t regs[NR_ID_REG_MASKS]; /* writable masks for registers */
 } IdRegMap;
 
+#define ARM_FEATURE_ID_RANGE_IDX(op0, op1, crn, crm, op2)               \
+        ({                                                              \
+                __u64 __op1 = (op1) & 3;                                \
+                __op1 -= (__op1 == 3);                                  \
+                (__op1 << 6 | ((crm) & 7) << 3 | (op2));                \
+        })
+
 /* REG is ID_XXX */
 #define FIELD_DP64_IDREG(ISAR, REG, FIELD, VALUE)                       \
     ({                                                                  \
-- 
2.53.0


