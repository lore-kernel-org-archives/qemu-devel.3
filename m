Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6B3C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1virpv-00037q-Jc; Thu, 22 Jan 2026 05:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1virpt-00036e-OK
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:22:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1virpr-0000wI-Ry
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769077362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezjGRqnwh8UBX/MyJADTM84jfekKwYTF3SiVD/emT8s=;
 b=Uuvxs9DUghnR2wU6gywLkwfSc+YkURpXj7+2rCqhgtTYTntaHuWYR8LMejFboTtsYQQVEs
 wFJONRb4XiU/huEPL+qG4yn1SfpsZTE+Tv7MVxQRZ8yNzuR4MrO4nVJlyiuYIFr7LKx/WF
 DcK+mxDMEFaSfxxE/RrCBiysMq98h6U=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-bLC5z0oIN0u5fxIszyHb1g-1; Thu, 22 Jan 2026 05:22:40 -0500
X-MC-Unique: bLC5z0oIN0u5fxIszyHb1g-1
X-Mimecast-MFC-AGG-ID: bLC5z0oIN0u5fxIszyHb1g_1769077360
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c617e59845dso507645a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 02:22:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769077360; cv=none;
 d=google.com; s=arc-20240605;
 b=ddZFBRhGfdCrtKMaTHHFvhvl6KkJpTJkKJXJv0wg4+I8dEFUNVnCVnkXWbHdGAltqe
 faqyfCncMCRBCLks6v1vQTSfm0VAfylp6HkKDaF1Z3jvmVig1BZ7bdk/aIl0UrBUYpiQ
 hZJfWy7710IP8Zc4M0MFwZTQWnNY8HHRodAWVn7tPBQzLuSZLSOTn6Ot6v2vhvP0238W
 2NhWKBdQiW34Q7fLFClS+SHgbj6/OBFNbgN70WuYHdK6XymCHWqtvVgATRi3gtVtCrn0
 bQFTCdhqVTzS1EnS7iBqQjLuCVS2xAJSjKntDJT8Ml2eZkzRZMN/krX87NJH9bYVvfJL
 IHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ezjGRqnwh8UBX/MyJADTM84jfekKwYTF3SiVD/emT8s=;
 fh=OCpsmp602vbHAupKnujCex6Dt2ggq+uQd8F1QCdSeDs=;
 b=EUsnPk1ok4ZJjb2Vld6UhCDWXPexpUjvB546V775+pV+qhqYB6TVSnvOGIq+PEsBNm
 2tnc0vCLbvdIi8S2dAbA3XBjtk5rnH3JuWJoUoQZ4uxAuKBhZbwTj8IFmZ3j/ZvfLMQO
 yrZhUtMfX78wKjRnQtupOyY+2ZiXZKtyCfU4eWGZtNW2GBCq26/FJP/keZKBMh4WZ0De
 x7DUw06E1aGLsI4Dhwa6d5SxkcM3dDmScelBRg+ZXPBY6vzfBntH0Wr64Y5ngNlpBUQ1
 reLoGHJ8WNcmCOm6/25zxCIaXOGiJrxLibXP7mFR9dQj2IhuMlxubvqgErfnLNkLJWF8
 KAgw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769077360; x=1769682160; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezjGRqnwh8UBX/MyJADTM84jfekKwYTF3SiVD/emT8s=;
 b=mI8fPzo7qoNEiEcHZIYu9LcQGl18JO3MQwqTF2mMfqS/4o9sLiLi41K7OWsD1zgu84
 rg/8/LHowl5DQ/nidTXiKhXJVDd3XUUqmYSiRsCbZlQnZ5JK4JOVyZ6qu92L4Sx6hV9k
 l6ppYJHJ/yN6wPPz6P5WF0xvUIetz+vZu/o6yyUfHj51zqEYBdSLfKVrb+oz9AeELaHM
 GYNY2cL7sIHosBgwSxJCLtRboOriJm9h39cnaAkD2Lcbwmt6c58bejhhoZSrV6lrDr/Z
 guEgjjFzx9KNY54f69+ECcmOAEKx+ygbj9N/0DuM/QAZFB16lF9gZH6YTxJFNc909/hy
 h4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769077360; x=1769682160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ezjGRqnwh8UBX/MyJADTM84jfekKwYTF3SiVD/emT8s=;
 b=mn96+10Gv+cInv4fYpl2OsRaQA2AyMU8F77iP1OgS9Kn/8jCgocdXzdNdoA3AslIei
 av9dT/rUsCAbbvYTort3ajyLWu9o2bqP4CN1nMJEg/jsFFFUr2232Z3J6aC6rA0utyy9
 iCJYArPHIYhH5lqMk+KzbUiw+uqmrTsTmYCYu/ERdCTACYYS94+dhak1EFfswgkGJI0g
 Z7+rh090fvyEcJeGmGd3TTvRLpjc1KSkbLpLu0B7N1tISnLPp/8ttOfJ5SlP4zJQeAx1
 7iEdejnzUj5W3MHxD+/dmHMQ1Ufu0gSrGfiyILM97H4Mv9EMayazgfJoP8Rvtm+FUXA+
 ospQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFfDbjWEjVIrBlrMbW17Tu2XHeIckzzHYtEkyDS4ZpXypz0dsV3NRm1JBuP9dqozKLcWdsBTBmNZ0t@nongnu.org
X-Gm-Message-State: AOJu0Yw1mhUC2t4gd6Evr6f8WRi2PgEZXWspmqAdT7zOzRdW3r1TqpHf
 u4ePbad/iH+MpZgM2ZshhSq+B8cx8NDpJ2AleBSUXlrM7A7kF6Tjq9kahIBGYKxqzkvOeNYnUSF
 LIvl8wWqcDa6rhIKUgXeOKEvRd878/sp3N5mktOuDSKE25YLGUGnGhjB6MjTA0zfDjpUlvUqxDR
 ccY5KImL+FWfKeUhk71MaSXoBlzuTyhnM=
X-Gm-Gg: AZuq6aIb+cy7VSaG2AEPMEeq+skIJjOZTXIz9Pm+BkqmygGwD0jcwIgxRAUr2TyhqP4
 eEliFF6h/q/azY1B/M+OsN7S882zuoSs51aMCj4eGF196ws08HRB+XxOVpWZIPvx4qIEmfZ6cen
 Q14bN7FgA9p+7eoIgG4RSHZ8tdSdMcJmgIK17SgntpruRtu+PuH/wXGMZNAu7fbLnB3JYu4hLcX
 vjD/JyUmJ2Sskg85/If47f9mg==
X-Received: by 2002:a05:6a20:258d:b0:38d:f8e6:fc9c with SMTP id
 adf61e73a8af0-38e45e74cc0mr8748304637.69.1769077359837; 
 Thu, 22 Jan 2026 02:22:39 -0800 (PST)
X-Received: by 2002:a05:6a20:258d:b0:38d:f8e6:fc9c with SMTP id
 adf61e73a8af0-38e45e74cc0mr8748267637.69.1769077359366; Thu, 22 Jan 2026
 02:22:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
In-Reply-To: <aXH4PpkC4AtccsOE@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jan 2026 14:22:28 +0400
X-Gm-Features: AZwV_QgYEFY_8Rekw5y_i2n3QwOvUQb0Z0m14eEZj4MAt05iu2O89z-ReaZSpP0
Message-ID: <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Jan 22, 2026 at 2:14=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
> > Hi Marc-Andr=C3=A9,
> > I haven't seen discussion about the project ideas you posted, so I'll
> > try to kick it off here for the mkosi idea here.
> >
> > Thomas: Would you like to co-mentor the following project with
> > Marc-Andr=C3=A9? Also, do you have any concerns about the project idea =
from
> > the maintainer perspective?
> >
> > =3D=3D=3D Reproducible Test Image Building with mkosi =3D=3D=3D
>
> > This project proposes using mkosi to build minimal, reproducible test
> > images directly from distribution packages. mkosi is a tool for
> > building clean OS images from distribution packages, with excellent
> > support for Fedora and other distributions. It should be able to
> > produces deterministic outputs.
>
> Aside from what I mentioned already, the other issue I anticipate
> with mkosi is the mismatch between what hardware QEMU needs to be
> able to cover, vs what hardware the distros actually support.
>
> Fedora in particular is pretty narrow in its coverage. Debian is
> considerably broader.
>
> Neither will support all the QEMU targets, let alone all the
> machine types within the target.


That's right, the goal here is not to cover all possible images though.

I picked Fedora here as an example, because it is the best supported
distribution in mkosi.


>
>
> While there is value in testing a full blown OS image, IMHO,
> for most of what we need it is considerable overkill, and
> thus makes functional tests slower than they would otherwise
> need to be.

mkosi can produce initrd images, which can be small enough and
customizable. Although I lack the details of what is possible, this is
part of the project research.

Imho, building all images from scratch cannot be sustainable.


