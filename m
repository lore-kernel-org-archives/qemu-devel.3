Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEFEC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 05:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV2oK-0002K3-5r; Wed, 31 Jan 2024 00:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rV2oI-0002JS-3k
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 00:06:54 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rV2oG-0005u5-MY
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 00:06:53 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9b37f4804so369088b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 21:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706677611; x=1707282411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mq7T8bwAeI8SSmQbxMb8Rsrd96Nf4xkghkm4j7vU6gw=;
 b=UCWtfmc894v0kU7x5XPUsPBmQMCMzdzKSixfyucRoeAqvhOJ4td/80cm1i2aW9RKLz
 ubq/d5dw5uolHDWs+/EmlK2mk9JMDDvPUxHkubqaCDOHakXhahrhrarHpLmxedCZqunb
 Js+kvYxOCcO5mJurcnvEWOJDb7OVxnjSlNlCAd2R6AuxhHLI/7s619ooBfbJnKntLgWW
 jzAAdf6u6PDA8cE1vkylvdphTuxLz9V9vdaJNjf8CXDDhFPxWJ35uWdzuFJ27qzFFsL+
 /kX2RyAf0K+Zb+/nom33RJDUbJ1HeP8CkY+1PMn1NKNMV5JlRHMzkKvFateLaCFgWQh7
 wpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706677611; x=1707282411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mq7T8bwAeI8SSmQbxMb8Rsrd96Nf4xkghkm4j7vU6gw=;
 b=UsHt0sDnSWRKOYV+7gXp8pU88anM0jEcCopJ68xkgg52vvoSYZnCKUVftnFABCGqvw
 85olrwi52LG282gR0OXzh9PW0PgJQL0M2a7opSK77XZCL9oyu3c6vFzTpOq/hR9aYU/B
 zNpBeyhNuzubxBPAd7cKjNcTH9QEiU8tg6rWfDl1Ri8vsTLzOI+Iru+nJKCoodDS7ph3
 1zBdcmdk7ZbtxejLQbF77ADjEjt0SyN+w5OKbXXyBei1zAyD9DLL9t5hWbaDCrIXcsDr
 em5RUGMoOPqeL2+Bn8uK7J/06r7MADYMnThx07laiiVUYnxrm48pSBwe2yUnJ1xK8mtg
 2EwQ==
X-Gm-Message-State: AOJu0Yxs1uGESraoFnqGnbzTdnUVvxTBImtrMnkKnOK/p3UxJrMLNr5+
 W8sAaQFlv1lEsseycTBQ1n5FCP17osaChy50EqFeCKDGCXjqw4woGRRzIpdXBho=
X-Google-Smtp-Source: AGHT+IHIdaPoVNOXsTChV56rVztVvZrm+yqhNBhsbgeVKalOdNG1NYDu7d2+TlJQERRBkD/apHC83Q==
X-Received: by 2002:aa7:88c5:0:b0:6dd:da33:f48d with SMTP id
 k5-20020aa788c5000000b006ddda33f48dmr3545837pff.23.1706677610974; 
 Tue, 30 Jan 2024 21:06:50 -0800 (PST)
Received: from [192.168.0.100] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a63cf13000000b0058ee60f8e4dsm9327821pgg.34.2024.01.30.21.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 21:06:50 -0800 (PST)
Message-ID: <74250471-0866-4513-9587-5da41ce0e7b9@linaro.org>
Date: Wed, 31 Jan 2024 15:06:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Register vendors CSR
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com, qemu-riscv@nongnu.org,
 christoph.muellner@vrull.eu, bjorn@kernel.org
References: <20240130111159.532-1-zhiwei_liu@linux.alibaba.com>
 <20240130111159.532-2-zhiwei_liu@linux.alibaba.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240130111159.532-2-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/30/24 21:11, LIU Zhiwei wrote:
> +/* This stub just works for making vendors array not empty */
> +riscv_csr_operations stub_csr_ops[CSR_TABLE_SIZE];
> +static inline bool never_p(const RISCVCPUConfig *cfg)
> +{
> +    return false;
> +}
> +
> +void riscv_tcg_cpu_register_vendor_csr(RISCVCPU *cpu)
> +{
> +    static const struct {
> +        bool (*guard_func)(const RISCVCPUConfig *);
> +        riscv_csr_operations *csr_ops;
> +    } vendors[] = {
> +        { never_p, stub_csr_ops },
> +    };
> +    for (size_t i = 0; i < ARRAY_SIZE(vendors); ++i) {

Presumably you did this to avoid a Werror for "i < 0", since i is unsigned.

It would be better to either use "int i", or

   for (size_t i = 0, n = ARRAY_SIZE(vendors); i < n; ++i)

either of which will not Werror.

Especially considering the size of stub_csr_ops.

r~

