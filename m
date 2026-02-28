Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027DDFEE4C6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 07:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwEqZ-000669-HK; Sat, 28 Feb 2026 02:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwEqX-00065m-Og
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 02:34:41 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwEqV-0003iY-6d
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 02:34:41 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61S7YFSF009308
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 28 Feb 2026 16:34:33 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2gmm9x6G4z8uo0q/Uh2no51UOb82XRPtkCjKYlg/Ra8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772264073; v=1;
 b=uBlK73SiWFMqI09ZdwCxomX9KwfmMfEs1N51DcViclSHlBe2ukXQuVUKdxk4Mn4N
 FkOYC8zNdonzpsTzhbqwUntIFhWYZjScatIgFuhhWYjAlD48rGdvbpC3OKUyPg0T
 xysdEg/7trqNYy2sSkxCrzHJ4Q6KGMjfml1EEdDCv4sS+4N2ZsV0oIPMSpaDWR2L
 +jpiFjUqbfqWiZaek1QH3Pw6y5UgGf412m/v1/MzfLF024S0By7VPG8Nm1cjJmy6
 nkHadbDsRjRxqpaT9U5/thEQMJySbBuvv/D7GbytZvueYIb8CLpUQL7umjpP7obn
 V1fXwt7qKYvyFJ+BvwaQfA==
Message-ID: <45aee031-3ae5-4334-a9fe-16162336f8a8@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 28 Feb 2026 16:34:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260227221632.827046-1-vivek.kasireddy@intel.com>
 <20260227221632.827046-11-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260227221632.827046-11-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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

On 2026/02/28 7:13, Vivek Kasireddy wrote:
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
> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> fall back to the vfio_device_mmap_dmabuf() API to get a mapping
> created for the dmabuf.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu-dmabuf.c | 35 +++++++++++++++++++++++++++-------
>   1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
> index b2badfc1bd..533d3d601c 100644
> --- a/hw/display/virtio-gpu-dmabuf.c
> +++ b/hw/display/virtio-gpu-dmabuf.c
> @@ -74,13 +74,21 @@ static int virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
>   static bool virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
>                                       Error **errp)
>   {
> +    Error *mmap_err = NULL;
>       void *map;
>   
>       map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res->dmabuf_fd, 0);
>       if (map == MAP_FAILED) {
> -        error_setg_errno(errp, errno, "dmabuf mmap failed");
> +        error_setg_errno(&mmap_err, errno, "dmabuf mmap failed: ");
>           res->remapped = NULL;
> -        return false;
> +
> +        if (!vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
> +                                     res->blob_size, errp)) {

Let's call vfio_device_mmap_dmabuf() only when 
vfio_device_create_dmabuf_fd() is called. Hopefully it will simplify the 
logic structure.

Regards,
Akihiko Odaki

> +            error_report_err(mmap_err);
> +            return false;
> +        }
> +        error_free(mmap_err);
> +        mmap_err = NULL;
>       }
>       res->remapped = map;
>       return true;
> @@ -137,7 +145,7 @@ bool virtio_gpu_have_udmabuf(void)
>   
>   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>   {
> -    Error *local_err = NULL;
> +    Error *local_err = NULL, *vfio_err = NULL;
>       void *pdata = NULL;
>       int ret;
>   
> @@ -151,15 +159,28 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>               error_prepend(&local_err, "Cannot create dmabuf: ");
>   
>               if (ret == VFIO_DMABUF_CREATE_GUEST_ERROR) {
> -                qemu_log_mask(LOG_GUEST_ERROR,
> -                              "Cannot create dmabuf: incompatible memory\n");
> -                error_free(local_err);
> -                return;
> +                ret = vfio_device_create_dmabuf_fd(res->iov, res->iov_cnt,
> +                                                   &vfio_err);
> +                if (ret > 0) {
> +                    error_free(local_err);
> +                    local_err = NULL;
> +                    goto out;
> +                }
> +
> +                if (ret == VFIO_DMABUF_CREATE_GUEST_ERROR) {
> +                    qemu_log_mask(LOG_GUEST_ERROR,
> +                                  "Cannot create dmabuf: incompatible memory\n");
> +                    error_free(vfio_err);
> +                    error_free(local_err);
> +                    return;
> +                }
> +                error_report_err(vfio_err);
>               }
>               error_report_err(local_err);
>               return;
>           }
>   
> +out:
>           res->dmabuf_fd = ret;
>           if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
>               error_report_err(local_err);


