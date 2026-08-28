Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBAEC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzwkJ-0003vW-HG; Fri, 28 Aug 2026 09:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzwkH-0003vK-Ll
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 09:35:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzwkE-0001KK-Ek
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 09:35:49 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67SDZMmx075768
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 28 Aug 2026 22:35:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=p9I7J0hiuXLrZCLsMO+Rt5F7X9GhI/D8uWXaTr/36l0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787924123; v=1;
 b=Df++MGC9Oy8jX5F/DFk0GhzVbpT7qR8vk5LDkC64Bnb7CxLbpV2q7dVYw4G1k8ZK
 WHL8NM6+c33o5nTEtCn0azxfqA5T/0Q5F7Og6MBKKgEc5+Jr/uKC8btFIa42EM36
 rUA9faiXvkWyAtSXV+SctaAYFXyB2mjfckOfsvAz0pxMympIGFHh80M7b1IE10/V
 81Ir9AvaYWGO/BkUKiU6NrivkiOn1n1ikqg484C1kpaaT9gVNi/V8dqs0SwSPJEW
 dVbWXAa5qynd361oBw6GSWVMuE/9y8gHi7zePooAA12c9SXOXgx8msdhtn+thJJd
 maDb/QsMXx+R/hcLo/K1IA==
Message-ID: <a523e460-b861-464f-9579-b160a14c7126@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 28 Aug 2026 22:35:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] RFC: various virtio-gpu/dmabuf related fixes
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 swing <swing@mail.exp.sh>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
 <a0bd3ef2-91df-4a6d-a04f-67a568188b24@rsg.ci.i.u-tokyo.ac.jp>
 <d71116d3-2108-4f14-baa0-d2f1f878b5f4@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1C+BPPLcko6nqK5vCTn81D=CHv3m_bvqDiQzbc-shY1S2A@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1C+BPPLcko6nqK5vCTn81D=CHv3m_bvqDiQzbc-shY1S2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/08/28 21:37, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Aug 28, 2026 at 4:29 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/08/28 21:26, Akihiko Odaki wrote:
>>> On 2026/08/25 19:20, Marc-André Lureau wrote:
>>>> Hi,
>>>>
>>>> While working on CVE-2026-66020 (which had a few revision on list), I
>>>> kept finding several places where virtio-gpu scanout and dmabuf
>>>> ownership was unclear.
>>>>
>>>> The CVE comes from using a blob after RESOURCE_DETACH_BACKING has
>>>> unmapped its memory. Following that path also found stale dmabuf
>>>> references, duplicated scanout bookkeeping, and inconsistent cleanup
>>>> between display backends.
>>>>
>>>> This series makes each virtio_gpu_scanout own its current dmabuf and
>>>> uses resource_id to track which resource it displays. It also makes
>>>> QemuDmaBuf own its file descriptors and moves GTK fence state out of the
>>>> dmabuf.
>>>>
>>>> Those changes touch a lot of area and I have done basic testing with the
>>>> various backends. I would not recommend backporting them to stable:
>>>> there is a high risk of introducing regressions. Yet, I don't know how
>>>> to address all the problems uncovered by CVE-2026-66020 in a simple
>>>> patch series. Help welcome!
>>>
>>> If you mean "all the problems", my coding agent tells there are some
>>> problems remaining:
>>
>> I forgot to note that I manually reviewed the claims.
>>
>> I also think you can drop RFC. Though the series is large, each patch is
>> small and I think reasonable.
>>
>>>
>>> 1. Vhost-user still has duplicate, incomplete DMA-BUF ownership.
>>>
>>> VhostUserGPU retains its separate g->dmabuf[]. The contrib backend
>>> disables a scanout using ordinary VHOST_USER_GPU_SCANOUT with zero
>>> dimensions, but the QEMU frontend handles that by only calling
>>> qemu_console_set_surface().
>>>
>>> Although that changes con->scanout.kind, it neither releases g-
>>>   >dmabuf[id] nor invokes the frontend GL-disable callback. GTK/SDL can
>>> therefore retain their private scanout mode and redraw the old buffer;
>>> the wrapper and owned fd remain until another DMA-BUF message. Reset and
>>> finalize also never free this array.
>>>
>>> Separately, contrib’s virgl RESOURCE_UNREF destroys the renderer
>>> resource without disabling scanouts using it. The in-process virgl
>>> backend fixes precisely this case, but contrib does not.
>>>
>>> 2. GTK DMA-BUF texture release lacks the required GL context.
>>>
>>> GTK’s release callback directly calls egl_dmabuf_release_texture(),
>>> which calls glDeleteTextures() and then unconditionally forgets the
>>> texture ID. Neither it nor the core release dispatcher establishes the
>>> owning context.
>>>
>>> This is reachable after another GTK console’s surface update leaves
>>> EGL_NO_CONTEXT current. Deletion is then not guaranteed, yet the ID is
>>> lost, leaking the GL import and backing. With another unshared context
>>> current, a coincident texture name could be deleted from the wrong
>>> context. SDL has the same missing-context pattern.
>>>
>>> 3. Rutabaga resource destruction remains incomplete.
>>>
>>> virtio_gpu_rutabaga_resource_unref() calls Rutabaga unref and frees the
>>> QEMU resource, but does not clean res->iov/res->addrs or remove a mapped
>>> blob’s host-visible MemoryRegion. Only explicit RESOURCE_UNMAP_BLOB
>>> removes that region.
>>>
>>> Consequently, MAP_BLOB → RESOURCE_UNREF or reset can leave a
>>> MemoryRegion pointing at storage destroyed by Rutabaga, as well as
>>> pinned DMA mappings. This is adjacent to, rather than the original
>>> scanout-detach CVE, but it is another unresolved blob-ownership problem.
>>>
>>> ...so there is still some work to be done.
> 
> Thanks for the analysis. Do you think we can review & apply this
> series first before addressing the remaining issues? (and helping me
> :)

For vhost-user and Rutabaga, yes: I think we can review this series 
without making it solve every ownership problem first. Those paths are 
separate and can be follow-ups.

It may be better to handle the GTK/SDL context issue before applying the 
series, though. The callback already existed, but patches 7 and 10 add 
release-on-disable and release-on-detach callers. They can invoke 
glDeleteTextures() with no context, or with another console's context 
current. A small additional patch should suffice; this does not require 
keeping the series as RFC.

> 
>>>
>>> But when it comes to backporting, I think we can instead do focused
>>> backporting to avoid extra trouble. Concretely, the patches you tagged
>>> with "Fixes: CVE-2026-66020" can be backported, namely:
>>>
>>> - "[PATCH 10/18] virtio-gpu: disable blob scanouts on mapping cleanup" and
>>> - "[PATCH 18/18] virtio-gpu: fix use-after-free on blob cursor after
>>> detach"
> 
> Cc: qemu-stable for those two only? even if there are still corner
> cases addressed by the other patches)?

Yes. I don't think the other corner cases are worthwhile to fix risking 
a regression.

But rechecking these patches, I found "[PATCH 18/18] virtio-gpu: fix 
use-after-free on blob cursor after detach" has two dependencies on the 
earlier patches:

- Patch 6 changes the signature of virtio_gpu_fini_udmabuf().
- Patch 17 allows removing the res->blob guard in
   virtio_gpu_cleanup_mapping().

So I suggest:

- reordering the series to put patch 10 and patch 18 at the first,
- keeping the res->blob guard in patch 18, and
- dropping the res->blob guard in patch 17 instead.

Regards,
Akihiko Odaki

