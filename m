Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212DFCFC27C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jh0-0006Tx-UY; Tue, 15 Oct 2024 11:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Jj9V=RL=kaod.org=clg@ozlabs.org>)
 id 1t0jgy-0006T4-DT; Tue, 15 Oct 2024 11:42:36 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Jj9V=RL=kaod.org=clg@ozlabs.org>)
 id 1t0jgw-0000HD-Dc; Tue, 15 Oct 2024 11:42:36 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XSddZ5mJpz4wyk;
 Wed, 16 Oct 2024 02:42:26 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XSddL3rR0z4wcr;
 Wed, 16 Oct 2024 02:42:14 +1100 (AEDT)
Message-ID: <069e909e-c39b-4fab-9392-d62ef43b9ab6@kaod.org>
Date: Tue, 15 Oct 2024 17:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Allow user creation of eMMCs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jan Luebbe <jlu@pengutronix.de>, qemu-devel@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20241015135649.4189256-1-jlu@pengutronix.de>
 <5fb5f318-6fd0-4390-9314-528acc5d8901@linaro.org>
 <f34082e5-fb7e-47c8-b149-6557b02f81d4@kaod.org> <Zw6IMVkNbNPXmloN@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <Zw6IMVkNbNPXmloN@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Jj9V=RL=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/15/24 17:20, Daniel P. Berrangé wrote:
> On Tue, Oct 15, 2024 at 05:17:26PM +0200, Cédric Le Goater wrote:
>> On 10/15/24 17:00, Philippe Mathieu-Daudé wrote:
>>> On 15/10/24 10:56, Jan Luebbe wrote:
>>>> For testing eMMC-specific functionality (such as handling boot
>>>> partitions), it would be very useful to attach them to generic VMs such
>>>> as x86_64 via the sdhci-pci device:
>>>>    ...
>>>>    -drive if=none,id=emmc-drive,file=emmc.img,format=raw \
>>>>    -device sdhci-pci \
>>>>    -device emmc,id=emmc0,drive=emmc-drive,boot-partition-size=1048576 \
>>>>    ...
>>>>
>>>> While most eMMCs are soldered to boards, they can also be connected to
>>>> SD controllers with just a passive adapter, such as:
>>>>    https://docs.radxa.com/en/accessories/emmc-to-usd
>>>>    https://github.com/voltlog/emmc-wfbga153-microsd
>>>>
>>>> The only change necessary to make the options above work is to avoid
>>>> disabling user_creatable, so do that. The SDHCI-PCI driver in the Linux
>>>> kernel already supports this just fine.
>>>>
>>>> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>>
>> Nice !
>>
>> Would it be possible to add an avocado test ?
> 
> NB, no new avocado tests please. Only use the recently introduced
> 'functional' tests framework for new tests.

True. That reminds me that the aspeed test file needs a conversion.

Thanks,

C.


> 
> 
> With regards,
> Daniel


