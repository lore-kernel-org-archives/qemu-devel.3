Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680D5ECE58E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 23:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sno9o-0005n3-0B; Mon, 09 Sep 2024 19:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sno9m-0005lv-4C
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:50:54 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sno9k-0000Jz-IF
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:50:53 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7d4f9e39c55so3356531a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725925851; x=1726530651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CZVpjkj2Y/vYHyzMRd/29Btnyk0KW0BXqZmjm7W+rJ8=;
 b=PRsHfuc+n7bUHVkRtwhxVdSO9JWIVFdLES60Y+TCM36fHbTpLfIAv13/0zkLIrPY/N
 Q+P6ONZWEosIbahmfWbyCFlqDHAfQWnBdHdyfyNtzGMplS8MNA/dmZMW7sXk8RVHQUm8
 Llk9PJGyglxFp3L1x+Kb118tjPl6BzfbhV7+cjK4xDaCM7sLEE/HmZlJ1pvR5PtJtecV
 mjvg6XdDrDsuQBJVn6vW3tUa9+Tp8TPYkHPypVMvEuW2F7tCKXua2blLuqPgfU0gp1mk
 XioH9en/WekBg3C9FDj7WXeQ98V11udGyIGfPLH4NBPwrZWgbxgkHj/cWzfImg75+Y0A
 0zGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725925851; x=1726530651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CZVpjkj2Y/vYHyzMRd/29Btnyk0KW0BXqZmjm7W+rJ8=;
 b=mT2Oul6TlFLzfUn7s3+7Rb2e5z/SChJrO/96TZ4dvk85+a/K9u0RMhdxOind9vyXvm
 KLkjHsFr2cHmnhSBTyRib55M2GvLUX4Zou6p4tjhoq7iDPfyJNmXAjOBPrAhcEQYW1Ie
 yTav2TNg1QyVp1UBiFwD4imJGYBbBwZA6mwJOUZjZidUKEWKlwi1dbw/9guSQWAFzVR9
 WCowA8B7K9iqwlKfToT/whhq6l2M7izz2jQN/rCQ4j7QuN8ZKq2v/T+uYMFET3M9nf8Q
 sad/TymRzjvPYCnXdhZHzovniSjRapkucmvPrfvpEFMvg8BOMlfAs8Md6mIma03I64+6
 8wEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWddoYzyuzyDDAMShecJut5mm/bG2Ud6FNdz+DH5hoCBzutMlY634zDeMKQ7+MfPH7iU4PeIREI4h8b@nongnu.org
X-Gm-Message-State: AOJu0Yy3jkIhz5+UvdHUjs9XNFgMfBy/WB1kKMFQjmI3etWzTc9j8xQa
 yZIicHbbuWW8rWLjF3dviE7xyt8QoYtavfTyI6rrKUYRTQM8oWayGPFDp1iSPBw=
X-Google-Smtp-Source: AGHT+IHt7bikpLTrwKldTNp7gkaGUJgtK6tPX9uzjgXPa5KIaEw/0XnwrvEwRVrSZNlnq3LHeEM73g==
X-Received: by 2002:a17:90b:3cd0:b0:2d8:e524:797b with SMTP id
 98e67ed59e1d1-2daffa7e131mr11189273a91.18.1725925850649; 
 Mon, 09 Sep 2024 16:50:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc07681asm7185326a91.33.2024.09.09.16.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 16:50:50 -0700 (PDT)
Message-ID: <9aac4861-b9b6-444a-b0fd-db03f21b1343@linaro.org>
Date: Mon, 9 Sep 2024 16:50:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10 2/4] target/s390x: Use deposit to set psw_mask in
 save_link_info
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240605215739.4758-7-richard.henderson@linaro.org>
 <20240909231910.14428-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240909231910.14428-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 9/9/24 16:19, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20240605215739.4758-7-richard.henderson@linaro.org>
> [PMD: Split patch, part 2/4]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index faa6d37c8e..53ec817e29 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -1417,6 +1417,7 @@ static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
>   
>   static void save_link_info(DisasContext *s, DisasOps *o)
>   {
> +    TCGv_i64 t1;
>       TCGv_i64 t2;
>   
>       if (s->base.tb->flags & (FLAG_MASK_32 | FLAG_MASK_64)) {
> @@ -1425,14 +1426,17 @@ static void save_link_info(DisasContext *s, DisasOps *o)
>       }
>   
>       gen_op_calc_cc(s);
> +    t1 = tcg_temp_new_i64();
>       t2 = tcg_temp_new_i64();
> +
>       tcg_gen_andi_i64(o->out, o->out, 0xffffffff00000000ull);
> +
> +    /* Shift program mask into place, garbage outside of [27:24]. */
> +    tcg_gen_shri_i64(t1, psw_mask, 16);
> +    /* Deposit pc to replace garbage bits below program mask. */
>       gen_psw_addr_disp(s, t2, s->ilen);
> -    tcg_gen_or_i64(o->out, o->out, t2);
> +    tcg_gen_deposit_i64(o->out, t1, t2, 0, 24);

This is incorrect, as you've lost the high 32-bits of out.


r~


>       tcg_gen_ori_i64(o->out, o->out, (s->ilen / 2) << 30);
> -    tcg_gen_shri_i64(t2, psw_mask, 16);
> -    tcg_gen_andi_i64(t2, t2, 0x0f000000);
> -    tcg_gen_or_i64(o->out, o->out, t2);
>       tcg_gen_extu_i32_i64(t2, cc_op);
>       tcg_gen_shli_i64(t2, t2, 28);
>       tcg_gen_or_i64(o->out, o->out, t2);


