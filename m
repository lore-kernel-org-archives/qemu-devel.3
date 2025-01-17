Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810F4C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpQH-0000aI-91; Fri, 17 Jan 2025 11:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpQ5-0000ZI-3R
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:42:05 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpQ2-0000Gk-Bi
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:42:04 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso2080808f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132120; x=1737736920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tD1tuxi7bHI8bBdrTyWjCLW1onKMFnZKFOgvVbAQyTo=;
 b=pLSw/XjPP0Az63jB5CgFVYXtpW+HNUyytnuPUcbDDarp3F1q1jFhKJLc9T/leEDwQ7
 oEqRjgArjcn0Ex7wiP7idktwYOa7nLAvXHUPu/wB5iLSV5/kN4gZvMN/ZUn/Y8QjKUKC
 /aa/NbipXOzvVsJuJJReVq/WmUQMis8H9EGhwC23JF0FsR8utL+Lqm8t58LlRGlFkZOD
 PGibwpwWwEyrszpsMSoEeO8BBpkIp/qHbMV0ToDe88ET2U1x6fI/Z0uK6QBFvtSgVgCX
 IDBdz0plfktSbPv2kL7gS1atjf7eVtJCo8vCWO0u+E34ZJvltOQkC+zqt1KvUcVF7tUj
 wmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132120; x=1737736920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tD1tuxi7bHI8bBdrTyWjCLW1onKMFnZKFOgvVbAQyTo=;
 b=ELtTHa7507+FI6EoI+ctzbr68AbGtXWCidAiTofs0HHrcrUEO2XrjAxVh1KG8I2Sdq
 0hSFitCGYi2+Wy3/d0qonhqRlLmK75cM+TRNmp9vy0ZBYSa4MGPnV7vXjp3oJGVbWACf
 uptBsx2wUVDx4WIsaGzcBtCOwSaCkQXiCfCVU8hz9iPZUbv4oaTtRbmRBhOOLKmWNGuD
 HoR84Lurlh17qdmiHVOg2TZQ9PJZCUsu8MpfueeBgZaq8OIvbybXFwB2cLzi4+FNBfgV
 EVxVx/MJTxynLQP4Bgzw0hleYXuw1tt5T7AMMkS+O+w1dI0hahdwi1WgZLnP09WzDpes
 LWoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0yC+2Nok/1vjkzmRoyIdmuMUCVZGJN7V7v4gbY9aJB72VgBHqMA2zeefHqK57SB7RWaJXluySJiKi@nongnu.org
X-Gm-Message-State: AOJu0YxMlnNIYD2cNZL25P4J0pvYWefREhTcn1tiZsl8qAzPSyfSHMlm
 ounPHYIU03ZeeISJFBujXiKqVwnJ/e9ineF0c3M/XywKk5CPqUG2wpyz73IDKRQ=
X-Gm-Gg: ASbGnctKnv6UXFI6gakZCRH9Q1C3QeNu5PsEjTtwDZPIY5cWDVPzxpCEmLEO6g8B4yS
 Ftbr4VwmRQMojizQ672YdFe3Z4HdINmvx++0LhjzacIcyxoLFNDM6G90u+lQpffegD/E07IEJUU
 HH7KcMO+S5oqOed5eKrKNicgOC31fTVll3pZ7hDID+wqGwvGKiT0yb2pPipSnbFiv1bp9WOLle7
 Q4arsk7Q9QPth1YRbV+U4o97vBsF3bEeeNsdR8aP02iWHFNXFzbmTrG2XSEWteNvAWTx5mBNdLA
 PfhEIntJTjCJKRply7FXzftr
X-Google-Smtp-Source: AGHT+IEiyQd1i/bwxWtPKEaP6lMPqTUSWwdr1mV9L2VBelHFqcRmTNtjLMBxueYcRzu5iKFLRJeEuA==
X-Received: by 2002:a05:6000:1acc:b0:382:4ab4:b3e5 with SMTP id
 ffacd0b85a97d-38bf55bbddemr3534110f8f.0.1737132119694; 
 Fri, 17 Jan 2025 08:41:59 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3288f79sm2885862f8f.100.2025.01.17.08.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 08:41:59 -0800 (PST)
Message-ID: <293b6780-17e6-4cee-a141-55022a9a75c2@linaro.org>
Date: Fri, 17 Jan 2025 17:41:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-9-philmd@linaro.org>
 <75e7805f-1ffa-421d-9415-5132131d80a7@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <75e7805f-1ffa-421d-9415-5132131d80a7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 17/1/25 09:58, Thomas Huth wrote:
> On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
>> E1000_FLAG_MAC was only used by the hw_compat_2_4[] array,
>> via the 'extra_mac_registers=off' property. We removed all
>> machines using that array, lets remove all the code around
>> E1000_FLAG_MAC.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/net/e1000.c | 63 +++++++++-----------------------------------------
>>   1 file changed, 11 insertions(+), 52 deletions(-)
>>
>> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
>> index 3d0b2277039..14d2133cd80 100644
>> --- a/hw/net/e1000.c
>> +++ b/hw/net/e1000.c
>> @@ -127,10 +127,8 @@ struct E1000State_st {
>>       QEMUTimer *flush_queue_timer;
>>   /* Compatibility flags for migration to/from qemu 1.3.0 and older */
>> -#define E1000_FLAG_MAC_BIT 2
>>   #define E1000_FLAG_TSO_BIT 3
>>   #define E1000_FLAG_VET_BIT 4
>> -#define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
>>   #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
>>   #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
>> @@ -1218,46 +1216,17 @@ enum { MAC_ACCESS_PARTIAL = 1, 
>> MAC_ACCESS_FLAG_NEEDED = 2 };
>>    * n - flag needed
>>    * p - partially implenented */
>>   static const uint8_t mac_reg_access[0x8000] = {
>> -    [IPAV]    = markflag(MAC),    [WUC]     = markflag(MAC),
>> -    [IP6AT]   = markflag(MAC),    [IP4AT]   = markflag(MAC),
>> -    [FFVT]    = markflag(MAC),    [WUPM]    = markflag(MAC),
>> -    [ECOL]    = markflag(MAC),    [MCC]     = markflag(MAC),
>> -    [DC]      = markflag(MAC),    [TNCRS]   = markflag(MAC),
>> -    [RLEC]    = markflag(MAC),    [XONRXC]  = markflag(MAC),
>> -    [XOFFTXC] = markflag(MAC),    [RFC]     = markflag(MAC),
>> -    [TSCTFC]  = markflag(MAC),    [MGTPRC]  = markflag(MAC),
>> -    [WUS]     = markflag(MAC),    [AIT]     = markflag(MAC),
>> -    [FFLT]    = markflag(MAC),    [FFMT]    = markflag(MAC),
>> -    [SCC]     = markflag(MAC),    [FCRUC]   = markflag(MAC),
>> -    [LATECOL] = markflag(MAC),    [COLC]    = markflag(MAC),
>> -    [SEQEC]   = markflag(MAC),    [CEXTERR] = markflag(MAC),
>> -    [XONTXC]  = markflag(MAC),    [XOFFRXC] = markflag(MAC),
>> -    [RJC]     = markflag(MAC),    [RNBC]    = markflag(MAC),
>> -    [MGTPDC]  = markflag(MAC),    [MGTPTC]  = markflag(MAC),
>> -    [RUC]     = markflag(MAC),    [ROC]     = markflag(MAC),
>> -    [GORCL]   = markflag(MAC),    [GORCH]   = markflag(MAC),
>> -    [GOTCL]   = markflag(MAC),    [GOTCH]   = markflag(MAC),
>> -    [BPRC]    = markflag(MAC),    [MPRC]    = markflag(MAC),
>> -    [TSCTC]   = markflag(MAC),    [PRC64]   = markflag(MAC),
>> -    [PRC127]  = markflag(MAC),    [PRC255]  = markflag(MAC),
>> -    [PRC511]  = markflag(MAC),    [PRC1023] = markflag(MAC),
>> -    [PRC1522] = markflag(MAC),    [PTC64]   = markflag(MAC),
>> -    [PTC127]  = markflag(MAC),    [PTC255]  = markflag(MAC),
>> -    [PTC511]  = markflag(MAC),    [PTC1023] = markflag(MAC),
>> -    [PTC1522] = markflag(MAC),    [MPTC]    = markflag(MAC),
>> -    [BPTC]    = markflag(MAC),
> 
> I think this is wrong. All those registers should still be marked with 
> MAC_ACCESS_FLAG_NEEDED, shouldn't they?

I followed Paolo's removal in commit fa4ec9ffda7
("e1000: remove old compatibility code"):

-    [RDTR]    = markflag(MIT),    [TADV]    = markflag(MIT),
-    [RADV]    = markflag(MIT),    [ITR]     = markflag(MIT),

Is it the same problem?

> 
>   Thomas

