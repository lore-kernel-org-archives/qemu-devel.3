Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654D8CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 06:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGtga-0008G6-N4; Thu, 06 Nov 2025 01:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vGtgU-0008Di-2B
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 01:41:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vGtgP-0002SK-8M
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 01:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762411276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wsmiHPIlSnW4YTKeEs5SSm1PVbXwF4Cp0f2iOarCvf0=;
 b=J5dDt1aP00MsEK+VdPvSqAMwXAnJrfgHlBr5nH5Z1rZFDjc9w7FPJXhWIGi1wH0lDk4voW
 kSXl9djY+DsGhXvWYUS/p8x7J3fEfNclyHoU8uVpxdme27ZOHly6uoemsJr095eQh0B0QT
 X/2ZGxdEtkYne9lFaFbopCS4Jgg68xQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-YEPKce7fO6CiVeFr_CizQw-1; Thu, 06 Nov 2025 01:41:14 -0500
X-MC-Unique: YEPKce7fO6CiVeFr_CizQw-1
X-Mimecast-MFC-AGG-ID: YEPKce7fO6CiVeFr_CizQw_1762411273
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34176460924so665820a91.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 22:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762411273; x=1763016073; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsmiHPIlSnW4YTKeEs5SSm1PVbXwF4Cp0f2iOarCvf0=;
 b=a9WvQ8+sPu1lRHktu2Eoebugc+nzdHZcFAU4LJ7PL6ScSnLFjhcIxgznIqiCTvRrHi
 G9koZ5P9kIL9c53DSfBFztlnfT6pNdrcXck7SRf95Ue+MuUWa5A5X8K+C/lvd/Y4FQTf
 mOxOfFAB7Wyv/v0TvwmiqXOfvyhRj1H7kKwnUIoS3Sc3mBl+uTb1GBNOmupoUSnW69DS
 +DQBA9xif22pEkPisq++3usEL7eW3bibuEchbJOcQsld2erKK1GJDnvlyN5+eySq/MWN
 WlHm3U08+shReyikVVWfM6h1kRIZCj/XMdHM6+Sg+0gz6a3tB0D8qiEWzVdA9FZe7349
 5b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762411273; x=1763016073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wsmiHPIlSnW4YTKeEs5SSm1PVbXwF4Cp0f2iOarCvf0=;
 b=YLDG5wU0mgFRLYCLY6aA8o42dYpFICPwgEApuLNGFsA/BKeGhTeorW6KMJ535PK6/w
 9QRS5JQ7j/o+WoIbQjSQ9C8bs5zFd9sXxPRD8trvzCKTvNkvGzDtaTrEgiPWfsT/gpsC
 tmXPj0o2uR/zXf98DqpVq+rsuH05ciYLr1siutAeDdVRA/Dx7F1OugroFyXEFUcPsLn9
 +GvoUYoLb24lmOm9cihDbX0XXOu5MNkOJZ4AqpCP8Z42au7+ufmmZilczMQ78zmQVMCi
 sqxd+XrOVQFT2giNBUWcxDZWLSoHUYFrfrHn676LIcGBxNr7Ry7MkNDRXJcCpGfggiyv
 trzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMEzHj/sq9rR/xLPaBddlpz1LAkmghN467FBaMQ56RsfNqcc/k0j1YR/MMxZqz3p49YOIc5t92E7m0@nongnu.org
X-Gm-Message-State: AOJu0Yy8nSJAeKsc7nULRtw3hfLl8R25hik7HGEeF6d6lqa4YeEh683P
 d18CVUYcLenBxxi3cwUVQrxkdASDuVvKRIVdM5lKmt5y6SdI8gCprbcH2tIS6ISL0BYcLsDZzxf
 21B6ENXZ84zXIE40XSnbXiHcE15c7sDtz05W3IMHeEyQ3bQ0B8QeEeAQdDJ8hrWzeEGB/Qo8IBJ
 6PMhA/F926+HBzvISNLWWpO6UNvXEbS+o=
X-Gm-Gg: ASbGnctyMaCTpKxIDaRCMUqRH4jWquIlMdtfGPwzHsQsmxvmfK0doyw0bHsIhA4n/ay
 Cjq6TQz4yiYf1ZI5ISTeOb1V/WGQ1Iq5DxAStiRmQ/osi/9l1urL9BO/ME8PqULAaXClzXQiZpq
 rkinBh+cc0kbfKCRrzBCk22ktf400WPZnyvm/DZT7Pwvirw8pJoz6RD+Y2
X-Received: by 2002:a17:90b:5847:b0:340:b572:3b7d with SMTP id
 98e67ed59e1d1-341a6dc595fmr7908954a91.19.1762411273222; 
 Wed, 05 Nov 2025 22:41:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3jTLYA9LzQBL7MQAXou69F6I3TkcObtO83ml27JqGSX7OBtz3ifV/9XQ2j4b/VjSWmvZWlLh3dDC/vy9L89g=
X-Received: by 2002:a17:90b:5847:b0:340:b572:3b7d with SMTP id
 98e67ed59e1d1-341a6dc595fmr7908924a91.19.1762411272857; Wed, 05 Nov 2025
 22:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20251029125001.15086-1-wafer@jaguarmicro.com>
In-Reply-To: <20251029125001.15086-1-wafer@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Nov 2025 14:41:01 +0800
X-Gm-Features: AWmQ_bmMtpc-E2T0cLKtwyqlIBDjj91xzJ1oM8NAUjMYZtUPqZ3Afe30hgdO5Pk
Message-ID: <CACGkMEtDMnN3DqdbJ_8_EB4XWchJcuCbGdXWTSvE05WEn-=ayw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix cannot get vring base when stopping a
 vhost-vdpa device with multiple queues
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: eperezma@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Oct 29, 2025 at 8:50=E2=80=AFPM Wafer Xie <wafer@jaguarmicro.com> w=
rote:
>
> When stopping a vhost-vdpa device, only the first queue pair is marked as=
 suspended,
> while the remaining queues are not updated to the suspended state.

This looks like a bug, no?

> As a result, when stopping a multi-queue vhost-vdpa device,
> the following error message will be printed.
>
> qemu-system-x86_64:vhost VQ 2 ring restore failed: -1: Operation not perm=
itted (1)
>
> qemu-system-x86_64:vhost VQ 3 ring restore failed: -1: Operation not perm=
itted (1)
>
> Fixes: b6662cb7 ("vdpa: add vhost_vdpa->suspended parameter")
>
> Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
> ---
>  hw/virtio/vhost-vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 7061b6e1a3..2d5e6aca74 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1481,7 +1481,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_d=
ev *dev,
>          return 0;
>      }
>
> -    if (!v->suspended) {
> +    if (!v->suspended && vhost_vdpa_first_dev(dev)) {
>          /*
>           * Cannot trust in value returned by device, let vhost recover u=
sed
>           * idx from guest.
> --
> 2.34.1
>

Thanks


