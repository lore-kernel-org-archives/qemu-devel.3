Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A14EC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 12:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUm0m-0004Q5-Ng; Thu, 26 Jun 2025 08:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5272304780=rmudimadugul@marvell.com>)
 id 1uUlf9-0001Bp-3G
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 08:25:08 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5272304780=rmudimadugul@marvell.com>)
 id 1uUlf3-0006Ay-Dl
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 08:25:06 -0400
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QARnZO032042;
 Thu, 26 Jun 2025 05:24:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=93DsU75GNxQFAnfZw+KjtTj
 XvdDdy4FE9C09G2xNI1M=; b=VRaatanbzinPFNdqGIOazs4NuWchOKpyceYpDDc
 DfN4LQ/wrBKC//h1R9S/gmh0fXAkfkqMZccVRmIj/x5bIqeOH/WNvkHsXk0NpQGs
 xej4JFN9AkE6M8JCGOyJaY1TErOT5yR6v4cqk8jGt8Ezb7M3hmyEfTA2VAxSFL2V
 7WJLB/67mlZQ2IuAX0jut2R1XHiO4lbWOsnv2F2fLkb2d0ccBAip9cIQCSjBInLJ
 Hd+yvRJKg4u18bwIJ8xh3o/uMJIAmlORrp7CMmZSPLextKcKEJNO6BIcKunoDuNd
 P6nW3or6Te4vhHGFMTg4D09V8ca8wPb0HnSFI/oG6TTzBsQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47h4f786f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Jun 2025 05:24:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 26 Jun 2025 05:24:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 26 Jun 2025 05:24:53 -0700
Received: from Dell640-transport-1.sclab.marvell.com (unknown [10.106.48.36])
 by maili.marvell.com (Postfix) with ESMTP id 78A773F706B;
 Thu, 26 Jun 2025 05:24:53 -0700 (PDT)
From: Rajesh Mudimadugula <rmudimadugul@marvell.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <pizhenwei@bytedance.com>, <gmuthukrishn@marvell.com>,
 Rajesh Mudimadugula <rmudimadugul@marvell.com>
Subject: [PATCH] vhost-user: enable asym capabilities for user backend
Date: Thu, 26 Jun 2025 12:24:51 +0000
Message-ID: <20250626122451.908205-1-rmudimadugul@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=AZexH2XG c=1 sm=1 tr=0 ts=685d3c16 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=M0aHttIpEyw3PdpNef4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: d5MgdsZs4pXi7YAQTaYzL3_NA_bJ7L99
X-Proofpoint-ORIG-GUID: d5MgdsZs4pXi7YAQTaYzL3_NA_bJ7L99
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEwNCBTYWx0ZWRfX8eTGhXlSW02b
 YD6tcAGwV4p0hrpsxDisriwObGUewr6OACIgTtDcOKBrOswXYj3QWQ49845lQRTKlV1aVgbkbdT
 NCrofrs5O5oEn3c89X4BBPm6cA0VXS2MKwFrPufW4wLkqbgBcn6DHvVWJG07o/idKhHh+ippX/o
 wUMjFIlCjTMyaZllSz8aWeU5ksx0Y2OqaO0qOBJSw5QfZ+gzr4JwanxUUHxKb3EQmfpcgDpquYU
 dJzQfUBywwQWyv6kNF6UaF1SKMBt4hKirnHP9Z5tLk4LXrUPCmIltqbYY/lcQ3Va8acsLq8X21o
 WE8ZM0eIhaac2+DjEH4XnUqGfBUHY2lM1C0SHpqL34DilLP/HCoccNEPguBSIeOYCVbwaErC/lz
 ldDWoUW4/QwwwwSQYGa8X/uDVHsCPW1aAiniyyn/q+CmycgfCkFV3owxqHiCrgTpJn8LJ8g4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
Received-SPF: pass client-ip=67.231.156.173;
 envelope-from=prvs=5272304780=rmudimadugul@marvell.com;
 helo=mx0b-0016f401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Jun 2025 08:47:25 -0400
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

This patch enables and advertises asym capabilties
for backend user application.

Signed-off-by: Rajesh Mudimadugula <rmudimadugul@marvell.com>
---
 backends/cryptodev-vhost-user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index cb04e68b02..f9dec14a4a 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -230,6 +230,9 @@ static void cryptodev_vhost_user_init(
     backend->conf.max_size = UINT64_MAX;
     backend->conf.max_cipher_key_len = VHOST_USER_MAX_CIPHER_KEY_LEN;
     backend->conf.max_auth_key_len = VHOST_USER_MAX_AUTH_KEY_LEN;
+    backend->conf.crypto_services |=
+	    1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_AKCIPHER;
+    backend->conf.akcipher_algo = 1u << VIRTIO_CRYPTO_AKCIPHER_RSA;
 }
 
 static int64_t cryptodev_vhost_user_crypto_create_session(
-- 
2.34.1


