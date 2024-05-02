Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FA7C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Wwi-00033L-Gi; Thu, 02 May 2024 09:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2Wwc-00032Q-FG
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:57:55 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2Wwa-0003a0-2q
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:57:54 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5557e3ebcaso331353266b.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714658270; x=1715263070; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=92HnkxTqtaxUmTU8QRZTs7D7UntS+4OAbbTuZ5JNnrk=;
 b=JEj0fUIUsat0pYrWfucPF8u4fmUaTf3z6PNRUtxQ/vSIfUNUrfB3k9hBnVJb1ihmgR
 ZFtOFqJDeyENajE/CrA+yf0Zjdrcr9YU9UklGyr4roHw8g1PxgqDs1Exlr9dGBC3r1pD
 y4WURYZZxQ7gXLuW8T0SpaPFki4Y+z2mxzAxF0S3NJoh0M/ZxZfMT9q0Ft7xvC6PTkvS
 en5vmTbrr3JcT0TRSfU4RmM1qAWAxdk+5y19rOXTLV+/ZjdGBMJgxKOvbzQw2/H5YhFM
 YYdmVxbl+J4pp4vwjDD2Xo+RMyLYWzez/ZOnDRc3hjIRhnoEgTpZOVHgted0rM+pTv9n
 EU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714658270; x=1715263070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=92HnkxTqtaxUmTU8QRZTs7D7UntS+4OAbbTuZ5JNnrk=;
 b=jtXTlGfbI8zGsEJIkpGXnRwHc0+8qR60XsaQ+pXyt9D5ZOuuHEJFHMER9O6sWuT50x
 SBiQQyXDyxMNGTGigA6Um1MHlfdQaR+AqXYd/naFsu/TRaOmlrR9VePjAWXpis62pTAt
 3QND28cYNwVWqTpgpotxs2txyi5R6evJmRY8goycqy/twc6dsGtuogl750iLlBuAPDL0
 YXWyg4bSEIrR2ETms+xpTogZGpitlVGpNHGm5UzSZYVhGRKZ1iX1vM8XNYZcfvrRcHLW
 xGSYYeRvoHz9KlHSmTt4XGIrTPWB7EoPBsXe45u5+R0ePbqWcmB9Ok8Xu+CdwJ15o6y1
 fk6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbudbGqp46Obzn9W5IyoGN29J3h/7eBfqZd2+6crw/4nlcIPM3GBVeIpvU2G3DSV+qr0jS94q1+Ueaz0GBkEuNw+TVaV0=
X-Gm-Message-State: AOJu0YzQ02DECXV8FqcOVcrtN5ZEvdNYg6GPE+SLjt+U5CmzIyjBshQB
 jJpOqyEviMZLLn4RvJ6uOqbYF7+eTZItT3IPLujVDo2LYlBtHQsNrnm0CkWE7M866rqTxyYPpFt
 Gac4pbnE+bBGWN06qBZZSxXTRDGTW9pQvfEEyiQ==
X-Google-Smtp-Source: AGHT+IEJhBn/tNCC5K+M1NX0STqrd0MEovY4rtFlvhdgMPk8QSHjPngkHV4SlRyrhmu4i3a6heiIbQrP1JpPgcqZsn8=
X-Received: by 2002:a17:907:7d94:b0:a59:5693:d709 with SMTP id
 oz20-20020a1709077d9400b00a595693d709mr2713948ejc.30.1714658269861; Thu, 02
 May 2024 06:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <7c6f66bf-2610-494c-9389-b558a11f8c5f@linaro.org>
 <CAFfO_h6-RXettxqnCYciDrq6ivsTHtM55FcksJSUNnLdbio4mg@mail.gmail.com>
 <c696603d-b8dc-4fed-96f0-da40c6ce8287@linaro.org>
 <CAFEAcA__6PJwdYLTuGbf01YOaV4t67dtRtbAbnP1eL7dd0YH0g@mail.gmail.com>
 <88e97ffd-f308-49db-aba6-ea3b9c308d21@linaro.org>
In-Reply-To: <88e97ffd-f308-49db-aba6-ea3b9c308d21@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2024 14:57:38 +0100
Message-ID: <CAFEAcA8ynOJtPazJ9D0M0nrbDAp+gHJzGjLSHVC7PunG42WxRA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Thu, 2 May 2024 at 14:50, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
> Both hw/arm/sbsa-ref.c and hw/arm/virt.c build cpu information in
> DeviceTree using "arm_build_mp_afinnity()" function. So if firmware
> parses it then it gets wrong values.

What wrong values? The values in the dtb should match the
Aff* fields, they are not the complete MPIDR_EL1 values
including U and MT bits and so on:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/cpus.yaml#n42
AIUI the ACPI spec says the same.

> Firmware should probably read MPIDR_EL1 directly instead but what with
> those who read DT and rely on this value already?

Firmware should probably not read MPIDR_EL1 directly for
topology information, because it's too vague and
unreliable. Either it's real-hardware firmware, in which
case it presumably knows the topology already, or else
it's running on QEMU, in which case this is one of the
things we can feed it via the DTB (either on virt or
or sbsa-ref).

thanks
-- PMM

