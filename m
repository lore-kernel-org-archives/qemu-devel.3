Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C56CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 20:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAwsB-00025C-JE; Mon, 20 Oct 2025 16:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAws9-000254-Ul
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:52:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAws7-0006Yr-53
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:52:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso2995318f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760993569; x=1761598369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3WNmbxZIg+q96mpCek2G0iZcQyZcaB8vmSJyXdqlrrI=;
 b=DAlvZ6say5KEWz0s8YYuJ3Y6FA0ByD3cwBd7ZeFMpWF42dTvSQiRhrc2xO+p3XmVpr
 hMcgpQOc/Z/Mh9JnBvTdBlpjY0tSdKVWe0v3K8B1IFu48TDxide5f9ZgpcCeInfTi7Uv
 wo2NoKXw/eXkufglmuDJRu4OOMNFTtYzfXrOS9irx16sHa3fO/6/FIjZdhzsN5gXIPvX
 oW47KMzbqeQ9LHCLCkJb0nG8a2aPG+I0Ul3a1P+Pu3h2SHXv7oUHe3nqF1W+tD5noeTE
 dG3FSCv+BHhLCKz1Hisl0OzGqh34inHXbkCUuZKiaqsF3Hm3hfcVMG9oRhDUT7CAo06U
 EVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760993569; x=1761598369;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3WNmbxZIg+q96mpCek2G0iZcQyZcaB8vmSJyXdqlrrI=;
 b=WGPtLwEmehg7CtKq2ruJBJpyEmiB7mIiqOsT/wgxJP+F+J7PXyJLJSbYzfmG6dPU//
 WpgO8Im4A4U2IKzcek3QHsUljNTQP1xn03PBOX88YNpHC/W4DXFYVegygNOg4LU+7gC9
 MpNqV7qQHM6aOfcnQ8gT1wOJCMcuWc9AawjoeF+rL7a4r4tQgDW3Jg7Rlen7Dzz9XYsS
 IrPuRGJKFiaDuf5hL7ZDxawpJJluxI7zC2VPzAzcpEa4Ge8q4WkM3Hm4tZfkjPUsTGVC
 KkgpdJlrT8/U8mc0wMLaIwKzHoUTptqcQdH+1eO05RKgkoGYDRLEo2V3iLnLTgUlNbYf
 GLnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzIlblwzl91dephwofykTRjJAph0CutQMoY6apnk1VFFsSo3kzyKExIx+NyoFrP+YVcw8m8QEeE5GK@nongnu.org
X-Gm-Message-State: AOJu0YzfvY+WA3uYbKG6ZpJxzyh2S24zuZjYTCPpObAUvNFDQtIZdoD9
 vwN4sjk8eTG5qeVmD0YwQz6l1+U5H2vIOXUmeGYOPyX6lfG6Nv+gXC5aqzvxjgJtg/A=
X-Gm-Gg: ASbGncsFijKhX9OmTPnrQlC3zy8ZEgq3IDsr6UVlvop9Mzj/2CJqTGbdnakJWS2FphW
 IPJ+P6L4AOxlIfkYGV3Cl7zkkoY4EgDZcMM9SNvA9tEtQBeKNhyjNF5Ap0xKV9q59fE87NrjIeU
 h3qfQ26QeXnARIgX8Nbm8xFq46cAQ63emwN9JZc4g9M4E6qMvMq+6T7kMih46nWO+d3PTSKzYh9
 7M5ScYbm6qPnwju8gv/iHEK7kR6E6IFA7ROGYRbxoze34mlGFWY69AmFJ8g+bLOGW9tAXskKB0M
 MD9nJjlN2kKVCiepfF9yLVSPXuc7Ph9Td7pSUsvtK9A8RwUcs+uXDXz5kpimHxK8QX8IgWre/Uy
 tI/SXCb1BD0P1LA5mKD4UlCqTNGGdWVjzPa0PLHvK2Wa2yO2IRErf7H+fPMrcsgNPrsyPboJ/ql
 dWlS6U43P+FvDTD6JptKgUODUd0/N8yVSVi6su+V6afa2UWF+K0gJo3g==
X-Google-Smtp-Source: AGHT+IFJOeFiJGdMRc9Z+yJUsROS64JqkJ2mKB9qcjeFEdwUKC6HbxwKwjGJQ96xhM3dV8AZrflKbA==
X-Received: by 2002:a05:6000:220c:b0:3de:b99d:d43 with SMTP id
 ffacd0b85a97d-42704da613emr9341650f8f.19.1760993568680; 
 Mon, 20 Oct 2025 13:52:48 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce06bsm16628429f8f.45.2025.10.20.13.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 13:52:47 -0700 (PDT)
Message-ID: <dd6eca59-436a-49bc-86f2-d7eb784e05fe@linaro.org>
Date: Mon, 20 Oct 2025 22:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 12/19] hw/arm/virt: Register valid CPU types
 dynamically
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-13-philmd@linaro.org>
 <62c23632-b498-4fe9-b337-294b0fe4cec4@linaro.org>
 <4e83559d-bbac-414c-a71f-076e038db772@linaro.org>
In-Reply-To: <4e83559d-bbac-414c-a71f-076e038db772@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 22/4/25 20:18, Philippe Mathieu-Daudé wrote:
> On 22/4/25 19:56, Richard Henderson wrote:
>> On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
>>> +#ifdef CONFIG_TCG
>>> +        vct = g_slist_prepend(vct, 
>>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
>>> +        vct = g_slist_prepend(vct, 
>>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
>>> +#ifdef TARGET_AARCH64
>>> +        vct = g_slist_prepend(vct, 
>>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
>>> +        vct = g_slist_prepend(vct, 
>>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
>>> +        vct = g_slist_prepend(vct, 
>>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
>>> +        vct = g_slist_prepend(vct, 
>>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a76")));
>>> +        vct = g_slist_prepend(vct, 
>>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a710")));
>>> +        vct = g_slist_prepend(vct, 
>>> g_strdup(ARM_CPU_TYPE_NAME("a64fx")));
>>> +        vct = g_slist_prepend(vct, 
>>> g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
>>> +        vct = g_slist_prepend(vct, 
>>> g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
>>> +        vct = g_slist_prepend(vct, 
>>> g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
>>> +#endif /* TARGET_AARCH64 */
>>
>> Why do these need to be strdup'ed?
> 
> g_slist_prepend() expects non-const.
> 
>>
>> Do you anticipate other instances where these names cannot be 
>> constructed at compile-time?

In a few patches this become a run-time check:

   if (target_aarch64()) {
     ...
   }

I'll keep as it for now but am opened to simplify on a following up
patch.

