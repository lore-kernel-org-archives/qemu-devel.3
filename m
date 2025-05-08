Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983FCC3ABC6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 21:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD8Mn-0003Mr-P5; Thu, 08 May 2025 17:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uD8Mm-0003MU-B6
 for qemu-devel@nongnu.org; Thu, 08 May 2025 17:01:16 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uD8Mk-0001tx-Fa
 for qemu-devel@nongnu.org; Thu, 08 May 2025 17:01:15 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so2142374b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 14:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746738073; x=1747342873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O3XRYcA8W2YyYPPF6UVXOycq43wFy2VdPuzBgGaaZtg=;
 b=Jp9BW8RuU1Vvj4pS4qyFHCcKeisjxaD50cPJQgmxNzbz5ur2R6exu576efM/ZojqZH
 vy5cJSo7QL9z5wwPGINvagANCsn/zUCrVw/5H2kfdZON/rS61Cnw0Nw6cnuPmKxNfXFS
 eH2NPsVcd0Y15UOBlOmPDrx1v8jGB/JsjKuGaCoVX7pHZaUtiIfrQoD7Sdv835sUS+71
 5PvnOcqv+KkJJXIFTsV/4AOiFFPjODXrSDvEEfkK1Q+W/XNpXeXNXBYrnVFTyWsuq8sH
 29z7JnQFAKOhebLq9mXOvx+6OnJzqiPebybY6alruY9kTlHfvyJNegSq9sXPBt3q1YPV
 hLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746738073; x=1747342873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O3XRYcA8W2YyYPPF6UVXOycq43wFy2VdPuzBgGaaZtg=;
 b=eZn2zaC7SMiPTGemEkQ9KS+wf6elq6dohlhhfF7DNMkj/x9rP8hLwUeZ4ltx47/br1
 G5E1glYEsUYyvMe6KAryBurhiBa7nSkKRknq6T6S1+I3OmaHyhMKlc0/8trfnoauyw4g
 Y4eWfNliwPoPbdwbLY5JAoHwEVolhJZJ7JTsSxnRYB3eMoOzp9MQgMzpB2RGay3N3llk
 wE2h4T/LrIcHEfwz3rcelhb2oeRyDsPvqwLaxPQiqFf9rr4ZQv079utM9QsdUouVXyIW
 NtnEKdAklFF39VQu6D0rqDXL3cazTBrc/dB0aRMG4T26XJNnxO6j0lbb+a16YqAAXkKq
 dRyA==
X-Gm-Message-State: AOJu0YyIggRmmgLvx63R9nWPxuRo8zHHXhyHL0mbT9yAtjUnvPhSkJVw
 HE7f1D2OZfpWFUvtI4vdJQH+/QVStK2QqJtcpUMhi5nzHNnlsWSEERZSKUBKlCMSrBm7ZGoAOFd
 c
X-Gm-Gg: ASbGncs6o3uwyN9XMlIcvH7EZ6xniJsSrDEyUK+HdFrNXvxg41aHUB+8BQvG0kMWzay
 wr/sF3iiy9oeRfkGjiRxwUmN8YRhuqFJhUMaIqd687F/Zen/QE7pW5BNVHGuGSoa/RccuKYmSGz
 yqM89dEnj/SHP/04WaPMpAS1r3GTWPyOAeSKMIo1xmKZEJn6Whh0+pcQf7CTU/TveG0RnLvlmBm
 9TmJCIJK4AI1M1aAv6+VXm2N5RVIPaCfIAMyemOW2l+GsQbhKAQJNr8z2JZaXzAjtNyk40VYDsh
 Q3PR5OocD39yQ+H9Djuj8dE0jnDHsD5IzhuTk7j3OuseZ+/WcepE3hEKExtE
X-Google-Smtp-Source: AGHT+IEb6qNoTS+WAPB4Af4bi3CATdo+EVnCfMRkV9kg7OwZmAlJxtmZMOprmnYXVvKHcVUJs5kWoA==
X-Received: by 2002:a17:902:f545:b0:22e:627f:ebc9 with SMTP id
 d9443c01a7336-22fc8b0fad4mr11463445ad.3.1746738072809; 
 Thu, 08 May 2025 14:01:12 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc680515esm4371185ad.0.2025.05.08.14.01.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 14:01:12 -0700 (PDT)
Message-ID: <f8fa2d89-2028-4d58-9722-13e90e09dc43@linaro.org>
Date: Thu, 8 May 2025 14:01:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: ignore misplaced REX prefixes
To: qemu-devel@nongnu.org
References: <20250508095436.471819-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250508095436.471819-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 5/8/25 02:54, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 36 ++++++++++++++++++++++++--------
>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index cda32ee6784..55216e0d249 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -2542,7 +2542,13 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
>       s->has_modrm = false;
>       s->prefix = 0;
>   
> - next_byte:
> + next_byte:;
> +#ifdef TARGET_X86_64
> +    /* clear any REX prefix followed by other prefixes.  */
> +    int rex;
> +    rex = -1;
> + next_byte_rex:
> +#endif
>       b = x86_ldub_code(env, s);

I guess this is ok, with -1.  It might be worthwhile rewriting without ifdefs, since we 
already let CODE64(s) and REX_PREFIX(s) expand to false without TARGET_X86_64.

The only irritating part would be actually setting s->rex_* at the end, because those 
members are themselves ifdef'ed over in DisasContext.


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

