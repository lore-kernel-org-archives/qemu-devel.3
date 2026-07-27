Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84E2C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHgP-0001pL-5v; Mon, 27 Jul 2026 05:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1woHfu-0001n5-LV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1woHfs-0002i1-UW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785144663;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=e6+0ZtVbeNTds7m2R4p8U7u3x6APq+nb8mJkIY5C5yw=;
 b=E+qVQF0meWL+N1yhG6QgTmXYPpPHC1vyM4y42e2VR2UhVh5QUFYOZ5GrbI3M2gkX6IePVO
 bQvlM0WYFYo141GsH3rKujYHY/ZKWmv2VqIkNUgRj0qzBE6D9aJlQQBt5PXdfgNYap2rrj
 NvYp5DA2pZuS3c4J8dUIPAtOV8NDHds=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-Bo3Fkf_JNFKQT7JNNjCxcA-1; Mon,
 27 Jul 2026 05:30:58 -0400
X-MC-Unique: Bo3Fkf_JNFKQT7JNNjCxcA-1
X-Mimecast-MFC-AGG-ID: Bo3Fkf_JNFKQT7JNNjCxcA_1785144657
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63D6A1955EAC; Mon, 27 Jul 2026 09:30:57 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06E361800370; Mon, 27 Jul 2026 09:30:54 +0000 (UTC)
Date: Mon, 27 Jul 2026 10:30:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] hw/display/virtio-gpu: Reject non-migratable large
 blobs
Message-ID: <amclS3G5VTeZuP8Z@redhat.com>
References: <20260727-blob-v2-1-d0b9af38a975@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-blob-v2-1-d0b9af38a975@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 27, 2026 at 06:23:25PM +0900, Akihiko Odaki wrote:
> The blob size is encoded as a 64-bit integer in the virtio protocol, but
> it is encoded as a 32-bit integer in the migration stream, and
> a large blob whose size cannot be expressed in a 32-bit integer will
> be corrupted after migration. Deny creating such large blobs.

Is there a valid use case for such large blobs ?   If so, rather than
rejecting the blob, we could dynamically add a migration  blocker.
That would allow the valid use cases, while preventing the migration
problem.

> 
> Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
> Fixes: 10b9ddbc83b9 ("Revert "virtio-gpu: block migration of VMs with blob=true"")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Changes in v2:
> - Add the Fixes: tag for f66767f75c9c.
> - Add a TODO to encode blob_size as 64 bits in virtio-gpu/blob
>   VMState version 2.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260725-blob-v1-1-f643fbd76398@rsg.ci.i.u-tokyo.ac.jp
> ---
>  hw/display/virtio-gpu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 718ba3039290..987b1b3ea860 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -352,6 +352,14 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
>          return;
>      }
>  
> +    if (cblob.size > UINT32_MAX) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: blob too large (%" PRIu64 "> %" PRIu32 ")\n",
> +                      __func__, cblob.size, UINT32_MAX);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
> +
>      if (virtio_gpu_find_resource(g, cblob.resource_id)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
>                        __func__, cblob.resource_id);
> @@ -1435,7 +1443,14 @@ static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
>          }
>          assert(!res->image);
>          qemu_put_be32(f, res->resource_id);
> +
> +        /*
> +         * The migration stream encodes blob_size as a 32-bit integer for
> +         * compatibility though virtio encodes it as a 64-bit integer. A newer
> +         * version of the migration stream should encode it as a 64-bit integer.
> +         */
>          qemu_put_be32(f, res->blob_size);
> +
>          qemu_put_be32(f, res->iov_cnt);
>          for (i = 0; i < res->iov_cnt; i++) {
>              qemu_put_be64(f, res->addrs[i]);
> 
> ---
> base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
> change-id: 20260725-blob-8a6a1a85601a
> 
> Best regards,
> --  
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


