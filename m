Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E401E83EE8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnXtt-0004l2-Fh; Wed, 04 Feb 2026 03:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vnXtn-0004kk-TE
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:06:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vnXtk-0000NR-Ep
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770192363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0c2t6Yusu6KsnJ4xgZRqGw//Zn7MbBHkAFOd/3NKmk=;
 b=RXgmlpz/J7x6n0imDt3bX1xNOfb/syW3D5qBBHml8BZfB2AQMwvKGqyi9lp63hf9XdYyCV
 woVpe3qWPKEKHlE4q1aRMwF+8jFxqJkQ4+kJtOHEA0xT+XhOdqqXJpXBvUSI8J97CdQseM
 ovuNOi19z+L3zV/BjdjZO2sN+WqSifY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66--HWym0a8M_-ojeb7CiDdnA-1; Wed, 04 Feb 2026 03:06:01 -0500
X-MC-Unique: -HWym0a8M_-ojeb7CiDdnA-1
X-Mimecast-MFC-AGG-ID: -HWym0a8M_-ojeb7CiDdnA_1770192360
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435af2d3144so4326627f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 00:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770192360; x=1770797160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B0c2t6Yusu6KsnJ4xgZRqGw//Zn7MbBHkAFOd/3NKmk=;
 b=uJ7A0G5VpqgV/j2koccfGE4ZM6Yd6nTbN1YNdiAP9M4mFCLrABip6H09o0vTPASpEa
 X9TuvwGKAx7LAQU/x65ZJLqnC+TI/ZVb6Wkv2vME8iBMN6StgSapfxOZ3PXeHyGS4AtL
 HXq6DPhfzRR3c9YkssAxZe/5mutEekvFoHEnJCGvvw9CaZpX++lCouosmD3K+sLYpWox
 6m2kn+jquY/sfT1whn+0yn1PZy9e+P08TUtuf0hj+8aEoWp5aYSuX49JOHvNMjaPTkC+
 KrdMifbVvNBYWhywoYj77ThYn4lqCgbSSbvt+W3FU13QrYb+V93E7e15eOFqRQFBG5xa
 M2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770192360; x=1770797160;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B0c2t6Yusu6KsnJ4xgZRqGw//Zn7MbBHkAFOd/3NKmk=;
 b=AkUou29xFyKlBDH/1CN2L7rRxcOwYnSuRzerWIAbACD8R74neLLSwh3UhkhqVPkkPg
 0Q5z5oTF4uNaANmsH7d58HZ3U4RJRosi33aNUQGiSB74nTp1G+3z7s/nO0D3VXBkEJ2Z
 Knh3G8ErrK3K1ynER9YykJCyvVK12I7EubgrR/dZf/R1OKd/OwQldG0gdpcalZzsXW/Q
 WX7SRM/nqGP+8AV46Uj2otmVMmPkORODpj9A38KdlG7HmaiANNS9zQoPaIJscEkeSvRE
 fHk7LMz4OEvkZKdfmP7SbiZciODFP1nWetO9sWUXz/t+4y7Ol38zXE2IQUEGmtVzoAPY
 aX2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhE7UrkBwwAXqSo0vElZ73DvBkNZbmZp5E3In96+RJ5Pvk9kbtpTpMvnJ5GLGnPSWptePWSXgDiITp@nongnu.org
X-Gm-Message-State: AOJu0Ywov4fORMSJjR8g7w58XPAVxfAz2mX78ipHJxVHudhwQYmgMhe8
 8FjSqi9i0UE52dHHcgwXYkh6vE8FDSQw6hMs52bRsx++BuqbczKmJbbuU4oR0/I3wbSVg58/DiL
 u8O1rn9PMYepsnmNPrEV6h+c/iC3D3iIvWA1YEB6yl4Al/9tMOe0kqkfi
X-Gm-Gg: AZuq6aIIQMflaGs0oBvoJB9ndBJuYMH/O58p7q0NnxsvdPHiI/Fjxg7pyJYqgUjPOnA
 iB1HQaIJtL9bA3aYKofJwtLY1eN5BHt5ArcmYkyZFdyhJW4uXhi8LH6BhqARz/toiReNB7sTrMA
 iAiSFULkHoMy6250+9E5UDRn6hqck13XCLwDEI7rDqDY7O6eKM96RAUDJCGxwWyNU9ign/ArGCM
 Zm2WZA3DSbw0VjQ27Gfpd5tZEpkcSdR9MFS1JUHdJiZ0aSIJ9vmWVuwpCUc5mLxw/HJzlXro7ir
 +woRwOI+y7erazkFPRO795/IJj0T6g8WCUlXnf9NnB0qvim2FY10QjO1RIB4W+fSixpfYPoqqOI
 jBI5axq1PWhVssmIVUI7tBb2/bfhuh7i++a+PGeBLGriMut9Ug+z15G8a30+9x+Ws1RdLVO+2WV
 iRTe6GByuoIzjvLw==
X-Received: by 2002:a05:6000:2893:b0:435:bbde:dd43 with SMTP id
 ffacd0b85a97d-43618062940mr2538474f8f.61.1770192360128; 
 Wed, 04 Feb 2026 00:06:00 -0800 (PST)
X-Received: by 2002:a05:6000:2893:b0:435:bbde:dd43 with SMTP id
 ffacd0b85a97d-43618062940mr2538443f8f.61.1770192359682; 
 Wed, 04 Feb 2026 00:05:59 -0800 (PST)
Received: from [192.168.10.81] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43618064813sm4583576f8f.38.2026.02.04.00.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 00:05:58 -0800 (PST)
Message-ID: <4bfd463a-f7ba-4bea-9fd5-27c1a05045f4@redhat.com>
Date: Wed, 4 Feb 2026 09:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] tcg/optimize: possibly expand deposit into zero
 with shifts
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-7-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260204052456.970605-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/4/26 06:24, Richard Henderson wrote:
> Use tcg_op_imm_match to choose between expanding with AND+SHL vs SHL+SHR.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 40 +++++++++++++++++++++++++++++++---------
>   1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index e6a16921c9..2944c5a748 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1743,10 +1743,17 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>               goto done;
>           }
>   
> -        /* Lower invalid deposit into zero as AND + SHL or SHL + AND. */
> +        /* Lower invalid deposit into zero. */
>           if (!valid) {
> -            if (TCG_TARGET_extract_valid(ctx->type, 0, ofs + len) &&
> -                !TCG_TARGET_extract_valid(ctx->type, 0, len)) {
> +            if (TCG_TARGET_extract_valid(ctx->type, 0, len)) {
> +                /* EXTRACT (at 0) + SHL */
> +                op2 = opt_insert_before(ctx, op, INDEX_op_extract, 4);
> +                op2->args[0] = ret;
> +                op2->args[1] = arg2;
> +                op2->args[2] = 0;
> +                op2->args[3] = len;
> +            } else if (TCG_TARGET_extract_valid(ctx->type, 0, ofs + len)) {
> +                /* SHL + EXTRACT (at 0) */
>                   op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
>                   op2->args[0] = ret;
>                   op2->args[1] = arg2;
> @@ -1757,14 +1764,29 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>                   op->args[2] = 0;
>                   op->args[3] = ofs + len;
>                   goto done;
> +            } else if (tcg_op_imm_match(INDEX_op_and, ctx->type, len_mask)) {
> +                /* AND + SHL */

Even if these extracts are valid, can they really be cheaper then an AND 
with immediate argument, or back to back shifts?  You still have a 
dependency between the two instruction.  I wouldn't bother with using 
EXTRACT here.

Paolo

> +                op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
> +                op2->args[0] = ret;
> +                op2->args[1] = arg2;
> +                op2->args[2] = arg_new_constant(ctx, len_mask);
> +            } else {
> +                /* SHL + SHR */
> +                int shl = width - len;
> +                int shr = width - len - ofs;
> +
> +                op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
> +                op2->args[0] = ret;
> +                op2->args[1] = arg2;
> +                op2->args[2] = arg_new_constant(ctx, shl);
> +
> +                op->opc = INDEX_op_shr;
> +                op->args[1] = ret;
> +                op->args[2] = arg_new_constant(ctx, shr);
> +                goto done;
>               }
>   
> -            op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
> -            op2->args[0] = ret;
> -            op2->args[1] = arg2;
> -            op2->args[2] = arg_new_constant(ctx, len_mask);
> -            fold_and(ctx, op2);
> -
> +            /* Finish the (EXTRACT|AND) + SHL cases. */
>               op->opc = INDEX_op_shl;
>               op->args[1] = ret;
>               op->args[2] = arg_new_constant(ctx, ofs);


