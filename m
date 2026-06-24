Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0DDCDE001
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcJP9-000812-4d; Wed, 24 Jun 2026 04:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcJP3-00080f-4Y
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 04:56:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcJP1-000749-1u
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 04:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782291368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnxS6Q93MUJafurmYLSxH5258s701tXHPdr+Qjs9U8s=;
 b=Rq0KWBcSNHF3m74aqXJlWKbKkQmpvlgzk1WW1ltMU0pu0u2jPe3bhGKFdV+q8vFeyQEBTp
 3QdCSLe0fjA1bjnr1gbRNrOkCjfxh5mnq9VSccNFbns6Dmdw3SHo2Oz4d8T8yffFcuge4i
 egQq8vruJgh+egnTeYu3qZrOc291AJU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-JbAbsSUQNbaFFC7fl2F72g-1; Wed,
 24 Jun 2026 04:56:06 -0400
X-MC-Unique: JbAbsSUQNbaFFC7fl2F72g-1
X-Mimecast-MFC-AGG-ID: JbAbsSUQNbaFFC7fl2F72g_1782291365
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8204D1800370; Wed, 24 Jun 2026 08:56:04 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C6EB1800667; Wed, 24 Jun 2026 08:56:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] virtio-gpu-virgl: validate resource existence on
 ctx attach/detach
From: marcandre.lureau@redhat.com
To: Bin Guo <guobin@linux.alibaba.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 dmitry.osipenko@collabora.com, qemu-devel@nongnu.org
In-Reply-To: <32f6f23fb4880a4f1ec3056fde306332d54e442f.1782270919.git.guobin@linux.alibaba.com>
References: <cover.1782270919.git.guobin@linux.alibaba.com>
 <32f6f23fb4880a4f1ec3056fde306332d54e442f.1782270919.git.guobin@linux.alibaba.com>
Date: Wed, 24 Jun 2026 12:55:55 +0400
Message-Id: <178229135572.323593.5328740742176153232.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3118;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jUgoBOvq6CJHaaNiMac8E3o8Xm7r9G+ropf2FQ4yRDc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO5udzOY4ptE6aHbTriPoCEJaj6nbZkbogZYdJ
 sZWkXxdVTqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajubnQAKCRDa6OEJdZac
 5ZrkD/9CjfmW5hQUJbtS9pVe8Ut9uedZuxMGHkLzrtRWItljEmfYiCcbP2Tks9BaM7wXsALj23w
 GjZv7N8zMfIFnkODPzmkKmymZCHaRQ5gLj2Omy70vTLV+OMeJiCvkS2dGAoIfI+2lxu+ILOMhxF
 GRNuerpwmauHm2NpmLv9iZc/zeIAj0EblSls1dJWJh8HxvnE8VzG443qcL02WFgN3NXRYgL5P6Y
 qyPnia30X+NUd2a1KETllHpXllZaeb0pcjPgaJ83BqItXoU4kKRBQT21TIzgV5UHLHS2J2YJ0tW
 me3QDROP4qyTK2rXGq8BGYLoaSC2BR7kYbf6AEBH1I/WZujK8C+Ktujx6j8k46EksRjH/Krjtze
 Mn5GVBEpKvNrBan6bM+yusK+3/oNuc95K8CnY4nhPVpCyu/+Pb6qbl6NBIzqid+y+8Jvmh4+ZAt
 NDkRp7ljqhcGbJUJkNwy/yNARFOqYznOLjwD1xhxurAPKq/KazbwG79gy83mc/7FXUeDWElrUiP
 4b0g9ae5I/Epgaavr5eQ6jdNB7mqL7Iezjp7ZldF970KZgrumzaHLyZuis+4z9aexPR6WLVWjH4
 kvLB1GoHapYtM2GLeK9pmQHYqUwfEDHiY7ZJFQDgd2mXP36y/9ZgnfseaNeNLdrZAUd8TzS3tN0
 0v4puVbOH6qM5/w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> Message-ID: <32f6f23fb4880a4f1ec3056fde306332d54e442f.1782270919.git.guobin@linux.alibaba.com>
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 60c78af06a4..b992ffc44e1 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -743,6 +743,14 @@ static void virgl_cmd_ctx_attach_resource(VirtIOGPU *g,
>      trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,
>                                          att_res.resource_id);
>  
> +    if (!virtio_gpu_find_resource(g, att_res.resource_id)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid resource %d for ctx %d\n",
> +                      __func__, att_res.resource_id, att_res.hdr.ctx_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
>      virgl_renderer_ctx_attach_resource(att_res.hdr.ctx_id, att_res.resource_id);
>  }
>  
> @@ -755,6 +763,14 @@ static void virgl_cmd_ctx_detach_resource(VirtIOGPU *g,
>      trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,
>                                          det_res.resource_id);
>  
> +    if (!virtio_gpu_find_resource(g, det_res.resource_id)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid resource %d for ctx %d\n",
> +                      __func__, det_res.resource_id, det_res.hdr.ctx_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +

There is room for factorizing the checking of cmd resource ids. ok.

>      virgl_renderer_ctx_detach_resource(det_res.hdr.ctx_id, det_res.resource_id);
>  }
>  
> @@ -1073,11 +1089,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>          virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
>          break;
>      case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
> -        /* TODO add security */
>          virgl_cmd_ctx_attach_resource(g, cmd);
>          break;
>      case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
> -        /* TODO add security */

Tbh, I am not sure what Gerd had in mind when he wrote that. I doubt it was only about checking resource IDs.

>          virgl_cmd_ctx_detach_resource(g, cmd);
>          break;
>      case VIRTIO_GPU_CMD_GET_CAPSET_INFO:

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


