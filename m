Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEC4C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoTv-000835-Tk; Wed, 21 Feb 2024 10:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcoN7-00010D-GE
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:02 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcnMe-0007sd-LG
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 09:14:26 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d7b04f7e9so498822f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 06:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708524862; x=1709129662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNnBeAjkH2C3G+hnXcIRwM7KrJy+LC4h8ErELw2KXoo=;
 b=QvJ/9euq8qIwwPqjSubPxoZqr2rD9H7PfrG57m3j7O9hDhYnTfvZrVkSiRcMOhLNi6
 XTqQBNCRlnCGwW3pzhzZ7l6BaMNbVRb3v94Ik8F53YRgyNbgA5+XcCENbqU8rsckEIYj
 GvEDsCl6ZBaAdUfvK+W2ch04hjzNrjqbN7hh30fYC4lRsdob0rMK8ARApWem0j4uSrh/
 EoZROf4A07cMJs5cncVYzad5N+Y75bsWsE85AIgf3RTka3m0+7jcYn8pJBFrFoBQrcc1
 PrHmn9ZQ/7/Fkk2wsT0KLtLGzl+EMrkUJimoVQx/GMxqMv2sF1Ja+9+Cq4GOo8qcB/dn
 VMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708524862; x=1709129662;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kNnBeAjkH2C3G+hnXcIRwM7KrJy+LC4h8ErELw2KXoo=;
 b=iQW8+ZusEnQGjqA3vIRcag1C1Q7v/nSSIx7qo5FrptbdlF3dJc5KyN6KWPhinTXoOX
 C3A5+SdrRCokyBsEF9Aw6aeMfM0H//ZlgkV87Vb9gRc971VIfUIDb8F8tjBNKyWclO3z
 ayDb5SSsPjGY18nJFx60XZi4AbwOsmUQaK5TlbbkfGXGY8GQdMOO0IOeMbGYEanYTaJR
 edjbOIZdPLzmstr4W5xjynkDm1qx1wZv1dwsuWulq9BbuKE0K9QxNJssMlxc0ZRzxhZJ
 kUx0hwcmlNZe4fOK64pn7ythOoQ2yUfpKQA5vGX4HICNUxpBgBiysZ7xWWez4glT2GOG
 9V9g==
X-Gm-Message-State: AOJu0Yz0c8xUyT77D99dbNKuQRPcSBl5FaZjg0MB0cGjbe7WsKxKNKZE
 ZK3qb6Suuz0RKUhXXUnGFQoBmV3YmedLFO04WWNDcMkxs0vhNus8U4xHEHO8+Ns=
X-Google-Smtp-Source: AGHT+IEVE7t3lOkN9YD1hVxc9VrXwcOhLi6KqM+agp11inKIkLWYs5es4LBTJFjFfht8gaqc5z8Kig==
X-Received: by 2002:adf:f9cf:0:b0:33d:5363:c38 with SMTP id
 w15-20020adff9cf000000b0033d53630c38mr5900839wrr.35.1708524862354; 
 Wed, 21 Feb 2024 06:14:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m17-20020a5d4a11000000b0033cf4e47496sm16878284wrq.51.2024.02.21.06.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 06:14:22 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 739375F875;
 Wed, 21 Feb 2024 14:14:21 +0000 (GMT)
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
In-Reply-To: <bf5e9471-c09f-47f2-a5a3-83713255c47a@daynix.com> (Akihiko
 Odaki's message of "Wed, 21 Feb 2024 19:11:05 +0900")
References: <20240216163025.424857-1-alex.bennee@linaro.org>
 <20240216163025.424857-19-alex.bennee@linaro.org>
 <c38a22b5-01e8-40f1-bfc4-4bba9bf7b516@daynix.com>
 <87il2jcje8.fsf@draig.linaro.org>
 <bf31a250-9539-448c-9c64-4168ab8741f1@daynix.com>
 <87bk8ab0f4.fsf@draig.linaro.org>
 <bf5e9471-c09f-47f2-a5a3-83713255c47a@daynix.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Wed, 21 Feb 2024 14:14:21 +0000
Message-ID: <87zfvtaoqq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On 2024/02/21 19:02, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> On 2024/02/20 23:14, Alex Benn=C3=A9e wrote:
>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>
>>>>> On 2024/02/17 1:30, Alex Benn=C3=A9e wrote:
>>>>>> We can only request a list of registers once the vCPU has been
>>>>>> initialised so the user needs to use either call the get function on
>>>>>> vCPU initialisation or during the translation phase.
>>>>>> We don't expose the reg number to the plugin instead hiding it
>>>>>> behind
>>>>>> an opaque handle. This allows for a bit of future proofing should the
>>>>>> internals need to be changed while also being hashed against the
>>>>>> CPUClass so we can handle different register sets per-vCPU in
>>>>>> hetrogenous situations.
>>>>>> Having an internal state within the plugins also allows us to expand
>>>>>> the interface in future (for example providing callbacks on register
>>>>>> change if the translator can track changes).
>>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>>>>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> <snip>
>>>>>> +/*
>>>>>> + * Register handles
>>>>>> + *
>>>>>> + * The plugin infrastructure keeps hold of these internal data
>>>>>> + * structures which are presented to plugins as opaque handles. They
>>>>>> + * are global to the system and therefor additions to the hash table
>>>>>> + * must be protected by the @reg_handle_lock.
>>>>>> + *
>>>>>> + * In order to future proof for up-coming heterogeneous work we want
>>>>>> + * different entries for each CPU type while sharing them in the
>>>>>> + * common case of multiple cores of the same type.
>>>>>> + */
>>>>>> +
>>>>>> +static QemuMutex reg_handle_lock;
>>>>>> +
>>>>>> +struct qemu_plugin_register {
>>>>>> +    const char *name;
>>>>>> +    int gdb_reg_num;
>>>>>> +};
>>>>>> +
>>>>>> +static GHashTable *reg_handles; /* hash table of PluginReg */
>>>>>> +
>>>>>> +/* Generate a stable key - would xxhash be overkill? */
>>>>>> +static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
>>>>>> +{
>>>>>> +    uintptr_t key =3D (uintptr_t) cs->cc;
>>>>>> +    key ^=3D gdb_regnum;
>>>>>> +    return GUINT_TO_POINTER(key);
>>>>>> +}
>>>>>
>>>>> I have pointed out this is theoretically prone to collisions and
>>>>> unsafe.
>>>> How is it unsafe? The aim is to share handles for the same CPUClass
>>>> rather than having a unique handle per register/cpu combo.
>>>
>>> THe intention is legitimate, but the implementation is not safe. It
>>> assumes (uintptr)cs->cc ^ gdb_regnum is unique, but there is no such
>>> guarantee. The key of GHashTable must be unique; generating hashes of
>>> keys should be done with hash_func given to g_hash_table_new().
>> This isn't a hash its a non-unique key. It is however unique for
>> the same register on the same class of CPU so for each vCPU in a system
>> can share the same opaque handles.
>> The hashing is done internally by glib. We would assert if there was
>> a
>> duplicate key referring to a different register.
>> I'm unsure what you want here? Do you have a suggestion for the key
>> generation algorithm? As the comment notes I did consider a more complex
>> mixing algorithm using xxhash but that wouldn't guarantee no clash
>> either.
>
> I suggest using a struct that holds both of cs->cc and gdb_regnum, and
> pass g_direct_equal() and g_direct_hash() to g_hash_table_new().

We already do:

        if (!reg_handles) {
            reg_handles =3D g_hash_table_new(g_direct_hash, g_direct_equal);
        }

But we can't use g_direct_equal with something that exceeds the width of
gpointer as it is a straight equality test of the key. What you are
suggesting requires allocating memory for each key and de-referencing
with a custom GEqualFunc.=20

This seems overkill for something that as I have said doesn't happen.
The reason it doesn't happen is you will never see two CPUClass
instances so close to each other they share all bits apart from where
gdb_regnum is being xor'd. We could assert that is the case with
something like:

  #define MAX_GDBREGS 300

  /* Generate a stable key - would xxhash be overkill? */
  static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
  {
      uintptr_t key =3D (uintptr_t) cs->cc;

      qemu_build_assert(sizeof(*cs->cc) >=3D MAX_GDBREGS);
      g_assert(gdb_regnum < MAX_GDBREGS);

      key ^=3D gdb_regnum;
      return GUINT_TO_POINTER(key);
  }

although MAX_GDBREGS is currently a guess based on aarch64. In practice
though there are so many allocations thing are much farther apart. As we
can see in the one heterogeneous model we support at the moment (the
last 2 CPUs are cortex-r5f's):

  ./qemu-system-aarch64 -M xlnx-zcu102 -audio none -smp 6 -serial mon:stdio=
 -s -S -smp 6
  cpu_common_class_init: k =3D 0x5565bebf10f0
  arm_cpu_initfn: 0x7f32ee0a8360 -> klass =3D 0x5565bee50e00
  aarch64_cpu_instance_init: 0x7f32ee0a8360 -> klass =3D 0x5565bee50e00
  arm_cpu_initfn: 0x7f32ee0be1f0 -> klass =3D 0x5565bee50e00
  aarch64_cpu_instance_init: 0x7f32ee0be1f0 -> klass =3D 0x5565bee50e00
  arm_cpu_initfn: 0x7f32ee0d4080 -> klass =3D 0x5565bee50e00
  aarch64_cpu_instance_init: 0x7f32ee0d4080 -> klass =3D 0x5565bee50e00
  arm_cpu_initfn: 0x7f32ee0e9f10 -> klass =3D 0x5565bee50e00
  aarch64_cpu_instance_init: 0x7f32ee0e9f10 -> klass =3D 0x5565bee50e00
  arm_cpu_initfn: 0x7f32ee0ffda0 -> klass =3D 0x5565bed0fad0
  arm_cpu_initfn: 0x7f32ee115c30 -> klass =3D 0x5565bed0fad0

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

