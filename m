Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A63E6F072
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 17:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6vSC-0007EY-TA; Fri, 01 Nov 2024 13:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t6vSA-0007EO-K2
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:28:54 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t6vS7-0008Ks-JA
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:28:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1730482120; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J99SfHBWG3VJeAnbdnAXaS3wfi3+aCuX4fIJ9ASorGaJRK6zaPEP1gGFT5CIT372IpXvlrMfoU4HS50RAmpV/D3WywBtSvcs1/mEPNkHw9PF9/EVagR1SEBkCjUHzbjQNJJLaypnJAvjILfllPHeeMusVT5KZgXdLiu5GrcziaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730482120;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xXV9dku7wn1JRr3xdqYwWpqUl989cxNml2ClDR9QVlY=; 
 b=n5J3oHZ689ed7ZNoBNWCvAkDwqh22rb0j1iD6jbVMuyTe5rEPn6ybRlCbMk/OEaa81oKCZxHUYdrBtC9lHbyKRlTws+Mi5MVGMPCebiHyYXsa1YQstkZIr71BNvw73ef8U5ZmVD/XxrYeiGGsnJMg9BibcxCKPoBBtl0sHcNLD0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730482120; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=xXV9dku7wn1JRr3xdqYwWpqUl989cxNml2ClDR9QVlY=;
 b=A3SGy7gz9QlvFHWdROQhQLtikIunB+SqqTZr1E/EgpTvH7DhnXPyfvX2mXK63Qmx
 6wp4at1j4wFdht4KIa9/aPU6I1/DukzQA+AyJbyp/bG5lW1G9wF+HqSjJrbRmfIp/bj
 fI/zTwDbe4ONW2XBf9+qZ8CGmSgkg46Aj/MPpPZo=
Received: by mx.zohomail.com with SMTPS id 1730482119370629.6870538725124;
 Fri, 1 Nov 2024 10:28:39 -0700 (PDT)
Message-ID: <c3bfee50-bb0d-488d-aeac-d2c02c392b30@collabora.com>
Date: Fri, 1 Nov 2024 20:28:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] virtio-gpu: Support asynchronous fencing
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
 <20241024233355.136867-6-dmitry.osipenko@collabora.com>
 <02b3051b-c062-4418-9ebf-8c9011d87842@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <02b3051b-c062-4418-9ebf-8c9011d87842@daynix.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/31/24 10:44, Akihiko Odaki wrote:
> On 2024/10/25 8:33, Dmitry Osipenko wrote:
>> Support asynchronous fencing feature of virglrenderer. It allows Qemu to
>> handle fence as soon as it's signalled instead of periodically polling
>> the fence status. This feature is required for enabling DRM context
>> support in Qemu because legacy fencing mode isn't supported for DRM
>> contexts in virglrenderer.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   hw/display/virtio-gpu-gl.c     |   3 +
>>   hw/display/virtio-gpu-virgl.c  | 138 +++++++++++++++++++++++++++------
>>   include/hw/virtio/virtio-gpu.h |  13 ++++
>>   3 files changed, 132 insertions(+), 22 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>> index 7c0e448b4661..53d938f23f20 100644
>> --- a/hw/display/virtio-gpu-gl.c
>> +++ b/hw/display/virtio-gpu-gl.c
>> @@ -170,6 +170,9 @@ static void
>> virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>>       if (gl->renderer_state >= RS_INITED) {
>>   #if VIRGL_VERSION_MAJOR >= 1
>>           qemu_bh_delete(gl->cmdq_resume_bh);
>> +
>> +        virtio_gpu_virgl_reset_async_fences(g);
>> +        qemu_bh_delete(gl->async_fence_bh);
>>   #endif
>>           if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>>               timer_free(gl->print_stats);
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-
>> virgl.c
>> index 3c564683820b..37b40e258398 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -891,6 +891,7 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>>   void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>                                         struct virtio_gpu_ctrl_command
>> *cmd)
>>   {
>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>       bool cmd_suspended = false;
>>       int ret;
>>   @@ -992,34 +993,71 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>         trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd-
>> >cmd_hdr.type);
>>   -    /*
>> -     * Unlike other virglrenderer functions, this one returns a positive
>> -     * error code.
>> -     */
>> -    ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
>> -    if (ret)
>> -        qemu_log_mask(LOG_GUEST_ERROR,
>> -                      "%s: virgl_renderer_create_fence error: %s",
>> -                      __func__, strerror(ret));
>> +    if (gl->context_fence_enabled &&
>> +        (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX)) {
>> +        uint32_t flags = 0;
>> +
>> +        ret = virgl_renderer_context_create_fence(cmd-
>> >cmd_hdr.ctx_id, flags,
>> +                                                  cmd->cmd_hdr.ring_idx,
>> +                                                  cmd-
>> >cmd_hdr.fence_id);
>> +        if (ret)
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s: virgl_renderer_context_create_fence
>> error: %s",
>> +                          __func__, strerror(-ret));
>> +    } else {
>> +        /*
>> +         * Unlike other virglrenderer functions, this one returns a
>> positive
>> +         * error code.
>> +         */
>> +        ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
>> +        if (ret)
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s: virgl_renderer_create_fence error: %s",
>> +                          __func__, strerror(ret));
>> +    }
>>   }
>>   -static void virgl_write_fence(void *opaque, uint32_t fence)
>> +static void virtio_gpu_virgl_async_fence_bh(void *opaque)
>>   {
>> -    VirtIOGPU *g = opaque;
>> +    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
>>       struct virtio_gpu_ctrl_command *cmd, *tmp;
>> +    struct virtio_gpu_virgl_context_fence *f;
>> +    VirtIOGPU *g = opaque;
>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>   -    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
>> -        /*
>> -         * the guest can end up emitting fences out of order
>> -         * so we should check all fenced cmds not just the first one.
>> -         */
>> -        if (cmd->cmd_hdr.fence_id > fence) {
>> -            continue;
>> +    QSLIST_MOVE_ATOMIC(&async_fenceq, &gl->async_fenceq);
>> +
>> +    while (!QSLIST_EMPTY(&async_fenceq)) {
>> +        f = QSLIST_FIRST(&async_fenceq);
>> +
>> +        QSLIST_REMOVE_HEAD(&async_fenceq, next);
>> +
>> +        QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
>> +            /*
>> +             * the guest can end up emitting fences out of order
>> +             * so we should check all fenced cmds not just the first
>> one.
>> +             */
>> +            if (cmd->cmd_hdr.fence_id > f->fence_id) {
>> +                continue;
>> +            }
>> +            if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
>> +                if (cmd->cmd_hdr.ring_idx != f->ring_idx) {
>> +                    continue;
>> +                }
>> +                if (cmd->cmd_hdr.ctx_id != f->ctx_id) {
>> +                    continue;
>> +                }
>> +            } else if (f->ring_idx >= 0) {
>> +                /* ctx0 GL-query fences don't have ring info */
>> +                continue;
>> +            }
>> +            virtio_gpu_ctrl_response_nodata(g, cmd,
>> VIRTIO_GPU_RESP_OK_NODATA);
>> +            QTAILQ_REMOVE(&g->fenceq, cmd, next);
>> +            g_free(cmd);
>>           }
>> -        trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
>> -        virtio_gpu_ctrl_response_nodata(g, cmd,
>> VIRTIO_GPU_RESP_OK_NODATA);
>> -        QTAILQ_REMOVE(&g->fenceq, cmd, next);
>> -        g_free(cmd);
>> +
>> +        trace_virtio_gpu_fence_resp(f->fence_id);
>> +        g_free(f);
>>           g->inflight--;
>>           if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>>               trace_virtio_gpu_dec_inflight_fences(g->inflight);
>> @@ -1027,6 +1065,50 @@ static void virgl_write_fence(void *opaque,
>> uint32_t fence)
>>       }
>>   }
>>   +void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g)
>> +{
>> +    struct virtio_gpu_virgl_context_fence *f, *f_tmp;
>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>> +
>> +    QSLIST_FOREACH_SAFE(f, &gl->async_fenceq, next, f_tmp) {
>> +        QSLIST_REMOVE(&gl->async_fenceq, f,
>> virtio_gpu_virgl_context_fence,
>> +                      next);
> 
> Replace QSLIST_FOREACH_SAFE() and QSLIST_REMOVE() with QSLIST_EMPTY(),
> QSLIST_FIRST() and QSLIST_REMOVE_HEAD() as you have done for
> virtio_gpu_virgl_async_fence_bh().

Ack

-- 
Best regards,
Dmitry

