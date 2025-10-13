Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDCECCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 16:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8LEd-0001ci-W3; Mon, 13 Oct 2025 12:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v8LE3-0001aX-7C
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:16:52 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v8LDz-0003fD-RC
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:16:41 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-32ee4817c43so3522830a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 09:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1760372196; x=1760976996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9dZy99F3XbHoMbsjvVjG5DZIQxjYvKcEwYXiFA5K6Mo=;
 b=Yh8jHDMI5GqwKYD9Tv4NsDNkYvnn0DhMYt6Wrc81O4vFyX/yaj2L3uQ9VpECnWzlQs
 zM5wJBAM4sP0dbVg0KhuSUNhuwPXQXr6lRRTfi62Ku3B+5Km2DGju3TMqNTgNAmZQBJn
 yKEv4Ge/gKRf0lUzg5RwdP4n/Sn1IsFDeFzKCF/0IsRQUYoHPps3PCRl8+S1qiSEZtWd
 ZDPFG5usiyCrpPC06LR6Y0NLuJMnOSQsXcFVmu/FK7C5pnJDIvAp4wWQxZairLVR9B+r
 IHOY83/w1hc/rCi3EIuLrHFkdIbV4htyeefenRrq0W2JuBtTsdHjtOM/tm8I7K645zIr
 hJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760372196; x=1760976996;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9dZy99F3XbHoMbsjvVjG5DZIQxjYvKcEwYXiFA5K6Mo=;
 b=GA8eICfiAFe7a7D+QWQNWbzwMlpyTaJZNZLT0gAKtkEt6vJvSMfLwOhSOCRJzt/mIG
 ZKSNYWqe1UP85o7VicOXCGLyjVaaHV0oykWJMvz8tRjF8UUh1VAkAi6YIQcgaMuF8SUX
 TA4NeaxXGC4w+atHvHyRGGmFfVbiCoj2AjsJk7qb8+86m2TRQD9rCyCEOg/+510e5bwy
 ZhL2yJccVuYaWQsIW+zQt5gvMFL6LOCBxvTUjzOpi0xxZz86t+1um2sfMFhMYvob2Hg1
 AylFly6Q+htPJ8JGM9ob6IhgmVK2/91SXlPN4m3dqbRtB8aHZRNO17qBO3WDObetEqga
 47jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0lsi7G5PdkJXKr9YnDhP40xg4td8N51CPEiHVgH97sZeptYmc/yI10TZmi5rvOwTwXL/KBRN/Qo1q@nongnu.org
X-Gm-Message-State: AOJu0YxIcpb7AsLzvuj3zBSb9hpnP+vgzhFvV3Jy/BUiuTm6kekEFCzv
 TkakHbtdfYu/+kjON0dN0Ar3Op0iDrJwrp2EUc2ZT4swb+nsF/AcmmGCd0kcjyM6rq/aEqpRVbd
 tsdtNAKs=
X-Gm-Gg: ASbGncuBZdpVxJhFE06unbpHf3T5IQGpvvk/NAJ3fj9de4vpcMTJuxlE+B+y1TI9I9V
 qVncTh7WWducQO55XW9l6xyCLwj0Epj87UgMKE5aaF4r04nr3u5SBoPK230G14XASLnOHmKCSu1
 Mii1c99OgzuJtBplkPWCpso9PKdU/wC9tSwM/C75rJHC4O13vD8XX/pnnqqoxui+4EsRlhzeQAQ
 uiDt5czytxP6ODM3x+1nKRCtSOqc1eLie7u9c4lj9MOUWZ/benGwsIsyjiI43IWavqlasuxwdel
 4V2Kkf+zCZrLEc7V+WmKYCHQ0vHfIStIRBZgJu/37FeiYkasJCF8z2ybmlVSgi9ATXqizjPgIrR
 xFYEnTotaF8wTp2douJlQvl9h+K0y/IqQsO2rkHzN+P08+gQIKSjDYkZz
X-Google-Smtp-Source: AGHT+IGIQOP+sSZTRNKQa9mzZPqTFtaWMGEgHnKQ44+L3lH8dEchvF4A/4ZGrUoIE5Is57Kzn4SMEA==
X-Received: by 2002:a17:90b:164b:b0:32e:3592:581a with SMTP id
 98e67ed59e1d1-33b51734ce5mr29355866a91.17.1760372196174; 
 Mon, 13 Oct 2025 09:16:36 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.122.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b626e8f80sm12599059a91.22.2025.10.13.09.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 09:16:35 -0700 (PDT)
Message-ID: <64b0434a-d0f2-457b-9301-968239dfe504@ventanamicro.com>
Date: Mon, 13 Oct 2025 13:16:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: Correct mmu-type property of sifive_u harts in
 device tree
To: Zejun Zhao <jelly.zhao.42@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Max Chou <max.chou@sifive.com>
References: <cca1b0f7-8063-4d53-88f7-a56eb56b3eca@ventanamicro.com>
 <20251013154340.1989427-1-jelly.zhao.42@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251013154340.1989427-1-jelly.zhao.42@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1032.google.com
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



On 10/13/25 12:43 PM, Zejun Zhao wrote:
> On Mon, 13 Oct 2025 11:38:48 -0300, Daniel wrote:
>> But the documentation I found [1] seems to indicate that it should
>> support sv48.
> 
> The second paragraph after the referenced Table 9 from [1] states:
>> For RV64 architectures on SiFive designs,satp.MODE=8 is used for Sv39
>> virtual addressing, and no other modes are currently supported.
> 
> And here is the same statement from [1]:
>> The U5 has support for virtual memory through the use of a Memory
>> Management Unit (MMU). The MMU supports the Bare and Sv39 modes as
>> described inThe RISC‑V Instruction Set Man-ual, Volume II: Privileged
>> Architecture, Version 1.10.
> 
> So I believe we should not try to support Sv48 for this hart. Hardcoding
> it to Sv39 should be fine and correct.


Makes sense. I believe we can proceed with the changes then.


Thanks,

Daniel


> 
> Regards,
> 
> Zejun
> 
> [1] https://starfivetech.com/uploads/u54_core_complex_manual_21G1.pdf


