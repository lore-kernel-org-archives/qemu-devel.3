Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBC2C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thXB5-0001Ns-1x; Mon, 10 Feb 2025 12:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1thXAy-0001Fs-Sa
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:02:29 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1thXAx-0001ZX-AF
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:02:28 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fa345713a8so5661244a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 09:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739206945; x=1739811745; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHXjo7N63RGQrMMZtoewKoCyxZtxUlYyfebHFvufNAU=;
 b=Y05wtjYB0SKca9HIHNy9ACkPqdYt2jCkmoTJoRXhB/lgw+YNpLRNKpQ9Xw17iZGaSw
 8pPmqY2mG5NCGK+b2ZcHdv7vTsOV+k/hlUlL6To8P1q48lLDLl40eC6Vja9ztiWo1qGZ
 /doK2JIi+NHkP1of8y8WyNbTSlGV2G9Uidv1EbB3SLSOo+Uek1PxI+REGl1WaQxPMO6h
 67xD9K9xInQs3NdK6RzSbOYL7cpYYk1rfSrx9bYjGdOMR6A1RSpkb+REdU1Afnz4IV8p
 jxWmqnoLcSIuRt3KtfPFSeaR756cRKV4krRKNFfQU2KDtRHOTZSaS61L44wRAQ1aEd4O
 DQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739206945; x=1739811745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHXjo7N63RGQrMMZtoewKoCyxZtxUlYyfebHFvufNAU=;
 b=tNX4NC1IQ1qpAAw0kN9QIg2NT86ecr/xj6OVl/S97OmaAwc8KX28+q+iHB0kqnvsQ3
 EWiLpMIlHi7T7PpAQXyNgKlaNduI1rly7Z/gtSD3mOg0H6fxLRB5z/WFA5IoHzc5gW8V
 GymjQ7mGb7LoyoxS5BlrAOsvVS8fxn38ZW9wSZ6TKGgB+jH/qcU0YlAk5vApY/IkdCjK
 mkuN5POwAese+iWHOy+fi7tpgDek5luFPPvolEhJ4odK3FmwHwUta4pnRtsthx/+KSzu
 Mmn56UBGy0IEiA0pgN/z57ibof4zHLRPSmbwO8jzioV0dBFZpviQOnbKYNoI2Z3f4dV8
 HN/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiftchyYdwgC00xA8ZnaxCVFuYNxOeTt74faqGIxomfS2w4IBWR7pUSuGFD8XFUf2eWthPhOU1VuBc@nongnu.org
X-Gm-Message-State: AOJu0Ywxg7psPTDDlAAVf2dUzskmIXuCmtA/9Uuc3HdNX3liUKXD2tf6
 wXDHTFUypY4rUTfoXHM8qIjuSuVQJRpu/Um7p9CGVeXIZngOq+HxZJXIOAHfIUbBsj/TBJCXI0e
 lbqnbaAOfnBYUjwV3/0mX4siQx2I=
X-Gm-Gg: ASbGncs1QCC9f474nVH6Dxrvk23h2ORVumRfeaA3dh9oScAr/BDKJhQzurXV8E0VCV6
 eIXYLH+6QPVsQG5KOPSg12090JhjrP+FDENON1BCzte8P1VKRJ37uaSWVBkk4H1EaJE8lFzXybR
 V9ysmnc/fcn1Kv6vOnpm/hW1DMjfr3oA==
X-Google-Smtp-Source: AGHT+IGMpW1FUXEANax3MGSzGYzBoVr1yqYTpgH8/MgbGl10bN0O0xasgCXks91KfvjGJvg70BgCqdj2sxaIYm9Lhc0=
X-Received: by 2002:a17:90b:510e:b0:2ee:70cb:a500 with SMTP id
 98e67ed59e1d1-2fa23f563b2mr20301300a91.1.1739206945555; Mon, 10 Feb 2025
 09:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-4-philmd@linaro.org>
 <526984ce-6bee-49b5-aebd-0ab4c391efb4@linaro.org>
In-Reply-To: <526984ce-6bee-49b5-aebd-0ab4c391efb4@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 10 Feb 2025 09:02:14 -0800
X-Gm-Features: AWEUYZnUB88E1zD2TGnOwynVaGrWzs-YMOFGqG-S5lS0ZBQ-VUpZ5JrZBpg4jeQ
Message-ID: <CAMo8BfLE8ROwCZRaEbHgTUT18LAV8sVugMxa=+DELCb24nA35Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] target/xtensa: Finalize config in
 xtensa_register_core()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Feb 10, 2025 at 8:30=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/10/25 05:31, Philippe Mathieu-Daud=C3=A9 wrote:
> > Make XtensaConfigList::config not const. Only modify
> > XtensaConfig within xtensa_register_core(), when the
> > class is registered, not when it is initialized.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >   target/xtensa/cpu.h    | 2 +-
> >   target/xtensa/helper.c | 5 +++--
> >   2 files changed, 4 insertions(+), 3 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

