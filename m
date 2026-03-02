Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A08E9B359
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0eT-000385-9e; Mon, 02 Mar 2026 05:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx0eN-00034I-1r
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:37:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx0eI-0001sl-NB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772447829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqwIlq9YsCC/mk/RbZ2jJbZEoXtp/RnqPmOFKrdWkWY=;
 b=BMBcy9cnja/2vy5/WFjkPz1O9FHIgO6OI5K4oxrQFF+6tfvFTpKnmuk6DvUYAEXvKxJQaF
 DOit5LQHTTLCNmR2WX0DsQD9xalJ+JLRsTbTEwEsUcGwLO/8J8ByN3bgMk4sBH0yPie3Zr
 xIBdu8utiw0YERzMgvUM3paxq+SAoIc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-qgevpJmTOymKrMbyLzaddw-1; Mon,
 02 Mar 2026 05:37:06 -0500
X-MC-Unique: qgevpJmTOymKrMbyLzaddw-1
X-Mimecast-MFC-AGG-ID: qgevpJmTOymKrMbyLzaddw_1772447825
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5805C1956053; Mon,  2 Mar 2026 10:37:05 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A2831800666; Mon,  2 Mar 2026 10:37:01 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v7 5/7] target/arm/cpu64: Define cpreg migration tolerance for
 KVM_REG_ARM_VENDOR_HYP_BMAP_2
Date: Mon,  2 Mar 2026 11:35:27 +0100
Message-ID: <20260302103640.1362564-6-eric.auger@redhat.com>
In-Reply-To: <20260302103640.1362564-1-eric.auger@redhat.com>
References: <20260302103640.1362564-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 24
X-Spam_score: 2.4
X-Spam_bar: ++
X-Spam_report: (2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_PASS=-0.001,
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

KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
from v6.15 onwards. Backward migration from a >= v6.15 to an older
kernel would fail without cpreg migration tolerance definition
for this register.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9e64184f6f0..0a61edb27f6 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -817,6 +817,14 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
                                      0, 0, ToleranceNotOnBothEnds);
     arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
                                      0, 0, ToleranceNotOnBothEnds);
+
+    /*
+     * KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
+     * from v6.15 onwards. Backward migration from a >= v6.15 to an older
+     * kernel would fail without cpreg migration tolerance definition
+     */
+    arm_register_cpreg_mig_tolerance(cpu, KVM_REG_ARM_FW_FEAT_BMAP_REG(3),
+                                     0, 0, ToleranceNotOnBothEnds);
 }
 
 static void aarch64_host_initfn(Object *obj)
-- 
2.53.0


