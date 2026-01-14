Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE632D3CC88
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 23:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgASl-0008HC-48; Wed, 14 Jan 2026 18:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgASj-0008Fe-Lm
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 18:39:41 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgASi-0005UZ-7B
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 18:39:41 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0f3f74587so2631095ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 15:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768433978; x=1769038778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R2FqAeIgTLxlJAHEqyaSx4oxF5sBS9zn1KQsbpWEH/A=;
 b=wMTK8phOvD0e1W71R3b2lE5alPNYF0btGxGaIMf5DEi2Qle+EWGfgxaruxlJELaL8R
 V0pmXNne86Uz1bb+LC2WJViNafeCHSQcMV1Hm3Ga+VbFvjdOjvwpxR1jUJEHFpsuq40G
 Yut7Om3V2faoJVonOsPJ0wgOjvCVxhTF1QkNVkh5wc9EuCbTxYnj31uQsvDiC5q/q4+z
 FHhVkC6iiHlj2F/1w+jCM1VfRQ/0PgGTeeYvbJInUom8b088Jk1TTXfD1+L7cSeB/wd1
 CqKklZjh9yScuXi9ZPDRmDgu4138/vg7MpBx1kiTsZ33wO83oHrnQ/rSLcqT7/Gu7dy/
 mf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768433978; x=1769038778;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R2FqAeIgTLxlJAHEqyaSx4oxF5sBS9zn1KQsbpWEH/A=;
 b=JV5IEMLV9WOjAEKLkHLwN/JezT6q5+mMw427ITPp3/WiqqCZQR4BDyBSDeYrrtyi6T
 9cf6FGbaKi4Dxzb8sIlmYjWty70GaQq5KmUzCvKo1gf9OjGQVaZSMBcwBNl9GR5405Up
 VQwJawpXsDqgnICm7uFFhLNDJWZ8RhIgU+aInvxKrieKTC7h1mNN2JtpN2eUeK4J4Kyw
 s7CkaPJbT/R7B/XML1wfynTOdEx16nTU9GgYJP/UdtInvI/u3QPUKA505WGepnSN1Sr5
 tYJ0X92c/GgFsC7lpAMyS6tKwGz0fnsqo0VqdQ6ULKj4GOaktVVvsXfL2vwVQwW+4f5T
 +2mA==
X-Gm-Message-State: AOJu0Yx2S3TBp3jNcK7s7KfsayGWd9s5CoCGA72JTEnIZiblWB29i8kp
 2o0f3M/czJwX/uAy8jBVu8H9ytrV5gogMAho1YdW8cl1EBHuN+fyIROBJtK58m5NaXQ=
X-Gm-Gg: AY/fxX6YJ9VWAKlLKNsym4Kg9gySpXE4a2DEvpJsHhbydg6Iq60uAT9xErBoJP41wIV
 GxspROcHgJgkwl9Tgt1OhXbbsogFF3X4yTaAJY5c0kzDsKIvYP2T92eT/grg8nYAtHMXxMegO1d
 iPFTTuLLt/gIZeJYSAqPxy6G2to9akfrtHJ2PdGtFpIBX4k8Xb3Hbd7lVFkhYO6vHYg6aI0C6kN
 shv4oV03u/NG7v78sTm6TQs67NqfV7FpzrHFhN4xUdQGFPVlXayPMBtb9lkkrjaFSUshEnS5Isl
 /XVTkOxkGf53HXq07AJrsBWncEJNAD/XuMAfFr6+sYXx7nOwyvj/mzclbPQ0U4O2bfRYFq8TQuM
 VgwbfidQfyDJyydFAapzuy1KC4MIQHdEEaGkumHYy5rtiG34lUIXlRvCW0VGEFcSAXitZpy6Ve8
 ZavGEIrUZ55LTS0qU/B/u8mpZT5NEhQIIV+35dzd/q5MYxRn23zE/ewBfy
X-Received: by 2002:a17:902:f651:b0:295:592e:7633 with SMTP id
 d9443c01a7336-2a599e2b429mr45782425ad.29.1768433978102; 
 Wed, 14 Jan 2026 15:39:38 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a2eesm71298595ad.6.2026.01.14.15.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 15:39:37 -0800 (PST)
Message-ID: <9fba7ded-d31d-4789-b83d-efcc96f5448e@linaro.org>
Date: Wed, 14 Jan 2026 15:39:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 0/7] hw/misc: Introduce a generalized IOMMU test framework
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <6d50c3fe-e235-48e8-b461-fe0689f12070@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6d50c3fe-e235-48e8-b461-fe0689f12070@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/14/26 5:30 AM, Tao Tang wrote:
> 
> A gentle ping on this series. Any further suggestions would be greatly
> appreciated.
> 
> 
> Link:
> 
> https://lore.kernel.org/qemu-devel/20251224034647.2596434-1-tangtao1634@phytium.com.cn/
> 
> 
> Best regards,
> 
> Tao
> 
This version is in good shape and is ready to be merged.
Eric, do you feel like merging it, or would you prefer someone else to 
pick it up?

Regards,
Pierrick

