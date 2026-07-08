Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89291C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTwX-00040Y-3C; Wed, 08 Jul 2026 11:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1whTwV-0003zo-UZ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:12:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1whTwU-0005HY-Eq
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:12:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso830689f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783523524; cv=none;
 d=google.com; s=arc-20260327;
 b=IAt6mq1V+mHIjOeSjYZgecThAhDZBWHznn3sUfx7uohQEsnvERDWM9H8QDJd5/HWD3
 wadymtXcQ/vU0BK++WGANmEHl7V+4LLSBmHrVsVINenD2DGwOx2vHO0JM3e36eP3zizr
 edn0jPREk9w3mR9Qar/f7Zr48w8HTFOLkSU6u9VUu/jAYdds1LyvN/DefbzWD8p4pr2i
 vhLQDCOu08CL1pUAOm0pLD+Oirn7Jm1XrPBbZyIc874jsr26Bxm/sRSzJ4hLfOtTmgqD
 IEQMng7YdZuh+3FXHMUsJEw1HaqsZTkw88tiEa9QgPj0CR3CUDwX8PcG3SxALtZza2lk
 VIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3a1hWsoVamXx8LIAPUq012ps2y8ekTt6uWioV93hNlk=;
 fh=PgvuDsSrN5tO339qb9tpnPzNGxQ+CWeig4WyWwbLr+Y=;
 b=OGue2ZtAxSw8g7m7035rvY0PVBnWa9yhT2/qiMXSAZF0LVEb195ep3y+C+Ij9cbrb/
 tjIr+Sf7ktVnn69zqEUv9w95pTkb5HS+kbOoAEhJpYOQI2Q9sqpEXG5DneshroLOJsmZ
 ZSuwVbGVm+pAV8s0B/PQXrcTqJeGLLNge1nfWxDKYkcnaCp3kNryU0IpCDxMJrijT7ol
 pFVcYP2SsMkO1IT7ntZT6rLl7ksBVvM3+r9gmLwDs4E1gU0xcKX0/s4ltD/OhatDSDui
 1/h7YmGu5HR/rvTzjhkudLqa9v8ZTv4wvoE7AFMsPjlKyaWK9Ixc2sHkAZztitZhoaS9
 vHFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783523524; x=1784128324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3a1hWsoVamXx8LIAPUq012ps2y8ekTt6uWioV93hNlk=;
 b=eilNnxNKCwVtW3X1Rx2mNa+x6DZoPawlXJ417ghZ0gWuP3clAr8swCqPuGaJyUPMhP
 I6RCNr0xh2mn8ZoRw/kLBXHxdE2oY3f0B7PK2PHAqp6cb9gqxVGljLVawU0uDKXq0jw3
 zImG8COEtO1043dcRQXN7/ue3naNi2NAC17WSDP8dhCjpcXwmiaThaa4SFMHwXlsaO+w
 +ECKzKsbO/O4g9Z8Kr/BWyhR7kvPDLm0iBbWNnj3EafU9WY1Dmdqex9FMnfJcovhCYGy
 dKZxIuAeokTYyWRJboAhq9SQ9PLiibAo6l09Ej1xWiYCKxGrsEjJnObFxcJ/AA5dhL5T
 zpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783523524; x=1784128324;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3a1hWsoVamXx8LIAPUq012ps2y8ekTt6uWioV93hNlk=;
 b=ki0redDONg3AwaBle90cwkCmH75/qMmo4akvRxOIfeg0rvfCzUy0rWVm6VjMXdCFcu
 wnHNKOgtLWBnt4I4LQvCGKNXqcJOJ09TlU+kkJBM21YusyuiEsUsbvsW4sYQBKtFHqEU
 7wTbrsgPz2GKpfepCatZg/rlLxgItIbP3fAYdGyvin5hu/TqIwZlEzNuIkHQO8PsleZJ
 kvrID+xd5f5SpkJ+abBF21j0cyR8bwqSlISzUbLNy1L1IykshDxUvC9zVab/0wOEzzeI
 8MOQy+xhgizk6GPMvsAZ4CWTX1Y1xNxGeF1eAwCiM33raBXhIARmU0zJLwtksaFrl0Bo
 b19Q==
X-Gm-Message-State: AOJu0YyTPPYfCQBhOgGuzAgA87+6tjq/A/T/carpqWayJYM8OOGv+5sP
 hhGhdk1MTo/MXX0wgCUweWv3wkG5cIv0IZZFRHFk2o7oxvxRmwnYDeExOouQd/Rp26rHA4xFobA
 oq5s+W3UhiLh0WHqlqUmrTUGm+ERKGx8=
X-Gm-Gg: AfdE7ckRDIIlTTBH0CFCYO3VmDvz+HMGJ1iO35XHAkhImOJcHcElTQaPIeptv6+CFdD
 0A13vjCGoXHn88r0ddH8q0as8hI+Rbz0XZqN8ef9fidqASHBlCgG6NTpVkRBEPvk6SHzmoyQA/T
 gwupehQL350636xLat6BiB37Ue/WJ8xF4kjqf+gTsa/FGudvPQ8LTexb1ek3Dk7kLiszg5gUrv1
 t32pVhYlMWSkH/ihuOnPo0uVaNH8VmKbaie7huGUQISEqUIsSAbCnbr3bOM4oJVFCFN0Wvv7qu2
 XEb14xkk4w==
X-Received: by 2002:a05:6000:4028:b0:475:c578:b619 with SMTP id
 ffacd0b85a97d-47df0797e0bmr3537040f8f.30.1783523524102; Wed, 08 Jul 2026
 08:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260708111544.1440761-1-clg@redhat.com>
 <20260708111544.1440761-2-clg@redhat.com>
In-Reply-To: <20260708111544.1440761-2-clg@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 8 Jul 2026 23:11:48 +0800
X-Gm-Features: AVVi8CfbYt3qSsXmCFYz__O7sq8kAHfp2j05SKOTq2DUih6oFmgKDry06GRsE1g
Message-ID: <CAEUhbmXns11jBwfc5ySZkbYx=Ss3ytG3q5VAAG1D+yevXfKywg@mail.gmail.com>
Subject: Re: [PATCH 1/4] tests/qtest: aspeed_smc: Introduce read_page_mem_fn
 for page read helpers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bin Meng <bin.meng@processmission.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x430.google.com
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

On Wed, Jul 8, 2026 at 7:17=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:
>
> This to prepare for fast-read variants. No functional change.
>
> Signed-off-by: Cedric Le Goater <clg@redhat.com>
> ---
>  tests/qtest/aspeed-smc-utils.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

