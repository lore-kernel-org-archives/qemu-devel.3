Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D694DCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbfmf-0005YN-DZ; Mon, 22 Jun 2026 10:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wbfmb-0005YF-GH
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:37:53 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wbfmY-0001hy-NG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:37:53 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65MEaxPU021103
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 22 Jun 2026 23:37:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=o6/ZSaRkdFCE7O97+b2uT7Sb8j/5Y7IqYEaRwQYkbQM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782139020; v=1;
 b=ihPL/w0fRh91V6z0nHFcX+NkfTRjCU9doYbcHw/wDAym1tx476VG28tdFyTTXSLo
 ouGrKC4TfK3XqP4Uv7O3tQptWI+l9vDIVnNZiXPFSWcBFSLIA6h/jZFQXXUAW1jI
 MmoNGqiTIeYx/zzaZW5ZJQovF6E86/fzhiGi6pOtBYoD4rtsauR6X7mkuh/aB8SH
 3Ep1cD/08Jqp7gfAge75D5B9vOngKDKJ753Bz4RPuDL0zdhvG8WkQMKon6U0HDnV
 ea7a5vyFejqD0CiJu+i/MlkabpeUX9MOZ73JoQcNUoP65TGrn287hOJw53FC8k9t
 PGn8QOcalZDzrE9SpIts2Q==
Message-ID: <2660c118-474e-4160-9b26-25694d02d676@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 22 Jun 2026 23:36:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/7] system: add memory_region_new / memory_region_new_io
To: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-5-berrange@redhat.com>
 <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
 <9976f829-7c33-7dce-b38e-aa6f04d6ec9d@eik.bme.hu>
 <78798c63-5ca9-4acc-a878-8638724d487c@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <78798c63-5ca9-4acc-a878-8638724d487c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/06/20 1:32, Paolo Bonzini wrote:
> On 6/18/26 00:44, BALATON Zoltan wrote:
>> On Wed, 17 Jun 2026, Paolo Bonzini wrote:
>>> On 6/16/26 17:55, Daniel P. Berrangé wrote:
>>>> Prepare for the move to dynamically allocated memory regions by
>>>> introducing memory_region_new and memory_region_new_io functions
>>>> which call through to object_new instead of object_initialize.
>>>
>>> MemoryRegionOps callback will certainly access fields in the parent. 
>>> Having a separate object gives you no benefit because you still have 
>>> the same use-after-free if the MemoryRegion outlives the device. 
>>> Likewise for buses.
>>>
>>> If the device itself is embedded, then all the invariants must hold 
>>> recursively:
>>>
>>> - the device must be kept alive by mutual references between the 
>>> device itself and its parent;
>>>
>>> - unparent for the device should wait for all guest memory accesses 
>>> to be either completed or cancelled.
>>>
>>> So, the problem is that "QEMU automatically references the owning 
>>> Device to keep the MemoryRegion alive" is a hack that should die.
>>> [...] I disagree that removing embedding will fix any bugs
>>
>> I'm trying to understand this better. The way it originally meant to 
>> work according to the memory region docs and implementation is that 
>> memory region is added to an owner as a child which takes a reference 
>> and when the owner is freed it will unparent its children which will 
>> then get unrefed and freed as well if nothing else increased their ref 
>> count.
> 
> Yes, and that's broken.
> 
>> The problem is that when something accesses the memory region it has 
>> to keep the owner alive as well so instead of referencing the memory 
>> region it references the owner (not directly but using 
>> memory_region_ref which does this).
> 
> A mechanism to keep the owner alive exists, and it is mutual references 
> (so that neither owner nor MR die) + unparent of owner (which should 
> wait for pending users to complete before returning).
> 
> The fact that this mechanism is not used, i.e. unparent of a PCIDevice 
> does not wait for pending BAR accesses to complete, is a bug.
> 
>> So embedding seems unrelated to this passing refs on
>> memory regions to owner and could be fixed separately that my patches 
>> attempted.
> 
> Your patches add the possibility of not embedding; I don't like having 
> two separate API, but I think we only have a disagreement on aesthetics.
> 
> This is different for Daniel's patches, which try to fix something by 
> not embedding, and I don't think they do.  Currently, if the owner dies, 
> the MemoryRegion dies with it while it shouldn't (which is a problem, 
> absolutely).  But these patches, while preventing the MR from dying, 
> still leave around a dangling pointer to the owner from the MR, so 
> there's not much gained if anything.

I think we can stack follow-up patches that reject accesses to 
MemoryRegions owned by unrealized devices. That would make this a more 
complete solution. Accessing an unrealized device is an unsafe corner 
case anyway, so it is better to close it explicitly.

memory_region_init_ram_ptr() and memory_region_init_ram_device_ptr() are 
a little more complicated, because direct accesses to those regions can 
happen outside the BQL. Still, we can unmap the memory when the 
MemoryRegion is finalized, as memory_region_init_ram() already does.

However, after looking into this further, I found one complication:
x-vfio-user-server. In that case, the unmap timing is controlled by
libvfio-user, so QEMU cannot keep the memory mapped until the 
MemoryRegion reference is dropped. This is not a new issue; it is a 
pre-existing use-after-free hazard. I think a practical fix would be to 
extend the libvfio-user API to support asynchronous unmapping.

Cc'ing the vfio-user maintainers.

Regards,
Akihiko Odaki

