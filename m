Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF35EC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u588N-0004q9-2u; Wed, 16 Apr 2025 15:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u588K-0004pc-Nr
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:09:16 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u588J-0004wg-1P
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:09:16 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-af28bc68846so6332148a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830553; x=1745435353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jrDta3utjFSxCgeXQCELcLxs96f+tHaqOnj6I7wp6J4=;
 b=Sq4mEI5lJ/bxxqiLD02a5Om81oLHkyGzcwNfa0rQnq6pwju4rm5ThHEKz1zckmjZt9
 rotnnxn8W4bi4IY1eCNMI/hp+CxbXSsKuXFlHiggSP7SaMo0kVDvvy5XyxqNpy4/63h0
 zgPw3ppoC2r7PMS3kq29nDrpxf3hwq828HwHu2bduZ3hgFtT6SGUgTIofXx/RSXOdXBH
 9hvW/o2PMiuc3N8O+n6xasTe8ZnGDFLXabw6jQ438k8YQQ6A6bc03/yN+j8mV3Ll704T
 Pgmhh1OsP/Zk3+kQgHweq7VdCWcefVk/8BX3xxhJuInK+br5Xhsd6fKsFQFmQbWHqUBW
 B43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830553; x=1745435353;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jrDta3utjFSxCgeXQCELcLxs96f+tHaqOnj6I7wp6J4=;
 b=BuXhYkqO4oqWbejr7idlZ8iirvIJ9ODEcesUI+33+1SVDq8mKRxf4TEnXXXNpNmw97
 6mPYLagKZfKXIc0YwcT1y4Z+ry1DwLKuRRXvKhY6gYcU+NFsezoZegzQP+MNQQJFFsdm
 JgYEh9m6Eb0ozWd0aNZHry+MFckz7BSx5nls0SPmM7qxZLqYdWuw2ban1oMh+ZVmPttC
 cDZWo5Wem8bNxdehCveJykkI89BtRInXY/fXDOkLb/GumtaddNsFJ6q7Nc5UStYbf7ja
 dUdxAOlLeEycpv38ppeXjSVHcIiTNJSyyejBe+Iig2aGwSDfGbSEZsdaDgCfK6yHxVdJ
 Swtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWNETKjbUovF3vfpv5ucU7CsIMJT0OuacBriCUX/R7YlMXXG0/bEPlDEzRAQLcOx7tlNQSM+5nnGnV@nongnu.org
X-Gm-Message-State: AOJu0Yzory3pYlZIBvMIGE3+HTShJxo4VGlMAmdmtdN1rthWEIQUmgwT
 OWmtsLwEBztyY74sP7PViac/rmTn1PQk0dYmS8t6rtj/7vhNiQmJxyYt7JGMxJ4=
X-Gm-Gg: ASbGncumtLu2UjwSWKih1FNrtneabapBnJJQ4pZ0NuLDsLi4dOdCwsrCEgYATDexh/J
 Y2LPdMMkjoFN9h0HY5vpZrbf+scNdzMLjAqY0QAOyat7s+rEotvb23jyRGtvvuVDnwM6MZ30sXL
 HwTUNVvs6s6ozV0rGH+NzjfhtWC1YVyRae20VRk/VWoAI6kC70Hlb0njvPmiYNPxmo603425mNw
 KmD0sNx73LJQ0PgI4b1UDuv3yvDTmUQuwsp/lhUVMESOy43RIQgxDEUszwJAezvp+nRU2j7ucQd
 dY7MYsJ2A2zVjVNrejUDrqu9mm0S2Vl3Ky9AJlqfaz8sNpFaREt7Xw==
X-Google-Smtp-Source: AGHT+IHf9SQ1t1i5bnX87UIRZqF1BBcGE+7xYum1aBv7WjKjkiHGyMsvFqTWxt5rJF2VKnBB2AwA5Q==
X-Received: by 2002:a17:90b:53cc:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-30863d25d6bmr4007857a91.6.1744830553339; 
 Wed, 16 Apr 2025 12:09:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30861211f49sm2004219a91.23.2025.04.16.12.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:09:12 -0700 (PDT)
Message-ID: <33347f38-9fbb-4646-9afa-c49cd305db57@linaro.org>
Date: Wed, 16 Apr 2025 12:09:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 129/163] target/s390x: Use tcg_gen_addcio_i64 for
 op_addc64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-130-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-130-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 00073c5560..a714f9c0c2 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -1250,11 +1250,7 @@ static DisasJumpType op_addc32(DisasContext *s, DisasOps *o)
>   static DisasJumpType op_addc64(DisasContext *s, DisasOps *o)
>   {
>       compute_carry(s);
> -
> -    TCGv_i64 zero = tcg_constant_i64(0);
> -    tcg_gen_add2_i64(o->out, cc_src, o->in1, zero, cc_src, zero);
> -    tcg_gen_add2_i64(o->out, cc_src, o->out, cc_src, o->in2, zero);
> -
> +    tcg_gen_addcio_i64(o->out, cc_src, o->in1, o->in2, cc_src);
>       return DISAS_NEXT;
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


