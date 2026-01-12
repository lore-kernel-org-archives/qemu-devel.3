Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C500AD277CF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEvn-0006Vf-BL; Mon, 12 Jan 2026 05:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfEvi-0006RL-6a
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:13:47 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfEvg-00079q-RA
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:13:45 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so42742225e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768212822; x=1768817622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N8aqD12xOoCufFXcGpNF3lLHRx3HXq/0xzFT847jmlg=;
 b=Eq3ykiD769zbC4v9edIWUpqwAOAF8+/miUCSvx2GbGa+is3TqIuqTVcmynPsu0Udil
 pm1ykoUUHAPxWDTsvdYueJmBjFJkXP5aP317FKcZw5xGzFq0vmJmbDm2nzcD5+EyAnU3
 2f8NZkVqkWS2cpyVWw7S9dJQB1+EOqlKpB0oXKodKbpeuMqiYjKdlDVBCvc9SD7E8Kj2
 ndVKolSiBwyekzY8Djp4O2XlKG2uPrShhHIYDQ20PNysq0Gs6MlhhzBmR6AdQ65+qMlr
 HjHcQ8m27E+kuxj/AV14swb6RuaeqINgjC4xypehcj/hfQgUbBxVDfcrMNmL2r6IvkfH
 Q+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768212822; x=1768817622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N8aqD12xOoCufFXcGpNF3lLHRx3HXq/0xzFT847jmlg=;
 b=ubGWqml4D+QvTlFB4twl047ABY5ERjo6tweY+xDqL4PW2MuFzT4s0W0FQ+3YI6WuM0
 09xOyHlpXkKzEa34PzyUB85QHgv5v+7t7zYyd/qCVuoCafzXzxCgCkUXcJ8KDBr8+5Ha
 NV8dovROnYVdv0MwcGSXz1GkgpawZt3J8mW5CNpO9+eGhNdt7BX5m3PuhzlgFkGDnniT
 x1LoY5uDI+E+PfZ/19F9WQCNAH4eo0J1r9vH7pIhlPswisMrd8Jt55DldokpLkBGTBUT
 BbFTEMetbtkZErwqC2SUVqmEXvHfiTOWyW3ZZWB+COPdOTmk+exg8ZaOocrOHUZa79ky
 cLFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfR26s/7CMjGKTqQLfXhwluNE7FvyStcjMtyOWLaSdJBbUHQiOjglK4+mmbq65uCvMG603RIw3Z3/I@nongnu.org
X-Gm-Message-State: AOJu0YwKvl8GupkyLYw3/dC9IzZNYSx1X3PWqivfwfpJb05F0pormVxF
 wm36rnC4SxqJA1LRkXaC7Jq8kp92adSguMvnSKp5V2nUac0Y60FauyJOK+/deVfWB0JLtXUOCyY
 cUJKdA3M=
X-Gm-Gg: AY/fxX69R+LmBG1zfS7CRYbDxLmqVEUKK5FuaozwVo443d6SnyX4ecOqt422aJwmBr2
 W9wFPsFO9oBAWtno0gKb3wtuiYsjS5CFY+fNYzv1fQRkPAMoxrGxJu5gbmS3B2KRHjvFSvcifhW
 1JFglq4m5xZdd93nclX2Rz2sF+gNXGCVYeyWpnBFfM4fKyIc2j/A6UI+YLwtXe+rOY/oikibg1/
 OIHcyJeJYo2kGYCVDm1DY2qhR5fhmJvuBAaUFEp/fowWDWQeRcOtIb2TTHhxBIOGltoh5A1jcjM
 2EDzY/dpiYT4LhOFCuvL4X32UP2VIQ/kpMHH2D3Rxfr3laRAfaYTQLTWA1aZ9hlGZDHTYDfG7l4
 3NRjHxAbseoRAxo98XnS0KYBOol3MTHlgqX9FDYoz7QZNj0CCsqBzEHj0uFMsM07vD5M0Kn8Mlt
 pm46jA7qPBFyePsF63Q7tB34vbUny/4BpvbFxYb7p/vWlHJqNkd7tFig==
X-Google-Smtp-Source: AGHT+IHx2ExmqzvFXyHXIW94/ley89BN6y1qaiGzDdYdoJhKpau7RwTyezCFJfwETCqXSAqVsMeRiQ==
X-Received: by 2002:a05:600c:444c:b0:477:a977:b8c5 with SMTP id
 5b1f17b1804b1-47d84b5b51amr217346745e9.31.1768212822306; 
 Mon, 12 Jan 2026 02:13:42 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0860f5sm37664819f8f.0.2026.01.12.02.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 02:13:41 -0800 (PST)
Message-ID: <b575794d-48fc-4ca5-82ed-4acfb5598ebe@linaro.org>
Date: Mon, 12 Jan 2026 11:13:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] target/riscv: Fix null pointer dereference in
 cpu_set_exception_base
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "alistair23@gmail.com" <alistair23@gmail.com>
References: <20260112090458.2345280-1-djordje.todorovic@htecgroup.com>
 <20260112090458.2345280-3-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260112090458.2345280-3-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 12/1/26 10:05, Djordje Todorovic wrote:
> Add missing return statement after logging the error when cs is NULL.
> 
> Resolves: Coverity CID 1644077
> 

Fixes: 209c2c9af62 ("target/riscv: Add cpu_set_exception_base")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.c | 1 +
>   1 file changed, 1 insertion(+)


