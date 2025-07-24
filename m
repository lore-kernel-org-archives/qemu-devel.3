Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2B8C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueu9L-000826-7G; Thu, 24 Jul 2025 07:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ueu9G-0007T4-13
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:30:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ueu9E-000393-15
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:30:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23602481460so8379165ad.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1753356601; x=1753961401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9mScItYN4PjiZN1y3ZL50DBOIN0/0wrBABlORo2JXU8=;
 b=MZPxmowFGn7SB3VaKwiTf2CpL8XJVXFK2wOM5TgbGerkaS+f0qE9Ot28sbW5IgN3+5
 U7bita/OPZERUGCQ0ITw+awXskrSOb5rCY6ihXHMfRtAxhkSHz+Z3HzTX8Q6CC2YXC00
 4Xuc9WeYyVDZlyv7qiHeVm7ASbc+5fbKpveigX8RuEpwvH26weQ82Z83HilQHh1Zj8hh
 atuHx1plmOqi3IFg6WYb9+dF4YuYtAQgddI8DMnhyXfMhaXYcrIsAVfRq07jeF8ASVHE
 krvefbe3z3VwciEtPCIm2NZyo6iZyVT/nxLMVtvZgM1+NMySwFbmAeusc/Hy3ixMz4ED
 HD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753356601; x=1753961401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9mScItYN4PjiZN1y3ZL50DBOIN0/0wrBABlORo2JXU8=;
 b=c+aA2tx9bCuHI1qWBrKq6/v5d/R7zIvxLWL5injqD+iBPY49Ict/JzQo7l8mcASPfJ
 ElYVncJa564tpU3TDV+53MftdiKW6bndUgz40NwZEuXxIy3BRw0Lhdfsm2hY0/mbAZe0
 DSTMZVmXAzqakV/+Fxpz1c/o749XF83oSlvEuLNMEsNKxzj5D2PUA+GPflvxibXin5ex
 V1f0B0B6316OLnvZKe0B/+Bm0wRhtNcM8Kj1Xl56707/MdDJJ5HN4KPwcAWwQbVQJ9mW
 LZUUpp6lA8IRpozcwsikJLfILWWWcTmAF6wdytqr7i22vd07cXD9srSLdk3NY9GnEYBl
 ggqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdMAxcMi6cs5qayPDzk9JG3duf7acSxK+7Juh96Givwpp80jRITQ2zGbx69OL/kcHelwKflSNFyaWr@nongnu.org
X-Gm-Message-State: AOJu0YyRsG967nprU+21S/YW+ftib7w2WejnAoo/ntjiWUETWNE0hzXO
 vEdUCwaf55l6Iir+fsRIHM0vNi1HcnC3S2cT6T5T98V+HYXB95x3BDaBFGWMD+7gCc5RkPt4zT9
 slJlO
X-Gm-Gg: ASbGncuMCdWBt8atCComSJ2hBMNTPCvnsg0mxIQl9O60VhXEgQFxKR046B4YztWkNfs
 1C7HkwCN2QMuTt0UTK8E4EmiQnR/JZWnEqpHgnlMnJ3T7njuafzQI9tu3fFwEkJ5Fxq8z6pLpvr
 u+hCmJCMRomTDmY8mRfIYrK18Vdg6q0pqgg46HcSXuWHE9Vqd8woIVoJIUwgFWdKIxKq5rhxTL6
 qDwODVBfVLObScbbVm6JlA870GH8A7EivKzpHznhtqEaV3XrpuVJ5z/2FcULZ4m+5MRL29ZKEfR
 gWbDQs8TvwGAsGde49LKPsbnRVIMcvrdxhh4yCEmCpj9HmcdJ6CM1pxykfxNIxDTOR8ftdHMQsI
 6DVuyTJqndpzjlU7tDl3bkeKEVBvnx2yzrm0PWf8hBgBz79QW9LkcVr0YsrCopEuxZv+1kn8xIm
 cX38XjlqlvZxU=
X-Google-Smtp-Source: AGHT+IFpJY84uaHysKbaKd8spF5WQ1pCc1Smu4PJ71DHxo1bzUHgQee4LIbyqgFCiFAYqg2ehobAnw==
X-Received: by 2002:a17:903:41ca:b0:234:ba37:87ae with SMTP id
 d9443c01a7336-23f98162005mr106464595ad.4.1753356601382; 
 Thu, 24 Jul 2025 04:30:01 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:8924:370b:6e58:6804:59a0?
 ([2804:7f0:bcc0:8924:370b:6e58:6804:59a0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fa48bc7b9sm13486835ad.98.2025.07.24.04.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 04:30:00 -0700 (PDT)
Message-ID: <f55a1514-acc3-4c46-b26e-b6727b38e25c@ventanamicro.com>
Date: Thu, 24 Jul 2025 08:29:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] bios-tables-test-allowed-diff.h: Allow RISC-V FADT
 and MADT changes
To: Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <anup@brainfault.org>, Atish Kumar Patra <atishp@rivosinc.com>
References: <20250724110350.452828-1-sunilvl@ventanamicro.com>
 <20250724110350.452828-2-sunilvl@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250724110350.452828-2-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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



On 7/24/25 8:03 AM, Sunil V L wrote:
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..0c3f7a6cac 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,3 @@
>   /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/riscv64/virt/APIC",
> +"tests/data/acpi/riscv64/virt/FACP",


