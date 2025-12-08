Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC66AD1CDC6
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 00:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSPVW-0006JA-Hl; Sun, 07 Dec 2025 19:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vSPVP-0006It-S5
 for qemu-devel@nongnu.org; Sun, 07 Dec 2025 19:53:36 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vSPVL-0006Wn-AA
 for qemu-devel@nongnu.org; Sun, 07 Dec 2025 19:53:34 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1765155196; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j83aTRSI9qGNHDaGd2xie9GwHxLTGicUAluGhUyotOXey9Gs+pkGZudBeqcuBoO922DASI+puUf3b4fvOtPYRQ485AaMLh7t4yW0EjKYIw+XF6VHFNiICfPNiTXZ5Jer90vccx0gc52CHiJOSezmFTyo4UaJVHQne/NDS5C7Ebw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1765155196;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=j2qJ2brHECYX2hpV8upcXmgsKvOlaMqxRk3gc63r4e8=; 
 b=AcZ6PrLABYWU3hHfpogsAiLxU03Uh1OrO9KsXYv98j9XoTWRk0/QNSXUDW/mH3+aRzC0ynAK3dcCUBRAYMGDOB4af80uT5NFz/xvWlnFZMVm6MUl+ve67SW1hq2hssK6OQ66GkQWG2n59V4N44glDeC5rz4DzVhvWhd1pn8RIWs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765155196; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=j2qJ2brHECYX2hpV8upcXmgsKvOlaMqxRk3gc63r4e8=;
 b=U1HrCZ3uORUNpxqte0zcnC3FGW6HgqI0MdfcHLCZrHROnXUEBd4VBQ4pKODrKmBx
 X5wAYbFDQgLzENZbFse3UCgSxuV9mJbgMWjuFuTeOiTa66KIRrZ0vfNkVcIpBuIlsfi
 28NhJJEo2eXDg+35Kd7yquVHP6vtbk/qfCPYDx8A=
Received: by mx.zohomail.com with SMTPS id 1765155193586892.2120199685935;
 Sun, 7 Dec 2025 16:53:13 -0800 (PST)
Message-ID: <50757d26-4257-4723-86b9-2ba60cc8f0a8@collabora.com>
Date: Mon, 8 Dec 2025 03:53:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 3/4] virtio-gpu: Destroy virgl resources on
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
References: <20251201233447.2218728-1-dmitry.osipenko@collabora.com>
 <20251201233447.2218728-4-dmitry.osipenko@collabora.com>
 <88a72e90-35b5-459d-af08-a70173429546@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <88a72e90-35b5-459d-af08-a70173429546@rsg.ci.i.u-tokyo.ac.jp>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 12/5/25 07:10, Akihiko Odaki wrote:
> On 2025/12/02 8:34, Dmitry Osipenko wrote:
>> Properly destroy virgl resources on virtio-gpu reset to not leak
>> resources
>> on a hot reboot of a VM.
>>
>> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   hw/display/virtio-gpu-gl.c     |  6 ++-
>>   hw/display/virtio-gpu-virgl.c  | 84 +++++++++++++++++++++++++---------
>>   include/hw/virtio/virtio-gpu.h |  5 +-
>>   3 files changed, 72 insertions(+), 23 deletions(-)
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
> 
> The state should stay RS_RESET so that the suspended work will be
> resumed later.
> 
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
>> index 6a2aac0b6e5c..2fc5c746396c 100644
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
> 
> "cmd_suspended" is now a bit confusing name because it is triggered with
> device reset which is not a command in the virtio terminology.
> "suspended" will work and is a bit shorter too.

Will change it all in v17, thanks!

-- 
Best regards,
Dmitry

