Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD7DC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 12:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rab3k-0001qz-O2; Thu, 15 Feb 2024 07:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rab3i-0001qK-6e
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:41:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rab3g-0002CH-0S
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708000903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R7FRWbNq8MtJjCK508CLqpEoSOt45hz+LKNRmBj/pSo=;
 b=UKEy/3/iN7K6YD4R8XixLurhsovthwQKX+qfojY7TvukUTo9t+1D37J/4jx89Nhhii2qfg
 fe826OttUdzimuRzOULmYuaSE4LY7h6WjEzSZn3H06WFxZ3it/WugULJ7yHOPIkk4Ts61K
 dGfr4kxZKBrUEb7vqBc/ruYCUlR1ReU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-FjmE9maDPXawHmRrOZsVAA-1; Thu, 15 Feb 2024 07:41:42 -0500
X-MC-Unique: FjmE9maDPXawHmRrOZsVAA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3c3f477eb7so38704966b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 04:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708000900; x=1708605700;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R7FRWbNq8MtJjCK508CLqpEoSOt45hz+LKNRmBj/pSo=;
 b=JnhHDNcCg9/WCknDbPBghFC+NWemtQaVv3yBdHCdMl4IrDRGgWkRipSGKTRm3TNZEf
 1uoRGGVRk4sbiKbveuaSFC+vrO7MeAm2MP8WjqD5rAselIwp3/S949kBgM7X2xP4Yr6e
 KBkJzpeaTVv2O6vOtsOX16t+GndPiEUYe7NFGtex/c2AZhId3KzDlhGHi3cSg325KCdM
 3rHPOji/aDhcy7u9bASmKzyVR+7rt3gHa4gfCau57wpyCSTRJdF+sAbxtv3hXUSlEm99
 rNsnV0OSRi1+0E2YTFixuqlSvr76VRghAMSdhx4sBOPSUnNYiYLce+NmBI6romN1gRsH
 mBGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJE1pPdM43kDdE9felqUJZ3ZrVv0nyVaULTNmCr8k1SOCjWtW3hjj7x/oDxYO0OkBH4e6X7i6Ikn7Rt8iKVA5zb8m2heQ=
X-Gm-Message-State: AOJu0Yz1WaU20b5HFpkPAFPxVZLvQb5/fCPWXHjV/eAtFPBhIPrWy+FL
 GHzEvvqsFr6gRJzyJ5CZWYRk/qPq792nBt/uaOp+0UlyrtumB7KxwrUyg32uMP4+iAhGd6vc2+D
 HuJkc0/TPhckDRbmne6RNo0rce96FHMp5Ax0tAI7sc8hNE+upYHPhJHwZ549+
X-Received: by 2002:a17:906:480d:b0:a3d:14ce:d95 with SMTP id
 w13-20020a170906480d00b00a3d14ce0d95mr1313666ejq.47.1708000900068; 
 Thu, 15 Feb 2024 04:41:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSo4TnZmBtQMw4VmCWeDAuR69S1GD0EeWpwvrvA80W4R7IrBJ8iJ+Bgp88UA0MaXvU7f3ErA==
X-Received: by 2002:a17:906:480d:b0:a3d:14ce:d95 with SMTP id
 w13-20020a170906480d00b00a3d14ce0d95mr1313653ejq.47.1708000899781; 
 Thu, 15 Feb 2024 04:41:39 -0800 (PST)
Received: from [192.168.1.174] ([151.64.123.201])
 by smtp.googlemail.com with ESMTPSA id
 pk27-20020a170906d7bb00b00a3d716dde9csm504408ejb.44.2024.02.15.04.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 04:41:39 -0800 (PST)
Message-ID: <48a8fac8-cee3-4062-8529-7a3b7f6f6c92@redhat.com>
Date: Thu, 15 Feb 2024 13:41:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/i386: Generate an illegal opcode exception on
 cmp instructions with lock prefix
Content-Language: en-US
To: Ziqiao Kong <ziqiaokong@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20240215095015.570748-1-ziqiaokong@gmail.com>
 <20240215095015.570748-2-ziqiaokong@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240215095015.570748-2-ziqiaokong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/15/24 10:50, Ziqiao Kong wrote:
> target/i386: As specified by Intel Manual Vol2 3-180, cmp instructions
> are not allowed to have lock prefix and a `UD` should be raised. Without
> this patch, s1->T0 will be uninitialized and used in the case OP_CMPL.
> 
> Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
> ---
>   target/i386/tcg/translate.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Queued, thanks!

Paolo

> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 10cba16256..07f642dc9e 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -1507,12 +1507,13 @@ static bool check_iopl(DisasContext *s)
>   /* if d == OR_TMP0, it means memory operand (address in A0) */
>   static void gen_op(DisasContext *s1, int op, MemOp ot, int d)
>   {
> +    /* Invalid lock prefix when destination is not memory or OP_CMPL. */
> +    if ((d != OR_TMP0 || op == OP_CMPL) && s1->prefix & PREFIX_LOCK) {
> +        gen_illegal_opcode(s1);
> +        return;
> +    }
> +
>       if (d != OR_TMP0) {
> -        if (s1->prefix & PREFIX_LOCK) {
> -            /* Lock prefix when destination is not memory.  */
> -            gen_illegal_opcode(s1);
> -            return;
> -        }
>           gen_op_mov_v_reg(s1, ot, s1->T0, d);
>       } else if (!(s1->prefix & PREFIX_LOCK)) {
>           gen_op_ld_v(s1, ot, s1->T0, s1->A0);


