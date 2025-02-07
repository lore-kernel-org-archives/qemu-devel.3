Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E189CC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgTJz-0005ZK-5q; Fri, 07 Feb 2025 13:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgTJs-0005YZ-Ou
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:43:16 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgTJq-0007hD-R6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:43:16 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f49bd087cso26476605ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738953793; x=1739558593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yQ6ouQKtMw+oLrG0MpntcTg7tf/Dub71Tm/Bgzpv4ko=;
 b=qSYp8NFBEAYZx3K2AlQBy7yeuLTzAzhLpmYjDQS9itA4Oh0VvdAatIdbGah5vdWvB+
 DcT0zLQcSpxP5B8ztY06DiGW0RyRlZ7J0IwtkhJACXyaDrztUlKwd9Hdf38EaBPuuAj4
 CoaNSAaTdTASD6ARIN8cgm3cv2dUNCpXwnknD078JJwQvF4vVMhanuFIZy2MulajewTv
 6nFj58F73/FDnV+RGxoj/gFeK42pVYpxWebZhnTSzOhgA1VaW/0PntDtz0Paqc7k/xU4
 45+WXfDc1dEVcxmlKgVJWYmgy9BkMk8uk4b8lZB+HOnbflUqPLu4fvaH7rrjZaXvno0u
 FwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953793; x=1739558593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yQ6ouQKtMw+oLrG0MpntcTg7tf/Dub71Tm/Bgzpv4ko=;
 b=erpEaSDuetexFC+aXvvQg5CY1lHEIS5eg4q79EViqbWXRWyGGPdFUW9ZDx7n3EDVab
 WmCKsw57CRkHSrjH8gf0cfftsdy3JaYGOuHWp6ohUPEcZZ8GiKP3JeuAcdo4FOdaXZgH
 UlSijJOq/RPD5l6Z47w6muampispZ3lHpWZQCz73BY/sVw+8PrPT1kox3X02nkWP1NB8
 v48/SyUDLLyO+3eo+SMmLNDSg+QY5yeV3gGgu8oaX6FpSc3Yi87MdZAaf0b3r88asH+k
 rEmVBnuHl6t/YPWd7lfsj+TICloMH/GaoxGeorIHY5if3e4eKGYmxzEiwsKsiPBI13E9
 Qftw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw8kG7Ea6VD9K4Ug1E3hIQrpwPqwQ+4i2lwUpuVeVbmZM4kToGyvawfcPjrFmxFs4TlPEfbrTxKwHh@nongnu.org
X-Gm-Message-State: AOJu0Yw+GaUC3ajJX9s4rbxboFkFuxe8hWAsp+qiG+mHFR8cxS+7efig
 UJ3d5FmOI5ylQauVfl6kDVbsgVaKB0tXDiJQVRKPrSrhywtVNk9cf4KTr5s9jOU=
X-Gm-Gg: ASbGnctJWjd9DutcOO+vD6LZmrnXk65L3O8vcwI9+JGesa0CMMvCQEXnd6Rvltz+glu
 HyVt3jNBN4snWCbF3rBucJxZPYWJ2InFyMEZGC3VaHNsvXVVjxUuc+iQzS+d25lE7Lthxi6ywbg
 6n8iFBnKyzdP1SGkrBjTvbvD4E6lcgJ+IKcwhiA5NitR2tcmH2+zvzlYKrtymIWoIL6Ol+mz6I0
 TnPdMilZSQw0PK+K0/9S5FdlAf1ACrPzfuLHf7fCU7SHpbVrJJqxzDWmJ4SHwRGndBTh0tFaGwF
 tVVVrjdCHGse6dozqBlE43KtlClvT6efTYuukhU2mm/qW6rk91ugwp0=
X-Google-Smtp-Source: AGHT+IGTpeNLYmW2p3SDgp/nsdVhTg4C9ppV2GubFXW0LsvCUjQZYYkGCotavEk7zK0VwH12vNpbpQ==
X-Received: by 2002:a17:902:e848:b0:215:83e1:99ff with SMTP id
 d9443c01a7336-21f4e6d255fmr59734945ad.27.1738953793035; 
 Fri, 07 Feb 2025 10:43:13 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368d8ccbsm34130995ad.255.2025.02.07.10.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 10:43:12 -0800 (PST)
Message-ID: <8636f192-8438-4123-9dfa-83fd4194ed82@linaro.org>
Date: Fri, 7 Feb 2025 10:43:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] arm/kvm: add accessors for storing host features
 into idregs
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-3-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250207110248.1580465-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/7/25 03:02, Cornelia Huck wrote:
> +/* read a 32b sysreg value and store it in the idregs */
> +static int get_host_cpu_reg32(int fd, ARMHostCPUFeatures *ahcf, ARMSysRegs sysreg)
> +{
> +    int index = get_sysreg_idx(sysreg);
> +    uint64_t *reg;
> +    int ret;
> +
> +    if (index < 0) {
> +        return -ERANGE;
> +    }
> +    reg = &ahcf->isar.idregs[index];
> +    ret = read_sys_reg32(fd, (uint32_t *)reg, idregs_sysreg_to_kvm_reg(sysreg));
> +    return ret;
> +}

I'm not keen on the casting.

If we want to retain read_sys_reg32 at all, then

     uint32_t tmp;
     ret = read_sys_reg32(fd, &tmp, idregs_sysreg_to_kvm_reg(sysreg));
     if (ret == 0) {
         ahcf->isar.idregs[index] = tmp;
     }
     return ret;

That said, read_sys_reg32 does exactly the opposite, using a uint64_t temporary. 
Therefore I would say that we should simply use read_sys_reg64.


r~

