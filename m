Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5079BC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPtG-0001Ee-9D; Tue, 20 May 2025 12:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1uHPtD-0001AI-EO
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:32:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1uHPt8-0003A1-Mw
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:32:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so48654095e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1747758738; x=1748363538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=oge6xpkkPBm5sp2qTNAQ0CSvOPpEwfREHq6d9z7MvoQ=;
 b=gfRnMRCfKqmE9PQF4BjEzXVL+A8TUTpZ3o5NNjLso66Zylt72sxsUCBUWqPpOVjCwi
 AhHvxTSNdQZoZY6sqJoIW5tCMRT53jfQKcZ0xf6FIB4jTAOfWa4jjuwLhbWudxeLHjnB
 PXgQn/l3m+GTxA/NM8FJjIE9Weu+ZpAElK4ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747758738; x=1748363538;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oge6xpkkPBm5sp2qTNAQ0CSvOPpEwfREHq6d9z7MvoQ=;
 b=T4VxPtTyCItPHXA3Tx7Ll9eC1AYs0ilHdmHroicexu0ZO8iTV52SeXwx941bR5LADM
 JQpB1a0NaPi4fJU0mbPzHXHI0SdXUKwTwOOYpSewG4jpdF2B5ZSCxzMUZfv5KM7TM/ZU
 rbQyI0H8CtxYfR8dWxYzLT1rv00Ff7dFVlk7v/38knN/ccEYQUh6/3+yBelhL8FWNYjM
 w4LHprSn2sIcEn35xOyI7ENU+pz07gnvZQR0eiyVsSq5AB2qdMjmRd9noz31gizF41DT
 znfKiCy2n70cYb4e71C2MoLVLn4nxy2gjmF2hXL3Bp+256N/GXCSWDgNaTkcvVTKd/8n
 GCyg==
X-Gm-Message-State: AOJu0YxL4WfGnfDzak1voIjraTe1Os+qIGCaD0RFTR1w0FNeKtLt4oWT
 1ysz5lL3CQLucIQuFcxlnDV88eewUlw9NhJepmI4+9DPFx+LZJuu1f/5Tt/mvlAQopdvq/f2kzQ
 YC2qL
X-Gm-Gg: ASbGncv4UMWTCdQHSsyq3JLxit9LMCdP0OJM4Cby0Qf55uzrSqxIRxWzVSfykUZZ5Pj
 Ba/v572Ldix/hQJanlEcnzV2sRI9ed41B0jQ6eqJKwrQjoW5ktPYkQPG1+HLMM03ijMNSSwmsCk
 swCugXNaUyBw/BGuQyCVcPsyKMzquxzDxeYxEiscGVXWAUNN5FK9uLyS8BvGJzgMClXV3EviLzM
 KTscplnN6NAcIuZ173FHAvwRFzQCKIsBXkxplbpgfBrongAX6y6hHZ3D2YxXOR8UeHOKpVdn+NZ
 nQlnxU9E9Ut+0S6if9CM9ERmJFyZRH5fb0muzlGE5A2xIKsSdw46LtDJqrhoKVHz5B8sCEuFOJ8
 sc+gqZYaQKiqzkftb
X-Google-Smtp-Source: AGHT+IGSGX7eNFG/R+53d98lhQeLpKYbzW5vWfb0PfX9yr8H96cgtoACS48fzFsD+dwVOKBFmP5kcQ==
X-Received: by 2002:a05:600c:1d88:b0:442:ccf9:e6f2 with SMTP id
 5b1f17b1804b1-442fd64452bmr210222395e9.16.1747758737962; 
 Tue, 20 May 2025 09:32:17 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f062fcsm35683145e9.15.2025.05.20.09.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 09:32:17 -0700 (PDT)
Message-ID: <7d9801e5-5be1-42db-a6db-92e89ab11f1d@citrix.com>
Date: Tue, 20 May 2025 17:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Fix #GP error code for INT instructions
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250312000603.3666083-1-andrew.cooper3@citrix.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250312000603.3666083-1-andrew.cooper3@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=andrew.cooper@cloud.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping?

On 12/03/2025 12:06 am, Andrew Cooper wrote:
> While the (intno << shift) expression is correct for indexing the IDT based on
> whether Long Mode is active, the error code itself was unchanged with AMD64,
> and is still the index with 3 bits of metadata in the bottom.
>
> Found when running a Xen unit test, all under QEMU.  The unit test objected to
> being told there was an error with IDT index 256 when INT $0x80 (128) was the
> problem instruction:
>
>   ...
>   Error: Unexpected fault 0x800d0802, #GP[IDT[256]]
>   ...
>
> Fixes: d2fd1af76777 ("x86_64 linux user emulation")
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> ---
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <richard.henderson@linaro.org>
> CC: Eduardo Habkost <eduardo@habkost.net>
> ---
>  target/i386/tcg/user/seg_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
> index c45f2ac2ba68..ff328b2a9522 100644
> --- a/target/i386/tcg/user/seg_helper.c
> +++ b/target/i386/tcg/user/seg_helper.c
> @@ -64,7 +64,7 @@ static void do_interrupt_user(CPUX86State *env, int intno, int is_int,
>          cpl = env->hflags & HF_CPL_MASK;
>          /* check privilege if software int */
>          if (dpl < cpl) {
> -            raise_exception_err(env, EXCP0D_GPF, (intno << shift) + 2);
> +            raise_exception_err(env, EXCP0D_GPF, intno * 8 + 2);
>          }
>      }
>  
>
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32


