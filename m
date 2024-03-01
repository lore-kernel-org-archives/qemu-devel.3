Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CC8C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7iF-00033F-DE; Fri, 01 Mar 2024 13:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rg7hx-0002Yc-Ol; Fri, 01 Mar 2024 13:34:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rg7ht-0008Tc-Qz; Fri, 01 Mar 2024 13:34:08 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 421IHKGm016830; Fri, 1 Mar 2024 18:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : mime-version : subject : to : cc : references : from :
 in-reply-to; s=pp1; bh=4PbI+9VO20IMypAuJjo9WzKMSYaaVfjtyM2iTUAn9sU=;
 b=QNCuQRHr/m1/LVKSzkmQ0O92yIzBvfNYfNf0hiv3Gft4Y10YK0UPegDc27cOn5oHUtjw
 KjKPDUJ+zoZwhjiZ5B5ebFIesz6vkkONigKUi5Jly5UjTceVjQnFacEfXKuPLGKCOX9y
 hR7KnE/Gju/ad/XEi/nefxZi0pfOVvxCkmu2EmBkb9SosKxa/vflX1UR0m2dWsgCM1zO
 h17ViP/H61jIP6rsvL74HnvrT9q5TaG/cJXGIu26gbrBP+rYEVx4QQvkxJRUVLju4fgR
 uB8FBI5HOGw9FK09+kdZv16HQsg4LJ2lh2B6ZVkJmZPk0j0Q/kRFURng3Oj5mUfUtJe7 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkm5j8byf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Mar 2024 18:33:55 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 421IKHaN025672;
 Fri, 1 Mar 2024 18:33:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkm5j8bxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Mar 2024 18:33:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 421Hcxd0008170; Fri, 1 Mar 2024 18:33:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mx3ue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Mar 2024 18:33:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 421IXnjf55837110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Mar 2024 18:33:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75E272004D;
 Fri,  1 Mar 2024 18:33:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5123A20040;
 Fri,  1 Mar 2024 18:33:47 +0000 (GMT)
Received: from [9.43.5.155] (unknown [9.43.5.155])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Mar 2024 18:33:46 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------7xzeBfk3PKS8FCDzzwZWfE4j"
Message-ID: <e732e024-093e-40c3-93ca-0592eb620319@linux.ibm.com>
Date: Sat, 2 Mar 2024 00:03:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] hw/ppc: SPI model
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com
References: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
 <2aef5ff8-bdae-437e-892b-25e4fe684335@linux.ibm.com>
 <9dd1a7fe-4d28-4d2d-b43e-07eeaf2c6b1d@kaod.org>
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <9dd1a7fe-4d28-4d2d-b43e-07eeaf2c6b1d@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zVBCuWShUMryvD6pExRT33i96_-cTGxP
X-Proofpoint-GUID: FsutSPg4GTbXdUvBygW4VQKzSCkblQtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_20,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=490 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010153
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------7xzeBfk3PKS8FCDzzwZWfE4j
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 01-03-2024 22:06, Cédric Le Goater wrote:
> Chalapathi,
>
> On 3/1/24 17:17, Chalapathi V wrote:
>> Hello,
>>
>> I would greatly appreciate the review comments/suggestions on PATCH V1.
>>
>> Thank You and Regards,
>
> I didn't forget but I lacked the time in this release cycle. Sorry
> about that.
>
> I have one quick comment though. There are already a few models
> implementing SPI controllers in QEMU. When I skimmed through the
> patches, I was surprised to see no use of the available SSI
> framework. Doesn't the current framework fit your needs ?
>
> Please take a look at files in : include/hw/ssi/* hw/ssi/*
>
> Same comment for the Serial EEPROM model. This device is generic
> and not POWER specific. It should be possible to attach the device
> model on other machines and different SPI bus provided by QEMU.
> This doesn't mean rewriting everything, but the "HW" interface
> probably needs to be reworked. It would make it easier to write
> unit test (see ests/qtest/) and ease the review also.
>
> Thanks,
>
> C.
>
Hello Cedric,

Thank You so much for the suggestions. Current implementation of 
SPI_controller and Serial EEPROM device using xfer_buffer payload allows 
me to use the *SSI_BUS* and *ssi_create_peripheral(). *I will modify the 
spi_controller and Serial EEPROM models to use *ssi_transfer()* and 
transfer control using CS line and update in PATCH V2.

Thank You,

Chalapathi

>
>
>>
>> Chalapathi
>>
>> On 07-02-2024 21:38, Chalapathi V wrote:
>>> Hello,
>>>
>>> In this series of patchset, SPI controller and responder models
>>> for Power10 processor are modelled.
>>>
>>> Serial peripheral interface provides full-duplex synchronous serial
>>> communication between single controller and multiple responder devices.
>>>
>>> The current configuration supports a single SPI controller reside on 
>>> the
>>> SPI bus. In p10, SPI controller device model supports a connection to a
>>> single SPI responder such as SPI seeproms, TPM, flash device and an ADC
>>> controller.
>>>
>>> SPI controller model is divided into configuration unit, sequencer FSM
>>> and shifter engine. All SPI function control is mapped into the SPI 
>>> register
>>> space to enable full control by firmware.
>>>
>>> SPI configuration component is modelled which contains all SPI 
>>> configuration
>>> and status registers as well as the hold registers for data to be 
>>> sent or
>>> having been received.
>>> Shift engine performs serialization and de-serialization according 
>>> to the
>>> control by the sequencer and according to the setup defined in the
>>> configuration registers.
>>> Sequencer implements the main control logic and
>>> FSM to handle data transmit and data receive control of the shift 
>>> engine.
>>>
>>> Microchip's 25CSM04 SEEPROM device is modelled and connected to SPI bus
>>> "spi_bus2" of SPI controller "PIB_SPIC[2]".
>>>
>>> Patches overview in V1.
>>> PATCH1: Create a SPI responder model which includes responder methods
>>>          and SPI bus implementation.
>>> PATCH2: Create a SPI controller model and implement configuration unit
>>>          to model SCOM registers.
>>> PATCH3: SPI controller model: implement sequencer FSM and shift engine.
>>> PATCH4: create SPI SEEPROM model.
>>> PATCH5: Connect SPI controllers to p10 chip and create keystore seeprom
>>>          device on spi_bus2 of PIB_SPIC[2].
>>>
>>> Thank You,
>>> Chalapathi
>>>
>>> Chalapathi V (5):
>>>    hw/ppc: SPI responder model
>>>    hw/ppc: SPI controller model - registers implementation
>>>    hw/ppc: SPI controller model - sequencer and shifter
>>>    hw/ppc: SPI SEEPROM model
>>>    hw/ppc: SPI controller wiring to P10 chip and create seeprom device
>>>
>>>   include/hw/ppc/pnv_chip.h           |    4 +
>>>   include/hw/ppc/pnv_spi_controller.h |  101 ++
>>>   include/hw/ppc/pnv_spi_responder.h  |  109 ++
>>>   include/hw/ppc/pnv_spi_seeprom.h    |   70 ++
>>>   include/hw/ppc/pnv_xscom.h          |    3 +
>>>   hw/ppc/pnv.c                        |   32 +
>>>   hw/ppc/pnv_spi_controller.c         | 1609 
>>> +++++++++++++++++++++++++++
>>>   hw/ppc/pnv_spi_responder.c          |  166 +++
>>>   hw/ppc/pnv_spi_seeprom.c            |  989 ++++++++++++++++
>>>   hw/ppc/meson.build                  |    3 +
>>>   10 files changed, 3086 insertions(+)
>>>   create mode 100644 include/hw/ppc/pnv_spi_controller.h
>>>   create mode 100644 include/hw/ppc/pnv_spi_responder.h
>>>   create mode 100644 include/hw/ppc/pnv_spi_seeprom.h
>>>   create mode 100644 hw/ppc/pnv_spi_controller.c
>>>   create mode 100644 hw/ppc/pnv_spi_responder.c
>>>   create mode 100644 hw/ppc/pnv_spi_seeprom.c
>>>
>
--------------7xzeBfk3PKS8FCDzzwZWfE4j
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 01-03-2024 22:06, Cédric Le Goater
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:9dd1a7fe-4d28-4d2d-b43e-07eeaf2c6b1d@kaod.org">Chalapathi,
      <br>
      <br>
      On 3/1/24 17:17, Chalapathi V wrote:
      <br>
      <blockquote type="cite">Hello,
        <br>
        <br>
        I would greatly appreciate the review comments/suggestions on
        PATCH V1.
        <br>
        <br>
        Thank You and Regards,
        <br>
      </blockquote>
      <br>
      I didn't forget but I lacked the time in this release cycle. Sorry
      <br>
      about that.
      <br>
      <br>
      I have one quick comment though. There are already a few models
      <br>
      implementing SPI controllers in QEMU. When I skimmed through the
      <br>
      patches, I was surprised to see no use of the available SSI
      <br>
      framework. Doesn't the current framework fit your needs ?
      <br>
      <br>
      Please take a look at files in : include/hw/ssi/* hw/ssi/*
      <br>
      <br>
      Same comment for the Serial EEPROM model. This device is generic
      <br>
      and not POWER specific. It should be possible to attach the device
      <br>
      model on other machines and different SPI bus provided by QEMU.
      <br>
      This doesn't mean rewriting everything, but the "HW" interface
      <br>
      probably needs to be reworked. It would make it easier to write
      <br>
      unit test (see ests/qtest/) and ease the review also.
      <br>
      <br>
      Thanks,
      <br>
      <br>
      C.
      <br>
      <br>
    </blockquote>
    <p>Hello Cedric,</p>
    <p>Thank You so much for the suggestions. Current implementation of
      SPI_controller and Serial EEPROM device using xfer_buffer payload
      allows me to use the <b>SSI_BUS</b> and <b>ssi_create_peripheral().
      </b>I will modify the spi_controller and Serial EEPROM models to
      use <b>ssi_transfer()</b> and transfer control using CS line and
      update in PATCH V2.</p>
    <p>Thank You,</p>
    <p>Chalapathi<br>
    </p>
    <blockquote type="cite"
      cite="mid:9dd1a7fe-4d28-4d2d-b43e-07eeaf2c6b1d@kaod.org">
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Chalapathi
        <br>
        <br>
        On 07-02-2024 21:38, Chalapathi V wrote:
        <br>
        <blockquote type="cite">Hello,
          <br>
          <br>
          In this series of patchset, SPI controller and responder
          models
          <br>
          for Power10 processor are modelled.
          <br>
          <br>
          Serial peripheral interface provides full-duplex synchronous
          serial
          <br>
          communication between single controller and multiple responder
          devices.
          <br>
          <br>
          The current configuration supports a single SPI controller
          reside on the
          <br>
          SPI bus. In p10, SPI controller device model supports a
          connection to a
          <br>
          single SPI responder such as SPI seeproms, TPM, flash device
          and an ADC
          <br>
          controller.
          <br>
          <br>
          SPI controller model is divided into configuration unit,
          sequencer FSM
          <br>
          and shifter engine. All SPI function control is mapped into
          the SPI register
          <br>
          space to enable full control by firmware.
          <br>
          <br>
          SPI configuration component is modelled which contains all SPI
          configuration
          <br>
          and status registers as well as the hold registers for data to
          be sent or
          <br>
          having been received.
          <br>
          Shift engine performs serialization and de-serialization
          according to the
          <br>
          control by the sequencer and according to the setup defined in
          the
          <br>
          configuration registers.
          <br>
          Sequencer implements the main control logic and
          <br>
          FSM to handle data transmit and data receive control of the
          shift engine.
          <br>
          <br>
          Microchip's 25CSM04 SEEPROM device is modelled and connected
          to SPI bus
          <br>
          "spi_bus2" of SPI controller "PIB_SPIC[2]".
          <br>
          <br>
          Patches overview in V1.
          <br>
          PATCH1: Create a SPI responder model which includes responder
          methods
          <br>
                   and SPI bus implementation.
          <br>
          PATCH2: Create a SPI controller model and implement
          configuration unit
          <br>
                   to model SCOM registers.
          <br>
          PATCH3: SPI controller model: implement sequencer FSM and
          shift engine.
          <br>
          PATCH4: create SPI SEEPROM model.
          <br>
          PATCH5: Connect SPI controllers to p10 chip and create
          keystore seeprom
          <br>
                   device on spi_bus2 of PIB_SPIC[2].
          <br>
          <br>
          Thank You,
          <br>
          Chalapathi
          <br>
          <br>
          Chalapathi V (5):
          <br>
             hw/ppc: SPI responder model
          <br>
             hw/ppc: SPI controller model - registers implementation
          <br>
             hw/ppc: SPI controller model - sequencer and shifter
          <br>
             hw/ppc: SPI SEEPROM model
          <br>
             hw/ppc: SPI controller wiring to P10 chip and create
          seeprom device
          <br>
          <br>
            include/hw/ppc/pnv_chip.h           |    4 +
          <br>
            include/hw/ppc/pnv_spi_controller.h |  101 ++
          <br>
            include/hw/ppc/pnv_spi_responder.h  |  109 ++
          <br>
            include/hw/ppc/pnv_spi_seeprom.h    |   70 ++
          <br>
            include/hw/ppc/pnv_xscom.h          |    3 +
          <br>
            hw/ppc/pnv.c                        |   32 +
          <br>
            hw/ppc/pnv_spi_controller.c         | 1609
          +++++++++++++++++++++++++++
          <br>
            hw/ppc/pnv_spi_responder.c          |  166 +++
          <br>
            hw/ppc/pnv_spi_seeprom.c            |  989 ++++++++++++++++
          <br>
            hw/ppc/meson.build                  |    3 +
          <br>
            10 files changed, 3086 insertions(+)
          <br>
            create mode 100644 include/hw/ppc/pnv_spi_controller.h
          <br>
            create mode 100644 include/hw/ppc/pnv_spi_responder.h
          <br>
            create mode 100644 include/hw/ppc/pnv_spi_seeprom.h
          <br>
            create mode 100644 hw/ppc/pnv_spi_controller.c
          <br>
            create mode 100644 hw/ppc/pnv_spi_responder.c
          <br>
            create mode 100644 hw/ppc/pnv_spi_seeprom.c
          <br>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------7xzeBfk3PKS8FCDzzwZWfE4j--


