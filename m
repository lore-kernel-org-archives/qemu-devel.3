Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8C9CF34BC
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQkU-0006Cc-5r; Thu, 03 Oct 2024 14:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swQkN-0006A2-Dh
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:40:19 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swQkL-00075N-6q
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:40:18 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71afb729f24so1103921b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727980816; x=1728585616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2fkMoD0i9taLeZEjrUv4HUb+iox9NK53uddLKBBo2XE=;
 b=FS6nqf/EMAKlL6UMvKU8qiY7fwKcaxxhcaWXd5mNZLXIg3pRkNd23DRCVNs9B/ofPP
 y6Y4dKxQiecFWApJUyUjQyl1tBVtGLl0sLNhgC+zOPSjaQD1ADFe3MeUXbivqA/jBdND
 QR5jWZ9tXwBAKJpGzpJ9bE8v+sRuboYFrxKH7EOcSQTC4ja/xbArpUWKPApBltB+tDr+
 07qC8Ve7hFHQcjrZDda+BOEP8JZOURFzEgKozOZJIRLvnJ1o+Nm2nkFHlt1sGNoBN9wc
 QSZgaQsA0TbP1edGshI7O4SzDM/WR+u5XbgJK7Uu5N2gcS+gSxGS6tl/pHJYoKpP1gIH
 xC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980816; x=1728585616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2fkMoD0i9taLeZEjrUv4HUb+iox9NK53uddLKBBo2XE=;
 b=mn4aMQ8GMMZXEJ6zonF+v31IZawPqzVKIU0KYXbEX6+KcF+PPQ7pRCEIS6u08sMF3p
 Qn8GQZbiIIIw0QnBl3FW1kyqc53ehTHsREp/xNJUhsdWKfJDArEUgcXV12z23tReIamG
 5nzF7eDOom3UFzuvh3i3fWxTOoynfJkIvRwSHcfZn3JMvSvHhaFenp2KB1gaBrCST4Fk
 I9Y5kBCVkp/FOeFMPNcZWsdxY3W1iEDpiuNqJ6p+jCAa2qjdtGwFtSW7QcFz3rv1tYEE
 dWKyTQ/ZbzhmOiWiMb1f/8bjE/HmLNrJqmVdXGXC6V5WR5yfqNH0RhYzGrIgVIRfbAGg
 hAnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZKUgzg138Wo0pSkvNXaWLHIJSzzqLNzUa2kDV3bbRpZD4M2vXQyXgP3/T02NgD/RycTDZTBjje2Fa@nongnu.org
X-Gm-Message-State: AOJu0Yx9Kb3GB/uCx4dp2w3hISFeZX+llv/e0uF2SVV99Z2lERytNBps
 vVxfzXKKJso4AKBnzYPZ5MjDWUmjC3+zoq8ttLEj1wpyA/c252UTfor9v4bEJdQ=
X-Google-Smtp-Source: AGHT+IHPrfoFmJfxRdMnQa1fizFfUp4Z4DbduIgNHmu8NlYDjDZabKfVgF9CzvwSNFw261SU60j8zg==
X-Received: by 2002:a05:6a00:4b52:b0:714:1fc3:79fb with SMTP id
 d2e1a72fcca58-71de22dd687mr193130b3a.0.1727980815598; 
 Thu, 03 Oct 2024 11:40:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71dd9ddeee5sm1685558b3a.106.2024.10.03.11.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 11:40:15 -0700 (PDT)
Message-ID: <ec6ed202-f67c-402a-9abc-19c31f03ec8d@linaro.org>
Date: Thu, 3 Oct 2024 11:40:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] target/riscv: enable floating point unit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, kvm-riscv@lists.infradead.org
References: <20240925061704.12440-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240925061704.12440-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 9/24/24 23:17, Heinrich Schuchardt wrote:
> The status and mstatus CSRs contain bit field FS, which control if the
> floating point unit of RISC-V hart is enabled.
> 
> There seems to be no specification prescribing the value of the field when
> entering S-mode from M-mode. But OpenSBI, as the leading SBI M-mode
> firmware, has set a precedent by enabling the FPU by setting the value of
> FS to 3 (dirty).
> 
> In TCG mode, QEMU uses OpenSBI by default. Users can reasonably expect that
> software running QEMU in TCG mode and in KVM mode behaves similarly.
> 
> When QEMU in KVM mode creates a vCPU, Linux' KVM code sets FS=1 (initial)
> in kvm_riscv_vcpu_fp_reset(). However, QEMU internally keeps a value of
> FS=0 (off) and then synchronizes this value into KVM. Thus VS-mode software
> is invoked with a disabled floating point unit.

This suggests that qemu is incorrectly syncing the registers from kvm at vcpu startup.

> +    if (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD)) {
> +        env->mstatus = set_field(env->mstatus, MSTATUS_FS, env->misa_mxl);

Storing misa_mxl here is wrong.  That's '1' for rv32 and '2' for rv64.
You want a single constant value, either '1' (initial) or '2' (clean).
 From the kvm source, initial seems preferable.


r~

