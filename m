Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFE9CF3186
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 09:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLeqo-0008I2-IJ; Wed, 19 Nov 2025 04:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLeqm-0008H9-MB
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:51:44 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLeql-0005da-5i
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:51:44 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b3377aaf2so3622442f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 01:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763545901; x=1764150701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GiRlg2/TLpdV8ivAmttMyg33wMMj8aCOLcacBAyl9tw=;
 b=z1Dqb0e3kVlBj4HaBB+BRX4WjknLCUPrAsANT4oTsssUutjKt6cio+7IfJWvT2xNvj
 nxbx3UFcOByUMLapxPDLhjvicnNFY8cdmC7BV6airIWN7zlQXhydEkEvibbjIqLpYDNp
 YbP3L84S0KEMNJEXFsItoRH29cOuz8o1RVid63pSlf4tFz7wMEkq+Pe4z4X23LVeJRPp
 H/2a7jddGN0iLaa2Cyqi7ZNAiGGHIsago9ft3KnN6YHL1o5S1QDOIan8ZCdFILCx/yDi
 V0gvEj4nG0LOD/ZQELk8jDTV1E0Ri4aWja/OAXu+iVKOkA8fMBi5lx+dHJW8TXBqwJS4
 CwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763545901; x=1764150701;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GiRlg2/TLpdV8ivAmttMyg33wMMj8aCOLcacBAyl9tw=;
 b=SwrkXUMiTUmtzQGdBeEw/RUboW4MPor7ioGVttUrJp21qs87x5Nv2fZL8Ue6jOVOy9
 c5OGBUwZ6dikakQWwEGLAwaG1h00Z2zXkGP2WNl6vunH1DRSFY14RoVyfNpt8Ctp208j
 B5iNGQKUhayW3Uwd1kPYB12rOe/uatuJCt95l+v8I+Wvs5BPtoLde13wRO4m0NkMVr/v
 y2mGR6H3GowhcgeTVCRzwvRJwKQfHOnuiRw4BRZhu1ZrmQB6KWoCecTABPxYdck9Ol5L
 //3AO34MPPJh4rXB8fZ9d9+lwGgZ3ZBLSr3BitmqX01aOHXKfYESNGfng7HAQw5FI/Nn
 Qx9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpOGdpIL5sxgOmK8iyYaNL5IqF1fR9isKwVEFhBjWUwOV79ujO6YMkzz/GLEY4kGDLwc6Q7a/TCqYl@nongnu.org
X-Gm-Message-State: AOJu0YwMtJ1AgtZ5huLp2rz/jRwu4aTDrjB0ohbOQ9XBe9Sr+evuecc2
 31lVhGJALFLMajdTaCBxLGaUdQ8P9rawHWzf2h2DLWlb7DHap6oAJrDvIRaFDBG0JMU5UQlLTmn
 +Jv4Ktq3YwA==
X-Gm-Gg: ASbGnctZAbjaHzsBhPqmH49tVfoxfFx1Do/t2xeyRE0NwOJiKKXLiUjzWURMNOU+5u4
 YBOXXnBWxaol4CQ/p3I5410yEQnoQmPZ2KLvB19d374KktAjPjeXx2rkMeqf/wiy5GlCCmibZbD
 gUv7To5ofKxodIvIoAWdT5HWEXY9aBGUSchNCmrUKOZICDs9b17QZs81P8kFlql2ohHOc6POntE
 tpjO3C3QqBqwbMB9GZCl8Hlg6EKIivatYBSlEF/Ov5o8GjdqrLnQvOyD38xWCfXqBaVoLpL2+gz
 0LGAfSGhv95ca8Yxny8XMWi89qJxAhYCqkqIi1eb7dDwCZqvmxSBr6QnJVj6Jzhf1I4Pj+Ep9Y6
 int93bXab2g7UoAy2qjp7MUctspd1AcJ8p/hIBG6Nbabrzhcws3iYZh1LuZOVoMffL+JvZn8QgV
 JzKj+hmqcO2cUODmMEt7/mUUAnG14nZcxb+XQzRW6ZJny6j3zXFbdp0Ot2O4MeAXNauA+hJg/Eg
 VL33Q==
X-Google-Smtp-Source: AGHT+IE5G4dSD//3dB8Wa7YKiMLUkrciX4CAf4gQGB5UIB0OS0UWmOJkUaZMpdBrVGldXQlq3J4JEQ==
X-Received: by 2002:a05:6000:178c:b0:42b:3b8a:3090 with SMTP id
 ffacd0b85a97d-42b59367af2mr17846809f8f.23.1763545900922; 
 Wed, 19 Nov 2025 01:51:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1?
 ([2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae16sm37446872f8f.3.2025.11.19.01.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 01:51:40 -0800 (PST)
Message-ID: <98b9ec31-abd0-4b1a-a06e-4e041f84bebd@linaro.org>
Date: Wed, 19 Nov 2025 10:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unaligned access for cortex-a15?
To: Liviu Ionescu <ilg@livius.net>, QEMU Developers <qemu-devel@nongnu.org>
References: <77419EC3-BFC1-4F0C-9287-2E753D0C30DE@livius.net>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <77419EC3-BFC1-4F0C-9287-2E753D0C30DE@livius.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

On 11/18/25 23:15, Liviu Ionescu wrote:
> Hi,
> 
> After upgrading to 9.2.4, which seems to be more strict with unaligned accesses, and after fixing the cortex-a76 alignment faults by enabling the mmu, I have a related issue with the cortex-a15 tests.
> 
>  From what I read, this is not related to mmu, apparently the core itself must handle unaligned accesses.

You must enable the mmu for unaligned accesses for the a15 as well.


r~

