Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74988C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoOs-00046W-W4; Wed, 21 Feb 2024 10:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcoL7-00010D-6d
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:54 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcjQZ-0000HR-2j
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 05:02:14 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-512bb2ed1f7so3771716e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708509728; x=1709114528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUkWydTv2VrLHRINP4jDL5WI0AAuSIf64/VbYecvIRA=;
 b=Nc0rXIkERZ4qxYYeANl4wY1nY2L3a6pFIqZ7G7oq/PCoKjAfKFzk/2FHq2EcLyXMNL
 lE7z7uNVoWpPOT+yTMfKzpIwf66EwGHXHkIsdDUUi3gVNkVPLtONRGLRzE4eAjdxSQK0
 7/x8rdQ/fH+EN3P+x7uX26eUZfQbdEWjrP6h7xG9RRTGy6qMQ5jTHeDzOnngPy7tDg90
 bJAd/BXVOfSqVAl+URDIeodnOoRyI8n0hmgykXan8p/eWSWtChoet52C3Q6mySkxO3yu
 XSZ4yZOgXYoounQTM688vCx1NFI75UBFMAXBh+91rYqvMIL9+cxOgK3RGiYXjbiH9TXO
 2Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708509728; x=1709114528;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JUkWydTv2VrLHRINP4jDL5WI0AAuSIf64/VbYecvIRA=;
 b=HWn0HQ+HUplydq3gO2S24ssJDEZuNSZO8p+Qu85qPWfx5E851dIbYsG+YP/fplnW0y
 8p1SHJZf4ru0kRcDn4f1C1gRw+ucTXuwedFtABt3Iu0tukyz9tu9Bc16aC3qh0gBw8VQ
 yEdYEppjWehzZqLCDIR7w+e+cHMyMsgCY7mmb+T3EQC9Uv4V/2AesgAmmokWBAftoF/X
 W9Bj7aMhlDL/CUgsSr+XEtjOC2aBdzWkjlsWAQoiPuKbF86qiHacpzkHeFKoMhBS+2/i
 /rwG7jZkGBzjbaxxVw76E61PpzTAwwOdvXSoHJ/Hyac7svfmho3+L4Yer9vzAU5egNr/
 lcoA==
X-Gm-Message-State: AOJu0Yz8J/Z4mnb3Hhhv+EgJKOuBOe2JooVCC2orUE+MY0DL7W61lnkV
 AgejUqBRcgjlz7dezXqLMv2G6VKdfcAKukaPPC89izvbU6+XYwiocYBNYSjys6U=
X-Google-Smtp-Source: AGHT+IHLeOd6gaUqT81BSIlTcz4al/LxL7/p7IM099mHYvt7ZJyCft9QPFAaUxmPD7CNpXvTgqdH4Q==
X-Received: by 2002:a05:6512:1146:b0:512:b437:4b06 with SMTP id
 m6-20020a056512114600b00512b4374b06mr4271003lfg.67.1708509728026; 
 Wed, 21 Feb 2024 02:02:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b13-20020a05600c11cd00b0040fddaf9ff4sm1935434wmi.40.2024.02.21.02.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 02:02:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 34FBE5F875;
 Wed, 21 Feb 2024 10:02:07 +0000 (GMT)
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
In-Reply-To: <bf31a250-9539-448c-9c64-4168ab8741f1@daynix.com> (Akihiko
 Odaki's message of "Wed, 21 Feb 2024 13:45:16 +0900")
References: <20240216163025.424857-1-alex.bennee@linaro.org>
 <20240216163025.424857-19-alex.bennee@linaro.org>
 <c38a22b5-01e8-40f1-bfc4-4bba9bf7b516@daynix.com>
 <87il2jcje8.fsf@draig.linaro.org>
 <bf31a250-9539-448c-9c64-4168ab8741f1@daynix.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Wed, 21 Feb 2024 10:02:07 +0000
Message-ID: <87bk8ab0f4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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

> On 2024/02/20 23:14, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> On 2024/02/17 1:30, Alex Benn=C3=A9e wrote:
>>>> We can only request a list of registers once the vCPU has been
>>>> initialised so the user needs to use either call the get function on
>>>> vCPU initialisation or during the translation phase.
>>>> We don't expose the reg number to the plugin instead hiding it
>>>> behind
>>>> an opaque handle. This allows for a bit of future proofing should the
>>>> internals need to be changed while also being hashed against the
>>>> CPUClass so we can handle different register sets per-vCPU in
>>>> hetrogenous situations.
>>>> Having an internal state within the plugins also allows us to expand
>>>> the interface in future (for example providing callbacks on register
>>>> change if the translator can track changes).
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> <snip>
>>>> +/*
>>>> + * Register handles
>>>> + *
>>>> + * The plugin infrastructure keeps hold of these internal data
>>>> + * structures which are presented to plugins as opaque handles. They
>>>> + * are global to the system and therefor additions to the hash table
>>>> + * must be protected by the @reg_handle_lock.
>>>> + *
>>>> + * In order to future proof for up-coming heterogeneous work we want
>>>> + * different entries for each CPU type while sharing them in the
>>>> + * common case of multiple cores of the same type.
>>>> + */
>>>> +
>>>> +static QemuMutex reg_handle_lock;
>>>> +
>>>> +struct qemu_plugin_register {
>>>> +    const char *name;
>>>> +    int gdb_reg_num;
>>>> +};
>>>> +
>>>> +static GHashTable *reg_handles; /* hash table of PluginReg */
>>>> +
>>>> +/* Generate a stable key - would xxhash be overkill? */
>>>> +static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
>>>> +{
>>>> +    uintptr_t key =3D (uintptr_t) cs->cc;
>>>> +    key ^=3D gdb_regnum;
>>>> +    return GUINT_TO_POINTER(key);
>>>> +}
>>>
>>> I have pointed out this is theoretically prone to collisions and
>>> unsafe.
>> How is it unsafe? The aim is to share handles for the same CPUClass
>> rather than having a unique handle per register/cpu combo.
>
> THe intention is legitimate, but the implementation is not safe. It
> assumes (uintptr)cs->cc ^ gdb_regnum is unique, but there is no such
> guarantee. The key of GHashTable must be unique; generating hashes of
> keys should be done with hash_func given to g_hash_table_new().

This isn't a hash its a non-unique key. It is however unique for
the same register on the same class of CPU so for each vCPU in a system
can share the same opaque handles.

The hashing is done internally by glib. We would assert if there was a
duplicate key referring to a different register.

I'm unsure what you want here? Do you have a suggestion for the key
generation algorithm? As the comment notes I did consider a more complex
mixing algorithm using xxhash but that wouldn't guarantee no clash
either.


>
>> Indeed if I add the following:
>> --8<---------------cut here---------------start------------->8---
>>     plugins/api.c
>> @@ -482,6 +482,9 @@ static GArray *create_register_handles(CPUState *cs,=
 GArray *gdbstub_regs)
>>                   val->name =3D g_intern_string(grd->name);
>>                     g_hash_table_insert(reg_handles, key, val);
>> +            } else {
>> +                /* make sure its not a clash */
>> +                g_assert(val->gdb_reg_num =3D=3D grd->gdb_reg);
>>               }
>>                 /* Create a record for the plugin */
>> modified   tests/plugin/insn.c
>> @@ -46,6 +46,25 @@ typedef struct {
>>       char *disas;
>>   } Instruction;
>>   +/*
>> + * Initialise a new vcpu with reading the register list
>> + */
>> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>> +{
>> +    g_autoptr(GArray) reg_list =3D qemu_plugin_get_registers();
>> +    g_autoptr(GByteArray) reg_value =3D g_byte_array_new();
>> +
>> +    if (reg_list) {
>> +        for (int i =3D 0; i < reg_list->len; i++) {
>> +            qemu_plugin_reg_descriptor *rd =3D &g_array_index(
>> +                reg_list, qemu_plugin_reg_descriptor, i);
>> +            int count =3D qemu_plugin_read_register(rd->handle, reg_val=
ue);
>> +            g_assert(count > 0);
>> +        }
>> +    }
>> +}
>> +
>> +
>>   static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
>>   {
>>       unsigned int i =3D cpu_index % MAX_CPUS;
>> @@ -212,6 +231,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plug=
in_id_t id,
>>           sizes =3D g_array_new(true, true, sizeof(unsigned long));
>>       }
>>   +    /* Register init, translation block and exit callbacks */
>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>>       qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>>       return 0;
>> --8<---------------cut here---------------end--------------->8---
>> Nothing trips up during check-tcg (after I fixed "gdbstub: Infer
>> number
>> of core registers from XML" to remove the microblaze check on
>> cc->gdb_num_core_regs).
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

