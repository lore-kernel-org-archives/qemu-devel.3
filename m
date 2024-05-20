Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7604EC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 07:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8xN3-0003Gc-Hd; Mon, 20 May 2024 03:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8xMj-0003Dj-3u; Mon, 20 May 2024 03:23:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8xMg-0005dZ-Vr; Mon, 20 May 2024 03:23:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso71116425ad.0; 
 Mon, 20 May 2024 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716189801; x=1716794601; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZcQ+s8xLlRETDW2xdAkOxokBoEWt3B+/PKVTwotr4o=;
 b=dggu7R2HX9ZWNetwSb3JJ245ZirRHYAZBnFojZ0MlBmdeoqbSTZ7emvpwIh93OO5wL
 lQ9mIvm2dbg2sOF3A8sqynW+Q3IRrf8Be1vEzKfqsjoo6AhwW/ynHaqIQ+88FPWgqPgJ
 ETjxbX2qlPbAPy2X0JNBIw8+siRZCdGA4Nk3zVOYdkUghLu0joAHxCIxZFeScEPo2wCL
 lilwoIEy0/KykZlrxWmJsprStX6S0/Gtk6yOL61ujJUAl2sL8uBxG+7Bda8VxB5tRzR8
 GYGgS5iOYYpdxRvdNwLWyY7L6hJ5KDQ/9RzSME8Z+TgAhQeTG3XlFI66LBAV9DL11sEM
 AirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716189801; x=1716794601;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aZcQ+s8xLlRETDW2xdAkOxokBoEWt3B+/PKVTwotr4o=;
 b=O0wqtPY/tN2xqEIZpHlo9obAwe4GSgYWrUzRyKWSOe+LzjdQKgYQ9cktFUP+okG98P
 aqqKUnzUoz5Q/hIP+jMlVR8+8kOytXLcaLoYl5DquPe9JTEHTvwGKCjljkGV7UApjN7A
 lZdyr08VjR2hbqPBO/rAgL/IzWRrwmsOJa8kzv3mVy+ujWV7g3gpaf1/Bf+tQfo3on7V
 aSBoG0V4gcUlPACPSNWy0RaPaT9y6PcB5PatxL/Y6IR4gRJgM+WNeytmSz1/kmlhkKtG
 eUvB3t66IS90Ok2VsPRZkWZ3B6UO7UmcXXdvoh7WOsOnANo5TDJGS8dlXGfqmwRKZ99s
 cvtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUsFmhB6hVcAPUEuqX6eDcGg57lO+wqBYpAIzFWNxjDFt6Wcbbl2H4XhGDc/7Yd8ADvDzIWeQXRHH0IeG13Gw19bQ/
X-Gm-Message-State: AOJu0Yxy/93/fMiMPE0S39+tP90pitA8fiJBAhk3Xc/eYp2HXd/+SSyg
 GP+CtuUJd1vFRBeQh0FmPBuorRbYxBcDbn389Q1Sbx3eG4LYcD65
X-Google-Smtp-Source: AGHT+IF1U/lLCBmiMMClaq4QXqIoRNh5Y8k8Ly6c/LstXYPkfZMq5lCQMWOa8CkGsrLp6f07N2mfMQ==
X-Received: by 2002:a05:6a00:1ad0:b0:6f4:d1aa:bbe7 with SMTP id
 d2e1a72fcca58-6f4e03bf5f8mr31731165b3a.34.1716189800801; 
 Mon, 20 May 2024 00:23:20 -0700 (PDT)
Received: from localhost ([1.146.114.227]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-665eaa5108fsm3149589a12.7.2024.05.20.00.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 00:23:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 May 2024 17:23:14 +1000
Message-Id: <D1EAIBNXFORP.201F1G7B0M67B@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Glenn Miles" <milesg@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/14] target/ppc: add helper to write per-LPAR SPRs
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240518093157.407144-1-npiggin@gmail.com>
 <20240518093157.407144-10-npiggin@gmail.com>
 <95b4f2bb-3eb2-477a-b2af-19cc4ac5849d@linaro.org>
In-Reply-To: <95b4f2bb-3eb2-477a-b2af-19cc4ac5849d@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

On Sat May 18, 2024 at 9:26 PM AEST, Richard Henderson wrote:
> On 5/18/24 11:31, Nicholas Piggin wrote:
> > +void spr_core_write_generic32(DisasContext *ctx, int sprn, int gprn)
> > +{
> > +    TCGv t0 =3D tcg_temp_new();
> > +    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
> > +        spr_write_generic32(ctx, sprn, gprn);
> > +        return;
> > +    }
> > +
> > +    if (!gen_serialize(ctx)) {
> > +        return;
> > +    }
> > +
> > +    tcg_gen_ext32u_tl(t0, cpu_gpr[gprn]);
>
> Better to delay allocating the temp until needed, so that you don't alloc=
ate one along the=20
> return paths.

Will fix.

Thanks,
Nick

