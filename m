Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A40CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 02:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur62F-0007i8-I8; Tue, 26 Aug 2025 22:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur62D-0007ft-Uy
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 22:37:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur629-0004vj-Gd
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 22:37:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76e1fc69f86so442595b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 19:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756262225; x=1756867025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PN1UiIwUnx0TLN7HTYbR8GaxIk1k1o2adWXgiowZkYo=;
 b=uhJPDReCW+upKRdkslJBzKUE15FZk8aKqAiFMstfNDvvXR4kTq68l72m9oNddQixOz
 v/kDEl3nusGCOoc7LR2JHvV5G5UHt/Gv69Iye4KDxXVh4y1jBxyvM9SEPv0IcT6HJE9M
 d1ORzk400TYFw3D7EBZwEpj6YaVZXCO1SjvEoR25wAs+l21Fw51SRnslVXeCfeivauPE
 +uIjEwoQjl319cK6V9oOKABWI899m/lv8Cy3y3Xc661WKNKNijYMBf0W1fqaQ3ppgHLp
 G9VDqNunsNyn5zdghWeIAZ3xeWCH6X7bsAQBaPAm/QzH3ASTeE77P7Asj01hUQ7NmI0M
 qLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756262225; x=1756867025;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PN1UiIwUnx0TLN7HTYbR8GaxIk1k1o2adWXgiowZkYo=;
 b=H46XnGB5ajWOAPlQgxKOFWHa4DCg99f4dUCJ5tKuU2MsZDn6K9qtHMpyTcqf4zO8k7
 14YadFDaqxDwSFp4zp7NOUuEzEkT986qSzanGaCH7NCAqTPQ2f9uElRzB0qugCvMusbe
 SxvlTQqwNjkj1MmLHVvyCysmjUoeZrdh6S0aMpgX57sQpYlBSDsyD2u8mcNBa1ULh4Q/
 /145b0PQNP2SEO9Oo1fMvwDl4pNT5U1r8FlyCI79EbFqV1rcLA9ehqKJWQYfimNdKn6u
 2xYypQ+R00UiVaHj3ZhxEd/YAWGJYxvP+883QrbkiJXiIO/lDXr6EVk/ELluTFowtQvw
 y8LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXraZg7o2u8Ob4tbHRFdnSeEAF/I9yGS6ckKfsX7eoEPoBJ8+O6ukdALOgfDOBNTnsK8MkvY/L0qybB@nongnu.org
X-Gm-Message-State: AOJu0YygyDEk0u1XTEM7y0AVnURlM6z1l/xTqZxcKM/Wnj872lOpG9Ls
 hr9l1AJYya0U6rzQH1WpkxaGJOd90v4XMeA4RGtFFxAHAILZrswVIBiGhXY/+/FO7VI=
X-Gm-Gg: ASbGnctIM2TwUKEHoQMO62RXjdmg1ZRw01uABja7bUM0dA8jUBhNILNbenjK79f8poE
 1OHAvPfUJlltIPMgOjuOE8z9vKQZMbeqjO2XkSuN31fScxbsK8Hm683ScJXTpCRW38HH80vpNFc
 M2DqfkTcDyyRu7C3P/BoSqfvay/Y5Qgn7u7cREhaRFkqsnDsjslBXaCFult8EaYuT5r279JN7tP
 0vpSnKI1hne01BsdDC4tACiaB/lJvrGtQQzFZNNR+0/M2qsUK9PmEkTKFkOBPjWC+gXU9l4Xvd1
 gvZZ1Yb0eu4AR9Dg2fH+ECmlAKNbOe4ttuCjtZU4WT6Cx1mIPj5W94pLOiVD32U7lyL9tVnXmXP
 G9cBvjTXenKtDiat8bEZ22ywlUCzJAO3lwlldZqh2GkSWbag=
X-Google-Smtp-Source: AGHT+IFDO75FNxA7H/3cx6TxNytQ5nTasFHH2VADHxcGpS6udD27t2pdITwUdx8KtTgpnn4oenH2VQ==
X-Received: by 2002:a05:6a20:3d0d:b0:243:78a:82cc with SMTP id
 adf61e73a8af0-2438fad28e9mr4141669637.25.1756262225351; 
 Tue, 26 Aug 2025 19:37:05 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-772093cac4bsm303493b3a.12.2025.08.26.19.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 19:37:04 -0700 (PDT)
Message-ID: <540d4897-df84-4ff3-beaf-059af914d5a4@linaro.org>
Date: Wed, 27 Aug 2025 12:36:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Fix reverse_debugging asset precaching
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, thuth@redhat.com
Cc: qemu-arm@nongnu.org
References: <20250827001008.22112-1-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250827001008.22112-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 8/27/25 10:10, Gustavo Romero wrote:
> This commit fixes the asset precaching in the reverse_debugging test on
> aarch64.
> 
> QemuBaseTest.main() precaches assets (kernel, rootfs, DT blobs, etc.)
> that are defined in variables with the ASSET_ prefix. This works because
> it ultimately calls Asset.precache_test(), which relies on introspection
> to locate these variables.
> 
> If an asset variable is not named with the ASSET_ prefix, precache_test
> cannot find the asset and precaching silently fails. Hence, fix the
> asset precaching by fixing the asset variable name.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/functional/test_aarch64_reverse_debug.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

