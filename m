Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C661D10C15
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 10:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t50DP-0006e7-GR; Sun, 27 Oct 2024 06:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t50DO-0006dz-Ov
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 06:09:42 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t50DN-0000t3-7q
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 06:09:42 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c94a7239cfso1845096a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730023779; x=1730628579; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=45jJyrf+k0ekMIw8rF2RayCK0+i1R6R/c0i+okPzUEQ=;
 b=NyhroGrfUktwo7yVGjejwxKovRYhyByGJu/6WCj7qXbJTfb/G6P0mbB9FjXpPvj3TA
 WqSEOQ5z+OxwJNYW9t2RbIGFnsnLytcDtHBiGvdPtxQyBibyERi6e10j67qlHn9JWohU
 xOOvbDeo+GCqy1twA8Vpn/LLUoEj3o+wMvq8D+Jq7dZQI3uAcRivJK4Y/hYWfUT/GJzY
 X7OtAfaUTc6wNyS9WKGNzFLf2AanBSXyP0uV16q+s7TUx0yqsRN9MJOj/sTvybjHvCjr
 GJ2GB1NNKJks/jfIPBkI8+WK2tJZGnh9ZaRazB4LAOvEL2EdkZqFGno/O+SmKIWSh4Zh
 ElOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730023779; x=1730628579;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45jJyrf+k0ekMIw8rF2RayCK0+i1R6R/c0i+okPzUEQ=;
 b=SZ5zGDDyXSz4R5lARu1j/3D6RbKNoCM0fhVbtjubyIqzZ0mbB/zTmvSdJrItjdzqr5
 CQrxknyanZ2Xf+kpNCxi89j8JpO5NwaD0latYEk62ccyl844BDHmFxy9X2jc2PteLhtr
 ioRoP6JgkntSC0fc9JXJr4U17mvCgMJ7oXcz6AQPHLuMBekRTirikpRxrPvmj0HaGbq2
 IzNUe163hGY8iqLC+RhjQ3m+E9la8u3IQg/YGCpsEgPHHjjMohU/RcIKS/wT5Ef5ksJd
 e3qXM35HdBnirY2iUNQbwiVOU7MqDEBcwe+9atVg7zAry58YQEusnY661/bgCwdhl07G
 e5vA==
X-Gm-Message-State: AOJu0YxOf1FZDFFhlby2GFnVgQgyGR7bNFSdEvFaMSjH42coFsmrPtS2
 5a0nRFzbwe/OTOR2vNKkXXDaVKgBS7ufXu6xVBi9+Qw+fHMlk2lqJw9kyIbcYDHjIH0JLA2loDc
 T+UQ=
X-Google-Smtp-Source: AGHT+IGRnDrN86VEN58PEkW/+mf6/JXXSkWPyxnAvm00rouFkVX6JDsSrSjSkgls1/ddWW4fh4tC3g==
X-Received: by 2002:a05:6402:26c1:b0:5c9:1beb:b971 with SMTP id
 4fb4d7f45d1cf-5cbbfa71a95mr4952937a12.24.1730023778744; 
 Sun, 27 Oct 2024 03:09:38 -0700 (PDT)
Received: from meli-email.org (adsl-161.109.242.225.tellas.gr.
 [109.242.225.161]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1dec79aasm262804666b.40.2024.10.27.03.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 03:09:38 -0700 (PDT)
Date: Sun, 27 Oct 2024 12:02:04 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: <axelheider@git.sr.ht>, qemu-trivial@nongnu.org
Subject: Re: [PATCH qemu.git 1/1] docs/devel/reset: add missing words
User-Agent: meli 0.8.7
References: <172998683323.20070.572834413126431721-0@git.sr.ht>
 <172998683323.20070.572834413126431721-1@git.sr.ht>
In-Reply-To: <172998683323.20070.572834413126431721-1@git.sr.ht>
Message-ID: <m0ew1.ywldxlj9rdms@linaro.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
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

Hello Axel,

On Thu, 17 Oct 2024 20:58, ~axelheider <axelheider@git.sr.ht> wrote:
>From: Axel Heider <axel.heider@codasip.com>
>
>Signed-off-by: Axel Heider <axel.heider@codasip.com>
>---
> docs/devel/reset.rst | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
>index 74c7c0171a..3e64a7259f 100644
>--- a/docs/devel/reset.rst
>+++ b/docs/devel/reset.rst
>@@ -286,7 +286,7 @@ every reset child of the given resettable object. All children must be
> resettable too. Additional parameters (a reset type and an opaque pointer) must
> be passed to the callback too.
> 
>-In ``DeviceClass`` and ``BusClass`` the ``ResettableState`` is located
>+In ``DeviceClass`` and ``BusClass`` the ``ResettableState`` is located in the
> ``DeviceState`` and ``BusState`` structure. ``child_foreach()`` is implemented
> to follow the bus hierarchy; for a bus, it calls the function on every child
> device; for a device, it calls the function on every bus child. When we reset
>-- 
>2.45.2
>

FYI: the `[PATCH ...]` part of the patch subject does not need the 
`qemu.git` string inside it, I suspect it was added by some tooling you 
were using however.

If you decide to spin this patch in a new version I suggest also making 
this separate change: (adding a plural `s` suffix at `structure`)

- ``DeviceState`` and ``BusState`` structure. ``child_foreach()`` is implemented
+ ``DeviceState`` and ``BusState`` structures. ``child_foreach()`` is implemented


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

