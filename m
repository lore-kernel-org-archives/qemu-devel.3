Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10919C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 13:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEqff-0006dN-VO; Wed, 05 Jun 2024 09:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sEqfd-0006VE-M3
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sEqfc-0001cE-2k
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717594034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9e4KwmmjiJ5xmaAO0+LStJyYZP1//KhEcep2QFkcTI=;
 b=Yy2iqACs0gRDidEa2E0IeW0gyRnHxCXyeoK4GsnXoyaXQDIwKAfsVMDSv6P43go2b+SVXX
 r3ErEL3S35O7sh66MXnbwUGV1BX5n05ILrudwUPLMRKsaqgRnn/ebCRuIbW3XhDJTImdTz
 oUDgvtkn/2WOSiplXrDqnRP+4hTM1rM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-_9JgJvhnPdqw_MCBkv3SUg-1; Wed, 05 Jun 2024 09:27:12 -0400
X-MC-Unique: _9JgJvhnPdqw_MCBkv3SUg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57a50752cd2so948564a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 06:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717594031; x=1718198831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9e4KwmmjiJ5xmaAO0+LStJyYZP1//KhEcep2QFkcTI=;
 b=b6ibjboL4Y2yVF1T1gEnaTgT0JxHz+yGcu3CTqJrhcO2m7CVOLFYLgoyKjTAZ0zNZO
 KPapLuvCep/ivEpsjZLZKxvYZe/9P0WSEdFwRq4nwidD1B0YYvhRjckXSK6ph4HLN/HV
 DY/JSxYmZ25XhGz5LGXWHNtHEJVe3yk+vc3icFpq95h7Dw4eb+QZnxsKTZA589iqBir0
 SIjeoTaf5YD2PLTKMCrtT2NcIZ0mbqY5zQ9UGxg88Ud409n203P5eU5wfutbirmQ6JDe
 BMkm4LNuYjoV8NNQzcoMCgu85In3D2ptl7vLQuot8JzFd2J7kNTkY87sMxIjoyjqIynK
 hpAQ==
X-Gm-Message-State: AOJu0YwrYkfqbkTcK3p7yvT65v63T/QvEW/WsoCT8+i/wcWq7WRF0x66
 IJjEH0lzxc5w420DMX9AIHWmAzqAjxZQFRyAL/X94raMRkcjDOsIn7Z35uA1UalGUIZdFDStoS9
 6bF+tgPqBeE3ouomM3Sd8tLsSyzHnyA3q0LPPc7QKza/HPWK2mIqMnzf+HYCuWvnvhLYKncJbc4
 UBqH4Ms4GGCZ7qerZm4PV4izf1rcJzd85hOBg=
X-Received: by 2002:a50:9e0f:0:b0:579:d34c:396a with SMTP id
 4fb4d7f45d1cf-57a7a6c18bdmr4149080a12.11.1717594031350; 
 Wed, 05 Jun 2024 06:27:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrqbKaA8JYmGJu9SWv44omNvgzVPehMk6+vUutUBatoaFuw/tX7cJUj872ybAZaprPmRtrqSdff3f+TbTs/Ww=
X-Received: by 2002:a50:9e0f:0:b0:579:d34c:396a with SMTP id
 4fb4d7f45d1cf-57a7a6c18bdmr4149067a12.11.1717594030978; Wed, 05 Jun 2024
 06:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240605131444.797896-1-kraxel@redhat.com>
In-Reply-To: <20240605131444.797896-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 5 Jun 2024 17:26:58 +0400
Message-ID: <CAMxuvawet2HKobd7RjQ3dG5bW17zuMTNMj_Zmoc-m==iizB8xQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] stdvga: fix screen blanking
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org, 
 Anthony PERARD <anthony@xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 5, 2024 at 5:14=E2=80=AFPM Gerd Hoffmann <kraxel@redhat.com> wr=
ote:
>
>
>
> Gerd Hoffmann (3):
>   stdvga: fix screen blanking
>   ui+display: rename is_placeholder() -> surface_is_placeholder()
>   ui+display: rename is_buffer_shared() -> surface_is_allocated()
>
>  include/ui/surface.h    |  6 +++---
>  hw/display/qxl-render.c |  2 +-
>  hw/display/vga.c        | 24 +++++++++++++++---------
>  hw/display/xenfb.c      |  5 +++--
>  ui/console.c            |  3 ++-
>  ui/sdl2-2d.c            |  2 +-
>  ui/sdl2-gl.c            |  2 +-
>  7 files changed, 26 insertions(+), 18 deletions(-)
>

for the series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


