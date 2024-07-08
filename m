Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6203BC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 05:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQgxM-0000g6-3h; Mon, 08 Jul 2024 01:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQgxE-0000cm-CT
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:30:24 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQgxC-0003Th-Ih
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:30:24 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3679e9bfb08so1951601f8f.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 22:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1720416621; x=1721021421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MdxhzsEahdwu6Vr8VLJzv6yiEh6/xuSTCWcfQqzOv0Q=;
 b=F43ucfw8BkaNIvC5UVJ9kru3CnjkHR6jqtarOXlF4PBm5fCYdOe3lWhVnhK0H95rzb
 b0R1Is5ZMhtjx7jxDrreVWlkUeNkbcOaIZreFuOS1DNXocCRka3QMr5e42NzGwfpvQMG
 H2lU0DxnDRAu1WayYMz/P6Vwd/7jaeSLpE6N9ccY7iVZGOwvoXw3vDzDQT53LyzBRRbh
 THaDrneECTPuzoOYPSVbLmIaTiAaBEhISVGbtazGXGUs7FWmXkF7u/UspScK9TsUXG7h
 8Z2rC6RvlwETKnNOSWkmA+McTHdD3un0jwu5ZH6FwZ/nPbcLwiDNGPo4OxaD4epl7btO
 2ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720416621; x=1721021421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MdxhzsEahdwu6Vr8VLJzv6yiEh6/xuSTCWcfQqzOv0Q=;
 b=pWgfAMQzaE/27SqTFq/cV/7Y4Nv9w8Mofy+uAW9UF5ScHjOrKZvXAtmfhje/nqqMg6
 ssTtMWULTUZyUyaFTMfXZIQjXqhL/FOZBsS887xg/u0sUqiHfGMqqkT1Wp9HZ2oKxJNJ
 j0E0ahm+3aHUIJlT7OWljxFvNSq9BPSoyuh2OUKCGsP9Q13RvUn4VHMixeSzuPPmNgy5
 EchDCJBoktoFfY86nctRvJJ2c5QD2ajFCrthtLSftxMgYeq2bX7YB6Dz3+eaheTT0Fop
 Eb9GTQ4IEkT75VVCwYP23GGRbbbmh+3IcegUlIsVxI6u4D58jX28qp+0XZA60lV5qvsS
 HlXQ==
X-Gm-Message-State: AOJu0YzPRseVPEzkdH6W660o4MbZnmjVfaqd2M3Ya2JwqZsM6PvWr9Xn
 colMsILNGMbjbUm+XNe+JdzzU1JDUQQxaJkF1pHwkEpEg6kwekh1fT1bmlw+Zjs=
X-Google-Smtp-Source: AGHT+IG59JCNKzPFGsDzMrrMonk2Q6S5KMxRwaYS3ffEEeQj4iJ+uAPtRRk45K6F4a7fbMQWGhc7fg==
X-Received: by 2002:adf:ef89:0:b0:367:9268:bfca with SMTP id
 ffacd0b85a97d-3679f75c4famr9360109f8f.22.1720416620962; 
 Sun, 07 Jul 2024 22:30:20 -0700 (PDT)
Received: from [10.11.12.72] ([90.220.10.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-426623153f9sm63051685e9.29.2024.07.07.22.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 22:30:20 -0700 (PDT)
Message-ID: <9d1b4caa-6886-4dde-8941-f62bdf4a562b@opnsrc.net>
Date: Mon, 8 Jul 2024 05:30:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 7/8] gdbstub: Add helper function to unregister GDB
 register space
To: Igor Mammedov <imammedo@redhat.com>, Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, oliver.upton@linux.dev,
 pbonzini@redhat.com, mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Shaoqin Huang <shahuang@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-8-salil.mehta@huawei.com>
 <20240706164103.16662dd2@imammedo.users.ipa.redhat.com>
Content-Language: en-GB
From: Salil Mehta <salil.mehta@opnsrc.net>
In-Reply-To: <20240706164103.16662dd2@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x42f.google.com
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

Hi Igor,

On 06/07/2024 14:41, Igor Mammedov wrote:
> On Fri, 7 Jun 2024 12:56:48 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
>> Add common function to help unregister the GDB register space. This shall be
>> done in context to the CPU unrealization.
>>
>> Note: These are common functions exported to arch specific code. For example,
>> for ARM this code is being referred in associated arch specific patch-set:
>>
>> Link: https://lore.kernel.org/qemu-devel/20230926103654.34424-1-salil.mehta@huawei.com/
>>
>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Xianglai Li <lixianglai@loongson.cn>
>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>> Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>> Tested-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   gdbstub/gdbstub.c      | 13 +++++++++++++
>>   hw/core/cpu-common.c   |  1 -
>>   include/exec/gdbstub.h |  6 ++++++
>>   3 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index b3574997ea..1949b09240 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -617,6 +617,19 @@ void gdb_register_coprocessor(CPUState *cpu,
>>       }
>>   }
>>   
>> +void gdb_unregister_coprocessor_all(CPUState *cpu)
>> +{
>> +    /*
>> +     * Safe to nuke everything. GDBRegisterState::xml is static const char so
>> +     * it won't be freed
>> +     */
>> +    g_array_free(cpu->gdb_regs, true);
>> +
>> +    cpu->gdb_regs = NULL;
>> +    cpu->gdb_num_regs = 0;
>> +    cpu->gdb_num_g_regs = 0;
>> +}
>> +
>>   static void gdb_process_breakpoint_remove_all(GDBProcess *p)
>>   {
>>       CPUState *cpu = gdb_get_first_cpu_in_process(p);
>> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
>> index 0f0a247f56..e5140b4bc1 100644
>> --- a/hw/core/cpu-common.c
>> +++ b/hw/core/cpu-common.c
>> @@ -274,7 +274,6 @@ static void cpu_common_finalize(Object *obj)
>>   {
>>       CPUState *cpu = CPU(obj);
>>   
>> -    g_array_free(cpu->gdb_regs, TRUE);
> so free() is gone but new  gdb_unregister_coprocessor_all() ain't called,
> are we staring to leak some memory here?

Ah, sorry yes for other architectures. Maybe I can put below check

and keep the free'ing code?

+     if (cpu->gdb_regs)

+ g_array_free(cpu->gdb_regs, TRUE);


Thanks, Salil.

>>       qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
>>       qemu_mutex_destroy(&cpu->work_mutex);
>>   }
>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>> index eb14b91139..249d4d4bc8 100644
>> --- a/include/exec/gdbstub.h
>> +++ b/include/exec/gdbstub.h
>> @@ -49,6 +49,12 @@ void gdb_register_coprocessor(CPUState *cpu,
>>                                 gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
>>                                 const GDBFeature *feature, int g_pos);
>>   
>> +/**
>> + * gdb_unregister_coprocessor_all() - unregisters supplemental set of registers
>> + * @cpu - the CPU associated with registers
>> + */
>> +void gdb_unregister_coprocessor_all(CPUState *cpu);
>> +
>>   /**
>>    * gdbserver_start: start the gdb server
>>    * @port_or_device: connection spec for gdb

