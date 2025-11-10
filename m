Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83859CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPva-0001Ko-St; Mon, 10 Nov 2025 06:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPb7-0006jg-I9
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:58:09 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPb5-0002UR-Vu
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:58:09 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6d3676455so871303a34.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762772286; x=1763377086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XH1dyFYaMy41jqBk6zO4fEN1pY0YSH7APDXwfIHvgo8=;
 b=EK5Y2iWvM3OF+mnet5RXDpkNzodolpDxEaLRnRlQmuw1QSahuAToUwIvgKWZ3JCmwN
 FhsHspw/EcNyh7Pr95SwoCECuwjuTjjNkqqHk/hX2rqzvKUaoPbFpNfjiUtaJMtimFRA
 9Q3H+w3gcIjSUMo8qOQrNaL93LyV9mf8ue/MqjZHcltDr7gL+5ONKb5hQfy5F2HDtky+
 BxXJfe2lmwfIRgFuyIVuBuOygaegdq76Kuh+eILImHkyWSwUr+tDpciJYXN3S+ag6KSI
 qYNqXRM1JyvNHiOYkF6BpKpYHHgsh7Q40dY5yuWSPQbiZMTyngZVQoC2RZ9quW0RqTbn
 z5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762772286; x=1763377086;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XH1dyFYaMy41jqBk6zO4fEN1pY0YSH7APDXwfIHvgo8=;
 b=aFYpnAU+H6ny3YWSlTp3s//c988BdPPbERJ6fPo/xQT8UqXZoWW9RtCtQZfIy+bHfa
 365WzVZiJJ1nfkdd1L1W6hXVI6OK3FnHna/ohTrgoaMi7+ccJw9uR/ot3Ud3D4J3DFgB
 Am8wlNGl88uumenXzNczJqkr2j8vAD+7sCPIB+XSTDcVGBIJQqIojLJsXnSunoL1nde2
 5jdjjR7Oc/16DOkIRmadsSTHvoC09dsN+l5NXmkEu/DySS8k9jRL8uquOntIrVIot0pG
 RBSo3a2ZUayLbBSJHOb13hEVpPiLNTCMp6Qqcv/Hp6BzO1l2Z3W4TQAqCyQGAE2ADma+
 vSng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKQwR0wjGJrM4an3/OJ28G2k0h2Cb4ajPWNLK3Mgpzi09fg37Cnnz3tPNzWgI+6pgu17gwOAh4az4v@nongnu.org
X-Gm-Message-State: AOJu0YwD9kyL9bqWvgajVEhVteEgIBt/4ZLAzh7fYi4/zOIsZsr+gwKM
 G5cb8KTL4k2gFrSxH57zqxxYmd78mW/7DCfn0SFV2YkjE+87YMXu3XvdmdNygNkz/Kg=
X-Gm-Gg: ASbGncu5G/lEN6lfW+qn7aNC7x9BnEIabz9mHsuzh5WDFnbSFq7kei2vCfECQfLUU2O
 QlmuRtOhD0PrrAZbKxxTkZm2T3cZ6ms2xwpQq2YbLI8eBhQjZ2NyYmr+8G1Z8KdYUlyEdZDD4jz
 KoneHWiEV8acbv5GgNZG9XX5qqCyLkRI8Rj+3O6aiz5YtygrGTQ8jZC3mAuwZkQdk+ihYehkXqH
 TRicHFkPG4Fy0tkZjzenM7V4jvNp2m2dlhA6rWG8Zyp18Xvs3py+WrOLQ4CTc5p6vBsHKiYU3qc
 3udPcUOjbr6OEpZr+QhnsUaNvt66DeW/MpsUY8uBCN99WaNczG1K2X7kEs4uWFSLOwAcWH+fjUF
 SQ1fBgqXUQspSr/hQ+nHq/riBcSnEIGBCgGX8lQduXx29wgEl0vjNE1Aq9Vj2qEZZC5x79qK+pn
 A5KATVA8mO96kq/0Jydrw5O8d2zjX/1MqIaXZe2l1wN12GG+2twpb3G9vLH0iasvqgNIY=
X-Google-Smtp-Source: AGHT+IEFy2T+v2r0buRncwoIv3tjngNiSOgHKMV0z6V6y4y9JI/iWEITygedDulproA06J2Ja6clJw==
X-Received: by 2002:a05:6830:2b2a:b0:7c6:de69:a05e with SMTP id
 46e09a7af769-7c6fd7d5db4mr5747098a34.19.1762772286651; 
 Mon, 10 Nov 2025 02:58:06 -0800 (PST)
Received: from [10.89.10.227] ([172.58.183.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f10f5c0bsm5477062a34.18.2025.11.10.02.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 02:58:06 -0800 (PST)
Message-ID: <5d05e71e-0ba0-4bde-81bf-1911ba5562ff@linaro.org>
Date: Mon, 10 Nov 2025 11:58:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi/parser: Mollify mypy
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru
References: <20251105152219.311154-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251105152219.311154-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 11/5/25 16:22, Markus Armbruster wrote:
> re.match(r'^ *', ...) can't fail, but mypy doesn't know that and
> complains:
> 
>      scripts/qapi/parser.py:444: error: Item "None" of "Match[str] | None" has no attribute "end"  [union-attr]
> 
> Work around by using must_match() instead.
> 
> Fixes: 8107ba47fd78 (qapi: Add documentation format validation)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/parser.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 1bb1af7051..c3cf33904e 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -441,7 +441,7 @@ def get_doc_line(self) -> Optional[str]:
>               self._literal_mode = True
>               self._literal_mode_indent = 0
>           elif self._literal_mode and line:
> -            indent = re.match(r'^ *', line).end()
> +            indent = must_match(r'\s*', line).end()
>               if self._literal_mode_indent == 0:
>                   self._literal_mode_indent = indent
>               elif indent < self._literal_mode_indent:

Thanks.  I'm going to queue this so that it's in the next CI run.


r~

