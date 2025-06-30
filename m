Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DB2C7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 06:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW7op-0000YI-Ah; Mon, 30 Jun 2025 02:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uW7oM-0000UY-Fj
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 02:16:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uW7oK-0003bU-Bp
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 02:16:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso38888325e9.3
 for <qemu-devel@nongnu.org>; Sun, 29 Jun 2025 23:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751264170; x=1751868970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4L9j7uIEbNWoQdi4SI+/tEVLo1YpAkTUUXtt4ydFG/Y=;
 b=Z/0MHfciqo3RUecrl2XkUmh3L988OZzBTWmmqlfT2dlOLFMTu1YslffCgoaYZ3UT5U
 Dib+bbA6pxJbcdIwMMhw2Gdds2IF5os2cCUqPV4ntxyLw8lKukcdvqgwhDC5svNRJglF
 zJrKo+YPtLgwJdM/tLh/T9ddLAJeO/49LCjF4KhEzGgBpd0Qfw1gzNOpa1mhzXBYJydG
 y+jyEgItptFq8yVaNnUAt5a3fy8+LqWWV9j11mctL+hwqqnKtOTbV6tCURrpMuwWAuVq
 A+llykibEpbojAykl5imfm1sn4Nxd5k2SjSs1F2VYjku976eTPw1LZeEd7QwhOKgXsGw
 vILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751264170; x=1751868970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4L9j7uIEbNWoQdi4SI+/tEVLo1YpAkTUUXtt4ydFG/Y=;
 b=LTegKwdV5pmq2Ut+jqItJ6bTE8otFabfIcZtsAZfwaEvM8J39IwmzgZt6w86ygmOK0
 K/cMnZUIU/kFq0+h/ZPht12xs+aiCcFBE3MkhOM9o/K6plzeVcs4ujLXz6Ov2BVJIYlK
 Mv3ollrhK60Rhlw6sXZHxcNbUmy2rWZFmygYYXk6vKMs0fV7AnWfn/bi/SwF9O0EbaF/
 GtEwBUaQBNkhUccUX4nTUe401MXBjnZjmxxT/Lm1NzgL47iTXysbXSX1YZU+t/Gy6/g+
 oSNk63EOJoC4661a9E7jcKeLuOSFRRRT2h5ODKkvjuANREV3ZLpnh8CcpsBOUwdFhex+
 uqXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpXwH2YopMDa+v3b6tzmR2Necdso0DsDMooCigT2vXSKPnHMCX4l97vw6kP2E8Fiouc9cRrfGpHYR1@nongnu.org
X-Gm-Message-State: AOJu0YzmtTZVLA1aFHWgU9aEWGbgQdjBkRvdgegOszjGM7Ki7ZZ+LFb5
 SCtbcgQ1JVvWApexPj8lXez1R4DVCKHDBgOAX6jjlsk3iPDlQuOvLVLxES0ZYbmmxetrpBAODxv
 k613D
X-Gm-Gg: ASbGncsVY7VCRZZx3M5mpHknhBOP5GTDrw0Wh1GGhGjASiUw5tidIntjxg+GLj5WR2Y
 NRCoSZBK6LS7UIpdiekx+yiJDQQEuvS1vYX0SoGtCDQlkqym1VMSpmzzRTZh/hTW1AUiN6YR7uU
 0db62jtQ9lD9MLtIlrOQChoiTIqoWthYZatCGBLQGs85kR+zy9c+XVC+OsOl3x86H8vOYjTKkEa
 r4WKtHMqatQQWUlNbc0ValxM+RRu5a/f2qu5U0MS/EgVXu4UxIdl2uM3J16U8XJ5xHtHCnR1/FZ
 QBExLqArBLZc7KYewKj+M2xuhSXU5WzoGgpnAPyhT3KslYMDd/XtmqbbNaF4Dngclg5nUuYa6eH
 e5gG7/2U3u0U9tl8xtBsiBZGVGV+UvQ==
X-Google-Smtp-Source: AGHT+IGtL94zFaVF0/ouqEY4fEn1TbKJpskLCLkjyr0uGcV2hVF1dAf8VqKG76H4XgfWymTT9pnLlA==
X-Received: by 2002:a05:600c:c11b:b0:450:cfa7:5ea1 with SMTP id
 5b1f17b1804b1-4538ee55a30mr106732255e9.16.1751264170279; 
 Sun, 29 Jun 2025 23:16:10 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a5b7fsm126229775e9.10.2025.06.29.23.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Jun 2025 23:16:09 -0700 (PDT)
Message-ID: <669620a2-325e-4d9b-b132-a5942218ddb5@linaro.org>
Date: Mon, 30 Jun 2025 08:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: set has_deprecated_props flag
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, fiuczy@linux.ibm.com
References: <20250630024404.940882-1-walling@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250630024404.940882-1-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 30/6/25 04:44, Collin Walling wrote:
> Now that the deprecated_props is an optional field, the expansion method
> must now set the "has_deprecated_props" flag in order for the data to be
> output from the response.
> 
> Fixes: 448553bb7c (qapi: Make CpuModelExpansionInfo::deprecated-props optional and generic)
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   target/s390x/cpu_models_system.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
> index 9d84faa3c9e..5b846048675 100644
> --- a/target/s390x/cpu_models_system.c
> +++ b/target/s390x/cpu_models_system.c
> @@ -252,6 +252,9 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>   
>       s390_feat_bitmap_to_ascii(deprecated_feats,
>                                 &expansion_info->deprecated_props, list_add_feat);
> +
> +    expansion_info->has_deprecated_props = !!expansion_info->deprecated_props;
> +
>       return expansion_info;
>   }
>   

Oops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


