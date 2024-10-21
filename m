Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37CFD0E6C8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2nhp-0002oH-Qw; Mon, 21 Oct 2024 04:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t2nhn-0002nv-Tc
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t2nhm-00048O-FR
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729499037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q+qrwHJ6kj519GVC+JLS5HtXbgWEJiktOxA+ULjreYQ=;
 b=DaV34arDTq1AWzPSDlLiIDUgElXAHMHzLM7f9V5CHnYHtPJGIAgrS1yjlVJazQNBOWIRv/
 GWNTFJkIGPI2er1daOixSC2HcetJaUXj97Bbfpm+o+MdsKcD9vAb5gLGoCXtUT1XWyxTZW
 o5o4VF751I++zy6Nk8QwrI6rUkR9VNI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-YguLMErHOzms8TWHcUMsMA-1; Mon, 21 Oct 2024 04:23:54 -0400
X-MC-Unique: YguLMErHOzms8TWHcUMsMA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7db4c1a55f5so3640498a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 01:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729499033; x=1730103833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+qrwHJ6kj519GVC+JLS5HtXbgWEJiktOxA+ULjreYQ=;
 b=F/AKNKH8uy3YG0+fdB7gd9NWxDGFUTf0WEmYKeJsy+Tu5jsxVpQ9x61IpEIPJDJr66
 aNIAAbmJOhx2AenPoeFCfwT9lnqlqvK4BQdIEbFRhNA33Ow68wxA5bRonuhXqX16M83/
 atAGpyXxqzVPRluIXzKiqOfWWMqzXrIDuSw8U5k3ZOuUzfF6/e9qfzANiXaG3Ndjbf1F
 8FBH6J7vY3i7UebkMTxKjUEUTVldjLKNyBG1Ri05G4YbQEQ5D8qZgZSlR2TdYOvd8OH8
 1X9SNLmhYZoJ9hLRyYN5aOAZo9bsMzrnRZTEZG3az0KQa8JbNiN2F8mBZIleQ3SP+7P4
 SpDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiLBkrBcSkUnSrLUFn5ITBe3zuSMXdd/nTEHoswH/fkqNaDeb5qXYUF0arzU7TIhBwGNGkjwx3hE5z@nongnu.org
X-Gm-Message-State: AOJu0YzEaw/qOfM9CXS+4+wWUg84+I8c/uDBkqyAyU25xs7WmYdr48bU
 EujxMaEjw//oZNmDhFxyFfzGRfaZd5/wu9fphz7Gyquc5LzDGzWo2knGE5E8a2UJhk7l21953BS
 1OfgPV1amD57gGIc78noXfbVw2LifjoeaZK+j8yo+pOUn42sdr6eKgIpxwX6vexxQrcbdNdXdTQ
 udXjb8GqNsbFnGWCmo7QNlTaEFRBo=
X-Received: by 2002:a05:6a20:2d12:b0:1d9:4837:ada1 with SMTP id
 adf61e73a8af0-1d94837b137mr10303402637.35.1729499033464; 
 Mon, 21 Oct 2024 01:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqzCdgF2+2w9Ry6nOKXA/T3wHdVYoK6JPiaasAApd9iJqzv/G5OYX9B9xnleiYSnbp5SEAD2ee8dy+BuhkIx4=
X-Received: by 2002:a05:6a20:2d12:b0:1d9:4837:ada1 with SMTP id
 adf61e73a8af0-1d94837b137mr10303378637.35.1729499033039; Mon, 21 Oct 2024
 01:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
 <20240915-queue-v1-3-b49bd49b926d@daynix.com>
In-Reply-To: <20240915-queue-v1-3-b49bd49b926d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Oct 2024 16:23:41 +0800
Message-ID: <CACGkMEuzgUKSqm01rEcYZ2+AkEOrqY-isvsVHS2r+aeomG08Rg@mail.gmail.com>
Subject: Re: [PATCH 3/7] virtio-net: Do not check for the queue before RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Sun, Sep 15, 2024 at 9:07=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio_net_can_receive() checks if the queue is ready, but RSS will
> change the queue to use so, strictly speaking, we may still be able to
> receive the packet even if the queue initially provided is not ready.
> Perform RSS before virtio_net_can_receive() to cover such a case.
>
> Fixes: 4474e37a5b3a ("virtio-net: implement RX RSS processing")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

The patch does not apply cleanly:

Applying: virtio-net: Fix hash reporting when the queue changes
error: patch failed: hw/net/virtio-net.c:1901
error: hw/net/virtio-net.c: patch does not apply
Patch failed at 0004 virtio-net: Fix hash reporting when the queue changes
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Thansk


