Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C3EC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCeoE-0003Oj-F4; Thu, 30 May 2024 08:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCeoD-0003OT-4v
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:23:05 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCeo6-0005lC-U0
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:23:04 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-579cd80450fso1885459a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717071777; x=1717676577; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTLvvrgD8EGDGP5twaVu5ShhR8MXpAbjf/cKpiOrofk=;
 b=NLCstbJlsZtzXusevYWQOpYrmO9eZQWxKQdpxbb7H3A6FR6H7zcNMxb50+bIcq4MfX
 kAQ1C+fYsdGBi6sUGVHnG4a6JslFiTz/lAySw5UfkHVDKJvCwoDVuc/6z0NffQbxNqrQ
 Ul++vaIJXxt/gEaE5Dg95Ugn14NR8OKF/+k7OFNVApPxZ4qSCl23kmbsespTlcIdIEFg
 j1XPHbC2jQsW31DCpuoQP3/I8j8fjeurQMMcBWEV4UemTdA/Vlf8+kL7MrDtG8pqRQlh
 m31y4UJKyFqFut6pFXGbEOuaI5NPzJ8d5uh7d9prDC2P4NAFCE+VP361CL5SVvdQAuaF
 luMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717071777; x=1717676577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTLvvrgD8EGDGP5twaVu5ShhR8MXpAbjf/cKpiOrofk=;
 b=IdGK2IIwzrn5MBALXfPXOlhjA2aaqLWxzKaI+awd8TRUcJUjo/iVD23GrNpz6FR/bL
 Y9mkCc3mMCo7LTx3jqijNnSVdEVxAEBvCwyiy1jyXPUULNbYBc4x5OChzkjAjXhcH63K
 wZP5N6kDPy17/w0CmdAgY3bq87M38Orm38BgLawbsZOQgSfwZIiJvqHQo4KPU7vN3eb8
 wFeYKF+2IvdeKiOAKaSqbHHS2phPfyk6UEtaB8lB8SQrVLZRSXVcS6dbFItAFvBTmXWu
 vtHjQLoSj5ocR8Fs1JlLFrx2wG89zjKuonU/bl2GnTDlLiArw9Yb65viFCIDH9+/YorG
 PrRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmLXlTP6cwZovO6tcnPEIE4ti5qqGz3WN8Q7Af9zNjiBBSdD6rN37P7y2HdDH/zJtu9pv0bXUkVjtyH6+vtFIdfVdYYMg=
X-Gm-Message-State: AOJu0YxKSzG3pyXf/kuZenj8+EhzpfZUDOwNunc2Q9jkD1ApbsZXqHua
 Ey510CgNvLlMTpmHy2k0lGRLfWq6pRIDwC6kjWrpjF/VFVeWXN3+Hfoq23E65Pwv62ypHZoXeX0
 vSRhJVIWFzMnwt7oM0eRmcSp8GlM+WYHfFERvnegvEeOvRuB0
X-Google-Smtp-Source: AGHT+IGdxg81TuFNFHXO8Ol+1FDM21IlJsYX1zq7GgA4uhGBOM/EpV62YDVufXM4YkWibWO738Zy0pYrSKcZjdY1knQ=
X-Received: by 2002:a50:d659:0:b0:578:e204:bfb6 with SMTP id
 4fb4d7f45d1cf-57a19f66369mr1145363a12.9.1717071776796; Thu, 30 May 2024
 05:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240523183928.37809-1-marcin.juszkiewicz@linaro.org>
 <f2b32bb7-409b-484a-b4c3-71ca40d9bbe2@linaro.org>
In-Reply-To: <f2b32bb7-409b-484a-b4c3-71ca40d9bbe2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 13:22:45 +0100
Message-ID: <CAFEAcA9Xi8A4bpcMU5XXMQR0z7diBP4VnYTHe26prjAaoxuWew@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests/avocado: sbsa-ref: switch from OpenBSD to
 FreeBSD
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 27 May 2024 at 10:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 23/5/24 20:39, Marcin Juszkiewicz wrote:
> > FreeBSD has longer support cycle for stable release (14.x EoL in 2028)
> > than OpenBSD (7.3 we used is already EoL). Also bugfixes are backported
> > so we can stay on 14.x for longer.
> >
> > Planned to upgrade to newer OpenBSD but we would have to wait for 7.6
> > release to get Neoverse-V1/N2 support.
> >
> > Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

> > +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might tim=
eout')
>
> Nitpicking, maybe 'Test might timeout due to PAuth'? (few occurrences).

Yes, can we have specific reasons for why we're skipping tests,
with also a comment giving a link to the relevant gitlab issue
about them, please?

PAuth shouldn't cause a test to time out -- it might be slower
than without-pauth and mean we need to give that test a longer
timeout value and not run it by default, but it shouldn't result
in the test hanging indefinitely.

thanks
-- PMM

