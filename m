Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6DFCCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kz5-00086D-O3; Tue, 14 Oct 2025 15:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8kz3-00083F-DL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:46:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8kz0-0002mh-9k
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:46:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2698e4795ebso56312335ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471211; x=1761076011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dx7mod2Uc3tgOPevQTTANCrf8aVZJ0M7bWpQTaLYBqU=;
 b=CvswCqH9uMRUmvCXiEU7Yq5xlP/N2ure0+bIeIC8ytA8NcS16CNHiSnrr2MHrtHNNB
 AEH+fIGM4YHbIGawDn3EMk7qSJJZ0P9Y3WAq70RTF2DkE6QwotOvhu56aYoHhAEpdQo4
 O0VtOwy/YpDkA/UJQH60vlpXNVLo2A3sqW5Ei2cLPn2xPI9WcZgZ/z6h29Ih2bvXxN/n
 y2AtIsVkNtfquGk7J/BdXSRA532Tj12aK9OI38ayWsLcKhktXw+XGCkuNVVMrmJJQO+7
 zpA4SGVuGTagsmdalBCwkiMYDQEyWwwkeDjp2sTD1NJdD2e4LW3Dxwqas4smzWGZJAEi
 jXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471211; x=1761076011;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dx7mod2Uc3tgOPevQTTANCrf8aVZJ0M7bWpQTaLYBqU=;
 b=o++j/CbAFhuaMcsNTfsahymCCvKwQmT6VYyWut4px1nd70rEzcw+uYM+YxdWaHD0Ae
 okQ3fCGwI2A5dK2kq1Mk0cMQj1zv7hF/IPH/W2B7kI4BSFpaqNPFCNdwCyTUfDlGO1Fc
 At+3cX2R5e6cz50rXr2Faciw7+bcDcuG003LO/+PygFiIdA+EweyYCVd41KZmaD6tgOo
 xECTtHq6cCb4VytEyetBlRJDZdGPhhkfjMoKu3EU4CJrYmYz9COtBZ8eIs9ACPymF/BZ
 CnaWRPAlhWW9KV6t53oXDZRp/soPmzCQ2/lwYftf9RYI0cnP+qpGZ1/OvFNUjRKY8iMR
 9j/A==
X-Gm-Message-State: AOJu0YxJyIFMQbpSpFUtZ9KD9lldCo9Bc+D4QOFd226uCVim8yXxnMz7
 vzqbJNv8NJ4xtdcRtBj+R6ITd6nSlTj7POiADLAQsLII8keuTocnbA0hTZoBLkXwzhl+f4+hewl
 rCtg7rYk=
X-Gm-Gg: ASbGncsKUbWEtgkOIwe+V8H+8P3jpgH02BLI8WjbcBnOtR0sCBz1x0OmyOeB6FnxISZ
 eepICP2E965edqRi5LqF6PoIv3GmPAoND+yQH7wgncV4gPt1Wcq+HLEcCojyCa/9KsGEQy8ujEM
 L2bP1NulJuNG1fzkQifqmdtwLRy/OGrnDjOrCEEcMtWZuApLo4d/FAc4DqVuQw3kK9tJncSqLCD
 HnRiJk20m/v/4snanQFymAliuyKRtYOuytWjC7iS/G4UluEfp/L6mBBDTgIkNATavVo8T/7MGDB
 qEN0Fp9HH/3Zk8lIdw4nWvPVU7EPn3DqgMbMwTt9Y0xaVuIWGo3lTiKrvqgV2A3sgq5y26M29Re
 rMakA4TmYsdnVHNbFNbwEEnnetZ8J5S5tqZt18oiZfaQ9yi7pafPG8lLdNf+JjvkGHn/FHw==
X-Google-Smtp-Source: AGHT+IFEFuDXf1W8u/C7PAwAruwgh2lSj112YYIlYOU+uL9zfVjNNLOnYggwkWSKwigj4qXOocGO6g==
X-Received: by 2002:a17:902:ce0d:b0:26b:da03:60db with SMTP id
 d9443c01a7336-29027373dabmr363647305ad.13.1760471211354; 
 Tue, 14 Oct 2025 12:46:51 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034de6de2sm173116355ad.18.2025.10.14.12.46.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 12:46:50 -0700 (PDT)
Message-ID: <1a727ac2-72c8-4f5c-a2f4-88794c9a703e@linaro.org>
Date: Tue, 14 Oct 2025 12:46:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] tcg/linux-user patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20251014172341.243858-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251014172341.243858-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 10/14/25 10:23, Richard Henderson wrote:
> The following changes since commit f3f2ad119347e8c086b72282febcaac5d731b343:
> 
>    Merge tag 'pull-target-arm-20251010' ofhttps://gitlab.com/pm215/qemu into staging (2025-10-10 08:26:09 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20251014
> 
> for you to fetch changes up to ec03dd9723781c7e9d4b4f70c7f54d12da9459d5:
> 
>    accel/tcg: Hoist first page lookup above pointer_wrap (2025-10-14 07:33:21 -0700)
> 
> ----------------------------------------------------------------
> linux-user: Support MADV_DONTDUMP, MADV_DODUMP
> accel/tcg: Hoist first page lookup above pointer_wrap

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

