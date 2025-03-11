Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F5AC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 06:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trt0T-0006Tc-FX; Tue, 11 Mar 2025 02:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trt0R-0006TB-GP; Tue, 11 Mar 2025 02:22:23 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trt0P-0005KR-KE; Tue, 11 Mar 2025 02:22:23 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2feb91a2492so8488272a91.2; 
 Mon, 10 Mar 2025 23:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741674139; x=1742278939; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRcxPSbYBxouviXiVv6gryxnsPmZmYQdgb94khxj3qo=;
 b=i9HyvCoOPTQBJ6J+8xDX8Qg2rXE4FY8+gJMO6Q14WjQYdaUcwjKLxwqf9sNlrhQpI3
 dH5EhcIv9tpjPqUCz76cyvuJUfVXkzduP7ZKrZTcGRh0fSptJFDWLTf3Il9EPwoOvJ3r
 wTZe7qnZv6yVzn/LO4j62q9f4UR30SPhthFCeaAZ/4xpyipNIx4Z75/cNQTKC7PUTsUb
 ErqJXN5/DZgeXzQeQD0eTEHH8nWhGhMiywW5jWPwnfbIsUByup0Syd9VCCysPj6k3l95
 vDmAj+Lq6B2JrnJi+JRVsH2ZHE5yQ0iZz/ryKndhQ+Foz+Wrwp1fv5j3IT8fL+vWP888
 iaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741674139; x=1742278939;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HRcxPSbYBxouviXiVv6gryxnsPmZmYQdgb94khxj3qo=;
 b=Tq5xe8yZqAsmZt6f9B/jRZx1huoXPuzZ4j6iUxoxuXbdykVTWxcue9ec62UxQjq1rs
 Gfy+R+qJ8/tvez+0cmO95vmlw8u8VauLP53YPQKpBKVi5zDdcqvJJwsdSDwO5AM2CvaC
 zFiNUciCaoojE19Q+6zqkSVCe1I8y7fB0SKm4O2ETxn1rpxNMZlcDNAiHrz6gLrv8UlT
 O2mweX6dhyvhgoEvyKW9agLdDZ9rKC4VSUaCYHBGFbTAy7qCFtmoIKh+JYs7prt18918
 R5SImgenHmHVGV0gvetQTrWySIArGaGueac/Iw2Lt8jn7u/TcYGjIOVs47+ede27j+q6
 0U4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUPnvnWZsJNiRB50cf+knjQhM2vK+5C8Gw9SzvS1ZjMRgWzz+qW3Mic0nZ/JnhxF6h7oqmAqS5rhU=@nongnu.org,
 AJvYcCXtcn62dCw1iXpnQKXhowqPPNK+SoblFo2MUBPQFP9+3DyrJ/6883ORCp5ASDmVNrocXGEFglzx8kzP@nongnu.org
X-Gm-Message-State: AOJu0Yy/wAeyPvMxteEr9oRTzQZr0PdgzZEQ9i3t02qXWIgHxDvgGx9b
 kdLkjeBm9VSB1/thVKRV7Vdmmmc6ofzj+Kko3nDtNAMWcQeAwb8ZbzXRlQ==
X-Gm-Gg: ASbGncsuLhwRsW2r900+CCcOhRz5Qd3r3SE0dm27KVuzO8x3g0v0zDmqsFAjhP8mLDJ
 uKKKuaDcgS+FzakZroscx7cEsc3RblN0uldEiFOmiRNgvhQKBzdut1FsAwTpQ4Ppv8VlGDntwgL
 +A5hA/qiwS5ivldToLeaTCmDne3g0GvEc100hhtcH79vKRhhBYUR+yP6+bRTtgH98/Hx2ZW2AY5
 EQZtq2VTsoBaAT++1U7jMars5RoUg9mklFuUcrXwLGXLGYeXXBfkWoCeZX6Qqc+kSnGnWLlsSB9
 oSVNLBQIw2SQE8EZn6JqXYKbwrm/nrz2vPo9KNIV
X-Google-Smtp-Source: AGHT+IFP/SIPMh+gTkEW9MteP+xO5pV0P+CauVKHf7v7r2jnACZDsVkn2dwfD0NoW8lVTDq6vzE7uw==
X-Received: by 2002:a17:90b:1d8e:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2ff7ce6fd4amr27477971a91.14.1741674139241; 
 Mon, 10 Mar 2025 23:22:19 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693f6bd8sm9166089a91.41.2025.03.10.23.22.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 23:22:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Mar 2025 16:22:13 +1000
Message-Id: <D8D7YBC7KXTQ.156IWAC3B116E@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 00/15] target/ppc: Move TCG code from excp_helper.c
 to tcg-excp_helper.c
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250127102620.39159-1-philmd@linaro.org>
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
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

On Mon Jan 27, 2025 at 8:26 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Since v1:
> - Keep ppc_tcg_hv_emu() within TARGET_PPC64 (patch #10)
>
> Hi,
>
> This series is a simply a cleanup restricting TCG specific
> exception-related code to TCG, by moving code to a new unit
> named 'tcg-excp_helper.c'.
>
> I ended doing it as a preliminary cleanup for the "Extract
> TCG state from CPUState".
>
> Diffstat shows 1K lines moved, but the patches are trivial
> to review using 'git-diff --color-moved=3Ddimmed-zebra' option.
>
> Branch published as:
>  https://gitlab.com/philmd/qemu/-/tree/ppc_excp_extract_tcg
>
> Regards,
>
> Phil.

I pulled this in and just added some minor changelog and comment
and subject line tweaks noticed in review.

Patch 2 was already merged, patch 10 I left out because it had a
few possible issues (but it generally looks good if you plan to
resubmit it some time).

Thanks very much, it's a nice cleanup. Sorry I have been slow
with things...

Thanks,
Nick

>
> Philippe Mathieu-Daud=C3=A9 (15):
>   hw/ppc/spapr: Restrict CONFER hypercall to TCG
>   hw/ppc/spapr: Restrict part of PAGE_INIT hypercall to TCG
>   target/ppc: Make ppc_ldl_code() declaration public
>   target/ppc: Move TCG specific exception handlers to tcg-excp_helper.c
>   target/ppc: Move ppc_ldl_code() to tcg-excp_helper.c
>   target/ppc: Ensure powerpc_checkstop() is only called under TCG
>   target/ppc: Restrict powerpc_checkstop() to TCG
>   target/ppc: Remove raise_exception_ra()
>   target/ppc: Restrict exception helpers to TCG
>   target/ppc: Restrict ppc_tcg_hv_emu() to TCG
>   target/ppc: Restrict various common helpers to TCG
>   target/ppc: Fix style in excp_helper.c
>   target/ppc: Make powerpc_excp() prototype public
>   target/ppc: Restrict ATTN / SCV / PMINSN helpers to TCG
>   target/ppc: Restrict various system helpers to TCG
>
>  target/ppc/cpu.h             |   5 -
>  target/ppc/internal.h        |  11 +-
>  hw/ppc/spapr_hcall.c         |   6 +-
>  target/ppc/excp_helper.c     | 943 +----------------------------------
>  target/ppc/tcg-excp_helper.c | 924 ++++++++++++++++++++++++++++++++++
>  target/ppc/meson.build       |   1 +
>  6 files changed, 955 insertions(+), 935 deletions(-)
>  create mode 100644 target/ppc/tcg-excp_helper.c


