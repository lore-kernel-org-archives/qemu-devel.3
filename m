Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28CFCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1rE-0007gI-5A; Wed, 29 Oct 2025 04:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1rA-0007fq-M7
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:48:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1r3-0000t3-By
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:48:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4711810948aso51914415e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761727706; x=1762332506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xk42QL3EQDuc6NXYW/TALC4pzcD7aluTFyiKFj919vo=;
 b=VuAxiDpSW2ZolvIF4Rwi4jZmyRplizLtRJlbA9zrp3HIwbxHhyZL9xhQZP0r7eV5Hk
 V14wlPjesOkVGjVp6B2xXLyhmhorg8tKJxrFopoDoJGX6KJ86nnqK1UilgbQ1VSB0iXe
 efPrf//ZhKi2aDGvioeFdjiJR5yAfWG35ubINTMPLBK8DAv/eIcTQqrypRt8qHpcOkTS
 RYG8NSRXYEfyIWX5U6Uud7UwYkmFXDDNI7Vk3zGMnY7UxzdDkc3FJl51jIpo5ntSQpYC
 RbGbBpGh9ge97ab2u2y/s57uxZjivI0P0T4VHfZc03IbdH8xVXhDFPRYfirmZpRZrLnp
 cPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761727706; x=1762332506;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xk42QL3EQDuc6NXYW/TALC4pzcD7aluTFyiKFj919vo=;
 b=TJi6d/DLjf6bvFuq5pt/7ZtrX10nlHJ+9uw7jXn/hqoxptHTVGVFlXQT5lmDBaEN6i
 5jPR2utT1q7XMqWNe/NAjmvIEglw9sgF74BXX/iP+VR3AwOSATNYV6D2cw6G2pBa3/zi
 SBeGwIqExm+UTE/zIf5XefvNNfgowRBPMoPUI5Uli49GivOckPKwzbjibjuO94/TR+5f
 2EUQ/jk2XPTyAwCra6GBKbntFi0pqmQZWh0dNAf1mWU0z895rIGjH1EacT08mXccDH5T
 HmLG9p6LbyZbhdHrKi1U2wiZoztKLIX2JoBRZ1v60hJPIWeIKsoAaeAVTFarcuRRuOMp
 dysA==
X-Gm-Message-State: AOJu0YwTNPZRWZph+X5BxRRsbI1f0o+XAvQU1NUqgmoq75T7OwJhw+ah
 7ixOpUTqyADqLCK0QJmhe3DAQ23b5dr25/JVKY0W7wSJZpBwWUQ2AtEhZIuVY3mE/FNiBoOR3DX
 PS7YnRJk=
X-Gm-Gg: ASbGncvEYo8AiWl1oDSP5APIRJ0fnNRLkhJ65hRDA8IEPmaODUk5BnMSX2yslA07j2l
 vtjg9BxJB/tEcL5pgt/u+VHnv8SQnH+lHn7lWMYKstTkIvDqb5BUy2lI8HDMZWeyWLR49ENbuUx
 KD8LkA/zsWvcDRfI2jJU5W8olG8rBFb324T+AdT/4euPBUexnDXU53wo84CD4hTXdeCLV86UGey
 wJwusktxM1EyXGv0KTMPJTsM05DsC9/Ian3QjF9Su+FWRVInclHlS6KYEkZ8MeZf2xzZ+L2FSCs
 gyhOJ4cqORLLRviWROia9NhJd+x23O2YRR0XqDFQw3AniiLiwjR+Q277IOV8QyEqXKysRjaxl27
 uAGCTrxsPQAYzhtl15JGQy6U/ecRI1jQNfJm8uM1wOzwX1ZfeFCyvcN2H2qLISZVbslDZU4+xqq
 c6o8kCiW3TXKf3Gxsn
X-Google-Smtp-Source: AGHT+IH8NIwo2TBbFUIhBpKXnncr52egdLESMlXryDc30B1PfSuZyy6Nzerwwej5uz4ZiHE5AQw8eA==
X-Received: by 2002:a05:600c:548f:b0:46e:59f8:8546 with SMTP id
 5b1f17b1804b1-4771e34aa65mr17851465e9.17.1761727705867; 
 Wed, 29 Oct 2025 01:48:25 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d9e80sm25025774f8f.28.2025.10.29.01.48.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:48:25 -0700 (PDT)
Message-ID: <35b73abf-39b4-45d0-ae2f-35919da7a40b@linaro.org>
Date: Wed, 29 Oct 2025 09:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/25] hw/pci-bridge: Use memory_region_get_address()
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-20-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/pci-bridge/pci_expander_bridge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

