Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125FFC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJpa-0004Il-Uv; Wed, 28 May 2025 12:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJpS-0004Dg-Fj
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:40:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJpQ-0007N0-5w
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:40:33 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCqMTg024357;
 Wed, 28 May 2025 16:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=STTCm
 LYvGNy47Me4cGoBc6uLUGklAyfLwPj9EVqosRw=; b=XFssd5yksyRktOq3G+VCi
 6+NJ+x+xrJf7afdNV2xt7sZ/bUgnt6FEJDLP5Mb2xbwmgEAxE9OfTBK/C6Jz0XU8
 zQ+tg6aVCKRL3hdjivukq8YzUrMpFDPpK+ov/P+Id3sEdqnbmWSonIxsHHs1t4M1
 uD27h+VXXDiBHMYo0LN+68azIUBAouukR2H4oURqSUunWUDlOx05tdmY+fsCil5E
 KUpuvetZsHnDlw5DIVQ4heRuPxY2BHlKXVZ74YvmXis8MHnfy34EGe6Ycf7umfVU
 G3Ht8OASWySBjLSZTEUrh1NqOkE1emD6t8Gb1ITRoMUYRQ2vUp5WuSmq5xHfTQO8
 w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46txe2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:40:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SFZtFO027835; Wed, 28 May 2025 16:40:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4janper-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:40:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGZvHA004472;
 Wed, 28 May 2025 16:40:20 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4janpcr-1; Wed, 28 May 2025 16:40:20 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 06/13] test/acpi: allow DSDT table changes for microvm
Date: Wed, 28 May 2025 12:40:10 -0400
Message-ID: <20250528164010.2191-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250528163545.2143-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280145
X-Proofpoint-GUID: 00JLmdtIDsfqRPxaBFwtnfj_tM1UQNP8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfX6/pVy9ERQlxo
 +wfdwx+w9b2pZ+Hf0TJGSMMca1GLd75LhiAEm/9zVO6LixJSz+PjuB2wcF5Sx0B2m8Rx9b7v8LU
 DV3EG3SlWG4m52SC3zzjmC2NGSPAgfwO2uWrQhf6Hkx+MaSaKqq2Xme8woyMeIUW8kJS9ovzWxa
 V/VafW+xjs/8BPTLshVkBZN0bulYW5hhlxg7laDwdSrKchHhAmQ03GQxakmuVw13hvb0XYDSwVw
 3MmuIo0FIeoFdusKD4CbYPhyCQCst5+/Pw2jRM/Z0bEa52Mbx4RMkpM8htps69d2TMIDz+haXQC
 q/PGr9jG7xeinkY0USu6dgr1/XhElnzXme9qPgVvbJID76Z6bMZRXbMAdmImYLQVu5+EICJ8e90
 7RCL/Wm/WHayz3CxlD/zWcMw2vOpxfCZdCayT3OcoRWw6cBq9QpWvz0FLuSwAL99+lqEu4pN
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=68373c76 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=0DZBe8mL0SfWGJ_CsLkA:9
X-Proofpoint-ORIG-GUID: 00JLmdtIDsfqRPxaBFwtnfj_tM1UQNP8
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

List changed files in tests/qtest/bios-tables-test-allowed-diff.h

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..bb028db137 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,6 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/microvm/DSDT",
+"tests/data/acpi/x86/microvm/DSDT.ioapic2",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
+"tests/data/acpi/x86/microvm/DSDT.rtc",
+"tests/data/acpi/x86/microvm/DSDT.usb",
-- 
2.43.5


