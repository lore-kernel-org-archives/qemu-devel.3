Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3609AC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 11:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdTyy-0007no-4e; Fri, 23 Feb 2024 06:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdTyp-0007le-6t
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:44:39 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdTyj-0007wL-K8
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:44:38 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d180d6bd32so10433271fa.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 03:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708688671; x=1709293471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbOq+5s/X39YkRR/r8UlhWzXHHqLg9Z8IYVgikI+0+Q=;
 b=r9vuFsYRJUJdUnUGVc3WFIe6nOluzmfoQCN/crPrZ1x4w77Rx/vEXg6jk5IxHm6hCp
 pTAwQAPZZ+Uow+Y2sgYjL8ERmhllSDCTPLqqRKoi/FSDUiFfXsDfNN/DVtKxuHbmntED
 ruW4dLQYbkhWPRUc8ZVHBHCbf58+FKUuDQCGziyBv2WSbuLSCjfTc0gdR9owpAg7y+jp
 dHrTyO678eWh8TPkHWBtBYpDcyt9AR4vTSvxGkPWVsmmkLEmbsOp2LEpvOj625DYc7gZ
 6u2+Qu0LbMgbdJF00ra4ibEA08Ra9IZt7onXzemIrq8LEt8iezrkboZeCmTRAm32mOYZ
 rztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708688671; x=1709293471;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DbOq+5s/X39YkRR/r8UlhWzXHHqLg9Z8IYVgikI+0+Q=;
 b=fnA/Lhro6dZNKpRqbct40e/kRV4nuFkd0uB8KcBSn+peUY7ubVjhLmpzJTeaeTS55X
 r69lucKt0G+xVnEdAV/NNy+apIt1k6Nv89+mkCT2yWpr/BEU4H7ypfEbVVwozG5LXYcl
 fUwSkFfLscBxXmyeEzqtfPIGOF3X4niG5iOS4sXPDY7E0BKIMUrTDv/fmyuGZBqugsjl
 nt3kpILTbcSPk+LCmyRHGwd34AedxVf3RGykYqRnfN862uPfHoxHaSP7g9qzvAXwaaye
 vzhzBB1T6g1+f4MCwqMNeMtW0PkA2S9C6nS2xANAFmU/F9zw0JvzKhynNvGnyjrPZBGW
 /DfQ==
X-Gm-Message-State: AOJu0YzChA2cxE2oZ4yxNSM+LVZZQpid2KQz+n7Lvosg05PaHu8Nz80t
 jybPcxdJCKt/Kcm/szLvClZMRTOOXzXNsE4NlUcZSx0Z+H9vLJHfiTL3K9YXDSg=
X-Google-Smtp-Source: AGHT+IG/7kH0tu1tHjmC1TQwROCMvUvxz92uTqu2QeX1Dc+UKq8ZpSA9GD5rV2zDSuu2A82nu4eQqA==
X-Received: by 2002:ac2:5185:0:b0:512:be76:b15 with SMTP id
 u5-20020ac25185000000b00512be760b15mr1071984lfi.58.1708688671373; 
 Fri, 23 Feb 2024 03:44:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x1-20020a05600c2a4100b0041292306f2csm2019847wme.16.2024.02.23.03.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 03:44:31 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 95A3D5F88C;
 Fri, 23 Feb 2024 11:44:30 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>,  Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Michael Rolnik
 <mrolnik@gmail.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-ppc@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-riscv@nongnu.org,  Cleber Rosa
 <crosa@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Song Gao
 <gaosong@loongson.cn>,  qemu-arm@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  John Snow <jsnow@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@kaod.org>,  Nicholas Piggin <npiggin@gmail.com>,
 qemu-s390x@nongnu.org,  Laurent Vivier <laurent@vivier.eu>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Yanan Wang <wangyanan55@huawei.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Brian Cain <bcain@quicinc.com>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 Bin Meng <bin.meng@windriver.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Alistair Francis
 <alistair.francis@wdc.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 18/23] plugins: add an API to read registers
In-Reply-To: <308de8f7-5871-4d3d-847c-f4f55fb6f790@daynix.com> (Akihiko
 Odaki's message of "Fri, 23 Feb 2024 19:58:40 +0900")
References: <20240216163025.424857-1-alex.bennee@linaro.org>
 <20240216163025.424857-19-alex.bennee@linaro.org>
 <c38a22b5-01e8-40f1-bfc4-4bba9bf7b516@daynix.com>
 <87il2jcje8.fsf@draig.linaro.org>
 <bf31a250-9539-448c-9c64-4168ab8741f1@daynix.com>
 <87bk8ab0f4.fsf@draig.linaro.org>
 <bf5e9471-c09f-47f2-a5a3-83713255c47a@daynix.com>
 <87zfvtaoqq.fsf@draig.linaro.org>
 <7e4b4ba6-3683-464f-ac37-3b7f19455643@daynix.com>
 <87cysoajhl.fsf@draig.linaro.org>
 <f4b0b535-9e2b-47c7-a84b-afd851deb88a@daynix.com>
 <87plwo8l56.fsf@draig.linaro.org>
 <308de8f7-5871-4d3d-847c-f4f55fb6f790@daynix.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 23 Feb 2024 11:44:30 +0000
Message-ID: <87jzmv8kwx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2024/02/23 2:27, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> On 2024/02/22 19:20, Alex Benn=C3=A9e wrote:
>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>
>>>>> On 2024/02/21 23:14, Alex Benn=C3=A9e wrote:
>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>
>>>>>>> On 2024/02/21 19:02, Alex Benn=C3=A9e wrote:
>>>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>>>
>>>>>>>>> On 2024/02/20 23:14, Alex Benn=C3=A9e wrote:
>>>>>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>>>>>
>>>>>>>>>>> On 2024/02/17 1:30, Alex Benn=C3=A9e wrote:
>>>>>>>>>>>> We can only request a list of registers once the vCPU has been
>>>>>>>>>>>> initialised so the user needs to use either call the get funct=
ion on
>>>>>>>>>>>> vCPU initialisation or during the translation phase.
>>>>>>>>>>>> We don't expose the reg number to the plugin instead hiding it
>>>>>>>>>>>> behind
>>>>>>>>>>>> an opaque handle. This allows for a bit of future proofing sho=
uld the
>>>>>>>>>>>> internals need to be changed while also being hashed against t=
he
>>>>>>>>>>>> CPUClass so we can handle different register sets per-vCPU in
>>>>>>>>>>>> hetrogenous situations.
>>>>>>>>>>>> Having an internal state within the plugins also allows us to =
expand
>>>>>>>>>>>> the interface in future (for example providing callbacks on re=
gister
>>>>>>>>>>>> change if the translator can track changes).
>>>>>>>>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>>>>>>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>>>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>>>>>>>>>>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>>>>>>>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>>>>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>>>>>> <snip>
>>>>>>>>>>>> +/*
>>>>>>>>>>>> + * Register handles
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * The plugin infrastructure keeps hold of these internal data
>>>>>>>>>>>> + * structures which are presented to plugins as opaque handle=
s. They
>>>>>>>>>>>> + * are global to the system and therefor additions to the has=
h table
>>>>>>>>>>>> + * must be protected by the @reg_handle_lock.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * In order to future proof for up-coming heterogeneous work =
we want
>>>>>>>>>>>> + * different entries for each CPU type while sharing them in =
the
>>>>>>>>>>>> + * common case of multiple cores of the same type.
>>>>>>>>>>>> + */
>>>>>>>>>>>> +
>>>>>>>>>>>> +static QemuMutex reg_handle_lock;
>>>>>>>>>>>> +
>>>>>>>>>>>> +struct qemu_plugin_register {
>>>>>>>>>>>> +    const char *name;
>>>>>>>>>>>> +    int gdb_reg_num;
>>>>>>>>>>>> +};
>>>>>>>>>>>> +
>>>>>>>>>>>> +static GHashTable *reg_handles; /* hash table of PluginReg */
>>>>>>>>>>>> +
>>>>>>>>>>>> +/* Generate a stable key - would xxhash be overkill? */
>>>>>>>>>>>> +static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_reg=
num)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    uintptr_t key =3D (uintptr_t) cs->cc;
>>>>>>>>>>>> +    key ^=3D gdb_regnum;
>>>>>>>>>>>> +    return GUINT_TO_POINTER(key);
>>>>>>>>>>>> +}
>>>>>>>>>>>
>>>>>>>>>>> I have pointed out this is theoretically prone to collisions and
>>>>>>>>>>> unsafe.
>>>>>>>>>> How is it unsafe? The aim is to share handles for the same CPUCl=
ass
>>>>>>>>>> rather than having a unique handle per register/cpu combo.
>>>>>>>>>
>>>>>>>>> THe intention is legitimate, but the implementation is not safe. =
It
>>>>>>>>> assumes (uintptr)cs->cc ^ gdb_regnum is unique, but there is no s=
uch
>>>>>>>>> guarantee. The key of GHashTable must be unique; generating hashe=
s of
>>>>>>>>> keys should be done with hash_func given to g_hash_table_new().
>>>>>>>> This isn't a hash its a non-unique key. It is however unique for
>>>>>>>> the same register on the same class of CPU so for each vCPU in a s=
ystem
>>>>>>>> can share the same opaque handles.
>>>>>>>> The hashing is done internally by glib. We would assert if there w=
as
>>>>>>>> a
>>>>>>>> duplicate key referring to a different register.
>>>>>>>> I'm unsure what you want here? Do you have a suggestion for the key
>>>>>>>> generation algorithm? As the comment notes I did consider a more c=
omplex
>>>>>>>> mixing algorithm using xxhash but that wouldn't guarantee no clash
>>>>>>>> either.
>>>>>>>
>>>>>>> I suggest using a struct that holds both of cs->cc and gdb_regnum, =
and
>>>>>>> pass g_direct_equal() and g_direct_hash() to g_hash_table_new().
>>>>>> We already do:
>>>>>>            if (!reg_handles) {
>>>>>>                reg_handles =3D g_hash_table_new(g_direct_hash, g_dir=
ect_equal);
>>>>>>            }
>>>>>> But we can't use g_direct_equal with something that exceeds the
>>>>>> width of
>>>>>> gpointer as it is a straight equality test of the key. What you are
>>>>>> suggesting requires allocating memory for each key and de-referencing
>>>>>> with a custom GEqualFunc.
>>>>>
>>>>> My bad. I wrongly remembered g_direct_equal() and g_direct_hash(). It
>>>>> indeed seems to need a more complicated solution.
>>>>>
>>>>> It is possible to write a GEqualFunc and a GHashFunc that consumes a
>>>>> struct but it is a chore. How about having a two-level GHashTable?
>>>>> reg_handles will be a GHashTable keyed with cs->cc, and another
>>>>> GHashTable will be keyed with gdb_regnum.
>>>> That still seems overkill for a clash that can't happen. What do you
>>>> think about the following:
>>>>     /*
>>>>      * Generate a stable key shared across CPUs of the same class
>>>>      *
>>>>      * In order to future proof for up-coming heterogeneous work we wa=
nt
>>>>      * different entries for each CPU type while sharing them in the
>>>>      * common case of multiple cores of the same type. This makes the
>>>>      * assumption you won't see two CPUClass pointers that are similar
>>>>      * enough that the low bits mixed with different registers numbers
>>>>      * will give you the same key.
>>>>      *
>>>>      * The build time assert will fire if CPUClass goes on a sudden di=
et
>>>>      * and we assert further down if we detect two keys representing
>>>>      * different regnums. In practice allocations of CPUClass are much
>>>>      * farther apart making clashes practically impossible.
>>>>      */
>>>>     static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
>>>>     {
>>>>         uintptr_t key =3D (uintptr_t) cs->cc;
>>>>         /* this protects some of the assumptions above */
>>>>         qemu_build_assert(sizeof(*cs->cc) >=3D 256);
>>>>         key ^=3D gdb_regnum;
>>>>         return GUINT_TO_POINTER(key);
>>>>     }
>>>
>>>
>>> I think the assertion and comments are overkill. Doesn't having a
>>> nested GHashTable save some words you have to wrote for the
>>> assumption?
>> A nested hash table for a single entry is overkill.
>
> You mean that the first level will be indexed by only one CPUClass (or
> few if we support a heterogeneous system).
>
> I think it's still OK though. It's not like we will need more code
> when having few entries.
>
>>=20
>>> I'm also not quite convinced that the comments and assertions are
>>> enough to say this hack is safe; what if some sort of pointer
>>> authentication is added and shuffles bits? Will this hack be
>>> compatible with static and dynamic checkers we may have in the future?
>> We are not using the value as a pointer so that should be irrelevant
>> although generally those bits tend to be at the top of pointers so they
>> can be masked off.
>> I'm not sure what we are trying to achieve here. I've got something
>> that
>> works, doesn't fail any tests and has some guards in for potential
>> future problems. At the same time I'm not prepared to over-engineer the
>> solution for a theoretical future problem we haven't got yet.
>> What about if I just key based of gdb_regnum and we accept that that
>> might break the one heterogeneous system we model today?
>>=20
>
> That's the best option in my opinion. gdbstub won't work well with
> such a system anyway, and fixing it will need something similar to
> GHashTable. But if I would fix gdbstub for a heterogeneous system, I
> would add a field to CPUClass instead of having a GHashTable keyed
> with tuples of CPUClass pointers and register numbers. It should be
> fine considering that CPUState already has gdbstub-specific fields
> like gdb_regs.

It would be nice to move all register code into CPUClass to avoid
repeating ourselves but I suspect that is quite an invasive change for a
later series. Currently all the CPUClass values are set on init and
shouldn't really be changed after that otherwise we'll have to start
messing with locking.=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

