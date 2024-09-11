Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FC1EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE8K-0008W1-T3; Tue, 10 Sep 2024 23:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE8H-000887-Q5
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:35:06 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE8G-0001Xz-17
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:35:05 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2059204f448so52391935ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025702; x=1726630502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mRGw2QFBIi4le1fXeLM+0rnq/1+mz5qGNRGg2SDQ+z4=;
 b=P+thZNulPcn+Ss7+No/+MDwe9xoCQU12mEuc/4IznsYBNdtC8abTnWLRpA8gRDa/Hh
 8WFsj1WYE9sOWkFRR5/xD0OIyUYtxSnutgzAEeQsVgWyhHre8yvounxsyRRK4ZFRoxu5
 ENTtmCBlL7g+5XAALa/jT1tU1k01E/VdGNf/zKk/DCI3a6X5FBXJRDxTf+dZmyW6fBcv
 0rLp4lvOqa+c+tKFxBmuTUsCNxBMNY/EkalnHr/yV6q2qbBuyqn6HGd28FFoT9zhO1Sz
 kBQrkh4vb/NHi43tLJQcsCTnTO6ivs7fjTkAKBWsCDUCe0F2BSuimmL7JL4VKc3/NFoO
 FWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025702; x=1726630502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mRGw2QFBIi4le1fXeLM+0rnq/1+mz5qGNRGg2SDQ+z4=;
 b=BkDXraVeHyib4FHjrNANAo4iA7b2o7kHIdlnqrRZvBaQuhVDsctlJLn8ghFDsDo69n
 WsVrmyFv5qs3rBOOzOdrUJOGJqlbdievxxr4ud4mFqpmbN54v0AlujLuqNDDMPXJwatz
 /MQXw8lysdIXko3nyh7uDBiS4bslbgKCfPmrdK0A3KYOddP6DD0UQkR0THpPnDMwg6Zn
 B25FoZIWswa9oInemQWysa80upcoPbGpha57B2K01S2pNxrnB7YzDrpG54aaZnFQNjVf
 WIXpV3QegU6S1yQpMNKTPtXj/NMHzXYFf6d1LCyLt/D67l/3I44q+LXWx0eqIhFVZIRC
 pefw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2hXWfR0FbECdakzOYc5bBK8vBVCY5rKSPLs+BMh4lPco6T3ieROZstXpAI9z8VfwoSK9KnhrBUFxW@nongnu.org
X-Gm-Message-State: AOJu0YyhIp5pSIvaszw/Q225IJ/Qw6/wwE/EIEDEWLmksk/+LrcgBheK
 MNvKjZOrSAPi3Xrxhp6KwPOKz5k6ZRe+6G2AexRuxuCgk5DieejTFfIdkPrg+r71sTWCFCgi2wS
 X
X-Google-Smtp-Source: AGHT+IGntSF2jfORAdyPV6ubhIbTaU9HI8HBA/nefs/BgXrn0bHVDkpCshcDW/nUOrYrr53LYKcCJg==
X-Received: by 2002:a17:903:98b:b0:202:301f:36fd with SMTP id
 d9443c01a7336-2074c5e1416mr43209965ad.18.1726025702494; 
 Tue, 10 Sep 2024 20:35:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f3552bsm54926695ad.289.2024.09.10.20.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:35:02 -0700 (PDT)
Message-ID: <0c718434-95e6-46bb-9451-7651e5fe2393@linaro.org>
Date: Tue, 10 Sep 2024 20:35:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/39] fpu: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-38-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-38-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 9/10/24 15:16, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index a44649f4f4a..cc6e06b9761 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -1373,7 +1373,6 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
>               break;
>           default:
>               g_assert_not_reached();
> -            break;
>           }
>           switch (b->cls) {
>           case float_class_normal:
> @@ -1386,7 +1385,6 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
>               break;
>           default:
>               g_assert_not_reached();
> -            break;
>           }
>       }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

