Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B1BC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 15:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wneOz-0007WN-Em; Sat, 25 Jul 2026 11:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wneOs-0007Sy-TR
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 11:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wneOr-0006vh-Dh
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 11:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784993692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=asT0gK91JRATsMfNodweY4ltm1KQ0e6elKZDXDfhUi8=;
 b=Q41XIMtILxwtb2UQbU3u65qBHiqnkHgthGvb8kXD9tgQtIFZGHMkUk6DspBt5W5PMQOvXf
 0vodInhs7XXFcNotkIJLbKObxDO/FR1tjZIZj+jAWNDxWL2yq6wA9kqgMejxWEYb7RdQvc
 IYwMOCvh7eYSz0tTJBlj/tNhNZPEnAA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-EQK8KdnPMCqCd7pjVsjdFA-1; Sat, 25 Jul 2026 11:34:50 -0400
X-MC-Unique: EQK8KdnPMCqCd7pjVsjdFA-1
X-Mimecast-MFC-AGG-ID: EQK8KdnPMCqCd7pjVsjdFA_1784993689
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4954b1c6310so13079565e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784993689; x=1785598489; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=asT0gK91JRATsMfNodweY4ltm1KQ0e6elKZDXDfhUi8=;
 b=CJcg4pxk4HtufusXargSxrXgh9Xct/8HuEhHViPeruhPvjFDsWg/6cF9PAL9Wp2uH3
 7fuz0gfreD5cg9t7lFozey98SbxvlfOp33SysVoGlIzevG+OwoXcEM+fGGKmWw1+sEcj
 ua0mswIKmLkUHdmvMF93iEhn59S+Piu5J4HDiL3hXbxz0vAKVdpVQVVfhC903dRr0YVj
 bUN1Nqb4+TNIOgGBWVyrI1iVsMBZLYlANSmzAVxrqUGqdj1/Hq3nUk2qh5KOTzJrCyvH
 DnKO9jgAPhfld2ajfoyme727IiSg0kAvRnonjjO710i1wtwfIUCFIAMSXq+Id/LeJllr
 5kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784993689; x=1785598489;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=asT0gK91JRATsMfNodweY4ltm1KQ0e6elKZDXDfhUi8=;
 b=GEWt4nWtX9Z/HjbVdVZd2JALPG0Ylk6DcQJD5dhV+Aeqmwt175/fynxDkr7vbEFRvE
 QwdnbBVyLxq6pkuQxoUkpN/AWe8tUrzCDSd07Posd2Hsv92Ou0+5kzhMFcTCW4yJfwq7
 WTAISqSg9D0qs/42sr2K3zSNMXm8KfVbNd64n+HDpNB9m+2C/Fb3z+lvXweJJF13RFgy
 f9OVDU2kh1dkPhhWy3I4yBT9jPckGJTO6CMnjIQ8LP+Jqb2us36uTTzR4usSy/+8kEao
 eyUyjF7Pp7yUrgh6O234mta+XBBDpj8xRLoI7Yw2/QgjgIAc2dmdArbU8JFwTV0jXDpl
 pCxQ==
X-Gm-Message-State: AOJu0YwdGKdh6sjrZVSqWC8Glq4EMo4kOrOAbXcjjnvFTXQpma/Q7/9d
 zKf6pWX80yHgbzHzoZrGpIIXc9XQWab5lZURwImEP/ImR0Lr3LyI5E6i7V57YAhXZRNGdSaBwlR
 CjZYGGkYH8skHnNea8UY41pRzyYWazlV3/k/HgpGrCOOkotYg1RkKjvP4
X-Gm-Gg: AR+sD13p+ZydDTQzxYOun0589cAkUqx/A9DQVs47JsOT2UW98Jb2vU8hn1NEtrQNa53
 TFYY0WISWA/GGQLCw/YmUANOwc4AuQKw3b/VPKKo00QmEAnj0akTkEYU1W0hZMRRnI5q5pqNQi9
 b5wTM9D9CSWNYJH1AtrI+v7dwYk73XjsPEDoho4lIcgTdNSdNn1xb0nIBgdOBisI3pxUIzSbj5E
 G+JAkm/y0LnrpNAoZVAcXXF8Q0OP2PLapRYzKTs/UdFZKhj9jnc/EwblYEjV43LCYkLoTYTtdzQ
 qMUjwZ+eAdD7j+TgINiYBtfJuHp7b7DS+ml6rco7oTP0gLJVQvManGj7Nx6s3QqwhcYqGiGEVBS
 liN00xnLv9gpEo/vfM13YER6lX+HkITw=
X-Received: by 2002:a05:600c:3b10:b0:495:3f26:97fb with SMTP id
 5b1f17b1804b1-496b56bbd08mr30782495e9.3.1784993688952; 
 Sat, 25 Jul 2026 08:34:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3b10:b0:495:3f26:97fb with SMTP id
 5b1f17b1804b1-496b56bbd08mr30782115e9.3.1784993688413; 
 Sat, 25 Jul 2026 08:34:48 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm18658217f8f.26.2026.07.25.08.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 08:34:47 -0700 (PDT)
Date: Sat, 25 Jul 2026 11:34:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>
Subject: Re: [PATCH 0/3] Harden virtio migration load paths against crafted
 streams
Message-ID: <20260725113324-mutt-send-email-mst@kernel.org>
References: <20260710102859.1967551-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710102859.1967551-1-lvivier@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 10, 2026 at 12:28:56PM +0200, Laurent Vivier wrote:
> A crafted migration stream can crash the destination QEMU process
> through unvalidated fields in the virtio device state: an unbounded
> allocation in virtio-serial, reachable assertions in the shared
> virtqueue element deserializer, and assert()/exit(1) calls in
> virtio-scsi request loading.
> 
> These are hardening fixes: the destination QEMU is in a paused
> pre-start state and the source VM is unaffected by a failed migration.
> 
> Patch 1 validates the virtio-serial nr_active_ports count against the
> configured maximum before allocating the post-load array.
> 
> Patch 2 replaces the assertions in qemu_get_virtqueue_element() with
> a bounds check returning NULL, and updates all callers (virtio-serial,
> virtio-blk, virtio-scsi, scsi-bus) to handle the failure gracefully.
> 
> Patch 3 replaces the remaining assert() and exit(1) calls in
> virtio_scsi_load_request() with proper error returns.
> 
> Tested with migration round-trips for virtio-serial (0 to 511 ports),
> virtio-blk (1-2 disks), and virtio-scsi (1-2 disks), plus the
> original PoC reproducers for issues #3801 and #3802.
> 
> Laurent Vivier (3):
>   hw/char/virtio-serial-bus: validate nr_active_ports from migration
>     stream
>   hw/virtio: return NULL from qemu_get_virtqueue_element() on invalid
>     state
>   hw/scsi/virtio-scsi: harden virtio_scsi_load_request() against invalid
>     stream

Kevin objected to my version of this, I guess same will apply?

>  hw/block/virtio-blk.c       |  4 ++++
>  hw/char/virtio-serial-bus.c |  7 +++++++
>  hw/scsi/scsi-bus.c          |  4 ++++
>  hw/scsi/virtio-scsi.c       | 20 ++++++++++++++++----
>  hw/virtio/virtio.c          | 11 ++++-------
>  5 files changed, 35 insertions(+), 11 deletions(-)


A similar exit in mptsas?

> -- 
> 2.54.0


