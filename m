Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C1DC88E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 02:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkCTo-0003so-Hl; Sun, 25 Jan 2026 21:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vkCTk-0003iw-St; Sun, 25 Jan 2026 21:37:25 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vkCTi-0002Wb-C2; Sun, 25 Jan 2026 21:37:24 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60Q2b4K4049977
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 26 Jan 2026 11:37:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vAlGyijEGoBpRCJghkyEHn1iLftW9MPmq3caYEcD4K4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769395025; v=1;
 b=tF8qNxsP5Prareq86PZQX/97A8aZ9gFk4PebHVRy3iJZK9YPEwCJy7PT9o3rtcKT
 DmRsKpTXKrLx1FYlpUyHukN+uzJGdJHy2QZE4ueXj2OkjgHV9e0v8LpII6+FD040
 hghTx25WPK3qvGHJIPZ601ZE0rnX/qDYzPaxNZvrK+PRk5DdtWhPR4EE0iWmd8wR
 Al9FiHAvMsKqwIIXNqNrVVrgiRhSuuRwNk7eJiz7d/kz2vNH4Omi67UJv+24+X6t
 ZeSEfk9luypsjxhlEO0qApSCbXaSpWgLq3neceLtGb9ux9S/Z6D73B1OJeiQL6T1
 NWH11a8Ui2EPfM+kMbGHlA==
Message-ID: <9c4707fb-8e7f-4d4c-ae22-0b5ad6f05cdd@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 26 Jan 2026 11:37:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] vfio/pci: Grow buffer in vfio_pci_host_match()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <20260125-nvme-v1-2-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <4ad2cafe-9518-4cda-9b25-228cee136c1c@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <4ad2cafe-9518-4cda-9b25-228cee136c1c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/01/25 19:22, Cédric Le Goater wrote:
> On 1/25/26 07:42, Akihiko Odaki wrote:
>> Ensure the buffer in vfio_pci_host_match() will not overflow even when
>> an invalid addr parameter is provided.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   hw/vfio/pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index c73447272141..3338c4d7b528 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2673,7 +2673,7 @@ void vfio_pci_post_reset(VFIOPCIDevice *vdev)
>>   bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
>>   {
>> -    char tmp[13];
>> +    char tmp[36];
>>       sprintf(tmp, "%04x:%02x:%02x.%1x", addr->domain,
>>               addr->bus, addr->slot, addr->function);
>>
> 
> Using a g_autofree variable seems possible too :
> 
>      g_autofree char *tmp =
>          g_strdup_printf("%04x:%02x:%02x.%1x", addr->domain, addr->bus,
>                          addr->slot, addr->function);
> 
> vfio_pci_host_match() could be moved under container-legacy.c, with
> an assert on addr too.

I have another idea for improvement: replace slot and function with 
devfn. It will limit the range of slot and function, and is better 
aligned with Linux UAPI (c.f., vfio_legacy_pci_hot_reset()).

In any case, I intend to limit the scope of this series to fix the 
overflow. Further improvements like moving the code to 
container-legacy.c may be done later.

Regards,
Akihiko Odaki

