Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD4ACA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeP2-00064T-Oe; Fri, 02 Oct 2026 10:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCeOv-00062C-Fb
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:38:18 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCeOu-0002wb-0E
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:38:17 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ac4967f1c9so33301947b3.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 07:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790951894; cv=none;
 d=google.com; s=arc-20260327;
 b=Ee8h9KY1bzFamZLDZOfWGMFY7y+goyszZqeAK3ReGtmwwfY5JO6vuHtc2MjhaF4WyV
 tJQbFN33//9b9AXC5FgR6NYe1L1XT3uNS6vChbSla77sfgmSVaIG746EHsLC3l6J9FnB
 BgV+8IsS/M5789TltTFgIdO8WRjtwujmhDuTUUBfzzaanm+L13GuWRHjKfN0ZElvkwMw
 DvBLRIVRLLVig+FMhMZH7dOU05DR5nDcCs7yfcl+GBoiLhKDPxKyySO8UCx89V1b6uWl
 Iyau7xo7GworFLU7NrliYKgIRN20Fylu9ej8j3EA90YGRQoWk7RXYU9ZbgpsDZaxQD0h
 C4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/Ni7h1HvRIj85bwqLGcPfZ4eX8EkSqi8uCorPtNtrnc=;
 fh=tNOmbw+NM37rz3VUVErnRJ68Xx8SSOnONFGjeyr03MQ=;
 b=TRflWC1YaE0DK4jkWBmhg2wvGYll3NH3lJ7SbQmtrUW6C8ZlpDwiXknA6VQPW5B7KX
 bVoagOEomV5dgzPxNxq0MWeXYVR6EyUqoKJmPX3O0gmuzDDXoyjlqORmrezIO5h3XENV
 bWXDd2lhWEvXya0EbKwk/oiW5jvuXeGq1DpVEjih+Ljh5LzuGomgiVS9vmOqus5eH/hh
 Q2ge1cf4poZeNb0GaFXZ+HaH9MF+86+s18nG+ZcaUk9yXgOgt4Q+phz4R6bJluCQZ9oR
 AiuR/P5LapTPcLsyTNWSHFJC4Um1CF5ZvrLDM8GeIQFTz7zBPG/t4qJ7tZ7HuUwfiEmC
 GxnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790951894; x=1791556694; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/Ni7h1HvRIj85bwqLGcPfZ4eX8EkSqi8uCorPtNtrnc=;
 b=FaQqGGbyiftWOubh1lYTUJgUBXXGR24EH6nAaqAkeUgRt+b9R/yZpXNT3PBCjJSrQm
 j0z6HfUfBpczIRYlseGL/MDXtNTPsdndDkLseq5IfEFG0nePdM6SKZXDygsZNWFnGhvh
 UZyqnrW9HvqUogYH2+fTN1nlbF8xFMyGZq/ucKGjo5rEAYHZkqvCXvVNFDLt+CsvruBw
 iGwrVkmCzExgoV5UGkO1OqnSB5DoKT1Ec2wKh6epOrBfTJuys5iwateXCZa67xeK76kD
 f3kxTK0A/ym2NK1e5rrhSO2Q6o3+xGR5d5u3Zth68t6MlfBg5flWDsdzYPJk0Pp5OqU+
 OG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790951894; x=1791556694;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/Ni7h1HvRIj85bwqLGcPfZ4eX8EkSqi8uCorPtNtrnc=;
 b=X1lG36k9N86iiZD24vipMt02X8cdQF4WyFMHsoQx/PJz/VU+4CY8+uocRZmivT6Yjd
 rXpgG+vJ+Ej3gYKRPv7A9pl8CXNiPdb2IaKyA4FLFGSTIwcK3FChCXvWLw+4iOfeRA1X
 sph0myU+3+HfODP+jwvC1XUxqCAMkkXYBR1Bge5NQH4txgzwLqADy5G0WeUo+NsvhqdO
 2B9gwCITcbvq7P88g9xDXCn2klF6OYxYAjdl4+k1umtdniJ0b3fSY9Xh/AF0zXBu6h+P
 LNfTr6BV+M2EPlekZn0mUyHbWkTTcyTko4HGG5mup9Io/fw4cZEkfjCSIB8tGmlr4okx
 SK2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnPPj7awgJqIzeaTFsrxKKlubX/XrVhacP6fGzKecm84Rv0eQ2IWJC2S6fJzPD+BXnQsmk/X7mrbWw@nongnu.org
X-Gm-Message-State: AFq9FYJsJq48nlxY77jwDTSoSTCB7zmdnMq9mVSrfV6GzAK8jFTsnnud
 DDlY4l17il+o8r4/WpQotjXIkSe1b7/NYAzi2hWuSBBn5WQQHawJ28kda34Sl7fHQRiAaLREaoa
 JSMaRyrxfUIWdsLn1IU5mb3wVhwJsLP04nm52cQasRQ==
X-Gm-Gg: AYBFou1Aw0xx05XYR++X5iAlHdjpudJN3WLRKrj5Zd3ZxVuOk9FclJhPMLsFBP9CNYy
 vxT8214Y07f3AL/QCRIg8nBkK8mqdIuaS08NGkFt1+NDtIJzkRqIiv9+cgXEL/b9DcyyvxgkjrK
 nIzSIvpf0wHLs/sP6puQcaVMl/mZtQwdwDG92UdIpxXwBwWzypRGrroLtKWtyqD7bQfZXfoTrup
 ianq6ergIo334qV9XrAKV9f8kdz+DkegxyK+vWt4Q0lIRaTA9rHPFbgXDxRxNfCv0QbC3Y6oNMz
 Hhgvu5uT6bIqCKigDH2DRHdUnvGamcXjRK3r1Uo7Mj+kNJpL4LHweMPV6hkxb+CTq3PnwacJlzR
 EZgwifvroxF6K4Oxd3WHLb5pKjthVlyO3w8Dt+hE=
X-Received: by 2002:a05:690c:c6c5:b0:8a8:7fda:15fc with SMTP id
 00721157ae682-8ae3afdaeaemr8950567b3.79.1790951894454; Fri, 02 Oct 2026
 07:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
 <20260919085510.3388454-11-manos.pitsidianakis@linaro.org>
 <CAFEAcA-K7L5NWk0cC9R8yVvojSS6O6Eh+i9KXP8Lijo4Tjnd-Q@mail.gmail.com>
 <c58c324d1ce1f095c0036c43691d61d9dcac6f1d.camel@mihalicyn.com>
In-Reply-To: <c58c324d1ce1f095c0036c43691d61d9dcac6f1d.camel@mihalicyn.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2026 15:38:02 +0100
X-Gm-Features: AclHuK-USmvAVMxQzUyl86qLnunOQASjJHpksz59K6dNXS1FelpVH-fXTNc8Qis
Message-ID: <CAFEAcA-J9R2ZOSR+Y=5xOidR6fZq2Y9Z6f9MZoSxgRK0iNTzhA@mail.gmail.com>
Subject: Re: [PULL v2 10/10] hw/audio/virtio-sound: add missing vmstate fields
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 aleksandr.mikhalitsyn@futurfusion.io, 
 qemu-devel@nongnu.org, =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 2 Oct 2026 at 15:07, Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> On Fri, 2026-10-02 at 14:49 +0100, Peter Maydell wrote:
> > Here we call virtio_snd_pcm_get_stream(), but we don't check
> > for a NULL return, unlike the other callsites.
> >
> > This NULL can't actually happen, because it only occurs for an
> > out-of-range index, and here our index is by construction
> > in-bounds. So this is a Coverity false positive.
>
> yes, I did know about this, but haven't expected Coverity to overreact here,
> cause I specifically checked that NULL pointer dereference is not possible.
>
> My fault, sorry :-(

No worries -- the coverity scan only runs on head-of-git and it's
hard to tell what it's going to complain about in advance (and it
has plenty of false-positive reports on perfectly good code).

> > But I think it would probably be slightly better to follow the
> > convention that seems to be used in the rest of the file, which
> > is that virtio_snd_pcm_get_stream() is used when dealing with
> > stream IDs from the guest that need validation, and for "loop over
> > all streams" (as we do in virtio_snd_realize(), virtio_snd_unrealize()
> > and virtio_snd_reset()) we write that like:
> >
> >     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
> >         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
> >         ...
> >     }
> >
> > What do you think?
>
> I'm happy to submit a patch for this if you and Manos don't mind.

That would be great.

thanks
-- PMM

