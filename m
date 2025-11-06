Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7413CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH1f4-0002DI-Se; Thu, 06 Nov 2025 10:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vH1f3-0002BZ-8w
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:12:29 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vH1f1-0001uu-MT
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:12:29 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-64088c6b309so1634943a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762441945; x=1763046745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YwzN0w6St7GK0tiS0apQaEg90la80zGg9XrnVdabP6Q=;
 b=dcbvG1zAqMdlhDTQBTmrYV0Wbygl1hYBzqfENTje1leBXEZ3Q9YU/apPb+hFMiwdMP
 rLUSytjSJzTMrIy/gLqBo4pu2TiM99chTx5eW492GDYlusbBgFhH1NfhLu3REfBnLuQb
 /CU9bD4xOFnaODwYC4h6+wYVWPRHOjkPFf3rYc8I5r9/pjejckGg6EAioKw16L+2uHR4
 guqKHxSyHyiGvhP8FV6jeE5tEC2tSlSeXY9YW+MdxR+qTJWx1DWTZLkXlKzeXcbDmsZg
 Yu+SDL3UG8il1J7ShiTnnWK/3wwLHniVKQQgCkvYESX3zwofzyJM1NLX7nk8SHqow001
 MeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762441945; x=1763046745;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YwzN0w6St7GK0tiS0apQaEg90la80zGg9XrnVdabP6Q=;
 b=gMwWp0i545iOk+HEZiVOyRN0UH0XDxK/Kb054pWjyiF2/SMVvnDLo8gQR+1Sv7tYhh
 KhPfrxwtfLBKteBTlMtOqE5rKaMcAD8AtoY0zcvO13tTvJRkBlHuwi8IDJzGKq5mh5fm
 U+TPMFL/x9deLG1y59M1C0MqaBMbMiXhOa/VNJJlWmv2Ut3Kxv+BIbqPbM8FZMoeM8aJ
 NqmkwSaDNUAWtmRM+mLVXb6k+uzsV+a3fWxDFV51LAfvhd9/dcb6Qe05UdHiOcXsh+v3
 ixE3vuQp1gH5O8QcZIo9oEymcq8wmQPyekQfHOLRbvkuwV2uOBBqEj3qfRCYOnM2md6v
 VjaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWolC9HBnH5JKrpMkxhHjhDXlHpbIS58m+fzGJqxqIncHtY7aztMot3iC8Cm7ai0Zo3INuHwIEMvLSk@nongnu.org
X-Gm-Message-State: AOJu0YwZP3yAcWsKD6cItEavEkvOBYZGC0tDkl/cB3Xo2M62s7RQZ/mx
 P0NrEwjcug1ZlWxelD2Gqtsg6S3qUAqw90CAtwUqYp8gj7QCXGO05qp1bgq/tjGa32g=
X-Gm-Gg: ASbGncsj8q7cwuG7Lf070By0l5No/KPznGB+61SiZC+bGW0hSrCPZ+7mOI4e/VPSZOX
 Ll0j/dTT+POaXMu/hV+3juag4rO0TCL/+swwj7NZqlGNT4TCWCtseP3K0c3IUt9brLgw4amQddn
 UGzdE66tdCqJWuG1GBQe2Zu7ykcKkSrkqZjy3Ck+vHef7ZcGLNeBi7VmpULquqWrrrlvXANWzL3
 BBNo5r4YRqPeMJ+6CxY3nVUfcmreCbyXItd5Qc5VP+1E4dhtYK5cQ6Wmel7TXJIyw/WneMb981O
 4YHKS6N+HEaki7wUH1K1cIouEROH5soqmLRZL/XVDsH4rhqbfBH5YZku0KS/1iO6Ms/SdyrgWEX
 b+PJXdUcC8QR6BNAfokJ4lfoxHDnLPNChwHSp4QgifgfrwQN4XaKMIQv5ONGOjlms0WVT5pwWNA
 pBXahxw+BZ03MF8cw9TR9QDiA7agI=
X-Google-Smtp-Source: AGHT+IFwGUsPHQ/gppJ59lH8pgoOFIEuMDJxuA3cCZvuvHJuYLOCnXwlZO0AEwgWSG743kNCiq6+DA==
X-Received: by 2002:a17:907:96a0:b0:b70:cf3f:7fbc with SMTP id
 a640c23a62f3a-b72656cf18bmr757738466b.65.1762441942413; 
 Thu, 06 Nov 2025 07:12:22 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7289334257sm242776166b.6.2025.11.06.07.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 07:12:21 -0800 (PST)
Message-ID: <89299280-94da-49ce-97d6-90b085ccd16c@linaro.org>
Date: Thu, 6 Nov 2025 16:12:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add RISCV Zilsd extension
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Roan Richmond <roan.richmond@codethink.co.uk>, qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, alistair23@gmail.com
References: <20251104120012.194899-1-roan.richmond@codethink.co.uk>
 <710d9b96-ac43-4d51-b210-65917bf91aa0@ventanamicro.com>
 <6d00d026-25e7-40a7-ad44-348a7aa4fc1a@codethink.co.uk>
 <6b90bd55-f2c9-4c6c-9058-16ba147f3c0f@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <6b90bd55-f2c9-4c6c-9058-16ba147f3c0f@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52a.google.com
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

On 11/6/25 15:47, Daniel Henrique Barboza wrote:
> 
> 
> On 11/6/25 11:31 AM, Roan Richmond wrote:
>> I understand your point about doing the check before the 2 ld_tl() and the 2 dst_gpr() 
>> calls.
>>
>> My reasoning for doing the check after was the wording of the specification:
>> "LD instructions with destination x0 are processed as any other load, but the result is 
>> discarded entirely and x1 is not written"
>> This suggests that a load instruction is still dispatched but the result is then discarded.
...
>>>>   +/* Zilsd extension adds load/store double for 32bit arch */
>>>> +static bool gen_load_zilsd(DisasContext *ctx, arg_lb *a)
>>>> +{
>>>> +    TCGv dest_1 = dest_gpr(ctx, a->rd);
>>>> +    TCGv dest_2 = dest_gpr(ctx, (a->rd)+1);
>>>> +    TCGv addr_1 = get_address(ctx, a->rs1, a->imm);
>>>> +    TCGv addr_2 = get_address(ctx, a->rs1, (a->imm)+4);
>>>> +
>>>> +    tcg_gen_qemu_ld_tl(dest_1, addr_1, ctx->mem_idx, MO_SL);
>>>> +    tcg_gen_qemu_ld_tl(dest_2, addr_2, ctx->mem_idx, MO_SL);
>>>> +
>>>> +    /* If destination is x0 then result of the load is discarded */
>>>> +    if (a->rd == 0) {
>>>> +        return true;
>>>> +    }

If you're looking to not write to r1, then you need to use true temporaries, not 
dest_gpr(), which may return r1, which will be modified by the load.

You can drop the unnecessary () in those a->{rd,imm} + c expressions.



