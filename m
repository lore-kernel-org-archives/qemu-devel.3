Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D75606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=FrtAdhq4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR8Ej-00010D-GO; Wed, 11 Nov 2026 08:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xR8Eg-0000zp-EI
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:19:35 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xR8Ed-0004wS-Jt
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:19:34 -0500
Received: from [172.19.247.154] (customer.sttlwax1.isp.starlink.com
 [74.244.199.159] (may be forged)) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6ABDJGjR013962
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 11 Nov 2026 22:19:18 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=6sciZs0DIIRciyXDGcXSr6SqLbX7/539g8jjF+pTnXU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1794403160; v=1;
 b=FrtAdhq4BfVYjzvrzlGf4DVIYw8MRIK9Zaj1EiAC9M9cLwZYiU9J9RH3MJ89GBc0
 UIn5lUywveFTMQRkRKkGw/rb1nBCMe0VycYerTpt9MxASDpMHPVHaeyWPzz3UN8f
 iyr3+W6Cx50hPmWzKshJPhGoDkI5XzJNMGKQYMTtMQVKfOBN2+iakVVZ1yhj+Xwb
 64Dwdk+3m3PlR/CwHgH+2PKEKGwVsHN9OgKy1rNFSdT9XYHBqMbYWLV3e5+/8d/l
 Ma4zLigi15INE8VwHhfLWb2ugPxOVEzX0o5F0fbd6pYCXFb+NKYpQ+7reDAqTcOF
 4/JGcD/sIB3nPQoOgb8waQ==
Message-ID: <568cebce-381c-48b4-baad-20d6f1684ea2@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 11 Nov 2026 05:19:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 2/4] virtio-gpu/gl: reject non-32bpp cursor resources
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>
References: <20261110-master-v1-0-7a0505d6c259@redhat.com>
 <20261110-master-v1-2-7a0505d6c259@redhat.com> <avLbiXYoG2KTpBj3@redhat.com>
Content-Language: en-US
In-Reply-To: <avLbiXYoG2KTpBj3@redhat.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/10 17:53, Daniel P. Berrangé wrote:
> On Tue, Nov 10, 2026 at 12:31:12PM +0400, Marc-André Lureau wrote:
>> Cursor pixel data is copied as 32bpp, but the resource format is never
>> checked. virgl_renderer_get_cursor_data() sizes its buffer for the
>> resource's own format, while virtio_gpu_gl_update_cursor_data() copies
>> width * height * 4 bytes from it: a 64x64 R8_UNORM resource gives a
>> 4096 byte buffer and a 16384 byte read, so 12 KiB of host heap past the
>> end of the allocation is sent to a connected VNC client as cursor data.
>>
>> Look up the resource format and refuse anything that is not 32bpp,
>> matching what the non-virgl paths accept. Querying the renderer covers
>> blob resources: a blob carries no format in the virtio command and QEMU
>> stores 0 for it. The virgl and virtio format enums have the same values
>> for the accepted formats.
>>
>> Fixes: CVE-2026-122027
>> Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
>> Reported-by: Fernando Bortotti <https://gitlab.com/fernando.bortotti>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/display/virtio-gpu-gl.c            | 18 ++++++++++++++++++
>>   include/hw/virtio/virtio-gpu-pixman.h | 13 +++++++++++++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>> index 2b7a41c46643..c314631b05f3 100644
>> --- a/hw/display/virtio-gpu-gl.c
>> +++ b/hw/display/virtio-gpu-gl.c
>> @@ -31,6 +31,7 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
>>                                                uint32_t resource_id)
>>   {
>>       VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>> +    struct virgl_renderer_resource_info info = { 0 };
>>       uint32_t width, height;
>>       uint32_t pixels, *data;
>>   
>> @@ -38,6 +39,20 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
>>           return;
>>       }
>>   
>> +    virgl_renderer_force_ctx_0();
>> +    if (virgl_renderer_resource_get_info(resource_id, &info) != 0) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown cursor resource %u\n",
>> +                      __func__, resource_id);
>> +        return;
>> +    }
>> +
>> +    if (!virtio_gpu_format_is_cursor_capable(info.virgl_format)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: cursor resource %u has unsupported format %u\n",
>> +                      __func__, resource_id, info.virgl_format);
>> +        return;
>> +    }
>> +
>>       data = virgl_renderer_get_cursor_data(resource_id, &width, &height);
>>       if (!data) {
>>           return;
>> @@ -45,6 +60,9 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
>>   
>>       if (width != s->current_cursor->width ||
>>           height != s->current_cursor->height) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: cursor resource %u has unsupported dimension %ux%u\n",
>> +                      __func__, resource_id, width, height);
>>           free(data);
>>           return;
>>       }
>> diff --git a/include/hw/virtio/virtio-gpu-pixman.h b/include/hw/virtio/virtio-gpu-pixman.h
>> index 4dba782758dc..d6043d2ca1df 100644
>> --- a/include/hw/virtio/virtio-gpu-pixman.h
>> +++ b/include/hw/virtio/virtio-gpu-pixman.h
>> @@ -42,4 +42,17 @@ virtio_gpu_get_pixman_format(uint32_t virtio_gpu_format)
>>       }
>>   }
>>   
>> +/*
>> + * Cursor data is copied as 32bpp; formats without a pixman mapping are
>> + * rejected.
>> + */
>> +static inline bool
>> +virtio_gpu_format_is_cursor_capable(uint32_t format)
>> +{
>> +    pixman_format_code_t pformat;
>> +
>> +    pformat = virtio_gpu_get_pixman_format(format);
>> +    return pformat && PIXMAN_FORMAT_BPP(pformat) == 32;
> 
> Seems like 'pformat &&' is redundant since pixman_format_code_t is an
> int (enum) and thus it is impossible for it to be 0, at the same time
> as PIXMAN_FORMAT_BPP() reports 32.
> 
> Functionally it works though, so with/without it,
> 
>    Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

virtio_gpu_get_pixman_format() returns 0 for formats without a pixman 
mapping though 0 is not part of pixman_format_code_t. It is confusing, 
but the function is pre-existing, so:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

