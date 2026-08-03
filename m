Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F69C5518F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqpxx-00078s-GV; Mon, 03 Aug 2026 06:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wqpxw-00078e-1T
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 06:32:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wqpxs-0001Fv-W8
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 06:32:15 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 673AW1Q5061639
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 3 Aug 2026 19:32:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=CcXFUw3pW+zvo7JdjBYqbnUFq/1yJF5XqKnr3Xq4qX4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785753121; v=1;
 b=J1lxUTaNgxA1GMExKsOLFVI6P5uDW5RTz/Lyoqrt/nByArf5IF6zNgyrq0ASz3tq
 TPiKqGg1+eqAaSjaZfTQh1wa9YglH6+bba4XwERldmnsYygRm4eRfzFlJ4OGgtKr
 wH0iUaDN398ch3iJYwE8lLcYnmRCQnBpLdwr5qVEJAEoOJhBXGrT+JwG/eccr3Im
 /L12R8He9g9PMiyJcT9/a3EtNg8Ho9hbcgfKRV85BxlGyt0r9PJ+ktm4+C3i+/fK
 oaudYrLhCpg5QYXqqqj+Jn5x5VDdAtJtiYyU0HqoM/EeHRGhfPld05DnrltoN/Ex
 gjakY+uq8LK35uq0GerPGQ==
Message-ID: <2579e4f0-d557-4061-bc0d-7c1592705a82@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 3 Aug 2026 19:32:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Always reject invalid scanout
 bounds
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260803-scanout-v1-1-c9831dafdab2@rsg.ci.i.u-tokyo.ac.jp>
 <f18b62fc-9efe-4741-af01-5190f902165f@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <f18b62fc-9efe-4741-af01-5190f902165f@oss.qualcomm.com>
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

On 2026/08/03 19:17, Philippe Mathieu-Daudé wrote:
> Hi Akihiko,
> 
> On 3/8/26 10:45, Akihiko Odaki wrote:
>> virtio-gpu does not consistently check scanout bounds with wraparound
>> handling. In the unchecked virgl SET_SCANOUT path, guest dimensions
>> reach qemu_console_resize(), qemu_create_displaysurface(), and
>> ultimately qemu_pixman_image_new_shareable(..., &error_abort), so an
>> invalid rectangle can terminate QEMU. Implement a check with proper
>> wraparound handling and apply it consistently.
>>
>> Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering 
>> support.")
>> Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
>> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
>> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for 
>> gfxstream")
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   include/hw/virtio/virtio-gpu.h   |  5 +++++
>>   hw/display/virtio-gpu-rutabaga.c |  6 ++++++
>>   hw/display/virtio-gpu-virgl.c    | 20 +++++++++-----------
>>   hw/display/virtio-gpu.c          | 36 +++++++++++++++++++++ 
>> +--------------
>>   4 files changed, 42 insertions(+), 25 deletions(-)
> 
> 
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 4d46a4eb10fa..3c0e38c1def0 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -622,6 +622,26 @@ static uint32_t 
>> virtio_gpu_format_bytes_pp(pixman_format_code_t format)
>>       return DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
>>   }
>> +bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t 
>> resource_id,
>> +                                     uint32_t width, uint32_t height,
>> +                                     const struct virtio_gpu_rect *r,
>> +                                     uint32_t *error)
>> +{
>> +    if (r->width < 16 ||
>> +        r->height < 16 ||
>> +        (uint64_t)r->x + r->width > width ||
>> +        (uint64_t)r->y + r->height > height) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds 
>> for"
>> +                      " resource %d, fb %d %d, rect (%d,%d)+%d,%d\n",
>> +                      __func__, scanout_id, resource_id, width, height,
> 
> __func__ will always be "virtio_gpu_check_scanout_bounds", maybe we
> want the caller instead? Otherwise simply drop?
> 
> Since we rework this code, in case we are debugging broken guest driver,
> it could be more helpful to log one LOG_GUEST_ERROR per error type:
> 
>      if (r->width < 16) { ... }
>      if (r->height < 16) { ... }
>      ...

I don't have a strong opinion here, but if I'm debugging a broken guest, 
probably I would use the printed function name to look up this code and 
then figure out what's wrong by comparing with the actual condition.

This applies to other instances of LOG_GUEST_ERROR; ideally it would be 
nice if there is some sort of guideline, though I think people have 
different opinions what such a guideline should say.

Regards,
Akihiko Odaki

> 
>> +                      r->x, r->y, r->width, r->height);
>> +        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>>                                         uint32_t scanout_id,
>>                                         struct virtio_gpu_framebuffer 
>> *fb,
>> @@ -635,20 +655,8 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>>       scanout = &g->parent_obj.scanout[scanout_id];
>> -    if (r->x > fb->width ||
>> -        r->y > fb->height ||
> 
>  > -        r->width > fb->width ||
>  > -        r->height > fb->height ||
> 
> Do we want to remove these checks?
> 
>> -        r->width < 16 ||
>> -        r->height < 16 ||
> 
>> -        r->x + r->width > fb->width ||
>> -        r->y + r->height > fb->height) {
>> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds 
>> for"
>> -                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
>> -                      __func__, scanout_id, res->resource_id,
>> -                      r->x, r->y, r->width, r->height,
>> -                      fb->width, fb->height);
>> -        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>> +    if (!virtio_gpu_check_scanout_bounds(scanout_id, res->resource_id,
>> +                                         fb->width, fb->height, r, 
>> error)) {
>>           return false;
>>       }
>>
>> ---
>> base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
>> change-id: 20260803-scanout-c7cf28c1890e
>>
>> Best regards,
>> -- 
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>>
> 


