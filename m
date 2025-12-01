Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB04D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 14:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ51P-0006pZ-4k; Mon, 01 Dec 2025 09:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vQ51I-0006nc-Iz
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:36:53 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vQ51G-0002dS-Km
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:36:52 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1764599784; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cYA55ZAs8x4W1TTDBS0wmDWE28tPZc20WMA5yIqvR5q3xH0PH1AWJIYsjLjmC+wJOtlTN6rd7Yn6pTKhBKcvkNqMelowthZpDyVTAgG5cYRgAqtsQ7YLHtfMN+2gCCmYaqTW8YHzdX1P1hvon0BdjpOvjHbwR7+s+Rj+1m8YxpA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764599784;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=oYSz/gQ9J7vGJ/fM9QLfU2TnfqKauP8XTonMBdJ/iXI=; 
 b=ONVW+psf/k7zPWFV7RkBpO8Pui1bDtBeKScAUKSF3nd70//D0Rj8tPxR6c8cr53vBiIIbTBicCvS4al6jFKq1DqpRuJ6uv4RxLc9q6tGLMU99qTVABiX5ViCenRJVXZxY9wjOcF5AebVEeKyQrz26XZtMu3zg4gstfhpN4mf1D8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764599784; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=oYSz/gQ9J7vGJ/fM9QLfU2TnfqKauP8XTonMBdJ/iXI=;
 b=JIim0Uk79tXX9lnwnPDxEjjklLdCsWfSQpv4rNNMMjX500Lcpzzx/OLLtcCa7Id9
 Bo8DOB3p9rRzD/rBZ+Jd2mN3AVazxFkWmWfHl/ptZxxdqY1UDZt82t6eINyVZNs6Yx+
 ezUvHqMyumjtkxG5jfgi107H9ZKjIMwOdtZiYYqQ=
Received: by mx.zohomail.com with SMTPS id 1764599779076537.4177964358089;
 Mon, 1 Dec 2025 06:36:19 -0800 (PST)
Message-ID: <96b75cbb-7394-41ec-9013-625ea2d8d010@collabora.com>
Date: Mon, 1 Dec 2025 17:36:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 3/4] virtio-gpu: Destroy virgl resources on
 virtio-gpu reset
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
References: <20251130040940.1611949-1-dmitry.osipenko@collabora.com>
 <20251130040940.1611949-4-dmitry.osipenko@collabora.com>
 <97def678-f5cb-482c-b322-8337339f2d58@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <97def678-f5cb-482c-b322-8337339f2d58@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/1/25 14:57, Akihiko Odaki wrote:
> On 2025/11/30 13:09, Dmitry Osipenko wrote:
>> Properly destroy virgl resources on virtio-gpu reset to not leak
>> resources
>> on a hot reboot of a VM.
>>
>> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   hw/display/virtio-gpu-gl.c     |  6 ++-
>>   hw/display/virtio-gpu-virgl.c  | 87 ++++++++++++++++++++++++++--------
>>   include/hw/virtio/virtio-gpu.h |  5 +-
>>   3 files changed, 75 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>> index b640900fc6f1..bf3fd75e9e6b 100644
>> --- a/hw/display/virtio-gpu-gl.c
>> +++ b/hw/display/virtio-gpu-gl.c
>> @@ -72,7 +72,10 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice
>> *vdev, VirtQueue *vq)
>>         switch (gl->renderer_state) {
>>       case RS_RESET:
>> -        virtio_gpu_virgl_reset(g);
>> +        if (virtio_gpu_virgl_reset(g)) {
>> +            gl->renderer_state = RS_INIT_FAILED;
>> +            return;
>> +        }
>>           /* fallthrough */
>>       case RS_START:
>>           if (virtio_gpu_virgl_init(g)) {
>> @@ -201,6 +204,7 @@ static void virtio_gpu_gl_class_init(ObjectClass
>> *klass, const void *data)
>>       vgc->process_cmd = virtio_gpu_virgl_process_cmd;
>>       vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
>>   +    vgc->resource_destroy = virtio_gpu_virgl_resource_destroy;
>>       vdc->realize = virtio_gpu_gl_device_realize;
>>       vdc->unrealize = virtio_gpu_gl_device_unrealize;
>>       vdc->reset = virtio_gpu_gl_reset;
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-
>> virgl.c
>> index 6a2aac0b6e5c..60d8fbf0445c 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -304,14 +304,46 @@ static void
>> virgl_cmd_create_resource_3d(VirtIOGPU *g,
>>       virgl_renderer_resource_create(&args, NULL, 0);
>>   }
>>   +static int
>> +virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
>> +                                struct virtio_gpu_virgl_resource *res,
>> +                                bool *cmd_suspended)
>> +{
>> +    struct iovec *res_iovs = NULL;
>> +    int num_iovs = 0;
>> +#if VIRGL_VERSION_MAJOR >= 1
>> +    int ret;
>> +
>> +    ret = virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +    if (*cmd_suspended) {
>> +        return 0;
>> +    }
>> +#endif
>> +
>> +    virgl_renderer_resource_detach_iov(res->base.resource_id,
>> +                                       &res_iovs,
>> +                                       &num_iovs);
>> +    if (res_iovs != NULL && num_iovs != 0) {
>> +        virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
>> +    }
>> +    virgl_renderer_resource_unref(res->base.resource_id);
>> +
>> +    QTAILQ_REMOVE(&g->reslist, &res->base, next);
>> +
>> +    g_free(res);
>> +
>> +    return 0;
>> +}
>> +
>>   static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>                                        struct virtio_gpu_ctrl_command
>> *cmd,
>>                                        bool *cmd_suspended)
>>   {
>>       struct virtio_gpu_resource_unref unref;
>>       struct virtio_gpu_virgl_resource *res;
>> -    struct iovec *res_iovs = NULL;
>> -    int num_iovs = 0;
>>         VIRTIO_GPU_FILL_CMD(unref);
>>       trace_virtio_gpu_cmd_res_unref(unref.resource_id);
>> @@ -324,27 +356,21 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>           return;
>>       }
>>   -#if VIRGL_VERSION_MAJOR >= 1
>> -    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended)) {
>> -        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>> -        return;
>> -    }
>> -    if (*cmd_suspended) {
>> -        return;
>> -    }
>> -#endif
>> +    virtio_gpu_virgl_resource_unref(g, res, cmd_suspended);
>> +}
>>   -    virgl_renderer_resource_detach_iov(unref.resource_id,
>> -                                       &res_iovs,
>> -                                       &num_iovs);
>> -    if (res_iovs != NULL && num_iovs != 0) {
>> -        virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
>> -    }
>> -    virgl_renderer_resource_unref(unref.resource_id);
>> +void virtio_gpu_virgl_resource_destroy(VirtIOGPU *g,
>> +                                       struct
>> virtio_gpu_simple_resource *base,
>> +                                       Error **errp)
>> +{
>> +    struct virtio_gpu_virgl_resource *res;
>> +    bool suspended = false;
>>   -    QTAILQ_REMOVE(&g->reslist, &res->base, next);
>> +    res = container_of(base, struct virtio_gpu_virgl_resource, base);
>>   -    g_free(res);
>> +    if (virtio_gpu_virgl_resource_unref(g, res, &suspended)) {
>> +        error_setg(errp, "failed to destroy virgl resource");
>> +    }
>>   }
>>     static void virgl_cmd_context_create(VirtIOGPU *g,
>> @@ -1273,11 +1299,30 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>>       }
>>   }
>>   -void virtio_gpu_virgl_reset(VirtIOGPU *g)
>> +int virtio_gpu_virgl_reset(VirtIOGPU *g)
>>   {
>> +    struct virtio_gpu_simple_resource *res, *tmp;
>> +
>> +    /*
>> +     * Virglrender doesn't support context restoring. VirtIO-GPU
>> +     * state shall not be reset at runtime. Virgl blob resource
>> +     * unmapping can be deferred on unref, ensure that destruction
>> +     * is completed.
>> +     */
>> +    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
>> +        virtio_gpu_virgl_resource_destroy(g, res, NULL);
>> +    }
>> +
>> +    if (!QTAILQ_EMPTY(&g->reslist)) {
>> +        error_report("%s: failed to reset virgl resources", __func__);
>> +        return -EBUSY;
> 
> I think you missed my reply for an old comment (which was too late and
> sent for v3 despite you have already sent v4) so please check it out:
> https://lore.kernel.org/qemu-devel/d88cc89b-
> d796-4bc4-8c90-07da3b88cc7f@rsg.ci.i.u-tokyo.ac.jp/

Totally missed that reply from you, thanks for pointing at it!

Inlining it here:

> No, I meant that virtio_gpu_virgl_resource_unref() may set 
> *cmd_suspended true. If that happens, QTAILQ_EMPTY(&g->reslist) will be 
> false, but it is fine so no error log should be emitted.

Alright, the virtio_gpu_virgl_resource_destroy() itself should print out
error message when it fails. Will remove the additional error_report().
> It is confusing what "runtime" refers to. This code doesn't care about 
> S3 so such a comment shouldn't be necessary.

Will remove the part of comment talking about the runtime. Thanks a lot
for the review.

-- 
Best regards,
Dmitry

