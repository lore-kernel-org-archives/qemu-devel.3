Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330D0CCFA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 05:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIKJn-0001Wb-Pi; Mon, 10 Nov 2025 00:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vIKJL-0001V6-NE
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 00:19:28 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vIKJI-0003th-G6
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 00:19:27 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AA5JHg0005727
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Nov 2025 14:19:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=OVPfvQSvbTcYG8dx0YcYH+0uNm7NzE3f/ndUohfQLP0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762751957; v=1;
 b=IOR68jHjLZ9spHDPZuL6CaB4fDM0he6zLQjZ173FEVsDJioIXRdIq9xKf6mlMdSe
 ZxacMdhk078GkFsDquAbNJSkp3SP6vLYQqQRPSTjf3akYfAm8/0hTkl5kIpHObRl
 PHMdiEhpQ/1JpLqPAtUwdCa2f4sbX4QzMTBViIuo8xjfVYM2uwlG5EMelcRdTFOW
 eg6bpr9nDHLQQi+51SRK/eVp7uD8jpsWmTXwJ9dMFcI2+GALFq9p8e7YNQFRt60H
 /AVRaNNHGajvqEidwi0znXkWaYgBLdZBALkmduZQo308KFaB2vxSF6ur0fvF7/JK
 g19s7hqbnKtCclh2KTWT1Q==
Message-ID: <83274ca7-dd37-4856-b198-f334bf630835@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 10 Nov 2025 14:19:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] virtio-gpu-dmabuf: Introduce
 qemu_iovec_same_memory_regions()
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-10-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251109053801.2267149-10-vivek.kasireddy@intel.com>
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

On 2025/11/09 14:33, Vivek Kasireddy wrote:
> Add a helper to check whether the addresses in an iovec array
> belong to the same memory region or not. This is useful to verify
> before trying to create a dmabuf from an iovec array.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu-dmabuf.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
> index c34d4c85bc..80143034d4 100644
> --- a/hw/display/virtio-gpu-dmabuf.c
> +++ b/hw/display/virtio-gpu-dmabuf.c
> @@ -27,6 +27,31 @@
>   #include "standard-headers/linux/udmabuf.h"
>   #include "standard-headers/drm/drm_fourcc.h"
>   
> +static bool qemu_iovec_same_memory_regions(const struct iovec *iov, int iov_cnt)
> +{
> +    RAMBlock *rb, *curr_rb;
> +    ram_addr_t offset;
> +    int i;
> +
> +    rb = qemu_ram_block_from_host(iov[0].iov_base, false, &offset);
> +    if (!rb) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Could not find ramblock/memory region\n", __func__);
> +        return false;
> +    }
> +
> +    for (i = 1; i < iov_cnt; i++) {
> +	curr_rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
> +	if (curr_rb != rb) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: memory regions not same for iov entries\n",
> +                          __func__);
> +            return false;
> +	}
> +    }
> +    return true;
> +}
> +
>   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>   {
>       struct udmabuf_create_list *list;
> @@ -137,6 +162,10 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>           res->iov[0].iov_len < 4096) {
>           pdata = res->iov[0].iov_base;
>       } else {
> +        if (!qemu_iovec_same_memory_regions(res->iov, res->iov_cnt)) {
> +            return;
> +        }
> +

This check is unnecessary. Perhaps rejecting iov with different memory 
regions may be fine if that simplifies the code, but this actually adds 
some code.

>           virtio_gpu_create_udmabuf(res);
>           if (res->dmabuf_fd < 0) {
>               return;

Regards,
Akihiko Odaki

