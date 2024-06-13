Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C57DC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 12:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHjff-0005vn-JM; Thu, 13 Jun 2024 08:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHjfd-0005tW-Sv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 08:35:13 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHjfc-000079-66
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 08:35:13 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57ca578ce8dso1013242a12.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718282108; x=1718886908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xsWT4b3y3NMawCOFvh2U/P9gaPJIhjmuV+d7jXet5BY=;
 b=saw+xxysivueil9CppBZJHPg+fnCSf85x5RuKYhdkayj3DYMKsB5N7aIunjOBR6NbJ
 VxtCv5xYxkbm7MdQ0bJCWZ+EpwXM6tEJizgzlftrlJgSrievp7irA4zGUguAar+IG5zr
 L8/hGRe3XmrTAyWaMweykLQcufAd1puzRk9VUqyPf7WpGfPMiVonKfcUofabl9Rpvi4U
 FCKr4pawAA34GpvL4esmtJB/3BvcI9Ep90R+lGaWYGkqAVNDwRivsC36hPX8nXp28OJv
 TwlTQjxZAxgMq/Q5v6ld4fTs/Wj13feNq4i21fGBE5a9ds5iiZDv+HldvIGb+T55Gdtu
 X9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718282108; x=1718886908;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsWT4b3y3NMawCOFvh2U/P9gaPJIhjmuV+d7jXet5BY=;
 b=dzO34FCgNsc/1t+C+g4brJVsJBQtkBr02763e3hSAxc55iZBCXYdJwR6sj1SCLoYGG
 Sg4RhJ1OvglaXgaxVlvwZ3Dp7gMhoua66MSI5oTV4aHbS5qXuqcFg2jMtnCNvqkfIgYa
 oFI1bdmFMqsQRfgma9me5yF6rCAxwJVBCFYzZXphq99nY3+gDuVTMWlgT5YRCI7raChe
 kbECNKAV+CZn0pxsmGmayMcqrnkhX62TWmM/eYBm3Bxx1cv+RWOWspSF0w+EFWQTMZiB
 eRh6NosmPl0fxdaXgq1CE6r7kM6yLEFGTsE/6ADXLbXXrC4OvID5bbE2YdRkZ9vJtV8h
 sjuA==
X-Gm-Message-State: AOJu0YwoMoCzkJMeJlXrxoFmTv+aXM2U1F+kg/NQ/ta1eTsvWJJQl/LM
 pUldLXDYah/G0arGIanwNFmjUyml7WIOkl1tcqqrEAjGFuIQ0xBLIEOfQLMVf5Q=
X-Google-Smtp-Source: AGHT+IEj2rxfbDph7WYanlJZ1uCIbQZ2O7hXqwikG5pyz22qEmiLCZWq85VCfiQHjOzbKpCqLLKu9w==
X-Received: by 2002:a17:906:2b9a:b0:a6f:18ed:254f with SMTP id
 a640c23a62f3a-a6f47d56f0cmr318681266b.58.1718282107852; 
 Thu, 13 Jun 2024 05:35:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f5c416f7asm32756866b.92.2024.06.13.05.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 05:35:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EC0DB5F7A1;
 Thu, 13 Jun 2024 13:35:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 8/9] target/arm: Add aarch64_tcg_ops
In-Reply-To: <eaa422eb-d616-44fe-ac7e-79baec8d60ce@linaro.org> (Richard
 Henderson's message of "Wed, 12 Jun 2024 08:45:59 -0700")
References: <20240606032926.83599-1-richard.henderson@linaro.org>
 <20240606032926.83599-9-richard.henderson@linaro.org>
 <878qzaxm6n.fsf@draig.linaro.org>
 <eaa422eb-d616-44fe-ac7e-79baec8d60ce@linaro.org>
Date: Thu, 13 Jun 2024 13:35:06 +0100
Message-ID: <87a5jpvx51.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/12/24 07:36, Alex Benn=C3=A9e wrote:
>> What happens when the CPU is running mixed mode code and jumping between
>> 64 and 32 bit? Wouldn't it be easier to have a helper that routes to the
>> correct unwinder, c.f. gen_intermediate_code
>
> GDB can't switch modes, so there is *never* any mode switching.

Hmm but code can. We do want to solve the gdb mode switching case as
well although that requires some work on the gdbstub.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

