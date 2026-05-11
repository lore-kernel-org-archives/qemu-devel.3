Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9F6CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSCv-000485-PE; Mon, 11 May 2026 11:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSCu-00047B-6d
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:06:08 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSCs-0008SI-Pr
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:06:07 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65c7a459105so4866702d50.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778511965; cv=none;
 d=google.com; s=arc-20240605;
 b=S8G/Wd17pTIbZGt3ImJNM+dd+sAGsN/O0BADzYekP5UQKYUUKyAzdzVh0lN1rpyNxV
 ffKxqgdJ2VOeANctj6E62/J/OaoczgP1HvdkCgzC7CpewuhyocGr60PLqpQrEO6N99C9
 jh3zb/eb3YiggNewH7QfKkqDsy3bfPYXQC4s+B2igj/A1JDPfUE29gRtzywnjL4FguV5
 76jUTTvzJv0iBi2yWvyVC9DBZgR82LilRBovXekhlqSLCSrubaEq0OfoNw+BuufgqGy0
 VKzvwoOVTjgLqNm1FQqAsUBHjodVww942UuDAQMkGUaWXcuitgPE/djex2LcU0kQozFT
 0AGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uTuU+9FyNiyOJ9A+d6CfzbFA9DvI8QbQo7S071yxPgI=;
 fh=Q5JM97DADZs4DQbO3R03qnoWme9tz+UiTOuol6AQ9Q4=;
 b=QWwNbbA4+xetV48f7uJOuQRWAaXwccoO42/O0PaVlTuk81r1kAT5SEgmeRo7sdW47T
 lux8B6VGiYWBoUlYyW7sAfSO0cRXJ3HKVVI3VzTVEo/iDVIiQvwro9mKgYJ6f8SEeNg+
 UThlFt5VzMXLPl3O5S0n8neNPGdrdSPrDmIxgxHCgpXOuCoinCHriuWwRuuxSGQ5wIcO
 qErP5Lm0/TVwf3Ii3NBUZHb+8ikT+y8wC7VCV9FhXdJMb2z5XNGITs8gcCQVA2w+hZjF
 6fGdjcf/EeZ/dQTKetxhtrntujUrm+gEsXYDiRBhb2Ij1s87dVlqlGLXtk/mNjSy60rg
 ZySQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778511965; x=1779116765; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uTuU+9FyNiyOJ9A+d6CfzbFA9DvI8QbQo7S071yxPgI=;
 b=VKZJ4PYtOCQhtwQIQ1f7a+Mesg2LGskjCqJujr3Uo/gHiUpYxDQlXM5yKrM13TE/cP
 q4Q9QVzPO89QgkI4ZpwJuVtapBoaJfxhqcxjFzlGVaZDPGHxkbuixs3Z9b2N7N1+0znY
 8i58MKAtDocUgLIDzgZEAsZIwrGbOdE8e3oL9p54g1WbGHsaP/jT3D0Dwpc3IKaJ012H
 ov/OakVZXcDQw6okpJ4lyKaqI+NjjCmTFWyhz7KpSsKLxdOOPV145s5h9LFqqZJXXYTH
 GL/LSpgTcKUKkg+vFJYOzcONH/ayoBJDqvUqtK4wu5h8vukyiVqv2eFrk0Yb7Q032Jrs
 O8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778511965; x=1779116765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTuU+9FyNiyOJ9A+d6CfzbFA9DvI8QbQo7S071yxPgI=;
 b=cYJgR2007y5Qf+/ANWIBvMJJkcBlXewPZ9Ho37xqtqL+SvzWhHIPW7JZhKy5DQCvuN
 VK06mUBzKLs3bR/P2+RW6ZmSE719J5vxknfdEPjafXvOSR8abjW6+NgZOeV8OdxtSDlL
 ic3fzPJgTtka39gTorXEwA74LGxTw8y3JwYBh9w2AUgqWVdwY9UjiqxrMIk15Wg/XsQj
 bO/DrqqhjJ6SiczTzKxnKNpr3mK/jOO8Cf/ACJfIhi5M6Fn89Sl/sQc4WJLkDASkH49h
 hiqNT6s8DDz4trwdGXCfhAkXnLG/qmBzFpzWIsmKTSU6ZrjKyXq+eKa/U3deiaIgzjNm
 5NZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XI4ba/L8pQSNglPuV+7av7LWtnBl+ES5HrUj74WeysgHo+EK3q92X3skzuoaC6y3WzpBccSzTm0mo@nongnu.org
X-Gm-Message-State: AOJu0YyETJ/6AzBa8jpRwCaoXXYLnNNhKn+R3mtmYoRRn43QCnrvnM57
 2o5De1xWXXxoJEs0lCJvvCLw9xhN1nNk1FDcHVAudiib902r/9BeHwxP0O9LCUNuc8DCmYN/xrv
 GkaZ/YRsvFAeNjo+habm0VimFO36RfDKZzc6jl3lmIQ==
X-Gm-Gg: Acq92OHSwqpSrPTO/DgVpkpAJVnVcmWTQkim58ls0o5L/jM3R/kHhSZCX6IK3Dfw6NQ
 WVwWSbxSCmQ69mrnkuQZOaTqp5cHp7sw1xaTvy8q3/sgQpC88O5BNou8tukl4Es0jMDs/WMxwHZ
 55qG6vyg+VuiP+FlCJT54cg1TDiMvkZ1w8ipl/Rgzm2V2WetXYRubahIGqlY+w0MIYyvck+zMqT
 74FZIqTuTjc2DbbCRSfvItH3ogsK0J8wN29R3nAMp0/fIXuNJmsluej90n+a9KNzJtn29lnTR03
 jmtcdKE+1UmCPTNVuhQC6P3SvQaoDBMahapv3PhZ0yRZrTlfBjT2inot+f2/zxVS6rc=
X-Received: by 2002:a05:690e:b8d:b0:65c:290a:d7ab with SMTP id
 956f58d0204a3-65d7e75bc01mr15098649d50.11.1778511951823; Mon, 11 May 2026
 08:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260511115918.32765-1-agarwal.vineet2006@gmail.com>
In-Reply-To: <20260511115918.32765-1-agarwal.vineet2006@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 16:05:40 +0100
X-Gm-Features: AVHnY4Ke91dV5vISBLDe6PVZ8kMDUUUhJaKTJCMwtNs5iNIeBaYB0pO7w9GX8GM
Message-ID: <CAFEAcA-05wGy4rkKE_01PE7SPqHv3Wk1VmUan0afBaYOhH2Osw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: fsl-imx8mm: Don't call qdev_get_machine in init
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 11 May 2026 at 12:59, Vineet Agarwal
<agarwal.vineet2006@gmail.com> wrote:
>
> Calling qdev_get_machine() from fsl_imx8mm_init() can trigger
> an assertion failure because the machine may not be created yet.
>
> Reproducer:
>
>   ./qemu-system-aarch64 -S -display none \
>       -M virt -device fsl-imx8mm,help
>
> This hits:
>
> ../hw/core/qdev.c:844: Object *qdev_get_machine(void):
> Assertion `dev' failed.
>
> Move the CPU initialization into realize(), where accessing the
> machine state is safe.
>
> Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>

This is the same fix we put in for fsl-imx8mp under
commit b67d0bcdd. I've applied it to target-arm.next,
with a note added to the commit message about that
other commit.

thanks
-- PMM

