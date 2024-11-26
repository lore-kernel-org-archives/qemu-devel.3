Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B95D5A6CC
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 03:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFls3-0001O3-Pv; Mon, 25 Nov 2024 22:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tFls1-0001Mq-Dm
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 22:04:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tFlrz-00084h-BO
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 22:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732590244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XgEcesNGHdUKQizaGlSYRpLPYxrtkyuorFsfZMfUnb0=;
 b=Gki4ZFkjbfKekKxYYPq6SoMMBRE3l7UvIdIRQNpkZ0w/TANyNrHu3gEO2o9vUsWV3iphCl
 CuQ3aakkzJXWuKeQRe2Jw54ukMrQ5au2Mxctf6Twvj9EaVB1AiTKqjQFOGeavRpMCqPpi5
 0xH0i9DWa1ljyaqYPxTGYs1RC7BuM6c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-vbOSp_aaOPGZ2iXMxkG0DA-1; Mon, 25 Nov 2024 22:02:48 -0500
X-MC-Unique: vbOSp_aaOPGZ2iXMxkG0DA-1
X-Mimecast-MFC-AGG-ID: vbOSp_aaOPGZ2iXMxkG0DA
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5cfca66c7a2so3065955a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 19:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732590167; x=1733194967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgEcesNGHdUKQizaGlSYRpLPYxrtkyuorFsfZMfUnb0=;
 b=QUfs/AAPPG+MNwCZhfnnV9sN1FWxgFUvBzI9HBIIGb/xQ/rO3ZG/nE6cjKQCa8DDKv
 Ou0HwD2VxCLbUMdq6kOgAVIKvYnIJ39VG4Kz/lOINat2BDMMlrkVupHJsYCQMh/neGC5
 tQ3AHr/W/sUwrK6kznRiJdc9W7B5QooYcZxc8qCezuP/gAYNiPllFGKCXHvyGP4IjLzg
 I6wU7jDANOObF1nbJC3dbVBa/q+01RrBLzV6JyrHBizkALDQNCEhXc+wU/DHRCWzMUQW
 /dKBYONyJRBArlLC7Z+XbQiR98rswgNF7zByit1McjiCDXnVXt165plx8rcdPXbVRNkj
 rKCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF6xn4YWNDvV8GUVrLCTXN6KeygGdUqd627MkCt3AFo3Sv0ff8Wm4lEGC1DsG4VNNBatVzpRyXMBfU@nongnu.org
X-Gm-Message-State: AOJu0YxPQg+A2eqEKUF+q3bdMqnN3nr5wo7pafuG36C9HvrxBs6VRKNU
 lO4/XLU1Wc5yeoPoNndgIcAbFJvd4o08gWV56LSRIL2aE9Fx3ikrZqkkT93q4QyyCbWSEfYQu7s
 qdQQBveUv3qknnoZvoh/RfPFQ+wQ9cEpmFbPkTwP5saTA1AIl4WPZwulEzxNLcvyfegLx7+Wiey
 BrDN3DFBsu73h+QVm/fQXrI3MLvH8=
X-Gm-Gg: ASbGncutv1xXMQ3X8SjHbdZvjjKtCIxkk2cHFDy2ppjtsDOzCYqEe7Llx2ZKx+22+Wq
 OT6QqaMhvNoNDtp1G9OXJ/mAgmNWSFJDG
X-Received: by 2002:a05:6402:42cb:b0:5cf:9f1:3f39 with SMTP id
 4fb4d7f45d1cf-5d0205f8ef4mr14902958a12.13.1732590166847; 
 Mon, 25 Nov 2024 19:02:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdEqPKwn+I6d1Ntf0CGDxXgGBqDEOH5RNSG95CDpR8LQSMYKVi71GY36uKeXnYR+a4bo77Ss87Y1gY3Aa3JuQ=
X-Received: by 2002:a05:6402:42cb:b0:5cf:9f1:3f39 with SMTP id
 4fb4d7f45d1cf-5d0205f8ef4mr14902937a12.13.1732590166542; Mon, 25 Nov 2024
 19:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
In-Reply-To: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 26 Nov 2024 11:02:09 +0800
Message-ID: <CAPpAL=w=LeEMXcFtDfKEgh0Eyqz1PQx2XYyG7vihmDiAh2qzGg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] virtio-net fixes
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, devel@daynix.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

QE tested this series patches with regression tests, everything works well.

Tested-by: Lei Yang <leiyang@redhat.com>


On Fri, Nov 22, 2024 at 1:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Most of this series are fixes for software RSS and hash reporting, which
> should have no production user.
>
> However there is one exception; patch "virtio-net: Fix size check in
> dhclient workaround" fixes an out-of-bound access that can be triggered
> for anyone who don't use vhost. It has Cc: qemu-stable@nongnu.org and
> can be applied independently.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v3:
> - Rebased.
> - Link to v2: https://lore.kernel.org/r/20241111-queue-v2-0-2f7883a1004f@=
daynix.com
>
> Changes in v2:
> - Dropped patch "virtio-net: Fix num_buffers for version 1" in favor of
>   fixing the spec. See:
>   https://lore.kernel.org/r/CACGkMEt0spn59oLyoCwcJDdLeYUEibePF7gppxdVX1Yv=
mAr72Q@mail.gmail.com
> - Added a Buglink to patch
>   "virtio-net: Fix hash reporting when the queue changes".
> - Rebased.
> - Link to v1: https://lore.kernel.org/r/20240915-queue-v1-0-b49bd49b926d@=
daynix.com
>
> ---
> Akihiko Odaki (6):
>       net: checksum: Convert data to void *
>       virtio-net: Fix size check in dhclient workaround
>       virtio-net: Do not check for the queue before RSS
>       virtio-net: Fix hash reporting when the queue changes
>       virtio-net: Initialize hash reporting values
>       virtio-net: Copy received header to buffer
>
>  include/net/checksum.h |   2 +-
>  hw/net/virtio-net.c    | 108 +++++++++++++++++++++++++++----------------=
------
>  net/checksum.c         |   4 +-
>  3 files changed, 63 insertions(+), 51 deletions(-)
> ---
> base-commit: 34754a3a627e1937be7f3daaa0c5e73d91c7d9b5
> change-id: 20240907-queue-f425937a730f
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


