Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732E3C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURQv-00009b-9D; Wed, 25 Jun 2025 10:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURQs-00007T-Tl
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:49:03 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURQr-0005J2-1a
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:49:02 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23526264386so72598385ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862939; x=1751467739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AM4DjWogGZz0JU02yvlAcCv6B58syl2/RgyxNtFDHp4=;
 b=NHphVKrKHwbqrcsynR2+xa+a21wXe57YIXonDbK+Fe7GglDk8us2WImr4Rc+PLOgfG
 z7W5KU9el3cLUCPHm4jxNdsNdUXNrgdNmyNMwd8EQKYl/fkzJ6Q/32bTbWOvRXDwUzY7
 K908KJP0m+X8MwhoYXzi4nUAxNp2kzuAlayAUHnQeaYNw4CystrOg32WLqJGYv2kWsu1
 RgF+KsOTkWRlv6saCZs9BaI8SvCecD5HcTfKibYb2h9LjJMAfBRTSHOaNPXg5TS2gjxk
 NUo76MH2IqpzRUTqtGfvh8L4iTfj/sqrN7grPJ9BLjF+geIHENjVXXmyj2uLw5VOiaAe
 cFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862939; x=1751467739;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AM4DjWogGZz0JU02yvlAcCv6B58syl2/RgyxNtFDHp4=;
 b=qrkVA67Gq5n4b03CkSnlb2o5l5/ogV2LycRx/bWgXxCdvJKRnTavVf8UKknOxutdzC
 kiuH1/pKBwWgQ85fJKY5h1GzqDH9Ednfqhpxgn4CQeEyl63+TzsaAcJKeIhVrn1vxPa8
 X7MS2zmiwNZPOmd6yXL7toc36vaI7tnZUxANVWCXsjyITP1FKCKB+rv7J1TK0yVGFN3q
 T/af/q2krvO73CzYu0uFxjyckR5Fg/R5XoO9A1lrx8rBla37/Xsr6nYVdgctfw+xwPf7
 SO6fhc2AvEEaQFkXCntDVx1K2pSkBST4IyUiCSgohodMLlu26dzEYi1lw5f3t3Qn/bn+
 oBvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF64JYelbqGPNlj0Yh11iVpLzFwNvZb/8B89GuVaR1weKzLEQQ9zWL/vD2ZYaEUuTWHI8ysU+rYKef@nongnu.org
X-Gm-Message-State: AOJu0YyV5ZBFobK936JfMAzglV2YlCemsAwVe8y3aPkDKRLu9+rCtzpT
 U/c9PNrcoSuAv6P8Q4pdVTTS7QzZSrz/UbquVV5vmtiatIbPs2ty5QTNCUOEboFOxP4=
X-Gm-Gg: ASbGncu/gx5VVl13tMGoWrVB6pzx33dMwrsKfzrvaCKhHimS2z15tEpTwDPp9RhCw46
 qpl3TDIpic50PxYINUCiDdpICVCGPkqAMDvm9GcULSUPvkLsnR1brEJePKQ/vgsi/pojJI4U4yq
 NOWfozOD6iFzT2r2lnFVL7DLHjHD2Msu5nui0u46oUTRLMUZ1HHfzXLZLfs40PVR/igxOSwOfLK
 52QaxUCOOdU0Phua92SAgtLeCVIX7i3aI3ksdgmk3iwXXOSZZpflt88uBEdy8Jo5dtHW00GDPQI
 8H0JsqDLbpUPl2/2v1s/kDn5JVLi2O6Juc8C/o4iQMv6J9ib+5teqaFKBsNGgYXs2KXXX5cPr+s
 =
X-Google-Smtp-Source: AGHT+IFd95OBTOQA/6tbg8XnSAFMneBv6fIKMIsD+yK4264057U1MU8VGrqkTjFqlYWWfpExF4uL1w==
X-Received: by 2002:a17:903:4b0c:b0:234:b44c:d3c8 with SMTP id
 d9443c01a7336-2382407271emr52416685ad.37.1750862938973; 
 Wed, 25 Jun 2025 07:48:58 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8393741sm132817405ad.15.2025.06.25.07.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:48:58 -0700 (PDT)
Message-ID: <770a903a-c018-4a01-a883-3d271d00af8d@linaro.org>
Date: Wed, 25 Jun 2025 07:48:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/27] tcg/optimize: Build and use one and affected
 bits in fold_or
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


