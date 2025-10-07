Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A45CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 13:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v688V-0000sm-Uy; Tue, 07 Oct 2025 09:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v688T-0000rJ-Sf
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:53:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v688L-00086S-HD
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:53:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so68479565e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759845216; x=1760450016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KSu7YaNQ98fqgKApTwJFR5+NIZ1z3gREge4RWvjXBYo=;
 b=Ks48qnxYIeQBgMsx58EkDKdcJgkPFAmjVOYc2bFUVJxCW8xAaEo2zgqDe6qQLbh/ha
 jiYWGYGu9aPtXBpPMI5ZN2GxBqhlR862A+OVRxA9yOqYsf3ggM3nE/XuO9T/7yQulzbU
 JO+ACxA1//cXnnQIjxEFy4iWl3ttiuCLNMe9S/W0rDKT+nSIJ7vbl1VB/xXhdC0lpUM8
 67tTQCKAGg1gfkBMduuMLOE7xSLHzo/Lcg6qpbNVfKDWGeECAvaA1uQOC1cvPCNEK5so
 ZghfYv5x73pVedJ2802rLl+OW6onWMKrvJyCdRHV+crbf9ndwOv33+Pduv5HfG/FGIP/
 nc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759845216; x=1760450016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSu7YaNQ98fqgKApTwJFR5+NIZ1z3gREge4RWvjXBYo=;
 b=TANG/5RXWNNTeQHqt1vf5H1H7+idHnIYSUFRJll2NA5Ylut5f0pVk3kez58bQDNsSs
 m58mvoa3sPD+m9MSXwTHVcGDHlpTKrwKAqQjj9lFg+KDlAQJyqox3s+wHx5zgMOEoeTp
 y/STAvbKXmxRld3N8tx9F/5eN8Aair6KRd48Dm3ZQmC1UjE5wiNoLqqq3I+zmFMxOGIR
 bMsy8ae0pbdxG5oT1akbjYJNi78ImWJewwNLQlbGGmustmD+muUOpkx3oxJQxcT3rhSU
 kEGxplGYrXpKym3/TGQP8m2H6qmkCC9QHu0THd3RXPEnWIJd0zNKaTNwk5gADSb+V/bx
 Do4g==
X-Gm-Message-State: AOJu0YzAjKolqOMk+9WpPGZa4kimWkkvyRcDeubhViiqVWc/Bpjox+pd
 Qd47nzjXhPqn+hCsgEUE38oOjuA/x9qT9CtSqqOBUH3gPKN/7MRGQ73QRWgN5l8aj/Q=
X-Gm-Gg: ASbGncse04Q5eHvBlgcGBE/muefam0o3d+3S5W9NaR8v4QC7ta9RGTLYq5lAzwM7Z4j
 tL2LdVuMI98+qAJCx9lcYOOPFGNgH1QCHMvQ4v/BejST9CVNXNMyyKUW/6JtBcqcx8qgGBTMGAa
 qcYFLpABJckGFIYrAQiI2twdqdxh5+dVY+PRzgjzCw5Vt7p/HrEu9flvHEenMGgMG5RRVNlBc57
 hl3A7o5TtBzCoWU/c6lwkjfevtCevvJsQDZCWpsRN5HAdYI7fekWG+0EqZcbJL3hZjiOeH9fAh+
 QGTsFuFEBOP1XI6Ye2T2tg2WBa3JZnuCOyTSw1P/5e+Mbp9tvlnnIzDCS4z1tqCsf36HJui3AzJ
 Pqf6l10aGCCKkOxXKUnZmQyjnU7XUks8ndro36i4F9ltwwMV+W1d/XSxknwTgbZ9II4ahyaUp6m
 gbpvVrAWJ15PCFss8cew==
X-Google-Smtp-Source: AGHT+IEnky2yVJPGAWBDFxN4WGWRP9AzefwqPuoYNHPLT0f5ShCcXu2lf1+SKolr1wo3QdbUohJxXA==
X-Received: by 2002:a05:600c:4e92:b0:46e:448a:1235 with SMTP id
 5b1f17b1804b1-46e7110f1bemr142948205e9.16.1759845216081; 
 Tue, 07 Oct 2025 06:53:36 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa3a0d17fsm17718285e9.4.2025.10.07.06.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 06:53:35 -0700 (PDT)
Message-ID: <8a931a39-fb34-4176-b8b8-c47bd2b1d266@linaro.org>
Date: Tue, 7 Oct 2025 15:53:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/kvm: Factor kvm_cpu_synchronize_put() out
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-riscv@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20251007081616.68442-1-philmd@linaro.org>
 <20251007081616.68442-4-philmd@linaro.org>
 <20251007-650e7ef70cc4591d1ef647f1@orel>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251007-650e7ef70cc4591d1ef647f1@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 7/10/25 15:30, Andrew Jones wrote:
> On Tue, Oct 07, 2025 at 10:16:16AM +0200, Philippe Mathieu-Daudé wrote:
>> The same code is duplicated 3 times: factor a common method.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/kvm/kvm-all.c | 47 ++++++++++++++++++---------------------------
>>   1 file changed, 19 insertions(+), 28 deletions(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 9060599cd73..de79f4ca099 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2935,22 +2935,32 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
>>       }
>>   }
>>   
>> -static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
>> +static bool kvm_cpu_synchronize_put(CPUState *cpu, KvmPutState state,
>> +                                    const char *desc)
>>   {
>>       Error *err = NULL;
>> -    int ret = kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE, &err);
>> +    int ret = kvm_arch_put_registers(cpu, state, &err);
>>       if (ret) {
>>           if (err) {
>> -            error_reportf_err(err, "Restoring resisters after reset: ");
>> +            error_reportf_err(err, "Restoring resisters %s: ", desc);
>>           } else {
>> -            error_report("Failed to put registers after reset: %s",
>> +            error_report("Failed to put registers %s: %s", desc,
>>                            strerror(-ret));
>>           }
>> -        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
>> -        vm_stop(RUN_STATE_INTERNAL_ERROR);
>> +        return false;
>>       }
>>   
>>       cpu->vcpu_dirty = false;
>> +
>> +    return true;
>> +}
>> +
>> +static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
>> +{
>> +    if (kvm_cpu_synchronize_put(cpu, KVM_PUT_RESET_STATE, "after reset")) {
> 
> This should be !kvm_cpu_synchronize_put() and same comment for the other
> calls below.

Oops! Thanks :)

> 
> Thanks,
> drew


