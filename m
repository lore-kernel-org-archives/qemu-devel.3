Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BF6C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trh0C-0007QQ-49; Mon, 10 Mar 2025 13:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgzh-0007CR-KP
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:32:52 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgzf-00045K-I7
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:32:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223a7065ff8so9403475ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741627966; x=1742232766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sac58OW9KVD0JTLog6v88FdMndEx1OKs7undtT6nU1Y=;
 b=KgGLchTGltA5Q83KxsqtEqU6FakTOncSpVymHjOephfgngwekIpIdCfYTuaBJS/hdg
 7rOIcNlHPmfTCr1Nep7Gbojg/yXpJBHCXC4ucUDN/zuNRoqniTyxGnSiQXm/9wOKaeTg
 BfYN9gHwUckvSaHjKS3qqCa6KzfbTPpRxYUAqrOjHJ3GkeW1u34y/dza0UHxPWRMHm32
 SCCRpl4epsuR7EtUSk+djIKOsHLgElKGux1K6mlQEJQ69vWJMWErmGJupZ+bYr4fCx7d
 HTfM4U/apBsK+NG8JCo6PAg1vWK7uV8FOi6kv09KhXxw3c05jUElwluU4W3Nk/Aa2Pjz
 0/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741627966; x=1742232766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sac58OW9KVD0JTLog6v88FdMndEx1OKs7undtT6nU1Y=;
 b=LAbZdQD00GPWYhNVwYwDPFb8sV9KshoFMOIBUXC7KRVJN/N6zXdefdFpNfzwHOIGjn
 mH/IBB4VIJYoIhQGdydaWm0uSzoykZjN0hZclN/HOTemngdXXSGohWcnkq2FxCJNZckW
 m4IbvEOma8CKYrasHRFeWlyybESW75e3G/uwsz5u7So3dg86dKyl0KxQiiB2oLhgh6Rp
 IlW0Sri8iG+He4lggg25hNBS0uGbA4mOc4nxQhpKv+UKEC04Edgl9yZZ5WApTMmveMIK
 LGhGILLvuxUbZ1+u9jwTe7LkG5iUsLSkXuv+f8jiqbWNAfaV/7bqnamVTr2+zphGui/h
 VdYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVedoTewbNzF58ScD5hSk32cxgDe1onHcpQgy/iTdQYKUR3yVu5fqXScaJZYotbib7IYUm3zI+uylvU@nongnu.org
X-Gm-Message-State: AOJu0YxA0iJIDeoWnlM43FwFq2cZGcdklW6HFJYUrOJemhcgZ9m5/g5v
 lrnIsuas33EEIT08f8mVaKV+vhXYv42XZH5nlu+rmpXnN2GW1ijXMsz5kBVooMc=
X-Gm-Gg: ASbGncu4yrK6Zk3Ff6/s7TEZm/k/Rj4vNbZB90wnykN5Pc0q9a54ItxiF0y/xvMxyDp
 kc26qkPSOKlI/AwfFG4rh6xlERkVJFQVsxJUkom8Zlg0BnuB8t60DZ/WCOfz7pHXgxrkih+FSik
 3wOhAiLFEA70hvUj6HyY1jxTukTH21zHBGX4IPLCjCWhfFULnQh6uQB7Uj2aySCD+Cqa58IC550
 /n+stKJ0CEV/ILkqE714yNBMdkH6Fo4fkaun+eoo5C607AEpL90Bi90wvAfZKtU92vXECxH6iZy
 pgMXyzhvYC0DRq7GpCeaJ7UNqBJvfQj12kXJ8+90dWNjM8fPQ7r38J+1jqXCNni4OQuY6LSgvKx
 FsNjvfLB9
X-Google-Smtp-Source: AGHT+IEdXhMNYK12E8l65pYeo0hi4c9S2R6A7024I/cK/9c3ID+lqjq3Kl4wY90CrakUxoW5Sj9K2A==
X-Received: by 2002:a17:902:c94d:b0:223:5c33:56a8 with SMTP id
 d9443c01a7336-22428ab89ccmr255617375ad.35.1741627965915; 
 Mon, 10 Mar 2025 10:32:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91db3sm81146525ad.170.2025.03.10.10.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:32:45 -0700 (PDT)
Message-ID: <8f747909-8b40-4994-b3fa-68d9b9c137af@linaro.org>
Date: Mon, 10 Mar 2025 10:32:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] system/physmem: compilation unit is now common to
 all targets
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-15-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-15-pierrick.bouvier@linaro.org>
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/system/meson.build b/system/meson.build
> index c83d80fa248..9d0b0122e54 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -2,7 +2,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>     'arch_init.c',
>     'ioport.c',
>     'memory.c',
> -  'physmem.c',
>   )])
>   
>   system_ss.add(files(
> @@ -15,6 +14,7 @@ system_ss.add(files(
>     'dma-helpers.c',
>     'globals.c',
>     'memory_mapping.c',
> +  'physmem.c',
>     'qdev-monitor.c',
>     'qtest.c',
>     'rtc.c',

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

