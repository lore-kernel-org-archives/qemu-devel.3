Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF04E65D14
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 02:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEIym-000825-0J; Thu, 21 Nov 2024 21:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tEIyd-00081e-Kt
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 21:00:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tEIyb-00051j-TN
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 21:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732240850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jk86ALuywbr7Pa31NOuvlfxUTyNtpXhnqPd3eSh0lUY=;
 b=g38Eguf/FmP9vo8VpnSbqFdUd5HfjAufQc4JGOEwVg5OPre9sfcWA/o59Asox0Gv2/yhqd
 0O0rysKFvZSnUGwJJihTklr88p91Lz+LRri5yYR9jhyBGr1YJDNJPJ41q4aFOisrKelTrx
 +UWECvsAjOXci6HWiMH/GfZDH7ZUjpA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-iOERblzhPcGfmr2jhsvW8A-1; Thu, 21 Nov 2024 21:00:48 -0500
X-MC-Unique: iOERblzhPcGfmr2jhsvW8A-1
X-Mimecast-MFC-AGG-ID: iOERblzhPcGfmr2jhsvW8A
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ea21082c99so1696845a91.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 18:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732240848; x=1732845648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jk86ALuywbr7Pa31NOuvlfxUTyNtpXhnqPd3eSh0lUY=;
 b=jOiGsIuJeZ1VttqYvRiAW/q/zhrP/z7NYM+ikgibXB56Y39i+uqSY0o0QGUQwwnaj/
 lHl1yuyySYv+MDa+HvJ9y+VIUsCkt6hRibN8x3WRGeM113AtLDLjfJel0QizUy+Ubtbo
 2Fy7IxglapImeDodp1zJhokIDQSMGHEYNloPQ8sAbUwuFYRXKPDQEN1DIZ6xcbGRlzv7
 xgGjVobhrlxxsAioyq30euu+FXH5ae1RYIkOaVgv6oPfg8oRGU/s8xHb9Z2/DoCcA0Po
 AoNNlr/XWcun3P34p1oLwJd+lFgfl8YKdPqrhuBNLBp6K52DxeHLaLIz8CGBXSVx36GA
 d6nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8mNbZd8vlOgQsOpG201bh/6Q1iYr1pc2ZtvuaJMETs4kwLlGLzKWW48GLS8owz6QysIYWJiSnHn/v@nongnu.org
X-Gm-Message-State: AOJu0Yw5wRJquKjMDgRYTV1yCwHT3qcyE6hiKyWC1wWNJvhhGupkY87Q
 5EK/xl78AS9FnlbJM6ubpQUNgoq0FU9B31bpigEPPKJViGnlQsTiObgRnXu2jRv6OzOC4Dx+kUo
 r8YI0iAuVLW0Gn8lwyVGzchQy+86IuVXuJvDjyZNvItDhV/pKCjYbK67AZrASGuVK9CKCWTlPd8
 2GKK08iJzwk6sBbjOkUre1ePpg2/o=
X-Gm-Gg: ASbGncs04M6reeqxEE9ryk4UOgTb+oZEAiZFnCsNw6s3KsXk2a+tCoiF1eoaU75V5UG
 dMbquz6997Js83823dn3lwAtuFpDBpA==
X-Received: by 2002:a17:90b:388b:b0:2ea:8c3b:6d07 with SMTP id
 98e67ed59e1d1-2eb0e860129mr1028193a91.28.1732240847916; 
 Thu, 21 Nov 2024 18:00:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN7tL27RgzHcDL6+FhQygTEk63WPzkfZHNYUkbyr8N6hODBlJqTeM8sSQgWxmv4es9jK+cUids3/3lRko+O+k=
X-Received: by 2002:a17:90b:388b:b0:2ea:8c3b:6d07 with SMTP id
 98e67ed59e1d1-2eb0e860129mr1028163a91.28.1732240847468; Thu, 21 Nov 2024
 18:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
 <56718639-49b4-4660-94f2-3bf6f66e293e@tls.msk.ru>
 <3525b64d-9262-4eb4-9891-d30ace0db69f@daynix.com>
In-Reply-To: <3525b64d-9262-4eb4-9891-d30ace0db69f@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Nov 2024 10:00:35 +0800
Message-ID: <CACGkMEtCSKQ62jLfKKhc9Ejz8F2cMC-v-U7-8_QnZbZO-CsZiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] virtio-net fixes
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, devel@daynix.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 21, 2024 at 6:09=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/11/21 19:05, Michael Tokarev wrote:
> > 11.11.2024 09:40, Akihiko Odaki wrote:
> >> Most of this series are fixes for software RSS and hash reporting, whi=
ch
> >> should have no production user.
> >>
> >> However there is one exception; patch "virtio-net: Fix size check in
> >> dhclient workaround" fixes an out-of-bound access that can be triggere=
d
> >> for anyone who don't use vhost. It has Cc: qemu-stable@nongnu.org and
> >> can be applied independently.
> >
> > Hi!  Do you plan to submit this and "virtio-net: Add queues before
> > loading them"
> > for 9.2, which is at rc1 now already?
>
> I want "[PATCH v2 2/6] virtio-net: Fix size check in dhclient
> workaround" and "virtio-net: Add queues before loading them" for 9.2.
>
> They have Cc: qemu-stable@nongnu.org and will need backporting if it
> misses 9.2.0.
>
> Regards,
> Akihiko Odaki
>

Want to apply this series but patch 4 doesn't applied cleanly, please
rebase and send a new version:

Applying: net: checksum: Convert data to void *
Applying: virtio-net: Fix size check in dhclient workaround
Applying: virtio-net: Do not check for the queue before RSS
Applying: virtio-net: Fix hash reporting when the queue changes
error: patch failed: hw/net/virtio-net.c:2044
error: hw/net/virtio-net.c: patch does not apply
Patch failed at 0004 virtio-net: Fix hash reporting when the queue changes
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Thanks


