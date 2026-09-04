Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D1AC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2YGQ-0002Z8-ES; Fri, 04 Sep 2026 14:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2YGO-0002WI-AC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:03:44 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2YGL-0001Kl-Kl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:03:43 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-81ecf499af9so19704357b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 11:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788545020; cv=none;
 d=google.com; s=arc-20260327;
 b=ECOFXWvlTvHorcxfY+c3J56rS/Y5D0GCs13HyBcHPFElyj61A/ET5FwiexwP9dWfvN
 Bh+4UbjGTGhC6rGw/VAHmE8xJ6vqu89snG40aPRpEnVTQV5HQKZdWiq9akdZcH0YlNVt
 lbHpF9syxOcCAK5+B9QaReD+f+CJdUTcFinfF5JJS5RGaywTpIiquJ/iUwUyKtoDBV2m
 ntgmKmiMeq10Hnl5hi7zfyPTr28pIKWmFtnpTr4yq7W7JMUKATmRcAEJKtw2P2bJuAPm
 VixTMh4VNbGGapFaga6xS1YQQ94UZW4ynfcuru7fchIrfml2gO3xpLyq7ccsCP4mz7Zr
 VQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ecgHHHrX4VMS7aYZ2EpgZDXghXBbYqUZFhaZ0xetMrM=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=djJahITmE3url+xtB2X/4o2k4+fRsxW4pa3NyLXAsLyDmsD1lvyKBU/z0wTtutHU0m
 hSeLFvhnI2aDJwltEuvgjhHrSGBeF19++LWUgmai9Cq5u6dFZkQZJqnW+AVXDVsJpJ3E
 t2d6H0P97/7vcZLxVqrkaSbaO/AWY+kAj5hDOnKh+IgcNrDkmiujKfEcjPSKH9gH7ER1
 M7xWXhWoBf1niSZ0mJPK8YzBOPO4bpAX5KOnu+7hr1fDNQ+cL7zPltRikrh/sazz50/T
 QUEqzT69UhmwCxspeCzoq73jVXMfBCusyFAu/YT8o20OVZROsw+bLHMWI1kfkjVuiws+
 02Tg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788545020; x=1789149820; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ecgHHHrX4VMS7aYZ2EpgZDXghXBbYqUZFhaZ0xetMrM=;
 b=miqQrHnWiRU8ifEEtFdv7Ng5L68zp3raMxXK0NlXRuBR2BPwbynATOqoi8PiAFyfWv
 DZnGtHd4WtbzrZYF2KANg/k7dlPk5G+uqNr2FwF1TyDESEqg9VQVSvUdvPbec8pj6ZpI
 PUNbve7lTTQyhBvBCZkvaBdqtCPd3Isch1ut+b3rsFi5SRKs0oFJVdSRVfB7vIT2tkVh
 zP7VQ8bIe+nFGSD2AW0y0hZQRdMZD3Wgpiruz6xE7JDxBPFPksHmzMCLeqd4wyc/POBK
 Q6PUKUTrcz6UQxecPuKl2NTwxYQaciqURugTqvVSOU7OC/ejSdaytGPmkpjkgrqJlNaV
 abww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788545020; x=1789149820;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ecgHHHrX4VMS7aYZ2EpgZDXghXBbYqUZFhaZ0xetMrM=;
 b=cwWyT2JYy3etYyahjmWl1U0JgCqf+vke877M2Hyn10tDvV6SYDWNtmCyIe2aIQN3b9
 K0NK9hSvkOAPqq1VxkD4UpH64HkeOlyvgwl5t7pm2tcATEysiKJf2dQy4nDYowK4MOAw
 QWFl1mGr8iNIvuyf38ygCYJT3fLDvY6/ntDx47MWyqKrSyvNAawKNxvg0trtDAvE6/ne
 HLrSv9BiFQvz7g89PtJzaI3qEj4HY7HobTSeuFb6Gr0E38Y7tUmMDgBG92qTRoMHN+hK
 o3KCj9/r37UyF6HhAnsGfCruZ1q6Ip1JfwYYD0nGXKB1s2R1+Zlsvi6HOOv3IYvE7Gza
 Js7Q==
X-Gm-Message-State: AFuF++n+P+VXqdtwMTDrLLq0gwkSNrqW0ZaBJspmfIqaKwdQATMi/BnE
 X7D6jHngn8OciovHeWKRgv2YWIHpg8KsiPO944qLYyl0qIS3kh9iEqz+GbpkCWiApkLbWZymnCC
 PBdOZ58Bdayt8ixDYpDjSXRcPR724cGRoPenOBCVfiFUOZhha+AitiVg=
X-Gm-Gg: AYBFou1Efth7hOhDo17ZuA4Ji0X46M6Eiwk3ryObJxZDd03nliYSE1huE3L/aRkGuxj
 5mvClHwu2Yq2WX+dqV05GUUjMF7yt6Kg2uMs8SlTf0MwmWgyT0GW1gfk4lUM1NgShwsYnZygQ6n
 u+qhHFY+F2YCVt6IqLKpcuQtXY0xZtAd/amCeFRMPbkJZ5tuBvRd1IZJUM6x+0bqCvoZpMLzZ9J
 gWjq9purP5dfRqka/RS8oRQtmYojCDju6DDarAeGN72v4nU82X9xdcE1W3MH7ePMhmf+J8GV2MR
 e+cPCm070yU+fQA6tNCnLko0Zd/CFgLsoNz63xWsd+IZvouIx3LaYHBzrvTigwMIQG6FdnFU6d+
 yPWUfo2UEb30+LSQp9+57l6NgsA/Bsch+vV02M0jtpg==
X-Received: by 2002:a05:690c:3385:b0:861:5bb9:c171 with SMTP id
 00721157ae682-871266c4d5emr48291387b3.16.1788545019790; Fri, 04 Sep 2026
 11:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
In-Reply-To: <20260904150826.2331577-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2026 19:03:28 +0100
X-Gm-Features: AcwNN1W-bNbNHWRhpyV2xnX91FsQQUSw2H52HjJRnMKQvHYHyQ-lVxpi5Vu55ms
Message-ID: <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Fri, 4 Sept 2026 at 16:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit d2843fbf80260e4346c856819e8cea11768c9d=
0e:
>
>   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alistair=
23/qemu into staging (2026-09-04 09:43:27 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meson-0409=
26-2
>
> for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b3002597:
>
>   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (2026-09=
-04 16:06:22 +0100)
>
> ----------------------------------------------------------------
> tests/tcg: conversion to meson
>
>   - remove unused variable from multiarch/memory
>   - standardise checking plugin output
>   - bump minimal meson to 1.6.0
>   - introduce meson plumbing for check-tcg
>   - return error code if docker probe fails
>   - add CI/self/mem test to gdbstub prot-none tests
>   - use raw opcode for fprcvt test in arm
>   - remove unused variables from gpc-test
>   - teach probe-gdb-support about mips
>   - identify or1k pc register
>   - port check-tcg logic to meson (all targets)
>   - update documentation
>   - add Pierrick as a maintainer for tests/tcg
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

