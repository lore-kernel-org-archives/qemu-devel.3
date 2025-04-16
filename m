Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9A8C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u588h-0004t2-Tf; Wed, 16 Apr 2025 15:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u588g-0004sd-BC
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:09:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u588e-0004yU-No
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:09:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-227b828de00so345235ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830575; x=1745435375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E1DSAUZv00bvhxLY/a353//l/EsPQEOYBdmJeJAGniY=;
 b=oDqUUjFk1IiCGhGYEtT7F9XCTn7czHlvGuwnaIt7NzwGxRivLwz/PlBOAsYI9x36pc
 6Juo8HuRnPP7MtypuzXqhCMGRjndil7TQHdIX8CCTv+/VF/CLvdUYMTeXOgQ3/YTRRHM
 n11dLIZb2YlHyheJWmXaTvxNz7dZiUxiAjBDP0Fl7Rc9NWSNBkIOhNyN0RhlvV/LOQvF
 kgTYBft6qXsy4PpGReE5R0BqS7mX/RDtkCX8TBM2l8lyQO+1F0L3jWp4q0or5/4KyoG1
 UU/M0/hLcWfXvaCpqz2c1VlOv1Ww8XnMEfFxCpHsF2GN26U+8Xu3ir3FCpXQosAc/huy
 Kmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830575; x=1745435375;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E1DSAUZv00bvhxLY/a353//l/EsPQEOYBdmJeJAGniY=;
 b=pECO0MkuNnA99HES6hqKHAmf2xBC24XYjQtanVRcDGlzflX9Y7mq8OqCrQ/Qhu+Yws
 M+vDWT0lMU6p3Kc46tK+O2+Byf+jW4AUro+mLcufUQ0jab3hC7z+BmrLaMWZXr1voX05
 Y2R4X3AlDNDuCYsWwXTGomBNEKPZIVZQhWaa8y/oTImnWpvmRtAxt2/fvR9I1h3iUY51
 5+QpwCXTumS8sSBVKy13pfpoAQZxNBmCYj1hUcEvikSXp2r3xJkQVCoNxwaSATcdwN3i
 4mYVNGHKTKpkH7xjuOVrTx8+xEj5jSYUrzGF9njE88sM3z14VXriONrp4USD5PSa+sSx
 +Jrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOLdluryuTX62+/tS0UwXYthlltTLbGQIgntY1HMzrXkWFi11rboYpPuBtf3fBWcL4tX1MCDzOHWy4@nongnu.org
X-Gm-Message-State: AOJu0YwB+QxJnJqiV+wBVCDxZ56wG8CaccOfUPPvn6SPCsGDYBD4G1XH
 anrLogN3x1N+PL4D4uIpRYYUrrzgtTZf927vIzrNqg7zS4r/wUbEm5vhFEJ2ovw=
X-Gm-Gg: ASbGnct8tqLekgn0HTzjPoceqzLilACmOYKTN6hN2G+LEEGwbHEYeDZUUW1sw5t8eZW
 K4ZQ3MOleSVirBGTj+jLJ/piC1wcG3b+SVppkkuQPWPCOSXJjPQHomTg+pq8IvDDlE/6EHXhDxt
 rbXvZxEL2RJd6/6xjxSE2Q00r99Ad3bjdSxhtMaGjjttmleh0QXcPFLPRp71kQtxYTr9S0nUgkt
 5md2aOlRXniNYj+XmWbYDr3ZHX5WLW/LNEJAY6BSVhc4VFyCV1000HMRdc3WnFr3rm7KmAbZ7at
 maouXzAL3dNt2H25bJ0rBq/WNdjThbQ9owVU+eYxrXr8m0RgDIwg6w==
X-Google-Smtp-Source: AGHT+IE0vN/xg7qSkf6/+ooPT7f894ZjEkYDG0JYfAVIc+KAf6I7EfRhb99WgUyttymtFteTqieRzA==
X-Received: by 2002:a17:903:3c6c:b0:215:bc30:c952 with SMTP id
 d9443c01a7336-22c358c2930mr40168435ad.6.1744830575042; 
 Wed, 16 Apr 2025 12:09:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82f6sm10822530b3a.88.2025.04.16.12.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:09:34 -0700 (PDT)
Message-ID: <55eb490f-5014-444a-9940-6d6079d1971a@linaro.org>
Date: Wed, 16 Apr 2025 12:09:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 131/163] target/sparc: Use tcg_gen_addcio_tl for
 gen_op_addcc_int
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-132-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-132-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
>   target/sparc/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index bfe63649db..392b51196a 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -395,8 +395,7 @@ static void gen_op_addcc_int(TCGv dst, TCGv src1, TCGv src2, TCGv cin)
>       TCGv z = tcg_constant_tl(0);
>   
>       if (cin) {
> -        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, cin, z);
> -        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, cpu_cc_N, cpu_cc_C, src2, z);
> +        tcg_gen_addcio_tl(cpu_cc_N, cpu_cc_C, src1, src2, cin);
>       } else {
>           tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, src2, z);
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


