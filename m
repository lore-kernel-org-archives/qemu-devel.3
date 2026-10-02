Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15270CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCddp-0000jh-AE; Fri, 02 Oct 2026 09:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCddi-0000jL-JO
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:49:31 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCddg-0006Cf-PR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:49:30 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ac47074e38so18702137b3.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 06:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790948967; cv=none;
 d=google.com; s=arc-20260327;
 b=i6qlA01/1yrdFF3gqoYjwO55JND2Bzp0Mu0o/1emXBneNXwSU011JiilnIkwVbB8sq
 deGTZ74/2atpVH+42cwo1ARcInnMvEvpNeRa55TYrnc+M4vdlEEqmguRTnCclale6CTP
 EemxOHLH0qNTsWtHnikVd74bJ7xJOpXXoSrmzxIL/rW7e9stjypUgGUX+9izjzo6TtOJ
 ZKLRR0fxUuMviITLl78CNkcICi5tc1FVreOUEnLW3o09CD30TsVHF7zHC+fPFqnnPHZi
 crXUxZb5E60/ovHdGpoB7KHPk94bSZGOHt+mGdoC6luWTeXURBvkgX5vULgqD5Tg/CVw
 FZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x2X+obFPc2V25xqyN77/pjNnaBDjuv63J0cbYvPz3i0=;
 fh=HQYgrhqJk+Uxz98jMt+8eyg5RmqkZCrnXHuwlURzlEs=;
 b=JT6SY9uHr0xCTP4Jw5YXgPVFclVDaGVwx70eHwyIsECXj6HEDoHQUp3t5E/Gd+Nb8h
 4AGPyzFvGfprYWhVLiQu7+duvG9a4d6PRrs1eqfBHu3XwkK71G1l3sqxdfG67P18S0cG
 cy+ODpVurllnKdXr5x6oKIXgXNM0rKqlfEjQchU+//VNovVr6jCXXvnesSXICcJ6ziSg
 BmcLgzJUvJpo22wveBe4A2zSZkHn+tv+8Tq0L6YMnVVINs5APtElmhTV6iGCqurG533z
 x946AZ33zipVA9u+g/UkhNFGFNG/sCg3GMmCCOenAR8M88bIpo0y5El7EoqA5nQDFq7J
 NXCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790948967; x=1791553767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x2X+obFPc2V25xqyN77/pjNnaBDjuv63J0cbYvPz3i0=;
 b=TjniPp0071Te8Omc9fcZoSyIeQBT7NCMaqD8s1fr5f1zerqmJ10BpNlX5la2UM6M9g
 ZkNvuGJbPIX2psB12mECyZTivtahoqwrcpA9qEmDWkKZnou56oSt0esRzw8fMkfJf/ex
 3Kc22qIpkCyGJ6oS3euKRKBeUIEaKAR7vfChzBfxCz7Lt3mqVYcmRAETIScf4bSbgprr
 enT3hYR8IdJSO3SZ/wKYUN6ny93XQFqXWiF9bqeXKUdoDp/Jc/IsCxXUhnYEUZ0IHPeV
 Se5LXsndxCfYLxIo/G1bfgP7rhTeXyIzSZQX4GkUTGBQzp+FslUee9zPhB+d8SMXP6cB
 KSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790948967; x=1791553767;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x2X+obFPc2V25xqyN77/pjNnaBDjuv63J0cbYvPz3i0=;
 b=Tmn1kZVJ402VQVk/bFneuhIv750hbDb2nhsaGycUw7knsrG8Fb2W9B8vaZMAPRY65P
 hxTCQsX55AeYUoRiTrzBqx1X1nWioTMXZ/LHqYTsG7UnGmY1hUMh52HMQrHn32gMPAYc
 IrOOf5TLJXeTrjvFBEp7R0EZ0kKE1InNmY2aCZQ2LhDRrtqUaNGezwq1VNerevVR1rpp
 VrCU/jaXx1WPDLpaB2dROsU+LTZeyyJyygaBn3qPR7q+qSXa6BWfiWOqZQFrdIrvFVl/
 W+jVb/5B3IS2TihdBsDt5emiuAiyRoeFW6xMjhmZm3+jKutJOG8VX0GUXVWI8Y4a/Ox4
 RG1g==
X-Gm-Message-State: AFq9FYKs+UJroATy/nZPtbpmFRPl66aswo6nzkeCvBkDNUk7CQ/1ixHs
 tp/mRFKYvmIdTm6XQyFdCuz5LiE5zdxw/4E8BClGhezyI5PmRSUHDL6uB4btf3CZaEapy90veet
 EUcLzQ1+aAderFg6uJlUTcv8f4qtaJMRwjJe9FeBLOA==
X-Gm-Gg: AYBFou0Lz9PTDuN02obqYX7nNZmKfx6XmwcBGlIUoP3053Sv8wfD3W8u9596jkK6BSC
 Z60m/8/5taTk7iQpI4tJSY8F0BiQHW7Q0sF7Mz3qv7zMRJwS+2mUXgI5rpoYfmogp3eIRuHH/DV
 Qy2p4/06bseqDa5bvg1u/tUFumWtlWiCViPQt2DVP6/0qlVEE8dQlZLpbU0zn8XkNzMZJCc6ZCz
 Wr+h+xrac2z/ywLMY8nWf7Wfs/wGOmZfpUHuHMW2G0aHWkMD3T991mwY50UUxceRg05sJrHTaiq
 iZZMmFXxLngr+8As/xO+6ih/c8yHKTRZSd/XKjd4XHp36s3bPp5CEpjpZPV9mqa4GGFq1PumeMN
 3OxEX5HztuTSXb8dlD7B+550iBsy5VQeUkssQNRQ=
X-Received: by 2002:a05:690c:660f:b0:8ac:8a2a:c3ab with SMTP id
 00721157ae682-8ae3aae0e68mr10901747b3.22.1790948967106; Fri, 02 Oct 2026
 06:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
 <20260919085510.3388454-11-manos.pitsidianakis@linaro.org>
In-Reply-To: <20260919085510.3388454-11-manos.pitsidianakis@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2026 14:49:15 +0100
X-Gm-Features: AclHuK8fFTe_3x456r3EmCU2k2yx1nyW1Az14rrb53zkMJ638T-w6ygRPbIHe3w
Message-ID: <CAFEAcA-K7L5NWk0cC9R8yVvojSS6O6Eh+i9KXP8Lijo4Tjnd-Q@mail.gmail.com>
Subject: Re: [PULL v2 10/10] hw/audio/virtio-sound: add missing vmstate fields
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 19 Sept 2026 at 09:56, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
>
> The virtio-sound device is currently not migratable. Add the
> missing VMSTATE fields, enable migration and reconnect the audio
> streams after migration.
>
> The queue_inuse[] array variables mimic the inuse variable in
> struct VirtQueue which is private. They are needed to restart
> the virtio queues after migration.
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> [AM: trivial rebase changes]
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Message-ID: <20260803081159.91981-11-alexander@mihalicyn.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Hi; this change triggered a Coverity nitpick (CID 1687010):

> +static int virtio_snd_post_load(VirtIODevice *vdev)
> +{
> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> +    uint32_t i;
> +
> +    for (i =3D 0; i < s->snd_conf.streams; i++) {
> +        struct VirtIOSoundPCMStream *stream;
> +
> +        stream =3D virtio_snd_pcm_get_stream(s, i);

Here we call virtio_snd_pcm_get_stream(), but we don't check
for a NULL return, unlike the other callsites.

This NULL can't actually happen, because it only occurs for an
out-of-range index, and here our index is by construction
in-bounds. So this is a Coverity false positive.

But I think it would probably be slightly better to follow the
convention that seems to be used in the rest of the file, which
is that virtio_snd_pcm_get_stream() is used when dealing with
stream IDs from the guest that need validation, and for "loop over
all streams" (as we do in virtio_snd_realize(), virtio_snd_unrealize()
and virtio_snd_reset()) we write that like:

    for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
        VirtIOSoundPCMStream *stream =3D &vsnd->streams[i];
        ...
    }

What do you think?

The other option would be to just close the coverity issue
by marking it as a false-positive.

thanks
-- PMM

