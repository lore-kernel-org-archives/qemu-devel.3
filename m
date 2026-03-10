Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6FBFCC9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq5P-0000Mv-Ab; Tue, 10 Mar 2026 01:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5H-000840-JT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5G-0006JL-7c
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jom5EJvT7LgkAx4Ap5azKCpZXCiV3zJ7vOSGvCN+Nh8=;
 b=PvWYWmNYKgkQ5k6bNvgzEvkr42A7EOO5uM5UoxtaI7U2/5hAE8FY1ZWnoGpta0D1vCEIJT
 1WQc04zJ6ueqpBd/Un6umb6G7+MjFk+58AfjGxVPv3+cfI7uwVrbnnUWFZN/wLtsey4it7
 wGgBLpJOjl7mMrEDrsKIPd2uch2PZns=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-yozpV5VyN4SFxT7xSO3WTA-1; Tue,
 10 Mar 2026 01:56:43 -0400
X-MC-Unique: yozpV5VyN4SFxT7xSO3WTA-1
X-Mimecast-MFC-AGG-ID: yozpV5VyN4SFxT7xSO3WTA_1773122202
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DBAA180035D; Tue, 10 Mar 2026 05:56:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 277571955D71; Tue, 10 Mar 2026 05:56:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 17/25] s390x: Add definitions for PCI IPL type
Date: Tue, 10 Mar 2026 06:55:22 +0100
Message-ID: <20260310055530.8893-18-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

Define a new PBT code and IPLB layout in preparation for supporting PCI device
IPL on s390x.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20260309003601.242634-10-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/ipl/qipl.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 6dc12dd859f..8d3c83a80bd 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -23,6 +23,7 @@
 enum S390IplType {
     S390_IPL_TYPE_FCP = 0x00,
     S390_IPL_TYPE_CCW = 0x02,
+    S390_IPL_TYPE_PCI = 0x04,
     S390_IPL_TYPE_PV = 0x05,
     S390_IPL_TYPE_QEMU_SCSI = 0xff
 };
@@ -108,6 +109,14 @@ struct IplBlockQemuScsi {
 } QEMU_PACKED;
 typedef struct IplBlockQemuScsi IplBlockQemuScsi;
 
+struct IplBlockPci {
+    uint32_t reserved0[76];
+    uint8_t  opt;
+    uint8_t  reserved1[3];
+    uint32_t fid;
+} QEMU_PACKED;
+typedef struct IplBlockPci IplBlockPci;
+
 union IplParameterBlock {
     struct {
         uint32_t len;
@@ -123,6 +132,7 @@ union IplParameterBlock {
             IplBlockFcp fcp;
             IPLBlockPV pv;
             IplBlockQemuScsi scsi;
+            IplBlockPci pci;
         };
     } QEMU_PACKED;
     struct {
-- 
2.53.0


