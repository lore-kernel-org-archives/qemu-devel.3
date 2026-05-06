Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D241CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdRm-0002Ki-32; Wed, 06 May 2026 10:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wKdRe-0002JS-BN
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:41:52 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wKdRb-0001PJ-53
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:41:49 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-12e332315a8so354518c88.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778078492; cv=none;
 d=google.com; s=arc-20240605;
 b=SC/vs859sKx/K/DhKArNLGM0IpnKWRbwlQFuAMI1E+g5fq/XmoYBYWbhRjQ8+A/Uq9
 GFp991pHy8EPVUODJhV7n8RIBPhWfzn3kS58pp9N3Yzt0VTLS1Pkty4LsTpQMTzIA1+M
 wgSHz+dRHn5/n9MxevF7KmGPewPIvjjtN22gGDm6v8l6yRJCmMt2YUNB+R3JtzcakK/2
 tZpy2yXxJbrr4+KNg1odzWEDOks3kAftDUoMYlrKHUtMA7jCwftzP5ELZadkpHIcFgaH
 4Mu27W4oRHnH/pbeytWIlHc2wd6OPz0BaMMA0CzpikwKPZ8lkwDwr5Txsklh9OMNnMNy
 hP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wfJXtOPnbdhNPMTvEDgxIMbAualP+stvQwz0I/dlJOs=;
 fh=ynMZpoLdc8EcguBEfEqlF67vL8jpBgF8ghejmEGS7cY=;
 b=W5B6qh/xgOiXExlWLQittPs7s+gliKAfTL6nQ1ky6BXAitcab4jQ3KuYZY5P4Kel/l
 dArUUdlVTtv0pqNSr+cOL1QyIXJxe/iBSRTM+sbz61VhqFOEBpAc2qlqRfJNzmdGTXem
 kcDd7W6ZSX0XIdD+GjgoSfMzlBn/VbHKSGIKjk5f5g1dGQfz+rOIRTzFM6N0u1ahhq79
 0/8GoYcgJZ6rZV9SE8YVFIU5C4kBBOcI/ltBYZZiaO5un3FequQLnx79CkAXEpWY6nAo
 oMHsYuCVdX3Z9cpOtlKDXSGkJuG+LRzdCA9mtomHe3Sh1NWZTMdU3PxC8sek+RZvgTx2
 sR2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778078492; x=1778683292; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfJXtOPnbdhNPMTvEDgxIMbAualP+stvQwz0I/dlJOs=;
 b=q+vXTnxHlpwO5CXTrydUSPHxEHC2eTlPBOfVBlsQr/ELviMe12sTarLKP6k2hsbtf1
 9LEENf1F5oMLfjPKTDLLnS51JxQtbyRYeq9gmeLaGIEXJ/sRXs9knjyUzy3lIVxAKtLF
 O8zKdl1NZQhXDNMewpk55pn20k6r1j+Fvp2qg2e6xYWlw2596GjHdxrV0/cyRLE2GNV2
 yKxvVygvmdZBgu1ELoqHe7VeKN2APsjAr4U1kcr5vYuQOQQcBnBTJ0Z6N9aUAEfp4A6R
 8fq3AA8kyJasbrlgd/9iRCzEOsKIOIjq7hFfSGSMFzY2OxsmNKzEUPOhSdGqq+RAaEXs
 DiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778078492; x=1778683292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wfJXtOPnbdhNPMTvEDgxIMbAualP+stvQwz0I/dlJOs=;
 b=s2dMjZiOR9R9cP6q9C/iBmm5Fb+w6ks5GH832cPg9NDqMUyXfuJvHiGbKZNt19VZi6
 TMAsGy6PCczxdOL/jTNJYrGLR6Ze+9QG+ZK3RoFEZ84fO2qsXZfw0KlcIv0RWKr5enyl
 qxFBSUvBGCjT9txMEaSk2oq25ewWs5alIubOPT7nzja27WXuFdmySVa2g4UiE1QLiT+s
 DkfVuNwmxP6qX6dYN144CvCdZLrjTXnlA4HVUNXQP6OrUC9OnEWCyc6WnNR023XZuMp6
 IMpimqrbp3y9xow9cnpbY6WfCKxl/ZBy3OcrVXPgxHKQgbLtrsBVD00WIkzaft8+18GK
 jjPQ==
X-Gm-Message-State: AOJu0YxT0e0u+0JmnsFzDP4NtYOT2rhjxKxcS8UR3nOEbq9E19ef1H5H
 X9woPFwOM38XMO59CSTOpbrNuMQuk15tKLTPQBN7DYJz6K6VHCIJ7mCtHAp3QcJ1qQgWojJ+Kv7
 DY4mtsTBlv/7HfUQkQ4dEx0DZiO+QWgo=
X-Gm-Gg: AeBDievA/LVFaDFeNCT7s/6tEAPLncmZpdXDIsFIPn4hPm1H2L7hvazY616I3UQyl12
 SwKg12gyb3LiG1mo9NUriTJe68aLdw9CPeb4sXui8Z7ZzsxgXvBCmtwlYFSyOrCm5IoUds45yt1
 FmoPMZCu+v6hirhRkJF2VXkbL/KS2eIUJffQ8ZhV6nhOqfaZCBmqbmS4IqzbguwEywWbrZqpvOh
 j038gMBWqetE0vQhNUBmE4Dzj1fwXx7BjRXVwPq94BqEh1Lc3f+QBn4hbCPhfm3K12sp8yvG4cr
 J57H65rN1/azYCsadFP1vzEkNeMYdUkBycwK2v1td6Ec8RHZ
X-Received: by 2002:a05:7023:b07:b0:130:9b78:b17b with SMTP id
 a92af1059eb24-1318eb48a01mr1927024c88.38.1778078492199; Wed, 06 May 2026
 07:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260505230644.2710049-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260505230644.2710049-1-pierrick.bouvier@oss.qualcomm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 May 2026 10:41:18 -0400
X-Gm-Features: AVHnY4I87v8kJxoyertslRanjz79A6eH0OhlXw1xGT4dfT1aAxvt9Wepi_TL3sY
Message-ID: <CAJSP0QUki9C6Nk8owfvmfyy_vfYT66mFQfsharkZ6GnDCLR5zg@mail.gmail.com>
Subject: Re: [PULL 0/2] Build system: add stubs per target
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=stefanha@gmail.com; helo=mail-dl1-x122c.google.com
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

On Tue, May 5, 2026 at 7:07=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> The following changes since commit a85c588d07f8d3345ccad38b22026569a04571=
d1:
>
>   Merge tag 'pull-monitor-2026-05-05' of https://repo.or.cz/qemu/armbru i=
nto staging (2026-05-05 10:11:49 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/build_system-20260505
>
> for you to fetch changes up to 2e44ff32fc758bf8c0df13b0287afb75bb00c38e:
>
>   target/arm: define stub library (2026-05-05 16:06:00 -0700)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH 0/2] single-binary: add stubs for target/ (Pierrick Bouvier <pie=
rrick.bouvier@oss.qualcomm.com>)
>   Link: https://lore.kernel.org/qemu-devel/20260424230103.1579600-1-pierr=
ick.bouvier@oss.qualcomm.com
>
> ----------------------------------------------------------------
> Pierrick Bouvier (2):
>       meson.build: define stubs library per target base architecture
>       target/arm: define stub library
>
>  meson.build                | 22 +++++++++++++++++++---
>  target/arm/meson.build     |  8 +++-----
>  target/arm/tcg/meson.build |  2 +-
>  3 files changed, 23 insertions(+), 9 deletions(-)

Is this a pull request for Paolo's build system tree?

I'm not merging this directly because I prefer to follow MAINTAINERS
so it's clear who sends pull requests for each subsystem. That way
maintainers won't be surprised by me merging a pull request from
another contributor who is not officially the maintainer and it's also
better for security.

Thanks,
Stefan

