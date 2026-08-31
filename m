Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2658AC624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16nd-0001cr-WF; Mon, 31 Aug 2026 14:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x16nZ-0001bu-AS; Mon, 31 Aug 2026 14:32:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x16nX-0001vU-D9; Mon, 31 Aug 2026 14:32:01 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVulN1235525; Mon, 31 Aug 2026 18:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=frCaMr2YGuQAhq9fnBCTBllM2PjUTrtZPkuiWOW90
 SE=; b=EDpIUI+jYAo3uGIdVOZX6wELfhZcWBWigQik4HN6zcjnxxCbW0osBNXvE
 /rNbICaFVLA3LzEZkf4AY7ALG9AGdPBHN9F+P2V9AfKoTD/hZRyjcKgd+tB7MPQS
 fanNZWENptX6XprZei2GIpcgWMZrh9JtMCQ6q4dkSB1h9iekSDLp/nBh4vZQhJH8
 SBHE9MUhZiGWqmtFJo7arRvTVlmaoFINS2GG8ffkwLdZhnJ4ICgwIXlxEfj97OaS
 3y/RClm6yfOtW+s69DbwVC39/LLcyB3XbVASdeJHefGwpeP48vma+My6bZsRWUxA
 M6bt3g3Q3AkJbqF58So3b/6JKBcbw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r34cn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:31:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VIU8RV018883;
 Mon, 31 Aug 2026 18:31:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq7m9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:31:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VIVroN24576610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 18:31:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 205B55805F;
 Mon, 31 Aug 2026 18:31:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A2945805A;
 Mon, 31 Aug 2026 18:31:52 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.20])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 18:31:51 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com, armbru@redhat.com
Subject: [PATCH v4 0/4] Error recovery for zPCI passthrough devices
Date: Mon, 31 Aug 2026 11:31:47 -0700
Message-ID: <20260831183151.12626-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a95c89b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=VnNF1IyMAAAA:8
 a=jPNWSg8WF9iJXmU8qocA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfXwXH7ZJcvo4Pm
 7bKW6RY5BS/7S665z8NEDLC6a8O5jk64T+j/8AAZt+qJG/zCdSjuYFFR/LyyKYHEQVrxAOH83Rq
 u7CTHJR8oV7NZ7Qfq9nP6x+d3mPxTgPQiufPpAJp3OYdRJ8leoyuYvOAX4T83zvr7HGrrMYtgSc
 inZRYOuIvTxp36PhUwkQTGdsD1ydp6BVw+HOqwKJ7C9ux3iiJ8mdcpWYF7H0bdsXAi9BrvDcVtG
 ff62lqEeIhpFt4tjjD03yrQB7laJdRrAgsuUqW3za+HdROsEFC01mxl9KBPeyDOg04etSk/XxY0
 t2GHmWAAtv9+DzkKK7N785tfMl8tPjEcOqg+JxhsyodhzXR6e2KFdQi6YrPPGY4zNHF94H7LFJA
 0XvGV6NGOXcadi4MdlIgCzfQLZVtC7jPlA2Sm5F5X3f3gHsrg9rItk3ixKrB3XwxiVN/Bi8gkjL
 /IUKsltEcFZZHGtvIKg==
X-Proofpoint-GUID: u6nYi3pJAS0DNkobyOb0Jz8LP_SP0zbv
X-Proofpoint-ORIG-GUID: u6nYi3pJAS0DNkobyOb0Jz8LP_SP0zbv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfXwiT27YOofOnA
 lYmpBECyD26F1cJlnh522Bn/tRnZXdfydt6r9kK/h5T13I3lJ70EXZaO2YjwaiuGT5Wlk53LwOL
 PGfQ/wmKM9DOqJcsFa4f4F7vg43BKRM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310160
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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

Hi,

This patch series introduces support for error recovery for passthrough PCI
devices on System Z (s390x). This is the user space component for the Linux
kernel patches [1]. The kernel patches were merged for 7.3 and it had some
significant changes in VFIO API since the last QEMU series was posted. But the
design for QEMU component is still the same.

For QEMU on eventfd notification for PCI error from vfio-pci driver we call the
vfio error handler. We can use a per device error handler callback to override
the default vfio error handler.  For s390x specific error handler, we retrieve
the architecture specific PCI error information and inject the information into
the guest. Once the guest receives the error information, the guest drivers will
drive the error recovery.  Typically recovery involves a device reset which
translate to CLP disable/enable cycle for the device.

I would appreciate some feedback on this patch series.

Thanks 
Farhan

[1] https://lore.kernel.org/all/20260818164326.387bb27b@shazbot.org/

ChangeLog
---------
v3 https://lore.kernel.org/qemu-devel/20250925174852.1302-1-alifm@linux.ibm.com/
v3 -> v4
    - Include linux headers for 7.3-rc1.
    - Rework VFIO API changes based on the kernel API (patch 3).
    - Address Markus's comments from v3 (patch 2).

v2 https://lore.kernel.org/qemu-devel/20250825212434.2255-1-alifm@linux.ibm.com/
v2 -> v3
    - Update arch_err_handler to err_handler and include Error ** in
    function definition. (patch 2)

    - Introduce helper function to hide the internal indirection of device_feature()
    (patch 3)

    - Update function definitions to include Error ** (patch 4)
    


v1 https://lore.kernel.org/qemu-devel/20250813174152.1238-1-alifm@linux.ibm.com/
v1 -> v2
   - Use VFIO_DEVICE_FEATURE ioctl to get device error information.
   (Based on Alex's feedback on kernel series)

Farhan Ali (4):
  linux-headers: Update Linux header to 7.3-rc1
  vfio/pci: Add an error handler callback
  s390x/pci: Add PCI error handling for vfio pci devices
  s390x/pci: Reset a device in error state

 hw/s390x/s390-pci-bus.c                     |  16 ++
 hw/s390x/s390-pci-vfio-stubs.c              |  10 +
 hw/s390x/s390-pci-vfio.c                    | 110 +++++++++++
 hw/vfio/pci.c                               |  27 ++-
 hw/vfio/pci.h                               |   1 +
 include/hw/s390x/s390-pci-bus.h             |   2 +
 include/hw/s390x/s390-pci-vfio.h            |   2 +
 include/standard-headers/drm/drm_fourcc.h   | 209 ++++++++++++++++++--
 include/standard-headers/linux/ethtool.h    |   6 +
 include/standard-headers/linux/fuse.h       |  63 +++++-
 include/standard-headers/linux/virtio_ids.h |   1 +
 linux-headers/asm-arm64/kvm.h               |   1 +
 linux-headers/asm-riscv/kvm.h               |  13 ++
 linux-headers/linux/iommufd.h               |  45 ++++-
 linux-headers/linux/kvm.h                   |   1 +
 linux-headers/linux/userfaultfd.h           |  54 ++++-
 linux-headers/linux/vduse.h                 |  28 +++
 linux-headers/linux/vfio.h                  |  21 ++
 linux-headers/linux/vfio_zdev.h             |   2 +
 19 files changed, 579 insertions(+), 33 deletions(-)

-- 
2.43.0


