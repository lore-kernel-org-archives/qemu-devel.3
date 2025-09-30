Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF97CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3b3r-0007yE-Hy; Tue, 30 Sep 2025 10:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3b3p-0007xn-9h
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:10:33 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3b3k-0007cc-8X
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:10:32 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-27c369f8986so58013045ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759241424; x=1759846224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bETngk8oWz+y/33qWB/HDZmhP+JNmoYsAVGClEUh47w=;
 b=voqhVb+lsItXJzYRkNVz+L4/IGEdeVwgCDk0e68ZKCccxYx8T5dUxuY0AKG/qzmlqa
 24IJ5N/ZxYym5B5uIgw0cZ/J8DtgC76hi9Ntu9/jG8A8fcYqm/f8ywttMawP5qu8k4A8
 YDqHt1iKezldZv66CTc2ApMZ9VrvZKEhfRTVcFPn+z3cr9AdA5NpshOE6EhEMkflPoUm
 nJ0wTd6p8WgLRdYmKZnwXtC8EuKtiLNl/VhRHPabys/EH7329kY7DdwzxAXbePP9E7zu
 YUr2SryBuTgAPmdnu4InmBsh9NdVM4+DLWohUXmpmtZsGJRfMDBlb154NCFDdw/agLmF
 EvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759241424; x=1759846224;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bETngk8oWz+y/33qWB/HDZmhP+JNmoYsAVGClEUh47w=;
 b=h4bghvM8vwHIx7H1pp6CzG+oSwHW0d6evwK1NVMEUKc2wNVtHcFtn7unqsYvJ7c1Hy
 4lwYOL3zk33b8WxYmkjHTW1RUtvmzulYp4zpvgu9JwoMkw3jPbToEoHsdri75aA2+gnb
 o1M7PxDtzrLrP8cAb6hIwhTYZ0kqWWPCi4TStA6OH2AgbwXpGL8y1rpkdB8u5j9DSumm
 4TUkHfSGR5Sq5Xh3Ze+TAL0L5WfiIXwigSaA7iEpmtXwelOMy3cxeeUqIeMjrsE2koZa
 jE0KZZYXajHUPXqH6UsvgwJUYs6XNRlwXo05TbIlo4U8jRPFmcRVsZ4nZ8ThqfBcv2mE
 YFnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1mW1W84hCEc6sn1/zgP3+VatoC65L5XdvJu598CXx0GKBc2ZiAViOcfR2XydVk7AJUJtYkIH3TO+t@nongnu.org
X-Gm-Message-State: AOJu0YyjhGx7uJB49oOhCTmdWe8XloRqFAIl5Vf2RwOj2AqiMhJm1zOS
 cYe9UqVY97+IGqU4s63yH9ZZHvSuDIIoEAE+Dh4LbafjjyM0fMOdH3FtNYvcuqSZ5W4=
X-Gm-Gg: ASbGncvm/weoF7CK1YM2ps+45oa3VIUxhpBTUUDkcFxJ/Ya4c+02AYoMTAoR3P4mTwP
 kZRuQecHu5xRTXAINEjbKno/1pmFSMMlz/OOptlUJXO4moQdpZ1MfI0OF4inun3KLu8UoDFlP8L
 lmfddKGiBAXcFCDhe9RNGLlNg8VlNHC+5EHD/Z7Zc2iswBrim1WAehB2D36q6njA3H/OGbETI/2
 lAsZ8lDYAgWJ6J/ea9VyGijCTF0I8cv9+DvQpCfGUDxHgWwNzPRas8unCTg0KV3IiwEDPMc6WtZ
 5x6pOKVIcEryHejldqE2e+roD/gGYd13XNTJx00aYbALkTJD4EA9NqOiMexDZpp+JZEoJaZNu2/
 n6ibmHP30lc8lzsAo+G1D4NOM/YRNgmKTdcoarvvL+MVOZII8uuFtiB7YCJ5uSAU09Xwsmis=
X-Google-Smtp-Source: AGHT+IErJx1XZ6G4XHiiKMynK/kRIYq5365OOuUPI+qdl/lVAT6zeq0u4gvFtRJ8Mg3qECuI1WNOZQ==
X-Received: by 2002:a17:902:ef03:b0:27e:ef12:6e94 with SMTP id
 d9443c01a7336-27eef126f60mr169096575ad.55.1759241423797; 
 Tue, 30 Sep 2025 07:10:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6725bbesm161575605ad.60.2025.09.30.07.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 07:10:23 -0700 (PDT)
Message-ID: <7ea1d69b-cb73-4a9e-ad5e-e821740632fd@linaro.org>
Date: Tue, 30 Sep 2025 07:10:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250929165230.797471-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
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

On 9/29/25 09:51, Cédric Le Goater wrote:
> The following changes since commit 4975b64efb5aa4248cbc3760312bbe08d6e71638:
> 
>    Merge tag 'pull-loongarch-20250928' ofhttps://github.com/bibo-mao/qemu into staging (2025-09-28 09:01:35 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20250929
> 
> for you to fetch changes up to 9ec30a07483640ecb8417fce3dfa9273f7a036c9:
> 
>    hw/arm/aspeed_ast27x0-fc: Make sub-init functions return bool with errp (2025-09-29 18:00:20 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Introduce a new ASPEED OTP memory device model integrated with the
>    Secure Boot Controller. It includes a new block device backend
>    ('drive' property), is enabled for AST2600 SoCs and AST1030 SoCs.
>    Functional tests are included
> * Changed "ast2700-evb" alias to point to the "ast2700a1-evb" machine
> * Introduce support for Aspeed PCIe host controller, including models
>    for the PCIe Root Complex, Root Port, and PHY. Enabled for the
>    AST2600 and AST2700 SoCs, and functional tests are included
> * Refactor Boot ROM support to improve code reuse across the different
>    Aspeed machine. This is in preparation of vbootrom support in the
>    ast2700fc machine
> * Improved Error Handling in the AST27x0-fc machine init functions


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

