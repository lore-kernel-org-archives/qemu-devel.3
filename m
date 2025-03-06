Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4997DC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 23:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqKSQ-0004Xg-E5; Thu, 06 Mar 2025 18:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqKSP-0004XU-K8
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 18:16:49 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqKSN-0003Vk-Al
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 18:16:49 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22409077c06so27091395ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 15:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741303005; x=1741907805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZYwxqdYNQZ21xprZS51nD2F6CTTR9RznKMWoL9Ld5D8=;
 b=pmJU5zOI5/rc+uCxEL+BcD4PzOs2j8mNbVYnzIhCmJTEnCUVtrfAaY110WwIFrmQN/
 DHVHmPO8y+0lZYONH66UC7yey24IUfBkdqQJ//7zQcxkRGv+h16yCkKU24ZJjPummx2W
 JxZh7X49OasK17UkNiOa9XbRRmcYho5XUDnJnK2M5kbgOvQ3hXASQq2l7hxTZkcDSDcK
 IkO/v7uRWJ5WcMUo52JRCvE+H52Qjmdx7wb3boN9iQlkso6qz1axxRKXtsaeheYynATb
 8U5P3j+aaeTEQg00LeKEHlOCkTy48/BKeJl0p4um7czzeMBfk4w7u6PCFPQLQa+iNmOE
 CmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303005; x=1741907805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYwxqdYNQZ21xprZS51nD2F6CTTR9RznKMWoL9Ld5D8=;
 b=shySFQ7vKK/1a0Tfhahx1/0d6HN2i09aLrBcowiLvlwNy3qI6EpP0gsj7SIpztHISG
 NnOsSETXCkgiqh8IDQMpx79wJSJ7z7j9W6a3Z5f6M1tvkdldxyVEQX32ulMNrKPEuRx5
 dky72wgOeIIylPEDoF9HyL9lf+TGoVhrH0YBE2GK+fxZGOhgux5KLVR71ovNuybEVkOz
 8GMwdif0zEDd91pdtPf6+DDc6xg+/yFBfP790YycaVkGINlO4nWRpoYvX2wE728rIgqH
 K8UzQpw8NpBLbvVOTFryUN1rwG4lvO4+kgqFUd85zQLox27ep/YR1Y7uEXBf8GB43GYh
 hdjQ==
X-Gm-Message-State: AOJu0YynBCJ4EK+l0Gke4v+SXAFDPkXkupHCsFRAlnX17I70G5fH65p7
 jpOn8Ewi9ppxNPJEVk7dbmKkgmgwylvt3OiyQl8vyHLhbP2gev3R6Ot9thb2q4vx1TCYYNrn1wE
 T
X-Gm-Gg: ASbGncvPI0VpfMeuEzTEmje2zAVxV3uR+BoUmJ0eB0kl4QQbcc0X/nUvzN+BqcfLGFY
 GMuxrPIub1n2FB9gDS47kJy7xD0ay6W4Pu7ApU5uRVdej3DiSIwBgFf5Obwop3n/8F11GxL4hHO
 4/MHsD4/+VNtyiuOhkws0EuQquSCjThN2hH5IQImME9q7CcS5aSL0ceE3mFB1f2XThOTJB+KVWx
 5F43RcMz/mkJvS3OArVFsvbTpSNdV9zoefZVj9dIi79ehu2tmEQGu0SIQp65VtQQX0qj0R4zYmb
 ijrQigFbO0HtTy55oQGstY+XArZlY1hJpm0tIO9TipFd0pLIvcz+2R689JMvkSuQ+9hqX+bMV2X
 MKPmep66B
X-Google-Smtp-Source: AGHT+IFhBFO1cAwc/koPpifW50pomtiKpNV/Eh6TKEMPAEoZ+OlZ25AWaK3YBJ+dgneMPnjNYxya9A==
X-Received: by 2002:a05:6a21:9994:b0:1ee:6d23:20ab with SMTP id
 adf61e73a8af0-1f544aedbc9mr2033461637.10.1741303005357; 
 Thu, 06 Mar 2025 15:16:45 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736984f6f82sm1910497b3a.115.2025.03.06.15.16.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 15:16:45 -0800 (PST)
Message-ID: <3acf66e6-449d-4e39-b5e2-3b495cb5881b@linaro.org>
Date: Thu, 6 Mar 2025 15:16:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] target/arm: Forbid return to AArch32 when CPU is
 AArch64-only
To: qemu-devel@nongnu.org
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-11-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306163925.2940297-11-peter.maydell@linaro.org>
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

On 3/6/25 08:39, Peter Maydell wrote:
> In the Arm ARM, rule R_TYTWB states that returning to AArch32
> is an illegal exception return if:
>   * AArch32 is not supported at any exception level
>   * the target EL is configured for AArch64 via SCR_EL3.RW
>     or HCR_EL2.RW or via CPU state at reset
> 
> We check the second of these, but not the first (which can only be
> relevant for the case of a return to EL0, because if AArch32 is not
> supported at one of the higher ELs then the RW bits will have an
> effective value of 1 and the the "configured for AArch64" condition
> will hold also).
> 
> Add the missing condition. This isn't currently a bug because
> all our CPUs support AArch32 at EL0, but future CPUs we add
> might be 64-bit only.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-a64.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

