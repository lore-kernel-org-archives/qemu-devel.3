Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A43D73EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 06:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhlR-0004aI-Jg; Fri, 30 Jan 2026 01:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vlhlP-0004Za-Lu
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:13:51 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vlhlM-0002nP-Ls
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:13:51 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60U6D7e4070004
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 30 Jan 2026 15:13:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=WsWwjhNaC0PxpsKmmKlgtdYu68gInZX3+a7LikjAtpQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769753607; v=1;
 b=A0Iis0movKq3Jx+P9EkQdKZrFUYyP+AETjzWtfAAUh7lVsDbsDnV2GdHn7nqw4/D
 39zOaXXmZlcv3mPs34aCF92wVghTvFt3zCS68nQ72WFJZYIB311jCXlYA3ogUniy
 5t1tTI8rYFjPz+9xmEa9bV75FeoRsDk0IlIEOmAirI4NQlPPR+Jdw8ZCw8MD1ng5
 CB2hWTgfgWWV3+bcSNuVWS6BaK8SDoLj2hNadWai3Lj1fa/frxF/4ThkVsWttr1e
 qWYjEOYjDqfc1tAMY33U1soFRRcH/ATIdCgT1zDThK2W4MqfER2S+ZVpUxRdPQYP
 8E8pWqu/iYFHgtiW576EGw==
Message-ID: <3b12aa21-4d2d-465e-bc66-f5246cba2e43@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 30 Jan 2026 15:13:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Implement memory_region_new_* functions
To: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1769362313.git.balaton@eik.bme.hu>
 <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
 <0118dc9b-d467-7f6b-92a8-4f42760ecb6c@eik.bme.hu> <aXkXWGho7lnJ-gwX@x1.local>
 <2fa59d39-5634-0b8c-27ee-9e9548a7f92a@eik.bme.hu>
 <562f0e5c-7ae8-4d95-9dd4-674447362ef7@rsg.ci.i.u-tokyo.ac.jp>
 <cfacf068-7663-6c7f-4908-928bb63e803c@eik.bme.hu>
 <CAFEAcA-8-jC-HJix5YFVbmg3sEuhcSMD8gKJxzAiz=GPy0sw9Q@mail.gmail.com>
 <b5721fa1-e613-889a-03de-77c46aa01da4@eik.bme.hu>
 <d83ac948-afb4-4128-9e23-44aa8a8e31c4@rsg.ci.i.u-tokyo.ac.jp>
 <581b1d82-de10-47c5-9034-165b5af62e42@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <581b1d82-de10-47c5-9034-165b5af62e42@redhat.com>
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

On 2026/01/30 3:06, Paolo Bonzini wrote:
> On 1/29/26 05:41, Akihiko Odaki wrote:
>> However, I see another problem in struct embedding; it breaks 
>> object_ref(). When embedding, the child object effectively takes the 
>> reference to the storage of the parent object, but this reference is 
>> not counted, so use-after-free can happen if someone takes a reference 
>> to the child object with object_ref(). That is why the wrapper of 
>> object_ref() in rust/qom/src/qom.rs needs to be marked unsafe. Memory 
>> regions workaround this with memory_region_ref(), but it's not perfect 
>> since it relies on object_ref() in the end.
> 
> Yes, and in Rust the idea was to have (in addition to Owned<T> which is 
> for an allocated object) another smart pointer Child<'a, T>: an embedded 
> object that is owned (the parent has a reference and a field of type 
> Child releases that reference when the parent is finalized) but cannot 
> be cloned.
> 
>> For this reason I think object_initialize(), 
>> object_initialize_child(), and the like are better to be noted as 
>> deprecated in
>> include/qom/object.h. Then memory_region_init() can be deprecated 
>> referring to them.
> 
> This would be huge and I don't think it's feasible.
> 
> It also only provides the appearance of safety.  If you have a backwards 
> pointer (such as the memory region's owner), you still have either a 
> leak or the risk of a use-after-free.

Now I'm starting to recover my memory on the situation of this matter. I 
have actually written patches to make struct embedding safe and also 
deal with memory region's owner. My tree that include them can be found at:
https://gitlab.com/akihiko.odaki/qemu/-/tree/51066314fcff96303c1ad5814c3d74027855a7cb

Making struct embedding safe is done by introducing another reference 
counter for storage. So the reference graph will be looked like the 
following:

Owner -+-> Owner's storage
MR ----+

Memory region's backward references to their owning devices are 
invalidated when unrealizing the devices. The reasoning here is that the 
corner cases where devices are accessed after unrealization are unlikely 
to be handled properly, so they are better to be forbidden.

Users other than memory regions may still have backward pointers that 
are not properly tracked, so the Rust wrapper of object_ref() is still 
marked unsafe.

Regards,
Akihiko Odaki

