Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFE6C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHOCZ-0003ZE-Bz; Wed, 12 Jun 2024 09:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHOCX-0003Yv-OB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHOCW-0007iN-10
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718199582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QekPl/+SJDAqOkSOuUlcgF2vIe5Agb0K/30Ij11Y9HI=;
 b=asQq7xw+e6KAGST8cosqHtaZhadehU592KNtRght2zZZMDtUE4qrl9WsXuYdYB2QmftnNq
 XUbXA7Hmg99li4W8ngekVeLiJVOzDldbJckzfFmiPPAH/Y79qMn2N50EvGp9PBkY4EFA4i
 j4J8KbQhgjkMY+wlAtpwFM3slGcva3o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-gyFDPiISMnaE1TqBuIzIVQ-1; Wed, 12 Jun 2024 09:39:41 -0400
X-MC-Unique: gyFDPiISMnaE1TqBuIzIVQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35f06558bc3so1709152f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718199580; x=1718804380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QekPl/+SJDAqOkSOuUlcgF2vIe5Agb0K/30Ij11Y9HI=;
 b=rGsY8zTsOth3MJmBPG1GPmpeCIwkPv+lYiky00WbhV3+Aqe7WIv8nNWGhIfURifHrm
 ow5rhxt/yfM4fbXunmGClP4uFufJM7qm2QSlt9FfB8AZ0ZZfEQBI+QW6Q4dQf63fewy9
 Fd/BFHOK4HvSkeeJIROnC3TwAk5HVNw/VdQa7E478TpzooeBPbQ9z1D83KjZ+oOvAmBS
 klu7cL1Sf4IIrM+zWkdvLUOPlcipDUgFxhGA9t6qHMpqTVibnk/FIlzaUtnaP0TS1vcW
 nFRCAIsU1mdx+7CN0hmGcbBOotCeFMXIrKD+xJJd4CdEAM3Q9Y62Xk6qy1gxOu362zyG
 /zBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTauRCsw/Kn77rOj8M6s+OELoFD0o2R2vVZG/VM8t+JIXCo+16FZy5uSLXIRJ2d+gvc94JqKpvb6MiwkqVX2vRb1386h8=
X-Gm-Message-State: AOJu0Yxm8WkPFjyT/r6fgEwMxudBcDRivvBTRqr9MS1YNV/q/MrLA9rD
 nFkZ/Vxpkl6KUMHMJylZR8F2JvUbEDYZLy3mZ4gNWHdh3mvJksRuasapzGv8uBDRJpYjoi7pAUC
 BmCT0dFpCCb1YFjf2tEBpmG2XyPHlDcmAouTE71M/jgc5d/dPWAKq+3b0AMwJZSZ4oejCrsUqo3
 t9dwnDJH607f0FRBEG9nr8ECiRaIA=
X-Received: by 2002:adf:e645:0:b0:360:6ffa:9803 with SMTP id
 ffacd0b85a97d-3606ffa98cbmr624438f8f.56.1718199580541; 
 Wed, 12 Jun 2024 06:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBQ5ZcEbocLMw2CEB/I6OAGJRnGt3DmYLMT81vjeitZvtwMWDdjkbz5We1ZFIda+k5J4KY6rgClYRvqyo/ZDo=
X-Received: by 2002:adf:e645:0:b0:360:6ffa:9803 with SMTP id
 ffacd0b85a97d-3606ffa98cbmr624419f8f.56.1718199580172; Wed, 12 Jun 2024
 06:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <e26ac8a0-5cb0-22a8-fbf9-54f198cdc7ed@ispras.ru>
 <CABgObfYf8=3yXu1p6q6jzyZ7uHy92BHaBXtJY8AMYXBdd9+HGA@mail.gmail.com>
 <caa7d068-a2c6-28a4-51d5-93c61f004bc0@ispras.ru>
 <CABgObfaswAJRffjdu9h8crD6jvFAP78CaDDbutvoa7EGxwuy1w@mail.gmail.com>
 <e292326a-0f71-3d4d-4ec1-562efe94271b@ispras.ru>
 <CABgObfZEmA6DrN-8f_nTg8DHfN+m7DO+DbabW1AtdtMtHjbgyQ@mail.gmail.com>
 <b5fac5cc-40af-2437-44c4-4e0d5747691d@ispras.ru>
In-Reply-To: <b5fac5cc-40af-2437-44c4-4e0d5747691d@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 15:39:28 +0200
Message-ID: <CABgObfbPu10_jEuT2sEHJmF91Vov9M7bTmLR9dQXRR5gicNF5Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
To: Alexander Monakov <amonakov@ispras.ru>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Wed, Jun 12, 2024 at 3:34=E2=80=AFPM Alexander Monakov <amonakov@ispras.=
ru> wrote:
> On Wed, 12 Jun 2024, Paolo Bonzini wrote:
> > > I found out from the mailing list. My Core2-based desktop would be af=
fected.
> >
> > Do you run QEMU on it? With KVM or TCG?
>
> Excuse me? Are you going to ask for SSH access to ensure my computer real=
ly
> exists and is in working order?

Come on. The thing is, I'm not debating the existence of computers
that don't have x86_64-v2, but I *am* debating the usefulness of
making QEMU run on them and any extra information can be interesting.

> Can you tell me why you never commented on buffer_is_zero improvements, w=
here
> v1 was sent in October?  Just trying to understand how you care for 2% of=
 L1D
> use but could be ok with those kinds of speedups be dropped on the floor.

I'm not sure if there is any overlap in the scenarios where
buffer_is_zero performance matters, and x86 emulation. People can care
about thing A but not thing B. If there's anything that you think I
can help reviewing, feel free to let me know offlist.

Paolo


