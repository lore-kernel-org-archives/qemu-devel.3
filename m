Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CCBFEC0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56bg-0007Ij-Vy; Tue, 24 Mar 2026 14:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w56bR-0007Fe-00
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:35:48 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w56bP-00032O-1U
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:35:44 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-79a40fb9890so42978437b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 11:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774377341; cv=none;
 d=google.com; s=arc-20240605;
 b=bjKicXXLVLKAZaYxZnqDfT+1LEACfl7TRLoBBscW8UiZSGUqUwR1hvfIvitOsPTzHs
 o+yTlTVgjnjJRUud1CcGgoRfRHXAdRJwxr7o/DfYNlVbPEl39UcPN2Dxwr+YiXrTX/KG
 Dh6i+mArCnKanVsM1VF8guWVfJQn1r5psOzX3UhGWwoaIeX6fTHPyOqvsHMUwCZ+UKsY
 WDlKekYL14SC5QCxjZVNgRyA6ekJKuBt9PcKOURfgGSSwxupKCFdUSj8W7wbnumUuOTi
 CAlpcby1fTsETlUArkNeDDzucJNMgEa+XOQo8gtmcxIKMUdCCmcoGX9826CI9jMHz5M1
 usEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kiux1RVEUWOxgwutrdGWLijSZiyQKam7x1ALRKd1e3Y=;
 fh=OfuEzBbZj1NpkFX7ORixRu8UUq8+XvhOz3Jpal+S/Bk=;
 b=CBPReAxAx4Ujec5dBb7VtfmQVvfmswoftCS6Fk09EwaFN2josSQ80WipxJFwEfIraI
 hlZjeqlEY1JzayJaX7h/uE6UP4hnWtk7RMRSVTLp0vx1+tXEm582T6+Ivz3vh71ZT/Vz
 d0Z0rB0cBRzarohfoLYSuWvJfHt1MyoOBS/TPTP6wJJ0q6qq1WIwisxKs0g+qG4rQFGG
 /PmNb/86ne0pLX0k7AEC96QdxLH4M5KtekKklT6EIFNyrnQUBdQbuVRfNSur5aCl8yFN
 9jvdSAGSCHoxxW1GrF519lxv9ezYDmjXpyypN1YIAgYZq9KP9ibxa5CBbqO21VEcVley
 0PEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774377341; x=1774982141; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kiux1RVEUWOxgwutrdGWLijSZiyQKam7x1ALRKd1e3Y=;
 b=MeB8ZAQVJmfkWaqAm6g0X1C+yvlMKFUGTyUzFIoAOw6aPBtbiG4eAjCn/DpKQdglDF
 EpEzrI99hROfQzFbjL2ZPAHvf07BBYTI+RarzKEwOgHIXMiqqLFiCo1L46we9o9xrj+Q
 HEyQYjvlnBdhAP2V1SWsCHZKqVZgs81FNEVIO9n+1LnoRL76axaw/k4oNQ7dpLzfTjst
 1nxhMtDu/7b3zkAXSstsHuNkrjdDiHwF6wqDK+FowadVgcvqHUaVuSrUi9FIyYkA0M06
 v32l8xAmHe7k62LMg6X6ytgAGX641rdHbc4bczdEr8bOxXEsarPr/cM7N0JjMs7bX5ui
 dr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774377341; x=1774982141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kiux1RVEUWOxgwutrdGWLijSZiyQKam7x1ALRKd1e3Y=;
 b=KiO03Ulc8zYkQSjBh6FrEp9MvXGUWpFL5Oj0k36r0AZP9lKf1oSm5cF2SIAmzd8Toi
 wBGt/PWz+AoplHObR1w6XN1zOqEaioVQNneBmnpxh4Psr/1mADzVoEOMZmZSArxsPNjO
 M585DPFV1vfsi9f/bwnUYDRF06DYvyQjfBIFXeQ43wlqE0axqcMx92J9h3/E/2KgbwXC
 FO+GzjHNUDLHenIdUI120obgZdImOZA12gkjm1X4Q+ogw33bpzPRY6U4sjK8+TUCoZTc
 w6EBnsbL1dHR0QNwsToWbdpeQadVb/WRMm7Qv+JX8zb97GqiXXs5QfzN+JIaAFVI5W5W
 4Uag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUMP360ih21x5vdrI7FNx89IHENmCl6cgfn/c0+FKOXDM5rdHsD1zBQkpo5dyztzZyMnZchFi2mF0b@nongnu.org
X-Gm-Message-State: AOJu0YwsKyPpGQb3yEGtu3qGWLsZ2AlpnawkVKp6JSI6cj+DtKiDa2AB
 +2ulAJPVdCYFOM+55X9L0g9BthoTuoEXq8glqyI2reWXcq75V5y/QwFwMZNpwOjPHb+m6c0s+6a
 WJiE2MgeKnY3g3NRxYv0+k3QdLCN6xi5gW2f7Mm553g==
X-Gm-Gg: ATEYQzyNFnoytVpuwa11zuNcWfwXNeV/gmbRDTLQtsMRpXbvA8zdoOLcgjIKSgqtWYR
 c7nNd4c2LMAcGDRCfQtcRelYBPE6cjw6UPp1oXLG+bFqpuDvcc9T+vGbAxlcXCXfTrPXg+MnmWA
 nQxx3n1aJeQByzAFoRSmXXpoNnmOtW6Cxzbd4RUD0D17iWS/nFKLpK3PiavUFRi4KGMM12yC8IQ
 5cIg3K4H4uh8FvMzDjhW2uJGJxXW9r43l+EKjMGzZtL9a1gkkANCWN/n4PDhxwq8O3EBO3TmaCz
 5S0KltQv1/5c7i9sYV/2dIZz6lQF1hqNZxIchYz0jAxOUKZesQ2QZFLuTZ1uQnvWwoM=
X-Received: by 2002:a05:690c:46c8:b0:79a:c28b:b077 with SMTP id
 00721157ae682-79acf65e59fmr8163937b3.37.1774377341102; Tue, 24 Mar 2026
 11:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260324124131.1053711-1-clg@redhat.com>
In-Reply-To: <20260324124131.1053711-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 18:35:28 +0000
X-Gm-Features: AaiRm52kyXe-2Y6mgTI-LWP4Ac1Yi398JJQ-TwYhhmh-w_n_IkTSKXY_V29uuKQ
Message-ID: <CAFEAcA-1zYJKqJCaG6GVnYfRj2ukhFjAPE5SZqPhkNTaE23PNg@mail.gmail.com>
Subject: Re: [PULL 0/5] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 24 Mar 2026 at 12:41, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 750ed363ebfb108082b40bc532b20564bf00f9=
13:
>
>   Merge tag 'hw-misc-20260323' of https://github.com/philmd/qemu into sta=
ging (2026-03-23 16:58:15 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20260324
>
> for you to fetch changes up to 5fca367b89de2d11631cb27a90a8c5431d004f58:
>
>   hw/i2c/aspeed_i2c: Remove assert (2026-03-24 11:19:40 +0100)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * Rework Aspeed SMC mem ops to improve error handling
> * Fix race in Aspeed I2C model
> * Disable kernel crypto self-tests in AST2700 boot tests
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

