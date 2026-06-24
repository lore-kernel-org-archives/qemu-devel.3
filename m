Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9473CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcJUy-0001Fb-Pu; Wed, 24 Jun 2026 05:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wcJUw-0001FT-Iv
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:02:18 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wcJUt-0007q8-L8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:02:18 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65O91xaZ096362
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Jun 2026 18:01:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=tD59hKbiyO5jQzwjyFHv3fmucADD2qql9ueblIRuTxE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782291719; v=1;
 b=QgC67N/ER7XrkPCpweUl9RRE5aaWFH3mcrdlQJyRlDb+o9GX2LVpmLnr0D7yUDCv
 jkMeQdWt64EncecZiC+4h2JW7UoCDim88Adi+dV2LPk/D3GF9AIB7Ynj83CwUq4w
 4aEied9zH78qLQEi4IykQO8cc6LVfgjqzFnjKoXTk3g/5cFexcX2m+DB2f/vUD7L
 pIYSriyXYq7ZMrz5wgCGbv8Dsd/BpBWE560CsF5MfX1IREbb/JQdsmGjm+1yYiw0
 2RFl9UflUIO5JtzvbsOPbywhsQYsK0LHaRad9ljeG0rfTDIFrI7w/O/k8wXtT36N
 GEcJ1+E8mUxjldrzwm45cA==
Message-ID: <df7e24c6-12e6-4488-8a02-2fa57c504086@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Jun 2026 18:01:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] virtio-gpu-virgl: validate resource existence on ctx
 attach/detach
To: Bin Guo <guobin@linux.alibaba.com>, alex.bennee@linaro.org
Cc: mst@redhat.com, dmitry.osipenko@collabora.com, qemu-devel@nongnu.org
References: <cover.1782270919.git.guobin@linux.alibaba.com>
 <32f6f23fb4880a4f1ec3056fde306332d54e442f.1782270919.git.guobin@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <32f6f23fb4880a4f1ec3056fde306332d54e442f.1782270919.git.guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/06/24 14:55, Bin Guo wrote:
> The CTX_ATTACH_RESOURCE and CTX_DETACH_RESOURCE command handlers
> forwarded the guest-supplied resource_id directly to virglrenderer
> without verifying that the resource actually exists.  A malicious or
> buggy guest could reference an invalid resource_id, potentially causing
> undefined behavior inside virglrenderer.
> 
> Resolve the long-standing "TODO add security" comments by checking the
> resource against QEMU's own resource table (virtio_gpu_find_resource)
> before forwarding the request.  This is consistent with how other
> command handlers in virtio-gpu.c validate resource references.

I think it is better to be checked inside virglrenderer. In general, the 
timings/places of check and usage should be centralized to ensure that 
the invariant required by usage is properly covered by the check and to 
avoid time-of-check to time-of-use (ToCTToU) bugs. Since virglrenderer 
uses the value, it should also check it.

Furthermore, checking resource_id is insufficient as it does not cover 
another parameter, ctx_id, despite that the TODO comments are removed. 
QEMU currently has no knowledge what ctx_id is valid, so it also 
motivates having checks inside virglrenderer. The corresponding 
functions of virglrenderer may be extended to have return values for 
error reporting like other virglrenderer functions.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   hw/display/virtio-gpu-virgl.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 60c78af06a..b992ffc44e 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -743,6 +743,14 @@ static void virgl_cmd_ctx_attach_resource(VirtIOGPU *g,
>       trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,
>                                           att_res.resource_id);
>   
> +    if (!virtio_gpu_find_resource(g, att_res.resource_id)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid resource %d for ctx %d\n",
> +                      __func__, att_res.resource_id, att_res.hdr.ctx_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
>       virgl_renderer_ctx_attach_resource(att_res.hdr.ctx_id, att_res.resource_id);
>   }
>   
> @@ -755,6 +763,14 @@ static void virgl_cmd_ctx_detach_resource(VirtIOGPU *g,
>       trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,
>                                           det_res.resource_id);
>   
> +    if (!virtio_gpu_find_resource(g, det_res.resource_id)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid resource %d for ctx %d\n",
> +                      __func__, det_res.resource_id, det_res.hdr.ctx_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
>       virgl_renderer_ctx_detach_resource(det_res.hdr.ctx_id, det_res.resource_id);
>   }
>   
> @@ -1073,11 +1089,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>           virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
>           break;
>       case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
> -        /* TODO add security */
>           virgl_cmd_ctx_attach_resource(g, cmd);
>           break;
>       case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
> -        /* TODO add security */
>           virgl_cmd_ctx_detach_resource(g, cmd);
>           break;
>       case VIRTIO_GPU_CMD_GET_CAPSET_INFO:


