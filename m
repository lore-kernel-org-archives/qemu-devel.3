Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8158ACD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMscw-00009I-Vp; Tue, 12 May 2026 15:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMsck-0008TH-1q
 for qemu-devel@nongnu.org; Tue, 12 May 2026 15:18:34 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMsci-0000HF-BB
 for qemu-devel@nongnu.org; Tue, 12 May 2026 15:18:33 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-65c305f381eso6502311d50.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 12:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778613511; cv=none;
 d=google.com; s=arc-20240605;
 b=ZDAs4AuFVJIhWL38I7PMWC0gYkhL+JFpQb9o6KK7A97HlN29SvQO+j/OoceR0/FnnD
 RTjX6AKwUhq0CXYmawMpZ65P/Yy2fLGbP5GFFoiV1QsTGwUi243+QbmMQGJIVxl0wHIa
 8k7cw4WPwDST6wDud9Q+FvXc+QWVfSHbRZbxVqSgScKDI4mgfqHA0qv0y4pjUShSUiJg
 1yl4f/GddcfBqcubO+Uk9WuSIuIlRjJBHvQrk7LtZ03Jn4jtGLyJUTGWMfdfNViozvIC
 9WBwTGiMMq8rEBnCpYwdZTgCjoiBXvB7ZOgHzMhO0h7rPH4sX0m1NiWYoNgbKvhAvz9P
 u+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xkcxdo+XkZKK1gJ+1DsaxJ1v8iMmDGIYTeh7Mq8MqZE=;
 fh=51Ccb4NYjQFwMse4N/Roq/vkLatIQveyB1tFlPgrUUs=;
 b=jj32mUQLg4943CEE6xKnuvT6pERN+LJrqpS0FPFv6EReIZegKyJlgPQ1qQsB4/M65w
 /W+XLLZrdMhWEo+UzyNL5yEidpi9nlpNeaoYtRMyWuz/I2gw2iZ4nZ7rF4nT7UoTmdl0
 YGzRvfJ4qigUjYNXdnGbtXMMEzem+n6wvhnISOz+rySmmquysEdbb/LgsT6GIT6lBF+O
 pQc05Dxk4oFQBSvS52w9WWm5wzwRVaNU0YzlYwfWJwaD2uZgaHE4oJPf5P7kTPci9tTX
 M3M+1CUedS4VC/clPUjg5Bd6bDdql616gFYtky96vErOsllV2YjBM8fuyecHC6EsuDTZ
 pxnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778613511; x=1779218311; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xkcxdo+XkZKK1gJ+1DsaxJ1v8iMmDGIYTeh7Mq8MqZE=;
 b=MrpXB5t1KTkuz1pwNxjvguOrq9rPK3jwqHDeCPYAHVfChNsdcHS0thQT4DYvf4Na6H
 Wg2m6A+9HkohtdKLu2WA/qkq+CcpeYZauG5lzjuqc0UYpK+pQYQ9hX0dE3WwDXQFWXzH
 SHJwof60DpLM822ZwTIqqH159ybUYBTyP+kMa1+CUPdEcec6lwPqbsiXhX2prOAdxOZ8
 9VXUMsH3/r1m4r5xMxowBdY40hgk7ZidTxM4aKhcp8LDTbkEbGl2WuFpd505YTipFYuh
 /0LyeKG+B4Qaxe2L1iAz6mH21WujcR2AfM1q8kwAB2oXfGl0Ke6LrrKQB7fAjb1M0Srf
 7qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778613511; x=1779218311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xkcxdo+XkZKK1gJ+1DsaxJ1v8iMmDGIYTeh7Mq8MqZE=;
 b=HlYD38bSmQqCxxevnF+KDmmKPGYJXgvGH8b52cB7FPexMlAvIri+WrwxkZ+85Qe8/Q
 6PVwkmBf+C1ahQP/K+LGOICEg9FO39aBmewohlIZPCiTV+sWBjTaNxhB0+mk7+ZYcDQF
 dLK6tJFuguf+9BXkVIm6yg68XONAmIpxsnfqFshcTbqox2yrGglRVdTaMwN4AfVW7tK/
 fLjxk2q6fDyk9+bFyS22IFE3U8v954t0Q+jborirzEH05iqsMHwp5SUavKLE7M5Ymog2
 U6KRl+orvnovV4IMrgNu3xNdFSONnpraCbrYrIh//zWkI/ihqMOk9tf6kpo8GDDK3UKj
 R5lw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nXY8Nvw/zJt3+urHj1XNqrmGV5pKKnjqvsGIoOfmoZu1TZcCuj/nTuM/2i9AWAyP5RFUTk5ZamU7l@nongnu.org
X-Gm-Message-State: AOJu0Yx6ouKE11Rtcb+ZFdwstOWB+fiHA7//6RxG1Pn6PfVHVvAhj3x/
 zmN3Y5VmVE6s4pE5wVyPC8BghFt9X/RUgqUk+2yvOEK5P+gJJgpyhYoc0XbmhtfWHO2c62lXXHq
 44aJMOeM3I5fAQaM9jbbPQlAhAncj5w57d+2wn5Y4EA==
X-Gm-Gg: Acq92OFN+jtkqFFhKCqfpGaJGyxjLhls+7Gshj5J0o96s9Pj2Ut8oiDPtulbdql0Vz2
 q98wUdR80QjWJyhq8QxnCmXwUUwImIB6PfCCMNazdHf/m2toSqA//YLpUcsDxekMdLjyZe6kZfm
 8X1ZpPNcCt2gHGRtYCeyqGmX0E5gwILyrM8wDMKf6wFA+YWiquXT7BMkEtU2WUJoBpMQSkdUmzz
 xspZv9KUL133JDnZdOOP4jjzpMQPJlwvDgDygaF9tpJ39cI4SudvYKzQhoGpO/REqoIlJ2UBdKM
 y7hYDGZsM6legvt6Y6GV9qB+Cehwin+BOugd/Oz66xnlq1yrnoO5h9AGL8BCVQgWCmw=
X-Received: by 2002:a53:ecc6:0:b0:65c:67fa:b420 with SMTP id
 956f58d0204a3-65df635cbd8mr214222d50.30.1778613510448; Tue, 12 May 2026
 12:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260410055045.63001-1-scottjgo@gmail.com>
 <20260427195516.46256-1-scottjgo@gmail.com>
 <DIGUN8EOAZ7C.3VYBVHXL4F06O@gmail.com>
In-Reply-To: <DIGUN8EOAZ7C.3VYBVHXL4F06O@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2026 20:18:19 +0100
X-Gm-Features: AVHnY4Ib3PGLLuv0WpK7hF6LMb44uUqzwHydMqom5gCeErbcuZA7o90aMz-Bsvo
Message-ID: <CAFEAcA8xfJKpp+Ut1+7V-aqbaYZOkUbUYXr9eT5Nhgt9y6XC2A@mail.gmail.com>
Subject: Re: [PATCH v3] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
To: "Scott J. Goldman" <scottjgo@gmail.com>
Cc: qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov <rbolshakov@ddn.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 12 May 2026 at 17:46, Scott J. Goldman <scottjgo@gmail.com> wrote:
>
> On Mon Apr 27, 2026 at 3:55 PM EDT, Scott J. Goldman wrote:
> > Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
> > changed hvf_wfi() from blocking the vCPU thread with pselect() to
> > returning EXCP_HLT, intending QEMU's main event loop to handle the
> > idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
> > always returns false and the vCPU thread spins at 100% CPU per core
> > while the guest is idle.
> >
> > Fix this by:

> Hi Peter--
>
> Sorry to nag, just was wondering if you could take a look at this follow-up
> to your earlier review comments in:
> https://lore.kernel.org/qemu-devel/CAFEAcA9RHQ+7++=kLn2goJwcgzDnaqdkQtQBtxQ2Rw1-uiKY=g@mail.gmail.com/#t
>
> It's a bit of an unfortunate regression, so I was hoping to get some form of
> the fix in.

I'm really hoping that somebody who knows and uses hvf will
review this (and your other hvf patchset)...

-- PMM

