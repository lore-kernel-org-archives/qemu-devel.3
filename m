Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61FECCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 17:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCi7h-0005Z5-6i; Sat, 25 Oct 2025 13:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCi7T-0005NW-Ab
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 13:32:02 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCi7Q-0005Qp-W0
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 13:31:59 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b64cdbb949cso699192166b.1
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761413514; x=1762018314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SnNEDvqzwQAaRExV1eHmCSbDMziZ/dxiS8SEx50zXh0=;
 b=hM8hgmaUfyw4Z0uq+E3gLc+1NG5g6Hb1PK12/hgbO26tlfVAihT/nAE6d6d5cSDpdP
 EpJNnfdkN8fLruov+ZMOzIbT0VNG+wF1r8lyMuweQAh+LfbLfOoSxO2Mz5QcaXnO0MQk
 M+cO6Z/bU5LVX7AsqyMmUDfXnaiX9gNXxRpsxM5qeDtZVwxzYCYt1eZJWCoEQiRYtPMJ
 oRUe1ycfkC7vNmtyK5aje7MAwAfadwii6ZECLJdfCheL53fRNxexs/ixpSf3Z0dp2XRl
 UqVpbhWCz03tnqiY2lWW0vOexEfLdopxCViMUkRLF2WBCV60/uGAKaiwlZK0TmocehLo
 K5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761413514; x=1762018314;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SnNEDvqzwQAaRExV1eHmCSbDMziZ/dxiS8SEx50zXh0=;
 b=Ds7MNbl/u2mIO2ZF1DyJ9jxG6Vgl1QSLV86wd6AuMFWkxeLczsBeDcFg8hYu2e1pCr
 foX2jFa6/fJ5Jf0AVgitGkdX+NQAmz79W0J8kJ9FhWsB20QLZtGTRlaaDX/gDKY/zBHC
 ju93o5XAsdESnXJBvT0h8IfGdKnnd+nhFgkpNeCHeX232zJc5ZiUM4u+m/YRbQk9Dozq
 JrmLKXL6SKAlhmKNjEaS5nONTornRcp1ap0bbxlZ2Wx6WP6pHN2j1sB60dS8UpZ9oN4T
 j4twn/SmDcDES2QAWlqa/yQgYfmpeXciukzxVg6p+PuAzM4ZXzUU6Xd1+FnYJEiIycOp
 aihg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOEPbaGYLnyZkWseG9y1PZu3+GxCbO1i7ZYz0SS3SoHV8AGEPsssM9onM8LJYyQIuDDx/mtCEhwD6O@nongnu.org
X-Gm-Message-State: AOJu0YxROkQQWM6QI1y6gVLG/r9lZ8E42+fZLiEl+IQqfK8t+CQgNg04
 nNEmPcxXJCNzivQ7schzoPmvPMs0a0W/9L6pXwAXCVJB6c4xIZSpBOpuUQIOOf2qlweC3bzhAk9
 UQ24wBXc=
X-Gm-Gg: ASbGncvEQ2jEc/UZgUAdjA8rfNbWWYplo2ZydFsEZC0cQ8sdVWY99ix34vu3JV3OnWI
 uG4gQgWuEY9pJtwx5E19AHup2PEwrliSs7mTHGNFp5lQ28Qyuahm4AygoW9+pUxN3+bbSr0Zegt
 id1LkBaOJGdAvCzLsccF/B95FFVDUmJ4HKS7NAtKWNFTjSG1QhQVPN+jeBfJDQ3nPq42rrAfomS
 YtXlfWzXYoTCYMXCO7VKgqo/9VPOv747jjeLx0CsDY82YvZz4A2yUgXBap7as/qae7YupmF8mQf
 /CQSD3xZ4KsOtTIBHZqUk5LJ3xWoaY4IMaJQj6mEC3W/9n/unzG7E28GtaBRfW3hr1iMNGRJvE/
 xKMfzpaearUv6gZPoK4VfYccw2tH1LLdYZWjq7TCyEq3mzgiFHSV3u1FsOV5gjTlOCvDFxtEMhO
 8GvyC74iouXvKBs9zCCJm2QWan12/micZAbfFVP9i9Ojrdj1DeYs24kNRGwI+Vjfo=
X-Google-Smtp-Source: AGHT+IEd/wUd85s3pln0qSJ+GVeHoSMOF7ppka+nk+iaRjFnEgCDhTGz56rYxyLUKfoQ9lSrjpZRgA==
X-Received: by 2002:a17:906:4a91:b0:b6d:8d8d:3010 with SMTP id
 a640c23a62f3a-b6d8d8d4d87mr138011666b.56.1761413514021; 
 Sat, 25 Oct 2025 10:31:54 -0700 (PDT)
Received: from [10.240.88.227] (ip-037-024-071-028.um08.pools.vodafone-ip.de.
 [37.24.71.28]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85308c8dsm253799166b.0.2025.10.25.10.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 10:31:53 -0700 (PDT)
Message-ID: <568103a7-e184-4c08-8aae-a44a634beb43@linaro.org>
Date: Sat, 25 Oct 2025 19:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/58] accel/hvf: Trace prefetch abort
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023115311.6944-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023115311.6944-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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

On 10/23/25 13:52, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c        | 11 +++++++++++
>   target/arm/hvf/trace-events |  1 +
>   2 files changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

