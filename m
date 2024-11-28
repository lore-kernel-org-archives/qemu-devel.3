Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22487D6D251
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 00:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGSqp-0002hM-5r; Wed, 27 Nov 2024 19:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGSqn-0002gk-AB
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 19:57:45 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGSql-0008NA-Fc
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 19:57:45 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-212583bd467so2385685ad.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 16:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732755462; x=1733360262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/4k3jbmmui7Raq124fT8NFlRf5pw1ILHH9zOULwZkgI=;
 b=JQazbMtBLt9bZNWMPNYlhTQtagWV/T/i6gca/SQc2QbkOZ7iBbhQoZVO8rPC67zq/Z
 KzhGufgLivm0dZD/8qc/bMXpsyQXJuSasHw5/aAc1brgxsk7zLlFF+7tNEPe9EI3JpjI
 g7MPZMDDPEHxgHljR7KqINEd3Bh8f40+m9CaV6CUGg424Ajaw+sAJddgnH60zpmnrkSU
 8Wp3cB8XlVmGVbP0mZ83/UUKA5fhYMI1YgWRNQTpO7cUeKKZiqJFzMQSNICW/yytzBI1
 0Ydegiho73Lgg0DYw196GCww38BlNb9F73BJ0NbasVs9mF75MefXJPjszrcbnJ8pPvF8
 RM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732755462; x=1733360262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/4k3jbmmui7Raq124fT8NFlRf5pw1ILHH9zOULwZkgI=;
 b=ZAI6mCpY0sHBtuCDP5nwfkUSDEpvaaVVIBVC+xL4aXxXFwDJXoqQCFEC8CFCSNqYZF
 D/yhnjcDAxydpMEq6Dyg4flUxNkkdxCnZhhgbNR7ym4wEROJonOJw4ZGO3xoG5TKaPey
 w/RUfoNaH9rKeQJph+Gw9LG0uVilXn+M12Us1heH2N0XDZVwkuxTHLRQsVJVJE6IFTp7
 L4/GmyWyebHR8DlpG88tHq2/Anyo6BGSoP+F7flhL1Xb0bVRF2EQyVJBqhbHtdN6D/t1
 mGMfLWI+yh4WyrqJmssO1FB3Y7g5/eKrKWDIHEiXhBRunddnkienykimMcV0H3/KkHjq
 PhjQ==
X-Gm-Message-State: AOJu0YyiAALF7oVIXpVDlrsVNkFUy49Ebu1qU9Yggoy36TFKjmRdTztU
 BwELFeOEBcK3iwQDKt8cUDgO7thxb9dpVMbT9G9lynDrpxP2ktshgilIRSgZkUR7UraJZdF93gJ
 oUvk=
X-Gm-Gg: ASbGncs76AUSvXp4/wxKVHQufBwkq8NNhGg5+2l0a/N8s4ta/XoCn333SKKjeR670Ft
 /hLj4p/249E6yRbgBtry9wweeXrUB80ASxWcfR/yTN4A07wQfxlS+ISXr2QIlb3BfP4IUgT243L
 qxfvP3akMgGiaK6BGCO3+nNkxGIIrsyTnC+BNSy0DRu6R7tkyf50838UFAO9NtmjFr/hAvv1Vhm
 kdxRm4EVuMhTEeTFkz1esT7qn7727lV9hpitd1KxgoyddVu/FqdLI1iyh8oaC0hc8hLIn/QhHxy
 D4rF71WT3NctBo3150xxhw==
X-Google-Smtp-Source: AGHT+IENhRepUQQUCXHiO2S35i1v2EXnVl051FuKgR9T8YQpZcyT6K//E+hG6M/f782+wTJjSAEJ/A==
X-Received: by 2002:a17:902:ecc9:b0:20b:38fe:60d7 with SMTP id
 d9443c01a7336-21501096d1bmr68005965ad.22.1732755461696; 
 Wed, 27 Nov 2024 16:57:41 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215219acd32sm1713945ad.244.2024.11.27.16.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 16:57:41 -0800 (PST)
Message-ID: <e94a1547-514d-448b-b783-4704195f1c5d@linaro.org>
Date: Wed, 27 Nov 2024 16:57:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] win32: remove usage of attribute gcc_struct
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
 <20241126211736.122285-2-pierrick.bouvier@linaro.org>
 <v63qepc7jqqncwcknnu2v2ksnjxrrfe7dpugorc7ppro2soxxp@vra5v6glq2eb>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <v63qepc7jqqncwcknnu2v2ksnjxrrfe7dpugorc7ppro2soxxp@vra5v6glq2eb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 11/27/24 01:20, Stefano Garzarella wrote:
> On Tue, Nov 26, 2024 at 01:17:34PM -0800, Pierrick Bouvier wrote:
>> This attribute is not recognized by clang.
>>
>> An investigation has been performed to ensure this attribute has no
>> effect on layout of structures we use in QEMU [1], so it's safe to
>> remove now.
>>
>> In the future, we'll forbid introducing new bitfields in packed struct.
> 
> Why?
> I suggest reporting in this commit description what you wrote in the
> following patch in the documentation (or a summary), because at first
> glance I could not understand the correlation between removing
> gcc_struct and bitfields in packed struct.
> 

Thanks,
I'll mention the problem came explicitely from the bitfields.

>>
>> [1] https://lore.kernel.org/qemu-devel/66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org/
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> meson.build                               | 5 -----
>> include/qemu/compiler.h                   | 7 +------
>> scripts/cocci-macro-file.h                | 6 +-----
>> subprojects/libvhost-user/libvhost-user.h | 6 +-----
>> 4 files changed, 3 insertions(+), 21 deletions(-)
> 
> The patch LGTM.
> 
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> 
>>
>> diff --git a/meson.build b/meson.build
>> index e0b880e4e13..fa6d24e1233 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -354,11 +354,6 @@ elif host_os == 'sunos'
>>    qemu_common_flags += '-D__EXTENSIONS__'
>> elif host_os == 'haiku'
>>    qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
>> -elif host_os == 'windows'
>> -  if not compiler.compiles('struct x { int y; } __attribute__((gcc_struct));',
>> -                           args: '-Werror')
>> -    error('Your compiler does not support __attribute__((gcc_struct)) - please use GCC instead of Clang')
>> -  endif
>> endif
>>
>> # Choose instruction set (currently x86-only)
>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>> index c06954ccb41..d904408e5ed 100644
>> --- a/include/qemu/compiler.h
>> +++ b/include/qemu/compiler.h
>> @@ -22,12 +22,7 @@
>> #define QEMU_EXTERN_C extern
>> #endif
>>
>> -#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>> -# define QEMU_PACKED __attribute__((gcc_struct, packed))
>> -#else
>> -# define QEMU_PACKED __attribute__((packed))
>> -#endif
>> -
>> +#define QEMU_PACKED __attribute__((packed))
>> #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
>>
>> #ifndef glue
>> diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
>> index d247a5086e9..c64831d5408 100644
>> --- a/scripts/cocci-macro-file.h
>> +++ b/scripts/cocci-macro-file.h
>> @@ -23,11 +23,7 @@
>> #define G_GNUC_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
>> #define G_GNUC_NULL_TERMINATED __attribute__((sentinel))
>>
>> -#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>> -# define QEMU_PACKED __attribute__((gcc_struct, packed))
>> -#else
>> -# define QEMU_PACKED __attribute__((packed))
>> -#endif
>> +#define QEMU_PACKED __attribute__((packed))
>>
>> #define cat(x,y) x ## y
>> #define cat2(x,y) cat(x,y)
>> diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
>> index deb40e77b3f..2ffc58c11b1 100644
>> --- a/subprojects/libvhost-user/libvhost-user.h
>> +++ b/subprojects/libvhost-user/libvhost-user.h
>> @@ -186,11 +186,7 @@ typedef struct VhostUserShared {
>>      unsigned char uuid[UUID_LEN];
>> } VhostUserShared;
>>
>> -#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>> -# define VU_PACKED __attribute__((gcc_struct, packed))
>> -#else
>> -# define VU_PACKED __attribute__((packed))
>> -#endif
>> +#define VU_PACKED __attribute__((packed))
>>
>> typedef struct VhostUserMsg {
>>      int request;
>> -- 
>> 2.39.5
>>
> 


