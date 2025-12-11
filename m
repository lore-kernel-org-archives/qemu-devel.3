Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFA2D41D65
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTj0m-0005Ks-G8; Thu, 11 Dec 2025 10:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTj0j-0005Js-Pm
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:55:22 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTj0h-0003an-15
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:55:20 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-450823a7776so161010b6e.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765468517; x=1766073317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ujBG9cJQvgr/qYFJo5AwU34NrNlMfv6xSAXJ+A752s=;
 b=fMcqun9FICOMGYUmbypKR0L8PC39AF7yqh1mbIuBzeT6UP9pTK3OlAaubdfHh35/vD
 3Nov81aB/6FCT8BA/UaHXySftxGWaNPzxlj9ao4NbQ9Et4XCHmHCCz6o+cXOAW98hM6w
 QwmLv9aKpxaEe6NCeifhYbE3NG6HQDyP/ezghUXTMRVmvlk+dFg0ae7L7YSd/mpmAjtE
 TpvDRsSaDchEEYe2Y28/nlRmZgTx/xHYpSodqYZhY30W2WQX61v8xwLsqtCYxl8PS6pB
 ltmTV04ssmVGaWl4FVQnZ1ZjSSJwxZ+sm9dKLilhl/5OERJxcQSB3+lgpTiCoru/Apr1
 UxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765468517; x=1766073317;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ujBG9cJQvgr/qYFJo5AwU34NrNlMfv6xSAXJ+A752s=;
 b=If283xZFbgDB4JiKEYsHZBGvwt8h5T3jUeD5Qkg4gAo4Aiu9bQCUCUcbNSnk/JaHGT
 C+gah6xwKVZGySUGxQklf9stoZkK+kAdeyTY4TU7MD5avIDkvYpHb0/0fCPZQ0YadPIl
 mObiAUHXE7edqHQZc8KzJ0tV2+Mhg/YXd0ivhZrlFPIYujc0Olwchm25RCwzTdpzadju
 P6ZEJ9S4waHz30hTTcg+M9w79ig9+yrl7vDLosQ4b6NvgyxSdJBnfwXg+gf9s6VOyXCI
 U3StCMPx5WAh3Re1Ggjjy1o024PAZX5Mjh/kqlL02X7nf18lo13mBX0cjPjiQxyzeGjJ
 VIkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVehqnAJDDM1y/KoAPqtQX4n89QdH9Liqyj7T4TrKceOqQAF3/vXRMcg7v2k+joQ0/QqNDZ8ueXwp/x@nongnu.org
X-Gm-Message-State: AOJu0YyeQzB+ixwrtNx4Oa9K6LleI27DM5HgzHXKtK/2v9c9LqGHG97i
 U3UboosECy7233qmvKN5mOJIRdXC32amhUVsMOVFS0t6i7bd7K468e12ZIWDt1pNE8I=
X-Gm-Gg: AY/fxX6ValwvO+UYCnDkC9wDhtD2NffDgRzqk/sb9lxdqYbIfUIY2Pb602atPgNKgO9
 dQTH3EbS+k4mARu4blbZz0Erue/tN2FUiQVviak+kyivGfGl73XCLSqTmW3ZwJV7wEt/kFgO2zd
 1ysY0f4mZaibr1AhQWhqoJmKbKclheBLB/FYF0y7431Au1Q2oWM23CMyhO4VZboPBxEDJCwUx8B
 t5xWLPsotVo1giu9ezIOUFXgJQWAdZEjutPGHdGl3DQZBiBXuQM6C2umyqReyLfhz/31dWVty83
 XCj5ePPmZOdqGJkG8ggPWIn1rBkJ/lMWBD1/OzrWCD9Rr4v5UY5vKcQdQM7rHV1ooDszF81myHa
 m5eiTq8emRrf1GXkSeZ7NZaak8KjWW4VlBXg9FxufSqe9i7or12lt7iHg7Qs/jgy7qcOG3IY+Fj
 wT5KBxT4C6WPfExyIfQ9PhjIXY5beqolp+melnc25O9R5eb/tMRvWOg1wyUyNeet3U
X-Google-Smtp-Source: AGHT+IFcppxWw5HwCcpfmIocBxnAU9Ntt3gXqI4HkB7Gk6VnbIagqDlVby/H7srZ/q/1mepkd+WCZg==
X-Received: by 2002:a05:6808:1a05:b0:44d:bf83:d7f8 with SMTP id
 5614622812f47-45586359436mr3555040b6e.4.1765468517487; 
 Thu, 11 Dec 2025 07:55:17 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b9966dsm1205378b6e.9.2025.12.11.07.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:55:17 -0800 (PST)
Message-ID: <3ce39385-92a5-4efe-9cef-984775b60aac@linaro.org>
Date: Thu, 11 Dec 2025 09:55:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] target/i386/tcg: update cc_op after PUSHF
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> PUSHF needs to compute the full eflags, set the cc_op to
> CC_OP_EFLAGS.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/emit.c.inc | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 1a7fab9333a..22e53f5b000 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -3250,6 +3250,8 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
>       gen_update_cc_op(s);
>       gen_helper_read_eflags(s->T0, tcg_env);
>       gen_push_v(s, s->T0);
> +    decode->cc_src = s->T0;
> +    decode->cc_op = CC_OP_EFLAGS;
>   }
>   
>   static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,

Ah, as an optimization to not duplicate computation of these flags, not a bug fix.  You 
might expand the commit message by a few words there.  Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

