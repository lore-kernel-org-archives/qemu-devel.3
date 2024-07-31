Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13353C52D1F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 10:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ6Cr-00020t-QP; Wed, 31 Jul 2024 06:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZ6Cq-0001zl-Tn
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 06:05:16 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZ6Cn-0001zg-LP
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 06:05:16 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2681941eae0so1510703fac.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722420310; x=1723025110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=St2rf7QdPMn9EEI7qJv7t3MEGM0tEdgXwcCwjyJ3gvo=;
 b=nlJx4e9l0PmNuIHczHjGXU2UVPSy0bxK6yn+fFUI65txhBsa9bGtfp14AKvBPnHTxU
 uVYa8wW2lhYHMOQ01YkRG7L6KYlOSvAkPkO7Mwp+9cKOpUwl4K/3e0I1UGk8vmZptM+y
 /XsVWKWIhj4V74uAVW2wj+srrH/k8PvYlhjXvNVry5foPFbl886c61cvFiaYEx1h3/j/
 167N92imf2AOC5/PnUzttve70vNkrA7peQvUj+uah5pDmdrwh1RUjeLlgwEAG3dfHJn6
 Zk0vWXSXLdSwaSOCDfsPEuY7OxKFF5XXoeJ43JF3ub+DrchmVlCKdd1rHtZMvAT+U1kv
 BsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722420310; x=1723025110;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=St2rf7QdPMn9EEI7qJv7t3MEGM0tEdgXwcCwjyJ3gvo=;
 b=KdfBl+HKOeHDpNB7tBlWS6dC1V/M7U7wgAh36dntLw649HGrVWwa6dIdmR0Y1hG/78
 aIqtbn5jYGtMbi3HkUP3shJn0GAbTQA2uOFrkTJEcoa0QDuKqwbLSgPFU9V9nM22vZZL
 b7gI+Zrhpp1BKTfV8hEtBOEwNkVOKGALHHmALfNHZA8X9JX+wSE/N/HY0m/SrojmAi9f
 PzbZK7/VlMvTdqVCKfxGCu4X/sdix84L3XYXq01ARV1PYLQLVJx777jMocuy4pTJhv/k
 gWFDgVqsEi/cLdNoZJbSJ2Xj5rSgiDf6sijsDCX/ZzgIE0hPEmD2u2BygYRc0hLHq8dG
 RpEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZmh0gvWYi38jqHb/GgQc+GUhqWl2rlIg+w2LfPAk7NKzjvbnOkmHyuv30msJoVa7C5eOmHgvqDAs9@nongnu.org
X-Gm-Message-State: AOJu0YyN5dNl3de5vOuMvgc8FjngSGR50xzlyMesZMXt1XnIvSUF89tu
 qg2Ep4xocfLPELht82+l+yTL8q4Gi8rUvMW+5nzIGhVRAqDbUfZS1RWjn0wYe7Q=
X-Google-Smtp-Source: AGHT+IFHbSjAFF6B1k+SXdvQPEDbzHqZQZqw4pYJ6aIcZ+yTp2+EBPt+SCAw2m2AJPhY+AFwGXamVA==
X-Received: by 2002:a05:6870:d24c:b0:261:1cd4:cd9b with SMTP id
 586e51a60fabf-267d4d1c918mr14493723fac.17.1722420310150; 
 Wed, 31 Jul 2024 03:05:10 -0700 (PDT)
Received: from [192.168.68.110] ([177.197.107.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead874c56sm10036244b3a.172.2024.07.31.03.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 03:05:09 -0700 (PDT)
Message-ID: <65a9a35f-8f04-4342-aef3-0c6644af3143@ventanamicro.com>
Date: Wed, 31 Jul 2024 07:05:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] roms/opensbi: Update to v1.5
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 qemu-devel@nongnu.org
References: <20240715171521.179517-1-dbarboza@ventanamicro.com>
 <0a4172b9-aca0-45c4-962c-3c49327e2f5c@canonical.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <0a4172b9-aca0-45c4-962c-3c49327e2f5c@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2e.google.com
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



On 7/29/24 7:31 PM, Heinrich Schuchardt wrote:
> On 7/15/24 19:15, Daniel Henrique Barboza wrote:
>> Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
>> v1.5.
>>
>> The following commits were included in v1.5:
>>
>> 455de67 include: Bump-up version to 1.5

(...)

>>
>> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
>> ---
>>   .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 267416 -> 268312 bytes
>>   .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 270808 -> 272504 bytes
>>   roms/opensbi                                  |   2 +-
>>   3 files changed, 1 insertion(+), 1 deletion(-)
> 
> While OpenSBI v1.5 compiled from source allows to poweroff U-Boot qemu-riscv64_smode_defconfig, poweroff fails with the binary provided by this patch.
> 
> For details see
> https://gitlab.com/qemu-project/qemu/-/issues/2467

Replied in the bug, but to give some context here: the problem is reproducible when
trying to do a 'poweroff' using the default machine 'Spike'. 'poweroff' works when
using the 'virt' machine.

And it has nothing to do with the binaries distributed in this patch. These are the
same OpenSBI v1.5 binaries that you would compile from source, as I showed in the
issue. They aren't 'patched'.


Thanks,

Daniel

> 
> Best regards
> 
> Heinrich

