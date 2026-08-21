Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6082BC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKlY-0003id-IK; Fri, 21 Aug 2026 04:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxKlQ-0003i9-8D
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:38:13 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxKlO-000883-O7
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:38:12 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66b35d2c4edso989045d50.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787301489; cv=none;
 d=google.com; s=arc-20260327;
 b=dYUDPVa6zZ0YEBxODYm7A6aUjqjP8ToFIvVMWjL/7msGyLalh0Um5MRbeVWBkETu1M
 rT2TsB3zNnZ4m8oCKG+gJnEkZwMi21Nmn15j5o1bV9jLcIXA+x5WWI+g42kzZpBJM2iz
 S9M3I7ZEPDFsan3KqU14Wy2+A0yzLhSxAKrY4zY/q3lOciE6WXBoon0/0WgOZ2vHZbaS
 M9pszGsUauFoEvNJlTfnWNdqgVmTwIc86io3YtBlkfPAl8VoDKy6GvKWuvRLu522NMBS
 g5VA9FiYj4D5zBH3diMaMMHUToJur4I3ijB+D4T38vZLAC8wR9EzWfHMMvayLfIm0ve0
 vSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=driJv/iU1TGZAuFqXjz6qvmHy4wstCWvAUdKjcx/EAc=;
 fh=osPlDEuSIy+K3j6rh5uGQ65PTsUPiLv7sxj6YnLhFR4=;
 b=aMrE2kFHfadxy4xLUkg/plz79SdYU+6U3z72YkciXeB/N1PemqoOyI6VAnRfG5mLfv
 HJdPwBL3mTerUXK/EWDX6MoE2MATEEk5Krpad+G3lZ3vNTQp5D/WrYxI3zyPlHh6ABAw
 YwPQF8YinEscYh+kWCC/09BrBw2ZqordkV2zD1UlK7ZB77LYjwklhQgNqE8bFVRm9GDl
 VbgLRqy1QOLlmkbey61+zLxlBkaLIuwSZ+lRmIBWbouZlKskTQMZKSTCShIkqFtVArwt
 sRtDVo5GCkPuHjYxp+pA9QXNXZWLhkE152LHm7pqAs8hrkRW8GCGYHo2U3oVZ0AhM0in
 PfxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787301489; x=1787906289; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=driJv/iU1TGZAuFqXjz6qvmHy4wstCWvAUdKjcx/EAc=;
 b=ln76Wsxsxv58B6HPyrisEgFQYplooGOyUBRFaj/M3jDMtVxMo5hxc3Zrweu8XB5TS1
 EZdIV8VirxZ3KAZ6PJ8qcq8qz88JI71aLqKjzHFbSmuhfJoyfyMHw0j0hSj+MI66EX6Z
 GVge0vYrDXdWlCg4nfuFW7RCESzUU1/9C5Ks9DGzw8CUPCFzQBeu9Xxv43Lc5LDi4VZa
 tVdrlEmNlg3fzjkEAmODv1Xpk7LkkQRo+UKbrJ/jZwjbRKg1Ia2/zRtbxyB5d2rkAbsU
 /Ea9JfHZRr9rEkbW0Edm5gclnw/qSagjwWm6I4Z5VKJ+i7FTX6gIHUgn5z2tOnWHugVV
 1Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301489; x=1787906289;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=driJv/iU1TGZAuFqXjz6qvmHy4wstCWvAUdKjcx/EAc=;
 b=fTPDaZfAoeyGKQYO9AWLOSjeWYbf+g3VITbQ16QhzWi0Zysd9mMJxBnItHsh4Wl+wX
 RC2CRtHrFqeBz+xAXyz1GLzbYBzpiBl2mpvhcEjb140EWg9MLVNTlwoAkaxh5jMf1ktz
 RRTod0Lzk3y3BEdSsFZWvYT/LSnbGMCp+iZ1k8o7GFvsLhfGT+/HxahmOEd5TY6sgtiM
 V8cgVXSAUd3rg4Jvipf5c4lkbjmIL9Vbng5LpkwGP2Az9KpJ40vozCQHLEjuMOA6XHnM
 hEuVd1JS2Wes1DKrdnHucEp+oZPoBMYJl5CYEufqro1FIW6klfzyOweN6iQYXsOLdRST
 h5nw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpM8nhiVyoXT9RN37QAvOPNelYC/n3n9wxKHS9gt/MqV6njpRMmbtQdyKFem0i8+V3oWKaxvU+YFg4k@nongnu.org
X-Gm-Message-State: AFuF++lgOsNkKIRckGIW4cavM/VeSd9lUJpfIDxdrCvD4OjkJrIqCye9
 jDxZRkClzV3ReZyqt2by8YFGPo2afztzydwzsrXvfDbZnw+FbV5O4pZDx5CqiVpK+qvmreopbAA
 DlJBDaXgSWEjMoh3ZycxeT5qpsejynisVL72j67AIJg==
X-Gm-Gg: AR+sD13ameJLYMAHK2YdsL09JV8V2/9FgllcwfiAxVymGQoS+VULOpqoyQqUQ/WOayd
 d/QmkXOhxTlPgso6SW+YJHGAkN8jIX0Pja/I3+1SV+0eQ3wQHQPVJLIdFHC4DEGg2JgRelVCRKq
 AAmUO9j2jeCQ1aIBjwy7/rd2oXYzTPPgKvLAbxdUToWbJEan2nDfZDEPmKN3XqsIWck4a4mc6PL
 sBR9umq5ZWajtpVbgpIpJCUq2t99yPY897PfSjlv1Iy/8ctg4aH4XcCg9mwz2IEgYvO8GH4y5I5
 e0YiN46YTf4Ydp4/Dcg+jmJkg91am8piLXARGLtXI0NhR5i9xjlFu9nnzGbKZvEsHS3KJXrbw86
 8B+sdNUN5ZCQWV6upAJMPsYiuVdWd
X-Received: by 2002:a53:d7c5:0:b0:667:cf87:5838 with SMTP id
 956f58d0204a3-66ce4b65f65mr1559505d50.25.1787301489312; Fri, 21 Aug 2026
 01:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260819185430.3467629-1-peter.maydell@linaro.org>
 <20260819185430.3467629-5-peter.maydell@linaro.org>
 <6a3faf4b-2b03-48ce-aa85-0406e0ec4b67@oss.qualcomm.com>
In-Reply-To: <6a3faf4b-2b03-48ce-aa85-0406e0ec4b67@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2026 09:37:57 +0100
X-Gm-Features: AcwNN1VjM-xDsL_X43BT7HBtEpmMLE4QIyuFuVa3KTGXcl5E4BzjUHYsS8tZibA
Message-ID: <CAFEAcA_q3joQUYfDjvti8MGTm0Hbpzg6dPjF6Z2wuK_P9gBBNA@mail.gmail.com>
Subject: Re: [PATCH 4/5] hw: Remove Marvell 88W8618 devices
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Jan Kiszka <jan.kiszka@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 20 Aug 2026 at 11:59, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 19/8/26 20:54, Peter Maydell wrote:
> > The mv88w8618 ethernet and audio devices were used only by the
> > now-removed musicpal machine, so can also be deleted.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/arm/Kconfig                 |   3 -
> >   hw/audio/marvell_88w8618.c     | 315 --------------------------
> >   hw/audio/meson.build           |   1 -
> >   hw/net/meson.build             |   1 -
> >   hw/net/mv88w8618_eth.c         | 403 --------------------------------=
-
> >   include/hw/net/mv88w8618_eth.h |  13 --
> >   6 files changed, 736 deletions(-)
> >   delete mode 100644 hw/audio/marvell_88w8618.c
> >   delete mode 100644 hw/net/mv88w8618_eth.c
> >   delete mode 100644 include/hw/net/mv88w8618_eth.h
>
>
> > -static void mv88w8618_audio_callback(void *opaque, int free_out, int f=
ree_in)
> > -{
> > -    mv88w8618_audio_state *s =3D opaque;
> > -    int16_t *codec_buffer;
> > -    QEMU_UNINITIALIZED int8_t buf[4096];
> > -    int8_t *mem_buffer;
> > -    int pos, block_size;
> > -
> > -    if (!(s->playback_mode & MP_AUDIO_PLAYBACK_EN)) {
> > -        return;
> > -    }
> > -    if (s->playback_mode & MP_AUDIO_16BIT_SAMPLE) {
> > -        free_out <<=3D 1;
> > -    }
> > -    if (!(s->playback_mode & MP_AUDIO_MONO)) {
> > -        free_out <<=3D 1;
> > -    }
> > -    block_size =3D s->threshold / 2;
> > -    if (free_out - s->last_free < block_size) {
> > -        return;
> > -    }
> > -    if (block_size > 4096) {
> > -        return;
> > -    }
> > -    physical_memory_read(s->target_buffer + s->play_pos, buf, block_si=
ze);
> > -    mem_buffer =3D buf;
> > -    if (s->playback_mode & MP_AUDIO_16BIT_SAMPLE) {
> > -        if (s->playback_mode & MP_AUDIO_MONO) {
> > -            codec_buffer =3D wm8750_dac_buffer(s->wm, block_size >> 1)=
;
> > -            for (pos =3D 0; pos < block_size; pos +=3D 2) {
> > -                *codec_buffer++ =3D *(int16_t *)mem_buffer;
> > -                *codec_buffer++ =3D *(int16_t *)mem_buffer;
>
> There seems to be an endianness bug here.

Not that it matters, since the code is being deleted, but I don't
think there is. In guest memory the sample data is 16-bit little
endian values; in this code path we copy it directly into the
DAC buffer. The wm8750 code then copies from the DAC buffer to
the audio backend, and it has created the backend with formats
with big_endian =3D=3D false. This matches up with the 8-bit-sample
codepaths in this function, where because we calculate a
(host-order) 16-bit sample value from the guest's 8-bit sample
we need to use cpu_to_le16() to write the LE16 data into the DAC
buffer.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

thanks
-- PMM

