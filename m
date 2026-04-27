Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D9BFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHNj-0002iS-8z; Mon, 27 Apr 2026 04:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHHNh-0002iK-T9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:31:53 -0400
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHHNf-0004PW-3L
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:31:52 -0400
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso10204403c88.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777278709; cv=none;
 d=google.com; s=arc-20240605;
 b=NRPspEr0C+nelTcDll6jyEF5zSa+XHVDcaNUXLgl8sO4k0iJgALk4yFwb9I6g9YzQ9
 8P43wGU6PrTj/H6/YCiDoXNhFEKbjrNufn2tcWbyZbvFvVPp/rRT+63udPABOmBwLcOf
 FZZuy4AQ+gmcpBiNKn4iD8dSKi5lFYYKdCMMC5KqvGRePty8j0rAj2gtVi636sK/5GNT
 ZoENZiIm5+sWK43FKURjtKjf0KPcAjbKcfV8X3XbWg+CJLu5uqi+Fc2TM9pA9lBUp1Eo
 2LmJXo+UppUHijOVT1g4z/qRxo9MhebsuF3bI11CryNpXShVe24UwBbdeHUPop4BcIoL
 tjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Th+ZO+C4pom2CmQQJGeP1pRHoBCQ19IM9E05+DN20KA=;
 fh=upG203HKhUo4xMbdEezSwkWlp/4p7ubEgvHoIp2z/2k=;
 b=Krl+RRkrh8kfYDYIOQWpUYV6mWO0jsZfwIFZAPjQZ+KTZWgbpkIkX3hKIaD9Kdojw4
 9TXziU8ANOz/OvG/hyRlm7kMlqk+TPXZn5B9H0FcqbkEW2TVzwpmrPSKKS3eCU8HZu5h
 wP1FmuRFPawoSaw+6xJdeRIAXRbkYE1RQxsM1l1QH6R3oYw/A0UlQan4VTqAdHw3PMBY
 D0I/jFf3ilxYKlPeKMuU6FVXpE0Q1LlASTMax/4vvv8+t6is1amjo1PC3WxyyjsDUjGI
 6NXtNfbuRAkxQ4uWyfqJP2EM1Pbq77xIB3KRFw0f6QFnjxx3FJhA1xNgQT95xL1w3mxN
 /WzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777278709; x=1777883509; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Th+ZO+C4pom2CmQQJGeP1pRHoBCQ19IM9E05+DN20KA=;
 b=G7jnllBnobrq0MgIvDNScMO8r8jKixvD9Cam1+9fFKBnWUkeqhtfsRAglihWlX69Q+
 f0wyZK10qf6ndRqbNLUvDWPPFrqAmNCnYnE/RbPL2uZ4+dxbSHJMTznth0b9CCu4vTEp
 UJJVrjdYtKxJtzFfvncb0hfLsEj417N2+hBGKgwdAQ6aObsfL26UNI66aF48x04jCHHd
 PjR68phtugVbnDJj7MoSybFOo1UMqTpKxETvRYAksKuNc5uJIKF7WxMRWAN7evSI46Iw
 P6g0t+DKXwVnu0Z4uzfVdQDQzVJHhAj2mwdquonE2R14kB48iZI39qPBazmQws6Wurn2
 jd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777278709; x=1777883509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Th+ZO+C4pom2CmQQJGeP1pRHoBCQ19IM9E05+DN20KA=;
 b=jkfR8yODGBcLXjh4gb+AATHgiKWuVkLuCEKKcvEwYfrpdolTZXk5f2n0saYRbHXPzB
 SGaPTedY8jqJhULN06RCrJ1iPYTyB2a8EEwKGhGQ1WIAKYsyNtQ/6dOQePAWISgoocE4
 ri3kQ3monEYYD1F3yDDgdp9bOJnyanBJLAKYL85kTYdj2dzlrHWJRZot8amkeRyikPCw
 FrrrG3XPv1d6qC5zDtiD2Ze/spTiWDT43YxT+6c/HGRwZBfuauWK6qruEo6tHWGtA2zl
 QgfpuRp7AeQZko+cbQaVP0QS17LS20r4sJ8ckYZRR2gogFz0E4vqCysQA14rbLQlJh6v
 JdSA==
X-Gm-Message-State: AOJu0YySy6ln1AlVkOUNEDEgtgbDsxUd1929KMFa1LHE2kuzVq7+Gn6q
 nO+yYKu8tpQzfQQM9239YllqXJuk9WAN+libVbM8JbhX0n2xKmf/0mTBynDRz93iYkEigmlcqtu
 Sc4kBWKemSq8EnmhmjszfIb0cSbMnGog=
X-Gm-Gg: AeBDietXiZISsYTiMwAqhVA9WPjkMgB5YepX6X1eC1zWYbeFqs+gcX9yV+xeEDBHcKR
 v1sbvZsokzXP7KahnSxWbe/okeRTOcRsK1OiYUeFaYXwITehYlCcYNyB2LBCji5OVXAMLsPGrJY
 xYfuBZN60LtudwRmXC78sEfELMtKPWKlk0Dnxt1T/2PorJX/3jb6FyZe1ebU5t6zsv45/8A/CAS
 wa835xi1WvgBBjD5yzJ9QHdJ8cI2hbZj9psHMc+yJPJn+0WWd8vq0D7qt2SXnICGlk6sFlhZDYa
 N7xEG9pXaqRQ3JNi1OSpi03xaUvhJRJixH7dlA8MBJXRSvR5dIA=
X-Received: by 2002:a05:7300:324b:b0:2ea:ed3d:94f3 with SMTP id
 5a478bee46e88-2eaed3d9892mr4502998eec.1.1777278709214; Mon, 27 Apr 2026
 01:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-audio-v1-0-e1d6b65c76f9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260423-audio-v1-0-e1d6b65c76f9@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 12:31:37 +0400
X-Gm-Features: AVHnY4Ig3s0CBd6lQu3IFX6-sNlGKA93Pi-3lH6drCrZhUA0Tq26KYoUfJQgk40
Message-ID: <CAJ+F1CKPUv+tg6=1XcW3U=33WrxkPgCOs=EVjMiK4JoHsqDmBA@mail.gmail.com>
Subject: Re: [PATCH 0/3] audio: Fix unsigned PCM conversion edge cases
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x1236.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 23, 2026 at 6:00=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Building QEMU with recent Clang from Xcode reports warnings in the
> unsigned 32-bit PCM clipping helper. The warning points at a real
> conversion issue: the current code mixes unsigned arithmetic,
> floating-point rounding, and the wrong midpoint for unsigned PCM
> samples.
>
> Unsigned PCM uses a bias at the upper middle value of the sample range,
> such as 0x80, 0x8000, or 0x80000000. The existing HALF value names the
> lower middle value instead. Around that boundary, the conversion code
> can also wrap before promotion, and the uint32_t clipping helper can
> compute a value one past the representable range.
>
> Fix the unsigned conversion paths by:
>
> - converting before subtracting the bias, so samples below the midpoint
>   do not wrap;
> - clamping the floating-point clipping result to the integer endpoint;
> - replacing HALF with an explicit BIAS value matching unsigned PCM.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Akihiko Odaki (3):
>       audio: Avoid unsigned sample wraparound
>       audio: Clamp unsigned sample conversion
>       audio: Use unsigned PCM bias
>
>  audio/mixeng_template.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> ---
> base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
> change-id: 20260423-audio-464e1e90304e
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>

