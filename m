Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E412CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 02:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ezi-0007yj-JP; Tue, 23 Sep 2025 22:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1v1Ezb-0007wF-Oz
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1v1EzY-00047t-R9
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758679939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5tG8+Q0mK8WFYaWUVvWh8FCZsaEy0/XeTMpTXVBOJaI=;
 b=LlAbj02nHWYdm2ZFqX0o1IEdy2YzAsyaIrrrEkGR4IBYA5AdCc6wHZ0iVCfN8MonBB9wVM
 44gH3NAsNLenM1S5+tlTmooD+DcRuMzQ/b1CRByuAikI2RkyYD6oKoA5UAI+6/cI0pUwuD
 UdwNYGFScajB9Pd7EbfXn0P7x/+I0ec=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-BXBAf9BJMsyoyaxDUh94EA-1; Tue, 23 Sep 2025 22:11:05 -0400
X-MC-Unique: BXBAf9BJMsyoyaxDUh94EA-1
X-Mimecast-MFC-AGG-ID: BXBAf9BJMsyoyaxDUh94EA_1758679864
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-50f8bf67fbbso3676816137.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 19:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758679864; x=1759284664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5tG8+Q0mK8WFYaWUVvWh8FCZsaEy0/XeTMpTXVBOJaI=;
 b=nUB8G9uaU/qqnCUpmgbTw+fZDbc+dwQJvgOkKWcCYg2GwCJhn40I3HxdmfodYeLm6v
 Zx+gWJOGWLoz2F6EFI0f2IonEVzV1iLgEWVknMvLG5Gh5EV1n3O0z8Bn2pjYi+CWcQaj
 J0gcFkmkzzNIyJqFyaR6RkTtD84zuYyPPOxxNj6WQHv6ZMtWhqsXRWQGTufDAPvkXiEr
 yl/oR7lOU7cqxLvJK5s5GtzqHi7d0yJ/MA5refEis054MGuxjL0QPpDHNz2Pn9IXT3YN
 fb7eDnG6f4GhAaFstgSeuIvzgKSqz6/GwxpbouCjSdEK7unuSOUoY92i1/nZldEVYItR
 WX1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTrZ9QCxKCf1N4MlE4tEOfUDhlao1Ng+tCmKqzOM4VMERUt88at1M8W9V/eSru1YJyH/oNl61YLO4z@nongnu.org
X-Gm-Message-State: AOJu0YwCpdvfQzh/ijDsoD59vULIvt+LLJGS7G3gLjIsJY9b7UycO6PV
 9R4yCDNJAzHpPwNojLyojbyGqZ0DltyjYZppVer+UnRAnBKkuVrdAclM8WThUOx2QWNDW8RUzpZ
 bu1bHFpqZVzVGVWVJJMyu7W0oVdo17WitGzxOt788FM1xl/Zn/RmLbldVt5xIK9XWzJQQvidQnW
 51ixHg0VQ5aEliFgIrfRe1iuPnjJtvdPA=
X-Gm-Gg: ASbGncveUOEJw9u3rDZS+xznEFNiZINrdAZpMUevfHwmaH0a1XEzNqioIsivoecAyNA
 d4o+BbPCjJjOjZ8sqjPfWp81c/sgS+3m1xxZNqDqF1YA6w+VRPMVJOBSfjOU6f6SHoZYU52avah
 nHB1g+3YzfgNR2cmcTjE2Gsw==
X-Received: by 2002:a05:6102:2c0c:b0:59c:6e9d:23bb with SMTP id
 ada2fe7eead31-5a58118f848mr2215622137.17.1758679864379; 
 Tue, 23 Sep 2025 19:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz1FjLH9iWswqxUT3gpWdxWDMCjcUxZDY8VWCeOLjddCDHAHdQsVfqTRlH3z6P040em/r6ZUvr/cRC/GR64ZE=
X-Received: by 2002:a05:6102:2c0c:b0:59c:6e9d:23bb with SMTP id
 ada2fe7eead31-5a58118f848mr2215615137.17.1758679864098; Tue, 23 Sep 2025
 19:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <B01AB465-37DF-468F-9B76-2FC3D59E4749@baidu.com>
In-Reply-To: <B01AB465-37DF-468F-9B76-2FC3D59E4749@baidu.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Sep 2025 10:10:25 +0800
X-Gm-Features: AS18NWDlEo-ApBwRGVLDnPNQeNlP_w4a1TP_oivRx0GBU9y6elv6dgGjI6sdpKw
Message-ID: <CACLfguXqsjbHaP=OZ+zJDPFdvdr+7ac3bok=qgh5M9m2h9L4hg@mail.gmail.com>
Subject: Re: [PATCH] vhost: Do not actively send a config interrupt
To: "Li,Zhaoxin(ACG CCN)" <lizhaoxin04@baidu.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 23, 2025 at 7:48=E2=80=AFPM Li,Zhaoxin(ACG CCN)
<lizhaoxin04@baidu.com> wrote:
>
> On 2025/9/23 17:06=EF=BC=8C=E2=80=9CStefano Garzarella=E2=80=9D<sgarzare@=
redhat.com <mailto:sgarzare@redhat.com>> wrote:
>
> >CCing Cindy since she introduced this code with commit
> >f9a09ca3ea ("vhost: add support for configure interrupt"), so she can
> >help to review this, since I don't really get this change.
>
> >On Mon, Sep 22, 2025 at 11:19:32PM +0800, Li Zhaoxin wrote:
> >>From: lizhaoxin <lizhaoxin04@baidu.com <mailto:lizhaoxin04@baidu.com>>
> >>
> >>After the VM is suspended/resumed or live-migrated,
> >>we do not want the guest to output information such as
> >>the capacity of the block device, as this is noticeable to the tenant.
> >>Also, there is no need to immediately send a config notifier
> >>for the virtio device after vhost_dev_start.
>
> >Can you explain more clearly what your problem is and why this patch
> >solves it?
>
> >Thanks,
> >Stefano
>
> Hi Stefano and Cindy,
>
> In the vhost-vdpa scenario, after executing virsh suspend vm followed by =
virsh resume vm, or when live migrating the VM to the destination host, the=
 guest kernel will output the following additional logs:
>
> [Tue Sep 23 19:07:04 2025] virtio_blk virtio1: [vda] new size: 20971520 5=
12-byte logical blocks (10.7 GB/10.0 GiB)
> [Tue Sep 23 19:07:04 2025] virtio_blk virtio3: [vdb] new size: 20971520 5=
12-byte logical blocks (10.7 GB/10.0 GiB)
>
> This occurs because when the vhost device is started, the sequence vhost_=
dev_start -> vhost_start_config_intr -> event_notifier_set(&dev->vdev->conf=
ig_notifier) is triggered, which sends a configuration change notification =
(config notification) to the guest. However, it appears that actively sendi=
ng this notification is currently unnecessary, and no additional processing=
 is performed in the event of a sending failure. So, we removed the call to=
 event_notifier_set(&dev->vdev->config_notifier).
>
> Thanks,
> Li Zhaoxin
>
Hi Zhaoxin

this function tests and prevents event loss, I  think maybe we should
not remove it simply
maybe you can do something while it print the log?
Thanks
cindy

> >>
> >>Co-developed-by: Gao Shiyuan <gaoshiyuan@baidu.com <mailto:gaoshiyuan@b=
aidu.com>>
> >>Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com <mailto:gaoshiyuan@bai=
du.com>>
> >>Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com <mailto:lizhaoxin04@ba=
idu.com>>
> >>---
> >> hw/virtio/vhost.c | 7 +------
> >> 1 file changed, 1 insertion(+), 6 deletions(-)
> >>
> >>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>index 6557c58d12..1f8a495ef8 100644
> >>--- a/hw/virtio/vhost.c
> >>+++ b/hw/virtio/vhost.c
> >>@@ -1847,15 +1847,10 @@ static void vhost_stop_config_intr(struct vhost=
_dev *dev)
> >>
> >> static void vhost_start_config_intr(struct vhost_dev *dev)
> >> {
> >>- int r;
> >>-
> >> assert(dev->vhost_ops);
> >> int fd =3D event_notifier_get_fd(&dev->vdev->config_notifier);
> >> if (dev->vhost_ops->vhost_set_config_call) {
> >>- r =3D dev->vhost_ops->vhost_set_config_call(dev, fd);
> >>- if (!r) {
> >>- event_notifier_set(&dev->vdev->config_notifier);
> >>- }
> >>+ dev->vhost_ops->vhost_set_config_call(dev, fd);
> >> }
> >> }
> >>
> >>--
> >>2.34.1
> >>
>
>
>
>
>


