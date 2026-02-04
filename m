Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07455E9D408
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnfUR-0002ud-AL; Wed, 04 Feb 2026 11:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vnfUP-0002uH-CG
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:12:25 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vnfUN-00046G-RE
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:12:25 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65808d08423so10350676a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 08:12:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770221541; cv=none;
 d=google.com; s=arc-20240605;
 b=RAhPIwxi/KqRbfem2CpnZ7caaM7wie33oDq+xwCLoFTRcfLFQ4NoVDPGce/acmHoC0
 A8SvK+JqPjtKvCGwOQ+pEmJiKrgzekCR39kIyl4Xt5/ciWgzXBvNVKuR4nDpETxjtHNL
 j6Nqzbog+tcaNPgDiQP4qHKRdeewU4f88tjTG17luOCDAuvfD+7n0Itj4d0CLrplcgXu
 A8iCnvcjYawAeLlBiE0Jm5QdBWZAqq6kEa6Gla8FxFIc/iHDXMX5qIdZ/vF6AtnRkHE2
 MjFyQG4i1eOuwNZ2+ddAzNw9TPhxXKU9SrpmcwDi/j/x9bXL0uR4XWiZ8WVd3Y97JSbl
 9pig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kA3kkGkRy1EoHSUrG2Cy3FfnE3rgBk/8wS8Bi5b9XyE=;
 fh=x5HMi2bFcpW5plFmeTH1wxKaF74BkwSYZQXa5+amB5c=;
 b=CGzllC4/twDD0HXAoU9mLPKIpOFTprfQFsGVU0s2kh0QnMXfw4Iqbxm+sluo6J1K5X
 rDe0XoguaUBRdL9FWSK5hDmz2CyGPBmY9ttjvacFI/B6L6mCeFSVoZvOlhJ+B2RTpafY
 HJ89vUNKjX3nJJxRCNUqy7lXqRVrqTGgN2hJHDX/nfAoqhSvEIXV8MbwnELv4+sBaI4m
 RHqK5dshKYYBsuL/jH4zBh6l703rWYPfMXJpk9X2p1/58S3J5xVBDP45SaDVo38usRYv
 XiOVz40hk+3frN7ATOzoZZPiaA6qa8tvxMrHL1BoslrqQhxQnIDhcWUscJXhmy8IwLNh
 brfQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770221541; x=1770826341; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kA3kkGkRy1EoHSUrG2Cy3FfnE3rgBk/8wS8Bi5b9XyE=;
 b=PrlgpnhGeusEjJ7CSY9NtO3QkfpfiL+iudnpUDR2VjQusO5c/UNlsQa18Jy1Jg6jGU
 G41zxzcuuJExKhoWshwbT6CknjfkOr88t4+xZ6VXkSCRLztQVPldkGxc8HvjTF/VsKfd
 68yyozKfwYNE1r4NJGdAwnXUcCAVQ/OubxtTwwuH8bDRiR23ak8G6jMWZ77sJy/rWv8U
 h+pKqMe46cNAoEEDfy8SJybMJiy8445BJk9wLowTakrPfxswBbtsFI0IiAlMtnmONCGp
 7bKlK3zZ1l05cev2KmcmtHw5WLhJr2Vticmsj+pGLTViAbafE6IxEnz2z3G/LpouQ7c+
 V9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770221541; x=1770826341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kA3kkGkRy1EoHSUrG2Cy3FfnE3rgBk/8wS8Bi5b9XyE=;
 b=MhXE36pFF8D3lLYwg3xEe4CFFwUFrE3tV/opNWL3dVuYYPjO4jTmEIJkwLLPIs8JlI
 H+12MaFCP9tvNtbdWVRYdd0Nh2jF3XK4uNbBUBikm1iJ6PR6Xx4lSa+nay03IJ1ipS9H
 GJA3un7NwYdD+7jerHYiPqv64o+AQNffrNXT/y/dZMzjxcE6/5MaImN16eEt1i0IyiTC
 Pol5vzy7r1EibEcWPSRC1okEuv2KuvxsgvygwuOp+bKv0rIrDdhLC7R2hve99Gd8dq1V
 FZ3VwLBiscjdaVZwd0TCuf8LR0fkO1UYJ7aspuq6PYn7r5VP6FbpmZ2vSEne7Qx0LyQC
 /L6g==
X-Gm-Message-State: AOJu0YzorTMPM4tamCvyMQYyOM/XdLlGN5WFfW0puUAPepidkDxuQ/9p
 LHR9nNhm5a270YVFRJUqJOyKJHo4ITMHdraLk0ZwdMsKcpyncQgrS0iE+MIrU/p1d6bAGWw2j5g
 ssNHl0RUBPIBnUtjxvtQEpT4+rV3QnLM=
X-Gm-Gg: AZuq6aKKwgI58zu9BkVu8FZAA1TPbg/MUphFwehpZfbkJM8dmIWkeuy/ePbNzfWTC0D
 TAckYoYwqx13NslAwRSJotaG8lgCeAwm49JVumKYfQmdvOV0db8PCIlyeUVKCAT9NSEzixhffv/
 swqQ+Y30weQ1oX6iLQ2UjDJcHyP2jTYvfDITZywhw/8E+M7ZCGsaRPceilcm8/3b5oT4iELFvG1
 CohRQmwnRR+F6B03CmVjKhn0geWvdW25Rx459tkhe2+aOFOy9z9i4EbuygQwGpng9s9qQ==
X-Received: by 2002:a05:6402:1ed5:b0:659:408e:b7e6 with SMTP id
 4fb4d7f45d1cf-65949ecd24emr2079778a12.29.1770221541257; Wed, 04 Feb 2026
 08:12:21 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <h4uue2ekbnlh26rylj4ilsqzyxdrfzrq7czleysrkbowlgp4q2@wtbm7zi4kev5>
 <CAJSP0QXu+fmKuOKLw=OXL0GqTQS58pM_-REtnnOCiSaZJp9=LQ@mail.gmail.com>
 <2dzs6ukw6gwndluqlzarsmrueug5t7vtic6toxs74k2zewrzwe@337u533iprja>
In-Reply-To: <2dzs6ukw6gwndluqlzarsmrueug5t7vtic6toxs74k2zewrzwe@337u533iprja>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 4 Feb 2026 11:12:09 -0500
X-Gm-Features: AZwV_Qi34AfCTqThZTWIsGY-3u8Y3efuATqJR74FppYiIUTjW6dmESozfgaiWhg
Message-ID: <CAJSP0QXV5GK=wecHQcdJoa-ORGg6yM0zgeunezW0pPJiXRrqBA@mail.gmail.com>
Subject: Re: COCONUT-SVSM project ideas for GSoC 2026
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Feb 4, 2026 at 8:24=E2=80=AFAM J=C3=B6rg R=C3=B6del <joro@8bytes.or=
g> wrote:
>
> Hi Stefan,
>
> On Thu, Jan 29, 2026 at 09:18:15AM -0500, Stefan Hajnoczi wrote:
> > I think the mentors should provide the extension to the SVSM protocol
> > specification. That way the intern can start the coding period by
> > diving straight into the implementation and there is no risk that the
> > project is held up because the community does not like the design.
>
> Thanks a lot for your feedback. You are right the the project as describe=
d is
> too big for GSoC.
>
> So we settled on defining the protocol on our own before GSoC starts and
> provide it to the student. Updated proposal below:

Excellent! I posted your project description here:
https://wiki.qemu.org/Google_Summer_of_Code_2026#Observability_Support_for_=
COCONUT-SVSM

Please add a link to the protocol by February 19th when accepted
organizations will be announced and interns can begin researching
project ideas.

Thanks,
Stefan

