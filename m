Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F97CCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 10:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKwIW-0000VV-Av; Mon, 17 Nov 2025 05:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKwIU-0000VK-Ki
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:17:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKwIS-00035Z-Oi
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763374639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IV3JfogcwSiDa5HDuL7x9KB1wgpHIITweQyjmTOvbSk=;
 b=CTjPHqyDhFi+JTuiWkToCKJ9cIivo1yVHH38HlhdOuZJorl5F3K6iV7Zj7MINyz/0F58Ji
 xawCk4kNE/P9KvtIqTOMWta46FOuo0YaWpgdLH7BZg5UfMrH4TsZk3dnGgghenJz2Q83mW
 6EgiGSNXDLeztOvxtt1jXmTPuAsGCwA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-yJc9AH8kMqC0SIBb2FmuTQ-1; Mon,
 17 Nov 2025 05:17:15 -0500
X-MC-Unique: yJc9AH8kMqC0SIBb2FmuTQ-1
X-Mimecast-MFC-AGG-ID: yJc9AH8kMqC0SIBb2FmuTQ_1763374634
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD22A1800452; Mon, 17 Nov 2025 10:17:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECD71180057F; Mon, 17 Nov 2025 10:17:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 343D821E6A27; Mon, 17 Nov 2025 11:17:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Honglei Huang <honghuan@amd.com>
Cc: <alex.bennee@linaro.org>,  <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  <armbru@redhat.com>,  <mst@redhat.com>,
 <cohuck@redhat.com>,  <pbonzini@redhat.com>,  <qemu-devel@nongnu.org>,
 <Ray.Huang@amd.com>
Subject: Re: [v3] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
In-Reply-To: <20251117085342.175659-1-honghuan@amd.com> (Honglei Huang's
 message of "Mon, 17 Nov 2025 16:53:42 +0800")
References: <20251117085342.175659-1-honghuan@amd.com>
Date: Mon, 17 Nov 2025 11:17:11 +0100
Message-ID: <87ikf9q7yw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Honglei Huang <honghuan@amd.com> writes:

> Fix error handling logic in virgl_cmd_resource_create_blob and improve
> consistency across the codebase.
>
> virtio_gpu_create_mapping_iov() returns 0 on success and negative values
> on error, but the original code was incorrectly checking 'if (!ret)' for
> error conditions.
>
> Change all virtio_gpu_create_mapping_iov() error checks to use 'if (ret < 0)'
> instead of 'if (ret != 0)', following the preferred QEMU coding convention
> for functions that return 0 on success and negative on error. This makes
> the return value convention immediately clear to code readers without
> needing to look up the function definition.
>
> Updated locations:
> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_attach_backing()
> - hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
> - hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()
>
> Changes since v2:
> - Use 'if (ret < 0)' instead of 'if (ret != 0)' following maintainer's
>   feedback on preferred QEMU coding style for error checking functions
>   that return 0 on success and negative on error
> - Updated all similar usages across virtio-gpu files for consistency

Appreciated!

> - Expanded scope from single function fix to codebase-wide style consistency

Likewise.

> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  hw/display/virtio-gpu-virgl.c | 4 ++--
>  hw/display/virtio-gpu.c       | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 94ddc01f91..6ebd9293e5 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -557,7 +557,7 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
>  
>      ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>                                          cmd, NULL, &res_iovs, &res_niov);
> -    if (ret != 0) {
> +    if (ret < 0) {
>          cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>          return;
>      }
> @@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>          ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>                                              cmd, &res->base.addrs,
>                                              &res->base.iov, &res->base.iov_cnt);
> -        if (!ret) {
> +        if (ret < 0) {
>              cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>              return;
>          }
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 0a1a625b0e..1038c6a49f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -352,7 +352,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
>      ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>                                          cmd, &res->addrs, &res->iov,
>                                          &res->iov_cnt);
> -    if (ret != 0) {
> +    if (ret < 0) {
>          cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>          g_free(res);
>          return;
> @@ -931,7 +931,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>  
>      ret = virtio_gpu_create_mapping_iov(g, ab.nr_entries, sizeof(ab), cmd,
>                                          &res->addrs, &res->iov, &res->iov_cnt);
> -    if (ret != 0) {
> +    if (ret < 0) {
>          cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>          return;
>      }

There are two calls hw/display/virtio-gpu-rutabaga.c:

       ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
                                           cmd, NULL, &res->iov, &res->iov_cnt);
       CHECK(!ret, cmd);

and

       if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
           result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
                                                  sizeof(cblob), cmd, &res->addrs,
                                                  &res->iov, &res->iov_cnt);
           CHECK(!result, cmd);
       }

CHECK() hides return in a macro, which strikes me as a Bad Idea, but
that's a separate issue.  Would it make sense to change to
CHECK(result >= 0)?


