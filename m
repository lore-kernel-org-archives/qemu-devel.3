Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCB8C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVveS-0002LJ-Si; Fri, 02 Feb 2024 10:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVveQ-0002GV-4a
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:40:22 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVveN-00058V-6e
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:40:21 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cf42ca9bb2so24497851fa.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888417; x=1707493217; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wn5GjeSfLpdancttFflyj3wiQ0WnOWkvXBBOTXvGHyw=;
 b=YfvvMhNPq3HMb8au3MlZCpaGtP3Qhts/LqPrBZLoNTWuGVP83luMDHiGE8CHEgpF51
 2KxA7qH1pXLIGnLDC8qJi16rXo9X72y1TAR864uH672Uh5+w1aEhqCscruqVg1fmxAoe
 y+hnYiuPPrMbfN5rCqxIon6uixMY1TbUTHa8QLjMCQb2hBvlotEwaL39+RVYpUcedJXB
 mlzU/0lCPF8r5m/A7gkASbh3NxSB9sdsQohcRFhuS9G9lwas78tpoUb8JTjCIHqMNbB7
 M2W38coobUQE9DW6JONdacDhtBORSwlP0wse0zpiFGdy6ISiKwLhN0WXEW6ED6gN/3sW
 h0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888417; x=1707493217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wn5GjeSfLpdancttFflyj3wiQ0WnOWkvXBBOTXvGHyw=;
 b=DSnZavwECu0/liw1zDeH9WAqeeXcsacB1a2WucDE3NDW7ZTmohXKrhGisGr8CWtcYT
 xAF+ZKQprhYnAYoS60x/JJWxaE3Q/pQHM238Pe1QNgg2wOEK4vebJ5q+sw+wQAmHy8du
 4TJfBSl8dISqVv617h46TSxM6e9LgZ6Pf2/11KDHHIQbHQina+ipybThKx+5zc5M9O2h
 a23j9hCISwKaNf2cqU74PLl+ilnv6WpGDXP5pERBZEPdROlTRIajmwv1hXX954hbw7Pf
 NC9+oH/MAHXWLdJlFInuF+p04siV6p3blvz/RXXhAHVeMSrculwWqWncmVduebKvlROL
 2BCQ==
X-Gm-Message-State: AOJu0Yxvovs48apLnmMZS9qI4Rj+MTh8+EqsL432hTQXpF9W7m+DFDqz
 KodEb3wuy4SiTlCfD5agxI+wU55E+b9tliMhrfm0kMF3xcQF5A2p2zBRv3RQzBZH1/jxQN1ni/T
 F5hsEZx/sUs8cDJIub1/qbc/xjbPUo/+It/SdJQ==
X-Google-Smtp-Source: AGHT+IHZozv/oq7kdF2HE3OMsATt7+BqvQSGhHxNAI8rcrJ96f03sYzay0QuQUuXGN6LPmj3z3JZuAOQM7+3zcq1o5c=
X-Received: by 2002:a2e:8509:0:b0:2d0:6fb5:46b with SMTP id
 j9-20020a2e8509000000b002d06fb5046bmr1443868lji.23.1706888416835; Fri, 02 Feb
 2024 07:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20240201164412.785520-1-dwmw2@infradead.org>
 <CAFEAcA9-e=hzN62vkq-P575yMvjqmm1sNwNMswUDnqj1gCRmOA@mail.gmail.com>
 <4e86dd4daebb3c15d1585ff8d7316f61f122d827.camel@infradead.org>
In-Reply-To: <4e86dd4daebb3c15d1585ff8d7316f61f122d827.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 15:40:06 +0000
Message-ID: <CAFEAcA-Xbjpg8NUWnxq7Mkz5b+aUFUTsmZspBqWQ3N9Q76xhYQ@mail.gmail.com>
Subject: Re: [PULL 00/47] nic-config.for-upstream queue
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 2 Feb 2024 at 15:36, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Fri, 2024-02-02 at 15:32 +0000, Peter Maydell wrote:
> >
> > This fails "make check' because some of the qom-test and
> > test-hmp checks fail when the QEMU binary segfaults.
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/6084552256
> > https://gitlab.com/qemu-project/qemu/-/jobs/6084044180
>
> Thanks.  Any idea why that didn't show up in my own pipeline?
> https://gitlab.com/dwmw2/qemu/-/pipelines/1160949234

I think because the failing runners are the aarch64 and
s390 host ones, which we don't let run for anything
except real merge-pullreq test runs because they're
limited resource. I guess that perhaps we have at some point
said "we don't need to run all the guest architectures
on all jobs" and not noticed that this leaves the
coverage for the submaintainer only-uses-the-public-runners
CI testing with gaps.

CCing Alex and Thomas for possible suggestions.

thanks
-- PMM

