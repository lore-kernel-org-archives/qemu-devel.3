Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA4ACAC587
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 02:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwtG2-00021h-Ma; Thu, 11 Sep 2025 22:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uwtFv-00020q-7J; Thu, 11 Sep 2025 22:11:19 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uwtFr-0004xi-16; Thu, 11 Sep 2025 22:11:18 -0400
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58C29pIw079443
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 12 Sep 2025 11:09:51 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=OiEWy566g4njwzExPUXUWjjakl2LySIDrIBxFd9DPBo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1757642992; v=1;
 b=vpctMdJpef9Qn0NI5HhLlNNSqb0hhP6Uknft3SBWrWRAGCZORdGdGsjEDra3OMD1
 iqw+PpFYoUiEtPF+ceBirf+E/azkg/xi4Ae1dMl3PjpP4GEAtM3HamUTwijgGgV6
 RZQwbDluC2WFOawpKwhcDYEQWlALnUFDvodI6KQmjj9cjBjpi8RXJZYa6lU/zSL+
 5gyICXhC+HpAzyAaS7C7QL0LspJRMExAdhjG7XU/FCtJp8+EcV0darVNGUgcOTSu
 Z3KqTfVQna7gqO7UrW0EgSwX7OYOW9edJgT79hn0bnUaRtZQCS3PD9xPFd+Gf3pW
 HZWgPDbmk4dYVaqBSHP1uw==
Message-ID: <4d91c86f-4e3d-4850-8b8c-77ad3c9d5bce@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 12 Sep 2025 11:09:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] vfio/pci: Do not unparent in instance_finalize()
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
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-2-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <aMHidDl1tdx-2G4e@x1.local>
 <1a5b7471-1799-44bd-9c1c-c3c07e478bb8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNBJF9E4BYrWEHO@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aMNBJF9E4BYrWEHO@x1.local>
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

On 2025/09/12 6:37, Peter Xu wrote:
> On Thu, Sep 11, 2025 at 12:47:24PM +0900, Akihiko Odaki wrote:
>> On 2025/09/11 5:41, Peter Xu wrote:
>>> On Sat, Sep 06, 2025 at 04:11:11AM +0200, Akihiko Odaki wrote:
>>>> Children are automatically unparented so manually unparenting is
>>>> unnecessary.
>>>>
>>>> Worse, automatic unparenting happens before the insntance_finalize()
>>>> callback of the parent gets called, so object_unparent() calls in
>>>> the callback will refer to objects that are already unparented, which
>>>> is semantically incorrect.
>>>>
>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> ---
>>>>    hw/vfio/pci.c | 4 ----
>>>>    1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index 07257d0fa049b09fc296ac2279a6fafbdf93d277..2e909c190f86a722e1022fa7c45a96d2dde8d58e 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -2000,7 +2000,6 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
>>>>            vfio_region_finalize(&bar->region);
>>>>            if (bar->mr) {
>>>>                assert(bar->size);
>>>> -            object_unparent(OBJECT(bar->mr));
>>>>                g_free(bar->mr);
>>>>                bar->mr = NULL;
>>>>            }
>>>> @@ -2008,9 +2007,6 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
>>>>        if (vdev->vga) {
>>>>            vfio_vga_quirk_finalize(vdev);
>>>> -        for (i = 0; i < ARRAY_SIZE(vdev->vga->region); i++) {
>>>> -            object_unparent(OBJECT(&vdev->vga->region[i].mem));
>>>> -        }
>>>>            g_free(vdev->vga);
>>>>        }
>>>>    }
>>>
>>> So the 2nd object_unparent() here should be no-op, seeing empty list of
>>> properties (but shouldn't causing anything severe), is that correct?
>>
>> No. The object is finalized with the first object_unparent() if there is no
>> referrer other than the parent. The second object_unparent() will access the
>> finalized, invalid object in that case.
> 
> Yes, it's logically wrong.  I was trying to understand the impact when it's
> invoked.  In this specific case of above two changes, I believe both MR
> structs are still available, so it does look fine, e.g. nothing would crash.
> 
> For example, I think it doesn't need to copy stable if there's no real
> functional issue involved.

You are right. Cc: stable is unnecessary.

> 
>>
>>>
>>> I think it still makes some sense to theoretically allow object_unparent()
>>> to happen, at least when it happens before owner's finalize().  IIUC that
>>> was the intention of the doc, pairing the memory_region_init*() operation.
>>
>> Perhaps so, but this patch is only about the case where object_unparent() is
>> called in finalize().
> 
> You ignored my other comment.  That (using object_new() on MRs) was what I
> was thinking might be better than a split model you discussed here, so
> that's also a comment for patch 1 of your series.

I'm not sure what you mean by the "split model".

This change removes object_unparent() in vfio_bars_finalize(). 
object_new() will allow removing even g_free(), but we can do these 
changes incrementally:
1. remove object_unparent() in finalize(),
    which fixes a semantic problem (this patch)
2. allow object_new() for MRs and remove g_free() in finalize()
    as a refactoring.

So I suggest focusing on object_unparent() in finalize() to keep this 
patch and review concise.

> 
> Btw, this patch also didn't change all occurances of such for VFIO?
> E.g. there's at least vfio_vga_quirk_finalize().  I didn't check the rest.
> 

Indeed. I only removed object_unparent() calls hw/vfio/pci.c because it 
was mentioned in the documentation. I suspect you will find more cases 
that subregions are used in instance_finalize() in general if you check 
the code base; "[PATCH 11/22] vfio-user: Do not delete the subregion" 
also removes memory_region_del_subregion() during finalization, for example.

Regards,
Akihiko Odaki

