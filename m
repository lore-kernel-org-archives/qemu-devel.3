Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C60D4335A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTor2-0007mP-JR; Thu, 11 Dec 2025 17:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTor1-0007mD-78; Thu, 11 Dec 2025 17:09:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vToqz-0000q7-Ns; Thu, 11 Dec 2025 17:09:42 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBHYc8N029010;
 Thu, 11 Dec 2025 22:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=fKbvv7FdX9Z36rt+JkvqbhW/mX1NG7BWaz7D2rRo5
 yY=; b=Ikhr047DEeMaAg+kJe9hslmZirQUupFAozeIPI5tvu2Heg5A6dCipAZhj
 2yXdjUanvPyJY+AbHeqxWozHqV6W+nyBTP0vzzLre+ojicCf3YJqJAi52VTI0K2U
 9g7WCCfpZR7OV0MB+nC/EXhNffswzTBKkEsBFxdxyrZuvSTIdEZODZqwAcSPJkBL
 VnaN/NOcqHWw9vazrkZOJHSvIosMyeSYR5Fhn9TStjk3iWTmkOnTDyuxlqVYBdLc
 PIPDJY9qA7Onl2NqdTtnYxSRDtMJComv+IIyV4qTnu9gy86dD4THL+hkGn8SleWF
 CaCOcNijGosZiSR0EjgfYYmOaKFiQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww1t62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BBM9bK9024152;
 Thu, 11 Dec 2025 22:09:37 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww1t5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBIfhlM002031;
 Thu, 11 Dec 2025 22:09:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jrpw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:36 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BBM9ZL724183460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Dec 2025 22:09:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B80F658053;
 Thu, 11 Dec 2025 22:09:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0AC758059;
 Thu, 11 Dec 2025 22:09:34 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Dec 2025 22:09:34 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH 0/6] hw/ppc: Snapshot support for several ppc devices
Date: Thu, 11 Dec 2025 16:09:20 -0600
Message-ID: <20251211220926.2865972-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FMuypjIM2IugA0BhsAOvNKClJbo8SrpI
X-Proofpoint-ORIG-GUID: hgrz99hf74XkLjeyBt65_B5IxUkIRgmX
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=693b4122 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=pBNAg9uU81I9fobca8YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfXyRWQ2Gebq3ob
 qGIneWwZTPV78QlR3IwhtcSBpvf9tiHDsjsAY7TO7+uB8Vgyd/OLR7a6jQpE0fhVV9PcbKg9Rr3
 dFfsrRIMJUnFU37HlEAdlnXirnqFZPH9Jdo9TTBP7oUlWT5qPi2ZFZWXBW8tZ46Li3kGkqnznXS
 3+G9WqVVpEHSFIXkAb8K8OWVTTvif3GHWJKABa++NjvfHPG/Ek8TsUACH8EXq2ZM3GeV1bF5RHR
 KSvA+6WQDcmMVo6OwOuReVvW+BjRz5Ars3zwGcQZPIAZoKELNlM5intJ4fsTuGJYVe2DUXqJ9y0
 w5hcEimhprT0+a0XUhcfXJCNKY0A1erXrhkgashJhu2inPp4KO+Fp7pQtdK9jcUHN0im45pib/C
 co9Q8NGlpkeq+/amLJUuUkvopq6OGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add snapshot support for several ppc devices for the powernv machines.

* Adding LPC, ADU, SPI, I2C, core, and chipTOD

No specific ordering of the patches as this is ongoing development to
support the PowerVM team. Additional patches for other (non-ppc) devices
will be coming in separate patch submissions.

Thanks,
Caleb

Michael Kowal (1):
  hw/ppc: Add VMSTATE information for LPC model

Caleb Schlossin (2):
  hw/ppc: Add pnv_spi vmstate support
  hw/ppc: Add pnv_i2c vmstate support

Angelo Jaramillo (3):
  hw/ppc: pnv_adu.c added vmstate support
  hw/ppc: pnv_core.c add vmstate support
  hw/ppc: pnv_chiptod.c add vmstate support
  

 hw/ppc/pnv_adu.c             | 12 +++++++++++
 hw/ppc/pnv_chiptod.c         | 38 +++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c            | 22 ++++++++++++++++++++
 hw/ppc/pnv_i2c.c             | 11 ++++++++++
 hw/ppc/pnv_lpc.c             | 39 ++++++++++++++++++++++++++++++++++++
 hw/ssi/pnv_spi.c             | 27 +++++++++++++++++++++++++
 include/hw/ppc/pnv_chiptod.h |  2 ++
 7 files changed, 151 insertions(+)

-- 
2.47.3


