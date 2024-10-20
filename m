Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2496ED3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 19:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2bwa-0002Km-8Z; Sun, 20 Oct 2024 15:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2bwY-0002KT-SC
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 15:50:26 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2bwX-0002Yc-CP
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 15:50:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cf3e36a76so36571455ad.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729453823; x=1730058623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wj4ce5Z/iyRz2oiy5YwHhi/LOTOdHZPuQ4SLNxRMF4w=;
 b=K7D+hMTS1XKcLOVpVdzxR827HVdmmGb3VTwh8iZZbGtkQvpZIRsOBWkDxP3WD0GqsC
 DqkUJryKi32hMm8SNkObETX1N+T2aW+cm2LFkRb3DdmuoP8JdqtzMkchDdAShycwxzRb
 scTF/CyA3PlWipsKfleWj1Rdm1FY8F1lkU2WYBlV71pvcK1g3XDUY7xWmRv0nqkMVuzi
 7wzYlKSQiYu2x7sMl5pj0U9ze0vlx2791J7/HJYAxClYQ3s1YmT7biBU8uBRuLBEEd3X
 vVmKW87tZPRwlDDIO6T5ahF6uq262RQEJchKppnFPzRl/jcywrxNv6kuGu4OWiNnen5l
 cfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729453823; x=1730058623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wj4ce5Z/iyRz2oiy5YwHhi/LOTOdHZPuQ4SLNxRMF4w=;
 b=win7p6rBUopAkOzBuXJULTkiNlf6FRoJ4EID9NhryINK2R90vgh7Rac8qGlUgOm6Dt
 e7ohLgXYyf6DmvMheeiRN5zsBP9CEiqAG4G0MO4S7qWVkg+2pOtI3rOv2dx+hpRUzii/
 nB05kZijGj9Wd6HGo5xSar4jo6z8rIvTVWgsoXuQm+VvuUBIybvoRKaIKSuJIcR8XIeb
 xnfhI9K71jPmbCOTQqnPoeipLm3Yfrkmaij/X4jIlOl77Z/UIXQ9zsUczoRrqtFiSwaR
 iXtz7p2E73uLHsw55iLMGw9Pja/ybQfTkDYimmh4E2j9kgsa0dVKTN1XWwkThJhR7WH4
 WKhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvuU6IV3A+Wa6FSV5NNWV750mo1lfTGFB8r6jrs/lNWtHrpPhwOIDu+FMs/RnaWFd9DUTEKbTxfkb4@nongnu.org
X-Gm-Message-State: AOJu0Yy0h3lphUUEvX3gnb2905YvrBCAMbqa0u0kN7NmMxgw2oDhNnj9
 hAOKK4AOTjcuVsTHvwSucHVVlWMgtXQLlSyXxZXx3qtvKU8tHgYOPzIZgAE7RYk=
X-Google-Smtp-Source: AGHT+IEJzdioqUZ399yTPZIjAU54zAc/9GR4IH5lw4csnKamrXIkbaQv0A3pUWGvo0Jeb/KYq/Q0LA==
X-Received: by 2002:a17:903:990:b0:20c:d428:adf4 with SMTP id
 d9443c01a7336-20e5a8f3e51mr151374535ad.38.1729453822918; 
 Sun, 20 Oct 2024 12:50:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7eee6521sm13383805ad.31.2024.10.20.12.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 12:50:22 -0700 (PDT)
Message-ID: <441b10c2-5792-49ad-af07-028b9cf47368@linaro.org>
Date: Sun, 20 Oct 2024 12:50:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/i386: use tcg_gen_ext_tl when applicable
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241020155324.35273-1-pbonzini@redhat.com>
 <20241020155324.35273-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241020155324.35273-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 10/20/24 08:53, Paolo Bonzini wrote:
> Prefer it to gen_ext_tl in the common case where the destination is known.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

