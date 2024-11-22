Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA41CE6918E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 19:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEZ9j-0002Jt-NL; Fri, 22 Nov 2024 14:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEZ9h-0002IE-TZ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 14:17:25 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEZ9f-00087E-Lc
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 14:17:25 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2969ae2c99fso1531720fac.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 11:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732303041; x=1732907841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XZk9cjMHDdKEVSn/umzrOvbjeL8TRpKLbhdropNJY54=;
 b=XRwg8SOObd5/BcF7nLJYm5ujBK/SAFYhmmw+4cpsy4iyukxObo9VbwaHbrqwZxpm2s
 8KCtWpHTLKLuIAlZL1lor1joRZpkvpqMqI8xSpRthnUGGxyMMlRh+20vVojdbVlmKdZS
 7nnNLxj6288X86RZ4yaDW/FxgW+PSks/dwDzz8l8Lt9RufRvFMHGgc5o8zr96T3JXNCo
 LPks7FJx5ftXJaSFGwmp36W+NVyxc4KQdHJTvag35kl0bxtoisBBFUaWdSDQwiBmqT5R
 SMcaVu1IkzXoUatsU81oLcMbtorr2ax1hnl4zZLguqVYFb7kTxBauXHNeKCPTouRl6G3
 8hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732303041; x=1732907841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XZk9cjMHDdKEVSn/umzrOvbjeL8TRpKLbhdropNJY54=;
 b=EPcgZbDpQPSuKhLXaAB3Hxvi55PVoeJTk0g01Xm/tILO6MxIihbjLqb3xfbWBRd3pV
 78Scs4iaoqbJfEU6alA1ycM5UkkBU6KY1gMCZdWlR9wj7tDpJf+LNIl9EzZqZdm+ghJc
 RQJmzQ/CVhaAxSSm5mmyMOtrSZxRv0Qd/Oiukg80q8jk4EDjmfFsX4QWjNWAjDUxfkOE
 leDxJ9CkVFVVd+rO02WFGqKVpB1XavT9XFLWK8aYvUEwd6uVSK6zYHrnRFIoE1lbDmBt
 +dNPMYP1Ijo7PU2kbAcNblNJy6PBmJOhyWLTe2cQeDB3/+A/fB2H76BTmBuU36l+aGCL
 FYbQ==
X-Gm-Message-State: AOJu0Yy3/Lb6wvXIQz4qDL6pH+gLMLn6wNhle6KN5OKYYTaiA9WMjr+f
 4kzHmW/whIWI2FxOw8nmTeSFV/iJbTrpVT2B8so2jkt87Lyf+MdKQnkoHfcmnZmIP4pvRePlWH+
 up0Y=
X-Gm-Gg: ASbGnctGs1kyUbtu21Hh6fSOLP0NbVyuU+RNzXycCXicfCGTB7ia9ci5JcCqRnSYlQN
 8FZHkc2oPpneM0Dl3hrx9tyLX0dfAzUTAbOZOy1/QPc/qh7BYlFlrpuJzmfHYgZQ4/3lDGBTi/y
 4CM265m6Ee+gL4r2Hu6i/yYY9cJWNeOM43x6ZXSE2xKZkBFGBF/Ml0m3Y6XAE8+J4mdvGpC7mZl
 Kd6YOuAlzSGFnRIoPI2FDt+scYeRxf2evujTIbxLirp+t07B05p9HD0JoJTGgt7Og==
X-Google-Smtp-Source: AGHT+IH/dYJHZffrqNXeGriz2TVIXgb5MHRRA/OPAPgB3t8RU313QK6/NM9cnY46/Eqck2CAx8c0aA==
X-Received: by 2002:a05:6870:40ca:b0:270:1884:9db1 with SMTP id
 586e51a60fabf-29720af286fmr4728908fac.7.1732303041264; 
 Fri, 22 Nov 2024 11:17:21 -0800 (PST)
Received: from [10.25.2.124] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d88f849sm758655fac.49.2024.11.22.11.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 11:17:20 -0800 (PST)
Message-ID: <c0e086a3-a7dd-426c-8d1e-044c937d6358@linaro.org>
Date: Fri, 22 Nov 2024 13:17:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpu: Initialize nr_cores and nr_threads in
 cpu_common_initfn()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>
References: <20241108070609.3653085-2-xiaoyao.li@intel.com>
 <20241122160317.4070177-1-xiaoyao.li@intel.com>
 <dc286a4a-1885-4457-a248-846c16d847fa@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <dc286a4a-1885-4457-a248-846c16d847fa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 11/22/24 11:26, Philippe Mathieu-Daudé wrote:
> On 22/11/24 17:03, Xiaoyao Li wrote:
>> Currently cpu->nr_cores and cpu->nr_threads are initialized in
>> qemu_init_vcpu(), which is called a bit late in *cpu_realizefn() for
>> each ARCHes.
>>
>> x86 arch would like to use nr_cores and nr_threads earlier in its
>> realizefn(). To serve this purpose, initialize nr_cores and nr_threads
>> in cpu_common_initfn(), which is earlier than *cpu_realizefn().
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   hw/core/cpu-common.c | 10 +++++++++-
>>   system/cpus.c        |  4 ----
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
>> index 09c79035949b..6de92ed854bc 100644
>> --- a/hw/core/cpu-common.c
>> +++ b/hw/core/cpu-common.c
>> @@ -237,14 +237,22 @@ static void cpu_common_unrealizefn(DeviceState *dev)
>>   static void cpu_common_initfn(Object *obj)
>>   {
>>       CPUState *cpu = CPU(obj);
>> +    Object *machine = qdev_get_machine();
>> +    MachineState *ms;
>>       gdb_init_cpu(cpu);
>>       cpu->cpu_index = UNASSIGNED_CPU_INDEX;
>>       cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
>>       /* user-mode doesn't have configurable SMP topology */
>> -    /* the default value is changed by qemu_init_vcpu() for system-mode */
>>       cpu->nr_cores = 1;
>>       cpu->nr_threads = 1;
>> +#ifndef CONFIG_USER_ONLY
> 
> Is CONFIG_USER_ONLY available in an common_ss[] object? I don't recall.

No.


r~


