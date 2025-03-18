Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997C9C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufbs-0003VQ-0X; Tue, 18 Mar 2025 18:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufbq-0003Us-Ar
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:40:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufbk-0001dL-Jn
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:40:30 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22548a28d0cso17107115ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742337622; x=1742942422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S2UPpQLFKR1qr5/RvZ9zNkJfGHI2MCRLeltsmk729qU=;
 b=GwvnoPuEdEXODJDEkh63W/HCtU8ltzMnnqKkNZo1nDu5T6oMKpgMDGU1M/9xJpCbXo
 74j4qtGD7NY6tvr6ARv7LfUFRuK6/sGpSvx+lYj1HvD7DeKlhI/yRfS4pPuOiR6h75RB
 jmaGS7pD3Hf6+FGIgRcizqlLlf+mnJtt4ANdVVvnltlNGKY7dmHzD7UQ+IFoOkoey+Ue
 745bSsEeivf8PvtrffMQCA6bA6sRVmM8ezQE/GjdfxTuCBFRuB+jF1CfkjXVtEKeXDQm
 rYmhtli33uSm63vJ4DkAfVsr3fJOl2et4o9gBGNOEHE9EvznmTuLySz1SlgpT9v+DLrp
 SvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742337622; x=1742942422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S2UPpQLFKR1qr5/RvZ9zNkJfGHI2MCRLeltsmk729qU=;
 b=Kz5f7IYEb9DQXJ0b6XyoYiaUgdDVXnRLp1gYixmO2RIGwvuGOQwYQblu3VSXsehNyr
 aPv+z93hDQ1hOOi/AT3nnhadjmkhYetoUsPEGJ+P6qjE5KYkeVjXx14VwI3+7v6S8pwK
 PU85yzq/xeS5+2DjHsv4+byCuLR4mov4d/CyUmLLZAQ22uysVGvEn0lYiG4/51JlIg+e
 syhXq4IWlLx/BRVtTqazAnU3LXEmmFIgsgTo1yCEio5TS0sxGoEJAoB7PIn6Tz3c1yYk
 qnE7yqQ5X1CRuChY9tDpVGizz6GF56NLHCZU5dExrXeeuxR5Qh2cEgo8K9uynDUt0lBd
 m7sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0AZRACMw0d/nH2ys0Q8KSmjdbKbjgWws8d2xxSxNgDxpp3xtDKoNKxobu7lU7pAY+uytPKhVxQegY@nongnu.org
X-Gm-Message-State: AOJu0YzOvbucSXAdJp7yeVPakj4Y7lkJ36a02HqAgJ+4wVd2Pvs4/oE1
 Qw55nhaM9DbrAIqd7OcDm7TqggNTkfA7S5krolxxfl+daBWOhPbBRbhc/AIwhT8=
X-Gm-Gg: ASbGncs4/RjkvLUs5vwCw52FTv1sf5Bh5PPRakx+zjBC8kGlG4TJm+8bOffCaRez/Tb
 +UoweJNyY+uNmG6Xnv23DMsx/MAc2X3FXTlLrEAUige5iqqAOblBCF+HcySDFdZ3Enx3LuIbCpX
 gF1v4/joT+8medDVGBcNifYtmTD+XMhoUAK0F6j20D1Uv0W2xt/WErlbapkQzZ1ahDlycpJ20qN
 QDWwO3+agUpC9iU2tXSB0IUDA6oN03RXwnh8El5rhC1RLm8MMT5wDWoA+UW3z11tuBIJ5fRENWz
 LKi0Z9U8CMcGj6YBQCoJqzQloRcpo9de5qjqzWr93DLZxPtyjdbh3OgPOJzDxwJxhkpB6joqRCF
 1NDUgCfs1nhqI4Vp5H0I=
X-Google-Smtp-Source: AGHT+IHhbx4zrSFVC9Erry5Z56X+U/eo+aBTKB3hU0AYmsuCxAbdXsclAmXZcf+supeAECu7ukRqHQ==
X-Received: by 2002:a05:6a00:80c:b0:736:ff65:3fd0 with SMTP id
 d2e1a72fcca58-7376d6ead4dmr711477b3a.16.1742337621894; 
 Tue, 18 Mar 2025 15:40:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711529531sm10202523b3a.2.2025.03.18.15.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:40:21 -0700 (PDT)
Message-ID: <9556c183-c103-403c-b400-0942d42785d7@linaro.org>
Date: Tue, 18 Mar 2025 15:40:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] target/arm/cpu: flags2 is always uint64_t
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-9-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250318045125.759259-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/17/25 21:51, Pierrick Bouvier wrote:
> Do not rely on target dependent type, but use a fixed type instead.
> Since the original type is unsigned, it should be safe to extend its
> size without any side effect.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h        | 2 +-
>   target/arm/tcg/hflags.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

We can also remove the comment lower down about cs_base being
based on target_ulong, since that was changed some time ago:

exec/translation-block.h:    uint64_t cs_base;



r~

