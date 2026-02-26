Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D31FC592F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 11:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZWT-0001ji-2h; Thu, 26 Feb 2026 06:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvZWQ-0001it-OU
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:27:10 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvZWN-0007RR-Ok
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:27:10 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64937edbc9eso564532d50.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 03:27:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772105226; cv=none;
 d=google.com; s=arc-20240605;
 b=CqpAUUzBoux3zMDjQoaXzHNlVjvX9BlNQfDt+gbnQw+ZQH/E6jyVcvYLB8VnlbpjUD
 5Ltl09K2BToCrqpOiAAEyWtb1UxDfLtj/IVJCDnvTv89v+pI8c+61uGyrNGf3I0hAOHB
 osA1Nl/nFeNLz8AncNTnjZMKVRJl1cCJxLVYkTnNEuDvOamvhS5CztnT+bo2Scc73Kx+
 HH2XdiBZ3i75yS9ksD9g71rLitpDjZR0woApQ4dg4Lzv2Yb0imhe6dr1nRhuxSynXVLL
 +eZ14ThXvybj4cTmVExJ62B+Ep+dXZsMu5sIXNPDx+9PYm4TRKo+rtCfdm9bWhJse6tZ
 SO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JzOhWwV1LkmXxrYyweiJgKjm61/PJ8xKblWJNwIW4X4=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=cEcck682ewzFZqgubA5hog5FR+WyuldMhlJtiI9FT5BLoyUB5fndMNFLJoZpzLfRG0
 YHTjPCKveu0u5IWbUiGgd4eqzAgLDWjQK6EMrUO2153KOO6EppHMwaXyxMt1qpEKWa5E
 yzd8NI2ZMyCm+gLCdhKNEkEo07UfQtU/vcWjtqQ+UMnLkd/vqb8XgunydIAa32AtBznk
 KbiPzB2/e3UMB0UjyNlT+n9a+bvbpjeYHyum1W4GbyesrRHj7OCN93eDHrMLY6s/r9QM
 50Uo4dDY609oFy41TIxcaF9MWzukiweuIu/C1S1HLC6onmGe+alLAp6P2VTmBFieRX4Q
 FD+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772105226; x=1772710026; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzOhWwV1LkmXxrYyweiJgKjm61/PJ8xKblWJNwIW4X4=;
 b=ja5AW0bpTqNVgeRf9c0uUMvTSaqhu7NBEdnSc16OrUJ0KoqSPWFrrlHXbBD0XmRB9j
 Z9Xwk9xDKrT44GrPUprTR/cGSKF6cwReQLEoTPg9Fi2fG4F7eo4SpEfSf3giVAtYeeRP
 bXoxwXfeo/VjnJuz2Hr1IUlZeAJ+2cX/+6w8JIMxIhJ3s1LWP4gMs9vvNBgSoIurS4YL
 vsgFkI+OXRSx6+6VnJiM9Cmrf4jP8pkRONCZjT/OA3YDcHbV0+9U7GH2O+kE8/P4XTV1
 4dieIVXdFbEsa21XurRX1Jpa11XJ36r2MVOcEhfEzWVG2uGrHtVfNJlbK50nAuWZYxlO
 /dEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772105226; x=1772710026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JzOhWwV1LkmXxrYyweiJgKjm61/PJ8xKblWJNwIW4X4=;
 b=KUKpaqOAAmOV3LK4i6yLQX10T4ZobfNMGkUnGUYfT+mRB/PidHMqY1N8CgGDcfX+Zs
 s8+c/RAsO/1v8gO7as96VYtE2i1MlTgqvrvo+x2gDdJ5RqI5PUl7RcS/rRSwZiKR4Pb6
 3HsbRnm7EUlmcf57qOmx2MYRczm80jOF1koqu4rgtEFTM1mxmgBgqbRT06JqrxUZ29lR
 5hoT7xHqV2tSvthBc+BO42RY49BLxohKFQ7waEy7KWPLkERGOnlLJmXBifpxeGDi9R2B
 K4XJb2RlrEKTzGgk5P9928pzzP5Dq/D7jBgyZr9CZG3xv4Tpb6rZecK7cSUpZ8NuGwGE
 ZqYA==
X-Gm-Message-State: AOJu0YztMNd9qwUKBSuF2i7KEEApFniAQfO8+R1LZKrs7GiUVWQHhXNH
 DXLdEUuDHi5iLT1egXXuPZxth8IHaFfa5QhUIJuGTmbvXYVnZzO5sM/BGw5YYeM7dQMy5p+HIz+
 Rd1SOQtWDTzt1kyzW3SPXZImzC7pD2lj0VdNFwbM1XHHKbUdn3pk5
X-Gm-Gg: ATEYQzznWDLDbGGuY7VXA94B9IjdV6BuHCWgMqj1JDwHa+tSMe67BvjX93AaLbsEdhl
 TVmQiPQshXhvSHwm1NHgpCOZL+QsPMYBVOX5ne1nmVY5vTt66NssjMDojtlnJ22G22I2vFytmjf
 KG3eKKqwG3yJzq6a5dWQ1FBJvpOWO2OD5Xpa6qhyy19fz2TOGR6nWdOSUoTEfwOhMalaXtZbYcp
 HC4AnbLCyIbCSFBHIcHQW0IjOA8Kx+p9Vyg51qKGcIq5HkcRnaZ3JRxnUbyfVhsgEie5Dw1rrFy
 d2msNnC1WdAshWpMf+kOd5QTlLCt7LTJ7cOXJe7YG8I/ExzZ4U9tUc0M6SVZUgxNN4c=
X-Received: by 2002:a05:690e:2027:b0:64c:a4ab:e4dd with SMTP id
 956f58d0204a3-64cb22c7754mr2480126d50.1.1772105226284; Thu, 26 Feb 2026
 03:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20260225231411.96482-1-philmd@linaro.org>
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 11:26:54 +0000
X-Gm-Features: AaiRm52KDAoEUa2QX9roDo0_ioHsJrUjHCHaoKzk7p-s5LAHwRoJJrpsHXUisdM
Message-ID: <CAFEAcA9rBRMiLgk8FxfRTTM0Uf7qxUXqWvBqw7PWgL=s8-kc4Q@mail.gmail.com>
Subject: Re: [PULL 00/70] Single binary patches for 2026-02-26
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 25 Feb 2026 at 23:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 6593154e7d65f61d8f9dbeb98224731b7137c5=
3e:
>
>   Merge tag 'python-pull-request' of https://gitlab.com/jsnow/qemu into s=
taging (2026-02-24 18:41:04 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/single-binary-20260226
>
> for you to fetch changes up to c87bf20b072ebd26f2c4ff68f802ef0d69f72a46:
>
>   page-vary: Build migration_legacy_page_bits as common code (2026-02-26 =
00:12:12 +0100)
>
> ----------------------------------------------------------------
> Various patches related to single binary effort:
>
> - Remove TARGET_PHYS_ADDR_SPACE_BITS definition
> - Remove MonitorDef register entries already provided by gdbstub XML
> - Remove gdbstub ldtul*() macros
> - Build various gdbstub.c files once
> - Make qemu_arch_available() and page-vary common code
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

