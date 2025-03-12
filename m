Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE7CC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLZv-0007EP-Ha; Wed, 12 Mar 2025 08:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsLZm-0007Dl-HW
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:52:47 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsLZk-0005U7-Kk
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:52:46 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fee4d9c2efso11142334a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741783961; x=1742388761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XRQfE/d9zJNV3Hp/S76//aPPONxVne1nCB5dXdXH/eE=;
 b=c4MeRnqjGt0FKXDMkExnL8aEagNZNThqll0I/FjXhzet3PNQwdXuKGFQBQp4d7egRg
 IN+Vkpiu861NR0onHNSsnHgIs1MulEkqbb5+Kc0x1g8sG4oNC8xDyMSFf9ijoH+9ZNfH
 5VbfkTLQv33lUjBc/F0+V/T43szxJ4K9MvtttrKUByWvMo2Z7accP7GAMJTRjRQhvZoM
 nh0y8MZXjtwUFNm1oUudlpEO1y/PyCfPkJe84cVhtYuZ9/B6j2r3BoZNyzhVpT2jUTvD
 vvotk3e4Leajz9gIHbKt/5V32GgPCz8D07DlkabRn+e62dzYeb7+3q9gw0T+F9a1uyrK
 1sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741783961; x=1742388761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XRQfE/d9zJNV3Hp/S76//aPPONxVne1nCB5dXdXH/eE=;
 b=SR7neONKjVGAp4G+010MY1+EUxs6VzOz/JHlQQgZ5I9zhaHX+EE4AtGRyXpN5c2fvA
 /UF1f8muQJByzMPGBXJ6jBT6UImhU4CVzO+1jg59jzoG8H4C/+Y1/U3kUkEcm7r+XJ7W
 4Uv+/+ynt6cTndeI36kfjnH7hkL2NPtYT2wrTFjGMbyNKVruP8jPJof/v1P5JM/Jr//E
 MDrIUtdn8C/fif4chhULRiVnznS1W62eY9PSEhc+4r6A6H6tqwb1HwgH16tIHuICRcq1
 VpYJP9EQl5OBj7R70j3OXEU9AV9OmrtyE2Xj3Yb++KXonGERBvQzT2irZPxYXkfnPuW3
 km3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWooVDPA7WFANFg61oru2Wgoa9zivpck/qax7toRLH5uhly469uWDEfmc2SxwYMegNtvxSYplldK2N9@nongnu.org
X-Gm-Message-State: AOJu0YwJ3R5q8lMrCP+TzyOurfcNTO0tw98+5zSl/+QKQfcHrqhYPfQl
 7d1LeiMHFdtQoypcL7Ahf2VfK5o/vO6OjbDJngBGplksRX5E8N+RASQPi6UNkXY=
X-Gm-Gg: ASbGncven3EVq8+ixWkKAsV2t3fT/PRfgiqWxDfcIhn+8AnX0xP8DuRLB2A/jaxBsvb
 0SqY4COGrOmjc24dALLfgFmOtZdnU0HfYF3eGFw/XX7nX5Vj9E9/emA+6xRBK+g7dJtbPzw5uxx
 0G2YO6AXCz2TBQR43isjMaRouA81c0ueyPEdKmDuqtTZHB/QG+m8xFdbMTqdwORFJoL9UgrMph4
 o5FFX2laWjN0NPAHptFzqHmG6vVlLXqGK7CADnlTC0HQF3z9BCc3yb5AMUQ5VsQZp6KjtYRuvhL
 oSu52tYmaze84RtMFFx4vK4Zkd4GJBOl0B9XGyyvA3V/HA1dEeKA6anmjQ5+qptZvX5TWlLUgGN
 DR/35G1oCj68zWlxSnOc=
X-Google-Smtp-Source: AGHT+IEw6YGvNWT5CU6Vgxh9WVANqEAXaE6ZIQ0UyIf7wC0S/0QNJ09I3UYtPZKOKDuLLZA/+FOHGw==
X-Received: by 2002:a17:90b:3ec2:b0:2f8:4a3f:dd2d with SMTP id
 98e67ed59e1d1-2ff7ce89d6fmr33250058a91.15.1741783961504; 
 Wed, 12 Mar 2025 05:52:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301027187c4sm3605584a91.0.2025.03.12.05.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 05:52:41 -0700 (PDT)
Message-ID: <f2a9e4e3-79b9-478c-91a0-e8273d056296@linaro.org>
Date: Wed, 12 Mar 2025 05:52:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] target/i386: Replace MO_TE -> MO_LE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20250312103818.370-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250312103818.370-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 3/12/25 03:38, Philippe Mathieu-Daudé wrote:
> The x86 architecture is only implemented as little-endian.
> The MO_TE definition always expands to MO_LE.
> 
> Replace:
>   - MO_TEUQ -> MO_LE | MO_UQ
>   - MO_TE   -> MO_LE
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/tcg/emit.c.inc | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Is there a reason not to use MO_LEUQ?  Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

