Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9C6C55843
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqt02-0003zk-1x; Mon, 03 Aug 2026 09:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqszv-0003yt-TB
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 09:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqszs-0006Vn-S8
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 09:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785764788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clQ8oxgBiu9V0p8RvuISxI5zCabsH/c0QTq//4l9q1A=;
 b=LYuendcTmQKkolyqrmoBohVmymNKLn3h0v/4AMVluFKQHQWlCGur8VZD6q0xnRVHb7qKZg
 W8fM3pfZ36F4FEtu/fz3BRpTeqeMvd1MVd3zmwWIo82oB5J41zBUn+q3e0JgiOf2JCqyWb
 X7qEkYMArO70SZhZ+T9mqSSGXljy/xs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-ByZXAoM3OPqDKtMpf7dKBw-1; Mon, 03 Aug 2026 09:46:25 -0400
X-MC-Unique: ByZXAoM3OPqDKtMpf7dKBw-1
X-Mimecast-MFC-AGG-ID: ByZXAoM3OPqDKtMpf7dKBw_1785764785
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4957287363bso13838645e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785764784; x=1786369584; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=clQ8oxgBiu9V0p8RvuISxI5zCabsH/c0QTq//4l9q1A=;
 b=kmdcf6gIPzbVp7nFXBhmUxDz0aSiWMTm3R+Cb8jbWV31e6He5Ax1p527DX10cXr/vk
 wSR/ZWelTBXyhvDeBdIPS8uPVd4Re1Mwxqogu4zK8gRztgJ9k45Yw23a+ANqZ2OcSPtN
 HBwxlWDEVGH6+GG6Z1guh0vhzXPuCtrhtrASFbycAZzou8kYHgsGytN7eK3jGxvOyrY5
 R2fyVsAAwOJKqvvMTdMqRM12BllZDEk4ZlDf31J7Y1Ubmh5iJEJGZ5nW3z7PakYpB3we
 lqJzGblbClr2GXT5Nmo/1GbCmqTiCtrNU2MsA8L68wqNygO+OpUtQXjQHdfOZosAj+a3
 c9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785764784; x=1786369584;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=clQ8oxgBiu9V0p8RvuISxI5zCabsH/c0QTq//4l9q1A=;
 b=cGwmM4nteoDHizwKUihfQhJ8pnVArod2iHu5xZyYdBRjYFwmPnmcJ6qcJy+7s6MLJd
 SKFT4b4JvZkcASSl/kmcguVUJFtvkNa5Usvym/TCqgVNwTNfDU6YQPR5uVevEs4Go2qf
 Iq2l8OhGw6jvYGsIyQFItew0fE5c/0lDM0iDCXPILV/YW8nSumlvu66p7FR1JLXraO84
 6BwvLMVjVr0k6MbH7GYmcMAIO6wkPryaCdcisQQyQoQ04CxRW4tE5tq4BtI06VPSBpRd
 j9DpTf8NTdrnmlGzVgK0AKtVznKm5+fCI4VBpi9gwQAcGxJA9g+zvuyOWPaLkxdcX4ov
 LQ8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqthJiDSSJL6FlIqRgnXl/BSKBimfKHijat7DR+r1PEmHWuDb4Jk+B8RZvmuVr+6qaVURcMwMJDcjyQ@nongnu.org
X-Gm-Message-State: AOJu0Yw1+4mKgBwFS1HpmwEvYzMzpPqu+DQRln4561y4slSpmlNLAOd8
 NAnLa1Lfclvg/21eza/IDtHcBmESotaVqGGsq0TPXYyLdRmERRG8n3QmJKGiFcU+f/WK1ILcP9t
 B6pHlFdawROqNfNcaT13TFcMWkjoNzpMQ0hiKhD/v69Aya6LLU6qCoFPW
X-Gm-Gg: AR+sD13tBz5qR4Mkitlgiqz72Fk8dNoc6TH9UCPmmEXK1otSJE8T37D4hlouxjNHNQ/
 lv3r9ffHrCIUQEf7npNZy4dWse73TxmTe4zIUAad6c/boogxNVaFAzIg6CwGR54o1UA5YSugA8M
 LZIXqslvKoyFNMeyH8RMXMWKOTREhGJbWkW+yW+jYen4FRuBjx5n8ArEdL4We8ZVDb0xibFcxgp
 SyrmGbnkOWXlbsEKnHTbPhw+dFlhZvryJoC5eG3vrPsossOMsLLcSeCYeZh9ENinxDY+Z96ag/E
 gonm+l/IdkFOeh0Tw8W6Ng+KYOH9uDOi9lpOsCGHE+53exKq+TnzGoAfeeCLtzwgwQ13mYVvsYM
 Y0RAqnEPM5vCIJFvESPAlm3we0LzqSnl39K9z7/AkPGfrrbj1gbFuc6XsfV2le4cizgShXmVC94
 /bqEQ/vEu8Hpayik1d7j2kO+4Qx6Vtdg==
X-Received: by 2002:a05:600c:628d:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-4980c64e4c8mr238636795e9.13.1785764784465; 
 Mon, 03 Aug 2026 06:46:24 -0700 (PDT)
X-Received: by 2002:a05:600c:628d:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-4980c64e4c8mr238636115e9.13.1785764784079; 
 Mon, 03 Aug 2026 06:46:24 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:549a:e584:7c7b:2611:32a1?
 (p200300cfd73d549ae5847c7b261132a1.dip0.t-ipconnect.de.
 [2003:cf:d73d:549a:e584:7c7b:2611:32a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b917desm215979585e9.10.2026.08.03.06.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 06:46:23 -0700 (PDT)
Message-ID: <9478d870-641b-4f3c-a5da-9026a0ec137d@redhat.com>
Date: Mon, 3 Aug 2026 15:46:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/15] hw/virtio/vhost-user: send isolation regions to
 device
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>,
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
 Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-12-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-12-6b97c439eb28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24.07.26 00:30, Connor Kite wrote:
> Adds features to fill a vhost_user_set_mem_table message with the
> addresses of isolation memory regions corresponding to bounce buffers
> and vrings.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-user.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 79 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 710cf966f8..acabfb7f1c 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -625,6 +625,21 @@ static void vhost_user_fill_msg_region(struct vhost_dev *dev,
>       dst->mmap_offset = mmap_offset;
>   }
>   
> +static void vhost_user_fill_msg_region_iso(VhostUserMemoryRegion *dst,
> +                                           const struct vhost_user *u,
> +                                           const struct vhost_memory_region
> +                                           *iova_reg)
> +{
> +    assert(u != NULL && dst != NULL && iova_reg != NULL);
> +    uint64_t offset;
> +
> +    offset = iova_reg->userspace_addr - u->iso_memory.base_addr;
> +    dst->userspace_addr = iova_reg->userspace_addr;
> +    dst->memory_size = iova_reg->memory_size;
> +    dst->guest_phys_addr = iova_reg->userspace_addr;
> +    dst->mmap_offset = offset;
> +}
> +
>   static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
>                                                struct vhost_dev *dev,
>                                                VhostUserMsg *msg,
> @@ -1136,7 +1151,33 @@ static void cleanup_isolation_regions(struct vhost_dev *dev)
>       }
>   }
>   
> -__attribute__((unused))
> +struct iova_tree_traversal_args {
> +    VhostUserMsg *msg;
> +    struct vhost_user *u;
> +    int *fds;
> +    size_t *fd_num;
> +};
> +
> +static gboolean vhost_user_iova_tree_traverse_funct(gpointer key,
> +                                                    gpointer value,
> +                                                    gpointer data)

This function name doesn’t really say what the function does, and more 
describes its type.

> +{
> +    struct iova_tree_traversal_args *args = data;
> +    struct vhost_memory_region msg_region;
> +    VhostUserMemoryRegion region_buffer;
> +    DMAMap *map = key;
> +    args->fds[*args->fd_num] = args->u->iso_memory.iso_fd;

Generally: I find it quite hard to read code where general statements 
come after a list of declarations without an empty line, especially if 
there is an empty line later. Visually, this last line to me looks like 
another variable declaration.

> +
> +    msg_region.guest_phys_addr = map->iova;
> +    msg_region.memory_size = map->size + 1;
> +    msg_region.userspace_addr = map->iova;
> +    vhost_user_fill_msg_region_iso(&region_buffer, args->u, &msg_region);
> +    args->msg->payload.memory.regions[*args->fd_num] = region_buffer;

Why does `vhost_user_fill_msg_region_iso()` exist when this is the only 
caller, and we could just fill `regions[i]` here directly?

> +    (*args->fd_num)++;

As noted by Akihiko, there needs to be some bounds checking. At least 
against `VHOST_MEMORY_BASELINE_NREGIONS`, but even better against the 
array size of `args->msg->payload.memory.regions` and the caller should 
pass the size of `fds[]` via `args`.

(And I’m also with Stefan, something with `index` would be better. Maybe 
`region_idx`.)

> +
> +    return false;
> +}
> +
>   static int init_isolation_regions(struct vhost_dev *dev,
>                                     VhostUserMsg *msg,
>                                     int *fds, size_t *fd_num)
> @@ -1234,6 +1275,24 @@ static int init_isolation_regions(struct vhost_dev *dev,
>                                         map->translated_addr);
>       }
>   
> +    struct iova_tree_traversal_args args = {
> +        .fd_num = fd_num,
> +        .fds = fds,
> +        .msg = msg,
> +        .u = u
> +    };

Personal preference: I would like `*fd_num = 0` somewhere here, or 
`assert(*fd_num == 0)` before the iteration. Yes, the caller initializes 
it to zero, but it is just not obvious here, and it seems necessary for 
correct semantics.

(And the open question whether `fd_num` should be renamed here, too, or 
can keep that name. Not sure.)

> +
> +    vhost_iova_tree_foreach(u->iso_iova_tree,
> +                            vhost_user_iova_tree_traverse_funct, &args);
> +
> +    msg->payload.memory.nregions = *fd_num;
> +
> +    assert(*fd_num != 0);

Am I wrong or should `*fd_num == nregions`? Is it possible that 
`*fd_num` is less because regions end up joined? Can you add a comment 
on when they would differ?

Hanna

> +
> +    msg->hdr.size = sizeof(msg->payload.memory.nregions);
> +    msg->hdr.size += sizeof(msg->payload.memory.padding);
> +    msg->hdr.size += *fd_num * sizeof(VhostUserMemoryRegion);
> +
>       return 0;
>   }

[...]


