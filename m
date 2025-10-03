Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCA0CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 13:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4g7E-0004aK-1j; Fri, 03 Oct 2025 09:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v4g70-0004SJ-Gq; Fri, 03 Oct 2025 09:46:20 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v4g6b-0007Mp-2d; Fri, 03 Oct 2025 09:46:15 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 593DcseB064685
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 3 Oct 2025 22:38:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=GKFni/omShvUOfoASh/XkzY9Uo067qHc8z6UJ08gLA0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1759498735; v=1;
 b=Ozl2t/dIBTS9bVBEwoemG6s9+3+dZPhDB2eDzVTZj9CwnHb6uccGqmreg3fbkkCs
 6wXBD+D0uzWyjn3clOQ/HmgFyW85aaWULkleL7sEss+W7sGvH8Cli2MvVj30AfSb
 hIfAGDJVGnHVXC47p/JfSL+nh7iNYaefMHorTZVWyIoCE4Ixfy8vVvs57ifoW2+c
 EV0NBOy0iXr4GFirO1fyc1TLz4QMYaTwerzTHevd9rtzAnuv8jcEIvkBuyBy54yc
 5olelUBMwMRlsNSP4diZ9JedJXX5y5J4tak0DWU2e/QmicgCuERe7sLKMYElhri5
 wRj9OX/QIHNJw0fVQdjBTA==
Message-ID: <402e36dc-9649-4ac0-8ecd-796f0b958aaf@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 3 Oct 2025 22:38:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] hw/pci-bridge: Do not assume immediate MemoryRegion
 finalization
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
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
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
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
References: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-subregion-v1-1-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <aN7Iy7pZiriiAEHk@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aN7Iy7pZiriiAEHk@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 2025/10/03 3:47, Peter Xu wrote:
> On Wed, Sep 17, 2025 at 07:32:47PM +0900, Akihiko Odaki wrote:
>> When updating memory mappings, pci_bridge_update_mappings() performed
>> the following operations:
>> 1. Start a transaction
>> 2. Delete the subregions from the container
>> 3. Unparent the subregions
>> 4. Initialize the subregions
>> 5. End the transaction
>>
>> This assumes the old subregion instances are finalized immediately after
>> 3, but it is not true; the finalization is delayed until 5. Remove the
>> assumption by using functions to dynamically update MemoryRegions.
> 
> To Paolo - you can ignore this if you'll merge it.  However I'm still
> raising this as a pure question.
> 
> Could there be an explanation why it'll be delayed until step 5?
> 
> All the MRs involved in this patch are all aliases.  I believe this rules
> out any map() ref-takers.  IIUC it is exactly what was marked exceptions in
> the memory.rst here:
> 
>    There is an exception to the above rule: it is okay to call
>    object_unparent at any time for an alias or a container region.  It is
>    therefore also okay to create or destroy alias and container regions
>    dynamically during a device's lifetime.
>    
>    This exceptional usage is valid because aliases and containers only help
>    QEMU building the guest's memory map; they are never accessed directly.
>    memory_region_ref and memory_region_unref are never called on aliases
>    or containers, and the above situation then cannot happen.  Exploiting
>    this exception is rarely necessary, and therefore it is discouraged,
>    but nevertheless it is used in a few places.
> 
> I was expecting the current code should at least be fine, no?

You are right. This patch does nothing good so I'll drop it.

Regards,
Akihiko Odaki

