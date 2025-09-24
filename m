Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0248ECAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 21:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1XAG-0005nG-Ng; Wed, 24 Sep 2025 17:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1XAC-0005lB-SR
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:36:37 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1XA9-000119-0b
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:36:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77f0efd84abso311616b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758749788; x=1759354588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JjUHpX49DBfp5s1oS/u8Nqx0j0b15dM2PC2rC/Aokwk=;
 b=uClt4jR0JkUQsBP2LggG87ZAiTNb4P9enaxotydRw1aWCBh10BsbvInD6uG/ABlopD
 9OFUdnAtXUtSTYWfXe/PCL5gb67H8LEjG8aYjKfDvT/hGj8oMqg2c6AjiyojDYZ+zeZ2
 Tt5XZw5isn/EedRsNMSPpXr5zSKpF5SiqgFg00ZjF/uJob8NewjaksrybPInkMkxmy/1
 8cu8ITtCWG0IKcAbd2XdGsDCwKohDx/9r/b10XrEf3VdFIeiqOJ9JU8wljl+UfkY1w3I
 vDR3s2Y1dp3nSH7mEQhIfKvmXENGiL44m9aMkAAwl5dZSI6FUVgm75QxfNYnknxMYKwz
 daLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758749788; x=1759354588;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjUHpX49DBfp5s1oS/u8Nqx0j0b15dM2PC2rC/Aokwk=;
 b=VQRphfNsrKC7Rl9QYGV+BmzBHdhbGD/sD2GipVDP4hRF6P/EAMi//COcrO++Asat+F
 dKs9FTIqn296Xsxv7F7yTgW/2acE6p9ACQSESKWyGINuTCavyQwpmjB5a/WcWdGkmqLg
 EKaIMNG+D/n7D+3nrRVr8cL++0315uzW696pcr9nMNWdb5VYOyWobZzA5bR3oUumVD07
 kvAd0nH5qlATP7tnag8w2KIbHuy7WJO2vD2jtIiJfRMK8CVydCBq5Lpu5Y2QIZ98Z/Zs
 86QxpMnGDpeOdDuZN33W26FTpdG5jSLboIFC1rYmMBkC1xYj+Raq93hX3FiEBdRcwxY5
 xcRQ==
X-Gm-Message-State: AOJu0Yy9H7MrTIzGrPzs3+eaYSSVZ8DsKcMPYDt2FI/Q2Tckf1W55leH
 P1nzCGTfdfriaNHADdDva+t5tYuhoDhADqkjJ0AF0RgahD4pbiLZyApamZau+vJBHgOEde0TbFw
 mP1ZG
X-Gm-Gg: ASbGncv/mB179J+IRWqConp4JhvoNw1r46pkrwmbRzRkTiBoexWA/jYJOxTnaeh/6Bs
 j36LAJCojkjgz8Bd5FZlH2E4TLTrh3D6ScIYJJmaUICjC8BvENB2F3lZPwFS60pKTy/3txDNf+i
 Yi6AwaBPiAd0ye+w1/+WOxG6IMr6p3lb2xNsC7xPfxgSsh4gEA3+F3/YCh90LBLLzo4rpLxg/Hl
 ckdnYMTcKC30g1JdHNMkwNpuL/TsQ5jsoIUx8FONvD5Vu6dPfkpotJl9ETSz2iMn3Ga1dxFdDJT
 3WoyqwQNXygUx/RbFAiK0Nh7WfaWqt5Y16lGfQoqo4TGJlDFUQ7VPPY8nV2ExG9O9jrHIxL+w/5
 tGUeb0ltNAVINe+FJzmfC1oS3IjqukD8VNC3A
X-Google-Smtp-Source: AGHT+IGjjwyOhcyJulOHVsSH7sFbt+c+/L1o6unbJhHk7EZQxryfENnd7w3+j3RnHsN5WckWVG5dhA==
X-Received: by 2002:a05:6a20:a127:b0:263:b3:d8d4 with SMTP id
 adf61e73a8af0-2e7bf47c155mr1351462637.12.1758749787993; 
 Wed, 24 Sep 2025 14:36:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-781023ec6aasm32313b3a.46.2025.09.24.14.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 14:36:27 -0700 (PDT)
Message-ID: <63d16a48-f5ad-4357-a33b-09a157d33826@linaro.org>
Date: Wed, 24 Sep 2025 14:36:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/34] target/riscv: Fix size of trivial CPUArchState
 fields
To: qemu-devel@nongnu.org, "anjo@rev.ng" <anjo@rev.ng>
References: <20250924072124.6493-1-anjo@rev.ng>
 <20250924072124.6493-3-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924072124.6493-3-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 9/24/25 00:20, Anton Johansson via wrote:
> +++ b/target/riscv/machine.c
> @@ -84,13 +84,13 @@ static const VMStateDescription vmstate_hyper = {
>       .minimum_version_id = 4,
>       .needed = hyper_needed,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_UINTTL(env.hstatus, RISCVCPU),
> -        VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
> +        VMSTATE_UINT64(env.hstatus, RISCVCPU),
> +        VMSTATE_UINT64(env.hedeleg, RISCVCPU),

You can't change these sizes without bumping the version id.

I don't know if riscv really cares about migration stability yet.
If it does, then you have to jump through more hoops.


r~

