Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD66C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 21:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdcOJ-0002OO-9c; Thu, 30 Jan 2025 16:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcOG-0002O9-PE
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:48:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcOF-0000f6-CL
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:48:00 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so15305535e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738273676; x=1738878476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iIQ6jzWZ0zWkjfraGRvADD6Bsa/a+iFYh17j7qXolpU=;
 b=M0uNm6jFbJYuvtP9DHTaOxFggVqeay/Aasggi1KlK6KENejCqSxUxoYiq4+9vgH2XE
 FwWkVPB7kI2GUEX5GElXc6/ZWBOmz2GGxziftR1B/LnJTdE31DlGGoMLenDWeEIxGzzc
 ZLgQks6wANcMQopp1HRoZ37/6KaMJeBOknTisY81BL3kRjNCYKWAChfEgFu1HGD50bth
 qK/HXucsNmIBJdADdk8LFSSV3VSlfG8aXLoW3G8tPnSOYcXToItfuAQusjhgiv01Xuco
 CzREvT2azPgUaP1bS9fIANl9iTDnyVreduOC3EagM062fZXAafl274onF3RQah+X6BEA
 S/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738273676; x=1738878476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iIQ6jzWZ0zWkjfraGRvADD6Bsa/a+iFYh17j7qXolpU=;
 b=ig5p9mTo6Vz49D9ynU/DZQhr932wUhEqaiueJwUBXL3/F46CuNdvL6nWt4PuCMLWt4
 unue2pdk0HMrUK5ruoyIPLrPQCudMV+QsPbJvbD1Do+FCzupFsRmBAOZ2hpFX6o4TPWL
 3xzdaciH+uFvYYFhRdo4FrlEXFgaqB64jAnk+W2RY8ZunC6w2M4uAEo8dpGsJWQlojeP
 +t6lk6YiHivAO5KUi+Q3m+rF/gLiquvGm0WpZ0aRi+tOPKV/oekVLSXjmcNAGxR5u8g2
 2IDnE43PbNIlmrvQwvz9XpOxUXd4+0HNZxe08Q5DBtofWXP5QFSikws0yD6DjwZHWK0O
 Mk0A==
X-Gm-Message-State: AOJu0YxrlrE1gyhimF2p5M26vJfcrkrtdnpcG/7KUsawzcf3sYCeHPJ8
 w1VbPJscJ6m0+daWhO+yx26PnsRtYQG2WxaEvN/nZZVPaompg3RUhrae4fiV5jIo8GiOYXWgIzT
 AH/M=
X-Gm-Gg: ASbGnctlOD2z4+NRxpuTeTeMutt9gMYI+RRtC2oBsg6uIFdmv3byoOyppsTRvCAi0ma
 vERKwBJ20ELUFDJj2L9sGTl2ajx8JVlS2eWJ4zy4ukjWesDAIcAdI1T5RQyl78sQ91rNID+ATrF
 q5JrDSimhCi0PMjOKQCsX0F5E6HMRvk4Df1IFvZGLZWNxebaN0L0gzZ8Gl0PZsCH/eYnb33PPrp
 Be0CYroEjL8t5/LOu+68IWnUVWKrj2ZgFcaXo9aKHC1isaYohzslrVvuBIRUd0yEspRU/x0qosZ
 HWWXDbH54RSPsMBYQdhgTP23KsTprcabUm9cPojMdFGRpHfJnePNGoL0QDU=
X-Google-Smtp-Source: AGHT+IHxQjYwVHDxwH0bktR4nR2uFADsDM0A8MLpN8wewJjgLAUTPaWrsy1TcCkKdeAhKlmmvKe2pA==
X-Received: by 2002:a05:600c:4f07:b0:436:6ddf:7a27 with SMTP id
 5b1f17b1804b1-438dc40da5dmr75540915e9.23.1738273675666; 
 Thu, 30 Jan 2025 13:47:55 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b5136sm3137221f8f.65.2025.01.30.13.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 13:47:55 -0800 (PST)
Message-ID: <e5a3bd99-c338-4817-bb4a-acab78824b01@linaro.org>
Date: Thu, 30 Jan 2025 22:47:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] hw/ipack: Minor dust removal
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Bernhard Beschow <shentey@gmail.com>
References: <20250121155526.29982-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121155526.29982-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 21/1/25 16:55, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    hw/irq: Introduce qemu_init_irqs() helper
>    hw/ipack: Clarify KConfig symbols
>    hw/ipack: Remove legacy qemu_allocate_irqs() use

Series queued.


