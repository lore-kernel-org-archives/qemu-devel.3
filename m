Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BE3C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 14:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4hLi-0005IC-Ft; Tue, 15 Apr 2025 10:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4hLF-000525-AZ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:32:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4hLD-00077h-Jl
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:32:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22a976f3131so58670475ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744727565; x=1745332365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Fyj57vGaBc0roMh6YMQRRh+zQ5VOzli8l2LQL3dC2c=;
 b=SUc9tLNCO+7f60PBqtcBGxrxoFIKM8il6pUGdV9ZPJoE5pcpfhMXP+fLX4nx8ZrwF6
 KJdSF5TZyphdHzuMxiAf6BKsYMTIshwJ3eii5kFgKA0bWlmBEKLMhgruTTPkuIn0Mh4F
 BXAp4vBpz/jfDKIoEbro69GVJuNCkU5TDzmxLK1Y4sUr+GA53ZTzKW8dDrntUCc7BFjc
 3sddarUgt5WJIj4y3DP2y+X5rceKCvInCTuNNLmzVCYIqJzgqWNGz51Oc6ZRzgrziLwb
 2TCAaP3wzWSOGbv6TW6T9cJxr7gENlJzg+yGITWiY2n+ImhgkJ4KdZPF/G73J3VttGRZ
 ajEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744727565; x=1745332365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Fyj57vGaBc0roMh6YMQRRh+zQ5VOzli8l2LQL3dC2c=;
 b=ggUIO1N/0WMRCKAaOz+x71ktgtNw48/jDmOe9G8qzMXLq/YSExuiyDcjbltikJJI91
 0tFsBNKBjyp0Na1Ris6jCSxO7KW//4BRIgCsQFeQa3KQCZvblKjGQnbt16KV12Pwnour
 aK+/nJi0iM6CCcG9lt/fnZ/XFG5ssEMgzM8UgsPz7GH1YjMgIM7s+yZSX7J82EqlbJnm
 +PULTvzapdfyArT/j1LoneDzo5pxfQrB/GXsCTyOfIm0vec1Y0SzslX5sjQlVQPte1Qz
 QjUdXX4ZoHtrRYFjGrROzpYwXqMpf9jiQaul3cT/dLPet69YzTXx8Zmej9B/2djeOPk9
 OzCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEutsKB0ItfzIlp6mePxcXb759i/52cAbl1TRi5QuWzxoSfmY+6Ozq35wASMkhykJm8M1ZALTuhYPZ@nongnu.org
X-Gm-Message-State: AOJu0Yy2bFPGzuwI3Ljxvpc8FZ090gTkmExtO5tYgRzu9PPqJub44VWf
 Hs+ISFBpOtesuTybr0Mwk+3FMgOBzr1+xtMIBNAiQICTvbUdMTB7oyeRjQX+OPY=
X-Gm-Gg: ASbGnct+eJ+EtKfpCrGaCWHKVCQdvKzyqUwDBPn/Y/zuOX6yzRSiOog9fxm8NKwtHsD
 l+HVKSsMhPm/jF/mPmB4BmdtmQTWad3XNTCYvds6Od3Q8BROU7yFeSeaCzfhwTMu3hZJ9OVx48v
 ffxBYr1i4zCMoWHM0lV6WqpBD+1Ywlb74Yb1/ZGdAE/qf54hIbqhO4hr3YxkMnq20Mi0rfO2N/i
 /Ff+7KzdeePgQEdAnXoc1f0LFTJH7ok6sq+v8e3jKQsG0gAxvuX2iaohZh4XAEIOLMx20aTIcry
 4llQ0dB0EAm79rCCw+t5hZe6x7AV1cKMYrNWetfvcrR6zkOESWzVivZP3WB4xnZBr0E5MSXglBC
 AXrjkmeU=
X-Google-Smtp-Source: AGHT+IE/T0ATNx9AQ45DOWA46yhQAzAv5Rm50r2Eus84buuBj0enEWnWQgB6F4aK2N9cn8Klm6jejg==
X-Received: by 2002:a17:902:eb8d:b0:223:5e54:c521 with SMTP id
 d9443c01a7336-22bea3f1542mr237904995ad.0.1744727564445; 
 Tue, 15 Apr 2025 07:32:44 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c971bfsm118249105ad.123.2025.04.15.07.32.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 07:32:44 -0700 (PDT)
Message-ID: <de4fba03-c9dd-4ff9-8f4d-8feaff52703b@linaro.org>
Date: Tue, 15 Apr 2025 07:32:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] target/riscv: fix endless translation loop on big
 endian systems
To: Ziqiao Kong <ziqiaokong@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, alistair.francis@wdc.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250415080254.3667878-1-ziqiaokong@gmail.com>
 <20250415080254.3667878-2-ziqiaokong@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250415080254.3667878-2-ziqiaokong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/15/25 01:02, Ziqiao Kong wrote:
> On big endian systems, pte and updated_pte hold big endian host data
> while pte_pa points to little endian target data. This means the branch
> at cpu_helper.c:1669 will be always satisfied and restart translation,
> causing an endless translation loop.
> 
> The correctness of this patch can be deduced by:
> 
> old_pte will hold value either from cpu_to_le32/64(pte) or
> cpu_to_le32/64(updated_pte), both of wich is litte endian. After that,
> an in-place conversion by le32/64_to_cpu(old_pte) ensures that old_pte
> now is in native endian, same with pte. Therefore, the endianness of the
> both side of if (old_pte != pte) is correct.
> 
> Signed-off-by: Ziqiao Kong<ziqiaokong@gmail.com>
> ---
>   target/riscv/cpu_helper.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

