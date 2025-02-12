Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE08EC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiHDn-0004Tg-Iy; Wed, 12 Feb 2025 13:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiHDY-0004Sh-QE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:12:13 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiHDX-0003K1-97
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:12:12 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f55fbb72bso96105275ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 10:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739383928; x=1739988728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Glm6+Pe0IC25eIp3BrpVgsURsHqMEAfFb2NN7a5cFRU=;
 b=Cf/Bp2qGOUHALFX9gNUKpWtUpDzRN8c0x2DUc0VLm36mD/N9OJl16uQmNqmENKfSSe
 R1jxrbYwEnyDvKMIZXB+qDcYA/UqlD0t8KlNrZGZAb9M0NzzmCQ4aTRWXP+rKkgBmknh
 8Ea8nH3Cn890DVGOqkMR/eeE9A423Lu6Wl195hEqKcTZqXDI1KY0ZYldQtdXY528MW6y
 C05/iJaRpJRm+D2Tn+suTURVwRouBzoSkU7lJdCVhXPrpk4ShiqTenJ+gxMyTwdgyFAs
 4BvAMoJfXYX3gKiCKxZ0ZAJOcku7e7LQOCo9wtQQWpSDc9H7Vqq4hFA1F4Qx/9vGx8Nt
 9D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739383928; x=1739988728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Glm6+Pe0IC25eIp3BrpVgsURsHqMEAfFb2NN7a5cFRU=;
 b=gACsNj1EfUJRtN2jASHn2lYFedzVw9CkQGUYWYHSrxgzF5N52dDAuZb9iw7oWxzLrw
 YfdDys3JnvL7K9PBtivZ821E6M+guwFzvSnFkVR7sno5Qv0Zt33SbSmcoEEd3Vqjo0z3
 M99nT6BIpBGlPB+g+QyUnHgB76z9lCVyhppkafzmCk7zkYScKFgXUlm5v0I3doSiklOW
 q73ZQ0yGSngxIC2nXt913i9IKE5JAUregRcT2vYKKx5t8t7wnX/hldV9iv4zsL1V42mX
 TST7M9fDVYfoDsJInNDLUBdc5yOkDxq4+rGugk+ZmzSD+8PR2ukp9JXNA0CaIEK/jWjg
 nPVA==
X-Gm-Message-State: AOJu0Yw4DlNs7qtQeSA9oyW/j2R2O2ehApGDXHz4FOjAekrPNieUGNfS
 nkNjEGYGUw2Fo5yNxcC4X7co/ZgA3quEolWXRTv+jzQQf7gO+zV8pFyb2XtkI/mAHVDrfqdsp23
 D
X-Gm-Gg: ASbGncufmqgA02o0dzGQMgKlcyx30+V8kT3S+uaSi8MKnWgh61De7zbkwRlUPA/CDne
 pBjRoRJNvbsvWKYQXhrMZASmFWjgwFUlA6cm+RUD8YFly7MJSaEVPsFjnEE5xjD+G3Lyy9ysP+S
 q4JSGSLN3QSxFjEVK0KOmdrTUeuoIV8Mu4140XHlFjZ9KSV/zpC6CZJqK29HBH7JnvxYC97M2/f
 EoVRIuerkWJ9EaZJXfS50XNn2f0cIQKgtwCcxTrsFO+Gz0OxrvJQbRw6XnWnJJ5nh/s9bZF7YtP
 hcQmzxI0UQTnKgoJYmu4FtCxk3hlBTuNbrNh+hyiCeb0t42sbpLuq/4=
X-Google-Smtp-Source: AGHT+IGcIWnu5Ui5lJox+HemSvFjK+uisM/nlyXxiF21REPpxzaNs31Prf0Gf0rM95LXxQXZzDQp4A==
X-Received: by 2002:a05:6a21:3981:b0:1e1:ae4a:1d42 with SMTP id
 adf61e73a8af0-1ee6b399c4amr972674637.31.1739383928498; 
 Wed, 12 Feb 2025 10:12:08 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730775e4896sm7906512b3a.39.2025.02.12.10.12.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 10:12:08 -0800 (PST)
Message-ID: <6e2758d1-e904-44f8-83e9-2838c5385b89@linaro.org>
Date: Wed, 12 Feb 2025 10:12:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] hw/arm/vexpress: Specify explicitly the GIC has 64
 external IRQs
To: qemu-devel@nongnu.org
References: <20250212154333.28644-1-philmd@linaro.org>
 <20250212154333.28644-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212154333.28644-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/12/25 07:43, Philippe Mathieu-Daudé wrote:
> When not specified, Cortex-A9MP configures its GIC with 64 external
> IRQs, (see commit a32134aad89 "arm:make the number of GIC interrupts
> configurable"), and Cortex-15MP to 128 (see commit  528622421eb
> "hw/cpu/a15mpcore: Correct default value for num-irq").
> The Versatile Express board however expects a fixed set of 64
> interrupts (see the fixed IRQ length when this board was added in
> commit 2055283bcc8 ("hw/vexpress: Add model of ARM Versatile Express
> board"). Add the GIC_EXT_IRQS definition (with a comment) to make
> that explicit.
> 
> Except explicitly setting a property value to its same implicit
> value, there is no logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/vexpress.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

