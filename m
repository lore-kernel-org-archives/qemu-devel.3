Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0A4D58D4C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 13:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZQU-0004oF-IM; Mon, 25 Nov 2024 08:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tFZQH-0004jM-Ui
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 08:46:43 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tFZQF-0002yi-Ht
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 08:46:41 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53de6b7da14so493297e87.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 05:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732542392; x=1733147192; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtE2hcUw48GwVC/ro1+KfmisGy+Nmvx9gKWonCnWoJg=;
 b=i9WczaT0ei5W1VkC3jx/6IvrZwItkPqnCEYY1vey9m4BURhZKCJL5OnO6o+UEYSSEx
 ZNN5BT84umCPRKi7wdzeZaC6mV/uP1jHpBlxYRb+5QqkYOAv/JQA2R0+B/LRQ1q9LZzU
 zQd10KVo/mOyYwr7kfHDp/Lw41Ii1i2eCyLfbvP/nLBHwyOodJt71DZ1xPj/vru3ZKXF
 UPqPybQpiQ3gUPPK0xgUqQLYoteSKGAb/YxHEmiAI0cWd9pwJM4voaxZJObrd8GBejhz
 et25//scTvmYuBxAq/I4XlRZca1UPBQ5IfS3OKGSDaL4Bfip21W962tOSWdtL1LAdHGA
 hU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732542392; x=1733147192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VtE2hcUw48GwVC/ro1+KfmisGy+Nmvx9gKWonCnWoJg=;
 b=k/eG4Tr1C2iU5b4hcl10jq88q/irOF676eFi0rKWcwYUkjH8oQabotZ6ACY7a8fkXF
 W32ndceKrmhzZWWpM16WYWcNKuVoLOnT/GZbPXjNW4owNgzEoORixsIEE1vei9RkkqLx
 HI0LfrqPnW6r9CAA+C+HDI6C/Qy+fiFu/MepZoX3Vr1uCro1AnOrjhNf6oBfYsnJo66k
 6OtZAJSyh/Tt5vzsyhqZ+cWpCrLo5E7HzIRX65s+aA3UskSVzMhlsZODmpnnTpxXeGcW
 xGqNcIZGDbJg9FiBVuNf79+94QroCQ3+YXh409Mss7Jx0e+nDpQ/s3NS1sB23UZtnqDW
 Tp0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIR+oDpGTySLQeU9KeWHLu6hmtMGlqpq8Wu5+VP3CqNjGd38tc8G2Iqz41h+RmLenmr1isuXmLzbv+@nongnu.org
X-Gm-Message-State: AOJu0YwDQ8pB/AcwG9TEb2LCshJLBO8vINnDmMige5aEBnnJJJ/h/vTp
 1ozGNpwQJxk7HIr0RQAs+JK17fQEHT5E9jZUU6bD6mixZmLK0IEQ+lnAiRQc7oXryKtfCj7s//l
 86cHOTSxYD+M237Ivf4Q8CDkTsDc=
X-Gm-Gg: ASbGncuaviMt6nUZlniTfeqRECsY3OuRYvKoMavkIAcgh6swpYvFD8O3QvzEwG1waRw
 Kh9DqUTpnDmFP3w6l6QtsB43of0fnTnk=
X-Google-Smtp-Source: AGHT+IEauFnDYzzl5EqyqHAyPQwmkP/qY4cXEw6M5uetfQGH2cpumfs/9Bx0x8UP97/MyIMOLPOoR2+5OvfCCDzpmUA=
X-Received: by 2002:a05:6512:b12:b0:53d:d242:6bb0 with SMTP id
 2adb3069b0e04-53dd39b6ee5mr6131365e87.49.1732542392187; Mon, 25 Nov 2024
 05:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20241120075321.27143-1-r.peniaev@gmail.com>
 <aaaf219b-dbfc-459c-a531-02b5c494c65f@redhat.com>
In-Reply-To: <aaaf219b-dbfc-459c-a531-02b5c494c65f@redhat.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Mon, 25 Nov 2024 14:46:21 +0100
Message-ID: <CACZ9PQX5EMoWG8A29Jy5kUvEm65R68EcOAU++9t+DsGgf7_gFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] chardev/char-mux: tweak mux bitset operations
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x130.google.com
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

Hi Paolo,

Do I need to resend the fixed version, or if it is queued to what
exact repo or branch? I'm a bit confused. Thanks.

--
Roman

On Wed, Nov 20, 2024 at 3:44=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Queued, with just one change:
>
> > Also add a static compile check that MAX_MUX never bigger than
> > `sizeof(d->mux_bitset)`.
>
> This needs to be multiplied by CHAR_BIT.
>
> Paolo
>
> On 11/20/24 08:53, Roman Penyaev wrote:
> > Patchset tweaks bitset operations by changing a constant to unsigned
> > long, introduces a static compile check and simplifies bitset operation=
s.
> >
> > v1..v2:
> >
> > Rebase on latest master, incorporate review tags.
> >
> > Roman Penyaev (2):
> >    chardev/char-mux: shift unsigned long to avoid 32-bit overflow
> >    chardev/char-mux: make boolean bit check instead of find_next_bit()
> >
> >   chardev/char-mux.c | 15 +++++++--------
> >   1 file changed, 7 insertions(+), 8 deletions(-)
> >
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Reviewed-by: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.c=
om>
> > Cc: qemu-devel@nongnu.org
> >
> >
>

