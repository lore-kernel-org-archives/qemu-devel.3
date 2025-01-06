Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F9EE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 17:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUrJV-0005qY-0c; Mon, 06 Jan 2025 12:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tUrJT-0005qP-Cy
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 12:54:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tUrJR-0006mt-Kx
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 12:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736186085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fvy2BjbbeD6qoEouZiqZW2ocKJMDLV5YU9HPan5O/L8=;
 b=Bl0PI6CGXbAHp/GwN/A9QGeSf3TejNi9ydATCCK4L3N+E7U++R4fm5BWqN/IXux3UnSQ57
 fZ6P/WKYS2M6mbMedfO9n/4MflKHmXS558ixCqIPVj7wMcTddHDsNTVKH5ckabpz2mODep
 NtG4qdOni1Mp5+ZU+M7COb77Kk8jxh8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-jcLlnVRlNYqAVp84ZCVQeQ-1; Mon, 06 Jan 2025 12:54:43 -0500
X-MC-Unique: jcLlnVRlNYqAVp84ZCVQeQ-1
X-Mimecast-MFC-AGG-ID: jcLlnVRlNYqAVp84ZCVQeQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6f2515eb3so1498004285a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 09:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736186082; x=1736790882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Fvy2BjbbeD6qoEouZiqZW2ocKJMDLV5YU9HPan5O/L8=;
 b=PI5SHcOxKlObT6i8buPt++E1nJiCZINQJFHXOEuPIB0B+Ap07XAbiViGdbtYkeDSCE
 1CwCs+FQ6BT8RH4R5+e3ymb40QgJrbFFBTatVCoM+K0ZrTVtVHpbkprA6sSFkhp3xtVx
 hCTRwKv/Fv2TWCVgxmZEE1MT5oo0RKO7zAqi6g0IaT6LI9dVv47msL8meHZ59VAZNIfB
 yxcC1/kAA0GILYHhJO31Bftpod7sZxJoEZAu0hMAwis+khG8jdp+9ewq8LUwTeUerxrf
 itLmORSOi0lXEknYwSaW5W7TPOKnt9gBzOxoUlBMFjWwoRONhMBmPHzWe54+GN/VTJhN
 VAmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ0pFIUBoNUkIy2PxCkRrvGikAw4v+JGii62F6uXoJRI0u3OM3nzs9JP1IJ5o4xC0fyF/Jq+TBMX6Z@nongnu.org
X-Gm-Message-State: AOJu0Yw2LMe50/tWYnI8YaP3PFzddi/KBWrC1Q+6KDhAy8xsZhEZWxfW
 G869IklerKQYIXEsL4YI/iVKRn9ka+1ZnhPEBH7/+y773z7FiSNpXCEVHXA6suFvM+xgIFHAQ4X
 +/477/AxT60GJH5GoiNkPCiMDN3zj/aXolbo+zK73hYhmZs0jx6B464n/zX1Fz2xd93E7gPxzWO
 IBSO1upLsCQOA1SDPjrBibqjLEzd4=
X-Gm-Gg: ASbGnctX1dNq56on7hLxx6+FpfOox2nR+XHC3U9uEQbiMu1tNvIy7+6ygQfvSyykA6S
 Dsk0bCiKLykSkcRxAoXkDfb2ephKAUcIRDycT2s8=
X-Received: by 2002:a05:620a:27cb:b0:7b8:61df:f5de with SMTP id
 af79cd13be357-7b9ba7e5f73mr8860434585a.45.1736186082490; 
 Mon, 06 Jan 2025 09:54:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhUeBRKm87lpA4OkU+PW6OVxzk/PdQTTo8DJ9H7DxKOIWLi5mINjgNIwXQXlvQE+Mv7YJYGNpHFRjIkXlQdVs=
X-Received: by 2002:a05:620a:27cb:b0:7b8:61df:f5de with SMTP id
 af79cd13be357-7b9ba7e5f73mr8860432485a.45.1736186082226; Mon, 06 Jan 2025
 09:54:42 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jan 2025 12:54:41 -0500
From: Andrea Bolognani <abologna@redhat.com>
References: <20241203094702.124748-1-abologna@redhat.com>
 <CABJz62PDz_LJdji-NC7LdmonjshG4w+OqGJPzkuStECzMcYSBg@mail.gmail.com>
 <CAKmqyKMkN7z51MoAeOK-buDZjKeEV7AjzviyVcZ_AyMEJPgg0w@mail.gmail.com>
 <CAFEAcA97_XJNs=oZP2OUTsGdaEU0YD9_PFzucQO214+Vmo1mmQ@mail.gmail.com>
 <Z3vFRrkjIEa-LaqU@redhat.com>
MIME-Version: 1.0
In-Reply-To: <Z3vFRrkjIEa-LaqU@redhat.com>
Date: Mon, 6 Jan 2025 12:54:41 -0500
Message-ID: <CABJz62Myvg==rTWpjHhB9MWufZ_AMoMJv6Jtmf4i3isQt=sV1w@mail.gmail.com>
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,
 64} part of the same family
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair23@gmail.com>, 
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 David Abdurachmanov <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 06, 2025 at 11:57:58AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Jan 06, 2025 at 11:47:00AM +0000, Peter Maydell wrote:
> > On Mon, 6 Jan 2025 at 01:29, Alistair Francis <alistair23@gmail.com> wr=
ote:
> > > We didn't get an answer to the issue of a CPU supporting RV32 and yet
> > > the kernel still calls QEMU.
> > >
> > > I understand this allows things to work out of the box, but seems lik=
e
> > > a disservice to any hardware that does support RV32
> >
> > There's the same thing on Arm too -- we don't set up qemu-user
> > aarch32 binfmt-misc on an aarch64 system because the host might
> > be able to natively execute the aarch32 binary. This is becoming
> > less true, but we still don't want to silently downgrade
> > native execution to emulation on the hosts where native execution
> > used to work.
>
> Arm is a bigger problem as historically there genuinely was a
> non-trivial set of CPUs with 32-on-64 support in HW.
>
> IIUC, the riscv situation is much less likely to be a real problem

Exactly.

My understanding is that, while 64-bit RISC-V CPUs that can natively
run 32-bit applications are theoretically possible, no such CPU
actually exists right now.

Even if it did exist, distros would have to set up things to support
this scenario, which they don't.

So in the current situation we're effectively making it impossible to
run riscv32 binaries on riscv64 for the benefit of a hypotetical
scenario.

> As a immediate bandaid, I'd suggest that qemu-binfmt-conf.sh could keep
> its current logic as the default, and have a switch "--32-on-64" [1] to
> tell it to generate the binfmt for 32-bit arch, even if 64-bit arch
> could have 32-bit support.
>
> Distros/users could then choose whether to pass --32-on-64 when staticall=
y
> generating the binfmt files.

While I'm still convinced that this patch could be safely applied
as-is, I'd be happy to go with your proposed approach if doing so
would help move things forward.

--=20
Andrea Bolognani / Red Hat / Virtualization


