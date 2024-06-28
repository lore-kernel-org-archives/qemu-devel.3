Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE7CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sND0x-0006Gj-VU; Fri, 28 Jun 2024 10:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sND0w-0006GW-Qn
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:55:50 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sND0v-0002zM-6S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:55:50 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7f615d04a32so36650639f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719586548; x=1720191348; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZTrPQ7yE+Qqexf1Etg+iaLBPPpCp419mlmCi5xZYCts=;
 b=o2NzDPGHYuhJrIXMMVI3hmts8UUDjwebeJ/OVnk4CqPuiVb71aYtGNXH53US4nu1J8
 MqMvcPc33xo6esakVw7vBC/746vOjBxltFVY3hj3gtTZrF1QKb1GulW6nrSc7q+magsd
 8xaZeqBXy6yMYjxZUCpfs1xDfcvsYeASN/zEqACRiJCK0rReYmNHIlpbmK202VKXQPRr
 JcGGXUBNkSuh7R60Jx2Sxu0hyZfyqbOOwgnThPv3H89KVMynWlXskv10YIvt5ofwMa4U
 atfvVFs+aBYXHw7tCNOhZK/XseNSaCDK3smuERqGzQxhtZDKaPDWHDJUhsj3CTz8bflv
 OkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719586548; x=1720191348;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTrPQ7yE+Qqexf1Etg+iaLBPPpCp419mlmCi5xZYCts=;
 b=NyYe7hv3FlQMDgmXjTTXO8we5KZwEddjbpe5eeSndBiOPwkW+qMpAMG8wArUwdFtUr
 Yc9+P7zLlnyZsO5RCDelrJPG2XoK5eaMpVFI28fkexn9yCyJ9soXEUH9Pjri9g/kCvUv
 47h2wRnajFnEBmwNtkQuPXFRBQ9uDLVJPuCgNHBsheEz3pC7lBZlReK6H9Uvze8NtEu8
 FE2R9lja1ACW1qzPdyHp6qve9q7l0Gt6iOqlg9JdZJ5LC+zEWVVf2uzuXo/tjQ697ReX
 6gPizpJYKj7MfGHC5WoJ2/XobaEGaXWG8Qg4WhtyqqLTlyOiLQwbnqwHwW0FVc99P2m+
 IWfw==
X-Gm-Message-State: AOJu0YxAPmdmyT2DSHcLGTvwT1Juzpy1YTWtxKuqeX7PheRDt55sLfbR
 mIAFw4wdAO4WuErAshrOrhqeYAlmuA5I0VK0MSwEY8dsZ41Hppu70aJWMAXLagk=
X-Google-Smtp-Source: AGHT+IG55lVOHQ6SOlw198nXB1Hp2XEOhUdfVVLJVqPgqKTRm7pxVBBTyk4BpjAh+UNnAifXqp/oeA==
X-Received: by 2002:a5e:9411:0:b0:7f6:1da5:98a1 with SMTP id
 ca18e2360f4ac-7f61da599bdmr253291139f.21.1719586547847; 
 Fri, 28 Jun 2024 07:55:47 -0700 (PDT)
Received: from [192.168.0.102] ([191.205.218.108])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708043b7100sm1738137b3a.142.2024.06.28.07.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 07:55:47 -0700 (PDT)
Subject: Re: [PATCH v6 06/11] target/arm: Factor out code for setting MTE TCF0
 field
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
 <20240628050850.536447-7-gustavo.romero@linaro.org>
 <87zfr5nu0z.fsf@draig.linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <be8b6f51-300e-3ae8-b2c3-f85f70b0ad46@linaro.org>
Date: Fri, 28 Jun 2024 11:55:44 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87zfr5nu0z.fsf@draig.linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=gustavo.romero@linaro.org; helo=mail-io1-xd36.google.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.965,
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

Hi Alex,

On 6/28/24 9:14 AM, Alex Bennée wrote:
> Gustavo Romero <gustavo.romero@linaro.org> writes:
> 
>> Factor out the code used for setting the MTE TCF0 field from the prctl
>> code into a convenient function. Other subsystems, like gdbstub, need to
>> set this field as well, so keep it as a separate function to avoid
>> duplication and ensure consistency in how this field is set across the
>> board.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   linux-user/aarch64/meson.build       |  2 ++
>>   linux-user/aarch64/mte_user_helper.c | 34 ++++++++++++++++++++++++++++
>>   linux-user/aarch64/mte_user_helper.h | 25 ++++++++++++++++++++
>>   linux-user/aarch64/target_prctl.h    | 22 ++----------------
>>   4 files changed, 63 insertions(+), 20 deletions(-)
>>   create mode 100644 linux-user/aarch64/mte_user_helper.c
>>   create mode 100644 linux-user/aarch64/mte_user_helper.h
>>
>> diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.build
>> index 248c578d15..f75bb3cd75 100644
>> --- a/linux-user/aarch64/meson.build
>> +++ b/linux-user/aarch64/meson.build
>> @@ -9,3 +9,5 @@ vdso_le_inc = gen_vdso.process('vdso-le.so',
>>                                  extra_args: ['-r', '__kernel_rt_sigreturn'])
>>   
>>   linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [vdso_be_inc, vdso_le_inc])
>> +
>> +linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [files('mte_user_helper.c')])
>> diff --git a/linux-user/aarch64/mte_user_helper.c b/linux-user/aarch64/mte_user_helper.c
>> new file mode 100644
>> index 0000000000..8be6deaf03
>> --- /dev/null
>> +++ b/linux-user/aarch64/mte_user_helper.c
>> @@ -0,0 +1,34 @@
>> +/*
>> + * ARM MemTag convenience functions.
>> + *
>> + * This code is licensed under the GNU GPL v2 or later.
>> + *
>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>> + */
>> +
>> +#include <sys/prctl.h>
> 
> Aside from missing the osdep Phillipe pointed out including prctl.h here
> is very suspect as its a system header. I assume if we need
> PR_MTE_TCF_SYNC we should hoist the definition that linux-user uses into
> a common header.
Other .c files include <sys/prctl.h> for other PR_ definitions. For example,
syscall.c and elfload.c. Is this really a problem? I see that would be a
problem when trying to build, for instance, aarch64-linux-user target on a
BSD host, but we don't support it. Building *-linux-user target is only
supported on Linux host, no?


Cheers,
Gustavo

