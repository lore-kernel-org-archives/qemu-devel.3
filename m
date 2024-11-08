Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF0BD5E153
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9M8T-0007i2-0a; Fri, 08 Nov 2024 05:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9M8R-0007hp-0I
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:22:35 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9M8L-0003Vo-9H
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:22:30 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cecbddb574so2263168a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 02:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731061347; x=1731666147; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4YAmeeupvZYIEJGhmNwVUcb0JmoK4fUxFtelacjRj+E=;
 b=MNAnuezOlE3xxZ4eebKC6svdy5U78hUZqyYZSyW3seXphoh6QmSXznG32wGwb864kT
 x2FAANuDkFGKkRSGmoHXlVaaJ0qk5x7p0c6Gl0eEAfYE6Bi8UBXyheDUAkur58u5rWoJ
 j0XHnp5tnmjef8hicmmy0V+ETuZIEN7k26hIET81YSlG5p/5gqanyp414fTS+txdnMCQ
 HN8BHznev14gmBT+p97TasAhWhiFNQKgrbnzHCk4OTEh6/2Wf8WiW/UzbpfQMpOi7KP2
 Zyb4alZkzv5VAOM1MwZPyfZ2rCaNuSF+x6HPg/1CgiOuKWsAyFOGSxL/hVPeKGvAt4Uk
 GqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731061347; x=1731666147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4YAmeeupvZYIEJGhmNwVUcb0JmoK4fUxFtelacjRj+E=;
 b=fKuU9nCTcmMfQpb1Qj6w0cwtCalCoYWt5ZlGNCQ/jUa9yY7xkgjRTiyLX8qhE6AqI3
 Oz9B9LlXmyw/86u5GAE4boyFg6KyqKo1FxR1skDB8tjNEESCD0438GBOTCMIvAgBWOOR
 Cc1pMH1wZ8PIOS8JcIn7bZXaVSpUyAfVrDoCezNix6j5kQzQyDO3eeEh8DMeT/JYlRSY
 K1v23LAJN6ygbGxTAAl8PSpc3hw2NwCBdI1df/vajcml7d/IKiVB6OQx9Z1nhf2ejUoV
 /FHIaLW38ZsV5I8woU+xoYgFMJyFkL31OXCPnxKGM0g2qgKYNe6mdX/ZSMBXeIEHhJDG
 4Xkw==
X-Gm-Message-State: AOJu0YychBggyXgp2gnIY1bpDeCaaFZtz6YfJPcxp3L8RKtDLsfAzcrE
 +VWYO6x0CsxfXRH2sV9vWrX35dGGAqLPbR9NasZHEkGur/+nIJnCZ8LVQhfF2lmn1+nslJxsEqt
 A63Q28aSdJeyE5Dsug97AQ18sHyVLvzPgk3jV1w==
X-Google-Smtp-Source: AGHT+IGnIXUKAW59Xe/QzY0CuprpZrJin1DKrAQB9mhqDT0s0tuTIQt9kVdb5iYR7dDUyURy9fMHdoEpETPBxTVidjU=
X-Received: by 2002:a05:6402:1ed4:b0:5ca:14f3:2883 with SMTP id
 4fb4d7f45d1cf-5cf0a2faec8mr1762902a12.4.1731061347434; Fri, 08 Nov 2024
 02:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20241107104001.66039-1-kkostiuk@redhat.com>
In-Reply-To: <20241107104001.66039-1-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2024 10:22:16 +0000
Message-ID: <CAFEAcA-Pmf2H06q+mvb8bPA42DCQvBeCXsKcqqGcy-Bxf+3D2A@mail.gmail.com>
Subject: Re: [PULL 0/3] QGA fixes for guest_network_get_route command for 9.2
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 7 Nov 2024 at 10:40, Konstantin Kostiuk <kkostiuk@redhat.com> wrote:
>
> The following changes since commit f15f7273ea55472d5904c53566c82369d81214c1:
>
>   Merge tag 'pull-target-arm-20241105' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-05 21:27:18 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-11-07
>
> for you to fetch changes up to 5ab1c032e6eea810142eb918c57222464482756f:
>
>   qemu-ga: Avoiding freeing line prematurely (2024-11-07 12:28:20 +0200)
>
> ----------------------------------------------------------------
> qga-pull-2024-11-07
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

