Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0A7C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpX2-0000Pg-7e; Tue, 02 Jul 2024 22:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sOpWw-0000PL-1V; Tue, 02 Jul 2024 22:15:34 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sOpWt-0002qa-EC; Tue, 02 Jul 2024 22:15:33 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 994444E600F;
 Wed, 03 Jul 2024 04:15:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id bEy3jHig6NDC; Wed,  3 Jul 2024 04:15:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A02774E6004; Wed, 03 Jul 2024 04:15:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9E2DD746E3B;
 Wed, 03 Jul 2024 04:15:23 +0200 (CEST)
Date: Wed, 3 Jul 2024 04:15:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v10 11/12] hw/pci: Convert rom_bar into OnOffAuto
In-Reply-To: <20240702095426-mutt-send-email-mst@kernel.org>
Message-ID: <57c3c9c1-99c5-1f35-59d4-f913c3dee36b@eik.bme.hu>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
 <20240627-reuse-v10-11-7ca0b8ed3d9f@daynix.com>
 <20240702095426-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2 Jul 2024, Michael S. Tsirkin wrote:
> On Thu, Jun 27, 2024 at 03:08:00PM +0900, Akihiko Odaki wrote:
>> rom_bar is tristate but was defined as uint32_t so convert it into
>> OnOffAuto.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> Commit log should explain why this is an improvement,
> not just what's done.
>
>
>> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
>> index e17bb50789ad..35c6c8e28493 100644
>> --- a/docs/igd-assign.txt
>> +++ b/docs/igd-assign.txt
>> @@ -35,7 +35,7 @@ IGD has two different modes for assignment using vfio-pci:
>>        ISA/LPC bridge device (vfio-pci-igd-lpc-bridge) on the root bus at
>>        PCI address 1f.0.
>>      * The IGD device must have a VGA ROM, either provided via the romfile
>> -      option or loaded automatically through vfio (standard).  rombar=0
>> +      option or loaded automatically through vfio (standard).  rombar=off
>>        will disable legacy mode support.
>>      * Hotplug of the IGD device is not supported.
>>      * The IGD device must be a SandyBridge or newer model device.
>
> ...
>
>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>> index 39dae72497e0..0e920ed0691a 100644
>> --- a/hw/vfio/pci-quirks.c
>> +++ b/hw/vfio/pci-quirks.c
>> @@ -33,7 +33,7 @@
>>   * execution as noticed with the BCM 57810 card for lack of a
>>   * more better way to handle such issues.
>>   * The  user can still override by specifying a romfile or
>> - * rombar=1.
>> + * rombar=on.
>>   * Please see https://bugs.launchpad.net/qemu/+bug/1284874
>>   * for an analysis of the 57810 card hang. When adding
>>   * a new vendor id/device id combination below, please also add
>
>
> So we are apparently breaking a bunch of users who followed
> documentation to the dot. Why is this a good idea?

On/off is clearer than 1/0. But isn't 1/0 a synonym for on/off so 
previous command lines would still work?

Regards,
BALATON Zoltan

