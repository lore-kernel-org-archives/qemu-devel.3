Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A671FCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 15:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvdh2-0001S5-Qn; Mon, 08 Sep 2025 11:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uvdgz-0001Qr-8k; Mon, 08 Sep 2025 11:22:05 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uvdgv-00024O-H8; Mon, 08 Sep 2025 11:22:05 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 588FKQ8r038208
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 9 Sep 2025 00:20:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=pR7H7HGW0yVrYdYyEtmyx23P1FlXxhw9mkga9L8JSrE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1757344826; v=1;
 b=iKl5JYl27tMi1uWmdrk7pvyPDdgq1gCYopIxQ0w7w+ulLwN+VvMkGw7CKbRFZ6PV
 80IKLiZ++03e+Hcg3Aqp8KYAihkJk+r6ODgnsQjuHtwNNr7Gsd1ItQnNfuz4wYX5
 JD4y5G/XC9pr6EAqnfMU/30M55dNofcP1FzHsHBW0KsrRMwEt8Z4YL1gtPX4zL7n
 fDJi3TkbKm28DiAeQjox0BZKA9qbaTS8m+DygSnvTJ0Cl6ntK4csUl0Z0GJLx/sN
 Jn1fZgt7mAcW7y6csnFam6dbDpkgHbxoDY3pgx1WfANCcHY6vV8bIbDH8melH49a
 Ljc69knw+TS+fGnmDa+9Ow==
Message-ID: <f1eaf445-d80f-49b2-b722-8767feedf9be@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 9 Sep 2025 00:20:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] hw/pci-host/raven: Fix AddressSpace exposure timing
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-7-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <cd21698f-db77-eb75-6966-d559fdcab835@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <cd21698f-db77-eb75-6966-d559fdcab835@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2025/09/06 18:03, BALATON Zoltan wrote:
> On Sat, 6 Sep 2025, Akihiko Odaki wrote:
>> raven-pcihost is not hotpluggable but its instance can still be created
>> and finalized when processing the device-list-properties QMP command.
>> Exposing such a temporary instance to AddressSpace should be
>> avoided because it leaks the instance.
> 
> This may suggest there's an issue with freeing address spaces that 
> should be fixed there at one place if possible rather than adding a new 
> rule to remember not to create address spaces in init methods. Should 
> adress space be a child of the device too so it's freed with it? This 
> series simplifies some devices removing the rule to remember to unparent 
> memory regions but this now adds another rule to remember avoid creating 
> address spaces in init so overall we're in the same situation and still 
> have to work around issues. This trades one workaround for another so 
> still cannot fix all issues with freeing all created objects.

Making address spaces children will fix memory leaks, but it still 
leaves external side effects in init methods. Avoiding external side 
effect in init methods is necessary because devices can be created and 
removed at any time for introspection and it is not a new rule.

It is not necessary to remember to avoid creating address spaces in 
init; roughly speaking, int methods should only add properties and 
anything else should be done during realization.

"[PATCH v2 0/3] memory: Stop piggybacking on memory region owners" will 
cause an assertion failure if someone still manages to create an address 
space accidentally in init, so it is practically not possible to make 
such a mistake.

This series do not remove the rule to remember to unparent memory 
regions; it instead removes the rule to remember to delete memory 
regions from containers, which are distinct operations. And you still 
cannot add memory regions to containers during initialization; you 
should instead add them during realization just as like address space 
creation.

> 
>> Expose instances to the AddressSpace at their realization time so that
>> it won't happen for the temporary instances.
> 
> I had a series here: https://patchew.org/QEMU/ 
> cover.1751493467.git.balaton@eik.bme.hu/
> that changes this for raven (among other clean ups) but I could not get 
> that merged in the last devel cycle because of PPC being a bit 
> unmaintained. I'd prefer that series to be taken first instead of this 
> patch so I don't have to rebase that.

Looking at the series, "[PATCH v2 13/14] hw/pci-host/raven: Do not map 
regions in init method" moves memory_region_init() and 
memory_region_init_io() from raven_pcihost_initfn() to 
raven_pcihost_realize(). This should be avoided because these function 
calls add memory regions as child properties, which may be introspected 
without realization. Perhaps you may drop the patch and rebase your 
series on top of this patch, or let me rebase this patch on that series 
without it.

I wrote a documentation update to reflect my understanding of 
initialization and realization so please check it out too.
https://patchew.org/QEMU/20250908-qdev-v1-1-df236f7ce5bd@rsg.ci.i.u-tokyo.ac.jp/

Regards,
Akihiko Odaki

