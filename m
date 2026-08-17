Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3183FC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2VF-0001T3-RC; Mon, 17 Aug 2026 14:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VE-0001Sk-ST
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VC-000637-7L
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:08 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVh9D2076194; Mon, 17 Aug 2026 18:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=8cXgxb/r552oW8+fJbNR7IyWCZc/
 ssgQScB0dQ1/xbk=; b=WVA2i0uVWuJw3ZrtX9zgrT9cTaFnfXEcZ/d2pzYjNbOz
 SIfyNY/W+myy67mCDaGGoOC2kzcu36tgdGMG9P56+MLjWN8L0/M0OIpyaGZPfk5g
 nCBRb4qmRPji0zwn6XXq5uW7nX5EbLDA6NLimXMHdkqh6TAqObVBw7ECC2sdH9iX
 emjDoksjQWacjiMfBN8vpsCGjG+Tnq7tdKa06XeAp+M+iSYWsWNy5o9AY2aVzUQQ
 JkuMKRvCVWSGkAZ7uOxYiybUHEO8hd+3/YbYnUIGvTAut/PW5MDA5lawUtudqKTV
 KQIhab1v4XK+6+uuQlwaZ9A5q6YfJCBa5W/E3YJfbg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkusg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:55:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HIfUL4002835;
 Mon, 17 Aug 2026 18:55:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng73f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:55:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HIti7338404532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 18:55:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 793DE20043;
 Mon, 17 Aug 2026 18:55:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4972C20040;
 Mon, 17 Aug 2026 18:55:41 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com.com (unknown
 [9.124.209.12]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 18:55:41 +0000 (GMT)
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, philmd@linaro.org, farosas@suse.de,
 akihiko.odaki@daynix.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 00/10] tests/qtest: pci and MSI-X fixes
Date: Tue, 18 Aug 2026 00:25:30 +0530
Message-ID: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX45CzqtmjQia/
 4UZ1X0OYkyps1/o5snSOHtQmdRxy4aG0tHSugxkH1FWebncjkd2YG5NzIeljZmUMZU0rkLyq996
 vMYkxW0Q9uQxzSSGS45DRqUnMKHmXTcHEScNF87KrjDtUbfRUZh4BVfHYrvBLJOSvne+N0fEVQa
 cj3EwLQFx4xU+ebkh+17tEAqjgEuydt/BkCpVgqqqbIa/AL/98cWywyT9OXBXs5VnvlGMK4RHTb
 EShk5mO2oib9cZCSTwE7IRKLrLK3VCK+kZMxAwe5kHrTzW4SdTwPFN2UoFrzMtrJl/HQjX2XLNI
 ONil8wpbV8wjc2TUCvZt94K4+dQhZq7OeoawxP1VKWUtubLJ5Llq5EgGLEKEOV2svvEIpLNod5k
 zpURou9eV0SQD2ipAxr5oxeTHeUurWcxo789HKxsul5MfPOShPQ+dT9pPTUj3MG3p+drOmjo3gn
 ksqEKX37Fu3qyPk2Tvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX301DEOeQIx7a
 iDOt/9DVgg0sGezrsRviF1rDjOyLGoNVkRE6/Hj/74yWHOYPn9hln5W5Ksb8QT9olnB1q4eS9hD
 06ZpzuMQ0bhSyuOjOzSbh8U5nWgoHxw=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a835935 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=z4glEzOvAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=nZqQnNJBUmdCMqt5T2gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-ORIG-GUID: OLyxFyi_OqBwo1b-dM5Mg4m1qxkzu86f
X-Proofpoint-GUID: 2CNw_O8XP0PL9kZNRwTwWw8gr-BlaeEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170142
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=jishnuvw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>

This series fixes a number of issues in the pci and MSI-X qtest
infrastructure, and adds new functionality.

Nicholas Piggin is the original author of all patches in this series.
This submission takes his v5 posting forward, with the additional
changes described below.

It was originally posted as v5 in May 2025 but was not merged.

Changes since v5
(https://lore.kernel.org/qemu-devel/20250502030446.88310-1-npiggin@gmail.com/):

- Use sizeof(data) instead of literal 4 in qtest_memread/qtest_memset
  calls inside qpci_msix_test_interrupt() [Akihiko Odaki]

- Fix MSI-X capitalisation in the qpci_msix_test_interrupt() doc
  comment (was "msix", now "MSI-X" throughout) [Akihiko Odaki]

- Replace the per-device boolean flags (pci_enabled in AHCIQState,
  enabled in QVirtioPCIDevice) with a bool mapped field on QPCIBar
  itself. qpci_iounmap() is now a graceful no-op when called on a
  bar that was never mapped, removing the need for guards in callers.
  [Akihiko Odaki]

- Remove missed qpci_check_buggy_msi() guard in nvme-test.c

- Fix off-by-one bound check: use barno < QPCI_NUM_REGIONS instead of
  barno <= QPCI_NUM_REGIONS in qpci_bar_reg() and qpci_iomap(); the
  previous condition allowed barno == 6 which is one past the end of
  the 6-element array [Amit Machhiwal]

- Remove redundant memset(&dev->bars_mapped[i], ...) in qpci_iounmap()
  that immediately followed dev->bars_mapped[i] = false [Amit Machhiwal]

- Add explanatory comment before the msix_addr/msix_data != 0
  assertions in qpci_msix_test_interrupt() clarifying that 0 is a
  libqos-internal sentinel value [Amit Machhiwal]

- Remove always-true g_assert_cmpint(entry, >=, 0) assertions on
  uint16_t parameters in qpci_msix_set_entry(), qpci_msix_pending(),
  qpci_msix_masked(), and qpci_msix_set_masked() [Amit Machhiwal]

Nicholas Piggin (10):
  tests/qtest: Enforce zero for the "un-fired" MSI-X message value
  tests/qtest: Fix virtio MSI-X message endianness
  tests/qtest: Add libqos function for testing MSI-X interrupt status
  tests/qtest: Enable spapr dma with linear iommu map
  tests/qtest/ahci: unmap pci bar before reusing device
  tests/qtest/ahci: don't unmap pci bar if it wasn't mapped
  tests/qtest/libquos/pci: Add migration fixup helper for pci devices
  qtest/libqos/pci: Enforce balanced iomap/unmap
  qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
  qtest/libqos/pci: Factor MSI-X entry helpers into pci common code

 hw/ppc/spapr_iommu.c                   |  10 +-
 tests/qtest/ahci-test.c                |   8 +
 tests/qtest/e1000e-test.c              |  21 ---
 tests/qtest/igb-test.c                 |  21 ---
 tests/qtest/libqos/ahci.c              |  12 ++
 tests/qtest/libqos/ahci.h              |   2 +
 tests/qtest/libqos/generic-pcihost.c   |   1 -
 tests/qtest/libqos/pci-pc.c            |   3 -
 tests/qtest/libqos/pci-spapr.c         |   7 +-
 tests/qtest/libqos/pci.c               | 215 ++++++++++++++++++++++---
 tests/qtest/libqos/pci.h               |  21 ++-
 tests/qtest/libqos/virtio-pci-modern.c |  30 +---
 tests/qtest/libqos/virtio-pci.c        |  86 ++--------
 tests/qtest/nvme-test.c                |   4 -
 tests/qtest/vhost-user-blk-test.c      |   6 -
 tests/qtest/virtio-blk-test.c          |  12 --
 16 files changed, 262 insertions(+), 197 deletions(-)

-- 
2.55.0

