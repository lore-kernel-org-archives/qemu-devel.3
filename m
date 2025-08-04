Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DDCC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0lY-0005I6-JY; Mon, 04 Aug 2025 15:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uj056-0007cC-NV
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:38:45 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uj054-0000iQ-0z
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:38:44 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7180bb37846so33372417b3.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754332720; x=1754937520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TelzPIIR0uGAyTMRfXmevN7KXZsDtz4mcaw499tzek=;
 b=mqKiud2IRPnj98Wrk5IowGhn6/oy1wmC54jHMA5/wcDFwwMhoA3c2p8oKueY5XE56e
 Azefy6r9V4KVPUCXcpDzi0aylPU1+HfXQYYMF2E3QhCmjQzz886kil75gKsvNtWwMWJU
 mD6hsqPshgHE4crB8Y7KdI/MCf85zg0cMM+wzGBfzaCYw3U6KRw4amRnTFUkMSpYXdjs
 7aJnt0k9AHxNLA+PEdCiyAI8bJ/bXFWOMhuhSEjiDTKV+q93bOwf01NO3D/u8A28pNkH
 wIMHAu9llGhSHSKKKyRPuyMXlNBGUPNOV+xZ6XexgLeOqmphaL2q1DRYKYnnIYR8mtky
 swNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754332720; x=1754937520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8TelzPIIR0uGAyTMRfXmevN7KXZsDtz4mcaw499tzek=;
 b=afXf2EZesgLFWb5NCDjVuoEqbw8atRafxsG9gt6VL/2p64gD8z8BVR5CyFwoaXC2BM
 HQ0/YLJ7VFv7T6cdfPEZqvJacqCV2D00FOar8uHiqvl9Gmk+3fyEEGsimbYsUErqsRE8
 Fz4tIpmhgMhvbIG4BInsikELhURHsN4BLHdGuyjq7jR8IYaYlH8Dx4V1dEWIM8QPOUAB
 tDlus5wAGzoc76+/1dF+bP2N3zcjMH4o8g47PETW0iWhvPu4QsUMz3BwyV8QXFkGyz6Z
 5Rm6vOT5rfJZdiaAZX6kSrQrORXjqDFBgmH8qUExB1l4BvzGMs9tQi/WAaaJI5+s411D
 /bcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLODdnXwgJFul2JwdSxEHbAWq8C29Ww9ni1rnv9KqFLY2TsuXhqoHRLaVhB+1YDMcI71vChzjik87o@nongnu.org
X-Gm-Message-State: AOJu0YwiV1mZ9EqGbwn8Ctw/fsP6hbAscQpGG6j5LZD7hWZpMi/ET8WX
 ICouV+0lL3Bz98d+iWm1w2N2kZxcCyhUfzmCrSk7LZaN8xo/KhcSvicEhDseBegOckOxjc3Zyje
 FZnas+QJ7+l4rNZI2vKdG+7STPlYnJInxwCCEegTT9Q==
X-Gm-Gg: ASbGnctJ73sK1Qp6so4HgNvZdMK/+m1ODhEQED2Wi5dAWS6JlCvrL5TZ4swff1uHsOG
 dKGyRMabQKLeqPkeWq2UEUUReOKuSpiuOFHQJCJT97av5TlcgQ46CCussYRV+pHsKX17cZUoE6u
 LyM1YwYYNB64O1QkFAemDojOIMbdpz2ZpXPc25e+OchJUxnOoO7iE0J9fuIjQmjdG9Tiih2j2Pk
 SXdRqfl
X-Google-Smtp-Source: AGHT+IGC9LNasoDJIVV5QaFqHdbxzsNdf9JdffgfJFpD42WwszXsXWVUi+AkkWOJHZJi6rXXY9Id0XykwA1Jpu3IHXQ=
X-Received: by 2002:a05:690c:110:b0:71a:1e72:84c3 with SMTP id
 00721157ae682-71b7ecda924mr127241487b3.9.1754332720287; Mon, 04 Aug 2025
 11:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-2-vacha.bhavsar@oss.qualcomm.com>
 <875xf36qyk.fsf@draig.linaro.org>
 <CAFEAcA8o4wEHHDXVj0Fcc3i8g+49psY7YSf1AqGiGe9vNuXiQA@mail.gmail.com>
 <87ikj3545v.fsf@draig.linaro.org>
In-Reply-To: <87ikj3545v.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Aug 2025 19:38:28 +0100
X-Gm-Features: Ac12FXwm0pbL-VXCfd3cuR8gqXlvKMN1Z6IooKxLIQsuAJHiPnnx1fxVuCB7r1w
Message-ID: <CAFEAcA-Y7utLb9cciGJOVAPF8Y0W4RxcOLDnNS7ptpHtYVG_EQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/arm: Increase MAX_PACKET_LENGTH for SME ZA
 remote gdb debugging
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 4 Aug 2025 at 19:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Mon, 4 Aug 2025 at 16:34, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >>
> >> Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com> writes:
> >>
> >> > This patch increases the value of the MAX_PACKET_LEGNTH to
> >> > 131100 from 4096 to allow the GDBState.line_buf to be large enough
> >> > to accommodate the full contents of the SME ZA storage when the
> >> > vector length is maximal. This is in preparation for a related
> >> > patch that allows SME register visibility through remote GDB
> >> > debugging.
> >> >
> >> > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> >> > ---
> >> > Changes since v3:
> >> > - this patch was not present in version 3
> >> >
> >> >  gdbstub/internals.h | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> >> > index bf5a5c6302..b58a66c201 100644
> >> > --- a/gdbstub/internals.h
> >> > +++ b/gdbstub/internals.h
> >> > @@ -11,7 +11,7 @@
> >> >
> >> >  #include "exec/cpu-common.h"
> >> >
> >> > -#define MAX_PACKET_LENGTH 4096
> >> > +#define MAX_PACKET_LENGTH 131100
> >>
> >> This is a rather large expansion for something that ends up in a stati=
c at:
> >>
> >>     char line_buf[MAX_PACKET_LENGTH];
> >>
> >> I think maybe its time to get rid of this hardcoded define and make li=
ne_buf a
> >> dynamically re-sizeable buffer along the lines of str_buf and mem_buf.
> >> In fact make it a GString and we can get rid of line_buf_index as well=
.
> >
> > What exactly is the packet/response where MAX_PACKET_LENGTH is
> > causing problems? The commit message doesn't say.
>
> I assume it would be the g/G or p/P packets. The docs don't seem to say
> anything about them splitting them across multiple packets.

Probably because nobody thought about the possibility of enormous
registers. This sounds like something to query with the gdb devs
about what they expect the handling of the SME ZA storage should be.

> > In general I thought the gdbstub protocol was supposed to handle a
> > fixed packet length (e.g. in handle_query_xfer_features() the response
> > packet indicates truncation via "l" vs "m" so the gdb end knows it need=
s
> > to send another request to get the rest of the data). So if we run
> > into something which seems to be fixed by raising MAX_PACKET_LENGTH
> > I would first want to look at whether the underlying problem is
> > that we're not indicating to gdb "this data is incomplete, you'll
> > need to ask for more of it" or something of that nature.
>
> The docs reference "bulk transfers":
>
>   =E2=80=98PacketSize=3Dbytes=E2=80=99
>
>       The remote stub can accept packets up to at least bytes in length.
>       GDB will send packets up to this size for bulk transfers, and will
>       never send larger packets. This is a limit on the data characters
>       in the packet, not including the frame and checksum. There is no
>       trailing NUL byte in a remote protocol packet; if the stub stores
>       packets in a NUL-terminated format, it should allow an extra byte
>       in its buffer for the NUL. If this stub feature is not supported,
>       GDB guesses based on the size of the =E2=80=98g=E2=80=99 packet res=
ponse.

We do advertise this.

-- PMM

