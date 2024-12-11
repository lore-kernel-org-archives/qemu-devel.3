Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83980E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIbe-0007ef-7M; Wed, 11 Dec 2024 04:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIam-0005vE-4P
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIah-0007sa-Ko
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPdRS9haFwIBvhoMtX2yy1Qh2YtZc+1DS/UycqOM9vg=;
 b=Fg1PT7Q78DXwpSPA44AvSiUx6pVQxZ/zbQMIB4Plps53BESe6rx39oX9ARiY0cS0+Ljr9R
 NWEjdSR0Zbb/RisynVH+AyPshbqDyIZmRr2s5tq3FmvZ6eZklrFtc/vqhuALs7ppKbCouS
 VuOYMY40lypAsDC4s7RFIlCkbztkVAY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-D4Qs8-RjMgST1LZJcl13uA-1; Wed,
 11 Dec 2024 04:01:01 -0500
X-MC-Unique: D4Qs8-RjMgST1LZJcl13uA-1
X-Mimecast-MFC-AGG-ID: D4Qs8-RjMgST1LZJcl13uA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43BED19560BF; Wed, 11 Dec 2024 09:00:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2AAE71956089; Wed, 11 Dec 2024 09:00:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PULL 11/26] s390x/cpumodel: add Vector Enhancements facility 3
Date: Wed, 11 Dec 2024 09:59:55 +0100
Message-ID: <20241211090014.619351-12-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Hendrik Brueckner <brueckner@linux.ibm.com>

The Vector Enhancements facility 3 introduces new instructions and
extends support for doubleword/quadword elements.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <20241206122751.189721-9-brueckner@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 1 +
 target/s390x/cpu_models.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 09872ab3d8..0b7be0e6e9 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -116,6 +116,7 @@ DEF_FEAT(BEAR_ENH, "beareh", STFL, 193, "BEAR-enhancement facility")
 DEF_FEAT(RDP, "rdp", STFL, 194, "Reset-DAT-protection facility")
 DEF_FEAT(PAI, "pai", STFL, 196, "Processor-Activity-Instrumentation facility")
 DEF_FEAT(PAIE, "paie", STFL, 197, "Processor-Activity-Instrumentation extension-1")
+DEF_FEAT(VECTOR_ENH3, "vxeh3", STFL, 198, "Vector Enhancements facility 3")
 DEF_FEAT(CCF_BASE, "ccf-base", STFL, 201, "Concurrent-Functions facility")
 
 /* Features exposed via SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 117434b9a8..5d548de79c 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -458,6 +458,8 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH, S390_FEAT_VECTOR_PACKED_DECIMAL },
         { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH },
         { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
+        { S390_FEAT_VECTOR_ENH2, S390_FEAT_VECTOR_ENH },
+        { S390_FEAT_VECTOR_ENH3, S390_FEAT_VECTOR_ENH2 },
         { S390_FEAT_INSTRUCTION_EXEC_PROT, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
         { S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2, S390_FEAT_ESOP },
         { S390_FEAT_CMM_NT, S390_FEAT_CMM },
-- 
2.47.1


