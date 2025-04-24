Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293CFC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qfK-0002Ze-75; Thu, 24 Apr 2025 03:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qfH-0002ZN-Cj
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:06:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qfF-0002AH-LC
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:06:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so583469f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745478386; x=1746083186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fqoYq9dx0ThYNKancTSh16pkxRo/FreBlsus53jZ4MU=;
 b=rwGDeWZjKLA8r9xGf1nC6zdTUolYrVeiQN3RAMCZ6lERnOqQtJcH5LW5CU6Fnt7xXg
 gtyzE3e5W9rAtg1xyo8PkRU7omvBNw63d69knIuyo2G22mLTX9boQ12CYKpn6oX8BMbq
 leRa2ju0Wdq6lIUgARcFs0FtIJXWWVeGZwBSDi5ru+UoHHRJyR1HjhRdwgPRNgFs+qUp
 uL5/MK3wxRD50eanq6WpWYXLSjm+Nr1wO3Mo3xg+7di7ut8CzUCrV/oaWQEuLj4E8ecH
 f/RmtBd16x76qDCIFl9KoJHgt2p17TzDX/+L0o9J30ggiCt6r8KtGZzLlIKpttDpJTmT
 2nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745478386; x=1746083186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fqoYq9dx0ThYNKancTSh16pkxRo/FreBlsus53jZ4MU=;
 b=RgCzgcHdt//wt1OyaVnfTwgnuTaNdh9iYaVWxyGq/N063p1bhM7A7K2v7Uemk9LanR
 hAZRRNPmyJIEOOvaJviL4BbMVwL+JLkA2Xb+CfGfNwSnPOreTLG+e6MMoesc7hcDZgRn
 0ktPUlhXPPE1oweaSFnzUgwHKJdjhLQAkumrl3XIi5u/jxICrI5qMOX+j4O+RrNyxCVb
 hv+eWxii71Bb3ZbjTSVl4rCwcHgWb+G/Ld2T0FjWYs1YpnnRCCSOuYBbnH5gW2Q61w4P
 A3elsyi8aQsCrQAjSZFeowMKyevl/XdFjMdkIiOSLzXeMTDJJ3n0uyD4GUDOEo0C2D2T
 IOlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmGQKn0DN9mWiCxxlygQQcX/CMcafNj88VxTgRu/BN5SJ7H6lm4MjmTnfWnw0reIDIFPtr5wfEoo/R@nongnu.org
X-Gm-Message-State: AOJu0YzOdD5wZ9DrxAB5r2vAgpr6Ifv3PIzg7HSUs42LzNTyHqYeKY3/
 P6h+/FU//8xDwdYZRUa6t72EP79Hyp88y6zud+THs6C6u3LLxNIOwubPdLBnCyYP89XsoBW35Mw
 i
X-Gm-Gg: ASbGncsQ+vxcqUyERI9h+uVOYtKP7aecUpV2veMYKaZXro2MyymiWL4lmMCrRdc24OO
 lkftE3nxEaEbh53FYlQZV/56dZgWo5tmDBlGxcZBiv1RU4aIsvn2CiKn6zQkYCU7tf1eKEdZ6Y7
 bn4JW/8WNqcXx9jEirKts2d+SB0ECMEbpqFf6omBisDnostJLj6+aNSbQmi82pbpAIpQY4SLXNe
 EGIMEjV9jvw07F1Fp5wAYfH1nmFlICNaeZ8/0jtpkDA2PEPggYiYsvFo/tqAjE+J35+PH3QLNDq
 L+5LPSttfDf5JSFAsJAP4loTWt6NV9LpPmXMCd3/xzDxZxWu+PU6mvl0xIY5+ghJ8oSHR0L9BCA
 eEzVPdKeRAYxE1Q==
X-Google-Smtp-Source: AGHT+IEcavzRGdciQV3WxubLBuESt6eOHnw+gT5kBbpVHgVDR0vZ0GaUYEN6eNylpgqvuNMW2/fUMQ==
X-Received: by 2002:a5d:6dac:0:b0:391:2d76:baaa with SMTP id
 ffacd0b85a97d-3a06cfa9e74mr939020f8f.46.1745478386520; 
 Thu, 24 Apr 2025 00:06:26 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4a7ff8sm1095157f8f.13.2025.04.24.00.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 00:06:25 -0700 (PDT)
Message-ID: <9cf30223-268a-40b4-8688-fbeb3f25447f@linaro.org>
Date: Thu, 24 Apr 2025 09:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] include/exec: Move tb_invalidate_phys_range to
 translation-block.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424011918.599958-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 24/4/25 03:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h          | 4 ----
>   include/exec/translation-block.h | 4 ++++
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


