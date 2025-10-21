Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7076FCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIUR-00030h-Qh; Tue, 21 Oct 2025 15:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIUP-0002vq-1j
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:57:49 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIUN-0008Iu-4P
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:57:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42701b29a7eso141170f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761076665; x=1761681465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CQXoaofo6NfrBJoG83XIWxyM0hiwuc3u3KVa34QWk1g=;
 b=JxjyUcRPuF1OKt6Prj4t7puDjoaAvD+oQA+MVFTjxH4hJb2vC4es5acm79Z6MNaKOG
 R6/Ed6c6Tv/p1dF0Z5XSOOPpgD4MuVxqulA4w/XwE0ZFu3QF7YuhX3t+dJSeYmomflxj
 rLXNtUi1/D0G06zISOO+1vDjIQxdGdcgGHwK9on2YxtGnXkPOJBDPlGQ+v0S/lBXZCxp
 pYhCZln3mteC6hS/0owbUmVGyfhvBmWq3+FHAg/2sum80Q9Wd6ZDMcA1v26MPwLYaqo7
 6mxumFTWrc0ofwUp+uGz79jxc+ZEOqmrbqlyhgsiuvjwf/Tlxh4bm4Q0ZOyOOrSbHz1a
 uRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761076665; x=1761681465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CQXoaofo6NfrBJoG83XIWxyM0hiwuc3u3KVa34QWk1g=;
 b=LsGKa2JDzGIN8aszzTyE5RPdZU7VHowQPsHeGk3Y010H1ipMQkeiE+q3mZ1y3EbiRc
 GE59kY6ixOLWPTBt7msxgIkbXtY+ll8eu4uJ+prA+0UlgLiGFK2eoXaNaaviDoIs8I3S
 FCA+S8Q4wXJcTef2qAMlSvX+0Sd8z2kVghdA0PhIIvvsKtzK5ZJIaM4oY9rKjadqxjmh
 zIqPVA4ZfVt6/ZLjYEfw5inMw4Ka+WmG4hCYHThsbGupHdIyXEN53zEWDwe94UuTVKXe
 OOOTPSQiqCphdkCuTg0pAcQMln0d3M3pYBm0lrCw7gym+hXCiLOq6o2d3LUHRtRN2FUa
 a32w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVG2CsHvpY6MLplYHzK9Qiv9/FO173JYqR9E+RD96dh+Ru76UJCDMm9AHIWxwAeHLa8Cqht+vLwCJS@nongnu.org
X-Gm-Message-State: AOJu0YwhY+NhlhLXZuTyQFTlpMbSotuvdrnyYWDpWwHojE+Y4VNZKS9+
 GBNrxTM4FERBDAsh5s+kF8xcR5M28v+EPjHQmvO1qO1YqwraC4YwmIyCfX0bC1yA8BoDbaUn5fN
 hXkQ2qRw=
X-Gm-Gg: ASbGnctb2+4Gkv6uFhiNaTi4r42brwtyl4ktYLyeALc00fvRuO9jITCkjSxeEnYEc1W
 AvLMfbRofuZMa+TzKuBfdXo2HAEEiSCkvMZ1FOcqZimwDCBwFBh/CUXAOW6U+t5iVK6KVDZ5xwZ
 DhddPLS2rWQDUkKLg3Rfy2pA4+LtiqEVfVrysOL7LA3RAIboRb/xe7JQGPuY8BaP7KvauC5/l7/
 2woua6MxDmcgepgvffyQ0gWyFh4/54Jr+gM8nmBrrdsIFqpjCFEu9rxOqZwfRyrfYq2+JJzKrZT
 LaTw2jiVie/zByMNEU3Y+eZpSkuNbwakiO7MO2e9tcHg+aa2NbIOEOacvMvVfx+GLp+iJrVsqDE
 1oGGVWfsticB1KIVGqOZFCQjCGVzuIUgi4SEB0Emzv5qkchPA1hT7V5XN4EwVGmw8KN2yO34wRo
 ZE72nBZ4A+VsekttSo3AYiDI0Y5YNptuffnIIeqJL9qvhAgVufUIFWFWcxylklHMtF
X-Google-Smtp-Source: AGHT+IG7V11Gsmi38zj7BQw6tFq6nWVZu5+Mb+omvmoPZ3hIoiZnID8wTr5t4dZov4FkUbR4JA2rIg==
X-Received: by 2002:a05:6000:4026:b0:426:fff3:5d1d with SMTP id
 ffacd0b85a97d-428531dc844mr681286f8f.28.1761076665188; 
 Tue, 21 Oct 2025 12:57:45 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428a5bcsm8688745e9.7.2025.10.21.12.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:57:44 -0700 (PDT)
Message-ID: <c69f0494-e4b1-4107-adc4-5abd1d258742@linaro.org>
Date: Tue, 21 Oct 2025 21:57:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/25] target/i386: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1760884672.git.neither@nut.email>
 <5fb50dd708c97604112c95fcf33045cfe215901a.1760884672.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5fb50dd708c97604112c95fcf33045cfe215901a.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 19/10/25 17:14, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places the hook for x86 targets.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/i386/tcg/excp_helper.c | 3 +++
>   target/i386/tcg/seg_helper.c  | 4 ++++
>   2 files changed, 7 insertions(+)


>   G_NORETURN void helper_raise_interrupt(CPUX86State *env, int intno,
>                                             int next_eip_addend)
> @@ -93,6 +94,7 @@ void raise_interrupt2(CPUX86State *env, int intno,
>                         uintptr_t retaddr)

As a future cleanup, rename raise_interrupt2() -> raise_exception()?

>   {
>       CPUState *cs = env_cpu(env);
> +    uint64_t last_pc = env->eip + env->segs[R_CS].base;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


