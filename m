Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3074C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 07:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwzIm-0005qf-OG; Wed, 17 Apr 2024 03:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwzIk-0005oV-BA
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 03:01:50 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwzIf-0001tP-Jy
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 03:01:50 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a52582ecde4so389579566b.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 00:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713337304; x=1713942104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q185Mi2GDcExVNPwt8nwZd8oAJP5tllgdeKcNyAtXPc=;
 b=zOqSKpsnThfsnUHTaeTyOs15XLxZc6uvyaGmn34f6+VFs0XcZbFECm0qzdfKik04SV
 +MPw/zCNNAFWTjsGGraVfsiqH2bx51he6XfgnK6QD23Qw/4cSdWhKA+aJe9dZukgJfqs
 8UCYiJIvIarmlIoqBueRbXz40tjud31xJuIx/3D2+E+E3DiND2O71/RawsVIYxCGQaAw
 KNQl3opPbteGP/wMaAyAcGr6xMzw2zn43xeb8tB23fb6+tjiZXO122/v6c9X0v8jgZ7c
 tLGwhC45wCFFi7KTbP7ZZFBHI4vxxsOycbXBVwR5C6SAiJ3FBMbiJZqsUB0ssBbL5DnN
 7RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713337304; x=1713942104;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q185Mi2GDcExVNPwt8nwZd8oAJP5tllgdeKcNyAtXPc=;
 b=Zz8FzHBuZaLyZiXiKRZWJDQ9B5x8IcAe/PLUqpheZk8F7C68WzpcrbZ48DbhpG08ql
 b9VgNg6gxkIqBfQSpUV8fqX3Uh9gY/q2wQmvp5XHCDfiSrLCrP8QuswSpwh6BlpxgXqn
 lJB48QiSyxm6W8425stTs3hKyFvzlkxbksGWk8A7cE/x/pLPpzZE9c7Tp1limBtP8oN2
 Aw7bIvq2xRRlWoAXpU+UyLdIfR4/aWy9l7bM6xMkJNSqwx3gbhITTvSWC8LF7wkjS7l8
 svoWfhow9Eb8Wfj4m1zWSO4qD43RSPMWJjglgzZj8757ZdMVbUFhvKeAQ3Ad21BZyiRp
 VriQ==
X-Gm-Message-State: AOJu0YwZ+IuHLa53tukMTL8vRNOpzVMs7c70Du+Lbzi/xJNuFmTnmnIf
 oHjG6AoTbj2lTuPvzucDGFoFOkFVgHZml5xwHJvFtppr3IL7r7v0gKGsDrloq1BhH6qC3bMiwOC
 i
X-Google-Smtp-Source: AGHT+IFM/8sEw+qRxzKGJPltvkAP23hVbPNqg6uHTxhOtj+72qoNhBIgg3ga0azHbkZQkuozIKeNqA==
X-Received: by 2002:a17:906:5fc4:b0:a52:143c:1901 with SMTP id
 k4-20020a1709065fc400b00a52143c1901mr9175882ejv.22.1713337303453; 
 Wed, 17 Apr 2024 00:01:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a170906501100b00a4e696e613esm7748737ejj.153.2024.04.17.00.01.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 00:01:42 -0700 (PDT)
Message-ID: <837133c3-12bf-47c5-b370-912f3f8336f7@linaro.org>
Date: Wed, 17 Apr 2024 09:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
To: "Zhang, Chen" <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Zhang, Hailiang" <zhanghailiang@xfusion.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
References: <20240417025634.1014582-1-lizhijian@fujitsu.com>
 <84c98291-c9a4-4349-9143-aff61e06c125@linaro.org>
 <CYYPR11MB8432BD8E8E4DAA9FFEBD19E99B0F2@CYYPR11MB8432.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CYYPR11MB8432BD8E8E4DAA9FFEBD19E99B0F2@CYYPR11MB8432.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 17/4/24 08:47, Zhang, Chen wrote:
> 
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Sent: Wednesday, April 17, 2024 2:14 PM
>> To: Li Zhijian <lizhijian@fujitsu.com>; Zhang, Hailiang
>> <zhanghailiang@xfusion.com>; peterx@redhat.com; farosas@suse.de
>> Cc: qemu-devel@nongnu.org; Zhang, Chen <chen.zhang@intel.com>; Wen
>> Congyang <wencongyang2@huawei.com>; Xie Changlong
>> <xiechanglong.d@gmail.com>
>> Subject: Re: [PATCH v2] migration/colo: Fix bdrv_graph_rdlock_main_loop:
>> Assertion `!qemu_in_coroutine()' failed.
>>
>> On 17/4/24 04:56, Li Zhijian via wrote:
>>> bdrv_activate_all() should not be called from the coroutine context,
>>> move it to the QEMU thread colo_process_incoming_thread() with the
>>> bql_lock protected.
>>>
>>> The backtrace is as follows:
>>>    #4  0x0000561af7948362 in bdrv_graph_rdlock_main_loop ()
>> at ../block/graph-lock.c:260
>>>    #5  0x0000561af7907a68 in graph_lockable_auto_lock_mainloop
>> (x=0x7fd29810be7b) at /patch/to/qemu/include/block/graph-lock.h:259
>>>    #6  0x0000561af79167d1 in bdrv_activate_all (errp=0x7fd29810bed0)
>> at ../block.c:6906
>>>    #7  0x0000561af762b4af in colo_incoming_co () at ../migration/colo.c:935
>>>    #8  0x0000561af7607e57 in process_incoming_migration_co (opaque=0x0)
>> at ../migration/migration.c:793
>>>    #9  0x0000561af7adbeeb in coroutine_trampoline (i0=-106876144,
>> i1=22042) at ../util/coroutine-ucontext.c:175
>>>    #10 0x00007fd2a5cf21c0 in  () at /lib64/libc.so.6
>>>
>>> CC: Fabiano Rosas <farosas@suse.de>
>>
>> Cc: qemu-stable@nongnu.org
>>
>>> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2277
>>> Fixes: 2b3912f135 ("block: Mark bdrv_first_blk() and
>>> bdrv_is_root_node() GRAPH_RDLOCK")
>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> It looks good to me. And already verified this patch in my environment.
> After address Phillippe's comments

(I'm only suggesting, in case using the macro results in code
more easily maintainable)

> please add:
> 
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> Tested-by: Zhang Chen <chen.zhang@intel.com>
> 
> Thanks
> Chen
> 
>>> ---
>>> V2: fix missing bql_unlock() in error path.
>>> ---
>>>    migration/colo.c | 18 ++++++++++--------
>>>    1 file changed, 10 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/migration/colo.c b/migration/colo.c index
>>> 84632a603e..5600a43d78 100644
>>> --- a/migration/colo.c
>>> +++ b/migration/colo.c
>>> @@ -835,6 +835,16 @@ static void *colo_process_incoming_thread(void
>> *opaque)
>>>            return NULL;
>>>        }
>>>
>>> +    /* Make sure all file formats throw away their mutable metadata */
>>> +    bql_lock();
>>
>> Note there is also the convenient BQL_LOCK_GUARD() macro.
>>
>>> +    bdrv_activate_all(&local_err);
>>> +    if (local_err) {
>>> +        bql_unlock();
>>> +        error_report_err(local_err);
>>> +        return NULL;
>>> +    }
>>> +    bql_unlock();
>>> +
>>>        failover_init_state();
> 


