Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0679E69185
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 18:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEY7m-0006sn-7F; Fri, 22 Nov 2024 13:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEY7k-0006qv-UG
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:11:20 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEY7j-00024f-6w
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:11:20 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3e5f968230bso1199984b6e.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 10:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732299077; x=1732903877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ETZUX9Ryspj7j0fLoxoG2ElE8otyTmNQMLZNDXeylFg=;
 b=gsWOtmEnBHShqpBgwsuZrqr79ogFfJsgPud86QexrcxMUzMD2i8ow6fnQQGK7v5goO
 Av6B65wSifAosC2EQDT8gHYiSqdoojUqpD/Q/BgvKbX5N+JmC4nBWbRB1GmeYTWGvYSX
 qRa3RcIBQiF6cTsiobmDek+/IS9c8m4pckDZgcKnFUFRhP8D5rWoP5q6G7L3AJk+pKV9
 zJK3CiNE0jon+2HP0hRaVorqRDrHR4/i9ktAAXIGgLL1mSDJpYRVf4WoErKqmTJ/GYaB
 9F0tp/m38OAABgcnE2bL36uHSGqJEfFcv9NkY6b4OpE/HaS8HtLjzht+HqjNhw+K5ZE1
 W5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732299077; x=1732903877;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ETZUX9Ryspj7j0fLoxoG2ElE8otyTmNQMLZNDXeylFg=;
 b=VXHZuJpnn2CkechXaW7z1wvJRIBBrdmslozKmRuhf1CQc77XsnQyvPJwC2MTBiS/vc
 QxpoQwIVLrJooeEjb82yMdATORkpYEXtbYk6oXiOuc4iFbl1rNISZBZdmKHXgBoQYPT4
 baTCoiVvEYkCT6sfF0mLDm3Swf/b1lIbpjzrLfj7b3DhlJC4TXQqe8bL7CpT3jqv4pUt
 vi330AOoeXxteKIvqFlcB3GWrb0vjGRFnGqT2uQC8vT+mGJpX8ufQcUwwZgsm0lya/sH
 mPcU9tk430E/XwMpnQ4c7VbQoc5no8aIeneyh77h+6GdXF9/gsJ4VzsQ4Dpji70iENMI
 Rz5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTewcjNAi8Fm4KpQ6/xwpltLM8WD33XWO+xHmkraUw9mDujJQhj2zSKtkpEHlX3XDZ0VHzNhL/DDRV@nongnu.org
X-Gm-Message-State: AOJu0YxjSPJpVaKN+ERaQddYjeQKrjMZbiitNa5WhhkDEe+ZosHqnjqF
 CnwtIj3yUu7c968fPcTD7SCaFYa2SDih7ECfJygbxNDfFM+6eIm++vzu9HEohLs=
X-Gm-Gg: ASbGncvaO58aaUwW+qopynFJNT0X3DL6k7XtZP0ZnWtLd6fliGEseIzuQsWFC680sBv
 KIY0p+ssVYCYrUnDArdmgB3p2IJZxw9rLksaP7olD5WD8YI+Rum8/f5dESTd4ZVVGZFpt1YACLE
 mWR2zD9oJmfMe+iWqIwptGsPuYg4fuyAhjIHUU0fcG/7op990pNZ6INIlur7vPxxUxseCgbwYR1
 alCfatmV/aCRNkPU370co+sGGQAp39V3w8hc+3MczN4o5FAZ8Zpsdd4nHT/eEPTCRukado=
X-Google-Smtp-Source: AGHT+IGisbn3CFAjzZ99CsGKoYxPqi9Ci17qLHIgfQvaz3Hzjvh7NvF/77XugJjgFXa2UJAHKepstg==
X-Received: by 2002:a05:6808:1914:b0:3e7:61f6:811a with SMTP id
 5614622812f47-3e915a648c2mr5168495b6e.35.1732299077328; 
 Fri, 22 Nov 2024 10:11:17 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e914ed7cd5sm497727b6e.25.2024.11.22.10.11.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 10:11:16 -0800 (PST)
Message-ID: <8562d16e-78c3-48d3-9393-109ba6435062@linaro.org>
Date: Fri, 22 Nov 2024 12:11:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 07/43] tcg: Increase maximum TB size and maximum
 temporaries
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-8-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-8-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 11/20/24 19:49, Anton Johansson wrote:
> Doubles amount of space allocated for translation blocks.  This is
> needed, particularly for Hexagon, where a single instruction packet may
> consist of up to four vector instructions.  If each vector instruction
> then gets expanded into gvec operations that utilize a small host vector
> size the TB blows up quite quickly.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>

I hope this is a performance modification only?
I hope that the normal set of "restart on resource overflow" code functioned correctly?
If you're overflowing these values with a single hexagon insn, then I suggest something is 
wrong.

> ---
>   include/tcg/tcg.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index d3e820568f..bd8cb9ff50 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -39,7 +39,7 @@
>   /* XXX: make safe guess about sizes */
>   #define MAX_OP_PER_INSTR 266
>   
> -#define CPU_TEMP_BUF_NLONGS 128
> +#define CPU_TEMP_BUF_NLONGS 256
>   #define TCG_STATIC_FRAME_SIZE  (CPU_TEMP_BUF_NLONGS * sizeof(long))

Changing this probably requires auditing all tcg/arch/ backends.  The various prologue 
generation code *ought* to catch out of range values, but I bet we weren't that careful.


r~

>   
>   #if TCG_TARGET_REG_BITS == 32
> @@ -231,7 +231,7 @@ typedef struct TCGPool {
>   
>   #define TCG_POOL_CHUNK_SIZE 32768
>   
> -#define TCG_MAX_TEMPS 512
> +#define TCG_MAX_TEMPS 1024
>   #define TCG_MAX_INSNS 512
>   
>   /* when the size of the arguments of a called function is smaller than


