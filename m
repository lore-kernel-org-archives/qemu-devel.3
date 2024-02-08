Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5D6C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 14:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY5P4-0003V1-17; Thu, 08 Feb 2024 09:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY5Ow-0003QO-59
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 09:29:19 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY5Op-0006vM-Lu
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 09:29:17 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5601eb97b29so1856459a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 06:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707402547; x=1708007347; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uswSyOm1D4WQ+dn1PI8wLnB3SL0ieGuRJZq33vNjcvQ=;
 b=fIAgp4c5gxEs9YAkIHNgaLL5AdosKEhVDDpG508+Ns7MhPPLC/z4JJKzFLiGfNtYWo
 t4QGzlsFFgaGe+a8CJRZObGAZweatSKiTxCg+cbfta7EufK8cjalxsFkeGaboJ3DyBJF
 wsfiuQ0Ur6Qhdl5rUzuTZ/S15Bwyg8+6gIfByf5D4X9lcCh57spM1Gtl+6vqspGVbDHH
 qLxKEkpBPNWgdrqirZJAbyHG7OObiPJOc2yEcUW/4/E9wFa+m5HM64mxPby4qajcksh2
 EwG/kSEx0gM8n8Ux/A6oRdjokyjfUpQ/BQ/Da7LoLeC+pP3WYo8IyvSRrcTOa8jtzdnb
 fO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707402547; x=1708007347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uswSyOm1D4WQ+dn1PI8wLnB3SL0ieGuRJZq33vNjcvQ=;
 b=i7Oo0dcJ5KO2j/atYDNH+23lUtu7hbXLmlYdSEOy9O2JwtyTUhfeZHTXOH8GcTC8xX
 3Z8WPeSxpO7d02nKPOJjLsOj4/IGRfUipCpt4hiPfjWEpm0eDsVrK4RZyf6wRi3kkNRe
 JnZ70FiuheTd8zWqFz4Oy8UiTMliacCRiFYwDODT3T7cDjLSXLF+H3r5lm+UsD43JI3i
 9YagMVX9o4x02shOBHtLgSbzfi1fQqjWigIjqIwqQt8d98enT+kXlWE4yzvOhi/zYYVg
 3wf8riBF3PBwbv3GOOsDWHsGepSZXEWtzN18I2Sb+2Y2lXNahxgwoZeaxeypODS7IQrq
 rGDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl7U1UGcdLvrA2fNBhSJiNGc7LOaAzsolkhJdjPP8aoGvZJWmMTwxeut/KBP+7vQ0UdlKvb43b1T6/hM1y8zmXeNiph0I=
X-Gm-Message-State: AOJu0YygXXligshLw0MzMEujn7TTum/gGbhBQyhHR4/Fwk6SUQjs/KPc
 ZjkC/eQK1Y+3FSyphKQRVt7npKHqFLMyOQJXAc7Rg7V0ZgEUVBIPW1q0S33V4sKT4HTmZt1lTHS
 zUrQh1ILHSZQ33hl5fUTp7J95xcJBYEkIQ+vYK7IOGnhmUHJ0
X-Google-Smtp-Source: AGHT+IH/V8FP1ooPtmqO2IuX8FjlUS3TfCc4m47tQr04sKzFZFbA5e5fMV6xAX020IH5gcncK6Tkcn4jD0GE42FKjZg=
X-Received: by 2002:a05:6402:180a:b0:560:24d8:d2d1 with SMTP id
 g10-20020a056402180a00b0056024d8d2d1mr2773675edy.11.1707402547443; Thu, 08
 Feb 2024 06:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20240208101657.15962-1-kwolf@redhat.com>
 <ffe07fee-0cda-4517-a64b-031cb922d806@linaro.org>
 <ZcTjlNeibKUnIDcL@redhat.com>
In-Reply-To: <ZcTjlNeibKUnIDcL@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 14:28:56 +0000
Message-ID: <CAFEAcA_qnVdTh96KsxPRguy--SLD1-xD=Uxp6MzE6dK6e98Cew@mail.gmail.com>
Subject: Re: [PATCH] iothread: Simplify expression in qemu_in_iothread()
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 qemu-arm <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 8 Feb 2024 at 14:22, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 08.02.2024 um 11:48 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
> > BTW using the same pattern:
> >
> > -- >8 --
> > diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.=
c
> > index ec98456e5d..d074762a25 100644
> > --- a/hw/nvram/xlnx-zynqmp-efuse.c
> > +++ b/hw/nvram/xlnx-zynqmp-efuse.c
> > @@ -582,7 +582,7 @@ static uint64_t
> > zynqmp_efuse_cache_load_prew(RegisterInfo *reg,
> >
> >  static uint64_t zynqmp_efuse_wr_lock_prew(RegisterInfo *reg, uint64_t =
val)
> >  {
> > -    return val =3D=3D 0xDF0D ? 0 : 1;
> > +    return val !=3D 0xDF0D;
> >  }
>
> Maybe. I would have to know that device to tell if this is really meant
> as boolean. Or maybe it should be written 0x0 and 0x1 to signify that
> it's a register value or something.

This is a RegisterAccessinfo pre_write hook. The docs say:
 * @pre_write: Pre write callback. Passed the value that's to be written,
 * immediately before the actual write. The returned value is what is writt=
en,
 * giving the handler a chance to modify the written value.

So it is indeed returning a register value, not a boolean flag
masquerading as a uint64_t.

> > diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
> > index 301e61d0dd..bdd73bd181 100644
> > --- a/tests/tcg/aarch64/sysregs.c
> > +++ b/tests/tcg/aarch64/sysregs.c
> > @@ -183,5 +183,5 @@ int main(void)
> >          return 1;
> >      }
> >
> > -    return should_fail_count =3D=3D 6 ? 0 : 1;
> > +    return should_fail_count !=3D 6;
> >  }
>
> This one isn't unclear to me, though. This is EXIT_SUCCESS and
> EXIT_FAILURE, just open-coded. I think making your change would make it
> only more confusing.

I agree on this one.

-- PMM

