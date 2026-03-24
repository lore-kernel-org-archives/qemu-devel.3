Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FCCE9A775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 11:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w503O-0008H4-QR; Tue, 24 Mar 2026 07:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w503I-0008CP-V5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 07:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w503H-000803-2e
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 07:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774352161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5F4Tj4Whbu8nVgEJBtyQ5EINzLsvu1dVue6iQkG0YcE=;
 b=Qdr0tXb5RBQBgU8tef0ydZTuSCpQr2xaabCgJiWgFIUgDUgopzoIMHHo1z1m5GhTPksVBP
 ryvlae0JZMKAEGnDYtkihppOhtSdBJixskyHojOHAscS3YOBkCz+md4BcE/5LZEA/OdJNa
 j8u4G5apltbAx5hQLpWBtRx1b5ubH0A=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-_PIEUvDQMdqcLGC2GeRUgg-1; Tue, 24 Mar 2026 07:35:59 -0400
X-MC-Unique: _PIEUvDQMdqcLGC2GeRUgg-1
X-Mimecast-MFC-AGG-ID: _PIEUvDQMdqcLGC2GeRUgg_1774352159
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7983f854288so86341447b3.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 04:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774352159; cv=none;
 d=google.com; s=arc-20240605;
 b=KN7IMXq9y99BJa+q9NsFwHXeTVwkQEo0UBxu/lKBM7cfoPEX1dZ+Gk4eX26jyg2Zfi
 VQtic6ZPOIXgXsQEAJG5nrM3WBMtxOM9lkqTbNJnQh0uQcTTuoXiD/T0dzbkDWsOaMY/
 r0bycRW56RHVt/3Cx5txHWfeffEByrBJ+xLeGSLqXEd7DaswWZKg2jsoXouvm/N68qN3
 Oh+TmXY91AWAzlpxkBtbCWYtcZfrJFQCtTRCn1NcIXSDoUC0BTroT3d40lnu9qQrSG56
 SReWN67EaggR+0yLT0vJNdjEy64Sg3L66yG7x2MQ3Q08vcTZ4yNVmXMBk/9ppyN1ev9m
 zYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5F4Tj4Whbu8nVgEJBtyQ5EINzLsvu1dVue6iQkG0YcE=;
 fh=/Q1walrJ1rQppfQIaR5kN+L7c1qEv+piY1FwYfW9K3g=;
 b=GpEmfOCIJZuIYRBtitxIvBhQzTElpPqCPBs7h+AHTjnSeJZcCFeF/l4PMa5ZH+NOmZ
 OlHiuuPSntc2dgTjlOId4JCb3wIfcODtguhoiUdG9/6RBk0+H30iTcgytmz+aM+n/NkQ
 wqCbB82/7+sHClMMb5BBjMUJHwZKjFwgObVPkGFH6WqP8dL/yfyC+E9Gaz7w/IgiRsY3
 CJ1Ljw6r5rsFeXrp/G9gz+2Yk6Z5K8vLDH255w1eVVU8K9qImjaH0wgoFa9htg/Ud8zj
 O1uxnCVoTvOu6jh6b4H0zduobOHabz3eSuKflSGIHLzOBNhwWyfrw651N884W5E9s/SC
 Ucrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774352159; x=1774956959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5F4Tj4Whbu8nVgEJBtyQ5EINzLsvu1dVue6iQkG0YcE=;
 b=mCbDJn7258fiVzqbPFtljyvjRxCqSqdSqxvELMZcbuQ1rz6PKxdYFeDPUiezrf/CWj
 5Rbh8baUITzu6xi+QiccqKFg0CFpwlG9bDFpfyYRoXQUEESsxlYfFtq6/lODEKiOE7KG
 ZiIQum+AKYocDuUBUlGVD4YCmeYnJx/dIgcXUXGrD8T4WgK/mDIdcHC/sVK1nRVG1uFG
 BWd6jdmQgI3wjyCTisZrnAigGhAPaDymht+EBinImf3+sBFSGojcpxI/rcOchnCAT7xw
 xsHZbu1VaLzkrFjStnbeaFJ+5EhgOuCWbYbOYr6PkRLnYhOgu4UR/AFgsNXaZ+0e4Pad
 yWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774352159; x=1774956959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5F4Tj4Whbu8nVgEJBtyQ5EINzLsvu1dVue6iQkG0YcE=;
 b=SFU3p7rXvXliswYXG9qOLFr7JFATnZQh87idFgXN+idd9a7A6Dk5zv9nOqUrSOcvq6
 n4udh4eF/WW8q21b3fd2VlF0uxT6Xcmw083kuvmKbN9ps3lAr4FQ5AQelYnBlvvWWvQp
 yUGYsd0q3+XHSxAqqRowVA8YXLJiYqqOJJQ4Svk59QoFdtPwvPNOZGi/MLGrfQWmu5YM
 712EwAwAzEFTNnhCEjG2iW5L9IMwk25a6d1bOr8O6WhVwqGwA3wEqNvA9/AV1Z4X7VG9
 pCDJa61Jw2vqedpsjy7ITVOJ1Y//RhcLQqAj0g9myAyt3UP169U9OE4jSUH7h2wikf0W
 fKPA==
X-Gm-Message-State: AOJu0YzNS8uZhmjV35SIOAxFBgikv96L5qlZ/nm+LSFMEMMGgq0sK0Ti
 3zv2LAQMd3jbljXqfvGOBOYPIRkMU2QvOK0or9KSLaVEqvWjVvAeL2N7v/FshrZG+a2FyCLLzh3
 YYZdo2qcBOlJmqWT2A7K6GMhQTOQG2T0SAxT4N3FJS7RN8F2Ykodh1z3eECTNnIEl11iGHjf2ED
 rNBbUX2dOFYlr+CPlZNoMVZp00Cqqodx4=
X-Gm-Gg: ATEYQzwqe2V4DzLFHeNvJy7P3emTQyAcE4Q+vzci+reuZnup/QH2a5UQujlJNz2I/8H
 0G5FdKSKdG+xx3n0Yo5XUKtpE+odjilvtorYVbPIIqfurC3kQAKT3BiyD1SOP8djGTiXUprtY0P
 RFdNIDtY4BGJ5tyJDqtsOq0RYyzcPo5p4e4KmqWQ52PKd3egs4FUK30iy/oiw58JhVNQcbNZfzr
 EFU6A==
X-Received: by 2002:a05:690c:9204:b0:79a:52d8:fe5a with SMTP id
 00721157ae682-79a90beff50mr134194567b3.42.1774352159229; 
 Tue, 24 Mar 2026 04:35:59 -0700 (PDT)
X-Received: by 2002:a05:690c:9204:b0:79a:52d8:fe5a with SMTP id
 00721157ae682-79a90beff50mr134194297b3.42.1774352158853; Tue, 24 Mar 2026
 04:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-14-jonah.palmer@oracle.com>
In-Reply-To: <20260320142015.3856652-14-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 24 Mar 2026 12:35:21 +0100
X-Gm-Features: AaiRm51L_bSZTjKxlit4Ei7DqKr_jbCvENLZh9Y5aRhnO13_2MT43BywSJHIjcs
Message-ID: <CAJaqyWeSr42GwqG82hWcj5Etpde0Kz8no1TMwFbVeuCazQghJA@mail.gmail.com>
Subject: Re: [RFC v2 13/14] virtio-net: detect pending Tx work for VQs
 mid-migration changes
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Mar 20, 2026 at 3:21=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Track per-queue pending Tx work state during early migration time.
>
> This includes a snapshot of pending Tx state for active queue pairs,
> checking for deltas at the end of migration, and freeing the snapshot
> buffer during device unrealize.
>
> With this final delta signal in place, drop the temporary always-true
> fallback in virtio_net_has_delta and return false when no deltas are
> found.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/net/virtio-net.c            | 26 +++++++++++++++++++++-----
>  include/hw/virtio/virtio-net.h |  2 ++
>  2 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 3ee49a043a..483a43be4f 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3943,6 +3943,14 @@ static int virtio_net_early_pre_save(void *opaque)
>      vnet_mig->mq_early =3D n->multiqueue;
>      vnet_mig->queue_pairs_early =3D n->curr_queue_pairs;
>
> +    /* Tx waiting snapshot for active queue pairs */
> +    if (!vnet_mig->tx_waiting_early) {
> +        vnet_mig->tx_waiting_early =3D g_new0(uint32_t, n->max_queue_pai=
rs);
> +    }
> +    for (int i =3D 0; i < n->curr_queue_pairs; i++) {
> +        vnet_mig->tx_waiting_early[i] =3D n->vqs[i].tx_waiting;
> +    }
> +
>      /* RSS state snapshot */
>      vnet_mig->rss_enabled_early =3D n->rss_data.enabled;
>      vnet_mig->rss_redirect_early =3D n->rss_data.redirect;
> @@ -4254,6 +4262,8 @@ static void virtio_net_device_unrealize(DeviceState=
 *dev)
>          n->migration->mtable_macs_early =3D NULL;
>          g_free(n->migration->vlans_early);
>          n->migration->vlans_early =3D NULL;
> +        g_free(n->migration->tx_waiting_early);
> +        n->migration->tx_waiting_early =3D NULL;
>          g_free(n->migration->rss_indirections_table_early);
>          n->migration->rss_indirections_table_early =3D NULL;
>          g_free(n->migration);
> @@ -4412,6 +4422,16 @@ static bool virtio_net_has_delta(VirtIONet *n, Vir=
tIODevice *vdev)
>          return true;
>      }
>
> +    /* Has any active queue's tx_waiting changed? */
> +    if (!vnet_mig->tx_waiting_early) {
> +        return true;
> +    }
> +    for (int i =3D 0; i < n->curr_queue_pairs; i++) {
> +        if (n->vqs[i].tx_waiting !=3D vnet_mig->tx_waiting_early[i]) {
> +            return true;
> +        }
> +    }
> +
>      /* Has the VirtIONet's RSS state changed? */
>      if (n->rss_data.enabled !=3D vnet_mig->rss_enabled_early ||
>          n->rss_data.redirect !=3D vnet_mig->rss_redirect_early ||
> @@ -4439,11 +4459,7 @@ static bool virtio_net_has_delta(VirtIONet *n, Vir=
tIODevice *vdev)
>          }
>      }
>
> -    /*
> -     * Always return true for now until we're able to detect all possibl=
e
> -     * changes to a VirtIONet device.
> -     */
> -    return true;
> +    return false;

I'm failing to see one thing: If we add a new feature that the guest
can change during migration and it's only added in the
VMStateDescription vmstate_virtio_net_device, will this "return false"
prevent the state from being resent in the stop-and-copy phase?

Mandating its addition here is ok somehow, but I'm not sure if I'm
missing something.

>  }
>
>  static bool virtio_net_needed(void *opaque)
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index 88074a0976..dbbacc83bb 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -180,6 +180,7 @@ typedef struct VirtIONetQueue {
>   * @guest_offloads_early: Guest offloads snapshot.
>   * @mq_early: Multiqueue state snapshot.
>   * @queue_pairs_early: Queue pairs snapshot.
> + * @tx_waiting_early: Per-queue pending-Tx snapshot.
>   * @rss_enabled_early: RSS enabled flag.
>   * @rss_redirect_early: RSS redirect flag.
>   * @rss_populate_hash_early: RSS populate hash flag.
> @@ -201,6 +202,7 @@ typedef struct VirtIONetMigration {
>      uint64_t guest_offloads_early;
>      int mq_early;
>      uint16_t queue_pairs_early;
> +    uint32_t *tx_waiting_early;
>      bool rss_enabled_early;
>      bool rss_redirect_early;
>      bool rss_populate_hash_early;
> --
> 2.51.0
>


