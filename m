Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B83C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trh0Z-0007YL-HQ; Mon, 10 Mar 2025 13:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgzP-0006zT-Sj
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:32:36 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgzO-00040e-7V
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:32:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22334203781so99648265ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741627948; x=1742232748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FKvTTaeAXFeAoKKy/TUEugm6Lvxdb1J/dR+hd8yG8+Q=;
 b=UyF7QwTmi2x5yzXvD+EAxbhMiAx9+ekPNezr1KE8uMBaFvL++5Y2MSOn66HKIUu/m1
 WXp4sPrvFlTRxFaxkvVEXG/7JUZkS2wKNhTWjypg1b+DDcCTl9Ncr4bGUHaikdLFOTUo
 LkNW91MIOO2SuWHWFPIgyoVdWajYa8R61HEWvN+b7hv8eUxFYVuCXSw80zaQ6GmPXBWo
 t5Ma3eVX/35A8bbpemw6a9jmBi+XJh/nvPch4lv7zdOI524V2Xcx+VUP6vEVkrvwHTLJ
 ZlXuNPMc2Y6iLB3gNLpcLcUzV7Q8GOnvKgygfBjWmmN3Hx3ljVYwFPhTDscru4rxgYfS
 MWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741627948; x=1742232748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FKvTTaeAXFeAoKKy/TUEugm6Lvxdb1J/dR+hd8yG8+Q=;
 b=TDRDu9Hqur8jWhcW9QXvEwrZLb7utmnvTNTSMbpTLpfs7tD4PpimNVFUYS8J2qLasN
 +n9pTpwBbxP6wW8i0oSsJFP8RYu+hrfPOUd2rQtSLkrG+jxDRA0hO5XKFcnpMshwrox5
 nWCvpPzXqYDH3sobTzHP40bTHJfVqWD/T3fRGODgmIQI0yeaO+iIeBz3GNaC94yXIu3s
 X4QVM7r2ZndV26Dib1MX5V4g8YopZeGGSnQir+cCNdCIiZ5edpOqaGeKE1MrsxGmzSxj
 yC/8B9QUabHwCpAvPIAO+YE9v4Wqi/4SnzlujS3f3+0Aq6oXJmBXzaXKLdVs52n88JMu
 7UDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzNhlPAPvGXgJWeaeDt8K4e6Ap8ZWo3sd5/s3EfCp+cBMCylxSP2EuwBKS9zhWtZqTCrBL72/M8qXm@nongnu.org
X-Gm-Message-State: AOJu0YyQdvGGNPsEtd4Y0r67yBcCnw1k3A51S4CwfcygTUc5KPzlo6X0
 MnPo+0j3WtPauSy7m1UAyw9xdiGpZMwzK2vvGqRTqaIYmg4dPiL6F/+2BCOF2OY=
X-Gm-Gg: ASbGncuTCe+FlhSRUt1Y76xly8L3bVGKjYzXqfcx6CtTAXl8ZvSrq07MXnh+AUbUT+5
 L7kv6VgOABYrn1ViesKXNWaXgGzKTY9mh8V3vxNqw1iwxRdrhOeq4ypTnIVZ2Rq8zy/mX61yHEL
 LotZ9PPgtdi3ir44yu1BuswtGjnrom/JsyEj9gdRV5YqEAaQplcLlc6wWpc2se3tGtC5nVsNfxv
 dRgKCQLXWEvxZkY4KvXyQTzHwAcI6BE+281ijrXnNC+sqxhSQukmGu0zTl4NgEL2jAuQuU2gcHy
 hsdVMMez9DEwV39GvUfABpQ5Fe/WAHZYjyCZ8qGbqbHdahoCCe8bW4QXX0+5M3Kr+xjAEKF0vel
 Er+Fb6nGi
X-Google-Smtp-Source: AGHT+IGlsTuVM/mWYGBPfTtazpwhgbmQOPR2gjCm9rQY9M9e9b0UBRTLp/Z541I5JBsXGEodHFeYGw==
X-Received: by 2002:a05:6a00:1aca:b0:736:aea8:c9b7 with SMTP id
 d2e1a72fcca58-736ec5c3c05mr456490b3a.2.1741627948521; 
 Mon, 10 Mar 2025 10:32:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736cc153016sm3620330b3a.173.2025.03.10.10.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:32:28 -0700 (PDT)
Message-ID: <3dfedea0-baa3-4768-9c6b-033cb8b8adbd@linaro.org>
Date: Mon, 10 Mar 2025 10:32:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] hw/xen: add stubs for various functions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "open list:X86" <xen-devel@lists.xenproject.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-14-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-14-pierrick.bouvier@linaro.org>
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
> Those functions are used by system/physmem.c, and are called only if
> xen is enabled (which happens only if CONFIG_XEN is not set).
> 
> So we can crash in case those are called.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/xen/xen_stubs.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>   hw/xen/meson.build |  3 +++
>   2 files changed, 59 insertions(+)
>   create mode 100644 hw/xen/xen_stubs.c


Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

