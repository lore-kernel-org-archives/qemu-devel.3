Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CCBC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 19:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWgsX-0005pQ-VJ; Tue, 01 Jul 2025 15:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWgsW-0005oK-LJ
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 15:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWgsV-0003e1-1F
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 15:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751398968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ki+vhfi4OhQ4s0f5YvvP+tThkXReE4JiTxJT7KmZNhk=;
 b=LHuO09mwge4lwTxXWupngk7mMlIGHNZSDege6Zxgb6zcy8pBbA45hjGhCTBuXSC2d4I2kC
 2OX3dscbYr6EP97YxLSxoHxoHH9trUFBfWsIaLop4SBqRmSjM4FrIvtui8B/d5hM3cgN9q
 FtHwf2r8EBN8BQ08z+EL4TVSY27qWGQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-jOhgVycnMXCLnMy4lds0Qw-1; Tue,
 01 Jul 2025 15:42:47 -0400
X-MC-Unique: jOhgVycnMXCLnMy4lds0Qw-1
X-Mimecast-MFC-AGG-ID: jOhgVycnMXCLnMy4lds0Qw_1751398966
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 213B4180136B; Tue,  1 Jul 2025 19:42:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.64])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 011B319560AB; Tue,  1 Jul 2025 19:42:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH] target/s390x: A fix for the trouble with tribles
Date: Tue,  1 Jul 2025 21:42:41 +0200
Message-ID: <20250701194241.434183-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While Tribbles are cute, it should be "triple store" here,
not "trible store".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index e23e603a792..c017bffcdc4 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -186,7 +186,7 @@ DEF_FEAT(PLO_CSO, "plo-cso", PLO, 25, "PLO Compare and swap (256 bit in paramete
 DEF_FEAT(PLO_DCSO, "plo-dcso", PLO, 26, "PLO Double compare and swap (256 bit in parameter list)")
 DEF_FEAT(PLO_CSSTO, "plo-cssto", PLO, 27, "PLO Compare and swap and store (256 bit in parameter list)")
 DEF_FEAT(PLO_CSDSTO, "plo-csdsto", PLO, 28, "PLO Compare and swap and double store (256 bit in parameter list)")
-DEF_FEAT(PLO_CSTSTO, "plo-cststo", PLO, 29, "PLO Compare and swap and trible store (256 bit in parameter list)")
+DEF_FEAT(PLO_CSTSTO, "plo-cststo", PLO, 29, "PLO Compare and swap and triple store (256 bit in parameter list)")
 DEF_FEAT(PLO_TCS, "plo-tcs", PLO, 30, "Triple compare and swap (32 bit in parameter list)")
 DEF_FEAT(PLO_TCSG, "plo-tcsg", PLO, 31, "Triple compare and swap (64 bit in parameter list)")
 DEF_FEAT(PLO_TCSX, "plo-tcsx", PLO, 32, "Triple compare and swap (128 bit in parameter list)")
-- 
2.50.0


