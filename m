Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C9CC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0Mj-0003pt-2e; Wed, 29 Jul 2026 05:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp0Mh-0003oo-8Q
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp0Mf-00056P-FK
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785316452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9YdTDuVo8niT4qO7Mio/qjBuUTTJsiTpbi84Q7pNsA=;
 b=aVrGEgMRfcuNq2O0qpO/OnfEm4oOcMcggV0x/cypT22ZcEddVPiulqWMSRhlQS3Os2nN+u
 6OhDtCvcXUV4qpXaH/s4+4hWeaGgaCuToh5/fWa4hOJtGAeVZRBM6Bekg36kOs2AFg/X5R
 DwlGoto5J1iwg43nCxOaLcJbHTTThT0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-wZWit4flMF-r2FJ3MumGBA-1; Wed, 29 Jul 2026 05:14:10 -0400
X-MC-Unique: wZWit4flMF-r2FJ3MumGBA-1
X-Mimecast-MFC-AGG-ID: wZWit4flMF-r2FJ3MumGBA_1785316450
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso6025885e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785316449; x=1785921249; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A9YdTDuVo8niT4qO7Mio/qjBuUTTJsiTpbi84Q7pNsA=;
 b=PotUXaoH1BN88Dib8Y90jeK5Tfaxwf3SqsXuRddyBjM6+Gp80U8h4cYS2OPpzqdr6c
 hufmPa5y9+8rNRKy8O/yX0g/NWYRGE65zvpk3P2NCjD05uQqXgse07wbg7ecjy1R+vg3
 QFPqp7MPnrbr7A46dKMwA1LnQr2ZSkAzYpfEVm5gcqtoIaVbzwL9uDR3Ulbie/4ag+ZT
 XiBTbKGZ2IZdw5Jyzg6RN2ZRoFGtfX/YkBI3EePIPqWY6Xt20Lv/m1AkplrjASzlG0JU
 wS2/oUmeuwP102NPzl1ennzht8JZw3Yr6TRVhC+aqRICS2j8H3bjE1UqvvKVqoJlti53
 HV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785316449; x=1785921249;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A9YdTDuVo8niT4qO7Mio/qjBuUTTJsiTpbi84Q7pNsA=;
 b=qoodVBCUjOfIEvixF6Ig8OYBSGua1LtQxjDSgTlxUTnj30qu4bQJym5rMP+JmAGp2N
 HzDMIqvUKINWkS8CCZiE/phUq3dH6Xr+dFzRBCBKTU8a1AebOWN6jhrLejLaPxorfMKe
 bZIF0cPImcAZmSZwRQ2L7qdmYuvtTPikJ+NB9FikoJDQszWX103eY3F2LkqPSfoxKlsQ
 SB0qKCT8UUadunyiWlRSDGyEhFzPMod+BTxh8h0DtUzsp1yTCxBfHlLEMiFkQnyGMosJ
 ZsXd3svVQnwkxUfvI5cVwOYuMBU/iOyUOehBl8W8ayFJm1hQDYb7kzSseWBlSyX0lteN
 +WSA==
X-Gm-Message-State: AOJu0Yy5q5ZqY//gDXOxbSRZ/qcFhrq+ZUCevZ/ESUs8p4ypM9Dh2I1D
 EKB/vEOugNbt5yCFbe/yXo79r/xdXASxG3/TlSrfxUIefm97GdIqqHcIVfcQ0bJ3fmioHkg6Jq2
 s3H/GcTWyquvCYCsRaj4HLdFGOhmaEQFoTqKul6UXf2/GGLjOimmRxTlW
X-Gm-Gg: AR+sD13d+x38jjgR0yX10FzN86wZo8Q+ddmNgtlkvEtietacZ3OahQd7BcvWmNtK0P5
 udbH+UGvSuI6aHAth7TEFV4r+77OWR7yx6rIoqBgwnbfNNH5o8Cc7+icROKQ4COd2ZjZ4INpQA0
 AK4LyGtQQfE+a1K04FGhd/wYBD6XNInzL1SYaw+qG14SysV9YhYCHVtRju2TrQOU9VHozTTuJgC
 CI0Y33lx0JctKWZWFjPXNt8RLF+TUIG6yr5EOut+rCLEAsGD8SnVPPTrehWbCudxMfIEX9LMVzU
 Bi4Q3Sg/52E5Pxk3jcZEcsCRDQhNj/ALrmL5HLeX9PvIhIZ79OxxDEW1Xj0kilnoGDCqyy+0jVd
 6WMNqpcKw4X0AFV6dzLNHYzs=
X-Received: by 2002:a05:600c:c162:b0:495:7285:a498 with SMTP id
 5b1f17b1804b1-496c656540fmr66209525e9.18.1785316449397; 
 Wed, 29 Jul 2026 02:14:09 -0700 (PDT)
X-Received: by 2002:a05:600c:c162:b0:495:7285:a498 with SMTP id
 5b1f17b1804b1-496c656540fmr66208855e9.18.1785316448846; 
 Wed, 29 Jul 2026 02:14:08 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d70042sm37506535e9.1.2026.07.29.02.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 02:14:08 -0700 (PDT)
Date: Wed, 29 Jul 2026 05:14:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 virtio-fs@lists.linux.dev, Kevin Wolf <kwolf@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>, Raphael Norwitz <rnorwitz@nvidia.com>
Subject: Re: [PATCH v5 0/6] vhost-user-blk: add compatibility with older qemu
 versions
Message-ID: <20260729050854-mutt-send-email-mst@kernel.org>
References: <20260728100841.3475774-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728100841.3475774-1-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Tue, Jul 28, 2026 at 03:08:35PM +0500, Alexandr Moshkov wrote:
> v4 -> v5:
> - introduce protocol feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN
>   to guard the new message, instead of reusing the existing
>   VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INLIFGHT. Update docs.
> - improved commit messages.
> 
> v3 -> v4:
> - add new protocol message GET_VRING_BASE_SKIP_DRAIN instead of parameter to GET_VRING_BASE message. This new message can be send instead of GET_VRING_BASE, allowing back-end to suspend inflight I/O immediately instead of waiting and completing them.
> - rebase to newer master
> 
> v2 -> v3:
> - fix complile problems
> - add assert check in do_vhost_virtio_stop
> - make inflight-migration property mutable
> 
> v1 -> v2:
> - reorganize commits: make refactor commits first, then core semantic change
> - add additional pre_save check for inflight migration possibility
> 
> ---
> 
> This is v5 of the series previously sent as
> "[PATCH v4 0/6] vhost-user-blk: fix inflight migration compatibility".
> 
> This series extends the vhost-user-blk inflight migration feature
> introduced in QEMU 11.0 to address a runtime compatibility problem.
> 
> Currently, the inflight migration behaviour in vhost-user-blk is
> controlled by VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT, which is
> negotiated once at connection time. Once the feature is negotiated, the
> back-end always uses suspend semantics on GET_VRING_BASE — there is no
> way for the front-end to request normal drain behaviour on a per-call
> basis without reconnecting. This makes it impossible to disable
> inflight-migration at runtime, which is needed when, for example,
> migrating a VM to an older QEMU version that does not support the
> feature.


This part, I do not understand.

What exactly does "migrating" mean here? Live migration?
An older QEMU will presumably either negotiate or fail to negotiate
the bit.


> To solve this, the series introduces a new protocol message
> VHOST_USER_GET_VRING_BASE_SKIP_DRAIN (id=45) guarded by a new protocol
> feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN. The message is
> semantically identical to GET_VRING_BASE but explicitly instructs the
> back-end to suspend in-flight I/O immediately rather than draining it.
> This gives the front-end explicit per-call control: GET_VRING_BASE for
> normal operation, GET_VRING_BASE_SKIP_DRAIN during live migration.
> 
> In vhost-user-blk, GET_VRING_BASE_SKIP_DRAIN is sent only when
> inflight-migration is enabled and the device is stopping due to live
> migration (RUN_STATE_FINISH_MIGRATE). The inflight-migration property
> is also made mutable so it can be toggled via qom-set at runtime without
> reconnecting to the back-end.
> 
> Alexandr Moshkov (6):
>   vhost-user: add skip_drain param to do_vhost_virtqueue_stop
>   vhost-user: add GET_VRING_BASE_SKIP_DRAIN message
>   vhost-user: use skip_drain with GET_VRING_BASE_SKIP_DRAIN message
>   vhost-user-blk: make inflight-migration prop mutable
>   vhost-user-blk: move inflight_needed higher
>   vhost-user-blk: use GET_VRING_BASE_SKIP_DRAIN during inflight
>     migration
> 
>  backends/cryptodev-vhost.c        |  2 +-
>  backends/vhost-user.c             |  2 +-
>  docs/interop/vhost-user.rst       | 88 +++++++++++++++++++------------
>  hw/block/vhost-user-blk.c         | 43 ++++++++++++---
>  hw/net/vhost_net.c                |  9 ++--
>  hw/scsi/vhost-scsi-common.c       |  2 +-
>  hw/virtio/vdpa-dev.c              |  2 +-
>  hw/virtio/vhost-user-base.c       |  2 +-
>  hw/virtio/vhost-user-fs.c         |  2 +-
>  hw/virtio/vhost-user-scmi.c       |  2 +-
>  hw/virtio/vhost-user.c            | 47 ++++++++++++++---
>  hw/virtio/vhost-vsock-common.c    |  2 +-
>  hw/virtio/vhost.c                 | 34 ++++++++----
>  include/hw/virtio/vhost-backend.h |  1 +
>  include/hw/virtio/vhost-user.h    |  2 +-
>  include/hw/virtio/vhost.h         |  7 ++-
>  16 files changed, 172 insertions(+), 75 deletions(-)
> 
> -- 
> 2.34.1


