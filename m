Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5E9C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wobiL-0001CN-8k; Tue, 28 Jul 2026 02:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wobiH-0001BZ-SH; Tue, 28 Jul 2026 02:54:53 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wobiE-000317-Hh; Tue, 28 Jul 2026 02:54:52 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66S6semH025665
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 28 Jul 2026 15:54:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TObdROh5e/L641ulJ7t48JBbKT2xnRkP2LjX1jLitpc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785221681; v=1;
 b=J+vmlZiVRSkhEU6CGDFVVqWW8dyNPJw8fbjciPS55cmXIWTVDcUc//hG/6BgAaJu
 9MlPSfPDb4a7FRTt2US4T3NRhi8U0bHuztaVbh4gtaPYTnummyuTcKH/aKZCMbzK
 h6itXv9OvUOv4Mm7eb+XR9CkdAvGkQ3VdfHzxa6QyeEv2DrL3aXMj4oNF/DuxQd5
 Bjn0GEZHH80bE36JY9s+D7iQzClmAdljH/KRBxMN4Z5QomuwBFi/KKAlOKSf7d6P
 /axRh8uDQqbRFGrikho003M29jUS5LcT/UsIK0a3M+PgFo90z8ztKU0QgzaRZDB8
 rQimjkENWc3RzC4+rFRHaQ==
Message-ID: <81a781bb-a4e2-4cfc-a9d1-0316cfb2f17a@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Jul 2026 15:54:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Fix empty blob discrimination
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260725-image-v1-1-4698a805afde@rsg.ci.i.u-tokyo.ac.jp>
 <b0951125-f714-4bdf-a178-1a7658bef43d@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b0951125-f714-4bdf-a178-1a7658bef43d@tls.msk.ru>
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

On 2026/07/28 6:35, Michael Tokarev wrote:
> On 7/25/26 10:12, Akihiko Odaki wrote:
>> Discriminating blobs by checking whether blob_size is nonzero fails for
>> empty blobs. Identify 2D resources by their non-NULL image instead.
>>
>> Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
>> Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate 
>> subsection")
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   hw/display/virtio-gpu.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> Is this a qemu-stable material?  I've no idea from the description
> about the implication of the previous behavior.

This fix is not important nor a regression but you may still pick it.

The consequence of the bug this patch fixes is a NULL pointer 
dereference and denial-of-service. docs/devel/stable-process.rst says:

 > Generally, the following patches are considered stable material:
 >
 > * Patches that fix severe issues, like fixes for CVEs
 >
 > * Patches that fix regressions

And I don't think this match with the description. It still does fix a 
bug, and I think you can cleanly backport it and you tend to backport 
such a patch.

Regards,
Akihiko Odaki

> 
> Thanks,
> 
> /mjt
> 
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 718ba3039290..6413df029b8e 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -56,18 +56,18 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>>           return;
>>       }
>> -    if (res->blob_size) {
>> -        if (res->blob_size < (s->current_cursor->width *
>> -                              s->current_cursor->height * 4)) {
>> -            return;
>> -        }
>> -        data = res->blob;
>> -    } else {
>> +    if (res->image) {
>>           if (pixman_image_get_width(res->image)  != s- 
>> >current_cursor->width ||
>>               pixman_image_get_height(res->image) != s- 
>> >current_cursor->height) {
>>               return;
>>           }
>>           data = pixman_image_get_data(res->image);
>> +    } else {
>> +        if (res->blob_size < (s->current_cursor->width *
>> +                              s->current_cursor->height * 4)) {
>> +            return;
>> +        }
>> +        data = res->blob;
>>       }
>>       pixels = s->current_cursor->width * s->current_cursor->height;
>> @@ -1279,7 +1279,7 @@ static int virtio_gpu_save(QEMUFile *f, void 
>> *opaque, size_t size,
>>       assert(QTAILQ_EMPTY(&g->cmdq));
>>       QTAILQ_FOREACH(res, &g->reslist, next) {
>> -        if (res->blob_size) {
>> +        if (!res->image) {
>>               continue;
>>           }
>>           qemu_put_be32(f, res->resource_id);
>> @@ -1430,7 +1430,7 @@ static int virtio_gpu_blob_save(QEMUFile *f, 
>> void *opaque, size_t size,
>>       assert(QTAILQ_EMPTY(&g->cmdq));
>>       QTAILQ_FOREACH(res, &g->reslist, next) {
>> -        if (!res->blob_size) {
>> +        if (res->image) {
>>               continue;
>>           }
>>           assert(!res->image);
>>
>> ---
>> base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
>> change-id: 20260725-image-6c8566fb1253
>>
>> Best regards,
>> -- 
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>>
> 


