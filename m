Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C80C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 16:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzyR-0000Ef-OE; Wed, 02 Jul 2025 12:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWzyD-00006G-8A
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:06:02 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWzy5-000800-TI
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:05:58 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-553d52cb80dso33825e87.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751472350; x=1752077150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=++JlaSGB476iK+BgtEEeb5nTuhFKc8OLvO9VwWRGmRk=;
 b=Qmvfx/uWYubhg7x90dMmTCofejZ746WIGXSAHP3aNu3DqEAu142ZP7QJX25R4i4bxB
 7tFioveOsrnsJsQICOX4jj71lUk5EbWZycpuHKaU7ZRYrt6rOp3Y3xyigjD/U0yE3A/m
 lolav2X5bmlmX4P3C0ApasTrW0g+CcApl0knqtlEfn7Y+Sr3EFUuGnuJeyZ1TAXxvh52
 kpH9pV0mAp5V6oHcTjgjpzxSCr6GDBNJrQJZwEY0Xl3M9ULnYgDYFC620QHjRO5X3xnJ
 /wptisL2NdlycXi+STTW3sBbT/+U3IoIh/NAT42D3dc41YcY4RCbvd1vvLXuuZ41l1uV
 GAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751472350; x=1752077150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=++JlaSGB476iK+BgtEEeb5nTuhFKc8OLvO9VwWRGmRk=;
 b=AG6v8FfhJnHQ+5sMmy21493jUWwEmDfdg0uDA62IZjcHqn7vlWj3illmeLU912pnYy
 83Ptu/9gX/s9tWS68PtiSX8lht+6Ym0JTNvWJfyeZM2cKBc3cRalKliqgfvZggtTbjIR
 MekFQV40REXvhWIZyyUjn2YA/TGYH+CJllFD11KX6f+B3MdkpiIyKn8ycUeztm0b83OX
 cpho7aTC8kZdyuBcdEXHzRoednW+b+3upMwQts8kceofmhMuZI+KvGuowRsx6Ll8oyI5
 v18ocnDOupWxLgsveZnlCojU8V2AAPbbCjjQ45c02UUAo3ObVZA7nwVvjs/Dh/Ax4nla
 ODCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWENar/DM6BrE+kv4WKxnKakWp66plp7gJKVqigQtLlyzSp1BB4sudK01kBBonkz3B1SKOn9ZyHaa02@nongnu.org
X-Gm-Message-State: AOJu0YxRGX6MmQJD2kthuDe4q6V0/QKpFvcXrJhFkS7P4lB2Ie7fcT+I
 9s0gCsVp8dbbJgNrvxTJcsbvIvLm3H153l3pl3q0XDZvP/2+Y975mJDybOlTTwSyG+E=
X-Gm-Gg: ASbGncs3VYx6x6y+Zh/VoVznwUeqO7Q71kZ9l3Eo3flUaRymln49sDRX59tZsQy63kZ
 l9cdd7CAC9qyh5lc7/Yw8oHJTq4Mwv9RTnQDLxgGi+ksS9tWm2nmEu6Rnmck/byUaM0fH/ZNYj9
 JqqSO300o7/xM24C/ainSwmyILSonUijyKMrXnwpGXzXSYYrsIUGeZ1E2qtfINzfTmuIYGFsobU
 88El9VfpdK807jKlUCCyD91sOXwgVGTdm3CbQMAukhb3SI89y52F1rrZAgR8x8T5BVbxXb5L07h
 N8dTjm6sw/xvEOcasjkHenzZSwMudbt7jONGOEfL68oZgBxfBzrExXxXCS62HVMNRkmhl6yXPwe
 8PZ+VY6woqQe2am9+mdT918YpRjZYt2AiZ+DOBNQcfg==
X-Google-Smtp-Source: AGHT+IGf6nPvNKTJkzNNEVhP6TSMBEeIHJvWjvKrz4MIDE0psXj0BfGYgCboFgB47z2frmb4uqADAw==
X-Received: by 2002:a05:6512:33cf:b0:552:21b9:8bae with SMTP id
 2adb3069b0e04-5562ecc542emr46732e87.7.1751472349764; 
 Wed, 02 Jul 2025 09:05:49 -0700 (PDT)
Received: from [10.138.156.213] (52.249.130.77.rev.sfr.net. [77.130.249.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcececsm1796885e9.23.2025.07.02.09.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 09:05:49 -0700 (PDT)
Message-ID: <c54eda86-0b68-4f03-86f8-d147d3dc90e2@linaro.org>
Date: Wed, 2 Jul 2025 18:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 35/68] accel/whpx: Replace @dirty field by generic
 CPUState::vcpu_dirty field
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-36-philmd@linaro.org>
 <f7170a42-74e7-4ba8-a9d5-a8d92fbde2bd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f7170a42-74e7-4ba8-a9d5-a8d92fbde2bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/7/25 17:11, Richard Henderson wrote:
> On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
>> No need for accel-specific @dirty field when we have
>> a generic one in CPUState.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/i386/whpx/whpx-all.c | 23 +++++++++++------------
>>   1 file changed, 11 insertions(+), 12 deletions(-)
> ...
>> @@ -2226,7 +2225,7 @@ int whpx_init_vcpu(CPUState *cpu)
>>       }
>>       vcpu->interruptable = true;
>> -    vcpu->dirty = true;
>> +    vcpu->vcpu_dirty = true;
> 
> cpu->vcpu_dirty

Nice catch!

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


