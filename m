Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00409C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 18:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVDma-0001my-Ct; Fri, 27 Jun 2025 14:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uVDmY-0001mn-MB
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:26:38 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uVDmV-00059l-Ty
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:26:38 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ae35f36da9dso23995966b.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751048792; x=1751653592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENYYprJU8AnyiQCkKpwcesoh8/iWLjsE2ljcGvGeq+Y=;
 b=wqV/Ej3xbZM3Bb0yQCCL4wfBBzjaAeMw3rPnzVafmNXISz3BD/78qx9FYf1s75ufWr
 3QeYWqv1l+vYg5J4avE6QQK+YzG6WM3y9HchamcN9lgnJhW2qjtmMmU8lBLjqqmDOgiW
 DeA0ACWGwUG8K+1dCGX8RgzmXomziRh1EoApnwCDCRPjq/zvD3LtEprGomEQy7yfT/oC
 u2v2Uiy+A6ra9YTWviJxJ6+fQFG56QaIRAoEiyN8JDleB5+KF2Wg7mP7tOX4nehUrCZS
 bqSmDJSNJHHGkEA2fDqN1b3ey6ldpgxdMkH4OkhfFZONfQwtnUMwL6AxVwu+3hv1N5EF
 ja+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751048792; x=1751653592;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ENYYprJU8AnyiQCkKpwcesoh8/iWLjsE2ljcGvGeq+Y=;
 b=pBc+GphRMpT3c85l/Mlbx/cVFgC3ouJE/iFPc3hSwaOElTsCDwDRsJ4IBIRrPzxjq1
 wf3+cC/IcAEsNT5aY4zFiaTDbJx0VCdJB8K3RdNlxHK1SolIevnP4SXCILk45OzDAX+R
 TBffsadB8TJ9R9S8rc+5jJS0XxXq8cdcOBPLGthmebxyIqV+iku/W4xnCNbYETXpS7Fo
 0mkOHNWRS250Lxgo8fjyoSZBnGGJ0UR4u811ribM9xmwJdVYbnu8xpD3Lvh34M9DISIP
 c+TeEEVTsy3VZznh2QFntWrhFyApryFDAu6SVs5+PA4fkBNpacIMFbVoUuycH7nbr0uB
 Xfbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkj5nBh6m4vCcfzMiz/9TFtmZ+On51QGzfumZ6C78toD5BwaK02Rt7lq5Pw/YlNi+Xq/sKtJOE158V@nongnu.org
X-Gm-Message-State: AOJu0YzPNt7RQVxSWc/z2LvNWu9W0yhRTItciCN8cuNzruWZ/UROqLjD
 gWoci8tlODrWmwslkGgvG29wMB3rGR0L/t9qG1sEuhoiG2JOUruYb+w0c0UcGLPgttc=
X-Gm-Gg: ASbGnctsvTP89ibq9RCB1+JSzq0kYXF/9QmDk2mArfHtW2jQkPWyHZr0xRJ2NZLyfgS
 PC+Wl9EYI+/mdihlJwIGBUtzNDomwFIX2w2iPBqGftq2ABG8NEq7dxPkDu52lO3M8pKFh2uUdqk
 0Hwb+SjoSYJU9ndLxk8nJIVLwNUt/ROue9wKI+EQ/+Y2A199srkp6W8G+v/pI+Omm2xZnmOTuJ2
 eEVb4BVgJ/anTHIzTwwcAlg/lRtOL+ZlHd3sUQRmwNFolHiLa3gs5dsFNi51g70b4JHjPCNhD9i
 dTs4EqqETu95NeIOtjd223mSHFucrE99jVW1Wv8q5nI5xL+2tw46nUsaOfgvD8Y=
X-Google-Smtp-Source: AGHT+IHWXq9jNVylK9gI7O0uSnrWEZ3g+3HoRCRIQFVj85kBRBd+yqwQ4wPUdnT0r//9h0Lgty1fOw==
X-Received: by 2002:a17:907:6d17:b0:ad8:9e5b:9217 with SMTP id
 a640c23a62f3a-ae350195a75mr394565866b.45.1751048792369; 
 Fri, 27 Jun 2025 11:26:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c6bfa4sm167510266b.139.2025.06.27.11.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 11:26:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 286125F82D;
 Fri, 27 Jun 2025 19:26:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Rowan Hart <rowanbhart@gmail.com>,  qemu-devel@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Eduardo
 Habkost <eduardo@habkost.net>,  Zhao Liu <zhao1.liu@intel.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v14 0/8] Add additional plugin API functions to read and
 write memory and registers
In-Reply-To: <5f50e512-818f-465a-970e-04873ee2dc77@linaro.org> (Pierrick
 Bouvier's message of "Fri, 27 Jun 2025 09:18:00 -0700")
References: <20250624175351.440780-1-rowanbhart@gmail.com>
 <87o6ubzxfw.fsf@draig.linaro.org> <87cyaqzcft.fsf@draig.linaro.org>
 <5606f27e-48c1-40fa-9453-f76f87fecd2e@linaro.org>
 <877c0xzgpw.fsf@draig.linaro.org>
 <5f50e512-818f-465a-970e-04873ee2dc77@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 27 Jun 2025 19:26:30 +0100
Message-ID: <871pr5yrah.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 6/27/25 2:17 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> On 6/26/25 9:37 AM, Alex Benn=C3=A9e wrote:
>>>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>>>
>>>>> Rowan Hart <rowanbhart@gmail.com> writes:
>>>>>
>>>>>> This patch series adds several new API functions focused on enabling=
 use
>>>>>> cases around reading and writing guest memory from QEMU plugins. To =
support
>>>>>> these new APIs, some utility functionality around retrieving informa=
tion about
>>>>>> address spaces is added as well.
>>>>>
>>>>> Queued to plugins/next, thanks.
>>>> So this fails a number of the CI tests, mostly due to 32 bit issues:
>>>>     https://gitlab.com/stsquad/qemu/-/pipelines/1890883927/failures
>>>> The tci failure is easy enough:
>>>> --8<---------------cut here---------------start------------->8---
>>>> modified   tests/tcg/x86_64/Makefile.softmmu-target
>>>> @@ -34,9 +34,11 @@ memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D1
>>>>    # Running
>>>>    QEMU_OPTS+=3D-device isa-debugcon,chardev=3Doutput -device isa-debu=
g-exit,iobase=3D0xf4,iosize=3D0x4 -kernel
>>>>    +ifeq ($(CONFIG_PLUGIN),y)
>>>>    run-plugin-patch-target-with-libpatch.so:		\
>>>>    	PLUGIN_ARGS=3D$(COMMA)target=3Dffc0$(COMMA)patch=3D9090$(COMMA)use=
_hwaddr=3Dtrue
>>>>    run-plugin-patch-target-with-libpatch.so:		\
>>>>    	CHECK_PLUGIN_OUTPUT_COMMAND=3D$(X64_SYSTEM_SRC)/validate-patch.py =
$@.out
>>>>    run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
>>>>    EXTRA_RUNS+=3Drun-plugin-patch-target-with-libpatch.so
>>>> +endif
>>>> --8<---------------cut here---------------end--------------->8---
>>>> The other problem is trying to stuff a uint64_t into a void * on 32
>>>> bit.
>>>> We did disable plugins for 32 bit but then reverted because we were ab=
le
>>>> to fixup the cases:
>>>>    cf2a78cbbb (deprecation: don't enable TCG plugins by default on 32
>>>> bit hosts)
>>>>    db7a06ade1 (configure: reenable plugins by default for 32-bit hosts)
>>>> So I don't what is easier:
>>>>    - re-deprecate for 32 bit systems
>>>>    - only build libpatch on 64 bit systems
>>>>    - fix libpatch to handle being built on 32 bit systems
>>>>
>>>
>>> More context:
>>> ../tests/tcg/plugins/patch.c: In function =E2=80=98patch_hwaddr=E2=80=
=99:
>>> ../tests/tcg/plugins/patch.c:50:21: error: cast from pointer to
>>> integer of different size [-Werror=3Dpointer-to-int-cast]
>>>     50 |     uint64_t addr =3D (uint64_t)userdata;
>>>        |                     ^
>>> ../tests/tcg/plugins/patch.c: In function =E2=80=98patch_vaddr=E2=80=99:
>>> ../tests/tcg/plugins/patch.c:93:21: error: cast from pointer to
>>> integer of different size [-Werror=3Dpointer-to-int-cast]
>>>     93 |     uint64_t addr =3D (uint64_t)userdata;
>>>        |                     ^
>>> ../tests/tcg/plugins/patch.c: In function =E2=80=98vcpu_tb_trans_cb=E2=
=80=99:
>>> ../tests/tcg/plugins/patch.c:159:54: error: cast to pointer from
>>> integer of different size [-Werror=3Dint-to-pointer-cast]
>>>    159 |                                                      (void *)a=
ddr);
>>>        |                                                      ^
>>> ../tests/tcg/plugins/patch.c:163:54: error: cast to pointer from
>>> integer of different size [-Werror=3Dint-to-pointer-cast]
>>>    163 |                                                      (void *)a=
ddr);
>>>        |
>>>
>>> Since we disabled 64 bit targets on 32 bit hosts, and that data passed
>>> by pointers concern addresses, it should be safe to cast values to
>>> (uintptr_t) instead of (uint64_t).
>> Something like this?
>> --8<---------------cut here---------------start------------->8---
>> modified   tests/tcg/plugins/patch.c
>> @@ -47,10 +47,10 @@ static GByteArray *str_to_bytes(const char *str)
>>     static void patch_hwaddr(unsigned int vcpu_index, void
>> *userdata)
>>   {
>> -    uint64_t addr =3D (uint64_t)userdata;
>> +    uintptr_t addr =3D (uintptr_t) userdata;
>>       g_autoptr(GString) str =3D g_string_new(NULL);
>>       g_string_printf(str, "patching: @0x%"
>> -                    PRIx64 "\n",
>> +                    PRIxPTR "\n",
>>                       addr);
>>       qemu_plugin_outs(str->str);
>>   @@ -90,7 +90,7 @@ static void patch_hwaddr(unsigned int
>> vcpu_index, void *userdata)
>>     static void patch_vaddr(unsigned int vcpu_index, void *userdata)
>>   {
>> -    uint64_t addr =3D (uint64_t)userdata;
>> +    uintptr_t addr =3D (uintptr_t) userdata;
>>       uint64_t hwaddr =3D 0;
>>       if (!qemu_plugin_translate_vaddr(addr, &hwaddr)) {
>>           qemu_plugin_outs("Failed to translate vaddr\n");
>> @@ -98,7 +98,7 @@ static void patch_vaddr(unsigned int vcpu_index, void =
*userdata)
>>       }
>>       g_autoptr(GString) str =3D g_string_new(NULL);
>>       g_string_printf(str, "patching: @0x%"
>> -                    PRIx64 " hw: @0x%" PRIx64 "\n",
>> +                    PRIxPTR " hw: @0x%" PRIx64 "\n",
>>                       addr, hwaddr);
>>       qemu_plugin_outs(str->str);
>>   @@ -132,19 +132,29 @@ static void patch_vaddr(unsigned int
>> vcpu_index, void *userdata)
>>    */
>>   static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_t=
b *tb)
>>   {
>> -    uint64_t addr =3D 0;
>>       g_autoptr(GByteArray) insn_data =3D g_byte_array_new();
>> +    uintptr_t addr =3D 0;
>> +
>>       for (size_t i =3D 0; i < qemu_plugin_tb_n_insns(tb); i++) {
>>           struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, =
i);
>> +        uint64_t vaddr =3D qemu_plugin_insn_vaddr(insn);
>>             if (use_hwaddr) {
>> -            uint64_t vaddr =3D qemu_plugin_insn_vaddr(insn);
>> -            if (!qemu_plugin_translate_vaddr(vaddr, &addr)) {
>> +            uint64_t hwaddr =3D 0;
>> +            if (!qemu_plugin_translate_vaddr(vaddr, &hwaddr)) {
>>                   qemu_plugin_outs("Failed to translate vaddr\n");
>>                   continue;
>>               }
>> +            /*
>> +             * As we cannot emulate 64 bit systems on 32 bit hosts we
>> +             * should never see the top bits set, hence we can safely
>> +             * cast to uintptr_t.
>> +             */
>> +            g_assert(!(hwaddr & ~UINTPTR_MAX));
>
> We would have so many other problems before plugins if this hypothesis
> was not true (all the usage of vaddr type in the codebase would be
> broken). So the assert will not detect anything we are not aware about
> already.
>
> If we want to mention this assumption for plugins users, the plugins
> documentation is probably a better place than one random plugin.

Well we could change the API function signature to return uintptr_t?

>
>> +            addr =3D (uintptr_t) hwaddr;
>>           } else {
>> -            addr =3D qemu_plugin_insn_vaddr(insn);
>> +            g_assert(!(vaddr & ~UINTPTR_MAX));
>> +            addr =3D (uintptr_t) vaddr;
>>           }
>>             g_byte_array_set_size(insn_data,
>> qemu_plugin_insn_size(insn));
>> @@ -156,11 +166,11 @@ static void vcpu_tb_trans_cb(qemu_plugin_id_t id, =
struct qemu_plugin_tb *tb)
>>               if (use_hwaddr) {
>>                   qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_hwaddr,
>>                                                        QEMU_PLUGIN_CB_NO=
_REGS,
>> -                                                     (void *)addr);
>> +                                                     (void *) addr);
>>               } else {
>>                   qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_vaddr,
>>                                                        QEMU_PLUGIN_CB_NO=
_REGS,
>> -                                                     (void *)addr);
>> +                                                     (void *) addr);
>>               }
>>           }
>>       }
>> --8<---------------cut here---------------end--------------->8---
>>=20
>>>
>>> Pierrick
>>=20
>
> For the rest, it looks good to me.
>
> Thanks,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

