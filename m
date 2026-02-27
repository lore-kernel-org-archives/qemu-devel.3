Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4B41039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5eL-0002hA-2s; Fri, 27 Feb 2026 16:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5eJ-0002gX-Vm
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:45:27 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5eI-00027Z-4j
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:45:27 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso21819295e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772228724; x=1772833524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d2k3LxyNyA0msDRwcAv+EmSNeU0JqvalL9mqhrE20G0=;
 b=NBAhzxsmaArfogwmwX44hwx7e9XaUWPxLR722fkM28WIK8R7lfW8fq1DXflrZtJU84
 Df1TT9pMlJ9h1AL4sKtz+U04kpUlGPI0GUJov7IeQbw4vjb6qokSVIiZAWkliOq1R6kE
 KcZBK6RQclxeRkcnsH6VpeSvtsFL8e/DkwVySRzvNzZLYifd2iREkpdnUKapA4LHyLrR
 ie5uOSWpKxeH3b8vexz6huzztajzb3+BHnVb4WKqor6zi6rUyxUHzHiqLNGvb+ibcQba
 8xKW2thCd7xjjrufZSeUp1G2iw/odI7mLtNZcT56oip3RxhFrht7b+LcLHwmJIYnZJ/U
 YdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772228724; x=1772833524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d2k3LxyNyA0msDRwcAv+EmSNeU0JqvalL9mqhrE20G0=;
 b=S1kqsUZ5RuQK3cxMmrmAQHkASHNHaiZm+0fDYCL9tlFpMLp02+D1xqfcO+yQYRYIAl
 cVnmwShXABogQObKPknQNr6dvijxQ3M4/fuovkkuwm1nXpEQ9xG3NbTKVaNEDG0U3phY
 uzGlg3pX2GDSjD8QxCIWEcjc3Ruw/ZfR5jQNs5QFinxeLnGXFPu1wSuG2+vbN1kdw7yB
 dvKnqRzhXej/vgyXQS5rwm7lvG89/RnuuqidxocPyrJKtxBYPAVsVCUy9jLe3AVSQtIk
 5RAVvfk+Y8yXakM2q2kPj6x3xKgMBIOJ6AweHui49pGEJZwK4iBGVgaoaSyqqYZUgZj+
 SHPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiBVCzcicJStyxh7t+PhqZmMGoOZ+T/BTbCSCaXApeWxfq8aKFLQwM2Ja+5uqgoIfvzxCBmpjn42Hc@nongnu.org
X-Gm-Message-State: AOJu0Yw/ZhvbFoKfXimZbotwRAKb+1OOyWyLAlVDRhdjDbGCy6Dw4iB2
 hUeLDMZLtMzKYehxMbFZ5UeGRxzs70bDvClp61SBZteS7z/4s1dD1lFpcBUFEuulDqw=
X-Gm-Gg: ATEYQzweuenFnuRsueP/meBjH3e1fcVLVDSMjjh5cKGFZIPwNFJQJR0wVZxFiFkoURi
 QH0E6LfIK72SfYj8I5d83/WTnL/zhFFhH5rWYZndGtzn356qPUiSdAHUV4gpixJ5zg4ddISxmjz
 9GVgKsRWWR0Ul65tpzQFiyRrcW9xcCl3BnUipj9WO5No/KIJpG/2+hXrJ1CWlWygXX6cW2FioXG
 rDLur4L8WPlWomLVWHWlKIRVDna4rl7X6T/DtP6vytCUhk7pHKEdxIWMiwmFg1n04pwqUV1rLSN
 mCXmGgZHtdnq0Cli0Xbi/EN4IhhRAv87ccChgfjNzZ19DGmzxmKvHFwG5dyBpkwvkjHsG2uIzox
 b2r/ptzGKJ8DYBuBQPnop2i14aRDjy4fbvfG2Zn4sBQTm0Mv6cN8n8apQj2JpOUdLIyZfj2cDfX
 A/RB4aYK+hAd15cUPIi5sSk/7wFjz45rlHdOPdpqct/GWU0uytLjUbdUDnCR5+8dCqUw==
X-Received: by 2002:a05:600c:3b18:b0:483:7631:befa with SMTP id
 5b1f17b1804b1-483c9bc55d6mr68602235e9.5.1772228724460; 
 Fri, 27 Feb 2026 13:45:24 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75a25dsm9304666f8f.21.2026.02.27.13.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 13:45:23 -0800 (PST)
Message-ID: <d949b2f4-d31a-4890-8e27-6f05e9977323@linaro.org>
Date: Fri, 27 Feb 2026 22:45:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/37] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-5-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227203627.932864-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 27/2/26 21:35, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/hex_common.py | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index c0e9f26aebe..63f83a8de2a 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -247,7 +247,11 @@ def need_next_PC(tag):
>   
>   
>   def need_pkt_has_multi_cof(tag):
> -    return "A_COF" in attribdict[tag]
> +    if "A_JUMP" in attribdict[tag] or "A_CALL" in attribdict[tag]:
> +        if tag == "J4_hintjumpr":
> +            return False
> +        return True

Alternatively:

        if attribdict[tag] in ['A_JUMP', 'A_CALL']:
            return tag != "J4_hintjumpr"

> +    return False
>   
>   
>   def need_pkt_need_commit(tag):


