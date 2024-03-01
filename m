Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D68C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 10:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg01z-0002nv-4B; Fri, 01 Mar 2024 05:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg01w-0002gv-M2
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:22:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg01t-00067Q-LF
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:22:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-412b83cfac4so13501205e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 02:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709288529; x=1709893329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYAOp0fBxRiqlstxwQZi4lSu4q04mRIAyZbZhG2aGrc=;
 b=SzbHvLpZsDdGqNcgr8jmK9QJyajgci1cJ5j1ytVhSnJq8e/3OpzMWdS7HKY2PZ+GJy
 SN074a/YPjAIJItnzXv3nTQKnFkWmtEdFh40sq6m5V98OBV8LZ4dHRM8fat2twwxp2HM
 O11A33FpTGiSYJsplwhsOABjk4HrOFoGUJyDGLAPcvu6YmKVnsYrtSg0rLv6gm4ACOGI
 HiMM+p6mWvHdZg/2kYscOuwv6zOgdoBQRtFRHnpAO7wtanskc6SJEPhgwPqTZspbs67s
 iGhXg7DQo7abOoAPAmEazraOEz/SrvX5/21ikC5whlqnX+LgKPi1LFfbdAdUpHznqTt4
 Kqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709288529; x=1709893329;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PYAOp0fBxRiqlstxwQZi4lSu4q04mRIAyZbZhG2aGrc=;
 b=jfD0WedwKdH34bwjkHdFisgtrED6jOHPNORWhY+C6YoeldDQxOcvCwvw2Ubo+ujqEP
 jkdaeXfQTWL9OnUKf43DvhCiYmcusBVAlnKxHbhHXaEIluv27bdio3FRuONKHZm63wqo
 ZEEIL4HvoMVMMMqk9+JhkMksbI88VjS7nqHbRJWMmJrj5aq3Tx/lDU9lZXGpEwvZ94T2
 M2oTSUq/KhPgUppJhPi/8o977vsUj0tpneiQJHzgnt6ibAQDEIKyeglFHS2DybHjizz6
 QESzUnECzK464h0rajmaSducnvqJx4Hx/aoKkpOfmLS95WWPHfXHGqXTJu/NkHGaOPGO
 Z5MA==
X-Gm-Message-State: AOJu0Yz3XDU1c5sGG9ks6bFSil4tsbnvAF13VHLnNkzT9FxFPAoqcIF1
 3eKaTNoYIQLXY5X8JX2e2r1esBhRd2AQ+OBMZsb/yU+AYZ8NMDGxzIKhtB+l+No=
X-Google-Smtp-Source: AGHT+IGY3iELUTU1yL+z37AdtZwcHu0H6qyNfLYdocGWJ3ruuQty3pL92iJRK38P8aK/zTwGkI2xUg==
X-Received: by 2002:a05:6000:12c5:b0:33e:1e0d:658c with SMTP id
 l5-20020a05600012c500b0033e1e0d658cmr802879wrx.70.1709288529123; 
 Fri, 01 Mar 2024 02:22:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n8-20020a056000170800b0033e2291fbc0sm500200wrc.68.2024.03.01.02.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 02:22:08 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5F82F5F78A;
 Fri,  1 Mar 2024 10:22:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PULL 26/29] contrib/plugins: extend execlog to track register
 changes
In-Reply-To: <ZeGBl5eJoJ0PLrW3@intel.com> (Zhao Liu's message of "Fri, 1 Mar
 2024 15:19:51 +0800")
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
 <20240228115701.1416107-27-alex.bennee@linaro.org>
 <ZeGBl5eJoJ0PLrW3@intel.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Fri, 01 Mar 2024 10:22:08 +0000
Message-ID: <87msri5k1b.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Hi Alex,
>
> I hit the following warnings (with "./configure --enable-werror"):
>
> /qemu/contrib/plugins/execlog.c: In function =E2=80=98registers_init=E2=
=80=99:
> /qemu/contrib/plugins/execlog.c:330:17: warning: =E2=80=98g_pattern_match=
_string=E2=80=99 is deprecated: Use 'g_pattern_spec_match_string' instead [=
-Wdeprecated-declarations]
>   330 |                 if (g_pattern_match_string(pat, rd->name) ||
>       |                 ^~
> In file included from /usr/include/glib-2.0/glib.h:65,
>                  from /qemu/contrib/plugins/execlog.c:9:
> /usr/include/glib-2.0/glib/gpattern.h:55:15: note: declared here
>    55 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
>       |               ^~~~~~~~~~~~~~~~~~~~~~
> /qemu/contrib/plugins/execlog.c:331:21: warning: =E2=80=98g_pattern_match=
_string=E2=80=99 is deprecated: Use 'g_pattern_spec_match_string' instead [=
-Wdeprecated-declarations]
>   331 |                     g_pattern_match_string(pat, rd_lower)) {
>       |                     ^~~~~~~~~~~~~~~~~~~~~~
> In file included from /usr/include/glib-2.0/glib.h:65,
>                  from /qemu/contrib/plugins/execlog.c:9:
> /usr/include/glib-2.0/glib/gpattern.h:55:15: note: declared here
>    55 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
>       |               ^~~~~~~~~~~~~~~~~~~~~~
> /qemu/contrib/plugins/execlog.c:339:63: warning: passing argument 2 of =
=E2=80=98g_ptr_array_add=E2=80=99 discards =E2=80=98const=E2=80=99 qualifie=
r from pointer target type [-Wdiscarded-qualifiers]
>   339 |                             g_ptr_array_add(all_reg_names,
> reg->name);

Hmm I missed that. Not sure what the neatest solution is in this case -
g_ptr_array_new() doesn't have a destroy func so we shouldn't ever
attempt to free it. We can manually re-add the const qualifier at the
other end for completeness and I guess comment and cast?


>       |                                                            ~~~^~~=
~~~
> In file included from /usr/include/glib-2.0/glib.h:31,
>                  from /qemu/contrib/plugins/execlog.c:9:
> /usr/include/glib-2.0/glib/garray.h:192:62: note: expected =E2=80=98gpoin=
ter=E2=80=99 {aka =E2=80=98void *=E2=80=99} but argument is of type =E2=80=
=98const char *=E2=80=99
>   192 |                                            gpointer          data=
);
>       |                                            ~~~~~~~~~~~~~~~~~~^~~~
>
> In addition, I checked my glic version:
>
> $ldd --version
> ldd (Ubuntu GLIBC 2.35-0ubuntu3.5) 2.35
>
> I think it's v2.35. Are these three warning reports valid?

It's the glib (not glibc) version that matters here.
g_pattern_match_string was deprecated in 2.70 when the suggested
alternative was added. However our baseline for glib is still:

  # When bumping glib minimum version, please check also whether to increase
  # the _WIN32_WINNT setting in osdep.h according to the value from glib
  glib_req_ver =3D '>=3D2.56.0'
  glib_pc =3D dependency('glib-2.0', version: glib_req_ver, required: true,
                      method: 'pkg-config')

The usual solution for this is to throw in a compat wrapper in
glib-compat.h:

--8<---------------cut here---------------start------------->8---
modified   include/glib-compat.h
@@ -105,6 +105,24 @@ static inline gpointer g_memdup2_qemu(gconstpointer me=
m, gsize byte_size)
 }
 #define g_memdup2(m, s) g_memdup2_qemu(m, s)
=20
+/*
+ * g_pattern_match_string has been deprecated in Glib since 2.70 and
+ * will complain about it if you try to use it. Fortunately the
+ * signature of both functions is the same making it easy to work
+ * around.
+ */
+static inline
+gboolean g_pattern_spec_match_string_qemu(GPatternSpec *pspec,
+                                          const gchar *string)
+{
+#if GLIB_CHECK_VERSION(2, 70, 0)
+    return g_pattern_spec_match_string(pspec, string);
+#else
+    return g_pattern_match_string(pspec, string);
+#endif
+};
+#define g_pattern_spec_match_string(p, s) g_pattern_spec_match_string_qemu=
(p, s)
+
 #if defined(G_OS_UNIX)
 /*
  * Note: The fallback implementation is not MT-safe, and it returns a copy=
 of
modified   contrib/plugins/execlog.c
@@ -334,8 +334,8 @@ static void registers_init(int vcpu_index)
             for (int p =3D 0; p < rmatches->len; p++) {
                 g_autoptr(GPatternSpec) pat =3D g_pattern_spec_new(rmatche=
s->pdata[p]);
                 g_autofree gchar *rd_lower =3D g_utf8_strdown(rd->name, -1=
);
-                if (g_pattern_match_string(pat, rd->name) ||
-                    g_pattern_match_string(pat, rd_lower)) {
+                if (g_pattern_spec_match_string(pat, rd->name) ||
+                    g_pattern_spec_match_string(pat, rd_lower)) {
                     Register *reg =3D init_vcpu_register(vcpu_index, rd);
                     g_ptr_array_add(registers, reg);
--8<---------------cut here---------------end--------------->8---

but I hesitated to add it for this case as plugins shouldn't assume they
have access to QEMU's internals. Maybe the glib-compat.h header could be
treated as a special case.

>
> I also noticed in target/arm/helper.c, there's another
> g_pattern_match_string() but I haven't met the warning.

Hmm that's weird. I suspect glib suppresses the warnings with:

  /* Ask for warnings for anything that was marked deprecated in
   * the defined version, or before. It is a candidate for rewrite.
   */
  #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_56


>
> Regards,
> Zhao
>
> On Wed, Feb 28, 2024 at 11:56:58AM +0000, Alex Benn=C3=A9e wrote:
>> Date: Wed, 28 Feb 2024 11:56:58 +0000
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Subject: [PULL 26/29] contrib/plugins: extend execlog to track register
>>  changes
>> X-Mailer: git-send-email 2.39.2
>>=20
>> With the new plugin register API we can now track changes to register
>> values. Currently the implementation is fairly dumb which will slow
>> down if a large number of register values are being tracked. This
>> could be improved by only instrumenting instructions which mention
>> registers we are interested in tracking.
>>=20
>> Example usage:
>>=20
>>   ./qemu-aarch64 -D plugin.log -d plugin \
>>      -cpu max,sve256=3Don \
>>      -plugin contrib/plugins/libexeclog.so,reg=3Dsp,reg=3Dz\* \
>>      ./tests/tcg/aarch64-linux-user/sha512-sve
>>=20
>> will display in the execlog any changes to the stack pointer (sp) and
>> the SVE Z registers.
>>=20
>> As testing registers every instruction will be quite a heavy operation
>> there is an additional flag which attempts to optimise the register
>> tracking by only instrumenting instructions which are likely to change
>> its value. This relies on the QEMU disassembler showing up the register
>> names in disassembly so is an explicit opt-in.
>>=20
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Based-On:  <20231025093128.33116-19-akihiko.odaki@daynix.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20240227144335.1196131-27-alex.bennee@linaro.org>
>>=20
>> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
>> index 81dcd43a612..fa7421279f5 100644
>> --- a/docs/devel/tcg-plugins.rst
>> +++ b/docs/devel/tcg-plugins.rst
>> @@ -497,6 +497,22 @@ arguments if required::
>>    $ qemu-system-arm $(QEMU_ARGS) \
>>      -plugin ./contrib/plugins/libexeclog.so,ifilter=3Dst1w,afilter=3D0x=
40001808 -d plugin
>>=20=20
>> +This plugin can also dump registers when they change value. Specify the=
 name of the
>> +registers with multiple ``reg`` options. You can also use glob style ma=
tching if you wish::
>> +
>> +  $ qemu-system-arm $(QEMU_ARGS) \
>> +    -plugin ./contrib/plugins/libexeclog.so,reg=3D\*_el2,reg=3Dsp -d pl=
ugin
>> +
>> +Be aware that each additional register to check will slow down
>> +execution quite considerably. You can optimise the number of register
>> +checks done by using the rdisas option. This will only instrument
>> +instructions that mention the registers in question in disassembly.
>> +This is not foolproof as some instructions implicitly change
>> +instructions. You can use the ifilter to catch these cases:
>> +
>> +  $ qemu-system-arm $(QEMU_ARGS) \
>> +    -plugin ./contrib/plugins/libexeclog.so,ifilter=3Dmsr,ifilter=3Dblr=
,reg=3Dx30,reg=3D\*_el1,rdisas=3Don
>> +
>>  - contrib/plugins/cache.c
>>=20=20
>>  Cache modelling plugin that measures the performance of a given L1 cache
>> @@ -583,4 +599,3 @@ The following API is generated from the inline docum=
entation in
>>  include the full kernel-doc annotations.
>>=20=20
>>  .. kernel-doc:: include/qemu/qemu-plugin.h
>> -
>> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>> index f262e5555eb..a1dfd59ab71 100644
>> --- a/contrib/plugins/execlog.c
>> +++ b/contrib/plugins/execlog.c
>> @@ -1,7 +1,7 @@
>>  /*
>>   * Copyright (C) 2021, Alexandre Iooss <erdnaxe@crans.org>
>>   *
>> - * Log instruction execution with memory access.
>> + * Log instruction execution with memory access and register changes
>>   *
>>   * License: GNU GPL, version 2 or later.
>>   *   See the COPYING file in the top-level directory.
>> @@ -15,29 +15,40 @@
>>=20=20
>>  #include <qemu-plugin.h>
>>=20=20
>> +typedef struct {
>> +    struct qemu_plugin_register *handle;
>> +    GByteArray *last;
>> +    GByteArray *new;
>> +    const char *name;
>> +} Register;
>> +
>> +typedef struct CPU {
>> +    /* Store last executed instruction on each vCPU as a GString */
>> +    GString *last_exec;
>> +    /* Ptr array of Register */
>> +    GPtrArray *registers;
>> +} CPU;
>> +
>>  QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>>=20=20
>> -/* Store last executed instruction on each vCPU as a GString */
>> -static GPtrArray *last_exec;
>> +static GArray *cpus;
>>  static GRWLock expand_array_lock;
>>=20=20
>>  static GPtrArray *imatches;
>>  static GArray *amatches;
>> +static GPtrArray *rmatches;
>> +static bool disas_assist;
>> +static GMutex add_reg_name_lock;
>> +static GPtrArray *all_reg_names;
>>=20=20
>> -/*
>> - * Expand last_exec array.
>> - *
>> - * As we could have multiple threads trying to do this we need to
>> - * serialise the expansion under a lock.
>> - */
>> -static void expand_last_exec(int cpu_index)
>> +static CPU *get_cpu(int vcpu_index)
>>  {
>> -    g_rw_lock_writer_lock(&expand_array_lock);
>> -    while (cpu_index >=3D last_exec->len) {
>> -        GString *s =3D g_string_new(NULL);
>> -        g_ptr_array_add(last_exec, s);
>> -    }
>> -    g_rw_lock_writer_unlock(&expand_array_lock);
>> +    CPU *c;
>> +    g_rw_lock_reader_lock(&expand_array_lock);
>> +    c =3D &g_array_index(cpus, CPU, vcpu_index);
>> +    g_rw_lock_reader_unlock(&expand_array_lock);
>> +
>> +    return c;
>>  }
>>=20=20
>>  /**
>> @@ -46,13 +57,10 @@ static void expand_last_exec(int cpu_index)
>>  static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
>>                       uint64_t vaddr, void *udata)
>>  {
>> -    GString *s;
>> +    CPU *c =3D get_cpu(cpu_index);
>> +    GString *s =3D c->last_exec;
>>=20=20
>>      /* Find vCPU in array */
>> -    g_rw_lock_reader_lock(&expand_array_lock);
>> -    g_assert(cpu_index < last_exec->len);
>> -    s =3D g_ptr_array_index(last_exec, cpu_index);
>> -    g_rw_lock_reader_unlock(&expand_array_lock);
>>=20=20
>>      /* Indicate type of memory access */
>>      if (qemu_plugin_mem_is_store(info)) {
>> @@ -73,32 +81,91 @@ static void vcpu_mem(unsigned int cpu_index, qemu_pl=
ugin_meminfo_t info,
>>  }
>>=20=20
>>  /**
>> - * Log instruction execution
>> + * Log instruction execution, outputting the last one.
>> + *
>> + * vcpu_insn_exec() is a copy and paste of vcpu_insn_exec_with_regs()
>> + * without the checking of register values when we've attempted to
>> + * optimise with disas_assist.
>>   */
>> -static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
>> +static void insn_check_regs(CPU *cpu)
>>  {
>> -    GString *s;
>> +    for (int n =3D 0; n < cpu->registers->len; n++) {
>> +        Register *reg =3D cpu->registers->pdata[n];
>> +        int sz;
>>=20=20
>> -    /* Find or create vCPU in array */
>> -    g_rw_lock_reader_lock(&expand_array_lock);
>> -    if (cpu_index >=3D last_exec->len) {
>> -        g_rw_lock_reader_unlock(&expand_array_lock);
>> -        expand_last_exec(cpu_index);
>> -        g_rw_lock_reader_lock(&expand_array_lock);
>> +        g_byte_array_set_size(reg->new, 0);
>> +        sz =3D qemu_plugin_read_register(reg->handle, reg->new);
>> +        g_assert(sz =3D=3D reg->last->len);
>> +
>> +        if (memcmp(reg->last->data, reg->new->data, sz)) {
>> +            GByteArray *temp =3D reg->last;
>> +            g_string_append_printf(cpu->last_exec, ", %s -> 0x", reg->n=
ame);
>> +            /* TODO: handle BE properly */
>> +            for (int i =3D sz; i >=3D 0; i--) {
>> +                g_string_append_printf(cpu->last_exec, "%02x",
>> +                                       reg->new->data[i]);
>> +            }
>> +            reg->last =3D reg->new;
>> +            reg->new =3D temp;
>> +        }
>> +    }
>> +}
>> +
>> +/* Log last instruction while checking registers */
>> +static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udat=
a)
>> +{
>> +    CPU *cpu =3D get_cpu(cpu_index);
>> +
>> +    /* Print previous instruction in cache */
>> +    if (cpu->last_exec->len) {
>> +        if (cpu->registers) {
>> +            insn_check_regs(cpu);
>> +        }
>> +
>> +        qemu_plugin_outs(cpu->last_exec->str);
>> +        qemu_plugin_outs("\n");
>> +    }
>> +
>> +    /* Store new instruction in cache */
>> +    /* vcpu_mem will add memory access information to last_exec */
>> +    g_string_printf(cpu->last_exec, "%u, ", cpu_index);
>> +    g_string_append(cpu->last_exec, (char *)udata);
>> +}
>> +
>> +/* Log last instruction while checking registers, ignore next */
>> +static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udat=
a)
>> +{
>> +    CPU *cpu =3D get_cpu(cpu_index);
>> +
>> +    /* Print previous instruction in cache */
>> +    if (cpu->last_exec->len) {
>> +        if (cpu->registers) {
>> +            insn_check_regs(cpu);
>> +        }
>> +
>> +        qemu_plugin_outs(cpu->last_exec->str);
>> +        qemu_plugin_outs("\n");
>>      }
>> -    s =3D g_ptr_array_index(last_exec, cpu_index);
>> -    g_rw_lock_reader_unlock(&expand_array_lock);
>> +
>> +    /* reset */
>> +    cpu->last_exec->len =3D 0;
>> +}
>> +
>> +/* Log last instruction without checking regs, setup next */
>> +static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
>> +{
>> +    CPU *cpu =3D get_cpu(cpu_index);
>>=20=20
>>      /* Print previous instruction in cache */
>> -    if (s->len) {
>> -        qemu_plugin_outs(s->str);
>> +    if (cpu->last_exec->len) {
>> +        qemu_plugin_outs(cpu->last_exec->str);
>>          qemu_plugin_outs("\n");
>>      }
>>=20=20
>>      /* Store new instruction in cache */
>>      /* vcpu_mem will add memory access information to last_exec */
>> -    g_string_printf(s, "%u, ", cpu_index);
>> -    g_string_append(s, (char *)udata);
>> +    g_string_printf(cpu->last_exec, "%u, ", cpu_index);
>> +    g_string_append(cpu->last_exec, (char *)udata);
>>  }
>>=20=20
>>  /**
>> @@ -111,6 +178,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struc=
t qemu_plugin_tb *tb)
>>  {
>>      struct qemu_plugin_insn *insn;
>>      bool skip =3D (imatches || amatches);
>> +    bool check_regs_this =3D rmatches;
>> +    bool check_regs_next =3D false;
>>=20=20
>>      size_t n =3D qemu_plugin_tb_n_insns(tb);
>>      for (size_t i =3D 0; i < n; i++) {
>> @@ -131,7 +200,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struc=
t qemu_plugin_tb *tb)
>>          /*
>>           * If we are filtering we better check out if we have any
>>           * hits. The skip "latches" so we can track memory accesses
>> -         * after the instruction we care about.
>> +         * after the instruction we care about. Also enable register
>> +         * checking on the next instruction.
>>           */
>>          if (skip && imatches) {
>>              int j;
>> @@ -139,6 +209,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struc=
t qemu_plugin_tb *tb)
>>                  char *m =3D g_ptr_array_index(imatches, j);
>>                  if (g_str_has_prefix(insn_disas, m)) {
>>                      skip =3D false;
>> +                    check_regs_next =3D rmatches;
>>                  }
>>              }
>>          }
>> @@ -153,8 +224,39 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, stru=
ct qemu_plugin_tb *tb)
>>              }
>>          }
>>=20=20
>> +        /*
>> +         * Check the disassembly to see if a register we care about
>> +         * will be affected by this instruction. This relies on the
>> +         * dissembler doing something sensible for the registers we
>> +         * care about.
>> +         */
>> +        if (disas_assist && rmatches) {
>> +            check_regs_next =3D false;
>> +            gchar *args =3D g_strstr_len(insn_disas, -1, " ");
>> +            for (int n =3D 0; n < all_reg_names->len; n++) {
>> +                gchar *reg =3D g_ptr_array_index(all_reg_names, n);
>> +                if (g_strrstr(args, reg)) {
>> +                    check_regs_next =3D true;
>> +                    skip =3D false;
>> +                }
>> +            }
>> +        }
>> +
>> +        /*
>> +         * We now have 3 choices:
>> +         *
>> +         * - Log insn
>> +         * - Log insn while checking registers
>> +         * - Don't log this insn but check if last insn changed registe=
rs
>> +         */
>> +
>>          if (skip) {
>> -            g_free(insn_disas);
>> +            if (check_regs_this) {
>> +                qemu_plugin_register_vcpu_insn_exec_cb(insn,
>> +                                                       vcpu_insn_exec_o=
nly_regs,
>> +                                                       QEMU_PLUGIN_CB_R=
_REGS,
>> +                                                       NULL);
>> +            }
>>          } else {
>>              uint32_t insn_opcode;
>>              insn_opcode =3D *((uint32_t *)qemu_plugin_insn_data(insn));
>> @@ -167,30 +269,124 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, st=
ruct qemu_plugin_tb *tb)
>>                                               QEMU_PLUGIN_MEM_RW, NULL);
>>=20=20
>>              /* Register callback on instruction */
>> -            qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
>> -                                                   QEMU_PLUGIN_CB_NO_RE=
GS, output);
>> +            if (check_regs_this) {
>> +                qemu_plugin_register_vcpu_insn_exec_cb(
>> +                    insn, vcpu_insn_exec_with_regs,
>> +                    QEMU_PLUGIN_CB_R_REGS,
>> +                    output);
>> +            } else {
>> +                qemu_plugin_register_vcpu_insn_exec_cb(
>> +                    insn, vcpu_insn_exec,
>> +                    QEMU_PLUGIN_CB_NO_REGS,
>> +                    output);
>> +            }
>>=20=20
>>              /* reset skip */
>>              skip =3D (imatches || amatches);
>>          }
>>=20=20
>> +        /* set regs for next */
>> +        if (disas_assist && rmatches) {
>> +            check_regs_this =3D check_regs_next;
>> +        }
>> +
>> +        g_free(insn_disas);
>>      }
>>  }
>>=20=20
>> +static Register *init_vcpu_register(qemu_plugin_reg_descriptor *desc)
>> +{
>> +    Register *reg =3D g_new0(Register, 1);
>> +    g_autofree gchar *lower =3D g_utf8_strdown(desc->name, -1);
>> +    int r;
>> +
>> +    reg->handle =3D desc->handle;
>> +    reg->name =3D g_intern_string(lower);
>> +    reg->last =3D g_byte_array_new();
>> +    reg->new =3D g_byte_array_new();
>> +
>> +    /* read the initial value */
>> +    r =3D qemu_plugin_read_register(reg->handle, reg->last);
>> +    g_assert(r > 0);
>> +    return reg;
>> +}
>> +
>> +static GPtrArray *registers_init(int vcpu_index)
>> +{
>> +    g_autoptr(GPtrArray) registers =3D g_ptr_array_new();
>> +    g_autoptr(GArray) reg_list =3D qemu_plugin_get_registers();
>> +
>> +    if (rmatches && reg_list->len) {
>> +        /*
>> +         * Go through each register in the complete list and
>> +         * see if we want to track it.
>> +         */
>> +        for (int r =3D 0; r < reg_list->len; r++) {
>> +            qemu_plugin_reg_descriptor *rd =3D &g_array_index(
>> +                reg_list, qemu_plugin_reg_descriptor, r);
>> +            for (int p =3D 0; p < rmatches->len; p++) {
>> +                g_autoptr(GPatternSpec) pat =3D g_pattern_spec_new(rmat=
ches->pdata[p]);
>> +                g_autofree gchar *rd_lower =3D g_utf8_strdown(rd->name,=
 -1);
>> +                if (g_pattern_match_string(pat, rd->name) ||
>> +                    g_pattern_match_string(pat, rd_lower)) {
>> +                    Register *reg =3D init_vcpu_register(rd);
>> +                    g_ptr_array_add(registers, reg);
>> +
>> +                    /* we need a list of regnames at TB translation tim=
e */
>> +                    if (disas_assist) {
>> +                        g_mutex_lock(&add_reg_name_lock);
>> +                        if (!g_ptr_array_find(all_reg_names, reg->name,=
 NULL)) {
>> +                            g_ptr_array_add(all_reg_names, reg->name);
>> +                        }
>> +                        g_mutex_unlock(&add_reg_name_lock);
>> +                    }
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +    return registers->len ? g_steal_pointer(&registers) : NULL;
>> +}
>> +
>> +/*
>> + * Initialise a new vcpu/thread with:
>> + *   - last_exec tracking data
>> + *   - list of tracked registers
>> + *   - initial value of registers
>> + *
>> + * As we could have multiple threads trying to do this we need to
>> + * serialise the expansion under a lock.
>> + */
>> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>> +{
>> +    CPU *c;
>> +
>> +    g_rw_lock_writer_lock(&expand_array_lock);
>> +    if (vcpu_index >=3D cpus->len) {
>> +        g_array_set_size(cpus, vcpu_index + 1);
>> +    }
>> +    g_rw_lock_writer_unlock(&expand_array_lock);
>> +
>> +    c =3D get_cpu(vcpu_index);
>> +    c->last_exec =3D g_string_new(NULL);
>> +    c->registers =3D registers_init(vcpu_index);
>> +}
>> +
>>  /**
>>   * On plugin exit, print last instruction in cache
>>   */
>>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>>  {
>>      guint i;
>> -    GString *s;
>> -    for (i =3D 0; i < last_exec->len; i++) {
>> -        s =3D g_ptr_array_index(last_exec, i);
>> -        if (s->str) {
>> -            qemu_plugin_outs(s->str);
>> +    g_rw_lock_reader_lock(&expand_array_lock);
>> +    for (i =3D 0; i < cpus->len; i++) {
>> +        CPU *c =3D get_cpu(i);
>> +        if (c->last_exec && c->last_exec->str) {
>> +            qemu_plugin_outs(c->last_exec->str);
>>              qemu_plugin_outs("\n");
>>          }
>>      }
>> +    g_rw_lock_reader_unlock(&expand_array_lock);
>>  }
>>=20=20
>>  /* Add a match to the array of matches */
>> @@ -212,6 +408,18 @@ static void parse_vaddr_match(char *match)
>>      g_array_append_val(amatches, v);
>>  }
>>=20=20
>> +/*
>> + * We have to wait until vCPUs are started before we can check the
>> + * patterns find anything.
>> + */
>> +static void add_regpat(char *regpat)
>> +{
>> +    if (!rmatches) {
>> +        rmatches =3D g_ptr_array_new();
>> +    }
>> +    g_ptr_array_add(rmatches, g_strdup(regpat));
>> +}
>> +
>>  /**
>>   * Install the plugin
>>   */
>> @@ -223,11 +431,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plu=
gin_id_t id,
>>       * Initialize dynamic array to cache vCPU instruction. In user mode
>>       * we don't know the size before emulation.
>>       */
>> -    if (info->system_emulation) {
>> -        last_exec =3D g_ptr_array_sized_new(info->system.max_vcpus);
>> -    } else {
>> -        last_exec =3D g_ptr_array_new();
>> -    }
>> +    cpus =3D g_array_sized_new(true, true, sizeof(CPU),
>> +                             info->system_emulation ? info->system.max_=
vcpus : 1);
>>=20=20
>>      for (int i =3D 0; i < argc; i++) {
>>          char *opt =3D argv[i];
>> @@ -236,13 +441,22 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_pl=
ugin_id_t id,
>>              parse_insn_match(tokens[1]);
>>          } else if (g_strcmp0(tokens[0], "afilter") =3D=3D 0) {
>>              parse_vaddr_match(tokens[1]);
>> +        } else if (g_strcmp0(tokens[0], "reg") =3D=3D 0) {
>> +            add_regpat(tokens[1]);
>> +        } else if (g_strcmp0(tokens[0], "rdisas") =3D=3D 0) {
>> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &disas_as=
sist)) {
>> +                fprintf(stderr, "boolean argument parsing failed: %s\n"=
, opt);
>> +                return -1;
>> +            }
>> +            all_reg_names =3D g_ptr_array_new();
>>          } else {
>>              fprintf(stderr, "option parsing failed: %s\n", opt);
>>              return -1;
>>          }
>>      }
>>=20=20
>> -    /* Register translation block and exit callbacks */
>> +    /* Register init, translation block and exit callbacks */
>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>      qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>>=20=20
>> --=20
>> 2.39.2
>>=20
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

