Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B65C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzviX-0007h9-2f; Fri, 28 Aug 2026 08:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wzviW-0007f8-6y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wzviU-0002ME-8p
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787920193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rS19fT4hEDASyIxwXNgxHR0wu0cgKifpCgEwRP35ln0=;
 b=RWyR2Er3GRjMu4Hbk6Wu8hPo+olB9OSu1TbAz9Xz1gmZim1crDTi+H7l5Chnk6n+0pXoT5
 bDHX7ydnvrWBxGq7zAfKNAQ5tCi0dv2DsO72UxkLLYMltshc3kxkUofImcLNDnpRxNjs7Z
 CHkyfevJY1zHD8JNPWqrJZz8u/Dt3kA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-C4j28TQ8OqqhH830Ar3PqA-1; Fri, 28 Aug 2026 08:29:51 -0400
X-MC-Unique: C4j28TQ8OqqhH830Ar3PqA-1
X-Mimecast-MFC-AGG-ID: C4j28TQ8OqqhH830Ar3PqA_1787920191
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8563c2a53dbso12493657b3.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787920191; cv=none;
 d=google.com; s=arc-20260327;
 b=ng/3k3xWrMrnLvvg9+UHXRvohEMJvDQSPVACQvTrimTyTbeRD+AGcIxGSf5UIltwaT
 +jGoZsf4H1611i6/8MZMQx1hZ2abGMcvUtjPVdwea8DDgOtwrbUww7k7A55pXEA/l5I5
 Z2nGoFFB5kuVdYcCBev+J1TRLcpmqqwiTFP974SPklBQkq+VkKJrgWpT6TqPLMON9nSp
 ZheaNv653XJ/1K/10pYYgsuWGF49kEMH4AlVuExqg6g94WoXnxMDpcLAJ7n0dqISruHl
 SdLDOMxkWLwEKO/lOpizvhVaeH+OcHguBg4aB3LhL1cboxEwN2BwUi7gXU275rs9w6Aj
 LYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rS19fT4hEDASyIxwXNgxHR0wu0cgKifpCgEwRP35ln0=;
 fh=yg5daGthdVMj9fDITVijmPSN3ReNNkmmnmBt2RkEpmU=;
 b=iOshQ4CGE0FisKOlgeHgYp6SSC8Mt6wLUsmn4/zQBHfiWBBDPeeNib+ugkVxw4PXL9
 DHkm0ehnVx4aNz2yJjdz0odzzBH3pOVcHm+z6j3bFTm+/bYBtzJf3FKbZ1pIrnWKBf76
 /sdlvLRVXQP1Gy1zPqJisELWFUXLVUT8aUBp6fqARQiqEsOPDrUNZ7Ii02XvzPYgAVCU
 izJJB9t1UDkABS0FkrLoSV9PQR15jd7JLXLV4ns2ieDPHZgrgBNI+gv7PgMVS9+ilXL5
 jDGqaux9IyWLWl8ZoGaqhPSo75ZuTI4WE0DzXe3yCkcgxM1O9cx8vG30WE1zCdcGkS4G
 fAsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787920191; x=1788524991; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rS19fT4hEDASyIxwXNgxHR0wu0cgKifpCgEwRP35ln0=;
 b=J0iJN/VhQHC/ON3y6SnH7VN+Ko1HDmi4aalqJOqeQ69iu/ILwTs+B/E5zvzXTkZ/dY
 xsAkIyqDnkYG5jKnCnZkpkG1bUb1Jz6n9CY2O1YR8rIJ02VfHgYqJQE3SRn98AExQnVe
 bO+wjOAFdqUmFJU47zvtQR+cygsuhPTOuLnuEqjSVVGSpN0W+stK6WTr7fOhE1LgTxYd
 HcRnlWZRB8T8/EQnDGj7OvpO1udUgUCvFcvPorNJo8U6nbMkq5b8w52uQkBbH80pWcxL
 dN6Hmc46wUDEll36GBYUFIqzxpCRPuSpVYv2qidC17ZpvDBcXr9Gz9BzOVnsQJdKzsfB
 wW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787920191; x=1788524991;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rS19fT4hEDASyIxwXNgxHR0wu0cgKifpCgEwRP35ln0=;
 b=HXRrHKTcCITWhgiO4vhsUq/A8c9zYdAVAZXGZ1c0G92n/Gt2V20HP5QOXhCePnQ5k/
 L3XflGrnExwL+PkE9GiyHmC5jsR3lc7Jy83BQQ0oHwkWLbZds+GjUukBjpxCBIkf5ili
 XaISTLgqVRBgp4EUzWz4SntmFgAkocZkDDwfMQ0wu9A78lviBiRF6FymPyEbB24zgSf4
 KTpbCh31nbNBiGeh9wAm7Qy/GgC2r/pR5028t8Lb1KakizTpmwydRqa7ZmmSs/LGICIq
 0ev69sLzpaVMdsv3FCWiU86y/HsyTZShmbn+H5IilufbKAvcwIr1SabJiQDyeGw8PCaM
 zhEQ==
X-Gm-Message-State: AFuF++lLwBmQHIQnwCU6XpDb48alPREHhbIiHpRBmYAZgE3CwU9bAPu2
 bZVxYd2W4ZwjEP/w3wRIv0HEwuiLF7H8mqe16wc+Be/GXWVwR3Y/MDKCJSp3CKR3yn9z07q61o0
 gzvo7HvgNyjs/I6CXBICQIRPhNfBQ73nAAt5woouBVwYAkYK/NT/FlxS/wOqMWyuExwQpVIDtMe
 bTTeBN0JxsYVkGjAW0gFqXnc0es92xN9g=
X-Gm-Gg: AYBFou059ADd+3mzeQnhqQzQ5NR6j5hO3n2N0I/Q4GPolgPYsT0u9jdY1l+IC5S4ND5
 3B/wyPhQFmqm9J34VzsdlVtBbr2xIiYa3RMRvqt9rq7+AJ88HinEdp2Ezx10Z+cV3MQChXKP8gP
 Jr3unS/3upuYC1ypXOG9G4HLLypfhKnoJgfczkNc8vEej9j0VoL63E9gC/iEbwo1g2pdquuZT3e
 ZEq8eeM6i9U1x1d74mWJqJVS4yVRxfSztMw5xYCk7iiogqYZbQh/lHU1Fc=
X-Received: by 2002:a05:690c:e1d3:20b0:85a:dd2d:906d with SMTP id
 00721157ae682-85d69640f4emr23095627b3.2.1787920190759; 
 Fri, 28 Aug 2026 05:29:50 -0700 (PDT)
X-Received: by 2002:a05:690c:e1d3:20b0:85a:dd2d:906d with SMTP id
 00721157ae682-85d69640f4emr23095397b3.2.1787920190308; Fri, 28 Aug 2026
 05:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-8-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-8-948aae960abb@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 28 Aug 2026 14:29:13 +0200
X-Gm-Features: AcwNN1VHrhFHmM7AUF9p_TslU01gI8yN1qi-kPfIWunAI2DiqE197XuGPz9KRpI
Message-ID: <CAJaqyWfCPYY4rFNZGG2EM6Pdtz66KpO0Rx9U2JmZ8UggzKJEfw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 08/13] hw/virtio/vhost-user: send isolation regions
 to device
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, 
 Peter Xu <peterx@redhat.com>, Alyssa Ross <hi@alyssa.is>, 
 Demi Marie Obenour <demiobenour@gmail.com>,
 20260817233147.2867623-1-connorkite@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Tue, Aug 18, 2026 at 7:12=E2=80=AFAM Connor Kite <connorkite@gmail.com> =
wrote:
>
> Adds features to fill a vhost_user_set_mem_table message with the
> addresses of isolation memory regions corresponding to bounce buffers
> and vrings.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>  hw/virtio/vhost-user.c | 118 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 117 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 7e9233e174..e1e5cba53d 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1140,7 +1140,77 @@ static void cleanup_isolation_regions(struct vhost=
_dev *dev)
>      }
>  }
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
> +    IOVATreeTraversalArgs *args =3D data;
> +    struct vhost_user *u;
> +    VhostUserMsg *msg =3D args->msg;
> +    DMAMap *map =3D key;
> +    uint64_t offset;
> +
> +    assert(args && key && value);
> +    if (!args->vring_node_visited) {
> +        args->vring_node_visited =3D true;
> +        return false;
> +    }
> +
> +    u =3D args->u;
> +    assert(*args->idx < args->fds_size);
> +
> +    args->fds[*args->idx] =3D args->u->iso_mem_ctx.fd;
> +
> +    /*
> +     * If the number of regions is fixed, it would be wasteful to use on=
e for
> +     * only the vrings. The first vhost_iova_tree element is always
> +     * reserved for the vrings, so we can simply combine the first and s=
econd
> +     * elements, which are contiguous in IOVA space, when sending region=
s to
> +     * the backend.
> +     */
> +    if (*args->idx =3D=3D 0) {
> +        offset =3D u->iso_mem_ctx.vring_hva_addr - u->iso_mem_ctx.shared=
_mem_addr;
> +        msg->payload.memory.regions[*args->idx].userspace_addr =3D
> +            args->vring_iova;
> +        /*
> +         * The size from the iova tree is inclusive, so 1 is added to it=
.
> +         * args->vring_size is exclusive, so no addition is required.
> +         */
> +        msg->payload.memory.regions[*args->idx].memory_size =3D
> +            args->vring_size + map->size + 1;
> +        msg->payload.memory.regions[*args->idx].guest_phys_addr =3D
> +            args->vring_iova;
> +        msg->payload.memory.regions[*args->idx].mmap_offset =3D offset;
> +    } else {
> +        /* Use 128 bit operation in unlikely case of negative iso_iova_o=
ffset */
> +        offset =3D int128_get64(int128_add(int128_make64(map->iova),
> +                                        u->iso_mem_ctx.iso_iova_offset))=
 -
> +                (uint64_t)u->iso_mem_ctx.shared_mem_addr;
> +
> +        msg->payload.memory.regions[*args->idx].userspace_addr =3D map->=
iova;
> +        msg->payload.memory.regions[*args->idx].memory_size =3D map->siz=
e + 1;
> +        msg->payload.memory.regions[*args->idx].guest_phys_addr =3D map-=
>iova;
> +        msg->payload.memory.regions[*args->idx].mmap_offset =3D offset;
> +    }
> +
> +    assert(offset + msg->payload.memory.regions[*args->idx].memory_size =
<=3D
> +        u->iso_mem_ctx.size);
> +    (*args->idx)++;
> +
> +    return false;
> +}

The iterator is already inconvenient in the gtree, and the plan is to
remove its usage when glib minimum version is updated and support for
better functions are mandatory. Why not add a function to SVQ to write
the nodes into an array and avoid moving the interface up?

> +
>  static int init_isolation_regions(struct vhost_dev *dev,
>                                    VhostUserMsg *msg,
>                                    int *fds, size_t *fd_num)
> @@ -1159,6 +1229,7 @@ static int init_isolation_regions(struct vhost_dev =
*dev,
>      DMAMap *map;
>      DMAMap vring_map;
>      int r;
> +    IOVATreeTraversalArgs trav_args;
>
>      msg->hdr.request =3D VHOST_USER_SET_MEM_TABLE;
>
> @@ -1244,6 +1315,27 @@ static int init_isolation_regions(struct vhost_dev=
 *dev,
>          }
>      }
>
> +    *fd_num =3D 0;
> +    trav_args.idx =3D fd_num;
> +    trav_args.fds =3D fds;
> +    trav_args.msg =3D msg;
> +    trav_args.u =3D u;
> +    trav_args.vring_iova =3D vring_map.iova;
> +    trav_args.vring_size =3D total_vring_size;
> +    trav_args.fds_size =3D nregions;
> +    trav_args.vring_node_visited =3D false;
> +
> +    vhost_iova_tree_foreach(u->iso_mem_ctx.tree,
> +                            vhost_user_fill_msg_reg_from_tree, &trav_arg=
s);
> +
> +    msg->payload.memory.nregions =3D *fd_num;
> +
> +    assert(*fd_num =3D=3D nregions);
> +
> +    msg->hdr.size =3D sizeof(msg->payload.memory.nregions);
> +    msg->hdr.size +=3D sizeof(msg->payload.memory.padding);
> +    msg->hdr.size +=3D *fd_num * sizeof(VhostUserMemoryRegion);
> +
>      return 0;
>  }
>
> @@ -1251,6 +1343,7 @@ static int vhost_user_set_mem_table(struct vhost_de=
v *dev,
>                                      struct vhost_memory *mem)
>  {
>      struct vhost_user *u =3D dev->opaque;
> +    bool memory_isolation =3D u->user->memory_isolation;
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
>      size_t fd_num =3D 0;
>      bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
> @@ -1262,6 +1355,11 @@ static int vhost_user_set_mem_table(struct vhost_d=
ev *dev,
>      int ret;
>
>      if (do_postcopy) {
> +        /* Postcopy is not supported with memory isolation yet */
> +        if (memory_isolation) {
> +            return -1;
> +        }
> +
>          /*
>           * Postcopy has enough differences that it's best done in it's o=
wn
>           * version
> @@ -1278,6 +1376,24 @@ static int vhost_user_set_mem_table(struct vhost_d=
ev *dev,
>          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>      }
>
> +    if (memory_isolation) {
> +        ret =3D init_isolation_regions(dev, &msg, fds, &fd_num);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        ret =3D vhost_user_write(dev, &msg, fds, fd_num);
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
>      if (config_mem_slots) {
>          ret =3D vhost_user_add_remove_regions(dev, &msg, reply_supported=
, false);
>          if (ret < 0) {
>
> --
> 2.43.0
>


