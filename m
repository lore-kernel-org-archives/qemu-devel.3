Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CF0CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENMC-0006L6-6H; Wed, 07 Oct 2026 04:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEKHN-0005rA-FS
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:33:48 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEKHH-0007VA-CD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:33:23 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6975WvAb035306
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 7 Oct 2026 14:32:58 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8yVw8J3NOdHT/kVSJCQ2HRoXNl/z3zkX1D8NYEhlrvo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791351178; v=1;
 b=SPafRbDvLBq3uFBK9R+dZBfdHCov3Vluh8bXh76lMJ3MMoukf9DyxfHcZ7Ouqpvs
 aIzJIt/zdvS9RAEEJ7hX7WtGGV+Qi40p3UbDBNKwTLXwY1+hZEsJMmIcDmdzzbUe
 yNcznVb6b02INNGxfdIHl/LcsmPGwXpiQelfZBZbWnhdd5lHPapmz6zj8m0NfvAX
 lkotCmvBjqXdEualK3luUTFHHPCy9wmYGLV+Gl1Ab0pGpzgLegBKUU9hqTWE3cV/
 S2Uut+W4GUQuqeWToOfAYxw3QE46VUDvpavgGZIAYhE6vb6UDPkw89i97ci1DDb/
 jyXnA761dt9huQbrQEgCKg==
Message-ID: <16c7ee0e-8e3e-4cb3-81e2-63cb14276155@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 7 Oct 2026 14:32:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: fix memory leaks in virgl and rutabaga
To: Tom Desnoyers <tom.ds1@gmx.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, dmitry.osipenko@collabora.com
References: <20261006135504.416083-1-tom.ds1@gmx.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261006135504.416083-1-tom.ds1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026/10/06 22:55, Tom Desnoyers wrote:
> When a gpu buffer backed by a guest-memory blob is unreferenced, virgl
> and rutabaga free the resource but not its addrs field, leaking memory
> on every unref.
> 
> In virtio-gpu-virgl.c, free res->base.addrs before freeing the resource.
> In virtio-gpu-rutabaga.c, call virtio_gpu_cleanup_mapping() before
> freeing the resource.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4634
> Signed-off-by: Tom Desnoyers <tom.ds1@gmx.com>
> ---
>   hw/display/virtio-gpu-rutabaga.c | 1 +
>   hw/display/virtio-gpu-virgl.c    | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index 3aafa4dc66..7907aea85a 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -164,6 +164,7 @@ virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
>       }
>   
>       QTAILQ_REMOVE(&g->reslist, res, next);
> +    virtio_gpu_cleanup_mapping(g, res);
>       g_free(res);
>   }
>   
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index f45571060f..b5b160c840 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -458,6 +458,7 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
>   
>       QTAILQ_REMOVE(&g->reslist, &res->base, next);
>   
> +    g_free(res->base.addrs);

Thanks for the patch. For the virtio-gpu-virgl.c changes, I think it 
would be better to update virtio_gpu_virgl_resource_unref() to use the 
virtio_gpu_cleanup_mapping() helper.

Previously, the virgl code only called virtio_gpu_cleanup_mapping_iov(), 
so there was little benefit to using the higher-level helper. However, 
since this fix requires us to free res->base.addrs as well, replacing 
both the _iov() call and this new g_free() call with a single call to 
virtio_gpu_cleanup_mapping() makes the code cleaner.

Regards,
Akihiko Odaki

>       g_free(res);
>   
>       return 0;


