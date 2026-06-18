Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ED4CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa5Er-0001sD-NQ; Thu, 18 Jun 2026 01:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wa5Eq-0001rh-2R
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:24:28 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wa5Eo-0006wH-2G
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:24:27 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65I5Nu6A053612
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 18 Jun 2026 14:23:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=RcnykiOf2Atn3CFqXrlSpKczPD9BjliucD6OzoFsM48=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781760236; v=1;
 b=UfX64Uy5IOKEGjlYsZTm1MLeH/if2z5WGXK1DsupgWfF1xdRT10LiP6ggkJiJnqg
 ILpTy37VE9CfPmXmbnYbvekfuXuq1IuQJd7W2zhJTemTTITp1ZEBUk1a/24XWebF
 pRS/QFsq0OJVJ29qHvFPJ2mvtd3Ke+AycJVcSbz0I4USKDe30mLEoxwHmj8wJFBX
 6O90yIk+iaU1aPDdT2gGA8rpjp1S3nXm7F8IMaM9k0vrBd6VXeAGcaB3t4njYCP3
 JrZWGQ6uqfUCSZ9D8xXx0yTcBRUdFifo3ZEAVCX/Eq7gCRQk9rIuL32vn4C/CiUj
 6st4bMT+BnvdocjdVIGwag==
Message-ID: <3890f5e8-6bf8-42fb-8f86-91d512130e5e@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 18 Jun 2026 14:23:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/7] system: add memory_region_new / memory_region_new_io
To: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-5-berrange@redhat.com>
 <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
 <9976f829-7c33-7dce-b38e-aa6f04d6ec9d@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <9976f829-7c33-7dce-b38e-aa6f04d6ec9d@eik.bme.hu>
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

On 2026/06/18 7:44, BALATON Zoltan wrote:
> On Wed, 17 Jun 2026, Paolo Bonzini wrote:
>> On 6/16/26 17:55, Daniel P. Berrangé wrote:
>>> Prepare for the move to dynamically allocated memory regions by
>>> introducing memory_region_new and memory_region_new_io functions
>>> which call through to object_new instead of object_initialize.
>>>
>>> TBD: add "new" variants for all the other memory_region_init
>>> variants.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>
>> Zoltan already proposed this, but I really think it's a bad idea.
>>
>> MemoryRegionOps callback will certainly access fields in the parent. 
>> Having a separate object gives you no benefit because you still have 
>> the same use-after-free if the MemoryRegion outlives the device.  
>> Likewise for buses.
>>
>> For buses, the fact that the parent and child live at the same time is 
>> explicitly tracked with mutual refcount and unparent.  If it's not, we 
>> have the hack that Akihiko mentioned (https://lists.gnu.org/archive/ 
>> html/qemu-devel/2026-06/msg03459.html):
>>
>>> However, this is insufficient to avoid calling object_ref() for all
>>> embedded objects. For example, consider an embedded Device that has a
>>> MemoryRegion. When referencing a MemoryRegion for guest memory access,
>>> QEMU automatically references the owning Device to keep the MemoryRegion
>>> alive. However, that reference is ineffective if the Device itself is
>>> embedded, because object_ref() does not keep the containing storage
>>> alive.
>>
>> If the device itself is embedded, then all the invariants must hold 
>> recursively:
>>
>> - the device must be kept alive by mutual references between the 
>> device itself and its parent;
>>
>> - unparent for the device should wait for all guest memory accesses to 
>> be either completed or cancelled.
>>
>> So, the problem is that "QEMU automatically references the owning 
>> Device to keep the MemoryRegion alive" is a hack that should die.  I 
>> added it, mea culpa.
>>
>> The model is that if it makes sense to have B outlive A, you use new. 
>> If it doesn't, you use init.  For MemoryRegions or anything that has 
>> callbacks, it makes no sense to outlive the implementor of the 
>> callbacks.  There are exceptions if the number of objects is dynamic 
>> but they're very rare.
>>
>> I agree that there's extra complexity added by embedding; but I 
>> disagree that removing embedding will fix any bugs, and because it 
>> will hide a relationship between objects, I believe the complexity is 
>> not accidental.
> 
> I'm trying to understand this better. The way it originally meant to 
> work according to the memory region docs and implementation is that 
> memory region is added to an owner as a child which takes a reference 
> and when the owner is freed it will unparent its children which will 
> then get unrefed and freed as well if nothing else increased their ref 
> count. The problem is that when something accesses the memory region it 
> has to keep the owner alive as well so instead of referencing the memory 
> region it references the owner (not directly but using memory_region_ref 
> which does this). This is OK but I don't see how this mandates that the 
> memory region cannot be freed by the above ref counting together with 
> the owner and why it must be embedded? All this ref count hack does is 
> that it passes references of the memory region to the owner so the only 
> reference to the memory region itself would be from the owner and when 
> everything unrefs the owner (either directly or through any memory 
> region) they would be freed together as above. But this is now prevented 
> by memory_region_init having hard coded object_initialize which can only 
> be used with embedded objects. The problem is not referencing the owner 
> but that memory regions are not created with object_new so cannot be 
> freed by QOM. So embedding seems unrelated to this passing refs on 
> memory regions to owner and could be fixed separately that my patches 
> attempted. Where the referencing the owner hack may fail is when the 
> owner is also owned by something else and this does not pass refs 
> further up the chain but that's a separate issue which embedding does 
> not fix either so that could be handled and fixed separately.

I agree with your analysis. That's also what I pointed out in another 
thread:
http://lore.kernel.org/qemu-devel/48a2ec70-8995-40c5-8224-aa82f267e9dc@rsg.ci.i.u-tokyo.ac.jp/

Regards,
Akihiko Odaki

