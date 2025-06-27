Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C7CC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 09:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5D5-0008Qd-Bf; Fri, 27 Jun 2025 05:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV5D2-0008QN-00
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:17:24 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV5Cz-000202-Dv
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:17:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4537deebb01so10164675e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751015838; x=1751620638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlwfZ/DMde9PmjH8WTe39bnLEYxPuc0WEJC29xKRYAs=;
 b=l6FKJA2cEZJ/DOv3IjhK7SjIASSkB+lnx1U4FAlukLwDxkueGlSHJeN0sWy4Bd/0vC
 ujDzadIJJfttUlOeKa28WbUh19Wb3TXg5/QgMaD22QnhfLhlA6Xn2FZRg8MyFdQVXXlN
 vEeGEKyTRky3hspFNIN2hpqdV+qD/WgUDDum2LngqNi2HlAD3/ZDLJUOuR74l3vP08rT
 oazEI7pjbgi7Vrx+EA/OJb4SV2s3pUNUD1xPz4/pIQWzGViH4nm+0gK15fAB5KtU2rGh
 K5J54zWJ+BkEG9Q3Szb9xesoXUauCJbytxJQbLGAfUFKzgZd2txNVGtmLmU5LfhWVqCi
 arfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751015838; x=1751620638;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SlwfZ/DMde9PmjH8WTe39bnLEYxPuc0WEJC29xKRYAs=;
 b=FtMHXFXiiW22ht+eS77xwv3rsbxbb3IYM1nKFP1QhmNpCRxT84tGxe6SHPCJ0seHW0
 gxNXzjhtFWBeSHB+Vv4Tl06S/cqkk/KbkA0DUs7uA4cUYE6wRCpx5YY2Bu7JqT8g0HzF
 yawBhfK4lCDS6WA+Z6AVYUHDuMmxOEMTHrVAwQlkkiQpP8YoMcV5iwQMahDxfV0nyZPl
 WYpj2/99IWRO7HnY3D+efWtjv711CtX3QhvaYSkBdw5hnK4vWQpA/FDFvd1PzQjZIpl3
 ifN7V54S9MllZZ/i3C7c6DFZGbIry/1Ufb07ACL2U6nld+FgHnSMqYxlS3g6Vbm7xOGi
 U84Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWtfdJl38/95983PLWfl1PUia2j0TOi6oTBoM1UXzqPz7dSenC7p5hxPS4o907GXpWV8FqCSi6wOia@nongnu.org
X-Gm-Message-State: AOJu0YxIFyZg79nws5tl5rddEV8+ImNjcKerOz04aUzxuzCWumgzGQSq
 UuaDoSM/rvwTg7WinFam/H+tVkWe1ybstC6TYkYLWx8stJt13hnmXDyH3OZsD0jtB/E=
X-Gm-Gg: ASbGncuLRc+IzlED/z51rvy3ChNkRvPXSusj6B5pgeZajIO8FYl7BFyvIkXk9dEjPwB
 sZTwWxFUfrdZ1d1FdIOfRuBPgqbCB7POX9S2kY1rhKTP6MlmF10Kiy8wefZcDWBSQQCbjC2lSVg
 Wjp++xhq25oNkjJbbm2b968n+EIgT5rJntxWJdQmNXpw+eynM6rSaWRh8HhnhBS3pbOY9imb/f9
 vSJJaqfL2v9rmsZEjjv6DEykm1IqZN+M8/oYaT1m65wLZIhboRFzKgmyFsB6icBGEjzKt9zQQUU
 x59zzHk4TjMgtuYJdiv1v0BG0ECBpMdpe7I15HQNf95+kYGRW3s+3NIpg+k6Zzc=
X-Google-Smtp-Source: AGHT+IEVoxvsEeTA4yrwItx3qhPdkR2CZB3G9C+bOjtZx1uKXgCsW7mjWJQirzOyJEwj2Tys4c3EDA==
X-Received: by 2002:a05:600c:1907:b0:440:61eb:2ce5 with SMTP id
 5b1f17b1804b1-4538ee61fddmr27597345e9.17.1751015838533; 
 Fri, 27 Jun 2025 02:17:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a8048sm45786065e9.9.2025.06.27.02.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 02:17:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7BA95F82D;
 Fri, 27 Jun 2025 10:17:15 +0100 (BST)
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
In-Reply-To: <5606f27e-48c1-40fa-9453-f76f87fecd2e@linaro.org> (Pierrick
 Bouvier's message of "Thu, 26 Jun 2025 11:23:03 -0700")
References: <20250624175351.440780-1-rowanbhart@gmail.com>
 <87o6ubzxfw.fsf@draig.linaro.org> <87cyaqzcft.fsf@draig.linaro.org>
 <5606f27e-48c1-40fa-9453-f76f87fecd2e@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 27 Jun 2025 10:17:15 +0100
Message-ID: <877c0xzgpw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

> On 6/26/25 9:37 AM, Alex Benn=C3=A9e wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>>> Rowan Hart <rowanbhart@gmail.com> writes:
>>>
>>>> This patch series adds several new API functions focused on enabling u=
se
>>>> cases around reading and writing guest memory from QEMU plugins. To su=
pport
>>>> these new APIs, some utility functionality around retrieving informati=
on about
>>>> address spaces is added as well.
>>>
>>> Queued to plugins/next, thanks.
>> So this fails a number of the CI tests, mostly due to 32 bit issues:
>>    https://gitlab.com/stsquad/qemu/-/pipelines/1890883927/failures
>> The tci failure is easy enough:
>> --8<---------------cut here---------------start------------->8---
>> modified   tests/tcg/x86_64/Makefile.softmmu-target
>> @@ -34,9 +34,11 @@ memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D1
>>   # Running
>>   QEMU_OPTS+=3D-device isa-debugcon,chardev=3Doutput -device isa-debug-e=
xit,iobase=3D0xf4,iosize=3D0x4 -kernel
>>   +ifeq ($(CONFIG_PLUGIN),y)
>>   run-plugin-patch-target-with-libpatch.so:		\
>>   	PLUGIN_ARGS=3D$(COMMA)target=3Dffc0$(COMMA)patch=3D9090$(COMMA)use_hw=
addr=3Dtrue
>>   run-plugin-patch-target-with-libpatch.so:		\
>>   	CHECK_PLUGIN_OUTPUT_COMMAND=3D$(X64_SYSTEM_SRC)/validate-patch.py $@.=
out
>>   run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
>>   EXTRA_RUNS+=3Drun-plugin-patch-target-with-libpatch.so
>> +endif
>> --8<---------------cut here---------------end--------------->8---
>> The other problem is trying to stuff a uint64_t into a void * on 32
>> bit.
>> We did disable plugins for 32 bit but then reverted because we were able
>> to fixup the cases:
>>   cf2a78cbbb (deprecation: don't enable TCG plugins by default on 32
>> bit hosts)
>>   db7a06ade1 (configure: reenable plugins by default for 32-bit hosts)
>> So I don't what is easier:
>>   - re-deprecate for 32 bit systems
>>   - only build libpatch on 64 bit systems
>>   - fix libpatch to handle being built on 32 bit systems
>>=20
>
> More context:
> ../tests/tcg/plugins/patch.c: In function =E2=80=98patch_hwaddr=E2=80=99:
> ../tests/tcg/plugins/patch.c:50:21: error: cast from pointer to
> integer of different size [-Werror=3Dpointer-to-int-cast]
>    50 |     uint64_t addr =3D (uint64_t)userdata;
>       |                     ^
> ../tests/tcg/plugins/patch.c: In function =E2=80=98patch_vaddr=E2=80=99:
> ../tests/tcg/plugins/patch.c:93:21: error: cast from pointer to
> integer of different size [-Werror=3Dpointer-to-int-cast]
>    93 |     uint64_t addr =3D (uint64_t)userdata;
>       |                     ^
> ../tests/tcg/plugins/patch.c: In function =E2=80=98vcpu_tb_trans_cb=E2=80=
=99:
> ../tests/tcg/plugins/patch.c:159:54: error: cast to pointer from
> integer of different size [-Werror=3Dint-to-pointer-cast]
>   159 |                                                      (void *)addr=
);
>       |                                                      ^
> ../tests/tcg/plugins/patch.c:163:54: error: cast to pointer from
> integer of different size [-Werror=3Dint-to-pointer-cast]
>   163 |                                                      (void *)addr=
);
>       |
>
> Since we disabled 64 bit targets on 32 bit hosts, and that data passed
> by pointers concern addresses, it should be safe to cast values to
> (uintptr_t) instead of (uint64_t).

Something like this?

--8<---------------cut here---------------start------------->8---
modified   tests/tcg/plugins/patch.c
@@ -47,10 +47,10 @@ static GByteArray *str_to_bytes(const char *str)
=20
 static void patch_hwaddr(unsigned int vcpu_index, void *userdata)
 {
-    uint64_t addr =3D (uint64_t)userdata;
+    uintptr_t addr =3D (uintptr_t) userdata;
     g_autoptr(GString) str =3D g_string_new(NULL);
     g_string_printf(str, "patching: @0x%"
-                    PRIx64 "\n",
+                    PRIxPTR "\n",
                     addr);
     qemu_plugin_outs(str->str);
=20
@@ -90,7 +90,7 @@ static void patch_hwaddr(unsigned int vcpu_index, void *u=
serdata)
=20
 static void patch_vaddr(unsigned int vcpu_index, void *userdata)
 {
-    uint64_t addr =3D (uint64_t)userdata;
+    uintptr_t addr =3D (uintptr_t) userdata;
     uint64_t hwaddr =3D 0;
     if (!qemu_plugin_translate_vaddr(addr, &hwaddr)) {
         qemu_plugin_outs("Failed to translate vaddr\n");
@@ -98,7 +98,7 @@ static void patch_vaddr(unsigned int vcpu_index, void *us=
erdata)
     }
     g_autoptr(GString) str =3D g_string_new(NULL);
     g_string_printf(str, "patching: @0x%"
-                    PRIx64 " hw: @0x%" PRIx64 "\n",
+                    PRIxPTR " hw: @0x%" PRIx64 "\n",
                     addr, hwaddr);
     qemu_plugin_outs(str->str);
=20
@@ -132,19 +132,29 @@ static void patch_vaddr(unsigned int vcpu_index, void=
 *userdata)
  */
 static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *t=
b)
 {
-    uint64_t addr =3D 0;
     g_autoptr(GByteArray) insn_data =3D g_byte_array_new();
+    uintptr_t addr =3D 0;
+
     for (size_t i =3D 0; i < qemu_plugin_tb_n_insns(tb); i++) {
         struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);
+        uint64_t vaddr =3D qemu_plugin_insn_vaddr(insn);
=20
         if (use_hwaddr) {
-            uint64_t vaddr =3D qemu_plugin_insn_vaddr(insn);
-            if (!qemu_plugin_translate_vaddr(vaddr, &addr)) {
+            uint64_t hwaddr =3D 0;
+            if (!qemu_plugin_translate_vaddr(vaddr, &hwaddr)) {
                 qemu_plugin_outs("Failed to translate vaddr\n");
                 continue;
             }
+            /*
+             * As we cannot emulate 64 bit systems on 32 bit hosts we
+             * should never see the top bits set, hence we can safely
+             * cast to uintptr_t.
+             */
+            g_assert(!(hwaddr & ~UINTPTR_MAX));
+            addr =3D (uintptr_t) hwaddr;
         } else {
-            addr =3D qemu_plugin_insn_vaddr(insn);
+            g_assert(!(vaddr & ~UINTPTR_MAX));
+            addr =3D (uintptr_t) vaddr;
         }
=20
         g_byte_array_set_size(insn_data, qemu_plugin_insn_size(insn));
@@ -156,11 +166,11 @@ static void vcpu_tb_trans_cb(qemu_plugin_id_t id, str=
uct qemu_plugin_tb *tb)
             if (use_hwaddr) {
                 qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_hwaddr,
                                                      QEMU_PLUGIN_CB_NO_REG=
S,
-                                                     (void *)addr);
+                                                     (void *) addr);
             } else {
                 qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_vaddr,
                                                      QEMU_PLUGIN_CB_NO_REG=
S,
-                                                     (void *)addr);
+                                                     (void *) addr);
             }
         }
     }
--8<---------------cut here---------------end--------------->8---


>
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

