Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022CCE6817D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 12:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsKak-0000UG-BS; Tue, 17 Feb 2026 07:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vsKag-0000Ty-2o
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 07:54:10 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vsKaa-0007sz-9W
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 07:54:08 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771332813; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lzcreig+0T2+rypWgGPut0U0DV1FsHLz3hU4cXmr/o8r24gTNog3UamCw+UGnQB0ACyv+OweyK0E674wjSt3VRj1ovNvPff1/T+oynC36oK0B3BmL73lsed3uBYUi9G/+C6SdcX453rBVC6YK0TN8dtMn2+9s+QnByg+7HJ4NGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771332813;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lV/6jEjChzisX4IWhMytFeLbWZ5hF3f6Tmg8STBMhso=; 
 b=FG2J9Hs3u2bLqcFLRTkqXUbqrmfqIhPBfTGpCpOizhPmpSY0dfmY3PLW65yKrycHRK/33rDfW1bMMDrW907EV/AEeOWZzn26HAo4MohZPQWF9e4vJM9J4gbj2nfUq4VQJ3fB6QZ7vKRe/eGJoJgune4kOH96VBxxPzKaUQnFThk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771332813; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=lV/6jEjChzisX4IWhMytFeLbWZ5hF3f6Tmg8STBMhso=;
 b=AZyXkbDi2JCqpmv8OnUa0r88Zg3wCGHDpNYL3uR4lCmx9+gvawixNh36hnVATwWR
 EUQzjbCcURrWKKFBZmkJA6ikv5BB2uA9e5XGw4lQMqLBresh5v41FgE+MSfQgSdtogH
 ky7KhSS20f/OLSLyZLC4WQmALY7cBgS6LlsDBa5k=
Received: by mx.zohomail.com with SMTPS id 1771332812447351.60888636842367;
 Tue, 17 Feb 2026 04:53:32 -0800 (PST)
Message-ID: <ba0de6c2-8281-4a0c-a21d-86a01c785cf5@collabora.com>
Date: Tue, 17 Feb 2026 15:53:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 06/18] virtio-gpu: Unset context after GL operations
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
References: <20260216191213.2556073-1-dmitry.osipenko@collabora.com>
 <20260216191213.2556073-7-dmitry.osipenko@collabora.com>
 <9116c5dd-d0ee-4a6e-b318-bbd410ad09ee@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <9116c5dd-d0ee-4a6e-b318-bbd410ad09ee@rsg.ci.i.u-tokyo.ac.jp>
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

Hello Akihiko,

On 2/17/26 09:32, Akihiko Odaki wrote:
> On 2026/02/17 4:12, Dmitry Osipenko wrote:
>> VirtIO-GPU commands may be processed outside of main-loop, from a CPU
>> thread. This results in GL context switch failure because context is held
>> by main-loop thread when GL is invoked from CPU thread. Always release GL
>> context after performing GL operations such that other threads could take
>> over the context.
>>
>>   0  SDL_GL_MakeCurrent() (libSDL3)
>>   1  SDL_GL_MakeCurrent_REAL() (libSDL2)
>>   2  sdl2_gl_make_context_current() (ui/sdl2-gl.c:201)
>>   3  make_current() (virglrenderer.c:639)
>>   4  vrend_finish_context_switch() (vrend_renderer.c:11630)
>>   5  vrend_hw_switch_context() (vrend_renderer.c:11613)
>>   6  vrend_renderer_force_ctx_0() (vrend_renderer.c:12986)
>>   7  virgl_renderer_force_ctx_0() (virglrenderer.c:460)
>>   8  virtio_gpu_virgl_process_cmd() (virtio-gpu-virgl.c:1013)
>>   9  virtio_gpu_process_cmdq() (virtio-gpu.c:1050)
>>   10 virtio_gpu_gl_handle_ctrl() (virtio-gpu-gl.c:86)
>>   11 aio_bh_poll() (util/async.c)
>>   12 aio_poll() (util/aio-posix.c)
>>   13 blk_pwrite() (block/block-gen.c:1985)
>>   14 pflash_update() (pflash_cfi01.c:396)
>>   15 pflash_write() (pflash_cfi01.c:541)
>>   16 memory_region_dispatch_write() (system/memory.c:1554)
>>   17 flatview_write() (system/physmem.c:3333)
>>   18 address_space_write() (system/physmem.c:3453)
>>   19 kvm_cpu_exec() (accel/kvm/kall-all.c:3248)
>>   20 kvm_vcpu_thread_fn() (accel/kvm/kaccel-ops.c:53)
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   hw/display/virtio-gpu-virgl.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-
>> virgl.c
>> index 0f754829fb71..cde1a7a8426f 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -896,14 +896,19 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU
>> *g,
>>   }
>>   #endif
>>   -void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>> -                                      struct virtio_gpu_ctrl_command
>> *cmd)
>> +static void virtio_gpu_virgl_unset_gl_context(void)
>> +{
>> +    dpy_gl_ctx_make_current(qemu_console_lookup_default(), NULL);
> 
> An appropriate console needs to be selected as
> virgl_make_context_current() does.

See now that virglrender always sets ctx0 for scanout=0. Hence same
scanout=0 can be used when unsetting GL context. Will change it.

>> +}
>> +
>> +static void
>> +virtio_gpu_virgl_do_process_cmd(VirtIOGPU *g,
> 
> Although it is a common practice to differentiate functions with having
> a word like "do", I see it as a bad one. The word conveys no meaning at
> all. A more descriptive phrase like "with_ctx" may be better.

Will rename the func, thanks for the review.

-- 
Best regards,
Dmitry

