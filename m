Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D19CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 09:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGZN0-00041D-Nq; Wed, 05 Nov 2025 03:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vGZMz-00040M-8L
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 03:59:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vGZMw-0006XL-GA
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 03:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762333193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7J9+FJGUzDuoRCqJt5OmLLNzFub+q8zB++TMx5ZiWAY=;
 b=aLBbzJpvtEhqtMpcxCzEqcyoeTFSDC9F/P0SqYSrHSBk5Yzn84B9zcQunMc9NEP/6la7le
 z6/6xAYqfvX8bn/ph0Hkd9rynGgjGMvOE+DBfu7lhgExIAKDRtDVowNlwN0H129jbMrOyP
 4qaEam55BTL3DpmO5MlhEq9m5CkvgFY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-WJQfyalON7ywolFIg3lVPQ-1; Wed, 05 Nov 2025 03:59:50 -0500
X-MC-Unique: WJQfyalON7ywolFIg3lVPQ-1
X-Mimecast-MFC-AGG-ID: WJQfyalON7ywolFIg3lVPQ_1762333189
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3405c46a22eso7063521a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 00:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762333189; x=1762937989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7J9+FJGUzDuoRCqJt5OmLLNzFub+q8zB++TMx5ZiWAY=;
 b=X137kf9lIKWt8XeHhEIw8rM2yzcDm9gx6QiE1PHJcNYmw1m9UvBQ3rU3c0pNVUiteK
 4d1uTtH+k9Nlmyfhhr2fQMaohQAlY+mr10cr3QK8uJAfwuCKuGey/pF8f17QUAxwKv7v
 PNA4iD7m4wBU48zXoD7Z8IyAEd/FJWTDyRkPxXxAVj30uMHl0ZGM2fDi3Rm7bhYJnICC
 gN9bk9sEzpMMY1pJvjf3htoXhSJTcu40LcZoHKDeH5wtVQ/gqt6V65b+/nKJLBrzvZzc
 guHC0Ecj2bzfVZMaELbECvz6ON8cF3dBZr7kGLatXzYi1ZEzNBPRJJhz9T64VZ3iXqQf
 yT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762333189; x=1762937989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7J9+FJGUzDuoRCqJt5OmLLNzFub+q8zB++TMx5ZiWAY=;
 b=jyr4h4m3lMnRSu7cgF6DIBOPVUGVl7kRM/n0I6m6buD0IV5wW42D0WtyFGDChyDI8t
 5CJkGlU1FAgfJkEoy8XkGpaS6iPrXDGkm4LdZTwDug1MIVpCeLU9Wc31TRZGuEVe6gmv
 dVd2joRveFOKRbQAAmJUkXUvys7hRqivDxyqjxZRYQXTZ6GYO+oIGR21coBlTN/2PgvM
 2J4lMhwNQK/ClWF+PMilYKV7gEcLUJknQGWxzBGAg7xLlVPzLGOIYTzv69ihkAre03he
 zHPWk5ZVGgI0DZxgyb9oHh7fi6OMpTGexfrpYclxBGANLhv5aTXJUdrsTGu7pR0glHtF
 pm8w==
X-Gm-Message-State: AOJu0Yy7q66y1N3wEuJVp6dr15hzIpVCV247JOyImoLIwLB4Nfw6hxCl
 iCvxhv3N4XmZ8MCQIQwgRKbIIEhVh3gTjt7xPvLfY05QR87b41yd7j+Rj7BHV+SIFZMN+ZqwODL
 ZrUyytPYHPKxiBrywNsC1woh0Ihph+DBT6wqj/MQcXA77cs7OzSGKlLqw/ff6HlBwYRxuV5lcW+
 0eXiAkVzI2XEUfDEDfb0UiPzY6SvDTZJs=
X-Gm-Gg: ASbGncvTSJ5jWCWNiXhInYbe5umldoaUfQYtlGPpH0+X+pQqJiUYaeObbnGlGijO3IE
 EKf9pJtUJGiTee4l0oTzqK0z8Unbqe4Y1xUzKUucCgL1ZYjwkJHams9VvSzT5+d5smsSUsv60mc
 6qXYdKzNqIIMal5SAWoctTZhp2eabq1C4b3pE+X858cHs9fiTP3QFDCq38
X-Received: by 2002:a17:90b:2d92:b0:32e:e18a:3691 with SMTP id
 98e67ed59e1d1-341a700d610mr3006017a91.35.1762333189209; 
 Wed, 05 Nov 2025 00:59:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFovKJPabs6rB7CVPU9wBWmcNSGRkzCVeGWuUd0HCQhJ0lyd4iFIeLYwotQq4f4G8O46hiSF1TP86IKcnIjn0c=
X-Received: by 2002:a17:90b:2d92:b0:32e:e18a:3691 with SMTP id
 98e67ed59e1d1-341a700d610mr3006000a91.35.1762333188770; Wed, 05 Nov 2025
 00:59:48 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
In-Reply-To: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Nov 2025 16:59:36 +0800
X-Gm-Features: AWmQ_bmdE8oFktdARDAYn3jKEJf21_cOs6qtGIUtpR1uvI7EtwW_YoIaPjlN8xM
Message-ID: <CACGkMEtUx0PigJrJSWY8n2N7+znc02aqotNq+Y5w3aOMOvUvjQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_Migration_failure_between_QEMU_9=2E2=2E4_=E2=86=92_8?=
 =?UTF-8?Q?=2E2=2E10_due_to_virtio=2Dnet_feature_mismatch_=28VIRTIO=5FF=5FRING=5FRESE?=
 =?UTF-8?Q?T_=2F_USO_features=29?=
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 qemu-stable@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 5, 2025 at 4:49=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com> wr=
ote:
>
> Hello QEMU developers,
>
> I=E2=80=99m encountering a migration failure when trying to live-migrate =
a VM
> from a newer host (kernel 6.12 + QEMU 9.2.4) to an older one (kernel
> 6.1 + QEMU 8.2.10).
> Migration in the forward direction (old =E2=86=92 new) works fine, but af=
ter
> rebooting the guest on the new host, migration back to the old host
> fails.
>
> ________________________________
>
> Issue summary
>
> Source host: kernel 6.12, QEMU 9.2.4
>
> Destination host: kernel 6.1, QEMU 8.2.10
>
> VM type: pc-q35-8.2, using virtio-net-pci with vhost backend
>
> Symptom: Migration from 9.2.4 =E2=86=92 8.2.10 fails with virtio-net load=
 error.
>
> Error log (destination):
>
> 2025-09-23T07:06:14.915708Z qemu-8.2: Features 0x1c0010130afffa7
> unsupported. Allowed features: 0x179bfffe7
> 2025-09-23T07:06:14.915843Z qemu-8.2: Failed to load virtio-net:virtio
> 2025-09-23T07:06:14.915851Z qemu-8.2: error while loading state for
> instance 0x0 of device '0000:00:02.0:06.0/virtio-net'
> 2025-09-23T07:06:14.917894Z qemu-8.2: load of migration failed:
> Operation not permitted
>
> ________________________________
>
> Analysis
>
> It appears that virtio-net feature bits differ between the two versions.
> On QEMU 9.2.4, virtio-net reports additional features:
>
> VIRTIO_F_RING_RESET
>
> VIRTIO_NET_F_HOST_USO
>
> VIRTIO_NET_F_GUEST_USO4
>
> VIRTIO_NET_F_GUEST_USO6
>
> These are not present (or not supported) on QEMU 8.2.10, which causes
> the migration state load to fail.

Interesting, we've already done the compat work:

GlobalProperty hw_compat_8_1[] =3D {
    { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
    { "ramfb", "x-migrate", "off" },
    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
    { "igb", "x-pcie-flr-init", "off" },
    { TYPE_VIRTIO_NET, "host_uso", "off"},
    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
};
const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);

>
> The issue seems related to the introduction of these features and how
> they are handled during incoming migration when the target QEMU does
> not recognize them.
>
> ________________________________
>
> Reproduction steps
>
> Start VM on host with QEMU 8.2.10 (kernel 6.1).
>
> Migrate to host with QEMU 9.2.4 (kernel 6.12).
> =E2=86=92 Migration succeeds.
>
> Reboot the guest on the 9.2.4 host.
>
> Attempt to migrate back to QEMU 8.2.10 host.
> =E2=86=92 Migration fails with virtio-net load error (see log above).
>
> ________________________________
>
> Expected behavior
>
> Migration from newer QEMU to older version should either:
>
> gracefully ignore unsupported virtio-net features, or
>
> fail with a clear compatibility message before starting migration.
>
> Currently, migration starts and fails during device state load.
>
> ________________________________
>
> Related patch
>
> I found this commit that looks relevant but is already included in
> both 8.2.10 and 9.2.4:
>
> https://lore.kernel.org/qemu-devel/20240527072435.52812-15-mjt@tls.msk.ru=
/
>
> ________________________________
>
> VM configuration
>
> -uuid dbaf0b1f-4dc5-4462-86b1-d82107b58599
> -name Serverwittchendbaf0b1f-4dc5-4462-86b1-d82107b58599
> -M pc-q35-8.2

Could you double check if this is used in both source and destination?

> -accel kvm,kernel-irqchip=3Dsplit
> -cpu SierraForest-v2
> -smp 7,sockets=3D128,cores=3D1,maxcpus=3D128,threads=3D1
> -m 4096,slots=3D252,maxmem=3D256G
> -bios /usr/share/ovmf/OVMF.fd
> -device virtio-net-pci,netdev=3Dhostnet6,id=3Dnet6,mac=3D02:01:17:9b:9a:3=
5,bus=3Dpci.0,addr=3D0x6
> -netdev tap,ifname=3Dn0201179b9a35,id=3Dhostnet6,script=3Dno,downscript=
=3Dno
>
> ________________________________
>
> Question
>
> Is this expected behavior (i.e. migration incompatibility due to newer
> virtio-net feature bits)?

No.

Could you check if

1) those features were enabled or not via "info qtree" when using pc-q35-8.=
2.
2) whether the migration with if you disabled those features explicitly in =
9.2.4

> Or should QEMU handle such feature mismatches more gracefully (e.g.,
> automatically disable unsupported virtio features during migration)?

This would break guests as it could be noticed by guests.

>
> Any guidance on how to make migration between these versions work
> would be appreciated.
>
> ________________________________
>
> Thanks,
> Jinpu Wang @ IONOS Cloud
>

Thanks


