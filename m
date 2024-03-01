Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F81C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 16:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg5sj-0000a6-L5; Fri, 01 Mar 2024 11:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DSA8=KH=kaod.org=clg@ozlabs.org>)
 id 1rg5sf-0000ZV-Tn; Fri, 01 Mar 2024 11:37:05 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DSA8=KH=kaod.org=clg@ozlabs.org>)
 id 1rg5sb-0005IZ-U0; Fri, 01 Mar 2024 11:37:05 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TmYdS5Qtzz4wc6;
 Sat,  2 Mar 2024 03:36:44 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TmYdP5fc8z4wc1;
 Sat,  2 Mar 2024 03:36:41 +1100 (AEDT)
Message-ID: <9dd1a7fe-4d28-4d2d-b43e-07eeaf2c6b1d@kaod.org>
Date: Fri, 1 Mar 2024 17:36:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] hw/ppc: SPI model
Content-Language: en-US, fr
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com
References: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
 <2aef5ff8-bdae-437e-892b-25e4fe684335@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <2aef5ff8-bdae-437e-892b-25e4fe684335@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=DSA8=KH=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Chalapathi,

On 3/1/24 17:17, Chalapathi V wrote:
> Hello,
> 
> I would greatly appreciate the review comments/suggestions on PATCH V1.
> 
> Thank You and Regards,

I didn't forget but I lacked the time in this release cycle. Sorry
about that.

I have one quick comment though. There are already a few models
implementing SPI controllers in QEMU. When I skimmed through the
patches, I was surprised to see no use of the available SSI
framework. Doesn't the current framework fit your needs ?

Please take a look at files in : include/hw/ssi/* hw/ssi/*

Same comment for the Serial EEPROM model. This device is generic
and not POWER specific. It should be possible to attach the device
model on other machines and different SPI bus provided by QEMU.
This doesn't mean rewriting everything, but the "HW" interface
probably needs to be reworked. It would make it easier to write
unit test (see ests/qtest/) and ease the review also.

Thanks,

C.



> 
> Chalapathi
> 
> On 07-02-2024 21:38, Chalapathi V wrote:
>> Hello,
>>
>> In this series of patchset, SPI controller and responder models
>> for Power10 processor are modelled.
>>
>> Serial peripheral interface provides full-duplex synchronous serial
>> communication between single controller and multiple responder devices.
>>
>> The current configuration supports a single SPI controller reside on the
>> SPI bus. In p10, SPI controller device model supports a connection to a
>> single SPI responder such as SPI seeproms, TPM, flash device and an ADC
>> controller.
>>
>> SPI controller model is divided into configuration unit, sequencer FSM
>> and shifter engine. All SPI function control is mapped into the SPI register
>> space to enable full control by firmware.
>>
>> SPI configuration component is modelled which contains all SPI configuration
>> and status registers as well as the hold registers for data to be sent or
>> having been received.
>> Shift engine performs serialization and de-serialization according to the
>> control by the sequencer and according to the setup defined in the
>> configuration registers.
>> Sequencer implements the main control logic and
>> FSM to handle data transmit and data receive control of the shift engine.
>>
>> Microchip's 25CSM04 SEEPROM device is modelled and connected to SPI bus
>> "spi_bus2" of SPI controller "PIB_SPIC[2]".
>>
>> Patches overview in V1.
>> PATCH1: Create a SPI responder model which includes responder methods
>>          and SPI bus implementation.
>> PATCH2: Create a SPI controller model and implement configuration unit
>>          to model SCOM registers.
>> PATCH3: SPI controller model: implement sequencer FSM and shift engine.
>> PATCH4: create SPI SEEPROM model.
>> PATCH5: Connect SPI controllers to p10 chip and create keystore seeprom
>>          device on spi_bus2 of PIB_SPIC[2].
>>
>> Thank You,
>> Chalapathi
>>
>> Chalapathi V (5):
>>    hw/ppc: SPI responder model
>>    hw/ppc: SPI controller model - registers implementation
>>    hw/ppc: SPI controller model - sequencer and shifter
>>    hw/ppc: SPI SEEPROM model
>>    hw/ppc: SPI controller wiring to P10 chip and create seeprom device
>>
>>   include/hw/ppc/pnv_chip.h           |    4 +
>>   include/hw/ppc/pnv_spi_controller.h |  101 ++
>>   include/hw/ppc/pnv_spi_responder.h  |  109 ++
>>   include/hw/ppc/pnv_spi_seeprom.h    |   70 ++
>>   include/hw/ppc/pnv_xscom.h          |    3 +
>>   hw/ppc/pnv.c                        |   32 +
>>   hw/ppc/pnv_spi_controller.c         | 1609 +++++++++++++++++++++++++++
>>   hw/ppc/pnv_spi_responder.c          |  166 +++
>>   hw/ppc/pnv_spi_seeprom.c            |  989 ++++++++++++++++
>>   hw/ppc/meson.build                  |    3 +
>>   10 files changed, 3086 insertions(+)
>>   create mode 100644 include/hw/ppc/pnv_spi_controller.h
>>   create mode 100644 include/hw/ppc/pnv_spi_responder.h
>>   create mode 100644 include/hw/ppc/pnv_spi_seeprom.h
>>   create mode 100644 hw/ppc/pnv_spi_controller.c
>>   create mode 100644 hw/ppc/pnv_spi_responder.c
>>   create mode 100644 hw/ppc/pnv_spi_seeprom.c
>>


