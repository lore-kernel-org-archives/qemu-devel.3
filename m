Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11A7CCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 20:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIu49-0000VD-Fs; Fri, 01 May 2026 16:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu3s-0000RH-Gw; Fri, 01 May 2026 16:02:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu3q-0000rr-Io; Fri, 01 May 2026 16:02:08 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6415nrTE1456647; Fri, 1 May 2026 20:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=E9ACmYlh9wDL1q7lQSckiLztF3rCg94xW/oVgs4NK
 kE=; b=hIGvpFyW3u2VzOUceHztZ6KYu8+TUjRgCjYEDI5VJfVfYrhivckqEsXqj
 howUl8NMuad+kBEkW0NOlDTDNdTvZgP8IcTSLKlKd47UNic8boQOQtzmyggyKsMx
 dbC+V5AGFC+CifWByZhBi60rnnn2OA8WcFfB5PWWwmmQaeJKYFmWoal8qTts84PQ
 DBmPnTPWj1lskVtsYkWBSloqksBpRovpk/KLXfZHI+Qu3j4vYt9T8plIYu5zJG2/
 C64viPPVnS5l0B86zpVKPiz8/n+vdOOyOHza6hOAAar4hPidh0xWh4Q55bVSMURD
 5Dtnfor+8CPoW4PEUkQoSsunbIJ6A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vv5wk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:01:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641Jrw2D001240;
 Fri, 1 May 2026 20:01:58 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5grt5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:01:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 641K1rig29229568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 May 2026 20:01:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4AEE58059;
 Fri,  1 May 2026 20:01:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9C2758043;
 Fri,  1 May 2026 20:01:52 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.25])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 May 2026 20:01:52 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: oelghoul@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com, clg@redhat.com
Subject: [RFC PATCH v1 0/5] s390x/pci: Improved zPCI Function Measurement
 Support
Date: Fri,  1 May 2026 16:00:21 -0400
Message-ID: <20260501200026.22784-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f506b7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=vVyIiItxORhcaOXRTgwA:9
X-Proofpoint-ORIG-GUID: dWyJgb2k8I8DwZENENMGtbVPUQD5Z6vn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5NSBTYWx0ZWRfX65lB2KxVa1rZ
 zC1Mh8MUM/hMDhJ4xr+q60uizbOWJUsMbLNJsglS1IdwpaAiJQFWJnlsaCNScAGDrPPcj/3HNNe
 pLE6Oj7NO6yhGLsAg+RcMxjA/hXkYzv2YSwNeFmfRdgvR5yUD3B775s6LDrXwXPEDDGrGfg28KM
 ILBg3/u5uFUSsl1NZwJib76MZLc33buMq8ItvQzBUBUMjqcUh2yTYbBg/2TZjHYk9zSqR0mYJij
 5Yeg4ArxPxhx8THH9ya0Efh7W7b+meV85/pGp3oRj9Fv0tabAspW0fJJ/6olu84NNPb171tnQoy
 JNvGaGji/a5Jjt9+jJGNlBg7FK4U+yxhzG/9Hu9ODoWjT+Lwx7kF+f1ygTBsx08ursywPybYpPx
 QY8r8hJGQFeJDS4QQy3O4dYZ3iwJn6J8hPBGWcKNYf40eTg59BDBWx3UNwlDXlBxi4MHydKsDJH
 PBrKxj1rRdAcDIV4rXQ==
X-Proofpoint-GUID: dWyJgb2k8I8DwZENENMGtbVPUQD5Z6vn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010195
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hi,

This patch series improves support for function measurement on s390x for
zPCI passthrough devices. It is dependent on the eponymous kernel patch
series linked below. [1]

Motivation
==========
The firmware on s390x machines allows for tracking a variety of statistics
relating to zPCI devices in a function measurement block (FMB). At the time
of writing, the kernel does not provide QEMU with a structured mechanism to
fetch the FMB of passthrough devices. QEMU also does not report the PFT to
the guest, which can cause issues with tools such as smc-rnics that depend
on the PFT to detect ISM and RoCE devices. Furthermore, the FMB itself can
take on different formats depending on the PFT, while QEMU's implementation
is limited to only the generic section that prefixes the format-specific
structures.

Proposal
========
The aforementioned kernel series proposes a VFIO feature that allows QEMU
to read the latest snapshot of the FMB. In this patch series, we propose
using that mechanism to share the FMB with the guest, as seen from the
host. We also inform the guest of the PFT and the FMB length as detected
from the host's CLP. Furthermore, we implement the format-0 FMB (DMA
counters) for virtio-pci devices.

I'd appreciate any comments on this approach.

Thanks in advance.

[1] https://lore.kernel.org/all/20260501192530.9429-1-oelghoul@linux.ibm.com/

Omar Elghoul (5):
  [do-not-merge] linux-headers: Add definitions for VFIO zPCI FMB
    passthrough
  hw/s390x: Clarified FMB format for emulated and passthrough devices
  hw/virtio: Add DMA counters for virtio-pci devices
  hw/s390x: Internal support for FMB passthrough
  hw/s390x: Report FMB passthrough and/or FMB DMA counters to the guest

 hw/s390x/s390-pci-bus.c          |  17 +++-
 hw/s390x/s390-pci-inst.c         |  65 ++++++++++++++-
 hw/s390x/s390-pci-vfio-stubs.c   |  16 ++++
 hw/s390x/s390-pci-vfio.c         | 133 ++++++++++++++++++++++++++-----
 hw/virtio/virtio.c               |  16 ++++
 include/hw/pci/pci_device.h      |   4 +
 include/hw/s390x/s390-pci-bus.h  |  29 ++++++-
 include/hw/s390x/s390-pci-vfio.h |   4 +
 include/hw/virtio/virtio.h       |   1 +
 linux-headers/linux/vfio.h       |  43 ++++++++++
 10 files changed, 301 insertions(+), 27 deletions(-)

-- 
2.52.0


