Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3DBE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4lh-0008K3-B1; Tue, 10 Dec 2024 13:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4lY-00087X-O2
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:15:26 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4lW-000340-3n
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:15:24 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71dfaa28eeaso1274545a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733854520; x=1734459320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aRf26W4N+ma7tvR7BwyzRfBJ+xAJLWaV6F6HEdFyTqI=;
 b=Vb7rkJw0JTgHZC1VslOjKtPcGXC7Ng2g71/5Cc8IlThEsuBwCYWWf6c/5gjNQr+eB9
 ga14SNnLd6VeTHPJ4RFomES20lqKxve92SFKXpzCf73yt5/kteEv1iSYOTS5wGGgxKtJ
 LTb0zYJoG+0rlzGUtJuibL0aJd5EWhTdbwuzthkuBC+K8y3zntTGNTDYBcKFYkkg/22R
 6g3eFuHNi2VZ8+3n4ClOmK1FCUmhV1CYwx0Aoog3x7+JaoVoL/UHENJ1XMML0kb37HBi
 ui6uatT/I5OtEhS4GTr/xprpSgsP6Q8PTV3bRstCmFjpD5tju49xXu6y20DJ3YCa0Ws1
 poxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733854520; x=1734459320;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aRf26W4N+ma7tvR7BwyzRfBJ+xAJLWaV6F6HEdFyTqI=;
 b=RDnJ1VXgqk40ccMiKI/nx8lm57yzRWFCr/afI98ntEL92fUmaKNzja4/ieoQeaSisb
 38zUSqdkNFwkEcOIr47mFkWPbZK/v8aZ3i0nmdLLfec0QoObrKDvF08nCZySKZvapUxP
 E6NM9oCw2JlWINKDaZq9sRgnrimCF5WC6GCWrK4S49XLtMNGwEd4ksMFhdZfAGxHtlsW
 l4WAJRKRbekT2qrDJ+SePqqk4GgcsNGKqyPtYonYfuUguqAo0ZZH/U8yKcbAo251vTbw
 vWdmXXLTmTA7TwWMUYlDEstsOhVoSPiAguc3P04DOacSz7CPwX9Jp15WVQveKiaTarAr
 bfTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7am3QZKFRBvd4urS1kOPfnH966oscTRD70A0dQdomooLd5JD4t7lkEfRxFChFBAfvwvKaJQl4tQXT@nongnu.org
X-Gm-Message-State: AOJu0YyuBXy3brGcrFJSDE0dS/B7kR/6vXoEIR4xLzHhk+/kc0TaKrU2
 OfvFiCAtBMgCP6/m2Ka3xt/T8V8xlZQg05DT8Xfzm1PFYMWHmgHxa/lfLb0s4WwB9lpL/EdSm8Z
 a9YNZ0yzs
X-Gm-Gg: ASbGncuP7MWstIeU5O7ntVr86UC4EiGLb67mHojGEY2A88rpoFEw8h301PrpWagX8sR
 NRnfPCF7w01cyOguPd76MmtGqRADio2tG19a8/vJcmqRDwXSIEHKT+EZc6xgiH+68hfnqiRdeSy
 El60wZxTgtmo6LTZn0/KKYEBg8RBFgoR27mwXrZT0vR7xOFaW+IfpwsFb7rgWWA6Jq3ydzKyYDb
 i49B539zPoidkiefMD2D3kqPbV/eEHPD3ro4nGNg4FT4zSBWWLMP2FaB+u2ainXz+dILhg=
X-Google-Smtp-Source: AGHT+IEem7c5OU3V7h6HESMDDq5adY2b4a06BzKFWlOw2rOxpzpk49/3r0dZ442CW9CSV1DtDc9e8Q==
X-Received: by 2002:a05:6830:2589:b0:71d:54cd:5289 with SMTP id
 46e09a7af769-71dcf546d94mr15612089a34.21.1733854520402; 
 Tue, 10 Dec 2024 10:15:20 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2ac352bb0sm1534084eaf.11.2024.12.10.10.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 10:15:19 -0800 (PST)
Message-ID: <29f77cdc-4215-44e5-9196-5a60ce466b18@linaro.org>
Date: Tue, 10 Dec 2024 12:15:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] target/arm: Move the AArch64 EL2 TLBI insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
 <20241210160452.2427965-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210160452.2427965-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 12/10/24 10:04, Peter Maydell wrote:
> Move the AArch64 EL2 TLBI insn definitions that were
> in el2_cp_reginfo[] across to tlb-insns.c.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h        |  7 +++++
>   target/arm/helper.c        | 61 ++++----------------------------------
>   target/arm/tcg/tlb-insns.c | 49 ++++++++++++++++++++++++++++++
>   3 files changed, 62 insertions(+), 55 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

