Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E436CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 06:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v21iv-00067Y-7O; Fri, 26 Sep 2025 02:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v21is-00066v-KA
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 02:14:26 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v21ih-0006UZ-UR
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 02:14:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so14152015e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758867249; x=1759472049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yDJTbOrwHvQqZhukxd9VCTKtPzB3Dkw/D/4a3mZK6Fw=;
 b=WW59yZN4QoQvc6DcqwZGq8gz/rek9Pm+wuT78jKGsM1lWR5FfJ3M7KsX0t/ncr5dPB
 ePyH31yEQxW3kCA7No628uFOn/H35BX/+OvFlakdlWj+0QKltqpQoJG2u6103GilFfj+
 s52tDezP3zT4t+SF2walgH0jlEoF5U+kMdP8pa/cDpRzEKnZj/PaMSSQeII/Cf0wSoJv
 QqqtdxVsAcR5oP23XJJcvkOBM6EgmdOZSOyosFCcc+LaHMYRbBM4MNAdzygthPW1Bqzk
 VGsSsLcgLU925t/OfW+PGWBcf3eqjMm0iWvPG64dVNlxAgtrZUPxgDm4XvKQllBRXxf8
 Foyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758867249; x=1759472049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yDJTbOrwHvQqZhukxd9VCTKtPzB3Dkw/D/4a3mZK6Fw=;
 b=YFl0KseaYaJHOjGScxcp1Ii++QWfMwN/bPyvylCPevwOe1HBmfD/oxwDYP72TM7DCW
 pW1Zsb4xOLfUoYti/S4c243bikg7nODtPfxqnomLNxvMJu2cGhCdYHRLS5/OpMMPP2DU
 4Fk+Va/KK5pqDxlvZlPhJAigFAbVoBxVLjfDW541ZU6A9RNf1Fq7zQlj3Yp2R6mXrEPo
 LNtzIhKVp2ilSaCP0rfFtyXlTJ+iQ4xPND24iBr6epYeAn7K3ZCwKwjq3EfXFLXJKltL
 YqDZDpRgFTGoqxtvODHBbHJCIpWqj8ZaPwc3nH6VdVMuEw1Uv1HDeMg8uEraW9HSHnwZ
 PvQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLehGYCRHDay67psbgdXdWSCiyQIwTIMavSfk0iJzrp4nPzU/AR5ml1sRUpshd58+ykWHUkdYv0XdZ@nongnu.org
X-Gm-Message-State: AOJu0YyvV5ATgbUwzwl9H7nVk+Qm94svWz6TqLb1hfmo/6NoetTd3MBN
 HpLm2xaRYz6ALHXKPKVdT2bTq7BdYan74d4v0L1UTaUacYUKvFUSxAWt9PaJY/VviGI=
X-Gm-Gg: ASbGncuzbQS50VUM8qBkgmjZaIoBdBqGNa+/PSzjTzJbhQi8rAYXP3Fw+1AzmZAhBKJ
 fSSMLEeq3GSmbjsdKoWj2+V6G1bUguiMi9ccXDW20qkjgQI50EAgVsbje9XRf5Ew/KE8XXbtSjO
 XBXll+HsNxBDXQrkXSfy7RdLDEN/zjlQtLeCxVcHHR1XwnauW3GoYBEbKKTgwIui9GKJa0zMofk
 1y+hyv/8HZwTHyxv3mF8PInAdgOwLAfTX20fk84Pb1ksEjkOBfMaZotSc5ZhfH7YnnAH9izd5u/
 q9HoA/5CcdWB6QQMzg2l88hfGIgZ3sTqk43q8HNpb51qnyW9WbGYWmKEIEnTDxeNXZzxizHa0I1
 Mxx3ytP3ardfpmiua/FpxI3DjobrIjZluBCZFCROoxHgGGsubqZ2t7DUkqj6AW9nTdA==
X-Google-Smtp-Source: AGHT+IF550NXqK1/R/OjiqxmKrxlyay0BjveFareF25YTuVFxlifwaXX04yT+nySli2CvdlI3Kjl/g==
X-Received: by 2002:a05:600c:3b8e:b0:45f:2cf9:c236 with SMTP id
 5b1f17b1804b1-46e329d4744mr71031135e9.4.1758867249275; 
 Thu, 25 Sep 2025 23:14:09 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9d26ef7sm5865395f8f.26.2025.09.25.23.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 23:14:08 -0700 (PDT)
Message-ID: <98d7c011-93e2-4c49-aebd-8591b5dc734c@linaro.org>
Date: Fri, 26 Sep 2025 08:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-2-djordje.todorovic@htecgroup.com>
 <5f0fb254-fa9c-4e29-a848-6e9b3bc8274d@linaro.org>
 <046d60ed-aa62-4357-a812-721de3412573@htecgroup.com>
 <ca5816d3-a0e7-4460-aead-8f0dbcb4bc92@linaro.org>
 <4d1e75d9-13b1-4fb8-b1f9-4917dbfb2415@htecgroup.com>
 <0a27b044-e7c2-4621-a2ad-e028d5ef31ec@linaro.org>
 <0c8036d4-9599-4249-bb20-76e35b970477@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0c8036d4-9599-4249-bb20-76e35b970477@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 24/9/25 10:00, Djordje Todorovic wrote:
> 
> On 22. 9. 25. 08:52, Philippe Mathieu-Daudé wrote:
>> CAUTION: This email originated from outside of the organization. Do
>> not click links or open attachments unless you recognize the sender
>> and know the content is safe.
>>
>>
>> On 3/9/25 14:35, Djordje Todorovic wrote:
>>>
>>> On 1. 9. 25. 13:05, Philippe Mathieu-Daudé wrote:
>>>> CAUTION: This email originated from outside of the organization. Do
>>>> not click links or open attachments unless you recognize the sender
>>>> and know the content is safe.
>>>>
>>>>
>>>> On 1/9/25 10:17, Djordje Todorovic wrote:
>>>>> On 8. 8. 25. 17:52, Philippe Mathieu-Daudé wrote:
>>>>>
>>>>>> CAUTION: This email originated from outside of the organization. Do
>>>>>> not click links or open attachments unless you recognize the sender
>>>>>> and know the content is safe.
>>>>>>
>>>>>>
>>>>>> On 17/7/25 11:38, Djordje Todorovic wrote:
>>>>>>> This is needed for riscv based CPUs by MIPS since those may have
>>>>>>> sparse hart-ID layouts. ACLINT and APLIC still assume a dense
>>>>>>> range, and if a hart is missing, this causes NULL derefs.
>>>>>>>
>>>>>>> Signed-off-by: Chao-ying Fu <cfu@mips.com>
>>>>>>> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>>>>>>> ---
>>>>>>>      hw/intc/riscv_aclint.c | 21 +++++++++++++++++++--
>>>>>>>      hw/intc/riscv_aplic.c  | 11 ++++++++---
>>>>>>>      2 files changed, 27 insertions(+), 5 deletions(-)


>>> +    CPU_FOREACH(cpu) {
>>> +      if (cpu == NULL)
>>> +        abort();
>>
>> Why do you end having a NULL vcpu in the global cpus_queue?
>> (this is the 'elsewhere problem').
>>
> Well, it is true, for our case, we would never get into vcpu == NULL case.
> 
> 
> After several attempts to come up with a better solution for this, I think
> 
> we are back to the existing one. I will try to elaborate why.
> 
> The sparse hart-ID layout in this case is not a programming mistake but
> 
> an intentional hardware design characteristic of the P8700. The P8700
> 
> RISC-V implementation has a sparse hart-ID layout where not all hart IDs
> 
> in a range are populated. This is explicitly supported by the RISC-V APLIC
> 
> specification. The current ACLINT/APLIC implementation assumes a dense
> 
> range of hart IDs (from hartid_base to hartid_base + num_harts - 1).
> 
> For the P8700 board:
> 
>     - We iterate through the theoretical hart ID range for a cluster
> 
>     - Some hart IDs legitimately don't have corresponding CPUs (sparse
> layout)
> 
>     - We need to skip these without failing
> 
> The CPU_FOREACH approach doesn't work here because:
> 
>     - The cpu==NULL will never happen
> 
>     - It iterates over all CPUs system-wide, not just those in the current
> 
>       cluster

Correct, we simply need to iterate over the CPUs in the cluster, which
IFAICT this device model doesn't use (TYPE_CPU_CLUSTER).


