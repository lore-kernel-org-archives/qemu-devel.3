Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5404AD0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJJu-0006cA-6r; Fri, 11 Oct 2024 13:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szJIc-0001A8-Q6
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:19:38 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szJIa-0004Zn-Bl
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:19:34 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5398df2c871so3118665e87.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728667170; x=1729271970; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCYIkA6N8w4z57nqIf/uV0mFAKf3819lBstuP/bqVNA=;
 b=sxPjcWob7Vo7J3mMa10mVjexEDQ8gihGjS3UFu7omjMFF7oHLfFlWXk4rS2bYOxn7p
 LAZ0GAVvK+Rs4wEdr7DO+5+IrhA+QqJha0zObRTKDBh92kEjGoSOwYaK9hepULOzc0XE
 HwcWHccMn3zqoJMecdALGACrEFypTkDqiMup0roErBFbFmX+IxftLLEq+S8Tu6mCBqws
 5ao1pA37isbiRVG1ylZVnkP/dsXcyMgvRfUMzxc9OkyNnTw5xwFTf1F1r3D1KCH6CfNr
 eWSwG9/GmnmVOozQXaYKUG/k2A257l9RCxqYu+iu65AKKjGUNu1Ai59AOzc1VmidWyf1
 z78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728667170; x=1729271970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCYIkA6N8w4z57nqIf/uV0mFAKf3819lBstuP/bqVNA=;
 b=MUGwzQTJIjHOJ/XnosDY/v1XT7LZMdMIxhiBVk8GW7IlA5tDifGYKctnTV5q7gPpxx
 oLKS9XJURi0uy1VHK47q8sip8DraSl4ItZ/Jyu+zIR5wmlBFuZKCU3akhcPibWGrNOEF
 xQqBOusE62D0tmM3q1U44wZf1fabwZhyBadwFCGHShYwvL4DMaCWzWLoOHADrGMAClsk
 YhXUAQ8CYm3OEhFlu4SPfmj29TFbt5hl5vOWLLC57C3u+AbGIzZ/mwTcU6wEs9BF9qWa
 cDWXiORbzmicosCbasveMndRnWarbKWGD2U1YTeENLOLh5O+nR73+gDVkPHwyie4IrMr
 WHFQ==
X-Gm-Message-State: AOJu0YwT9Ls3E9zrENk/P1xmPuYDYqQDoci7+XUw0coKsCPs+wWG0IA1
 5/hCGH1kss3nzQ8KzzQ6xQeJph27e/AroEbnMCRx9nvWK6b2sh6cfHicNnHGiRLRevD4hXAwZRZ
 IK5uECoEMkBCqE6flNHXW8j281dFbL156ieja3w==
X-Google-Smtp-Source: AGHT+IGGE3nQ1euCDr4CfjmZ5DRO/5gkEGHLicUvmVNvVStnApv81HUNSzDT5hEBUIDAtHIKegkmLf9kOubxPfoGSG8=
X-Received: by 2002:a05:6512:33ca:b0:536:7362:5923 with SMTP id
 2adb3069b0e04-539da3b439cmr1825490e87.1.1728667169929; Fri, 11 Oct 2024
 10:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241010162024.988284-1-berrange@redhat.com>
In-Reply-To: <20241010162024.988284-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Oct 2024 18:19:18 +0100
Message-ID: <CAFEAcA-e_1WFLun2HptTt2bSzXkSMBnxKAK_UzUhwRh_fb66Fg@mail.gmail.com>
Subject: Re: [PULL 00/17] Crypto fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kunwu <chentao@kylinos.cn>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Thu, 10 Oct 2024 at 17:24, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit 838fc0a8769d7cc6edfe50451ba4e3368395f5=
c1:
>
>   Merge tag 'chr-pull-request' of https://gitlab.com/marcandre.lureau/qem=
u into staging (2024-10-09 15:06:56 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/crypto-fixes-pull-request
>
> for you to fetch changes up to 08e702043fbee7b366d1d27c1b6682090c46c0d6:
>
>   tests/unit: Add a assert for test_io_channel_unix_listen_cleanup (2024-=
10-10 13:41:45 +0100)
>
> ----------------------------------------------------------------
> Introduce new cryptography hashing APIs
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

