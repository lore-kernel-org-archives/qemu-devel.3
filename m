Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7C6C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 10:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd6Bh-0004I9-9W; Thu, 22 Feb 2024 05:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rd6BZ-0004EJ-LT
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:20:15 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rd6BW-0002qK-6M
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:20:13 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412767742a0so11699545e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708597207; x=1709202007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jiWMgJUdgs0EZkxYpQKw5I50KnwQG9cdaRqRRe9tB0E=;
 b=Dp/X98EV9L9I/co+IlOHxWhXaMeSb34lAKJu6epivU694RIfD9cZyfdVHp4Q6cN1mT
 Ga2P7HRiYImCIFYg8EwvrgwBSL+LItbOay0+xL7roU4pcb6fYId52uo7IyXVjXP2Gw9y
 YXo6IN635npsAciU27WjM61+rsuzJv4PebRd+7gv1HDjtDTJLNskFCowD4mRYzCpjKn4
 sODL1z5GujH/on1ewqQA7s40Zgk9DY7mzqAZap4VOyoJcjjZOUxu0xA0DjN2uVWb2y80
 tPcur7nd/HFrRQD//vO8K9XXjWbJdG80LQP+BPH9/j+J9K5JTsVFDGVNhnWgQ26hz01c
 7MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708597207; x=1709202007;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jiWMgJUdgs0EZkxYpQKw5I50KnwQG9cdaRqRRe9tB0E=;
 b=m6ItsQevnQF0DuJpBmIMjL3tft+svWFP3JE8cG4879eSt/nXZDFl6Sq7ywLH8ar2La
 YAa2we/bwXnOh3vHlR3dQ2rNOJ9yucCTxQaVIR6fDil8QLh9UpqhqyeUr0CEjO/OQQ/1
 OZoeNGiodY+pXkyvvzuL3RxeeFpfgfwRclApCKt4xjOiSsMTmNcREbi5q6z+4dx03pOL
 qkl6rjf9tJaEaSj6DHRWodcUao0gZPVg6jfnJbFpOJFC1jnHPiT24rf6XxnkhcPO3h6p
 Iy/Scx+2UrVGWkmj7ptJxr5SwKG1L/8NLyrSrGD9/TXElzlCu/9UWyxO/t7ysVf/FZbf
 vZCA==
X-Gm-Message-State: AOJu0Yzea/Gtm9ZyWQKVdCnSpigIgmiLDMpEsABgyjiU3h3l9PoZ/zzT
 bkveOjzf1YLpXcjsNDWn2OpbnFfX878omyEcgqZgWVKXB70vknpzLuSlN4y3fsE=
X-Google-Smtp-Source: AGHT+IGagpflXl0Q+sJxm/1/BwlmqXguQPkxKsB2I/xNIh8AfHBeTa7UQ4cb6xnY2FFWG6Nt5QWBwg==
X-Received: by 2002:a05:600c:3554:b0:412:78ac:f343 with SMTP id
 i20-20020a05600c355400b0041278acf343mr2603999wmq.19.1708597207437; 
 Thu, 22 Feb 2024 02:20:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k14-20020a5d428e000000b0033ce5b3390esm19846382wrq.38.2024.02.22.02.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 02:20:06 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2FAB35F89B;
 Thu, 22 Feb 2024 10:20:06 +0000 (GMT)
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
In-Reply-To: <7e4b4ba6-3683-464f-ac37-3b7f19455643@daynix.com> (Akihiko
 Odaki's message of "Thu, 22 Feb 2024 15:37:10 +0900")
References: <20240216163025.424857-1-alex.bennee@linaro.org>
 <20240216163025.424857-19-alex.bennee@linaro.org>
 <c38a22b5-01e8-40f1-bfc4-4bba9bf7b516@daynix.com>
 <87il2jcje8.fsf@draig.linaro.org>
 <bf31a250-9539-448c-9c64-4168ab8741f1@daynix.com>
 <87bk8ab0f4.fsf@draig.linaro.org>
 <bf5e9471-c09f-47f2-a5a3-83713255c47a@daynix.com>
 <87zfvtaoqq.fsf@draig.linaro.org>
 <7e4b4ba6-3683-464f-ac37-3b7f19455643@daynix.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Thu, 22 Feb 2024 10:20:06 +0000
Message-ID: <87cysoajhl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

> On 2024/02/21 23:14, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> On 2024/02/21 19:02, Alex Benn=C3=A9e wrote:
>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>
>>>>> On 2024/02/20 23:14, Alex Benn=C3=A9e wrote:
>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>
>>>>>>> On 2024/02/17 1:30, Alex Benn=C3=A9e wrote:
>>>>>>>> We can only request a list of registers once the vCPU has been
>>>>>>>> initialised so the user needs to use either call the get function =
on
>>>>>>>> vCPU initialisation or during the translation phase.
>>>>>>>> We don't expose the reg number to the plugin instead hiding it
>>>>>>>> behind
>>>>>>>> an opaque handle. This allows for a bit of future proofing should =
the
>>>>>>>> internals need to be changed while also being hashed against the
>>>>>>>> CPUClass so we can handle different register sets per-vCPU in
>>>>>>>> hetrogenous situations.
>>>>>>>> Having an internal state within the plugins also allows us to expa=
nd
>>>>>>>> the interface in future (for example providing callbacks on regist=
er
>>>>>>>> change if the translator can track changes).
>>>>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>>>>>>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>>>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>> <snip>
>>>>>>>> +/*
>>>>>>>> + * Register handles
>>>>>>>> + *
>>>>>>>> + * The plugin infrastructure keeps hold of these internal data
>>>>>>>> + * structures which are presented to plugins as opaque handles. T=
hey
>>>>>>>> + * are global to the system and therefor additions to the hash ta=
ble
>>>>>>>> + * must be protected by the @reg_handle_lock.
>>>>>>>> + *
>>>>>>>> + * In order to future proof for up-coming heterogeneous work we w=
ant
>>>>>>>> + * different entries for each CPU type while sharing them in the
>>>>>>>> + * common case of multiple cores of the same type.
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +static QemuMutex reg_handle_lock;
>>>>>>>> +
>>>>>>>> +struct qemu_plugin_register {
>>>>>>>> +    const char *name;
>>>>>>>> +    int gdb_reg_num;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static GHashTable *reg_handles; /* hash table of PluginReg */
>>>>>>>> +
>>>>>>>> +/* Generate a stable key - would xxhash be overkill? */
>>>>>>>> +static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
>>>>>>>> +{
>>>>>>>> +    uintptr_t key =3D (uintptr_t) cs->cc;
>>>>>>>> +    key ^=3D gdb_regnum;
>>>>>>>> +    return GUINT_TO_POINTER(key);
>>>>>>>> +}
>>>>>>>
>>>>>>> I have pointed out this is theoretically prone to collisions and
>>>>>>> unsafe.
>>>>>> How is it unsafe? The aim is to share handles for the same CPUClass
>>>>>> rather than having a unique handle per register/cpu combo.
>>>>>
>>>>> THe intention is legitimate, but the implementation is not safe. It
>>>>> assumes (uintptr)cs->cc ^ gdb_regnum is unique, but there is no such
>>>>> guarantee. The key of GHashTable must be unique; generating hashes of
>>>>> keys should be done with hash_func given to g_hash_table_new().
>>>> This isn't a hash its a non-unique key. It is however unique for
>>>> the same register on the same class of CPU so for each vCPU in a system
>>>> can share the same opaque handles.
>>>> The hashing is done internally by glib. We would assert if there was
>>>> a
>>>> duplicate key referring to a different register.
>>>> I'm unsure what you want here? Do you have a suggestion for the key
>>>> generation algorithm? As the comment notes I did consider a more compl=
ex
>>>> mixing algorithm using xxhash but that wouldn't guarantee no clash
>>>> either.
>>>
>>> I suggest using a struct that holds both of cs->cc and gdb_regnum, and
>>> pass g_direct_equal() and g_direct_hash() to g_hash_table_new().
>> We already do:
>>          if (!reg_handles) {
>>              reg_handles =3D g_hash_table_new(g_direct_hash, g_direct_eq=
ual);
>>          }
>> But we can't use g_direct_equal with something that exceeds the
>> width of
>> gpointer as it is a straight equality test of the key. What you are
>> suggesting requires allocating memory for each key and de-referencing
>> with a custom GEqualFunc.
>
> My bad. I wrongly remembered g_direct_equal() and g_direct_hash(). It
> indeed seems to need a more complicated solution.
>
> It is possible to write a GEqualFunc and a GHashFunc that consumes a
> struct but it is a chore. How about having a two-level GHashTable?
> reg_handles will be a GHashTable keyed with cs->cc, and another
> GHashTable will be keyed with gdb_regnum.

That still seems overkill for a clash that can't happen. What do you
think about the following:

  /*
   * Generate a stable key shared across CPUs of the same class
   *
   * In order to future proof for up-coming heterogeneous work we want
   * different entries for each CPU type while sharing them in the
   * common case of multiple cores of the same type. This makes the
   * assumption you won't see two CPUClass pointers that are similar
   * enough that the low bits mixed with different registers numbers
   * will give you the same key.
   *
   * The build time assert will fire if CPUClass goes on a sudden diet
   * and we assert further down if we detect two keys representing
   * different regnums. In practice allocations of CPUClass are much
   * farther apart making clashes practically impossible.
   */
  static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
  {
      uintptr_t key =3D (uintptr_t) cs->cc;

      /* this protects some of the assumptions above */
      qemu_build_assert(sizeof(*cs->cc) >=3D 256);

      key ^=3D gdb_regnum;
      return GUINT_TO_POINTER(key);
  }



--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

