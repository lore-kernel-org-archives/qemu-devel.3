Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726CFCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 06:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZN4k-0004Wx-FY; Tue, 16 Jun 2026 02:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZN4b-0004T0-Mi
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:14:58 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZN4Z-0006xj-Fz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:14:57 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66077f6c438so4066933d50.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 23:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781590494; cv=none;
 d=google.com; s=arc-20240605;
 b=LUcDJsC5JT6LAEEZ0gGo8gjefrJRlABetjy+KHoSPgBIJQS4wyXUOgJlBoju6hSAxJ
 LtRQf0XT+aNsjxTO96O8Ys3xQ3tjW8CS3Hz2+C4B8qfNCFsieUFkpwI5kwbgxXPsAylV
 5C0sse5RLwtCx0pGg+vCDwUSUElHFZf1IEYrkHHW1O2K53cfBUFPFbKs+R5/YyCcF+un
 4zP7JnhIIydpeuwRrQDdnIQmOe1BdLLVhQkRzV0Xvbqf31kVwweTLyLh/8qqAwaZ2By5
 Hyqq3h0bNeMBm6Q3DTsMqoPKBrvYM/VU7jlZQ/KDpfqsUzmMQRpi+gK3lVMaBMlSGEuZ
 44SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ghu/IoeU6SlJcGB5NCMH+LG0EJhSG/y5nN9JRSXPP94=;
 fh=6qpf/J4MYwj9H3lW+0ghozOZF3ihEMmP9VOdX4hTdDU=;
 b=RHAUBCiKC130Okm9mpYG7450N7NBH1g5dhLVREUV6SA/nUEeJghruToXBy5RgfzCoY
 M6lE52PkNKQ4GXnTPKFgwozJTZvBEAMgbHTTL/aixWBQYn75tNb9TWzOLz/J5KRKENw0
 JdIF0MUAbIQdlTR/iQrJySGDWXiSMiKT0l68BWzWL0pc7dQafT4kHSH5veolk785nYTA
 4fYISHrPkHWFhGrUA08lrit1oVcvdMtisP0MiYHzC5FtV+R1uGNTn3PVP/fggDu4sCSy
 oEH+Xln7jso8p3UFuJywkrQwuRmv8pIxgCZehw5paRFcEx48YfxrbXu6BoHJ5OgGqwUM
 F7Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1781590494; x=1782195294; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ghu/IoeU6SlJcGB5NCMH+LG0EJhSG/y5nN9JRSXPP94=;
 b=doD+lloqUq7NsjdGExYWR2EDMJtFlYpPqKXZd6j6UReamyPnCxobq663E48c531hP/
 1DLxD8U4nv8tMeqP98fWEmt6SomLQ+IS6AKy/3Wtv842DKbSUgic4kXB1oF80NvCQ7qi
 wHM20paffT88fG0fo6TZN5f2OpfzBhEBpTEQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781590494; x=1782195294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ghu/IoeU6SlJcGB5NCMH+LG0EJhSG/y5nN9JRSXPP94=;
 b=OwWgDpjKt+/dkKhUV+jZhvcnJG6PJap2RxYTIEm0DVto+An5oft5CjgEHFbvfCOcjf
 TDKFCQDKWBIx11VMyse8sk/srZ19SZPKfHDtpgvZk59bnyT1Cm+fTfqo85Cq0UsEexeC
 jVpRmD9hogPzO7YoQ5oLmpCd9QUb0Hsq3UiAM/EsDVa4wKLNk8Qjt+Yn9dpiYHFpqQtD
 IyuvKHY4jrQMqW0Y7kpWFTjt3xOfAWAhLWwfFHeFqvHQNIDP/XmU+ZEKVxqjRt+oUMH8
 tojwxNdZP8/uM19DQ29Xa91wnFyMT4qMjILN4klyMEA5Gl5LcnIlaSxPr3LTmTHQq+I3
 gJKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ81r3iuEv/jRh3HTUA143VsZCulJFglkDljuwvL/HJ6ZkysMU7qw2YobjEfzSFV9ShhH43+0gLTKtDw@nongnu.org
X-Gm-Message-State: AOJu0YwNbptsZDh9JBZQwb0/K1+JnjtYeealgLsdXjCFPkVZYoWXGk5J
 hrkiHhrYXOSOet+zzmkNWLxvSFZfp8qCH8BnC/bGdnpGckKi71ZCntIpuoTwbBx5/lWWX1HNTWQ
 w6yR/fclJZQXBsbbVGpDufk4Pi984F/w=
X-Gm-Gg: Acq92OHqHRr4yOveb0iVFN4o9XurUL0hzHDyGtb6V43nPamBmrQts2SWaztF2u6SEtU
 jODBU4jMbjfDhvj/iGzyCKdkDlOVFT/fV5/EmZntXG1EKUEGZynWzLNg5ihliurnc5OsZ8kHcAi
 kGT2jIlRdKEGeK2nxOM9UUSi0yeQKAxtDKMd+rFgMzFLW5lFhgk6fhGGzfIzaQiaug7SNW0z2gq
 MaZ7GdF1y3lyOCnveesgxO9Z9jfD2jR7Un19oZzGR4pqPD6Qd/jH2kd0Am3GkigonAUT9H7C9zi
 rkrPrBiPzNighse21pPwKRPq8y/VquteMV9LS6wyJG789b6bl1hzg6TBODd955T27MZV9+TY7Zs
 be9B1EizJgIW2w8RlgFW7+hmZ
X-Received: by 2002:a05:690e:1444:b0:660:5c10:deed with SMTP id
 956f58d0204a3-662b616900amr1534701d50.55.1781590494444; Mon, 15 Jun 2026
 23:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-13-joel@jms.id.au>
 <CAKmqyKOYeG24747aN-OyOCFi-Knb3vc5E0FV2PM-FstCmf3Xgg@mail.gmail.com>
In-Reply-To: <CAKmqyKOYeG24747aN-OyOCFi-Knb3vc5E0FV2PM-FstCmf3Xgg@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 16 Jun 2026 15:44:43 +0930
X-Gm-Features: AVVi8CfUnkwXtytYjrmcjeYD2biQsxmAoOt1ge56ktua4LY6enzGXHKCKmdozco
Message-ID: <CACPK8Xf4LNGg7DbqW+Rkf+jWqE+mgUymTqyqKTiv3=n7wVGw1A@mail.gmail.com>
Subject: Re: [PATCH v8 12/12] hw/riscv/atlantis: Add some i2c peripherals
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb130.google.com
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

On Mon, 15 Jun 2026 at 21:23, Alistair Francis <alistair23@gmail.com> wrote=
:
>
> On Wed, Jun 3, 2026 at 5:03=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:
> >
> > Add an I2C RTC device and a temperature sensor. These are not present
> > on the board but help for testing.
>
> It might be best to leave this out, if these aren't on the board
> should they really go upstream?

Without something to stimulate the device we're not testing the
designware model, nor the integration into the machine. IRQs, memory
maps, as well as the model's state machine all get some coverage by
having devices present. The specific devices were chosen as the
existing test kernels have drivers built in.

We did something similar with the aspeed arm machines when adding them to q=
emu.

Cheers,

Joel

