Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8F4CD4F26
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 00:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb5ay-0006uM-LV; Sat, 20 Jun 2026 19:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wb5av-0006u8-JK
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 19:59:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wb5au-0000sJ-24
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 19:59:25 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-697573b16ccso3009455a12.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 16:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781999961; cv=none;
 d=google.com; s=arc-20240605;
 b=cb+UWGm7xxxEztMR6hVTMTXymu6db4X0p6AEyzkO3p1lrG5EJzT5b3bzcixUo7zWQA
 UYUCMLyv5TRTfktCgmY/b4SedKxj8QeMjYLsrd/ZKpSCPeAw1ozFf01EZmavpPHvcBQm
 l5nmP7UqOl9D4hoijCps8M2CmhOE2AB5/DPkmZ/eq5ZKdpjXYPHSZea1P2iEQ4Jm/Htl
 D+YHG5rTdWlaDcImqcMU5pms815BqRLj38GF4QZ5KlmlJkhph7fRFpbfyyi7+U5aRC83
 uYhl0k+bYSS5R4Lope3txG2Of/kBpOfYWOz7/m2kTgDF6PMl8/oD7VZL6J6kMTtIsdDI
 pg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H6JljcWaltISPM9t7+fODsflj3U9N+i6jCNhNjL7rUQ=;
 fh=MRZUNMWuv1kFuqQ9+hXt1nBjxFVEdkK9q0n91tRksII=;
 b=AKI65KShI/9JDj8RU58jYzCDBxIEulv25XUbqfPT+mtwvhToGF7neQ0fcUWQc+uuCl
 jV74bCXy4iHjb8wmPm5M1e+lQqH+end4NqCuqr00w754HRTVsjAI62ddEopxZlSoRUKC
 yMHv1F4O+983JUoulzT9REsv4BCao6b6vleWpMUPnsBygK0JCSejsKDFG7sB+mesrMBm
 KNjwa2kErY6BnMC2WMwtshJE6HwSkL3990u9SiP6jAHbGsTSZUiK7SxZH0hrjebqhZ5Q
 bQGsjDfD5Revlb4AONcxMZwjHZMX7UN63A5RacK7WCIURQbYj6qHmpewYeuEx1aNmHUM
 tfew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781999961; x=1782604761; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6JljcWaltISPM9t7+fODsflj3U9N+i6jCNhNjL7rUQ=;
 b=BPAQIMp9LclUCmjHRF3M6O5t3pJ2u7Uq8gSa6rDwBKdzm4APoou4YY02JK9kS4oYP9
 AXIqqGm1+1EYlPKihAqp7WLw2e33J2cBhq6qQntQJPK5yfYfMIPMgWiGZ4Nmfzt1Wh2B
 /STpK6V5bJbHxEhAe1xOqZg5Klt102eZmoNrie/7CQIshqYInAmHbAuUzwW7KZnZ789x
 yadiIp7YsrdrZhnMIY31KGETPsSBI5RrOuoGy3opCiF+oEFsB4cDahU2ujv0JUwJgKGs
 dEiywsWPElezRJalPWaSNnP6tWTKEFT8IAzW0pdedOf6pplvGomSIf0rpH2ZPHzKqH/A
 R4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781999961; x=1782604761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H6JljcWaltISPM9t7+fODsflj3U9N+i6jCNhNjL7rUQ=;
 b=JQ8YrnuOG5DKVETlq0gNO+OFPsq0JDP17ivkdvDzrmVHAVU2jwEJjvmklWdOqU2Uj/
 XRY7oj0VVjApxLW7/39gPgwJ/WOpIClEmZ2LM8WhQDyBqgOyH2L+dtpc0HRBVdg6+goN
 imEwwH4jQsPlKOmA6FQ8KMLcl91/GtbD5pQzd+IYFZMEGduqPbz7UnpuVKDuc+Dlrvvy
 CXuQH5fD680Z55qbSANNXxQimEka13zm5XZnP20BcplwjJyEWqyAs8Qlr6l/oFfPntM7
 pO/oWUQKHIYNZM5bC2+vbQT/lb6nvMcbfTbWWmNMnT74y6iTJlo/b4XohvahqzlFtpzT
 4VPQ==
X-Gm-Message-State: AOJu0Yze7Q/gOuIxj2SAFZl6PSftguY7f5LHcqLTZLIe0sfv1wSViD33
 tZPmkSknoRE3xEcDRk8lxM5cL7UTtRUolLv+s+wz1ht4pXD4hl4nlknY/ga/+hVlBNGNT7KMhOf
 ZMy/aC4uyOsynyQFZYgdzDIi3olenDME=
X-Gm-Gg: AfdE7cm08soYv7EJxCdrq8tHmwr4AHmrzEtdEQK+9Ty2YsgVAty/R8Kob+pWN26+Bb+
 qfaWsK/ija9ysI70zrFA2PWanX4R3hkPymFKW5moK1eTcEC/H5EPTOAm+HBFw9jyLMzybRjDydN
 YbPNx9HKQqk2Bnn7IcKsPiBiFRTQD2cLW3Vyvv5ntVc7I/+bQT4DL2mhw5A8PC+8kRsUVwPk/bT
 G7Cif4G7VfxvTBEsb1xN6Cr97dyQM65HXuWT1XRBLhHHrqkqE2c6qM9mVivNEE4UuhnDSuylWjj
 FvMLt3qvkNsCUG+s7VXLoBfskN92g6g=
X-Received: by 2002:a05:6402:1599:b0:67b:cd1f:9cc1 with SMTP id
 4fb4d7f45d1cf-696edc5a4ecmr4265724a12.6.1781999961605; Sat, 20 Jun 2026
 16:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 20 Jun 2026 19:59:07 -0400
X-Gm-Features: AVVi8CemEpmCL8DP5A_xMETluebgY1AswrOr8raXL3sg5cg5AJnDPxshnRoQ9Zo
Message-ID: <CAJSP0QWzQEgoYMCgZX+9jCvrV6O3RqnA+df1DpT2R6MZvVXiNg@mail.gmail.com>
Subject: Re: [PULL 00/74] hex queue - sysemu
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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

On Fri, Jun 19, 2026 at 7:00=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> The following changes since commit 3b50303f9563a42538a1fd5c0ea7f952e23016=
e1:
>
>   Merge tag 'accel-20260618' of https://github.com/philmd/qemu into stagi=
ng (2026-06-18 16:28:12 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/qualcomm/qemu tags/pull-hex-20260619
>
> for you to fetch changes up to ffa57dc3389a85263a3a7c4890d01b501a33ec97:
>
>   target/hexagon/idef-parser: open input file in binary mode (2026-06-19 =
15:39:11 -0700)
>
> ----------------------------------------------------------------
> Add initial hexagon system emulation support

Hi Brian,
Please take a look at the following CI failure and send a v2 pull
request that includes a fix:

../target/hexagon/meson.build:285:47: ERROR: Program 'emscripten' not
found or not executable

https://gitlab.com/qemu-project/qemu/-/jobs/14953356226

Thanks,
Stefan

