Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90474D6E2D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIyV-0008SM-Uu; Thu, 18 Dec 2025 13:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWIyR-0008Qt-Q8
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:43:39 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWIyO-0002Ys-ER
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:43:38 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34c1d84781bso1047954a91.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766083415; x=1766688215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a9wmRkVc2hHN+dKlkfjTmFGa5j++zwpGPYuiliQmx4s=;
 b=h7BOnC1heGmb/SHePDp55IIRRz0MeK/PBqxc9cAo00Ypl1iBnGI3mJA6l+7Z01631q
 hR569roPpd/YjC1AAkx2SmIm2XvDm+WBOBec99uSwzbwK7Ii+9+nDrCo0mEsWf8+5ULO
 O3pa7uzKqZRb5y3BiT+OxbYNtClHX9XUIKYZ7tUPbXLCTcnlo+30w1uGEflW+tBzjovy
 t8FBboaxoxSGd7Bn0gTyi8lLni3mKtTfFX8Bsv5Hx6Go1hEDkN00pDefam4oPlAdvfj1
 WIQYjS9qFHjmAmM3Bkt4iCwlQ4cqUSHBLq/GPlNdV5ZcSVqDwWEPU2M5830ohFy3I7QJ
 X+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766083415; x=1766688215;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a9wmRkVc2hHN+dKlkfjTmFGa5j++zwpGPYuiliQmx4s=;
 b=dIwrAHVHa7hOalxV+JkhN2YF14KatjtMDHJ2lJ3amxJ2RBWjl2IQ75qabxc3bRqcel
 UaBhVE9B952ulkeTQ83gPWhdNwu0HmTRWB94tul77dNs0w4+JVM/5P451+ZHC2IZfdk+
 llOhDf2pUScswC9xd2OS6ArWHQ2kfozIyjt2Fwg36bC8hwhdh/+Nephsbw30/6X6fhOE
 6MNrUVL8KRnnfHT2tsSSXm5wkB7Px8OpwizzDIOyqaQAqS/b0Wx8sL9rUg64ExZvJEKj
 ic9I15qkgPhNjDJXiUyGpa4oIwLtBLvvWumgjgro82YcEyst6qQKhL22N5ejyiQXAU7/
 DffQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYkRFajtMSeReOD+PCO1/33PrcE/e+Z6oca24AT1OYwJRiUxTxk7Unmx+DF0BvCqTS8i7MeWmsxNjq@nongnu.org
X-Gm-Message-State: AOJu0Yw/labtwltcRomeUHvgB4zYVVd6JbOHW9pQ3fFVFysfMNAKE7bm
 3PsHlnaahRfyf3Fa25mYmgKmllmGmCyrY1O1Aq9bMaxIQsfr6+XcgZ8OJ42LE1D8wVc=
X-Gm-Gg: AY/fxX4xV7TMqbiuhWFm7pOhMLLQ6WEy8h7cwpjvNVEd+mVrFvvjlKReZi7l0whVYsr
 EsbM1n6Rk2KJN3LCYLtjwPtxR80n2blDgPew41QFwNvJEgs4c378Vzc1tn7r+JvpzbFYedJBpzU
 GVQmEBQZRvpzgljN9+PUTLUYiElov6EYHeLpwV0irT3JeydaB31hB+YRduCN0uciTrDnGDe9XcZ
 snXTlpliLIUgJPFUwew7tuh1hrCPmr/MVnHYh1kUcy6HMkVMoRmhWczFkRQXu9C9eALbdGWbXOn
 ysr91M4WRfgMYyOSCB6ToNIE+1QAnec2tuxEZX//GixqpEEXw54RY/Tb3G+PAWF62rRQYV0Xlui
 PHWCGkFXBjagzq4+26XEBhAYPTfkRqafkum0jAL/yI44KjofWGaLFZueeN4PdYJqwEUmCBQtwxO
 GRZyyr2/DQ9W2ySwLM8SwVNLNilOdyMg==
X-Google-Smtp-Source: AGHT+IEOmcArMu8c8olHdDVlf2xw+TYlT8hRuKY8L4Bs5rjNyey5GB7ONA0FpuHVudFm+eXYzoE2lA==
X-Received: by 2002:a17:90b:134d:b0:34c:ab9b:76d6 with SMTP id
 98e67ed59e1d1-34e921b9fb1mr216357a91.25.1766083414652; 
 Thu, 18 Dec 2025 10:43:34 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e772ac1acsm994422a91.9.2025.12.18.10.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 10:43:34 -0800 (PST)
Message-ID: <de643344-ba22-4cc7-9091-d11edf22c475@linaro.org>
Date: Fri, 19 Dec 2025 05:43:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Error reporting patches for 2025-12-17
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20251217084620.3319239-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217084620.3319239-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 12/17/25 19:46, Markus Armbruster wrote:
> The following changes since commit 7154e4df40468012fccb6687ecd2b288c56a4a2d:
> 
>    Merge tag 'pull-glibc-20251216' ofhttps://github.com/legoater/qemu into staging (2025-12-17 02:38:19 +1100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-12-17
> 
> for you to fetch changes up to 00829ae3845fd11e56239390924e3e74c3a4c144:
> 
>    qdev: fix error handling in set_uint64_checkmask (2025-12-17 09:23:38 +0100)
> 
> ----------------------------------------------------------------
> Error reporting patches for 2025-12-17


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

