Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE30CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 03:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuk0y-000453-ML; Fri, 05 Sep 2025 23:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuk0u-00044d-KV
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 23:54:58 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuk0k-0004Ko-Q2
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 23:54:55 -0400
Received: from [10.40.4.92] (93-51-222-138.ip268.fastwebnet.it [93.51.222.138])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5863sDe4081769
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 12:54:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=k/LWNAQJEmyj9eb7zRTXTmjD82biz8dh1vsbAorJHvA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1757130857; v=1;
 b=P9Nd4uE01EjC6SG3dVpr6wgIFVefeX0EpY3KFADQfdxBzYiqqVH+jdtEMqTwCPDo
 R4+FFb2DGML6yHA1ZH9xhR1O6qJtWV/zXeBx5F23RcvhPnGJIhDHbILkioQJ3Tx9
 ohT0WHfZB94r73hMLSmCGnlYvH+w4HDHkE1BY26S57tbi2QJaoW/vnvwnnu55kkF
 41XLFZc4O5bNxFZ56nJAWYk8v0DFTrKpFpkj9iuJI/C34DRah1AMLZqXRawRvxxs
 QtZI8NJg8ToIuUuM19eZRY28XSnedDS9KYFsgfEtrPlElunq4H5EjEmj/20hcJMJ
 dU4wAUc1vj9drgRXsSbtFA==
Message-ID: <26c02124-eb57-4d50-bf8d-1fa809984adc@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 6 Sep 2025 05:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
 resources
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-5-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250903054438.1179384-5-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/09/03 7:42, Vivek Kasireddy wrote:
> The res->blob pointer is only valid for blobs that have their
> backing storage in memfd. Therefore, we cannot use it to determine
> if a resource is a blob or not. Instead, we could use res->blob_size
> to make this determination as it is non-zero for blob resources
> regardless of where their backing storage is located.

I guess this change needs to be applied before "[RFC 3/6] 
virtio-gpu-udmabuf: Create dmabuf for blobs associated with VFIO 
devices"; without this patch, the "create dmabuf" patch will probably 
create an invalid blob.

> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 0a1a625b0e..2f9133c3b6 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -57,7 +57,7 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>       }
>   
>       if (res->blob_size) {
> -        if (res->blob_size < (s->current_cursor->width *
> +        if (!res->blob || res->blob_size < (s->current_cursor->width *

I doubt that rejecting a valid blob due to an implementation concern 
(whether the backing storage is in memfd) is tolerated in the specification.

>                                 s->current_cursor->height * 4)) {
>               return;
>           }
> @@ -144,7 +144,7 @@ virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
>       }
>   
>       if (require_backing) {
> -        if (!res->iov || (!res->image && !res->blob)) {
> +        if (!res->iov || (!res->image && !res->blob_size)) {
>               qemu_log_mask(LOG_GUEST_ERROR, "%s: no backing storage %d\n",
>                             caller, resource_id);
>               if (error) {
> @@ -444,7 +444,7 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
>   
>       res = virtio_gpu_find_check_resource(g, t2d.resource_id, true,
>                                            __func__, &cmd->error);
> -    if (!res || res->blob) {
> +    if (!res || res->blob_size) {
>           return;
>       }
>   
> @@ -507,7 +507,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
>           return;
>       }
>   
> -    if (res->blob) {
> +    if (res->blob_size) {
>           for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
>               scanout = &g->parent_obj.scanout[i];
>               if (scanout->resource_id == res->resource_id &&
> @@ -538,7 +538,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
>           }
>       }
>   
> -    if (!res->blob &&
> +    if (!res->blob_size &&
>           (rf.r.x > res->width ||
>           rf.r.y > res->height ||
>           rf.r.width > res->width ||
> @@ -634,7 +634,7 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>   
>       g->parent_obj.enable = 1;
>   
> -    if (res->blob) {
> +    if (res->blob_size) {
>           if (console_has_gl(scanout->con)) {
>               if (!virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
>                   virtio_gpu_update_scanout(g, scanout_id, res, fb, r);
> @@ -645,13 +645,16 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>               return true;
>           }
>   
> +        if (!res->blob) {
> +            return false;
> +        }
>           data = res->blob;
>       } else {
>           data = (uint8_t *)pixman_image_get_data(res->image);
>       }
>   
>       /* create a surface for this scanout */
> -    if ((res->blob && !console_has_gl(scanout->con)) ||
> +    if ((res->blob_size && !console_has_gl(scanout->con)) ||
>           !scanout->ds ||
>           surface_data(scanout->ds) != data + fb->offset ||
>           scanout->width != r->width ||
> @@ -899,7 +902,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>       g_free(res->addrs);
>       res->addrs = NULL;
>   
> -    if (res->blob) {
> +    if (res->blob_size) {
>           virtio_gpu_fini_udmabuf(res);
>       }
>   }


