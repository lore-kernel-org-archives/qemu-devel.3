Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1F0F532FF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4xnc-0001di-CS; Tue, 24 Mar 2026 05:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w4xnZ-0001dF-Vp
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:11:41 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w4xnX-00011X-6m
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:11:41 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62O9BWjj068009
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 24 Mar 2026 18:11:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ZSmMdlU7nids3b6FDnnfwestQ5W02f0UK0dJTft58ew=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1774343492; v=1;
 b=J5m9o0xyCHHZtPJZr894Lc2NrAOGJDuAFktix4mxZJTcCBiQErgGOnPNiLumhNHR
 qhCXw6kv2JBBc0BNrjJqe3otXl/5Aq+ZLml4drWzcwaA+dMeSp9izvLrIm98SYAi
 76sjkX9PyCm0mz0TM0MSWfOWFLTlJ7OiAXa/HWQdckRocmsxIKH9shlG9yx3HToI
 b0DY1Z6tJeRPV7uF6FawBiMQVvdLiMU5Ux/Tb/7NNd5fl60j4WTXI5MtefRELdEa
 G5H1ZgbAOOT0+HsJMbe3vXnSzC/fF0CTz6GfzmF1Czakl+uHfkuZhudsWkaUP7Ag
 iM/Z6p4LTPD7Qxbks748cw==
Message-ID: <6af4e73c-4ad5-4684-9982-04276b6b7daa@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 24 Mar 2026 18:11:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-11-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260319052023.2088685-11-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/19 14:15, Vivek Kasireddy wrote:
> In addition to memfd, a blob resource can also have its backing
> storage in a VFIO device region. Since, there is no effective way
> to determine where the backing storage is located, we first try to
> create a dmabuf assuming it is in memfd. If that fails, we try to
> create a dmabuf assuming it is in VFIO device region.
> 
> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> backing storage is located in a memfd or not. If it is not, we invoke
> the vfio_device_create_dmabuf_fd() API which identifies the right
> VFIO device and eventually creates a dmabuf fd.
> 
> Note that, for mmapping the dmabuf, we directly call mmap() if the
> dmabuf fd was created via virtio_gpu_create_udmabuf() since we know
> that the udmabuf driver supports mmap(). However, if the dmabuf was
> created via vfio_device_create_dmabuf_fd(), we use the
> vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu-dmabuf.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
> index 89aa487654..f953db0fbe 100644
> --- a/hw/display/virtio-gpu-dmabuf.c
> +++ b/hw/display/virtio-gpu-dmabuf.c
> @@ -147,9 +147,26 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>           if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>               error_free_or_abort(&local_err);
>   
> -            qemu_log_mask(LOG_GUEST_ERROR,
> -                          "Cannot create dmabuf: incompatible memory\n");
> -            return;
> +            res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
> +                                                          res->iov_cnt,
> +                                                          res->blob_size,

The correspondence between (iov, iov_cnt) and blob_size is more of a 
internal concern of virtio-gpu, not of VFIO. This parameter is better 
removed from vfio_device_create_dmabuf_fd() and vfio_device_mmap_dmabuf().

Regards,
Akihiko Odaki

> +                                                          &local_err);
> +            if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> +                error_free_or_abort(&local_err);
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Cannot create dmabuf: incompatible memory\n");
> +                return;
> +            }
> +
> +            if (res->dmabuf_fd >= 0) {
> +                pdata = vfio_device_mmap_dmabuf(res->iov, res->iov_cnt,
> +                                                res->blob_size, &local_err);
> +                if (!pdata) {
> +                    virtio_gpu_destroy_dmabuf(res);
> +                }
> +            } else {
> +                res->dmabuf_fd = -1;
> +            }
>           } else if (res->dmabuf_fd >= 0) {
>               pdata = virtio_gpu_remap_dmabuf(res, &local_err);
>               if (!pdata) {


