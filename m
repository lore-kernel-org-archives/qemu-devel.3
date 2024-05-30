Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077D6C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCYtS-0003D5-CP; Thu, 30 May 2024 02:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCYtQ-00036X-QJ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCYtN-0000wK-2H
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717049040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uwanCSuVwpr3jhYTie2dFqlQ6OWtbgGr70992VqFgsA=;
 b=atm9o11VyQbhVQq6THqypwocG2xjr1I9m7+ZZ2sC8B0Yr0EIrreTpQLNL36PNKL+JhpOqC
 0wHxr1spNuFTYFHIDPCOrQ2T7DJVNvyMPpa+pSP7osUwndh46XEIEw5okO7ougUHV8cS0z
 OTIPTmmSYRxe+OFFGIjhzt3BKJ2wdE8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-XbMNGKinNBqhojVpyFeuTQ-1; Thu, 30 May 2024 02:03:58 -0400
X-MC-Unique: XbMNGKinNBqhojVpyFeuTQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52b7c4d505fso422728e87.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 23:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717049036; x=1717653836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwanCSuVwpr3jhYTie2dFqlQ6OWtbgGr70992VqFgsA=;
 b=hydIGYiua7cH0JXw7iIvFXNpFkAry8SLbKJY1HjBJat5hAC4A/5OI279tQg6cbgC+3
 +/Q4BZMQ3bu/sWv0YwNldez4LgDqtHw+3sCktVpEuNFEkLfDlzmR7/1/GMwx99DgGC6a
 d0bJn0invPF4oCpn75mK4rk6S39o2m4vDJYGDXALSH0MM3LfNVt7NL2/BgOSXO7Fa86i
 BfBfVyulvOoPEvlFt1i0OCfhqx3x2DNcHPqroXpFYZs2RmeDucg1gW2dqcynTev7jEip
 BQncLfYCbu8NJXVYjqV7ms5AR9DiQncKphaMmFBrXNVvq9HwpYh94EFvgA/Z+Lxi7BCq
 e7hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp7t0zV7Ibyf8KZXLl1pF8BRXp9y0evWrWGs47ME63P4GwpDE23jUlDpHIaDmImZM8Va5KgRsfi0wuNvRcFUKt3wZwIR4=
X-Gm-Message-State: AOJu0Yx+mJ/CTxf4MIMRjZwmRK+/PRIqfs1SJGGJvDhlyAMmrzQ1RkT1
 h2qUw1LU8ZMXAfg1V+nh2zqEV6MvPEg+NQ/ellQRx1eH8/s7iBiGl46H5h6JlQRbbkntGhYqoW7
 PssYE1/QbeHbl4JxtB2XCjdJiytJetYGZsVR2PS077R3S4Tx8lgRn8gzsOX35s7idZW1DshEkb+
 oR0yqNbb6zap9XvfvMw+wDIyNPgZIKomdg/ok=
X-Received: by 2002:a05:6512:3114:b0:52a:f478:a3fb with SMTP id
 2adb3069b0e04-52b7d490ce5mr1434818e87.61.1717049035963; 
 Wed, 29 May 2024 23:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0sQVxIJgwevIwDjU6so56/KG8QBQ4q6/a4QikX5oOlqEAp09MmYQXVQf7ikc1Iaey8qICkjpKwrzuMucvKpU=
X-Received: by 2002:a05:6512:3114:b0:52a:f478:a3fb with SMTP id
 2adb3069b0e04-52b7d490ce5mr1434797e87.61.1717049035498; Wed, 29 May 2024
 23:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240529155548.5878-1-philmd@linaro.org>
 <878qzse8md.fsf@draig.linaro.org>
In-Reply-To: <878qzse8md.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 30 May 2024 08:03:44 +0200
Message-ID: <CABgObfZ0P0Frgj6=mTmvgaA9_Ve6x0BeATgSKdVqM0Ku21p=iw@mail.gmail.com>
Subject: Re: [PATCH 0/3] semihosting: Restrict to TCG
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 29, 2024 at 9:11=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
> > It is pointless to build semihosting when TCG is not available.
> >
> > Philippe Mathieu-Daud=C3=A9 (3):
> >   target/mips: Restrict semihosting to TCG
> >   target/riscv: Restrict semihosting to TCG
> >   semihosting: Restrict to TCG
>
> Queued to semihosting/next, thanks.

Please don't, at least not in the current form. These are jokes, not
commit messages...

Paolo


