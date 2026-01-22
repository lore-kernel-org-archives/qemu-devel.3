Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F65C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visrq-0003eJ-Ao; Thu, 22 Jan 2026 06:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1visrj-0003dq-LJ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1visrh-00071x-Pp
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769081320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmDSe+oTS8G3U/EqtRz3XriophabAbp8L0k/+VkyN5c=;
 b=Ti1myrTitb2uKlHntcK+kR0YKsWLF3tqNdilgmTElfyx3yfgut8xHZ/ekrexqgNSdBWfZN
 nBAuFiU0zAdK25/JVE6zelxm651o1ZicY/ED4D5te5TWyTjIzUBDFj5s8qmUGe7Ephkq/v
 TVay8GvOSNCEPrQUfqEz7vrEM//GKVw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-sM8c1mrHO3K3BDVeV3s2ng-1; Thu, 22 Jan 2026 06:28:39 -0500
X-MC-Unique: sM8c1mrHO3K3BDVeV3s2ng-1
X-Mimecast-MFC-AGG-ID: sM8c1mrHO3K3BDVeV3s2ng_1769081318
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c48a76e75so830691a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:28:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769081318; cv=none;
 d=google.com; s=arc-20240605;
 b=EqB412/IoF7pt6YTGoyW+/LSY1qjeZ5JAT+EXar5d3UzqH3cfYIvXjTXTj46wg9Scv
 h/vkSaM1c9uUQbH+FTPne6dh4SDlXY+JY8s0ohYqf80fT/LvDWEXlW82djhMGFo1WgEN
 XZkhVSxXS6LdTHX+ezgTVviDPS8oIU00VJPtvEyVuQd5ncJkQSEfVxXejV/9Oh5fmHJW
 qnmcKCfD4BU9swX780Yja80gQVw5d/nTUmm46mEh0diceyvlIIRUpg6EbceL+JsJLh3I
 rrLC931Q+t3HRwVoHG7J6I2fRQl3qWNrhyB03VOO/5IFth8JxjrPtQUqkxNgS25XVw3S
 tueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MmDSe+oTS8G3U/EqtRz3XriophabAbp8L0k/+VkyN5c=;
 fh=Qoj2Z/1rUI0yVQaJjnxnbELoHsiO0wo7sEfhnuN1bDQ=;
 b=Q2qwQUeyHJZdCKH/J1ExQM/w8RMcxUI/WaaQinVkXJ9kuIlrjlS2+2ZDEw04WakXow
 xgT46tpPL3rCJVXZqPrIytLqU/GksyZuIvHrKd1mskbLfiu7V0wEuR3Va7zGwhpI4UBa
 +XNdjcE6lslrZ8HcpX0xdRrJ5Ta5kLSCwDko098blMMV2A3D0nrNx62BTwa7Jnepc2ip
 7g9+umPb8iPZ55kKfdBqEAOursu7hzH3d7hROb6EWsoFP+vTaXtpQUlqTHggkt0sIP2A
 87s47ZA/v0ARiv2Evq4weyZdFFHDoDCxyhI8Wyc+L/QmnNay6EgJ48eh9Z+KPWIGzvoQ
 xp0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769081318; x=1769686118; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmDSe+oTS8G3U/EqtRz3XriophabAbp8L0k/+VkyN5c=;
 b=joUlxuM288qYGb5g2986eFRzurbg6OpBgvC7ftCCma0jx3Tms3ilaUS95O/EJ/GP8Q
 yM/wzz3cTkzmHh9eXYSrQRBD1DPnmXkrF2Pi2JbHsHKi/fFeYBRJVAhfVDrj1b0w3b5R
 9+MWnySrjdhIrX+1A3ox8VAiHWoKh2Xqhki2yyj8VnoZTysjF2CjvARCQ/4GlfAX5FyQ
 Y+CWLZccGX9DhmUt1marEiC5ZWjfdaxQr2XuVcBxlfCmjCUfEkKhhX5qADn+QivxbLQe
 j/4OjSVbErMZnnkZCig2JX0IMqOwYJNXj5dRrp1GEQoRFlhC6cEUlQc1UOLgPaLFc8V7
 zq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769081318; x=1769686118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MmDSe+oTS8G3U/EqtRz3XriophabAbp8L0k/+VkyN5c=;
 b=dYhlR+s3LAe/+FvNvjXkxLaKQoNKSAoK/UZ8l1wTqOKDkz37ql0h5VAuBj47aV3Os3
 /E4rHHeFVQq6RCzgwyOsKXjCeNh+oLns1BYs/wgJLzPRtRTClDKMJerMGkwyCIsqTAaq
 o0lBPWpRkLx/kvy0sd9UJMj9j9WXU2x3Ob6l4kH7gCUJV3cEmpNajavy8UpHXispVf79
 KuYHPiyaDgwRCOLo56qpOkfxVUEq52izc+7PF7I0soNWnyoy0/t3Pa+AVcr6DsQZqraw
 FayEL3BxjEufhlBDW21D05iiGjiixDKomnC/bFMhlv14ybgktRIZi85WEqUbpfJBScJh
 JSKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ3P4meWFBpYMdyFNVPj/vUUfW9EA3rObzr1QkldNTfu1P1vIOt1b7qgnqcwKl2S47fDDuliT1saPb@nongnu.org
X-Gm-Message-State: AOJu0YzUx01S7coA8cBBezKJmSAhefrHf0Ffk2AkXBl6zjWECrDdXCin
 Uhp5D//1Ash+nsTrM3Ia/KhOGezkAjMHdOl0g8vf3FXhTV5aYV3TnwB8behgyDvMtvcRzMfuMIR
 dDBIGuZsHC2UuoHmYvv1SG6Tsh+rTLLICjEQdDKzzr0mEDTMikkEF4eBKwJJOsUyyUcXvHvc4ec
 wsWJz5DEZKA/DBm4p+g/SipVeMA6+NXRc=
X-Gm-Gg: AZuq6aL0/5MM0M5lYgh9FwArRgrlMoRWF3/g/DnwiSN8j8xTF66XPAsGK2SVUioaKek
 wV/+NtobtIiC4G87ZCjhYpw1eyYRudK+X49VI/Nvu9rEYnz4PDmoEHb4RuX4D4LOoJBU8+OQrWu
 sB52O0zMf2z1Wy96XUhH7DS7OIjqbEcQNuTM2si8wVjC4K3rhZg79wc8SnzSZe/6du6h8ObKuoP
 Vtt2tVmiGgTAhprqh4V6pcygQ==
X-Received: by 2002:a17:90b:1c01:b0:34c:a35d:de16 with SMTP id
 98e67ed59e1d1-35272f12a32mr17787886a91.11.1769081318347; 
 Thu, 22 Jan 2026 03:28:38 -0800 (PST)
X-Received: by 2002:a17:90b:1c01:b0:34c:a35d:de16 with SMTP id
 98e67ed59e1d1-35272f12a32mr17787852a91.11.1769081317918; Thu, 22 Jan 2026
 03:28:37 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
 <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com>
In-Reply-To: <aXICpFZuNM9GG4Kv@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jan 2026 15:28:24 +0400
X-Gm-Features: AZwV_QjBNh4RvXNqedsRlWfefXm8tdzTXizaBBZojIfu1tbjiEM0taJX8kCTgug
Message-ID: <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Thu, Jan 22, 2026 at 2:57=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Jan 22, 2026 at 10:54:42AM +0000, Peter Maydell wrote:
> > On Thu, 22 Jan 2026 at 10:40, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > > Once we have written some scripts that can build gcc, binutils, linux=
,
> > > busybox we've opened the door to be able to support every machine typ=
e
> > > on every target, provided there has been a gcc/binutils/linux port at
> > > some time (which covers practically everything). Adding new machines
> > > becomes cheap then - just a matter of identifying the Linux Kconfig
> > > settings, and everything else stays the same. Adding new targets mean=
s
> > > adding a new binutils build target, which should again we relatively
> > > cheap, and also infrequent. This has potential to be massively more
> > > sustainable than a reliance on distros, and should put us on a pathwa=
y
> > > that would let us cover almost everything we ship.
> >
> > Isn't that essentially reimplementing half of buildroot, or the
> > system image builder that Rob Landley uses to produce toybox
> > test images ?
>
> If we can use existing tools to achieve this, that's fine.
>

Imho, both approaches are complementary. Building images from scratch,
like toybox, to cover esoteric minimal systems. And more complete and
common OSes with mkosi which allows you to have things like python,
mesa, networking, systemd, tpm tools, etc for testing.. We don't want
to build that from scratch, do we?


