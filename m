Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C020D2ECF3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 21:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhwzw-0002IU-Il; Mon, 19 Jan 2026 16:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vhwzv-0002G2-CK
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:41:19 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vhwzt-0003Sw-7i
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:41:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1768858859; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SG3enuD/4oyeD8iPun3GMwfwolIlQKdObY6F2d/UPgVtWAa25ugZIjmMe4homJxlxkSR4EMIEeBxfkawR6p1qdCiHB075XPCldmqQbwGGGqpW+IVBHysJc1gaANPNRMF7hKpQGrKjww45cUQhPj+7YCNj2mXsBzEIdKRGuIKVB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768858859;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xhwCRbx4cjp2IpZrG7sRkybgnIqhXbxjo05ipNa5APs=; 
 b=eA0izDtKYQfgnrOzo+eT5hMqDC3x3kw/hbkbbWyLHqkf4fi6pOC7Dt5HSv28b1+euBoPXWpVYDY8tKi4c5Klpa1niqjB/vgkK7QDaq1KokdQJRRqchiOoWNk1OcFI43muVHTt1XRlpqahhTTxnugFhwDX3WWqKXOBTuhpDwtVuc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768858859; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=xhwCRbx4cjp2IpZrG7sRkybgnIqhXbxjo05ipNa5APs=;
 b=U3o1q+gBHUAn0W8OMN0rHri3lq3YMNd8u2H6mux2yLqMh0im1xWRUq0ZMbd+oJ5c
 s8c0ExRvFOX2VSxqQtbD0+0Hxz3f6GJR25JcTpJ3iniQDv7xcP1fG0LjNOuH3Nhx0dE
 rgFoZI2/OMugYSJ7EUgclLMEPh4Uj/elMS5lxU0g=
Received: by mx.zohomail.com with SMTPS id 1768858857895970.930405994819;
 Mon, 19 Jan 2026 13:40:57 -0800 (PST)
Message-ID: <e2219c76-1c4b-46e5-8b96-a04884880a88@collabora.com>
Date: Tue, 20 Jan 2026 00:40:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/5] virtio-gpu: Replace finish_unmapping with
 mapping_state
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20260112225246.3526313-1-dmitry.osipenko@collabora.com>
 <20260112225246.3526313-4-dmitry.osipenko@collabora.com>
 <1011721c-cc29-4e85-a6fe-c26398685ba1@rsg.ci.i.u-tokyo.ac.jp>
 <72a78f94-97cc-4523-bb05-514a3c5f45d7@collabora.com>
 <b7c6f158-f263-4e19-b30c-406312cbee93@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <b7c6f158-f263-4e19-b30c-406312cbee93@rsg.ci.i.u-tokyo.ac.jp>
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

On 1/19/26 08:54, Akihiko Odaki wrote:
> On 2026/01/19 1:28, Dmitry Osipenko wrote:
>> On 1/13/26 07:51, Akihiko Odaki wrote:
>>> On 2026/01/13 7:52, Dmitry Osipenko wrote:
>>>> Allow virtio_gpu_virgl_unmap_resource_blob() to be invoked while async
>>>> unmapping is in progress. Do it in preparation to improvement of
>>>> virtio-gpu
>>>> resetting that will require this change.
>>>>
>>>> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> ---
>>>>    hw/display/trace-events       |  2 +-
>>>>    hw/display/virtio-gpu-virgl.c | 28 +++++++++++++++++++++++-----
>>>>    2 files changed, 24 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/display/trace-events b/hw/display/trace-events
>>>> index e323a82cff24..4bfc457fbac1 100644
>>>> --- a/hw/display/trace-events
>>>> +++ b/hw/display/trace-events
>>>> @@ -39,7 +39,7 @@ virtio_gpu_cmd_res_create_2d(uint32_t res, uint32_t
>>>> fmt, uint32_t w, uint32_t h)
>>>>    virtio_gpu_cmd_res_create_3d(uint32_t res, uint32_t fmt, uint32_t w,
>>>> uint32_t h, uint32_t d) "res 0x%x, fmt 0x%x, w %d, h %d, d %d"
>>>>    virtio_gpu_cmd_res_create_blob(uint32_t res, uint64_t size) "res
>>>> 0x%x, size %" PRId64
>>>>    virtio_gpu_cmd_res_map_blob(uint32_t res, void *vmr, void *mr) "res
>>>> 0x%x, vmr %p, mr %p"
>>>> -virtio_gpu_cmd_res_unmap_blob(uint32_t res, void *mr, bool
>>>> finish_unmapping) "res 0x%x, mr %p, finish_unmapping %d"
>>>> +virtio_gpu_cmd_res_unmap_blob(uint32_t res, void *mr, int
>>>> mapping_state) "res 0x%x, mr %p, mapping_state %d"
>>>>    virtio_gpu_cmd_res_unref(uint32_t res) "res 0x%x"
>>>>    virtio_gpu_cmd_res_back_attach(uint32_t res) "res 0x%x"
>>>>    virtio_gpu_cmd_res_back_detach(uint32_t res) "res 0x%x"
>>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-
>>>> virgl.c
>>>> index 6a2aac0b6e5c..342e93728df0 100644
>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>> @@ -68,10 +68,16 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>>>>    #endif
>>>>      #if VIRGL_VERSION_MAJOR >= 1
>>>> +enum virtio_gpu_virgl_hostmem_region_mapping_state {
>>>> +    VIRTIO_GPU_MR_MAPPED,
>>>> +    VIRTIO_GPU_MR_UNMAP_STARTED,
>>>> +    VIRTIO_GPU_MR_UNMAP_COMPLETED,
>>>> +};
>>>> +
>>>>    struct virtio_gpu_virgl_hostmem_region {
>>>>        MemoryRegion mr;
>>>>        struct VirtIOGPU *g;
>>>> -    bool finish_unmapping;
>>>> +    enum virtio_gpu_virgl_hostmem_region_mapping_state mapping_state;
>>>>    };
>>>>      static struct virtio_gpu_virgl_hostmem_region *
>>>> @@ -95,7 +101,7 @@ static void
>>>> virtio_gpu_virgl_hostmem_region_free(void *obj)
>>>>        VirtIOGPUGL *gl;
>>>>          vmr = to_hostmem_region(mr);
>>>> -    vmr->finish_unmapping = true;
>>>> +    vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_COMPLETED;
>>>>          b = VIRTIO_GPU_BASE(vmr->g);
>>>>        b->renderer_blocked--;
>>>> @@ -135,6 +141,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>>          vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>>>>        vmr->g = g;
>>>> +    vmr->mapping_state = VIRTIO_GPU_MR_MAPPED;
>>>>          mr = &vmr->mr;
>>>>        memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>>>> @@ -171,7 +178,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>>>>          vmr = to_hostmem_region(res->mr);
>>>>    -    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr,
>>>> vmr->finish_unmapping);
>>>> +    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr,
>>>> +                                        vmr->mapping_state);
>>>>          /*
>>>>         * Perform async unmapping in 3 steps:
>>>> @@ -182,7 +190,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>>>>         *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
>>>>         * 3. Finish the unmapping with final
>>>> virgl_renderer_resource_unmap().
>>>>         */
>>>> -    if (vmr->finish_unmapping) {
>>>> +    switch (vmr->mapping_state) {
>>>> +    case VIRTIO_GPU_MR_UNMAP_COMPLETED:
>>>>            res->mr = NULL;
>>>>            g_free(vmr);
>>>>    @@ -193,15 +202,24 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU
>>>> *g,
>>>>                              __func__, strerror(-ret));
>>>>                return ret;
>>>>            }
>>>> -    } else {
>>>> +        break;
>>>> +
>>>> +    case VIRTIO_GPU_MR_MAPPED:
>>>>            *cmd_suspended = true;
>>>>              /* render will be unblocked once MR is freed */
>>>>            b->renderer_blocked++;
>>>>    +        vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_STARTED;
>>>> +
>>>>            /* memory region owns self res->mr object and frees it by
>>>> itself */
>>>>            memory_region_del_subregion(&b->hostmem, mr);
>>>>            object_unparent(OBJECT(mr));
>>>> +        break;
>>>
>>> I suggest:
>>>
>>> - Put vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_STARTED; here
>>> - Remove *cmd_suspended = true for VIRTIO_GPU_MR_MAPPED.
>>> - Let it fall through.
>>>
>>> This way, it is clear that we need to execute *cmd_suspended = true
>>> because the state is now VIRTIO_GPU_MR_UNMAP_STARTED, and we can save on
>>> line by not having a duplicate *cmd_suspended = true.
>>
>> The `mapping_state = VIRTIO_GPU_MR_UNMAP_STARTED` shall be set before
>> memory_region_del_subregion() is invoked because technically refcounting
>> logic may change in future and MR may become freed instantly. Will only
>> add the fall-through if no objections, otherwise please comment on v10.
> 
> That makes sense.
> 
> Strictly speaking, even if the refcounting change happens,
> qemu_bh_schedule(gl->cmdq_resume_bh) will delay the next invocation of
> this function in virtio_gpu_virgl_hostmem_region_free(). But even
> virtio_gpu_virgl_hostmem_region_free() can be changed in the future so I
> no longer believe moving `mapping_state = VIRTIO_GPU_MR_UNMAP_STARTED`
> is absolutely good. Please choose a design option you prefer.

virtio_gpu_virgl_hostmem_region_free() changes state to UNMAP_COMPLETED,
hence the UNMAP_STARTED need to be set before region_free() invoked.
Will keep the v10 variant then, thanks.

-- 
Best regards,
Dmitry

