Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2D7E9410B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 10:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbcpy-0006Sv-4y; Fri, 02 Jan 2026 05:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbcpu-0006RB-RR
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 05:56:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbcps-0002wZ-AC
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 05:56:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so64740215e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 02:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767351406; x=1767956206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRU6gSh3mMKteqWYhrDkKojuHknBG+ahgq/nZ4+EFEc=;
 b=FPFa2Mq2xGlKAuk0mwBYTWSS3itGkKa4i4pd1RyNW+oG+3cwEfAf49fuRTJmq6IsGd
 Wb5V0dfeqKqImsnKjJuEKIoYkShC6bBISjOXFYcGb7ndoTfn/XTDxh/UZpt9pT0b4Nad
 NeLTyKhtIK3CLfe04N0fEO5iDF3D6fxShVvxZBSwK9s9PbUWI2B34EC4Mh2HLFlRTM1f
 4dk+7/0lLkSiUp5eTjMKirew+CeSyx3dFBKhvXIEmu+y9oqhOQ01Q/6iZrwyVkexmxY2
 t4XBuO10U7tNf1b+T9cXBV1xXyso1JPorxE8EqxWZq4ipknbSqrFR+KCs3U5OJkD5OwD
 gF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767351407; x=1767956207;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NRU6gSh3mMKteqWYhrDkKojuHknBG+ahgq/nZ4+EFEc=;
 b=LIR5DB3RvYcXUzB+maM9XoKgxO9SVXglDpgKwmlBzBPkHRgdGF2mc5TWJkjxyNcl2o
 dHuIuGF63EQC9HnCPBFEN7CAfGTU/p9umELEuZVLP0O5FGE41pNeK94ml0GH1AVKlFU5
 Um1OZLWHoShZi5L7Nsfi9qWf086RyMiL13KkQ3uwdZwkJVpTt/bpVlln+5WsX8uggB9Z
 +JPfKaLUC5sriAq6UTtUA8ufCvBheBR0TNhsrCuQTgj9PMistnSIVQaImkAprUhMMsIn
 0loCJxs/omeKOaNyZ/wsdTrKV9f3UtArLZV4bZfyOq9+YEPlxJSyLRITwz9TJBALO2JI
 bFbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5AuviAtEf/7fk8QnlAwbDUL31Jfqk/Q+40uuKblZlSy6raewHwn+yvlNAro/RJcHEuu33cPBddtGn@nongnu.org
X-Gm-Message-State: AOJu0YyYITwcsBq8hoQM+xLuKUE2NwFc9Zgq0E1sJ2CGHCTbENArOwAc
 L3fLwYB/o/abIRcKqGhVi+yynAumy2bJjQirQ/hodPbmq1Wdpo0J9Fy5fjcXZxpFGFU=
X-Gm-Gg: AY/fxX7QpolItaYVlqkrdIuzgykPC7DJ7+2G/0a59yx34keF9MKX+2x6sUjuMtMPUPt
 /II++SmLcnPFYWAE9EGRYFJx06eNqvLCG7qBCvo7LjHyfonS8B0dmJ/ni9V9nfOS7jG/pM3q5cy
 /W+Y4VnAaYCWOen5pk3nqiwm/j7ex87K98tq+KCTCo4xyPBM5pcMsrBVwpohYHevloD61GlB3xJ
 EvCjmcgvskFzZys9dHVtbvNZQR+BR7N60SwlPH1P3edfARQh+3G3CaqT1bM6YdZsz66Gt8v5QcM
 0jAnQ4Yl0yiLvAXPnUSiwLVot994LHLKsYLXuiIxpZLtoU7v0y9IsQ1p8Dz0G7JYYqK0HZYVx/C
 XTxgHfZwWtZUQJCWFT92IhCLl4NtJMYnTUj6s6svaGr6xtegeUQDS2UfXPKpQrkkFW8sJAYimY7
 VfIt6MtQiarUE=
X-Google-Smtp-Source: AGHT+IEgCFxfzDN5iaBCYLEeHQ321oRDyR9+ML7gyWOrcjniCzSGYXlBD9z5XE7AXKwpAwFHY789sw==
X-Received: by 2002:a05:600c:c83:b0:479:3876:22a8 with SMTP id
 5b1f17b1804b1-47d19555940mr532890615e9.16.1767351406586; 
 Fri, 02 Jan 2026 02:56:46 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08efsm84673261f8f.29.2026.01.02.02.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 02:56:46 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6EEA25F7FE;
 Fri, 02 Jan 2026 10:56:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH 1/4] target/arm: Don't specify ID_PFR1 accessfn twice
In-Reply-To: <20251231170858.254594-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Wed, 31 Dec 2025 17:08:55 +0000")
References: <20251231170858.254594-1-peter.maydell@linaro.org>
 <20251231170858.254594-2-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Fri, 02 Jan 2026 10:56:45 +0000
Message-ID: <875x9kxoya.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In the definition of ID_PFR1 we have an ifdef block; we specify the
> accessfn once in the common part of the ifdef and once in the
> not-user-only part, which is redundant but harmless.
>
> The accessfn will always return success in user-only mode (because
> we won't trap to EL2), so specify it only in the not-user-only
> half of the ifdef, as was probably the intention.
>
> This is only cc'd to stable to avoid a textual conflict with
> the following patch, which is a bug fix.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 0f150c8499e970bd ("target/arm: Constify ID_PFR1 on user emulation")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

