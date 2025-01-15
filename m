Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC03C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 07:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXxzW-0005G3-TO; Wed, 15 Jan 2025 02:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXxzU-0005FZ-Tw
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:39:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXxzT-0007sz-73
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736926742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYW/IgtQPkRO4kOJDrQMhvbbR2nkJaPUlVP+cegfQl0=;
 b=F+qPorVfcH0RuCuDbYgmMJwDuOXzUdmm1U2+w/QsLfZC/AjLt/XzhAFH4db2r+ZSErzmX1
 5Otm4/W80wOQK6+m+jBCnblzXu75mO2kDP5zVRkchrmCPUfI6ci25NKAoFoGOKctEIQTOK
 aD7q4z85rS+OKuvdpO49+h2AvPH32Io=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-NNRhQnBGNV2i3luwhNjqGQ-1; Wed,
 15 Jan 2025 02:38:59 -0500
X-MC-Unique: NNRhQnBGNV2i3luwhNjqGQ-1
X-Mimecast-MFC-AGG-ID: NNRhQnBGNV2i3luwhNjqGQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A36D619560A1; Wed, 15 Jan 2025 07:38:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.143])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34F55195608A; Wed, 15 Jan 2025 07:38:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 7/8] target/s390x/gen-features: Remove the v2.11 qemu CPU model
Date: Wed, 15 Jan 2025 08:38:18 +0100
Message-ID: <20250115073819.15452-8-thuth@redhat.com>
In-Reply-To: <20250115073819.15452-1-thuth@redhat.com>
References: <20250115073819.15452-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now that the v2.11 machine is gone, we don't need the v2.11 CPU
feature set anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/gen-features.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 41840677ce..150e4d1843 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -844,12 +844,6 @@ static uint16_t default_GEN17_GA1[] = {
 
 /* QEMU (CPU model) features */
 
-static uint16_t qemu_V2_11[] = {
-    S390_FEAT_GROUP_PLO,
-    S390_FEAT_ESAN3,
-    S390_FEAT_ZARCH,
-};
-
 static uint16_t qemu_V3_1[] = {
     S390_FEAT_DAT_ENH,
     S390_FEAT_IDTE_SEGMENT,
@@ -1053,7 +1047,6 @@ static FeatGroupDefSpec FeatGroupDef[] = {
  * QEMU (CPU model) features
  *******************************/
 static FeatGroupDefSpec QemuFeatDef[] = {
-    QEMU_FEAT_INITIALIZER(V2_11),
     QEMU_FEAT_INITIALIZER(V3_1),
     QEMU_FEAT_INITIALIZER(V4_0),
     QEMU_FEAT_INITIALIZER(V4_1),
-- 
2.47.1


