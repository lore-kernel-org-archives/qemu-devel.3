Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0678DC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x29pT-0000uM-94; Thu, 03 Sep 2026 11:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x29pR-0000tP-OJ; Thu, 03 Sep 2026 11:58:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x29pP-0006rE-K4; Thu, 03 Sep 2026 11:58:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683DVWpY3109019; Thu, 3 Sep 2026 15:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=AZKZxZ7BNJRDpIHHSROWB4fNoUlNBSOodgjnvR87v
 cU=; b=AsJjkAN+e2FeZV/I3TGztQjexoqM4oUv9WjusIdX8vreYv4grgP6UrJD6
 CMzhMtWvHhQnmYBwpONuZ8NsmxBaH/v6DaWAnwQQynfrlOiaUi/V0S+qI8Z/zd9u
 h5UK8xdOHIrXTaAiuxfnu71MVNt/UuSlBy+4m21LFpcshLA3AaNp2AUKVINNwcrg
 WJS/9yQyA89px5m4KzICBRL2ItibIdf+JZhO4NrJs9VHMYhFQ66JkNqMAWi6FyXn
 +SHfDVz8RYv9kKkXANYjQX1YoMJMZWOQkvbGx7JM8uJlDDDUZuHXI/Yv0wN9x8Jj
 HqqwEyoefjc/saQ8871dJhKTzdSug==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5wr7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 15:58:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683FuKf4032007;
 Thu, 3 Sep 2026 15:58:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygr6st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 15:58:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683Fw5Jp43319620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 15:58:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9DFB20043;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E1CF20040;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id 7DE0E160A8D; Thu, 03 Sep 2026 17:58:05 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, jdaley@linux.ibm.com
Subject: [PATCH v3 0/3] Extend secure IPL support to virtio-blk-pci boot
 devices
Date: Thu,  3 Sep 2026 17:58:02 +0200
Message-ID: <20260903155805.1881366-1-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a999912 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=__IoPmQZGUIikFOuX7oA:9
X-Proofpoint-GUID: MwBKZTQ21wCGztgz8UOm194wTzneNNpG
X-Proofpoint-ORIG-GUID: MwBKZTQ21wCGztgz8UOm194wTzneNNpG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEzNSBTYWx0ZWRfX7jjdUkRo96Y9
 1IGBgbaLx4DQmpwcedgDyAPvL1RUkoTfRGHIuSnVbtdtChDGp70lduTWms5pAhk8te62jIQiLFy
 0UtPnDNC9sVthRhcpnpd+hKtewFPU5M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEzNSBTYWx0ZWRfX9hB4F7idcWlI
 1tO5OWeEXT4v0B7D2yCygCDZVQTiN7DpdVp5wgGD1czregZRzToxOzXcnpy8V0zc1JgwuD6v1p7
 0pq5psDqbVbPLC94F8+nX2npptGJ/ZrcBYTeY+pCiBeBoZbPZrDzu9tyAruRvsPYjKq2oPaGSG/
 KEqVieIY5pxvOaMKRaOpTphlR7Q1lXqK6WZ3q3YQ2bvFzDoLI25kTY2mJV2kfBMEa8SKGZbtu56
 JhuO/VSOWP7ucksnsgzv6A4DR5MLAFiqP3h9D+AV7Is5DlY8K4nGItL1yMgI60pLNlhgtzcRvC6
 z3G0pUNnGujAbzpLfgIdVaSX6wrJd3COaK0AaL1WaIndl60RcUZ7cI3WfPeiOJx+vDG1yi69PE4
 vKP0zl9djbFBbSFqNInyUVwGMkoKicrNorhzR0x3hj4cGWrZzUgqu5MF14c5MCFNwSNSq9LwFB8
 jcK1Km5Oi0KMw9K9VbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jdaley@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Changes v2 -> v3:

- Patch 3:
   Added _host_lacks_sipl_support flag to skip vm setup if
   we've already found that the host does not support SIPL.

---

v2 cover letter:

Changes v1 -> v2:

- Added RB tags to patches 1 & 2
- Patch 3:
   The setup step is now run only once, as originally intended.
   setUpClass and tearDownClass manage a shared workdir for the
   subtests to use. Instance vars are now class-level vars.

---

v1 cover letter:

This series is based on Zhuoying Cai's series,
"[PATCH v17 00/34] Secure IPL Support for SCSI Scheme of virtio-blk/virti=
o-scsi Devices"
https://lore.kernel.org/qemu-devel/20260730214624.2328883-1-zycai@linux.i=
bm.com/

Note, the above series is based on Cornelia Huck's patch,
"[PATCH for-11.2] hw: add compat machines for 11.2"
https://lore.kernel.org/qemu-devel/20260723163806.368127-1-cohuck@redhat.=
com/
which requires a small fix to apply (see Eric Farman's reply).

---

To add support for secure IPL with a virtio-blk-pci boot device, we simpl=
y
write secure boot flags to the IPLB when using such a boot device.
This is achieved by calling s390_apply_secure_boot() in the PCI boot
device case of s390_build_iplb().

The secure IPL functional verification test is updated with an additional
subtest for the virtio-blk-pci boot device case. To run the FVT:

  make check-functional-s390x MTESTARGS=3D"func-s390x-secure_ipl" \
  QEMU_TEST_ALLOW_LARGE_STORAGE=3D1

To test secure IPL yourself, view the "Secure IPL Quickstart" guide in:
docs/system/s390x/secure-ipl.rst

Joshua Daley (3):
  hw/s390x/ipl: Add secure boot support to PCI dev IPLB builder
  tests/functional/s390x/test_secure_ipl: Skip test if SIPL not
    supported by hypervisor
  tests/functional/s390x/test_secure_ipl: Add virtio-blk-pci boot dev
    case

 hw/s390x/ipl.c                            |   8 +-
 tests/functional/s390x/test_secure_ipl.py | 157 ++++++++++++++++------
 2 files changed, 116 insertions(+), 49 deletions(-)

--=20
2.34.1


