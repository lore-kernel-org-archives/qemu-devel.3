Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A54EE9A772
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 11:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4zud-0006eD-5Z; Tue, 24 Mar 2026 07:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4zuY-0006dg-BU
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 07:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4zuW-0006nX-S1
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 07:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774351619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4AjwnOyMWWuUV5ugFYxT6TM0E8wsDyNdVNWc9prLHjo=;
 b=JMRftwMB/XOzXTtfnfOASA7ORZNxwfBgZGJpB/1jDyH6S0N0qijTYYreIDYKpd4oa/0F5C
 uCatzF8jZsuxcEZ8EFdwseJyjQf4HAXiFrgTUJMpa/ZF4ioUNI2X0shbTBCYVzxGkxN31K
 9wftvdGjF5e94ImbZ7nRuRkSboP0/xU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-Li0JYf_GOVub-NrbK-mzMQ-1; Tue, 24 Mar 2026 07:26:58 -0400
X-MC-Unique: Li0JYf_GOVub-NrbK-mzMQ-1
X-Mimecast-MFC-AGG-ID: Li0JYf_GOVub-NrbK-mzMQ_1774351618
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-79832285fa1so28363327b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 04:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774351617; cv=none;
 d=google.com; s=arc-20240605;
 b=dfj8N5ol+Gnh+ftr72mMG0OsASq48/Td0NgtJXOPvtdRDyDJ7uaqPG0rFLkR/DD1+B
 a+w3YdfEOeqoGtZyI3KsBT5isHc+Yva0Zof1Ugcr62j4q5RMl7+OFcAfR3Zy5Ct+AO5M
 Mxn5rEleo43Sqjm+aVd/CiWaj/uLLncf/o/lCJtpeCEAxoFAklVBfWQDJddjlEeXRzvX
 ITFLqKgdXzoHWeMsLPsuKZIAQNn8j4nOFS7eOg4zeHt5/KmgVxbh3KEW/oQoMH4U4y/9
 KJTflyuXcpUdy2FEaGKTob0PrbApMJGZe7EQiufj8j92UZuj412Dtb4dQJ4JDJN65U3O
 CUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4AjwnOyMWWuUV5ugFYxT6TM0E8wsDyNdVNWc9prLHjo=;
 fh=/Q1walrJ1rQppfQIaR5kN+L7c1qEv+piY1FwYfW9K3g=;
 b=VMwihAkS05ISVZGntAXd+T8ZRZDyjBnz00TJ97C7r71PM/Tgcoj1fdm5phX1ic+b/9
 XN1NBn6dtQ0ZQTTATo5CkV0GWpbBnsCH4t5pKA1JxiG1WNpnJ9Cn4KfOKW96FG/h1/3J
 ++X45P3BtCS0W1VDjhlVE44MoeeJJbvklmjGgjlxfIDLScmpddekyhId7iM7bgqGo5m4
 pew6m9P1vQ8J1Amggjk8uVM8l+vJSQ+pWQgSEQlo14S15QH3yZeLRezKFlRjCp56fYFV
 MmA/36mCclLhsSUcOUFYKnmoYtQ8BPeCDT3ky6vzFNMZHtZZ4XXSBmNj89nEoRMe3P/W
 sEeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774351617; x=1774956417; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AjwnOyMWWuUV5ugFYxT6TM0E8wsDyNdVNWc9prLHjo=;
 b=i1WiPfjGvYjSQZuRh5F3PC7h/S7yXe4MeA39+t3N0x3vy0QDdxj4V/mbzfCaptsIwL
 mhthY85Hbb3Sp646Nql/dIMqd1fCV6t2bFEmJ20mGn8v1vNNQysPa8mQj9PgiZqI/HZc
 ZLeDIutHhmE6gyP0zgS/PIVVKfecRWNbrb0RY0n1940Kk17EKMX437xjgy/3Y/BbdEHu
 a7FW+jFifV7NV97TSPeEty92xHPNdmIO0II0pM2pW7uu5n/ynJoE7ysruiywo04C0hZy
 j8GoUjh8rUkyxAtqYeFNg6BMaDMzvxOt+OXVSj4fmfwzy33OKUyTZMdy9u0r8AZqbmVh
 adxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774351617; x=1774956417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4AjwnOyMWWuUV5ugFYxT6TM0E8wsDyNdVNWc9prLHjo=;
 b=X0ctfQu6KEWQNnfaTlC8y9G4Ko/q2LkJ4t0MsOdCbVp3NnKEuk+kr9arCYUe4kn4Qu
 hpxHDRmgCixY1vPVVjVc4cW85Ux4KATBuJZxWQ+MJRVT8Qaclv9BqnaeleRN8Iu3UtCp
 wCHa5bvg5/gMuMiG5mRzjuAJ8FAtPXCD381suEJSDQGmpN33k0Vr6Kgc81G0Bd7RskWg
 iyTRUgKSM9gUVOA6PCd6YN3U/ATJbWeOabC2zaLgJl/KbinxPLXrhyXrHgZbCWqJFcRH
 Up6cr/6JgoTI3pY0Wrrcdw5iYbuT6znWKnOqMMJDeqWeE1OPZarb3BYxVYhh6bFOKpRg
 WuNg==
X-Gm-Message-State: AOJu0Yzf7vtfHresY97SGiDHuBHFKmRkpkolod2pwaAm8kTYPHk96As6
 D3eGBLAU0ZRHlwrSnWuboaj+Yq04B1SGmBv3tpPVBfuTI0KNTAOTrAnTOkV5eY/vt7b43QFPcZV
 beU9XpKavEV+ef7k1zD95EztqDVEarfr9cFeB1BdxRAGmHXci8/t6eDtRbi+awilt9IObM1jMQw
 l3bu5tRNbtkHaLXp0qmGuKxmbPL3vEQF8=
X-Gm-Gg: ATEYQzw0BMf/XiQ+t7M8vYs6byzbibMXIRGvAJsFDbwaUUbIsGXicr+0Op6RyhfJDOm
 tfDcSbM9T+13dcu/lY5buT/TrmgnDCmK3fG8Qi9LKQDCCp/R5j9NOshTiB+3o96jPZzeXhuenWX
 /R2FuYC0UuSJWLVNeNfabEkzTAbMQ15IBJP4M7iZ/DMD2ik7N6kN+efqli/9jV6nBdSy4EBT5a8
 mKBOA==
X-Received: by 2002:a05:690c:e3c2:b0:798:1636:c330 with SMTP id
 00721157ae682-79a90bd06ffmr170287167b3.34.1774351617653; 
 Tue, 24 Mar 2026 04:26:57 -0700 (PDT)
X-Received: by 2002:a05:690c:e3c2:b0:798:1636:c330 with SMTP id
 00721157ae682-79a90bd06ffmr170286897b3.34.1774351617276; Tue, 24 Mar 2026
 04:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-9-jonah.palmer@oracle.com>
In-Reply-To: <20260320142015.3856652-9-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 24 Mar 2026 12:26:19 +0100
X-Gm-Features: AaiRm51MjDIAdt2n3DUZl7TjiJnY6x0PnkPeD-VccGPO_4OPvJlvlJZOZOHIN-g
Message-ID: <CAJaqyWebEJN0GL=5yotWcF=48FW6r2yO+q21ZZ-7DeawbTNocQ@mail.gmail.com>
Subject: Re: [RFC v2 08/14] virtio-net: detect VirtIONet status mid-migration
 change
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
> Save VirtIONet's status field during early migration and compare it
> again during stop-and-copy.
>
> VirtIONet keeps its own status bits here, including VIRTIO_NET_S_LINK_UP
> and VIRTIO_NET_S_ANNOUNCE.
>

These are particular to the device, so we don't need to migrate them.
If any, we should check if the destination device changed the link
state so we can update the guest, but we don't do that as far as I
know.

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/net/virtio-net.c            | 6 ++++++
>  include/hw/virtio/virtio-net.h | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2dd130777e..88ce33b1d2 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3872,6 +3872,7 @@ static int virtio_net_early_pre_save(void *opaque)
>      VirtIONetMigration *vnet_mig =3D n->migration;
>
>      vdev_mig->status_early =3D vdev->status;
> +    vnet_mig->status_early =3D n->status;
>
>      /* VirtIODevice config buffer snapshot */
>      g_free(vdev_mig->config_early);
> @@ -4304,6 +4305,11 @@ static bool virtio_net_has_delta(VirtIONet *n, Vir=
tIODevice *vdev)
>          return true;
>      }
>
> +    /* Has the VirtIONet's status changed? */
> +    if (n->status !=3D vnet_mig->status_early) {
> +        return true;
> +    }
> +
>      /* Has the VirtIONet's MAC info changed? */
>      if (memcmp(n->mac, vnet_mig->mac_early, ETH_ALEN) !=3D 0) {
>          return true;
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index 1e1f1a3995..59345f1811 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -169,6 +169,7 @@ typedef struct VirtIONetQueue {
>
>  /**
>   * struct VirtIONetMigration - VirtIONet migration structure
> + * @status_early: VirtIONet status snapshot.
>   * @mac_early: MAC address early migration snapshot.
>   * @mtable_in_use_early: In-use MAC table entries.
>   * @mtable_uni_overflow_early: Unicast overflow MAC table entries.
> @@ -176,6 +177,7 @@ typedef struct VirtIONetQueue {
>   * @mtable_macs_early: MAC table entries.
>   */
>  typedef struct VirtIONetMigration {
> +    uint16_t status_early;
>      uint8_t mac_early[ETH_ALEN];
>      uint32_t mtable_in_use_early;
>      uint8_t mtable_uni_overflow_early;
> --
> 2.51.0
>


