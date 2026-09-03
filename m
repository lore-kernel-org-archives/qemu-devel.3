Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228C1C624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AFX-000432-GT; Thu, 03 Sep 2026 12:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFQ-0003wg-OR; Thu, 03 Sep 2026 12:25:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFP-0006Z2-5L; Thu, 03 Sep 2026 12:25:08 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2sHX3304765; Thu, 3 Sep 2026 16:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=drmyZ3p3oUWb8jhPL
 Go8lOYWeDHUXRL37N7zlYohvUM=; b=VNtrkIlzqtM8ApvlTpjtsquZ0Q7/0XlBi
 98cZQgc3EZHqhl2fpxydmOT7afQ6nAgi3YqO/YG/ynXFskKjcT4v9LyAHobhSbmE
 3IyImHbvtaSSVWJmUWjj4Eaz/5stVFz2IJmFLyyKGI1UJzrByPUr97CYqSXpD7DW
 xYkYyhJKHbZ04WlX1TSjxOrhtBx0XWXbNsx/7YW0IySTxjl5HdWDm2w2SCqiml28
 p7eSdiMQdD5LO6VHbSsEyzTDf00l/pBIAOCOQnClrqXkgQmVcBfIeJ0bxOCa/5Ny
 vNtewfE0T4McreFomoRRUzvyRT4hZdvaj+S4e5gm/i2iKKGfzzOGw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj5kss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:25:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GBkgP018205;
 Thu, 3 Sep 2026 16:25:04 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygr9ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:25:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683GOLuN66257216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:24:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D94B45805D;
 Thu,  3 Sep 2026 16:25:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55A8158053;
 Thu,  3 Sep 2026 16:25:01 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.144])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:25:01 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, jdaley@linux.ibm.com,
 pbonzini@redhat.com
Subject: [PATCH v2 6/7] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
Date: Thu,  3 Sep 2026 12:24:48 -0400
Message-ID: <20260903162449.2588271-7-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903162449.2588271-1-zycai@linux.ibm.com>
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yt-ROsJHyKbBlRad5jBIWXxWpnfvAHvQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfX6A55NGtNYvqt
 SEfZv7RiZV6UII/kCSz0ce+udx3H/ap778Ev5XR2YXHJyHGIL2K1aAw1n+dXPiKuJoKXISBjW/i
 gF5xp7hLJTlzgptfnz7At5eQiMZfCy2jS0IpM+cEM3tplAc5DlJ+1YPGSJdNnYr+mc9cg9K7mIu
 bHTLi+rZ5HdYSzqD8qIZbwu0JLNxcZuQLDw/ejZvq1XHgd2fEVvxNMJUiD20YRoLzdLv9cTMUYG
 0ByNj3lohKM3bdYW2DXbAgyo2rhCdkYAq5LVFWxdqeky6OkCO0y3/m8jfzQk4rZLe0Llkd9MUAb
 BQthYnGgvR3AKdJQKVW+elzllDIiyjbsZoyKkVWYxJQRZtx1JG04QKsReEPn+Nh8eEEkt9LLNxr
 cfSJFQ/g1pnBQfIJUZai768jKOn1XRp15qNbm+gMYWRf9UUb3W559XJOW1Nb3/T41/LSSJhyrZy
 pZruVQjtFQ8QrdIGYcQ==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a999f61 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=PkLLOfym-WlFbigP99UA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfXyutGpLnkdzp5
 R+7Gv0T6TnAaZB27qmcB1AqWDj6pL9QdCQrBdaiTBSs1H/ve0hTQ4pFOpI0VpqEWfdxDA7DYYMc
 qf3Qzp5cUgL8piscHxfkKTK7ieT2K/s=
X-Proofpoint-ORIG-GUID: Yt-ROsJHyKbBlRad5jBIWXxWpnfvAHvQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add test coverage for virtio-net-pci network booting on s390x by
including it in the PXE test suite. The test verifies that PXE
network booting works correctly with virtio-net-pci devices.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Tested-by: Joshua Daley <jdaley@linux.ibm.com>
---
 tests/qtest/meson.build | 1 +
 tests/qtest/pxe-test.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 50a1a5272f..654e145fbe 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -289,6 +289,7 @@ qtests_aarch64 = \
    'migration-test']
 
 qtests_s390x = \
+  (slirp.found() ? ['pxe-test'] : []) + \
   qtests_filter + \
   ['boot-serial-test',
    'drive_del-test',
diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index e85dec5a4e..bfa3b98cad 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -60,6 +60,7 @@ static testdef_t ppc64_tests_slow[] = {
 
 static testdef_t s390x_tests[] = {
     { "s390-ccw-virtio", "virtio-net-ccw" },
+    { "s390-ccw-virtio", "virtio-net-pci" },
     { NULL },
 };
 
-- 
2.55.0


