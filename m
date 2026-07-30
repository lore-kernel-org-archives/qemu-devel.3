Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D941C55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpTNq-0005ps-2X; Thu, 30 Jul 2026 12:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpTNn-0005pF-OC
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:13:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpTNm-0003cj-8P
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:13:19 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso26192375ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785427997; x=1786032797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PMnWY4HwQr4OPjO5MNU53mmW9BAry2o4LWMXe0HNJmY=;
 b=qVt1zXrZWnMxXhvaIVrasdmrHZ9h4Ckasf68xB4mRdpkXpIsiw7wSkUrOFzw5hC8CX
 RcXX2vikU7M8NJWIE0RZsS9fDtRuCs2sub0+AJDgyU5YNchUTmjpPKLHjJp3Q3jN03+d
 RnLZyU4ngtyclbVH/LfkGg7j9OKQWsuP9xYP2th78oOuNqGO1K8+HEaYGd70V7ZRrwrV
 SlZJLq+KRFI39IUV3X1x9mJbtsvwinXiGzImpFtOA7So34WixB6FTL1MPc+OEKDwNLTN
 /BO8mcHvFNDuxk1IJ7krOL2xvzAyEf3/YcBlxMMk5obrSVNPjeYA9EPRBdtroVkR5Xl6
 2XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785427997; x=1786032797;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PMnWY4HwQr4OPjO5MNU53mmW9BAry2o4LWMXe0HNJmY=;
 b=DV4ebdTPe460ona4yGEZTFZdoIeJ+DAviKw/p1ECY8l5wrEMcl80Yo0NH33sAXSGqy
 tvEHbjHZiC9mqFnoCh81Jy26Uh4vlUISjBJ7TzoJ2uUdHKXxA3e5fN4TcR1VJCCdDW0p
 xelxa2Rwttq9nJ/bPcxeobOPOdhCc9IP+7gHpp8zNTbb70b4HSTye+irdZD/8L6uxU+f
 Zejf23S0DHLjMVSqN8Rpm25YmtYnJxVzbFFDrSqcdyLgs+MN3uLcseZJBoZgbrqtRrZl
 frhE7DulXu/nOxD8+e9BIMbQ4Bpe98m3QtLmIicx/lH25jQ5o3wcWFWHDoqyFSoZWrrj
 Dfsw==
X-Gm-Message-State: AOJu0Yw0KeI80x2r9arorN4+K1J7KH1N3H8AQZ0Hr5IKZt5LK47Trw+R
 Q/GBVQkDrL77NnQXV2LdaK74RTESgLpOPUQz5SqviQF1EryyRgrrcmT3ZrUPMZ300w+Micg/80f
 6xVz4
X-Gm-Gg: AR+sD13yQ5rIZ59x80xWpB3xp4yG/W/6Pd7ci7MK1UnLKxMO/IZcCMdsLJKEGthwFDj
 KKWkZ+f9QWcnV3I+nQeUlY0zPz6sbbhPgKRYU/0MradUEhnB0+jdxb04ELCH5BCFLapI5gN91DS
 xps4TwTy/Xg101AsjNIvBHaFSUTY3W5AM3Bxo8Tllg6An3536ZLdevSUju7o3g8hT+zaeKXPIql
 lPxTYobhjkzrjwZnBgxsNxCwKjSu3KhP/yWRGtWQp6q+GsCjZGC5rkAZ8FwZDv+oahlTXorteuJ
 /+XEQ9wJvzCnW0G6V/Sb3uNuXrwwH5sz8FwBlye8pYt/LW4hrhb2qxgDH5J8mzrwjvJ4nc6KyPR
 d6iJ4oQnBQtke+Cvtn0lp1hgvDftxvl/v4/lrK/ak8je+D9ENe0fJaeTuP5fAi7MPjJMXoXHYKz
 v46wjSNGtFhmHr2urnQpyWkqcH2dUSaHslJ9N88yIGjVH7BwC5FkbxG0O/UEcV+BZJ0WrPXjcfx
 OaMKNXgLElVpUjwZ+Od1Qx/sj9+
X-Received: by 2002:a17:903:2ac7:b0:2c9:e2c1:4fb5 with SMTP id
 d9443c01a7336-2d035ca12fcmr30960455ad.22.1785427996473; 
 Thu, 30 Jul 2026 09:13:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bc8400sm28953615ad.47.2026.07.30.09.13.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 09:13:16 -0700 (PDT)
Message-ID: <2b90dcf7-77a3-472a-8706-fdfcf1d9a6f7@linaro.org>
Date: Thu, 30 Jul 2026 09:13:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/50] tcg: Increase maximum TB size
To: qemu-devel@nongnu.org
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-5-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260730031025.12926-5-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 7/29/26 20:09, Anton Johansson via qemu development wrote:
> Doubles amount of space allocated for translation blocks.  This is
> needed, particularly for Hexagon, where a single instruction packet may
> consist of up to four vector instructions.  If each vector instruction
> then gets expanded into gvec operations that utilize a small host vector
> size the TB blows up quite quickly.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/tcg/tcg.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 7669dc1c2d..9f0a35f1be 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -40,7 +40,7 @@
>   /* XXX: make safe guess about sizes */
>   #define MAX_OP_PER_INSTR 266
>   
> -#define CPU_TEMP_BUF_NLONGS 128
> +#define CPU_TEMP_BUF_NLONGS 256
>   #define TCG_STATIC_FRAME_SIZE  (CPU_TEMP_BUF_NLONGS * sizeof(long))
>   
>   typedef int64_t tcg_target_long;

This isn't the size of the translation block, but the size of the stack frame.  Ok, with a 
re-wording of the commit message.


r~

