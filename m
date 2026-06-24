Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57038CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPds-0008Im-QL; Wed, 24 Jun 2026 11:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcPdr-0008IE-Tx
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:35:55 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcPdq-0006Uh-E5
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:35:55 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-842338c18e0so949984b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782315353; x=1782920153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IErdKKe94i4/WXP/vZlxmKkutA3Libx137ppXieDfO8=;
 b=a7CCG1rWgLjY+LXqmSkIp4jbURWFEYCZebMpOT7c1HxnGIVvXjsJQrQDj1APG3gFE8
 NGW+uysQMkNROljk+UkzZaO/yRp4BI8q7U+Tj2ukAZEXrUJeJMSFid98EOUrMaYSSqRq
 0eyxhx4i0uktalAIPEO2XZWnon5qY4PkYAKTzsVZC6VPvFSrsv5lZk/jRzRGMGW3LT3u
 HA24GuZmdD5dXguWg4cRLRMmoweYS+l9Bd0euOGHa+mVHgwQdZYH0qUsazv3kECMjnJY
 9Nyu+U5Zrd3HUpNKer1HqYhrh7c6bWJQePrLC2q/xTAl1SR5B6su493G5CrbqZoXiWVP
 Yqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782315353; x=1782920153;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IErdKKe94i4/WXP/vZlxmKkutA3Libx137ppXieDfO8=;
 b=Dct5RNjuGssu6Dl/iZTkKolZKyGwwDnipkFtgg5xIJynIpSBJl2uNwdjzzgrZNjfQQ
 2Z4PuesYXpikK1av3M6tQvxYLzGUR5FHC1p4ANi5SbGFMjvl3DhIxwfAa6rDUiPxCHOV
 sWyXhPKseozoi+ciJnV8y5q5+1uJ40sl+FmhiLkcWiM+QT8dSxcbCksKl+RK1ZbaKhL1
 51jVMishiU5DN4vtkT8IR3J54GWmIJ+ui2K22V+2eHzkaV4KN9lafAjJYbOE/ju+5O7d
 Hb1j5iA5DiXj9ir2VC6+2UYFC5Ror/VNyJY3ezx2IGlDUvIjkS1KPjiGvQyrUCe8FBTa
 M3FA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SL395ipOSIO2EH5ZJiHCwqF8vJXiUNfq0T/V8e/u+V+Von1d+aSkQahBcuWvRr600QK1h0lkVfHYF@nongnu.org
X-Gm-Message-State: AOJu0YypfMGgkn6HeKxCFr+GuqjMjk7j8XR807OiK3kSagokGaDOmtX9
 Qga3XEqF3g2Ff+RV8s0gfsXJid9JWkCAm4ye466aKxe+g8aS0lVr3076zDaBBKngHHdYiTXwQhV
 higYh
X-Gm-Gg: AfdE7cnrWsB2AWqiGtd+REULUiEiu9c0kKCvk014w9DqDj5a9GWpvrVeB4TFkvluUWx
 P/371EzntmiFONwOWfbCF9OHJe/lnv/AMAd0eEavg3xfrUJkH+p8GoORCBBcBwz1hjWduYH/Kyk
 m6meZE4vyKUoOTKO38PzJ9rSMKyk3VEj4Bae5vAulNCUr7WMU47Ts4b71d1Q9AS28HKM6tZbo+S
 W8E6AZuSL4x/AgTmYUVPWP0ZaBUh99ndytNj/W063GvPo8303wu50Q2BbROEPCRxybG/g+s/g1k
 f/CzGDVKsR8JetemTTPXppRaoWl3yRjwoLbL2dxIbJ2/2sbKCACWtZrEez8hPmUH3kvdlUZ2HRv
 GtIB5INgA3fGy+WVNZuZzgMJrLsKVhCndfCWea53Y/88jkjZNG/Xi6BJYgPX8WfLtKzuBoBaKT6
 tcEEoGmbaYvc6QiWpsV1S6pqflf/YhJDiGKFn/VT/b711ewaljsAPWBPafBA==
X-Received: by 2002:a05:6a00:1acc:b0:842:4612:55f6 with SMTP id
 d2e1a72fcca58-845a2774964mr4804974b3a.21.1782315352628; 
 Wed, 24 Jun 2026 08:35:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a411942asm2561976b3a.48.2026.06.24.08.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 08:35:52 -0700 (PDT)
Message-ID: <97b3325c-9e6d-4d95-b335-aaf705b2de58@linaro.org>
Date: Wed, 24 Jun 2026 08:35:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/arm/tcg/cpu64.c: Add FEAT_FPRCVT to cpu_max
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alex Bennee <alex.bennee@linaro.org>
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
 <20260624-jmac-fprcvt-v2-3-dc6cf8e512b6@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260624-jmac-fprcvt-v2-3-dc6cf8e512b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/24/26 06:37, Jim MacArthur wrote:
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/tcg/cpu64.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index f7a920a202..f259e82dd3 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1269,6 +1269,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>   
>       t = GET_IDREG(isar, ID_AA64ISAR3);
>       t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
> +    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* FEAT_FPRCVT */
>       SET_IDREG(isar, ID_AA64ISAR3, t);
>   
>       t = GET_IDREG(isar, ID_AA64PFR0);
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

