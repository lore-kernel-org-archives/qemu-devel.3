Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041CDCAC58F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Sep 2025 09:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxio7-0003PV-0J; Sun, 14 Sep 2025 05:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uxinn-0003MR-LM; Sun, 14 Sep 2025 05:13:43 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uxing-0001e9-24; Sun, 14 Sep 2025 05:13:41 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58E96jAq002655
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 14 Sep 2025 18:06:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TBXhmjS2UYQQhykvCCuPEf4Ur3c4iOpaKcaar+wZhi8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1757840806; v=1;
 b=CzbUVdN2qIGLGmbfozmILjqc8IOQDNHtnfYyChsQGwu+Rc8IAjwrXWVsxjZwIES3
 B3d/Ylfld47u3B0/gfHZRp/t0G2T7LaBiZEW+OtoRz2uBUmR78Rgw5bl0b8TlwFO
 lKct5pMvJWrXSnMEVgWoiJ76d5UGxW9k37dmJOhPU9XomudEWeVcWR8Qr+4NNfyr
 c3qANq6iqcPYHxk8VQkJE72veh+hTWNGqHxYEp1p2mOy4ShnjX2wnNYRxxEB7e0P
 vkcbB8ZOqSSz9QbeGccv4nlohrKKr/0iadvfyHf566MOALItMgF8hx0G6DLhMSiJ
 RQI8CT+54rpckezPoaai6Q==
Message-ID: <04eac866-74ea-46ae-9170-aa3ad5fc1b11@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 14 Sep 2025 18:06:44 +0900
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
 <4d91c86f-4e3d-4850-8b8c-77ad3c9d5bce@rsg.ci.i.u-tokyo.ac.jp>
 <aMSQDuVacnSG3MTV@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aMSQDuVacnSG3MTV@x1.local>
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

On 2025/09/13 6:26, Peter Xu wrote:
> On Fri, Sep 12, 2025 at 11:09:51AM +0900, Akihiko Odaki wrote:
>>>>> I think it still makes some sense to theoretically allow object_unparent()
>>>>> to happen, at least when it happens before owner's finalize().  IIUC that
>>>>> was the intention of the doc, pairing the memory_region_init*() operation.
>>>>
>>>> Perhaps so, but this patch is only about the case where object_unparent() is
>>>> called in finalize().
>>>
>>> You ignored my other comment.  That (using object_new() on MRs) was what I
>>> was thinking might be better than a split model you discussed here, so
>>> that's also a comment for patch 1 of your series.
>>
>> I'm not sure what you mean by the "split model".
> 
> I meant after similar change as what this patch proposes, (a) "owner of the
> MR lifecycle" (aka, who decides to finalize() the MR) is not the same as
> (b) "owner of the memory" (aka, who decides to free() the memory backing
> the MR struct), so the ownership model itself is more or less "split".
> 
> Now it's very hard to tell who owns the MR, because each owns only part of
> it.
> 
> IMHO it'll be slightly better to have the instance lifecycle and the memory
> allocation of the MR struct be managed by the same object, no matter
> automatically by the memory core, or manually by the device (in the case of
> the current doc, it went with the latter, even though I agree with you it
> looks wrong).

The instance lifecycle and the memory allocation is managed by the same 
object (i.e., the owner). When the owner is being finalized, the owner 
performs the following operations in order in object_finalize():

1. Unparent all children.
2. Call the instance_finalize() callback.

We can say the timing is "split", but the split timing exists even 
without this patch; unparenting happens before instance_finalize(), 
which calls g_free(), with or without this patch. Fixing the split 
timing can be done later.

> 
>>
>> This change removes object_unparent() in vfio_bars_finalize(). object_new()
>> will allow removing even g_free(), but we can do these changes
>> incrementally:
>> 1. remove object_unparent() in finalize(),
>>     which fixes a semantic problem (this patch)
>> 2. allow object_new() for MRs and remove g_free() in finalize()
>>     as a refactoring.
>>
>> So I suggest focusing on object_unparent() in finalize() to keep this patch
>> and review concise.
> 
> I agree that is the minimal change, but this is a common pattern.  It's not
> high risk, so I think we could still discuss it thoroughly.
> 
> I further analyzed the risk here, it turns out object_unparent() in
> finalize() is still very safe so the current code is actually bug-free if
> it all works similarly like the vfio code: The object_property_del_all()
> (on top of the owner device) would do prop->release(), and here MR will
> kickoff object_finalize_child_property(), which resets mr->parent to NULL.
> 
> So the 2nd object_unparent() will already see obj->parent==NULL.
> 
> Directly dropping object_unparent() should work, but leads to confusion as
> "split ownership model" as I discussed above.
> 
> Thanks to all recent discussions, IMHO we have much clearer picture of how
> MRs can be used.  I discussed it almostly in the first reply:
> 
> https://lore.kernel.org/all/aMHidDl1tdx-2G4e@x1.local/
> 
> I suspect we don't really have 2nd user I mentioned, because if so it'll
> likely require strict mr refcounting due to address_space_map(), in which
> case we should go the "create a temp obj as the owner of MR" idea, that you
> used to fix the virgl issue in patch 2 of your other series.
> 
> For the current issue, I'd suggest as simple as below (I observed at least
> the current VFIO use case only uses MMIO memory regions, so we only need
> one such helper):
> 
> /*
>   * Unlike memory_region_init_io(), @memory_region_alloc_io allocates an IO
>   * memory region object and returns.
>   *
>   * After the function returns, the MemoryRegion object will share the same
>   * lifecycle of the owner object.  If owner is not specified, the MR will
>   * never be released.
>   *
>   * The caller doesn't need to either detach or unref/free the MR object.
>   * It will be automatically detached and returned when the owner finalize.
>   * The caller can cache the MR object pointer, but it's only valid to
>   * operate before the owner finalizes.
>   */
> MemoryRegion *
> memory_region_alloc_io(MemoryRegion *mr,
>                         Object *owner,
>                         const MemoryRegionOps *ops,
>                         void *opaque,
>                         const char *name,
>                         uint64_t size)
> {
>      MemoryRegion = object_new(TYPE_MEMORY_REGION);
>      memory_region_do_init(mr, owner, name, size);
>      mr->ops = ops ? ops : &unassigned_mem_ops;
>      mr->opaque = opaque;
>      mr->terminates = true;
> }
> 
> Here, IIUC if we can allocate the MR using memory_region_alloc_io() here,
> then the ownership of both (a)+(b) above will be done automatically by the
> memory core / object core code.  The device impl doesn't need to care about
> either removal of subregions, or free of MR struct, anymore.  Then we can
> drop not only the object_unparent(), but also g_free(), altogether.
> 
> Would that sound like a better approach in general?
> 
> Again, I don't think this is anything urgent, so we can take time to think
> it through.
It makes sense to have a through review, but my argument here is the 
de-duplication of object_unparent() and the replacement of g_free() with 
object_new() are logically distinct and should be split into distinct 
patches. Each patch can independently have through review, be 
applied/backported, or be reverted in case of regression.

Regards,
Akihiko Odaki

