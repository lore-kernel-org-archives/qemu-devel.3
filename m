Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C072C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wza0s-0004br-3Y; Thu, 27 Aug 2026 09:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wza0p-0004bM-9U
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:19:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wza0m-00079d-5s
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:19:22 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67RDJ5q2093418
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 27 Aug 2026 22:19:06 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=dEhugfSMvFCruspAC8Et27pSxGCYlFexpeIhfxjgszI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787836746; v=1;
 b=i8YSTJQqFv/o58lM6WvWfFaxfeYRPSNb17VBuQ00J+7EqrHqFlFGnmzhIQcPg0MW
 IxFOVxFd+D/BDo7YXIfjIDp26Zyg2arFu40YS7pU6DhWd2HS/OSxnQnMXYgt68Ou
 1qH57E62jPuUtgQTIbsAik+/P8Y8apsca7il1uHrlBooKBxRLBtyPQwnTnvFW66N
 Fpl+SRkuArmayZmyNmJnWjHBhloZyZMnTWQ7u3FFhZntehuJ4uNFmF8DmGwS+kx6
 eRPGrNtkn8t8aQ9RSrfc0i1z9R3qsXtixdr0ug5Gi2nM6loCpmBjsxqgUGv1QLIr
 iQRn8BVgzXsegLjO4piIKQ==
Message-ID: <486b36e5-c47a-48b6-8030-3bbb081ad4a7@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 27 Aug 2026 22:19:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 10/18] virtio-gpu: disable blob scanouts on mapping cleanup
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
 <20260825-virtio-gpu-cleanup-v1-10-d3bb612b9975@redhat.com>
Content-Language: en-US
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-10-d3bb612b9975@redhat.com>
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

On 2026/08/25 19:20, Marc-André Lureau wrote:
> When a blob resource backing is cleaned up (for ex via detach_backing),
> any scanouts referencing it must be disabled first to prevent the
> dmabuf from outliving its backing memory.
> 

Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")

> Fixes: CVE-2026-66020
> Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 46ddfeeaba87..e547cac60398 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -982,6 +982,16 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
>   void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>                                   struct virtio_gpu_simple_resource *res)
>   {
> +    if (res->blob) {
> +        int i, max_outputs = g->parent_obj.conf.max_outputs;
> +
> +        for (i = 0; i < max_outputs; i++) {
> +            if (g->parent_obj.scanout[i].resource_id == res->resource_id) {
> +                virtio_gpu_disable_scanout(g, i);
> +            }
> +        }
> +    }
> +
>       virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
>       res->iov = NULL;
>       res->iov_cnt = 0;
> 


