Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82303F01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUi7-0007zN-Il; Fri, 06 Mar 2026 07:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyUi4-0007wY-BW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:55:16 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyUi2-0005xD-DE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:55:15 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ae222d978so8812778d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 04:55:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772801713; cv=none;
 d=google.com; s=arc-20240605;
 b=bdt6uIPq4xlCIt8bZYE0qA0YBDA6FXmBar1B7rqpyz7F2Ht5W0u5sBEcoA2u6Nj6s+
 62BDvgEY2+Nu5dWOfyldFS2MdwjoSZ+qL++BMl1hJhjd84YcE4cmQ0hHsAjId+HjS1xD
 eElARE9nd8lOjgoQAvA4zJCMkCXo/iQ9gpb3YFbMS1ylkHBhFOk1Lt0OxKmuj8nZCOKB
 8s31BXgWTBCc+pne7vlFNLCeSMQjEZY677FcJWAY7HijUjal2NyVQn+DBYGpUcPtHUB+
 2Ovo8zF7PrEBEI4NmUKvXt3xH4wntNuzFco4PRnVBSb/cKfxaMf4nJvbrinnQJaOzmBK
 r0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zLZ5XQi3wxMRFR5Uc3e80yxjBAASCbrgfZjbhYmh57Q=;
 fh=7nIYNV/zHmiWJg+HPMkRRPPgN56L8Zkg39I9U1zf+Uk=;
 b=BYs6Pjzo9+wTUro6F8Ay4ObspfB8QZAtK2JdEztw+0yH0HCV/+zrdJz+BNKT2kg5wH
 c3rWyglU9hzX7L6bUVEYJtR7riiDY+0fWm8y/ulK3/KjbcvRzkMEd3AfNtezaae4in8g
 rLeuA+Xksj0gOTOZP+h5/f9j3yj70P6HbECLM/Y7KDIYQNdqBa5FaaA+/a6b7POVCJkS
 3Rti8ESFjmclx2GSvcDo8cgt4LnhkDNECJ46nYFMBF5t+iMf2fzh7Mq7ez4JUnQ26jiC
 xdeIbS+7htTamGpsHxsl9qe4cc5jJrj1bzNHMNwuQwsVziovyCZNSn3wvSJfZogDWbXL
 /WgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772801713; x=1773406513; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLZ5XQi3wxMRFR5Uc3e80yxjBAASCbrgfZjbhYmh57Q=;
 b=vtxE1R/HDdiPo4dcVzBE4nUnpb1iKCTs7EmsAbqoa4OTUdUHsBlTuOscK+CEg8vUHE
 EDnM9MiOEf+GUBwIQKhiAiMoWsIXsuyW6tTraII5yp5CB/9T64ezMTBUkqDUMCsjgd86
 lK9w5vmwud/GXa31j9jaoXy35cN06i1iDdAOBA/2N4XawXIxb4pjC99slHFKL2QWTc9r
 inOmoesCskltNunPJaQfJyf8H/uwAdy1OUEcHb/Iuvt7ckMmNYZd5UEHrHk/+qVfEIsy
 F2LOAhZcAePRLXmd7klv94Yy/bh6vd3BICF82FicvWt+0Z1hbstJAFkWhjovJRmaC0Hr
 oYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772801713; x=1773406513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zLZ5XQi3wxMRFR5Uc3e80yxjBAASCbrgfZjbhYmh57Q=;
 b=qyHy6fZ/j9BMWuUnpDMV8E05H4sacTLaVBAmWEotU1ApgZ1U2pLJmUBtOW7HnkSpeG
 YXRyth5gqOXpwxubGOwl/2gL5IT4H8xuWWSfToHbue/mkcF7JfT1loS4KhgNWLn0dWbe
 1j44M58l+wzW4L1Nrw+C9q/tsF3WaFJhgj7bG4CpcdejQiPDQbl1BxKfR7sq+onXvEnJ
 5ZB3dGwISPupth6HrWWC0t4BlirIl+jfgR/YszE0uSmPHN9zzFI6hcXGuQXF1jxJ2xIg
 f7ke4ehPeL43iNjNVzN61nHnK0/5X9kLqDJWoMuVfVG4CPl48yYPvBL0HDLqoPDVPkNd
 w4Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9JS6J7Z1wFkhtNcuB/7B8JDUF/NY/J2ZtTVH7D4aV1kX+luKrXdIMPtmp/LEX6oztjlTOCRm1zU2O@nongnu.org
X-Gm-Message-State: AOJu0YyiAbK/K17Iu80vceVz/DiNUaDSFSYmhpr0Mgi61zTi7Xi8tZcL
 FZSWOXsBvGOXZ+XBTBULcRQmNxMrZYxMnik8jDrwxOTQ67ge8dQc8Cr6moq45ddnjHPnn4r4bJ7
 9SV8PUhXEFprxSRrVjcBeVkRYrloDorgzRCKLHMsUUJAAKyI68GL6
X-Gm-Gg: ATEYQzxC8UfSO04XazlwArmGaFP/vR0SOk7lgLWSlrmL7HNaU7WUoniVJpuABZlIBp/
 dx+TxQbMq9L4MfAHqDnpGLJ7aZu3EPpL3MLGcFWQHBm0Qph9LK3i5bkj7NogksYqIIHJIrOHVNk
 +fdp4Dt63RfGBNiGPt8ZhtjozFJ4sSaUPGhUS+UcXMon7HDlHWzIIw6yfNPGg06I9vOZnGUUe/Y
 W8SfnxYud77c+4NeFjtt3fqxKL2dV+mxGnZfZyQjuKgIrv41gG376TKhuAY2wwFswaj/Jw/ccCU
 eB0BS3Wy+L+sjO9etONntAowDuUXulkyZJQhEXA7rdr19Y/tej6XYUcGablpbR0tDEE=
X-Received: by 2002:a05:690e:191c:b0:649:e501:21af with SMTP id
 956f58d0204a3-64d1407efeamr1690715d50.14.1772801712546; Fri, 06 Mar 2026
 04:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20260305175711.1119025-1-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 12:55:01 +0000
X-Gm-Features: AaiRm50NA0K-bBGJPO62ii9Vs0LBZqUlrHmxj-_xci6bijdT2fZbOVV5-Eqn8kE
Message-ID: <CAFEAcA_dAZird_b0kPTaSDu0oBPyBkobj92xw7haQJR53jvgKQ@mail.gmail.com>
Subject: Re: [PULL 00/38] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 5 Mar 2026 at 17:57, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit ae6e281633769bbc7424523d0ca1163e214571=
ad:
>
>   Merge tag 'pull-loongarch-20260302' of https://github.com/gaosong715/qe=
mu into staging (2026-03-05 10:48:38 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20260305
>
> for you to fetch changes up to ee357844b13904a826ffa77834cd08e10ba1e9ba:
>
>   tests/functional/aarch64/test_aspeed_ast2700fc: Update test ASPEED Open=
BMC SDK v11.01 (2026-03-05 18:47:46 +0100)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * Add I3C support to QEMU, add an dummy I3C device and extend the
>   Aspeed I3C controller
> * Update test ASPEED OpenBMC SDK v11.01
> * Fix DMA64 address handling in Aspeed I2C model (AST2700 SoC)



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

