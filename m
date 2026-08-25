Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A4DC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysGu-0006Aw-46; Tue, 25 Aug 2026 10:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wysGt-0006Ab-AL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wysGr-0006OQ-4s
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787668620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Y6U34bGx3veeh8PYVBNu/tfNq9cvpQ+I7J9hPo13VE=;
 b=Au+0Mm1k/jpqjkjT3KCUhDaauXk6C6pGvmTOLO512ggZlUoQlCwyhcistCIhW8yhJZh54p
 6vxKkpLlmT4PBBvDkYSJxUEvT99PWd/WHw40O93eMyoNAPkkpGlt8tcbYR3p6SMliCVDan
 2uTmWu1vHtF46yejwKdyO0KhQlHbvpg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-xr5HyPi_N7WimR4hgi7eqQ-1; Tue, 25 Aug 2026 10:36:58 -0400
X-MC-Unique: xr5HyPi_N7WimR4hgi7eqQ-1
X-Mimecast-MFC-AGG-ID: xr5HyPi_N7WimR4hgi7eqQ_1787668617
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-69c20d1d150so4034418a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787668617; x=1788273417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4Y6U34bGx3veeh8PYVBNu/tfNq9cvpQ+I7J9hPo13VE=;
 b=pdnB5YRefRkhn/oTtki8gnP5G0DNfcZnbvEYrkrvNtlMz3zs0BieWnye2KtQARZAQI
 qWIBxd+TznwBuByEP6zF1/z+YMPzcsOc1KUrAOaMnbCKEcqvAyR0EvtZUtDsq0ixcFuf
 UUT5QHNZ09y9+6+ObCeHj9CdfAKllpsPF38pqfFUeJvnP5JIJ+RN68+kDq5b2qaeAzqI
 aTzBzQfg3b3lzN/OpOiKunrImD50u55ALKxt956dLKVvNZhrfIlm/4gJJgnuHEo9AlZ8
 /5aB4XTT6+NUnX7228hXC5bHFDcztBN0n3dTinn3Y349zDocsvBg1BGoyFcYdFyMJJ79
 PcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787668617; x=1788273417;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Y6U34bGx3veeh8PYVBNu/tfNq9cvpQ+I7J9hPo13VE=;
 b=F9ks5FUtFrMwoH4JKwCQSxj747r/sVUmcvfIeXeJZSOJlXvLNwMWPox9AaxGhdNbCj
 lfsAOyS3LSpgpSnesBZ6T8tNUpfyDYXqxArAcTrvj2gI95QYFAZfTPIKw8yujrXknP75
 lJ2C5oCHcyglVh32EEn09kffIXdsfjYELzW3THHBEpQ8tPr0SkjH/jK0rJ7l/9BvfTOH
 1twlvKKB7W8BI/Au4IEhkSme6+7NdXkCUQNfFy8os4iSQlPC9MOP+0WkRuiG8X3P6UQQ
 hNTc3m16ng044mW3v6872idUs1kVJ1iYara+hu4M23QHeyEe1hlo4gzvgAgZFY3E+yzs
 ELhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzuBEg3+ZUM+tCtrjYMOOpr/MNBl5rXL8d+3zLcfzXcXXXvMZ6UJnNE5ORfaSQkUBolkiXzsJ3lIpa@nongnu.org
X-Gm-Message-State: AFuF++lpG5fduwho4V6e1KapW/fs88uXll0OMM+PzgGQ7GG9VAbPGPcg
 Ox8yQRfCnPzxkFAdavCSYBDmceUtUZAZEEQj9SxfqWPBpex940yz2w9U96aIzlJhvkvoMlg8P7K
 dOMdlp0NiMHZ0iTG4L+ItYwb/9zFaOYhjn+OfzeHt7cEDkTkGX9GHjEBJ
X-Gm-Gg: AR+sD11bF+kz7GOEECObQtzuTqeUr/XIhX/GwYsN3GFXm/COaheAAcrLZAu6N1JL/KS
 5wI7CDYCMcJjRZ+O+EM39vnpPWROXH+88Z4w0xa2pNDimvt7+2aSAcVW3xCbbFDs/6SKfghEBNP
 hgvyolC7wP0fufk9iptc6L1sSF0fk/WXbf7vqSCtohQ2+hEAlAR8CH1DFMRhPVCzJxv8NWCZtNs
 WRUw/Py5sRYHfhFQ4rhGrJIAffge6HVupjV7rOXZ5IKxIld93+f2Qe5apl+K8ayVZbsAk2XxRLQ
 R3lSlM4GKbzyUYmp+OFfW3BrUQ5qz9VZ2F9e4iON1kQYvb7D3oMNevPEEZdtN4u/rzQpMmN4v5Z
 +2qpaDHfFluQc4hR+JEp5JsHtINJzUFcgL2D6D8j9ChW4TMe95CkCHH0u9qTpwnFp8AHoYi6ArO
 7Qi08nSmErC9NSRxhtCJTBG+FIJGESNw==
X-Received: by 2002:a05:6402:2411:b0:6a3:fee5:adcf with SMTP id
 4fb4d7f45d1cf-6a5c409f463mr9032325a12.1.1787668617204; 
 Tue, 25 Aug 2026 07:36:57 -0700 (PDT)
X-Received: by 2002:a05:6402:2411:b0:6a3:fee5:adcf with SMTP id
 4fb4d7f45d1cf-6a5c409f463mr9032231a12.1.1787668616631; 
 Tue, 25 Aug 2026 07:36:56 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70a:12bf:c327:80a0:6d65:31e3?
 (p200300cfd70a12bfc32780a06d6531e3.dip0.t-ipconnect.de.
 [2003:cf:d70a:12bf:c327:80a0:6d65:31e3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8d21f8sm27422a12.11.2026.08.25.07.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 07:36:55 -0700 (PDT)
Message-ID: <f543b2a9-46ed-4dcc-ba3c-650c2a7ca10d@redhat.com>
Date: Tue, 25 Aug 2026 16:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 08/13] hw/virtio/vhost-user: send isolation regions
 to device
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Demi Marie Obenour <demiobenour@gmail.com>,
 20260817233147.2867623-1-connorkite@gmail.com
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-8-948aae960abb@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-8-948aae960abb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 18.08.26 07:12, Connor Kite wrote:
> Adds features to fill a vhost_user_set_mem_table message with the
> addresses of isolation memory regions corresponding to bounce buffers
> and vrings.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-user.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 117 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 7e9233e174..e1e5cba53d 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1140,7 +1140,77 @@ static void cleanup_isolation_regions(struct vhost_dev *dev)
>       }
>   }
>   
> -__attribute__((unused))
> +typedef struct {
> +    VhostUserMsg *msg;
> +    struct vhost_user *u;
> +    int *fds;
> +    size_t fds_size;
> +    uint64_t vring_iova;
> +    size_t vring_size;
> +    bool vring_node_visited;
> +    size_t *idx;
> +} IOVATreeTraversalArgs;
> +
> +static gboolean vhost_user_fill_msg_reg_from_tree(gpointer key,
> +                                                  gpointer value,
> +                                                  gpointer data)
> +{
> +    IOVATreeTraversalArgs *args = data;
> +    struct vhost_user *u;
> +    VhostUserMsg *msg = args->msg;
> +    DMAMap *map = key;
> +    uint64_t offset;
> +
> +    assert(args && key && value);
> +    if (!args->vring_node_visited) {
> +        args->vring_node_visited = true;
> +        return false;
> +    }
> +
> +    u = args->u;
> +    assert(*args->idx < args->fds_size);
> +
> +    args->fds[*args->idx] = args->u->iso_mem_ctx.fd;
> +
> +    /*
> +     * If the number of regions is fixed, it would be wasteful to use one for
> +     * only the vrings. The first vhost_iova_tree element is always
> +     * reserved for the vrings, so we can simply combine the first and second
> +     * elements, which are contiguous in IOVA space, when sending regions to
> +     * the backend.
> +     */

I am not sure it makes sense to optimize here if it makes the code more 
complicated and the eventual goal would rather be to have a dedicated 
memory area for the device I/O memory rather than a full mirror of guest 
memory. Specifically because that full mirror already is quite wasteful, 
so… it was my understanding that the full mirror is mostly for testing 
anyway.

Hanna

> +    if (*args->idx == 0) {
> +        offset = u->iso_mem_ctx.vring_hva_addr - u->iso_mem_ctx.shared_mem_addr;
> +        msg->payload.memory.regions[*args->idx].userspace_addr =
> +            args->vring_iova;
> +        /*
> +         * The size from the iova tree is inclusive, so 1 is added to it.
> +         * args->vring_size is exclusive, so no addition is required.
> +         */
> +        msg->payload.memory.regions[*args->idx].memory_size =
> +            args->vring_size + map->size + 1;
> +        msg->payload.memory.regions[*args->idx].guest_phys_addr =
> +            args->vring_iova;
> +        msg->payload.memory.regions[*args->idx].mmap_offset = offset;
> +    } else {
> +        /* Use 128 bit operation in unlikely case of negative iso_iova_offset */
> +        offset = int128_get64(int128_add(int128_make64(map->iova),
> +                                        u->iso_mem_ctx.iso_iova_offset)) -
> +                (uint64_t)u->iso_mem_ctx.shared_mem_addr;
> +
> +        msg->payload.memory.regions[*args->idx].userspace_addr = map->iova;
> +        msg->payload.memory.regions[*args->idx].memory_size = map->size + 1;
> +        msg->payload.memory.regions[*args->idx].guest_phys_addr = map->iova;
> +        msg->payload.memory.regions[*args->idx].mmap_offset = offset;
> +    }
> +
> +    assert(offset + msg->payload.memory.regions[*args->idx].memory_size <=
> +        u->iso_mem_ctx.size);
> +    (*args->idx)++;
> +
> +    return false;
> +}
> +
>   static int init_isolation_regions(struct vhost_dev *dev,
>                                     VhostUserMsg *msg,
>                                     int *fds, size_t *fd_num)
> @@ -1159,6 +1229,7 @@ static int init_isolation_regions(struct vhost_dev *dev,
>       DMAMap *map;
>       DMAMap vring_map;
>       int r;
> +    IOVATreeTraversalArgs trav_args;
>   
>       msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
>   
> @@ -1244,6 +1315,27 @@ static int init_isolation_regions(struct vhost_dev *dev,
>           }
>       }
>   
> +    *fd_num = 0;
> +    trav_args.idx = fd_num;
> +    trav_args.fds = fds;
> +    trav_args.msg = msg;
> +    trav_args.u = u;
> +    trav_args.vring_iova = vring_map.iova;
> +    trav_args.vring_size = total_vring_size;
> +    trav_args.fds_size = nregions;
> +    trav_args.vring_node_visited = false;
> +
> +    vhost_iova_tree_foreach(u->iso_mem_ctx.tree,
> +                            vhost_user_fill_msg_reg_from_tree, &trav_args);
> +
> +    msg->payload.memory.nregions = *fd_num;
> +
> +    assert(*fd_num == nregions);
> +
> +    msg->hdr.size = sizeof(msg->payload.memory.nregions);
> +    msg->hdr.size += sizeof(msg->payload.memory.padding);
> +    msg->hdr.size += *fd_num * sizeof(VhostUserMemoryRegion);
> +
>       return 0;
>   }
>   
> @@ -1251,6 +1343,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                       struct vhost_memory *mem)
>   {
>       struct vhost_user *u = dev->opaque;
> +    bool memory_isolation = u->user->memory_isolation;
>       int fds[VHOST_MEMORY_BASELINE_NREGIONS];
>       size_t fd_num = 0;
>       bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
> @@ -1262,6 +1355,11 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>       int ret;
>   
>       if (do_postcopy) {
> +        /* Postcopy is not supported with memory isolation yet */
> +        if (memory_isolation) {
> +            return -1;
> +        }
> +
>           /*
>            * Postcopy has enough differences that it's best done in it's own
>            * version
> @@ -1278,6 +1376,24 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>           msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
>       }
>   
> +    if (memory_isolation) {
> +        ret = init_isolation_regions(dev, &msg, fds, &fd_num);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        ret = vhost_user_write(dev, &msg, fds, fd_num);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        if (reply_supported) {
> +            return process_message_reply(dev, &msg);
> +        }
> +
> +        return 0;
> +    }
> +
>       if (config_mem_slots) {
>           ret = vhost_user_add_remove_regions(dev, &msg, reply_supported, false);
>           if (ret < 0) {
>


