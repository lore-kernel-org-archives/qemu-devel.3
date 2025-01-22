Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B87DC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 12:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZhb-0007b3-JY; Wed, 22 Jan 2025 07:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1taZhZ-0007aq-4d
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:19:21 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1taZhW-00046c-KU
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:19:20 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1737548342; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KIacCP+zKPCp0cefO0BUXRShYzOgs7Q26eZzkTSR+270d5Agf/gxIxxbjYwtFUnGx0TYPgzi6zs3Ih9SxB/+lE3bHEStYjOtNpUflwYUKLo6/C3pDYaGt2GR0iim+E6GnpgIkGJL61g7cUgkHptVWyBdLozmgxpDkxwx1d1fNvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1737548342;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=csJYoqJWet7IE4Lme2xRMgy5hG0h7E0B7jqHJJgnLss=; 
 b=GvsGQ3VxGIVgo0JTwWr0pe+ABWldZnGzfpWL/d3oGSXGUgiyx7QiTLfiUSf9SaxE7hoJFttCjqqTlQy+ZSd0f3A+jYdxn3Ti2ianbM6/yfyIh8hBc0B0W33WmazkK/KXOKoVH8svqNmRpLMXPgC/+wjVCZnHC7fHbZV/XJsD5NQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737548342; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=csJYoqJWet7IE4Lme2xRMgy5hG0h7E0B7jqHJJgnLss=;
 b=Mecn0WV5DDUIdWuRyaPIPNor8t2dJJ6OIgndQ5KE6yGtbfSPomz8zvlZRwIM7AeA
 P6/Ahj3maTWLzUPSFt2CbFhEqPVQtqUbON2nQ09baNCuASj6qqzZ7AOiooX8GvVB24M
 T/CG5myVRDuKvAN0mAodFhHRUvOmO/fwrTSTCkZw=
Received: by mx.zohomail.com with SMTPS id 173754834021010.360222635231253;
 Wed, 22 Jan 2025 04:19:00 -0800 (PST)
Message-ID: <08fed26f-5cb1-4652-914d-585b4a74f810@collabora.com>
Date: Wed, 22 Jan 2025 15:18:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] virtio-gpu: Support asynchronous fencing
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
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
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
 <20250119220050.15167-5-dmitry.osipenko@collabora.com>
 <87cyghr3l2.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87cyghr3l2.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

On 1/20/25 16:56, Alex Bennée wrote:
...
>> @@ -972,15 +973,29 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>  
>>      trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
>>  
>> -    /*
>> -     * Unlike other virglrenderer functions, this one returns a positive
>> -     * error code.
>> -     */
>> -    ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
>> -    if (ret) {
>> -        qemu_log_mask(LOG_GUEST_ERROR,
>> -                      "%s: virgl_renderer_create_fence error: %s",
>> -                      __func__, strerror(ret));
>> +    if (gl->context_fence_enabled &&
>> +        (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX)) {
>> +        uint32_t flags = 0;
> 
> Is this is constant or do we expect to change this later?
There are no immediate plans for using this flags variable in QEMU
today. But in general context-specific flags could be specified here.
Crosv makes use of the flags.

>> +        ret = virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id, flags,
>> +                                                  cmd->cmd_hdr.ring_idx,
>> +                                                  cmd->cmd_hdr.fence_id);
>> +        if (ret) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s: virgl_renderer_context_create_fence error: %s",
>> +                          __func__, strerror(-ret));
> 
> This still fails with older virglrenderers:
> 
> ../../hw/display/virtio-gpu-virgl.c: In function ‘virtio_gpu_virgl_process_cmd’:
> ../../hw/display/virtio-gpu-virgl.c:980:15: error: implicit declaration of function ‘virgl_renderer_context_create_fence’; did you mean ‘virgl_renderer_context_create’? [-Werror=implicit-function-declaration]
>   980 |         ret = virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id, flags,
>       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |               virgl_renderer_context_create
> ../../hw/display/virtio-gpu-virgl.c:980:15: error: nested extern declaration of ‘virgl_renderer_context_create_fence’ [-Werror=nested-externs]
> cc1: all warnings being treated as errors
> [1981/2819] Compiling C object libcommon.a.p/ui_sdl2-gl.c.o

Indeed! Good catch again, thanks! Will fix in v6

-- 
Best regards,
Dmitry

