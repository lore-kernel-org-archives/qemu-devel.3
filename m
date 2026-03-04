Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70772EDEBFB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 05:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxeMB-0008DZ-GQ; Wed, 04 Mar 2026 00:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxeM9-0008D5-DU
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 00:01:09 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxeM6-00009K-Mc
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 00:01:09 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-660d2e4846cso18566a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 21:01:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772600465; cv=none;
 d=google.com; s=arc-20240605;
 b=G7d9RX5cPzJblLuBUYxOaEuR+ahtkNBo38ozQLx3VYAsCZyjq7k5rKSz5QOPclRJF+
 uXAGkptM1wWDMGaClsFUSZOs9wYK79zQi1rrbBdORZCZND4HASbJBlztDp0alX/lGWYF
 VW5T9H7+2cCTBVlPz99mHsFs+nia3FzDD6oHAP8TsK9WbwcvwXkGBrhhQ/4Rk+NdWZ4X
 5hlDj8Hsed7O8LtZn8X0tryciUWypLEHymSjJGibj4i//ixhZ32CzL4t4QA5GSyp+mmG
 hfPaj8LIZFESuh2MP14au58SAYdv0zqYzO7o8rBMRvM5FVWcXuR1iG+/UoOmvOWq/ZVC
 cXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2+QWZwrGM41YKnU8oXDPvgVnKpNMU4wKagtgOzcteWk=;
 fh=SQmLttdHIQuq3A+Mii99oLuEUoDRwjQE4gGZH2ySfCI=;
 b=fn4uCGy99IOxGQRGS0C65HHX1kYxcvUX3+LAqldu1VeZu4XXiuxwgOnFfL58lvUkmp
 XCx1+gR+KnTGZEjZaLMWhaD9WztjwIctXa5+2SeV+DUytcmqP716giPQgJafSyqdyqKp
 9r90UC5qwnS/mA5i8XcWY+mKvKXQ4fiHzL5RsctE+LJRpHeuZhDuJ8geBSiUltOMpOVa
 JVt5tRzeCKCI6ij58+P6JrRaB9ptqbndx38ACgQQqfxdplqDeWc29xCcFLF3bV3kqsA8
 sQnb+FNfE+GqMcFnLQi1HLa6YcLyojLaVdhCtm/zRj9Bi+LAH9BsasxWfJZ/42S+BGlI
 fpnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772600465; x=1773205265; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+QWZwrGM41YKnU8oXDPvgVnKpNMU4wKagtgOzcteWk=;
 b=ftOhjLSgqBd8oryOduj9XRZEA8LerJyiLi0ijOnd6+LuEV1Gr1N8A17vJeMh85Fw3p
 KP5hTa8e+uoimlZLkVV8h8SBWPfmnlG4iabEZhO1kfmAX8yXj8u8N4BJNQoCjo5RFgXw
 YZ0SZj4dnTk5If0TIcf4A/K81vl4/qpgIKZAot0qp4Iu5RS9sv6bc7dd1boi675rBX8x
 hfWbt5YgqOlulTkhI+uUUeAL8RONRSmwPmTpNUaccGy65VgH2R5vVoJAyka3TdwAjCQW
 32r9yG4VclYJxFVduSnlhbFwoVbnpx3AJ3qCvGt6w17W3ASuNm8npdLvemkCwt/hGhhi
 aPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772600465; x=1773205265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2+QWZwrGM41YKnU8oXDPvgVnKpNMU4wKagtgOzcteWk=;
 b=Dk3y/9p7JiDVw3dhaJ6qJTAm8SgCs2HAxlGdcZpRGynQ7/Y+ERCdNEWYFZ5ZM9en7S
 HMxbuunHwZ/8VxqW7b0nPszbFKUmH6o7vzwER+6/df7KzWJcogAcxMNzto56n+aKWHfh
 KJ7MskcC+1reBSh++Z7ZuTEkdsHBgOfBIfBMY97eTEChWFOKEbbr3Ji4M+DijYdZrx0l
 bsQZ0bqzgLmo7df+AMuFlWLYdMNJVICeOvantRYcjXQpezjBUeHqEssSOiRNRkUzUbx9
 JljCn27RchQmBLAVCuV2+PeWtcl794hzJe8B0CBPb2SCK5uiDEP14W5woYVFQn//VGM3
 VX/g==
X-Gm-Message-State: AOJu0YxDxxt9HNQAfVR+bQW3rxt5fFWfpfui+C09e4qIACWnY8dSN+KL
 6/uryorq1IoawdtUvwLJi8dPJCHHQIukG7unwQ8WtuATyLUihFzxLoHnVLGpkmWhym7OUU3VSyJ
 YPBvvnHtdsoO0UoX1oKNkXodQd8pLL8g=
X-Gm-Gg: ATEYQzxk68Vqaj4FXdDUNI3D0d43y8ctDqDXwfGU68yXS2QfkGXp9DG+xh5ZSMbokS+
 nbrYpheh/QJRTJMxjgcbNEbf7D47eOQpfryS8NxpVo83YCJmSc7SJkIUtTAx7fKApKjy88/XHXT
 1JKWevIvw3l4KJUTH5F9+7TZhyCCgkUSXA4sIY0bfXSCRx7GwHjPymu3SG/3KHKP4giISORhn/+
 cfHBgiEffi07Haz5+xn+5/soT1dFFyUpE9WeeG9bV2T1YEAAsaTagFHY7Yytq/ponzKZEYT+iH1
 DhcZ2pTFgX0q7+SjhDJIIiLIwoXxOen75MZ5Sw==
X-Received: by 2002:a17:906:f5a8:b0:b93:c5a9:a5e2 with SMTP id
 a640c23a62f3a-b93f1176dafmr33670766b.6.1772600464638; Tue, 03 Mar 2026
 21:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20260304030816.33209-1-jay.chang@sifive.com>
In-Reply-To: <20260304030816.33209-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Mar 2026 15:00:38 +1000
X-Gm-Features: AaiRm50kuzVP2yx_2LOIKeN9L1APC5bM7QGXofv5pCQuozSmn99jHhMC32vu0ZY
Message-ID: <CAKmqyKOjPYPUsysK7cQKHBFaPBa0uXJ-J3-X_ohJe1OW3SecOA@mail.gmail.com>
Subject: Re: [PATCH] hw/dma: sifive_pdma: Set done bit upon completion
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Mar 4, 2026 at 1:09=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wro=
te:
>
> Ensure that the 'done' bit is set upon transfer completion, even if
> an error occurs, since all transfers are considered completed regardless
> of success or failure.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/sifive_pdma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
> index 6d06ec0375..7b22e51492 100644
> --- a/hw/dma/sifive_pdma.c
> +++ b/hw/dma/sifive_pdma.c
> @@ -153,6 +153,7 @@ done:
>  error:
>      s->chan[ch].state =3D DMA_CHAN_STATE_ERROR;
>      s->chan[ch].control |=3D CONTROL_ERR;
> +    s->chan[ch].control |=3D CONTROL_DONE;
>  }
>
>  static inline void sifive_pdma_update_irq(SiFivePDMAState *s, int ch)
> --
> 2.48.1
>
>

