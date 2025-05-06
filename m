Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10A9C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 06:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCBh2-00080G-9w; Tue, 06 May 2025 02:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCBh0-0007yu-B0
 for qemu-devel@nongnu.org; Tue, 06 May 2025 02:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCBgy-0005sx-LS
 for qemu-devel@nongnu.org; Tue, 06 May 2025 02:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746512531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDIgUKE7JNG8uMUV1VE9NnIXQM++kgopu14d4ShCrus=;
 b=Vy38pDP/oQ5y9NQjH17fnNsi4cV9N9HwsckkDgeYBfYrxVmVyqnh3af0DwP+/shg2xPB6B
 ennYY1AYE5ZHTJBGHZ7m9BnAMeFZTIt9DbMvl2SYND5Cu8SD4TiRtx6zsFNg1S1oX2Pw6Y
 N34GivLBtzs5f8OjZccGvaMrtqlY+I8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-ACQK8zekPHSiwAZoh24cog-1; Tue,
 06 May 2025 02:22:08 -0400
X-MC-Unique: ACQK8zekPHSiwAZoh24cog-1
X-Mimecast-MFC-AGG-ID: ACQK8zekPHSiwAZoh24cog_1746512527
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F53D1800373; Tue,  6 May 2025 06:22:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.237])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8407C18001D5; Tue,  6 May 2025 06:22:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 4/9] target/s390x: Rename the qemu_V2_11 feature set to
 qemu_MIN
Date: Tue,  6 May 2025 08:21:43 +0200
Message-ID: <20250506062148.306084-5-thuth@redhat.com>
In-Reply-To: <20250506062148.306084-1-thuth@redhat.com>
References: <20250506062148.306084-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Now that the v2.11 machine type has been removed, it does not make
sense to keep the qemu_V2_11 feature set around. This is rather
the (minimum) feature set of the oldest supported machine now, so
rename it to qemu_MIN.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/gen-features.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 41840677ce7..754fc843d24 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -844,7 +844,8 @@ static uint16_t default_GEN17_GA1[] = {
 
 /* QEMU (CPU model) features */
 
-static uint16_t qemu_V2_11[] = {
+static uint16_t qemu_MIN[] = {
+    /* Features supported by the default CPU of the oldest machine type */
     S390_FEAT_GROUP_PLO,
     S390_FEAT_ESAN3,
     S390_FEAT_ZARCH,
@@ -1053,7 +1054,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
  * QEMU (CPU model) features
  *******************************/
 static FeatGroupDefSpec QemuFeatDef[] = {
-    QEMU_FEAT_INITIALIZER(V2_11),
+    QEMU_FEAT_INITIALIZER(MIN),
     QEMU_FEAT_INITIALIZER(V3_1),
     QEMU_FEAT_INITIALIZER(V4_0),
     QEMU_FEAT_INITIALIZER(V4_1),
-- 
2.49.0


