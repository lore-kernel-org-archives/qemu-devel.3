Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8C0D1CDC2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 02:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQzWS-0004so-Q4; Wed, 03 Dec 2025 21:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vQzWQ-0004rw-Nh
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 21:56:46 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vQzWO-0004Zk-0P
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 21:56:46 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5B42tbB2054742
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Dec 2025 11:56:30 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9NMoV4F9PIC2apKmQEtJdMlXWak7T2T7ZMLSFrml6Oc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1764816990; v=1;
 b=KY/Cm6+zFUf5rtuyZJeMs9xvo3F0lRWpgrzhJ6+oECcmhgf6HvaWpTQPx1IMxcpp
 XH6jNcTvlY2tMRV1XMQIzPO8MNvL8qoinDZ083fc8lIZeSVIHYcC7UHguLZ/Ek+K
 nqYb00sghRDEV5chzaW9bkLatp5KvbW/6LknBk2QHaAjZk3GzbwyhX49q1V2NAp+
 rSEgwoogzNsAwXOKawx1YWZcb7yHVqY2QHOarzBDGFsHO2fM1KeVjwgUKglOqxcb
 cLGqWPl4uYtNOous2o+aelhCebuR4KlvUhVjyR/W3h/s/O+QSLbxXas355TrJAAN
 p7tQudVeDYTG3FiXz3IU3g==
Message-ID: <b5e61b9f-3afb-42c4-a185-eaf659a4c11c@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 4 Dec 2025 11:55:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/7] virtio-gpu-virgl: check page alignment of blob
 mapping
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-3-j@getutm.app>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251203040754.94487-3-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2025/12/03 13:07, Joelle van Dyne wrote:
> Currently if a mapping is not page aligned, it will sliently fail and the
> guest, assuming it is mapped, will attempt to access the memory and fail.
> This is particularly an issue on macOS when the host page size is 16KiB and
> the guest page size is 4KiB.

It should work. If I understand correctly, tcg doesn't care the host 
page size. hvf will not call hv_vm_map() for misaligned regions and that 
causes Data Abort, but it is handled by QEMU to perform memory access. I 
think it needs more debugging.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   hw/display/virtio-gpu-virgl.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 20c856c04e..adf02ac22b 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -116,6 +116,20 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>           return ret;
>       }
>   
> +    if (!QEMU_IS_ALIGNED((uintptr_t)data, qemu_real_host_page_size())) {
> +        virgl_renderer_resource_unmap(res->base.resource_id);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: address %p is not aligned to page size\n",
> +                      __func__, data);
> +        return -ENOMEM;
> +    }
> +
> +    if (!QEMU_IS_ALIGNED(size, qemu_real_host_page_size())) {
> +        virgl_renderer_resource_unmap(res->base.resource_id);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: size 0x%llx is not aligned to page size\n",
> +                      __func__, size);
> +        return -ENOMEM;
> +    }
> +
>       vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>       vmr->g = g;
>   


