Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8D2C30658
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCgs-0004ks-4I; Fri, 28 Jun 2024 10:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNCgq-0004kD-Oq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:35:04 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNCgo-0000Ls-T3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:35:04 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a72af03ebdfso95691066b.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719585301; x=1720190101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+uAk3bFfID7pkNPPadj5fvdu8UK8/lHck3KEK8Z2W6E=;
 b=pUFGm74FetAp9AirNDn/Irw/AbHhULL84RQ0z54si+tTdRjiF5C8C52bAnYK92Cr3I
 XgvqfihP+GmdWNGf62ynqZoOh/Wnxlf239C0gyU8JAIax96r8jTrTflCYlSigP36ZaMV
 9IzKPem2kN57gFOlIV9zv4qvI+frj7blCWp8JZdAa1leBTBjdCI8ZcH+8gE3fr4C+f4A
 8q79TGTEnsWdvpAPKQcxFqgi3Qf15U4/lgKJXthGE/p+ccpaXgzvKT7e9hiFXOVQWjGq
 YyIvCZ8C4KtC4iKxj5XYuFeWH54zW+2xAwYd4AO0YIszHOgCRj81fpvmknGkG8zBoTDD
 9nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719585301; x=1720190101;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uAk3bFfID7pkNPPadj5fvdu8UK8/lHck3KEK8Z2W6E=;
 b=RJRO2vrjOBgiMrM2aqNCcN7HrA7pJ39yUIQ2gSfsM+fYQifVRc2ze4PKA601o7x/Qu
 brdEdIkj9+OiagpOcEZojeS2aZfrR3IpuAqJgj675iOdcAOS0e+tdc3dVClWzU065mEe
 fUu2AWbGXircul7FX9DRzbTL+n+QpOK26e+yuBeMPTgPBIwA+wLcaUaORn+qxFWtUulJ
 /B/XkNcYYXdmQhm/26g1d8dhYRbTHXWnwMM4sV03atDx0JkEMCGeb0jic/EHru6VL1WO
 PQAT/p3QB96I0KL584P8rH16of6MBKnd29wTeX03GioMQvleJA/787G0UExG+mJK48YQ
 emag==
X-Gm-Message-State: AOJu0Yyci1d3BWonK/USQpm1zcdSDlB8cVkA7xltDlr7KS8k9c0qlbYg
 8n1GsDad4zQ9/guLeuWOzdBi0ehBTYA2QfaVfweCO8Qzsib0WrjZ40OOkGqCUw0=
X-Google-Smtp-Source: AGHT+IG6VfqNA3syidWs0r6o9lNgdgF0gsLfYuJc04SrnoAC9y5alnejD8iE7HcuQETr2vGT5naycQ==
X-Received: by 2002:a17:907:9706:b0:a72:65e5:3e7 with SMTP id
 a640c23a62f3a-a7265e50623mr1054135366b.55.1719585300039; 
 Fri, 28 Jun 2024 07:35:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf62058sm85144466b.56.2024.06.28.07.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 07:34:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8909A5F7A1;
 Fri, 28 Jun 2024 15:34:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,  Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  qemu-arm@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,  Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Stefan Hajnoczi <stefanha@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael S. Tsirkin
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH 02/23] target/i386: fix gen_prepare_size_nz condition
In-Reply-To: <20240628124258.832466-3-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Fri, 28 Jun 2024 13:42:37 +0100")
References: <20240628124258.832466-1-alex.bennee@linaro.org>
 <20240628124258.832466-3-alex.bennee@linaro.org>
Date: Fri, 28 Jun 2024 15:34:58 +0100
Message-ID: <87ikxtnnjh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Incorrect brace positions causes an unintended overflow on 32 bit
> builds and shenanigans result.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2413
> Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

This seems to trigger regressions in:

  qtest-x86_64/bios-tables-test
  qtest-x86_64/pxe-test
  qtest-x86_64/vmgenid-test

Could that be down to generated test data?

> ---
>  target/i386/tcg/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index ad1819815a..94f13541c3 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -877,7 +877,7 @@ static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp =
size)
>          return (CCPrepare) { .cond =3D TCG_COND_LT, .reg =3D src };
>      } else {
>          return (CCPrepare) { .cond =3D TCG_COND_TSTNE, .reg =3D src,
> -                             .imm =3D 1ull << ((8 << size) - 1) };
> +                             .imm =3D (1ull << (8 << size)) - 1 };
>      }
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

