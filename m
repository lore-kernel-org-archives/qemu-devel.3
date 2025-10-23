Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDF3CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtkD-0001FU-0u; Thu, 23 Oct 2025 07:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtk9-0001Ec-Uf
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtk7-0001ZD-PP
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7SBpn011630
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=lF9ayyK4Y+CGn5OGK6ljEp8yPxYv
 WKH1w2ZyxYCV4zA=; b=pmmgOUDdjhGvayVy5GqilkQxqmS7w/F8RD2ljqmrKxxk
 tFvOLZlgRn8G0P3fCjAp0WbC0iRkEM1X12VmuGS/YTbtE/hZ37DPongXOAkY5ATj
 OW+uNB5UJEd2lTZMNc+lWnn1IVpGBAZJxcpKfFaJd99vuBcPe4gud9T2rjk48ECu
 kWR3qUYkKtJ2WooqxEr7G4md88OHhqkHfw4wtDbWsEVQLVwmotgoT/ANmFDQ7QdY
 XI3KONxM+ZOHsAFtqUYCb19iqIAE7oDXz7jYLMSM9wHfhRDTAYNdZQxxzElMma7U
 8+CnnYz7EaTMrtBnzT0MiQw8m8UXEKhTn7yTN5RJNA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgj1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:44:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAhERA002320
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:44:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejn9v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:44:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBiR7636897080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:44:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA23F20049
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:44:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 542D120040
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:44:27 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:44:27 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] ppc-for-10.2 queue
Date: Thu, 23 Oct 2025 17:13:47 +0530
Message-ID: <20251023114422.3675018-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QuAvMs7AQk5z2lJ0TbZZqTBGOZvIR4bE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9a2/N8w/o52x
 JF9ksGdk8FfoKGdmGxlPrwKTIQTDzuDTr24fk9pTo600yEy75UP0r7ZSQq0D9CaeusAsyB21wKe
 uD6qoPhMpOfmzy1ORPDUhDZHUq9c8PI27sNRh63uzJeQE0k11diLN/6iaw+tAosODrLMv1aldfV
 6pVuuL6yqe1L1bD3scVsw/VoOF30ZmQWW32IrAlTk0K5KzgKoy5o/CEcLSH0CpIVERzzVz8c1UC
 j9ve+wH7lHoYpqMgunuyeh02fpitrwx1/u4uh4gFeZZOSity/RIhniZVRI0eKN0QsuUSIADCClK
 sOoilzmC2KkGigPrRbahDiYXGEyfQEnWyDCzhKt/DAhS1Sc7Yu4w7ZJabkn5lUj8KIpXg8JbgHa
 m2B79V1SnqXDA/zfXl4oI33mghYvVA==
X-Proofpoint-GUID: QuAvMs7AQk5z2lJ0TbZZqTBGOZvIR4bE
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa151e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8
 a=1LGeStAcr6Diqoz3mFYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:

  Merge tag 'pull-vfio-20251022' of https://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-10.2-d2-20251023

for you to fetch changes up to 5191104c18f44c8d04180ed4959ec97323d906f5:

  MAINTAINERS: Add entry for FADump (pSeries) (2025-10-23 16:37:04 -0400)

----------------------------------------------------------------
ppc queue for 10.2

* FADUMP Support for pSeries
* Pegasos II cleanup and Pegasos I emulation
* Deprecation of pseries 3.0 up till 4.2
* Coverity fix for amigaone (CID: 1641398)

----------------------------------------------------------------
Aditya Gupta (8):
      hw/ppc: Implement fadump register command
      hw/ppc: Trigger Fadump boot if fadump is registered
      hw/ppc: Preserve memory regions registered for fadump
      hw/ppc: Implement saving CPU state in Fadump
      hw/ppc: Pass dump-sizes property for fadump in device tree
      hw/ppc: Enable fadump for PSeries
      tests/functional: Add test for fadump in PSeries
      MAINTAINERS: Add entry for FADump (pSeries)

BALATON Zoltan (13):
      ppc/amigaone: Free allocated struct
      ppc/vof: Make nextprop behave more like Open Firmware
      hw/ppc/pegasos2: Remove explicit name properties from device tree
      hw/ppc/pegasos2: Change device tree generation
      hw/ppc/pegasos2: Remove fdt pointer from machine state
      hw/ppc/pegasos2: Rename mv field in machine state
      hw/ppc/pegasos2: Add south bridge pointer in the machine state
      hw/ppc/pegasos2: Move PCI IRQ routing setup to a function
      hw/ppc/pegasos2: Move hardware specific parts out of machine reset
      hw/ppc/pegasos2: Introduce abstract superclass
      hw/ppc/pegasos2: Add bus frequency to machine state
      hw/ppc/pegasos2: Add Pegasos I emulation
      hw/ppc/pegasos2: Add VOF support for pegasos1

Harsh Prateek Bora (5):
      ppc/spapr: remove deprecated machine pseries-3.0
      ppc/spapr: remove deprecated machine pseries-3.1
      ppc/spapr: remove deprecated machine pseries-4.0
      ppc/spapr: remove deprecated machine pseries-4.1
      ppc/spapr: remove deprecated machine pseries-4.2

Philippe Mathieu-Daudé (6):
      hw/ppc/spapr: Remove SpaprMachineClass::nr_xirqs field
      hw/ppc/spapr: Inline spapr_dtb_needed()
      hw/ppc/spapr: Inline few SPAPR_IRQ_* uses
      target/ppc/kvm: Remove kvmppc_get_host_serial() as unused
      target/ppc/kvm: Remove kvmppc_get_host_model() as unused
      hw/ppc/spapr: Remove SpaprMachineClass::phb_placement callback

 MAINTAINERS                               |   9 +
 include/hw/ppc/spapr.h                    |  27 +-
 include/hw/ppc/spapr_fadump.h             | 124 +++++
 include/hw/ppc/spapr_irq.h                |   1 -
 target/ppc/kvm_ppc.h                      |  12 -
 hw/ppc/amigaone.c                         |   2 +-
 hw/ppc/pegasos2.c                         | 769 +++++++++++++++---------------
 hw/ppc/spapr.c                            | 368 +++++---------
 hw/ppc/spapr_caps.c                       |  12 +-
 hw/ppc/spapr_events.c                     |  20 +-
 hw/ppc/spapr_fadump.c                     | 730 ++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c                      |   5 -
 hw/ppc/spapr_irq.c                        |  36 +-
 hw/ppc/spapr_pci.c                        |  32 +-
 hw/ppc/spapr_rtas.c                       |  76 +++
 hw/ppc/spapr_vio.c                        |   9 -
 hw/ppc/vof.c                              |  50 +-
 target/ppc/kvm.c                          |  11 -
 hw/ppc/meson.build                        |   1 +
 pc-bios/dtb/meson.build                   |   2 +
 pc-bios/dtb/pegasos1.dtb                  | Bin 0 -> 857 bytes
 pc-bios/dtb/pegasos1.dts                  | 125 +++++
 pc-bios/dtb/pegasos2.dtb                  | Bin 0 -> 1701 bytes
 pc-bios/dtb/pegasos2.dts                  | 167 +++++++
 tests/functional/ppc64/meson.build        |   2 +
 tests/functional/ppc64/test_fadump.py     | 182 +++++++
 tests/functional/qemu_test/linuxkernel.py |  59 +++
 27 files changed, 2042 insertions(+), 789 deletions(-)
 create mode 100644 include/hw/ppc/spapr_fadump.h
 create mode 100644 hw/ppc/spapr_fadump.c
 create mode 100644 pc-bios/dtb/pegasos1.dtb
 create mode 100644 pc-bios/dtb/pegasos1.dts
 create mode 100644 pc-bios/dtb/pegasos2.dtb
 create mode 100644 pc-bios/dtb/pegasos2.dts
 create mode 100755 tests/functional/ppc64/test_fadump.py

