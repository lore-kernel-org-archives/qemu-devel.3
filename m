Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480ECC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26fD-0002jv-4E; Thu, 03 Sep 2026 08:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x26fB-0002jR-AE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:35:29 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x26f9-0001oJ-DB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:35:28 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so2714155a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 05:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788438925; cv=none;
 d=google.com; s=arc-20260327;
 b=WbbiTIo3ysQkUgq+Rer2Pf9sYCEhEXPIpK86wP2HQeccRJrMHGWoH6tdJOQJ4LH5M8
 nwemQcWIV4XmXJrQioaXCcB/smzjcK/IdZo7uEL7Q1Z7ioRU8frT1hy3H+TgTc/B/sqS
 1ULaoomxG9ddrQ5tgOkOt5g+6SJOQs6wu6hRpqXOx0NCtGu4J8pWF0GK0TP9fenR5/5i
 aa3LR1bnKK/htzfaQKHm37VlvoFeZV4RQ0Jg8GQTQoT1pLMG6AbkK6lHO4EkhmQenkOe
 V+2m7XnZNXn15B50qUCu+OcaooYb1K/Qrga1Sgk7s62G62y0m2pUbi35En+2WII3IHZu
 v7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=voNoGdHl6Gacsag6Kwq7nxIQkXKzmIzW1SM/gtvuQbc=;
 fh=ovnPkHjTITCxdFWHl/MXToUVszRLaAyFBL1jHXXciHY=;
 b=ZBBZilBqvBxYD5WgvOyeqRE9EHRS6fLoEdtFINuRulXoaGrelIglK5tAMFvF8uXDdW
 OapNPL6F8qVuhet2yBMBqCZ8QaunzzAGy7RF11fVqLpWmRPd7Q7WuLjY9JxgrfXqNidG
 4nU9J8gpVDTU8QWMuLMwCaPOpNwCPZziyUc+YfSsjsQqcYTvHNkJAeHyuVw3A7w/xcDI
 OL6LTKyFMoOP2RlkliTvG3D5uUwyQT6dc02ZoD/Mxx0yU3iZSTE15Pn3xuPHjtasuEtu
 Nc/QIwnWpisqW4P5XB1w2chH/lR8lfGKa6Q2Etq5cNorljKGx2MOuPI6QVdZKQHYcbFA
 cPcA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788438925; x=1789043725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=voNoGdHl6Gacsag6Kwq7nxIQkXKzmIzW1SM/gtvuQbc=;
 b=PsQ85UxItcWQXkhaYiVkTatZNzXyVLDUJYPS4pyOprtkNkkFiKTTfgwgo9lzPw7QzG
 8r7n8lHFqUvwJc/ik6bHYP07nsSLxp+SGftY6MNukftIDF2VFKIVfTR/3ltdybY7JgSV
 ZDnMDhzsxJmY7LAkAr+wwBqrpmSMa7yOSuojRHHs3T/qs6w6fOxCjf+flKobuyRl2seQ
 NpY5LS8sZxmcKYh1dWIqc+Q9q+3td1gdlcfroZkzKnNrJ1iBatBKnXjJIiIi2KePCIXK
 DlCEnZTEj6iMXvR+tTP78KCNX2ulKLaK1lPu5lghomb0JTDwSye3gHN50Y3nwPxZjDd0
 x9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788438925; x=1789043725;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=voNoGdHl6Gacsag6Kwq7nxIQkXKzmIzW1SM/gtvuQbc=;
 b=s0elAKC0YmaeuNTX+iutjyRdGUwTzETPtITtax2yns3zv9Qg5qFAyGkUQTF1kYf4Sj
 TiQGAjuHDqyYrk6x4arB6uHwvbOhpRXEbZleJzK1jEzqDQL4Pny1smLIOzei+Af5zXZx
 YZjdwBG6dT6PCM630EUnG+I8WshYDXDPPgol0Ij7fXzFIeescVmLZSNu08P+TBd69r10
 A5rjQAr9etijk0UN96ukprYkU6xSmVbkSQOZKJJWxWzMKaTo7p5H5KiHqeRA+4uL4PeP
 9RQFxZAu+HbMSypgxvD/R+wbLpZfRUXocGVohjZHTArJLcnfFtxlbjtCWLvVqFy0KX3G
 jc/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+DEanSZOJdqaB5JmPSbccTDp8UW0hVm1ZPL3R+k0nQHKXMQ2v+axaRJglgvp//qJPFTq650WvkFAi@nongnu.org
X-Gm-Message-State: AFuF++kr+bMQfq8m+n+LI9+GR0xaARYM4x8oc6zBVGjPx5lD2Yb/79KZ
 VTgRb94MwgUCdTIkXaNEfJ+BR6tO+gkg+plAz63pXW0xupciTQKpj4plvppSMygKTnPfc/ZQv0b
 y5Wx6Mn/SBUS1Qf91hEkHyXE1XNTe/ag=
X-Gm-Gg: AYBFou2ihS7S6PhZv42VaDvfuxGEGG2Bti1ONdrddTtHIvvFTMZXJfPpUjjkNSCQpMa
 HC2YzZQA5W4dsaO73KH/u3ey1m7Lc9OCPCvxCGjy+jutrA5XJ6OLOcwEdbxfnjKhHqZhv9oBzYq
 woS/0N2KRjkciWB0E1/OIBVtPCqzgcPijLc7LQwZfex5/92/Hg3nVTL88Xe/FsyUPhWK+9DAmmY
 NGv5tK8/6uwiSbzgDRZ519rbXAUeuxfPQ6RD+H744FrQtH7pUIMtdtAcS5Qo7JO4xPYVnxT6guy
 v+1xPjg/cpSw3g8E5B7PLFcaXAdsqvjGcEFe5bne4NSzTohOFMrUCP9OokijNUEBc8e5TcOWvT+
 C
X-Received: by 2002:a17:90b:4d08:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-39aede9344cmr16249420a91.5.1788438925446; Thu, 03 Sep 2026
 05:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260903100441.781277-1-pbonzini@redhat.com>
 <824e8ec3-f45e-475b-8fb4-93f2257d20ea@oss.qualcomm.com>
In-Reply-To: <824e8ec3-f45e-475b-8fb4-93f2257d20ea@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 3 Sep 2026 16:35:13 +0400
X-Gm-Features: AcwNN1XW6p5NfUOlqtDMARxPnQbqHeTriCidFa0njIJXYX4VPuqzD7RSgaQxkrk
Message-ID: <CAJ+F1CKoJVGxnkLAULF5tZkwNvDRtGeDFx+OEW42Bu793KDR=A@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: reject trailers that credit an AI agent
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1033.google.com
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

Hi

On Thu, Sep 3, 2026 at 4:17=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 3/9/26 12:04, Paolo Bonzini wrote:
> > The QEMU community has broad consent to not accept assisted-by and simi=
lar
> > trailers, and much less fake co-authored-bys, independent of any AI pol=
icy.
> > Implement this in checkpatch.pl already, so that there is another way f=
or
> > contributors to discover the AI policy.
> >
> > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   scripts/checkpatch.pl | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 03f35e75012..90cb40dfe1f 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1811,6 +1811,18 @@ sub process {
> >                       }
> >               }
> >
> > +# Reject trailers that credit an AI agent.
> > +             if ($realfile =3D~ /^$/ &&
> > +                 ($line =3D~ /=F0=9F=A4=96/ ||
>
> Few years ago Peter was concerned about using non-ASCII because
> it was not displaying correctly on his terminal:
> https://lore.kernel.org/qemu-devel/CAFEAcA-CJwcE9k+TqQ-vDrevzZPV_+CXAr1j9=
QfR_ivJTJ3e2w@mail.gmail.com/
> (that was using Ubuntu 22.04 which we don't support anymore).
> Should we still worry about non-ASCII in the repository? Having
> a quick look at the OS versions we support it seems all of them
> are ready to handle UTF-8 chars. Anyway I saw various utf-8
> emoji symbols in gitlab issues, and it is likely someone will
> paste one along with the report when filling commit description
> for a fix, so they'll end up displayed in a terminal via git-log.
>


Some projects actually enforce the usage of emoji in commit
messages/titles (Zeeshan's projects, at least). I personally don't
care. It can help, sure, just like icons do. I would much rather have
tags to help classify commits and allow people to display them however
they like, with some tools, though. For that, conventional commits
help somewhat. Just my 2c


--=20
Marc-Andr=C3=A9 Lureau

