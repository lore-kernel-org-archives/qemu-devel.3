Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D52CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 04:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuk5F-0006Hq-KM; Fri, 05 Sep 2025 23:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuk5C-0006H5-Rk
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 23:59:22 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuk4y-0005LW-Si
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 23:59:22 -0400
Received: from [10.40.4.92] (93-51-222-138.ip268.fastwebnet.it [93.51.222.138])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5863wgmn083607
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 12:58:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=dFMuebhWvqXfUBHwi5HI+GMJtGugPVMhyHlMNPvPHWk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1757131127; v=1;
 b=MzDR9bk0/YQD2PEliXIZMi3HVzMS7AERmUxLf8kmBGQ7cf5ce1p1Hf8xnSjVPyAj
 ogttFkCfZ3irsiPviiOXQQ8kzzh+R2NWgLUJ930HBqxlIeDsNWkl+7KCFOzNdISj
 JyXcIHoGigimYOf3DHTbWvTH+QbK7AgMtgyldbpdl33OB1yjhxU16T+t60r4i4u7
 7rA9Cvh0UVGmh6c0u0l2Px1A/bI2DkU69C9OsgF5x92oZlO6Fy83LK8xBgsJA0un
 PCM8Trq4Ds4ShBCtR8Hzt4or5QOybpsH/ja7nxyKSxaJyWE6Wjk01VPqN2r9CtHt
 ER+GCQiNlMgbztKQAD6L+g==
Message-ID: <98ba7bf7-3d27-4040-b01c-c769a058fb19@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 6 Sep 2025 05:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio-gpu: Recreate the resource's dmabuf if new
 backing is attached
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-6-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250903054438.1179384-6-vivek.kasireddy@intel.com>
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
> There are cases when a blob resource's backing might get detached
> and re-attached again such as when the underlying object is getting
> migrated in the Guest. In these situations, we need to obtain a new
> dmabuf fd, which can be done by calling virtio_gpu_init_udmabuf().

It sounds like a bug fix. Perhaps you may add a Fixes: tag and reorder 
patches to make this change come first.

> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 2f9133c3b6..1654a417b8 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -938,6 +938,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>           return;
>       }
> +
> +    if (res->blob_size && res->dmabuf_fd < 0) {
> +        virtio_gpu_init_udmabuf(res);
> +    }
>   }
>   
>   static void


