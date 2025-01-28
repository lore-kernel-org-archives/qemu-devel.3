Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C18C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcscK-00045S-7b; Tue, 28 Jan 2025 15:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcscH-00045H-0c
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:55:25 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcscF-0001g6-IC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:55:24 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso8288183a91.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738097722; x=1738702522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tk6SC/sXu3nZ38nnpeSVXfPOJnas5Y5jvFOyhMpP5wY=;
 b=Rn7Az9oBe7HHGH/A/CgfUWTCfywKw20251Z/MUwp8hnhAU7WukEHy7XWHvTFKvw+Pz
 eeYdKgjzLn7Y9kYMUHVPsTpUU1QrrcPJTF+CXosvO4mSY1Rn47PWGs81lwiuq0xgKsM2
 BnVLRTmihvizQtSYTRvvId957PT68JDoMdovQxfSfYHKOZUru5epJfnifwv3w0dWaXPA
 t12bk0MN6o+7nPXV0ardwZm/pntQwgwWQ0au8uanLmz7C9ANEo0DglkTKjCZuWLiwSdL
 OhGQU8V0tL7GifkpULaJ+kSc2yHWs/tUzdEu9E77VJ4qT3El62heAeQgEF6t8AqwfWw8
 USww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738097722; x=1738702522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tk6SC/sXu3nZ38nnpeSVXfPOJnas5Y5jvFOyhMpP5wY=;
 b=FywC5x3qN9wSL47PtWKn82RH/nxzonxbvoP6JTWIEW8k64T93t4PuybYsD/TQtMaDo
 08PnxpmuuuHjF+CRjiTh6PCchbHYI8VUvh/HpaoJzB37KYngDy6u4f3M59iIRjEAcJpk
 avYpjQmxo2QaGKMgd1+99nr0aJe5vo27N6hshcdZxNA/qn7ZAZtYOBpPkJR4/P8EawSx
 rY+M8++I8boMJ4ulbjrrpyzUJv58NYOsvde4lOIQF5G/922g6hj2b8H0xvm/EG4nxHbS
 T1oEdXgSwmPl+0OjKg1ZpvebO08jixMXYoO2JICT/iEXrrDHSg/OcZAZPmusNM2oaW5N
 djsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxUI3RIXw7NsU6p9sDiJDZyOlSD66eZ8sSHryyCOSAuRtTizz/wCoXqzG1ikAkKx/b7boOuizthrSu@nongnu.org
X-Gm-Message-State: AOJu0YxUwInAFuwfgi6vXi9yxuYa9riN0zIX/Da3ApntDYRmNvIBr8V5
 xXcH8MRJ9e8MLxWSYtNAsUXbZJ0FN0hZ3npeRtF8/n/Ld/5DbKjl9DlGb2xxj7A=
X-Gm-Gg: ASbGncvdQDoG85+PU2ICOBwYwqu5LWCJ7+jYnLgO0cfewvi/PUphfT9uTM9mjOvq2Jc
 xI4FwgeIwyMTLd1fRxUX90g/NVrTxiEPq+nL/eZr7kFZ8ix+f9Bv2hRoBBvV6HbSypTgkLri2Py
 eAwH6IZtGPWvGq7NhfgA7QuIyZmV0Q2spBh+28PjkF0XIsCLas8ylV+AfzMvcopWk835pWgxuP3
 94taVl+Y988DUskr1KjvTuNFkT309TFakPYxuIDVGKypnn2A+KusG3zC9k/3gJNYTFErnpS83h+
 H5cLdn1vHDLlLSZedfXZ0w5vm2N+lchUtW3vH5RB0732IZWkY/6zKTO4iCrYuXGWfJG+
X-Google-Smtp-Source: AGHT+IHXaHwiGgvoGyH4RXVKJr3J+3gnWSR7ML+JiAfdyojCEMUSMyRf8bjV2DFg5vmDLaJiVOu41w==
X-Received: by 2002:a17:90b:2c84:b0:2ee:cb5c:6c with SMTP id
 98e67ed59e1d1-2f83ac70de7mr508691a91.22.1738097721886; 
 Tue, 28 Jan 2025 12:55:21 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa456absm10898525a91.2.2025.01.28.12.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 12:55:21 -0800 (PST)
Message-ID: <55627824-fcbe-442a-ad95-24d5ac6e2ace@linaro.org>
Date: Tue, 28 Jan 2025 12:55:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/9] cpus: Only expose REALIZED vCPUs to global
 &cpus_queue
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250128142152.9889-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128142152.9889-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 06:21, Philippe Mathieu-Daudé wrote:
> @@ -91,7 +91,6 @@ void cpu_list_add(CPUState *cpu)
>       } else {
>           assert(!cpu_index_auto_assigned);
>       }
> -    QTAILQ_INSERT_TAIL_RCU(&cpus_queue, cpu, node);
>       cpu_list_generation_id++;
>   }
>   
> @@ -103,7 +102,6 @@ void cpu_list_remove(CPUState *cpu)
>           return;
>       }
>   
> -    QTAILQ_REMOVE_RCU(&cpus_queue, cpu, node);
>       cpu->cpu_index = UNASSIGNED_CPU_INDEX;
>       cpu_list_generation_id++;
>   }

We might rename cpu_list_add/remove, since they no longer do what's said on the tin.


r~

