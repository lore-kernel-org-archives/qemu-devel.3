Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAA0C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU16S-0003I7-14; Tue, 24 Jun 2025 06:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uU16P-0003Hi-SC
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:42:09 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uU16N-00028n-Kl
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:42:09 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-606fdbd20afso573759a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750761725; x=1751366525; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5q/qHRew/xSCliJBobXgAw/rxETRai3tTqlUtQvQ4M=;
 b=TU2it0en3EL1fk+7ihM2VkS5tvFm3oOr3Tv9CgQ/uDc2BvWmrmGmE4KDoEEVyFUnOM
 4DE09x4ZCKoOAsUeklcPsVqU/+DOgJ5PFoPCZIE33BBsmK00IJFYLZT9vLsGtloOWh6f
 kbZdRZ+emIjc3qnBY+28OV1M2aJvp593kp7si2DMugggWUtJLkIBzK1nzy0fSVniqljx
 MKl7t0JNmq8Z+6tiiUUeWjlzP6AkkjT8tyt+y5NTEy/ZbZ8SHRRIfcUX8yut1bwcwhLn
 lbRVfNy++22sL9SMJeIZsCo35u0o+l8Qjwx+aQFH5rXnRkqs8cKzy8jvyv/YV99Jw6W5
 fHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750761725; x=1751366525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5q/qHRew/xSCliJBobXgAw/rxETRai3tTqlUtQvQ4M=;
 b=o9S0xlIc8VQhI1kQQSnrFyO+UUW0UlQMdvUVcrTcT37MGSinl7w9bM00GG/aGLTiUH
 4Umb3ROGD3is5yIhCXIQfbaVDJcJoD93rXmnE4v2stq8ROJWUJ96tgwru3fBtg83uI0V
 4JG2I0tSkDq8eJlp2PSza+AHu+7TkC22xJQjADzRvth9uqPWKpwEhnNXJ73+8mTx5HPA
 FQQjU0lCH4BZPGwVVuaJowZLh7xLcD5/CJ1Yh5aFgwYNh4Ay/9bGQK7ZO8IRuBHFtxWp
 IHYSZGLUYhFSgHCRS8Si62PtWEiJUkx3jFnN8htP4kCPN6V0uIp3O59ydhnxGuxxMADT
 bEJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmeV7INX9FGpQHTSluENwTPo1p+L3/Dcvx9eeZaGqjWa0j9UUC7llgDdLb2D1xHEALb6m2FPQizfQ5@nongnu.org
X-Gm-Message-State: AOJu0Yy0Bs6E1vG40ns9BxTobUdMa0UF9+fD8KItK45LXHCVvBRhJNTA
 eZZQuru1ZTr3B5+85vDRAgzsBxZa0wBjcce+ObxloYnRKdUUF4eCYJmtqLBEOagw2WjGTPJa6yZ
 2dSFBqFcRlWoMB94NKpLGusEOA8jbLyo=
X-Gm-Gg: ASbGncuxfvNB1PXm6XeWstEHz07v5AYSz57CTUj9W+m727rvjW9CxDrCCJCbUFyIkPo
 CydaiGNkDob86kORuTGO7CfttOnYWqYayWs+Vu0xvWn4gZNeDbQBUALT6gPB0BTq2XCFT7m2783
 ToSGbVZJXDvE0Oo2NKU+A2VFgGbZcPpdXW9E5z5vqeUQ==
X-Google-Smtp-Source: AGHT+IEU9+VxnivJ0xt5DamFM9a/PlDOoNeGB4dpPgOxYxwe6gcoP7GAZekS2z7n23aeIpPMJU9tl17PL6UeLPyUWJY=
X-Received: by 2002:a05:6402:35d4:b0:607:4500:2841 with SMTP id
 4fb4d7f45d1cf-60a1cd33098mr14260680a12.25.1750761725168; Tue, 24 Jun 2025
 03:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250616092241.212898-1-armbru@redhat.com>
 <CAJSP0QV=mfmUt7s+iBkJtZsLiNd1v2c6tNrZeG8htBs58JHhrA@mail.gmail.com>
 <87h60614eo.fsf@draig.linaro.org> <871pr93f6s.fsf@pond.sub.org>
In-Reply-To: <871pr93f6s.fsf@pond.sub.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 24 Jun 2025 06:41:53 -0400
X-Gm-Features: Ac12FXxcvk8iAlCIFTnzEiJaNMVouu9s3E0ombucGiHODMkKw8PNaieoM3Y4lPA
Message-ID: <CAJSP0QWPcXsuvdr8Zt8x_fnA1tepzaHJpAtFBbqjJR7odR0P4Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] docs: define policy forbidding use of "AI" / LLM
 code generators
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
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

On Tue, Jun 24, 2025 at 1:02=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Stefan Hajnoczi <stefanha@gmail.com> writes:
> >
> >> Any final comments before I merge this?
> >
> > It's well reviewed lets get it merged.
>
> Stefan, would you like a PR from me?

No, that won't be necessary. I will merge the series directly.

Stefan

