Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57980E81A36
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 15:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs0aN-0001s4-ER; Mon, 16 Feb 2026 10:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vs0a1-0001ql-7r
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:32:10 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vs0Zx-0006Fw-7o
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:32:07 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771255911; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RTuPgXRmPwTmsr7H6KkdIWUSklt1NhLSlrv3FI/wnmE2OGAMgZHQ+xBhyia5sZw27J3WCs126jtJ8PxfxPWOGCDhQi5xClaMNer51H6Py0IcYGW2We73oytspUcIl8T6D4A2hSSu2EeP6GK6KkrsdDPfD8kMDFXPAI9XDg6hnVs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771255911;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FMJSWG7Mrnv23BkTetVWAPtjdiqd/i4OA66AdogcaJ4=; 
 b=bYVDFuIpnQJruoqdyM2ru2y4zrkBVgcpQicIlUmBNzYjD/4Nhn2Y+Su6BOMQoDK6RZ80kXfLUoZdIJeqPl31KJRnydr6j6G9W+JPuGHLF/KnJxLv5HdnIPHcS3k2OKVCtx3rwH6mcQw78pifMc9RPe68+gxxr/+PZIdAxMnkGhg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771255911; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=FMJSWG7Mrnv23BkTetVWAPtjdiqd/i4OA66AdogcaJ4=;
 b=f11cJAUKswmvBwWL0xn8ix+OfphVatRJUol9MzAsgefntDlouTbJHX9reau3bYjZ
 hPhEjYHwvsYXeMybGjN4qMeqE1yy/0EMa/mx+bsV7t7EjQPBf0Vgg9NPqYsGu8iqlWR
 Gzf66qd4r+wfr0F9WM1nZlq6wKJHqIt25iVbY33w=
Received: by mx.zohomail.com with SMTPS id 1771255910464966.1265953868796;
 Mon, 16 Feb 2026 07:31:50 -0800 (PST)
Message-ID: <572a9584-cdc6-4fa1-88bd-f0aec5f82d2d@collabora.com>
Date: Mon, 16 Feb 2026 18:31:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
To: Joelle van Dyne <j@getutm.app>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <CAFEAcA_8jB_KLzUzLS1=uG3y-nRRK_C2ZZp9SwKo1WrGu8dJkQ@mail.gmail.com>
 <87tsvkmxb5.fsf@draig.linaro.org>
 <CA+E+eSDZ+nrxT8=JKGvBJSO3b8cVoD-U1f+E0rhn-ZK7zePHrA@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CA+E+eSDZ+nrxT8=JKGvBJSO3b8cVoD-U1f+E0rhn-ZK7zePHrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/13/26 22:48, Joelle van Dyne wrote:
> On Fri, Feb 13, 2026 at 8:18 AM Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Wed, 4 Feb 2026 at 19:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> From: Joelle van Dyne <j@getutm.app>
>>>>
>>>> When `owner` == `mr`, `object_unparent` will crash:
>>>>
>>>> object_unparent(mr) ->
>>>> object_property_del_child(mr, mr) ->
>>>> object_finalize_child_property(mr, name, mr) ->
>>>> object_unref(mr) ->
>>>> object_finalize(mr) ->
>>>> object_property_del_all(mr) ->
>>>> object_finalize_child_property(mr, name, mr) ->
>>>> object_unref(mr) ->
>>>> fail on g_assert(obj->ref > 0)
>>>>
>>>> However, passing a different `owner` to `memory_region_init` does not
>>>> work. `memory_region_ref` has an optimization where it takes a ref
>>>> only on the owner. That means when flatviews are created, it does not
>>>> take a ref on the region and you can get a UAF from `flatview_destroy`
>>>> called from RCU.
>>>>
>>>> The correct fix therefore is to use `NULL` as the name which will set
>>>> the `owner` but not the `parent` (which is still NULL). This allows us
>>>> to use `memory_region_ref` on itself while not having to rely on unparent
>>>> for cleanup.
>>>>
>>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Message-Id: <20260103214400.71694-1-j@getutm.app>
>>>> ---
>>>>  hw/display/virtio-gpu-virgl.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>>> index 07f6355ad6..6a83fb63c8 100644
>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>> @@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>>      vmr->g = g;
>>>>
>>>>      mr = &vmr->mr;
>>>> -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>>>> +    memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, data);
>>>
>>> This looks very odd. The owner of an MR should be the
>>> device that that MR belongs to, not the MR itself,
>>> and usually not NULL either. The name should be something
>>> useful for people looking at the HMP info output about
>>> memory layouts.
> The owner of the MR was set to itself before the change and this
> caused a crash on my ARM64 host (I'm not sure why this wasn't a issue
> beforehand on other architectures, I suspect it was a race condition
> that was always won before). The original fix (see v2) was to call
> memory_region_init_ram_ptr() with "owner" set to VirtIOGPU *g and then
> manually setting "mr->owner = OBJECT(mr)" after the call, thus
> breaking the self <-> parent loop that caused the original crash.
> However, this was brittle as we were modifiying MR internals outside
> of MR APIs so the suggestion was made to use NULL for "name" and
> "object_unref" instead of "object_unparent" in cleanup. This MR was
> properly an orphan and does not have a parent. We depended on the
> behavior of "memory_region_do_init" to not call
> "object_property_add_child" when "name" is NULL. The APIs were not
> clear if "name" is allowed to be NULL but the existance of that code
> path led to the assumption that NULL was permitted as an argument.
> Obivously this assumption was flawed as the crash log that Dmitry
> shared showed that cpr_name() in physmem.c will return NULL and this
> causes the NULL name to be passed to cpr_delete_fd(). There might be
> other places that expect the name to be non-NULL as well.
> 
>>>
>>> If there's a use-after-free issue then I suspect that the right
>>> fix must be somewhere else, not here.
> The obivous fix is to revert the change but the original crash
> referenced in the patch will still be an issue. Alternatively, it
> seems that the v2 version is unclean but can still work because we
> just need the MR to not have itself as the parent. This would be the
> minimal patch that addresses both issues. (A proper fix should also
> remove the code path in memory_region_do_init() for when name is NULL
> and instead return an error because that path is invalid.) Another
> alternative would be to modify the MR APIs with a clear way to create
> an orphan MR. Finally, object_unparent() could recognize when the
> object is its own parent and handle that case gracefully. Let me know
> what people's preferred solution is and I'll whip up a patch.
> 
>>
>> The blobs really cause issues for our MemoryRegion code because they are
>> transient and aren't easily cleaned up with RCU because of the dance we
>> have to do between qemu and virglrenderer for the underlying memory.
>> There have been multiple attempts to clean this up and so far I don't
>> think we've managed to reach a solid solution.

Thanks for the clarification. Curious which gfx mode showed this
problem, virgl or venus? What's the GPU card/model on host?

-- 
Best regards,
Dmitry

