Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4572AC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 06:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd2hz-0008UU-GH; Thu, 22 Feb 2024 01:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rd2hx-0008Sm-Ox
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 01:37:25 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rd2hu-0006sZ-6k
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 01:37:25 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e43ee3f6fbso4547117b3a.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 22:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708583838; x=1709188638;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T/b0vPnGvrvn3JM0mQUk+THTOazfpt2hjrIbWxL2JwQ=;
 b=PA1BKCSB28iL9OD9Q/8gTwMwcj651anWISPUT4GpNPeMDqXXYj3XoC6lJsiNqqDl+1
 TuNi6HVPgnIk0RgrF4Au3e5OAmnJHJJdqwn/AjG3A3MegzGf+yyFTVbvtkk9F4XDgmL8
 ZRSyQlj9sOvhu6nJ53c7B4J3Zk4czhbTLoHNVipyo731GILRqqsGp/fsYgXUNLgnsHbV
 7TIiAkm7GdKmbQ3YACrFi3m6jkiF5eCy90KQ88MEPhm9/ESULkpZbcXelDKLlA/uCvHH
 WMK52l7yQWLctFWVYK252BD7M5uCYTqFGz7zGbozFMUOlBt50O6kwWdED++xALmp6etn
 6vnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708583838; x=1709188638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T/b0vPnGvrvn3JM0mQUk+THTOazfpt2hjrIbWxL2JwQ=;
 b=X2+YldRNe5CzoXRpUO+9jkS26wfgwznb3PpbB4rXZjJgDvq+41VU5nABZ9WWJXm401
 xfh/6nWg9I06287zw8e6MNJ5XVbYB+/jLbaIjp8NGt+J+k3/uaCShDNGltplLnR5JDYB
 FnCI52LSjnp4nwJzuveHzuWa6au44BxWsbXwyzHeYlvH++3oyfZp6MCjViwfmdXNln/x
 gPqxr/gu2ukJn4qOiHFtb8FVSJC6ySm5ysfPFUm9Ez3fEJQp33mwH6Krf+OsWtlsxkkq
 X29hRDn1aKOMtpAwpsp7JkAxbgom6GMiP1aEaS2/AQegBo/C6hY/GZEWdx9siJmGsGtd
 lQ6g==
X-Gm-Message-State: AOJu0YwR8GA8EVyjKH3FOFTkYvA3/MJlveHGbwOqa6kPHp3vbFWwVUIY
 bcX/ZOyarxtK14OAkXcZA1GeBWBKxoj7U+tBWgWGJqiAO5K2JWDDaBGVtqDP6Ww=
X-Google-Smtp-Source: AGHT+IF4O25LMrfr5cKmZpDOT1LBxKto4EFWbnhcbXh/aqoIlqGIXhg34IDcGYHRkkraYVZBK+AmOw==
X-Received: by 2002:a05:6a21:594:b0:1a0:bb45:415a with SMTP id
 lw20-20020a056a21059400b001a0bb45415amr4830565pzb.28.1708583838595; 
 Wed, 21 Feb 2024 22:37:18 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a056a00181200b006e3f62e1fbbsm8436227pfa.24.2024.02.21.22.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 22:37:18 -0800 (PST)
Message-ID: <7e4b4ba6-3683-464f-ac37-3b7f19455643@daynix.com>
Date: Thu, 22 Feb 2024 15:37:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] plugins: add an API to read registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow
 <jsnow@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Yanan Wang <wangyanan55@huawei.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Brian Cain
 <bcain@quicinc.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240216163025.424857-1-alex.bennee@linaro.org>
 <20240216163025.424857-19-alex.bennee@linaro.org>
 <c38a22b5-01e8-40f1-bfc4-4bba9bf7b516@daynix.com>
 <87il2jcje8.fsf@draig.linaro.org>
 <bf31a250-9539-448c-9c64-4168ab8741f1@daynix.com>
 <87bk8ab0f4.fsf@draig.linaro.org>
 <bf5e9471-c09f-47f2-a5a3-83713255c47a@daynix.com>
 <87zfvtaoqq.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87zfvtaoqq.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2024/02/21 23:14, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2024/02/21 19:02, Alex Bennée wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> On 2024/02/20 23:14, Alex Bennée wrote:
>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>
>>>>>> On 2024/02/17 1:30, Alex Bennée wrote:
>>>>>>> We can only request a list of registers once the vCPU has been
>>>>>>> initialised so the user needs to use either call the get function on
>>>>>>> vCPU initialisation or during the translation phase.
>>>>>>> We don't expose the reg number to the plugin instead hiding it
>>>>>>> behind
>>>>>>> an opaque handle. This allows for a bit of future proofing should the
>>>>>>> internals need to be changed while also being hashed against the
>>>>>>> CPUClass so we can handle different register sets per-vCPU in
>>>>>>> hetrogenous situations.
>>>>>>> Having an internal state within the plugins also allows us to expand
>>>>>>> the interface in future (for example providing callbacks on register
>>>>>>> change if the translator can track changes).
>>>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>>>>>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> <snip>
>>>>>>> +/*
>>>>>>> + * Register handles
>>>>>>> + *
>>>>>>> + * The plugin infrastructure keeps hold of these internal data
>>>>>>> + * structures which are presented to plugins as opaque handles. They
>>>>>>> + * are global to the system and therefor additions to the hash table
>>>>>>> + * must be protected by the @reg_handle_lock.
>>>>>>> + *
>>>>>>> + * In order to future proof for up-coming heterogeneous work we want
>>>>>>> + * different entries for each CPU type while sharing them in the
>>>>>>> + * common case of multiple cores of the same type.
>>>>>>> + */
>>>>>>> +
>>>>>>> +static QemuMutex reg_handle_lock;
>>>>>>> +
>>>>>>> +struct qemu_plugin_register {
>>>>>>> +    const char *name;
>>>>>>> +    int gdb_reg_num;
>>>>>>> +};
>>>>>>> +
>>>>>>> +static GHashTable *reg_handles; /* hash table of PluginReg */
>>>>>>> +
>>>>>>> +/* Generate a stable key - would xxhash be overkill? */
>>>>>>> +static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
>>>>>>> +{
>>>>>>> +    uintptr_t key = (uintptr_t) cs->cc;
>>>>>>> +    key ^= gdb_regnum;
>>>>>>> +    return GUINT_TO_POINTER(key);
>>>>>>> +}
>>>>>>
>>>>>> I have pointed out this is theoretically prone to collisions and
>>>>>> unsafe.
>>>>> How is it unsafe? The aim is to share handles for the same CPUClass
>>>>> rather than having a unique handle per register/cpu combo.
>>>>
>>>> THe intention is legitimate, but the implementation is not safe. It
>>>> assumes (uintptr)cs->cc ^ gdb_regnum is unique, but there is no such
>>>> guarantee. The key of GHashTable must be unique; generating hashes of
>>>> keys should be done with hash_func given to g_hash_table_new().
>>> This isn't a hash its a non-unique key. It is however unique for
>>> the same register on the same class of CPU so for each vCPU in a system
>>> can share the same opaque handles.
>>> The hashing is done internally by glib. We would assert if there was
>>> a
>>> duplicate key referring to a different register.
>>> I'm unsure what you want here? Do you have a suggestion for the key
>>> generation algorithm? As the comment notes I did consider a more complex
>>> mixing algorithm using xxhash but that wouldn't guarantee no clash
>>> either.
>>
>> I suggest using a struct that holds both of cs->cc and gdb_regnum, and
>> pass g_direct_equal() and g_direct_hash() to g_hash_table_new().
> 
> We already do:
> 
>          if (!reg_handles) {
>              reg_handles = g_hash_table_new(g_direct_hash, g_direct_equal);
>          }
> 
> But we can't use g_direct_equal with something that exceeds the width of
> gpointer as it is a straight equality test of the key. What you are
> suggesting requires allocating memory for each key and de-referencing
> with a custom GEqualFunc.

My bad. I wrongly remembered g_direct_equal() and g_direct_hash(). It 
indeed seems to need a more complicated solution.

It is possible to write a GEqualFunc and a GHashFunc that consumes a 
struct but it is a chore. How about having a two-level GHashTable? 
reg_handles will be a GHashTable keyed with cs->cc, and another 
GHashTable will be keyed with gdb_regnum.

