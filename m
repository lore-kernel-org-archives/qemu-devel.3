Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16B6C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgmj-00045p-E0; Fri, 18 Jul 2025 04:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ucgmM-00040s-IG
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ucgmK-0006CB-Gc
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752828554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cvVw+85pNKxFqV+0OY3kncHAyjo1jX8gmQq9i/RVdY=;
 b=U6fedSiYXme1wTplTA9WwBj83mh7xPFZw5grhH1xtcL5z5ENsRII8Vu+5uIaomoWb+3SN6
 jThq67PuQG6SRnAbnaA/SK/hqO/vUDcOpjmKWOHnvyRqvyrwRql+Dd8KZvm10WROThT9Or
 eZve+VrJyTtzRf/Nz9cZQ2Ic4GyFr54=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-j8xwtbTVOXuKkCxcqKmsFQ-1; Fri, 18 Jul 2025 04:49:11 -0400
X-MC-Unique: j8xwtbTVOXuKkCxcqKmsFQ-1
X-Mimecast-MFC-AGG-ID: j8xwtbTVOXuKkCxcqKmsFQ_1752828549
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-60c9a1db851so1618582a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 01:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752828549; x=1753433349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cvVw+85pNKxFqV+0OY3kncHAyjo1jX8gmQq9i/RVdY=;
 b=I6ezvuqene8erNcAMkhxu+PWKvooXqLd9TdyGL7OGYmTUrPN85imsJnX1C/pvrqRkE
 u7julzTf+UHzFxaGO7WkCTX7Pt8DVzS5v7ZXdq7oGW6ENLbU7gp2AgRrb5mccZDhbP31
 1A+36ecmDqoFT+88IzTwM/H18BT5CORsrwdyufN/QnzBlvX+pV1/W07pjbeYcxR2YRf3
 DY4YYkPPL04Y8WnboHbt2MQiehki+zrbyEwsjf/imBQdN+GVa/Ck9z8pKVMw/vKs3wYP
 iatXwxtN2DEvV5BOotH2sPvNZRjyoEM6a4r1/eBHzznNsCFDRYpq7dTdQP4Cl2jQGl0T
 Sugw==
X-Gm-Message-State: AOJu0YxqxsyiHVzsLnHGCed7I+p2tsZepNyEYvfW89hSzX5PL+rH/JTY
 9ZXXPhLH00D3ebfdbK4ry1XA1p6zyxDypFAOVfxgKHEnYoouxQpYCLWzhA1iPiIZF3cxNU3hrhp
 un1h4t5KEBJEAu+9P7vvGeeFqaFr0pnDQKBLw7G7AOW8hugyJ2gztlcsKiLxsG9WhYv4fwLjqzA
 k3vhGcJ7B/To2MKx3NiPxdME1RKeiAZo8=
X-Gm-Gg: ASbGnct9N7y9/1v0/zbMgGzcVmkaNRtYu7bWn3ovW0H/r8q7g+vnzsP2kIlB8rn12FS
 mHcuQdEH4Sq5pFUfgNciMHWg1cpcvwsl7MVl75/EQGxAxjJtyCEi19wQQMHSs0OHdbCuUhTtAiE
 J5CynzOu23i7Z9qj2KOrBs
X-Received: by 2002:a17:907:da4:b0:aec:5a33:1573 with SMTP id
 a640c23a62f3a-aec5a3354femr467396366b.41.1752828549371; 
 Fri, 18 Jul 2025 01:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF20TY5u8J2rQOZX1pga0UUD3urvA9h5LuyEt2ZYjRmNljVCdQuyDQGE/Pd5blIffuEElOB49NgB31knQwLB8=
X-Received: by 2002:a17:907:da4:b0:aec:5a33:1573 with SMTP id
 a640c23a62f3a-aec5a3354femr467393166b.41.1752828548957; Fri, 18 Jul 2025
 01:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 18 Jul 2025 16:48:31 +0800
X-Gm-Features: Ac12FXwRPXasSb4VA957KBQIAa0CjJZbtkJfboqM9JGWP2CoxqPOsA7YkNzTE3U
Message-ID: <CAPpAL=y=2os30kCA4_MCMT8OdE3PqGZdg7oBPeS8SKCN0heMrg@mail.gmail.com>
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Steve

I tested your patch which hit a problem under enable/disable nic mq
state(The full test scenario is live migration vm at local under
enable/disable vm nic mq state):
Run command: /qemu-img info /home/images/vm1.qcow2 --output=3Djson
Error info: qemu-img: Could not open '/home/images/vm1.qcow2': Failed
to get shared "write" lock

In the same environment if I remove the enable/disable nic mq steps,
it can work well.

Note: This issue has not been reproduced 100%, but in order to confirm
this is really a bug, I test the following:
1. Live migration vm at local under enable/disable nic mq state: 3/5
reproduce ratio
2. Only live migration 5 times are all passed.

Thanks
Lei

On Fri, Jul 18, 2025 at 4:48=E2=80=AFAM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Tap and vhost devices can be preserved during cpr-transfer using
> traditional live migration methods, wherein the management layer
> creates new interfaces for the target and fiddles with 'ip link'
> to deactivate the old interface and activate the new.
>
> However, CPR can simply send the file descriptors to new QEMU,
> with no special management actions required.  The user enables
> this behavior by specifing '-netdev tap,cpr=3Don'.  The default
> is cpr=3Doff.
>
> Steve Sistare (8):
>   migration: stop vm earlier for cpr
>   migration: cpr setup notifier
>   vhost: reset vhost devices for cpr
>   cpr: delete all fds
>   Revert "vhost-backend: remove vhost_kernel_reset_device()"
>   tap: common return label
>   tap: cpr support
>   tap: postload fix for cpr
>
>  qapi/net.json             |   5 +-
>  include/hw/virtio/vhost.h |   1 +
>  include/migration/cpr.h   |   3 +-
>  include/net/tap.h         |   1 +
>  hw/net/virtio-net.c       |  20 +++++++
>  hw/vfio/device.c          |   2 +-
>  hw/virtio/vhost-backend.c |   6 ++
>  hw/virtio/vhost.c         |  32 +++++++++++
>  migration/cpr.c           |  24 ++++++--
>  migration/migration.c     |  38 ++++++++-----
>  net/tap-win32.c           |   5 ++
>  net/tap.c                 | 141 +++++++++++++++++++++++++++++++++++-----=
------
>  12 files changed, 223 insertions(+), 55 deletions(-)
>
> --
> 1.8.3.1
>
>


