Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C382DC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 16:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg5Zv-0002lJ-IJ; Fri, 01 Mar 2024 11:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rg5Zp-0002hw-Bi; Fri, 01 Mar 2024 11:17:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rg5Zn-000224-07; Fri, 01 Mar 2024 11:17:37 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 421FvGPu032645; Fri, 1 Mar 2024 16:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9UsPZRSI05lwvGd1PFe2h74P4zK+cs8wuH2mhf6Ofso=;
 b=lhtlfChEaooqH84g5Ogh63QGigRCXYRtX8BiNXCQvPvGKQEk6OhnosTQO06uSpvGB8Vu
 CV6ldFFltqTSksQj6a5GQ8yo6qIARlRSGgieyABJsDI/7XwaojO1nVIStfzQFmf5uWSp
 Ux4dpWsIajVPBn2dBpD2G01UnSXqMkmi+pH+oYf9fRCyzdZxGyBG0z5dVuDr6YHmf7T0
 g3Rr42AJxqUtsd+R8YcMd519GJ1GOPZh4OfO+cmy61bz/mmSPGGMo7MvCz3sr3SOiqcr
 9ijRBKyPuWNX1iaUZeIhoNLrovT9Fz4OeiLXGmdyl1dAF6p2S/hOleCApFKC0SXbKh18 WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkj3y8rv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Mar 2024 16:17:28 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 421FvU5K002159;
 Fri, 1 Mar 2024 16:17:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkj3y8run-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Mar 2024 16:17:28 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 421Eak9Y021316; Fri, 1 Mar 2024 16:17:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfuspnfk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Mar 2024 16:17:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 421GHMBs7995862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Mar 2024 16:17:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C576320040;
 Fri,  1 Mar 2024 16:17:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA23B2004B;
 Fri,  1 Mar 2024 16:17:20 +0000 (GMT)
Received: from [9.43.5.155] (unknown [9.43.5.155])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Mar 2024 16:17:20 +0000 (GMT)
Message-ID: <2aef5ff8-bdae-437e-892b-25e4fe684335@linux.ibm.com>
Date: Fri, 1 Mar 2024 21:47:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] hw/ppc: SPI model
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
References: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JcmD8-CBt3y-FqSZamvtdTAB4txLrWXN
X-Proofpoint-GUID: DwQ2kcBY4G9DBvyzt2exsJxXiD_gaAdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_17,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1
 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 phishscore=0 spamscore=1 mlxlogscore=212 mlxscore=1 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010135
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

I would greatly appreciate the review comments/suggestions on PATCH V1.

Thank You and Regards,

Chalapathi

On 07-02-2024 21:38, Chalapathi V wrote:
> Hello,
>
> In this series of patchset, SPI controller and responder models
> for Power10 processor are modelled.
>
> Serial peripheral interface provides full-duplex synchronous serial
> communication between single controller and multiple responder devices.
>
> The current configuration supports a single SPI controller reside on the
> SPI bus. In p10, SPI controller device model supports a connection to a
> single SPI responder such as SPI seeproms, TPM, flash device and an ADC
> controller.
>
> SPI controller model is divided into configuration unit, sequencer FSM
> and shifter engine. All SPI function control is mapped into the SPI register
> space to enable full control by firmware.
>
> SPI configuration component is modelled which contains all SPI configuration
> and status registers as well as the hold registers for data to be sent or
> having been received.
> Shift engine performs serialization and de-serialization according to the
> control by the sequencer and according to the setup defined in the
> configuration registers.
> Sequencer implements the main control logic and
> FSM to handle data transmit and data receive control of the shift engine.
>
> Microchip's 25CSM04 SEEPROM device is modelled and connected to SPI bus
> "spi_bus2" of SPI controller "PIB_SPIC[2]".
>
> Patches overview in V1.
> PATCH1: Create a SPI responder model which includes responder methods
>          and SPI bus implementation.
> PATCH2: Create a SPI controller model and implement configuration unit
>          to model SCOM registers.
> PATCH3: SPI controller model: implement sequencer FSM and shift engine.
> PATCH4: create SPI SEEPROM model.
> PATCH5: Connect SPI controllers to p10 chip and create keystore seeprom
>          device on spi_bus2 of PIB_SPIC[2].
>
> Thank You,
> Chalapathi
>
> Chalapathi V (5):
>    hw/ppc: SPI responder model
>    hw/ppc: SPI controller model - registers implementation
>    hw/ppc: SPI controller model - sequencer and shifter
>    hw/ppc: SPI SEEPROM model
>    hw/ppc: SPI controller wiring to P10 chip and create seeprom device
>
>   include/hw/ppc/pnv_chip.h           |    4 +
>   include/hw/ppc/pnv_spi_controller.h |  101 ++
>   include/hw/ppc/pnv_spi_responder.h  |  109 ++
>   include/hw/ppc/pnv_spi_seeprom.h    |   70 ++
>   include/hw/ppc/pnv_xscom.h          |    3 +
>   hw/ppc/pnv.c                        |   32 +
>   hw/ppc/pnv_spi_controller.c         | 1609 +++++++++++++++++++++++++++
>   hw/ppc/pnv_spi_responder.c          |  166 +++
>   hw/ppc/pnv_spi_seeprom.c            |  989 ++++++++++++++++
>   hw/ppc/meson.build                  |    3 +
>   10 files changed, 3086 insertions(+)
>   create mode 100644 include/hw/ppc/pnv_spi_controller.h
>   create mode 100644 include/hw/ppc/pnv_spi_responder.h
>   create mode 100644 include/hw/ppc/pnv_spi_seeprom.h
>   create mode 100644 hw/ppc/pnv_spi_controller.c
>   create mode 100644 hw/ppc/pnv_spi_responder.c
>   create mode 100644 hw/ppc/pnv_spi_seeprom.c
>

