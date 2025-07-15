Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BF2C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbL8-0001li-Ol; Tue, 15 Jul 2025 04:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubbL1-0001hu-TT
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:48:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubbKz-0006uU-QT
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:48:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so11443755e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752569311; x=1753174111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RI9nY/lbAzUd7Ka04c4vLAtvymCMVs4BVmdt38+Im80=;
 b=oTIMwIxDahCLhI5N7IxcuTivl8NPtb3l1UNOO3mpKgUbX1VdoYJZHMuESBmL+y4ON3
 dcge0jgfl8sBaLIBG/kTL9W/NqM2l+cOMXoCAUIJznQJtTc96/BkhytDpEF5UmHetuL8
 sjJfR+53TGyBrISBBJ9UJpaXw1Az5imJPS0T3KPu+K708VlQEmMgFtF4wtMe3BROPsdn
 dD0r+DKPW93AQ+NWlkfy9X9u0pX4+HAVcWF2ffcb1L/b/3ZU3uQLe3WPZBsP5lZKjffO
 VPlzdVLTf/EInoQjPtobd9eA4bGtGBDJDmxs2K8ESV5AAnxzOsl2aMjVWEk7+PvRVnWS
 1UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752569311; x=1753174111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RI9nY/lbAzUd7Ka04c4vLAtvymCMVs4BVmdt38+Im80=;
 b=ISsj5LGfGQzifjx1syRQNNTeM1cYxbAJcjnyw96eVUf8cuJ9A4ZnsMCnbDJvGjo5DH
 qr6Ftbiua5IJLlDY+pcKqlvxqy2W67fwAsCqRTE/zCdmD2B51yJJipZrBuT4FcJ/CxQd
 nQNnm8qNQz8myhg5auJQIfjh1nJmWKPN2CSE3+flyuC65OY+ZvdoiQxBrQcQXFourKq5
 KxGVICkN3gCJK04SLz8tsFk15aVUipgfdttX8SLGe+4utGK0mrc73oQbmqn4Ei8iFebM
 F040MtcMj4IJATFPwnrM6tGr7QXwayUuaKXuqnV/TdfTvuZ53h8FMDKn2Pc6vei/cuQT
 gEbg==
X-Gm-Message-State: AOJu0YyWm557JNas4hzfWohikKTzwjNqwEpupCkZ58d8BBEsJUNEg6id
 yxcQrJO+HyVDMcQyurHX4DhsB8RZokODVIe9MHwScKf4ngIM5tGt0lP0Vkjoenez3As=
X-Gm-Gg: ASbGncvIt89jtD1CGng2gJHN27Vdbz0r83Al4cZbSB7b/PLaNUOHa1Nh0w7UREwN9Xx
 BUIvWk52doOLB/oeiA+yyFczsu3gtMRJk+WkMX2UZlTX0pomhXxbdZaG8Lh8gFt8OJszFDKjeR7
 g08gSLir+/0TbZVQRNZA3uSbeA810/gNdAOvOiJLnoQ6os+RTwfc1BD7niWGa+C2nvkvD/2zZHk
 zzQ4dY5GSJb5d6CjiE3YfYMzOitMgWTCCAjYEHa+NwKHnODxvntUWC7xN8y4qbBNRDDm9piX0zP
 NyZ2wLwnQdkWHI5wU5dYe4MbEAjBB5ELXfqKTDokZQRkKPs4+/FbzpVsu4HetiEy6UVCNYOJxCP
 ojMCYOUuAMZGHPrCh550b9jVRIdOz//w3qN8fEkp4j+RGrJHHgWG1whoBUptS9AWGMe/AGWI=
X-Google-Smtp-Source: AGHT+IHU4fqyyeI5Gqf+uafFpjYA0CgPuYZTxAT/kbb0+AzPpc+qoFsfD5nvt4S9uD5jdKKYzleyZQ==
X-Received: by 2002:a05:6000:23c8:b0:3a5:2b75:56cc with SMTP id
 ffacd0b85a97d-3b5f1895be6mr9264467f8f.23.1752569311234; 
 Tue, 15 Jul 2025 01:48:31 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0dc3esm14402137f8f.47.2025.07.15.01.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 01:48:30 -0700 (PDT)
Message-ID: <5f1fbfe7-d990-484f-825a-64af2781ac3c@linaro.org>
Date: Tue, 15 Jul 2025 10:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/39] hw/core/machine: Display CPU model name in 'info
 cpus' command
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-2-philmd@linaro.org> <87zfdksg8j.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87zfdksg8j.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 4/7/25 06:59, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Display the CPU model in 'info cpus'. Example before:
>>
>>   $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>>   QEMU 10.0.0 monitor - type 'help' for more information
>>   (qemu) info cpus
>>   * CPU #0: thread_id=42924
>>     CPU #1: thread_id=42924
>>     CPU #2: thread_id=42924
>>     CPU #3: thread_id=42924
>>   (qemu) q
>>
>> and after:
>>
>>   $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>>   QEMU 10.0.50 monitor - type 'help' for more information
>>   (qemu) info cpus
>>   * CPU #0: thread_id=42916 (cortex-a72)
>>     CPU #1: thread_id=42916 (cortex-a72)
>>     CPU #2: thread_id=42916 (cortex-r5f)
>>     CPU #3: thread_id=42916 (cortex-r5f)
>>   (qemu)
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Tested-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   qapi/machine.json          | 3 +++
>>   hw/core/machine-hmp-cmds.c | 3 ++-
>>   hw/core/machine-qmp-cmds.c | 1 +
>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 0650b8de71a..d5bbb5e367e 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -80,6 +80,8 @@
>>   #
>>   # @thread-id: ID of the underlying host thread
>>   #
>> +# @model: CPU model name (since 10.1)
>> +#
>>   # @props: properties associated with a virtual CPU, e.g. the socket id
>>   #
>>   # @target: the QEMU system emulation target, which determines which
>> @@ -91,6 +93,7 @@
>>     'base'          : { 'cpu-index'    : 'int',
>>                         'qom-path'     : 'str',
>>                         'thread-id'    : 'int',
>> +                      'model'        : 'str',
>>                         '*props'       : 'CpuInstanceProperties',
>>                         'target'       : 'SysEmuTarget' },
>>     'discriminator' : 'target',
>> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
>> index c6325cdcaaa..65eeb5e9cc2 100644
>> --- a/hw/core/machine-hmp-cmds.c
>> +++ b/hw/core/machine-hmp-cmds.c
>> @@ -40,7 +40,8 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>>   
>>           monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
>>                          cpu->value->cpu_index);
>> -        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
>> +        monitor_printf(mon, " thread_id=%" PRId64 " (%s)\n",
>> +                       cpu->value->thread_id, cpu->value->model);
>>       }
>>   
>>       qapi_free_CpuInfoFastList(cpu_list);
>> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
>> index d82043e1c68..ab4fd1ec08a 100644
>> --- a/hw/core/machine-qmp-cmds.c
>> +++ b/hw/core/machine-qmp-cmds.c
>> @@ -47,6 +47,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>>           value->cpu_index = cpu->cpu_index;
>>           value->qom_path = object_get_canonical_path(OBJECT(cpu));
>>           value->thread_id = cpu->thread_id;
>> +        value->model = cpu_model_from_type(object_get_typename(OBJECT(cpu)));
>>   
>>           if (mc->cpu_index_to_instance_props) {
>>               CpuInstanceProperties *props;
> 
> Does the conversion from CPU type name to model name lose information?

Likely.

> If yes, should we provide the type name at least in QMP?

OK.

> Let me also try a different angle...  what's the preferred thing for
> users of HMP and for users of QMP, CPU model name or CPU type name?
> 
> Are there any commands that accept one, but not the other?

Likely. In particular the CLI expect model names for '-cpu',
except when created as '-device' were the type name is expected...

> Are there other commands that return one, but not the other?

QMP commands usually return the QOM type name, not the model.


IMHO the external interface should be the CPU model name. Keeping it
simple, an example could be "max".

The internal interface (QOM type name) is used to compose the QOM model.
Some types end verbose, such "riscv64-max-tcg". I expect such
information to be more relevant to an experimented QEMU developer or in
a bug report rather than exposed to the users.

Anyway, I'll respin using type name for QMP and model name for HMP.

Thanks,

Phil.


