Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B339C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQtT-0004tO-Um; Tue, 20 Feb 2024 09:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcQtS-0004pO-LG
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:14:46 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcQtO-00026J-Pc
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:14:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4127077ee20so3464125e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 06:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708438481; x=1709043281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4YdIyD0hVjOSXtIyxUzS/JjRkKD0j2OyT2fYi9Hp98=;
 b=G+xE5Vmf5dSzKZKudz61C+liV0tj08xgQUnMekkBc9fDivulma09rF9gLtnqyrktDv
 y1V1HtLpRBnjn1qo/U2tRDmbTefg7gW4MA8hSCJOborPt2rSxo71Lxf+4P4B5WYEHdd9
 p8VFNvSxdb2eYh/bT3AOB9iyKDh4KBhNhfYVZd2hexgK9RHKx1OibGj26f+K9EQdvMxN
 XZGkDhaRs/rQ2hu5VhuwKL4nip5S+SodT8nOdfXpuqeyGrlJdxqOs+6H3ffpzu1re+lP
 2zmHepwJwyQmdwQZfB4v6GxhQQa2/FmcjYV0XLLV9hhfWrmW6iAbAGzQ/rR7PBIjQFOt
 jMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708438481; x=1709043281;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m4YdIyD0hVjOSXtIyxUzS/JjRkKD0j2OyT2fYi9Hp98=;
 b=Tfj1odjmuqfsrOAWzk4OcPVshBy+ZkYO6PJ9rflFnYwK1+A/PldNZGvu664LmuSg81
 cRBEIIAN9AbXVcb01TYL/RC11Hzk7gBvUexkuOqUJXIV249M0U543iyAIrlYo1Rx8vKy
 c4GNRjw/m1clGjRmx0Boi/8QcnqVGpkYOC0SGch2vZMNRqmUzhv9Ra+t1OxiWdJnFDCj
 2050lnQCx408efpgJGrdJpP/vcz8LRwXcfyec8EI2ok1IJSdd0JeZ62LQBY1BKjebQfS
 EakrA3FuCJXYgW9qgjlXtGL+s7OJpZyWR3f6acGE/CWVu5wKL2af2vTgMiTpBy3K7rgm
 rZWw==
X-Gm-Message-State: AOJu0YxYwRwMW/z1kKrU9vog+BelZDHuDzepK2zLUXDcm90VaAjNpMGC
 l9wg6FGk41dp35J0VwQaMPv3s8Im0g4ZWJETqvt8eJF4ArmT06YsFo+7GkCA04E=
X-Google-Smtp-Source: AGHT+IGi2xQQFG9wQLn18fXcsjoWIoEC18HSgFupx86Oi1tjYmCHg41s57tzHsiyGz4Jc9azVVmH4w==
X-Received: by 2002:a05:600c:3b8d:b0:40f:d3d8:c8d5 with SMTP id
 n13-20020a05600c3b8d00b0040fd3d8c8d5mr11375526wms.9.1708438480842; 
 Tue, 20 Feb 2024 06:14:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 6-20020a05600c22c600b004120537210esm14712214wmg.46.2024.02.20.06.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 06:14:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E689B5F85F;
 Tue, 20 Feb 2024 14:14:39 +0000 (GMT)
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
In-Reply-To: <c38a22b5-01e8-40f1-bfc4-4bba9bf7b516@daynix.com> (Akihiko
 Odaki's message of "Sat, 17 Feb 2024 17:01:19 +0900")
References: <20240216163025.424857-1-alex.bennee@linaro.org>
 <20240216163025.424857-19-alex.bennee@linaro.org>
 <c38a22b5-01e8-40f1-bfc4-4bba9bf7b516@daynix.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Tue, 20 Feb 2024 14:14:39 +0000
Message-ID: <87il2jcje8.fsf@draig.linaro.org>
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

> On 2024/02/17 1:30, Alex Benn=C3=A9e wrote:
>> We can only request a list of registers once the vCPU has been
>> initialised so the user needs to use either call the get function on
>> vCPU initialisation or during the translation phase.
>> We don't expose the reg number to the plugin instead hiding it
>> behind
>> an opaque handle. This allows for a bit of future proofing should the
>> internals need to be changed while also being hashed against the
>> CPUClass so we can handle different register sets per-vCPU in
>> hetrogenous situations.
>> Having an internal state within the plugins also allows us to expand
>> the interface in future (for example providing callbacks on register
>> change if the translator can track changes).
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
<snip>
>> +/*
>> + * Register handles
>> + *
>> + * The plugin infrastructure keeps hold of these internal data
>> + * structures which are presented to plugins as opaque handles. They
>> + * are global to the system and therefor additions to the hash table
>> + * must be protected by the @reg_handle_lock.
>> + *
>> + * In order to future proof for up-coming heterogeneous work we want
>> + * different entries for each CPU type while sharing them in the
>> + * common case of multiple cores of the same type.
>> + */
>> +
>> +static QemuMutex reg_handle_lock;
>> +
>> +struct qemu_plugin_register {
>> +    const char *name;
>> +    int gdb_reg_num;
>> +};
>> +
>> +static GHashTable *reg_handles; /* hash table of PluginReg */
>> +
>> +/* Generate a stable key - would xxhash be overkill? */
>> +static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
>> +{
>> +    uintptr_t key =3D (uintptr_t) cs->cc;
>> +    key ^=3D gdb_regnum;
>> +    return GUINT_TO_POINTER(key);
>> +}
>
> I have pointed out this is theoretically prone to collisions and
> unsafe.

How is it unsafe? The aim is to share handles for the same CPUClass
rather than having a unique handle per register/cpu combo.

Indeed if I add the following:

--8<---------------cut here---------------start------------->8---
   plugins/api.c
@@ -482,6 +482,9 @@ static GArray *create_register_handles(CPUState *cs, GA=
rray *gdbstub_regs)
                 val->name =3D g_intern_string(grd->name);
=20
                 g_hash_table_insert(reg_handles, key, val);
+            } else {
+                /* make sure its not a clash */
+                g_assert(val->gdb_reg_num =3D=3D grd->gdb_reg);
             }
=20
             /* Create a record for the plugin */
modified   tests/plugin/insn.c
@@ -46,6 +46,25 @@ typedef struct {
     char *disas;
 } Instruction;
=20
+/*
+ * Initialise a new vcpu with reading the register list
+ */
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    g_autoptr(GArray) reg_list =3D qemu_plugin_get_registers();
+    g_autoptr(GByteArray) reg_value =3D g_byte_array_new();
+
+    if (reg_list) {
+        for (int i =3D 0; i < reg_list->len; i++) {
+            qemu_plugin_reg_descriptor *rd =3D &g_array_index(
+                reg_list, qemu_plugin_reg_descriptor, i);
+            int count =3D qemu_plugin_read_register(rd->handle, reg_value);
+            g_assert(count > 0);
+        }
+    }
+}
+
+
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
     unsigned int i =3D cpu_index % MAX_CPUS;
@@ -212,6 +231,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_=
id_t id,
         sizes =3D g_array_new(true, true, sizeof(unsigned long));
     }
=20
+    /* Register init, translation block and exit callbacks */
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
--8<---------------cut here---------------end--------------->8---

Nothing trips up during check-tcg (after I fixed "gdbstub: Infer number
of core registers from XML" to remove the microblaze check on
cc->gdb_num_core_regs).

>
>> +
>> +/*
>> + * Create register handles.
>> + *
>> + * We need to create a handle for each register so the plugin
>> + * infrastructure can call gdbstub to read a register. We also
>> + * construct a result array with those handles and some ancillary data
>> + * the plugin might find useful.
>> + */
>> +
>> +static GArray *create_register_handles(CPUState *cs, GArray *gdbstub_re=
gs)
>> +{
>> +    GArray *find_data =3D g_array_new(true, true,
>> +                                    sizeof(qemu_plugin_reg_descriptor));
>> +
>> +    WITH_QEMU_LOCK_GUARD(&reg_handle_lock) {
>> +
>> +        if (!reg_handles) {
>> +            reg_handles =3D g_hash_table_new(g_direct_hash, g_direct_eq=
ual);
>> +        }
>> +
>> +        for (int i =3D 0; i < gdbstub_regs->len; i++) {
>> +            GDBRegDesc *grd =3D &g_array_index(gdbstub_regs, GDBRegDesc=
, i);
>> +            gpointer key =3D cpu_plus_reg_to_key(cs, grd->gdb_reg);
>> +            struct qemu_plugin_register *val =3D g_hash_table_lookup(re=
g_handles,
>> +                                                                   key);
>> +
>> +            /* skip "un-named" regs */
>> +            if (!grd->name) {
>> +                continue;
>> +            }
>> +
>> +            /* Doesn't exist, create one */
>> +            if (!val) {
>> +                val =3D g_new0(struct qemu_plugin_register, 1);
>> +                val->gdb_reg_num =3D grd->gdb_reg;
>> +                val->name =3D g_intern_string(grd->name);
>> +
>> +                g_hash_table_insert(reg_handles, key, val);
>> +            }
>> +
>> +            /* Create a record for the plugin */
>> +            qemu_plugin_reg_descriptor desc =3D {
>> +                .handle =3D val,
>> +                .name =3D val->name,
>> +                .feature =3D g_intern_string(grd->feature_name)
>> +            };
>> +            g_array_append_val(find_data, desc);
>> +        }
>> +    }
>> +
>> +    return find_data;
>> +}
>> +
>> +GArray *qemu_plugin_get_registers(void)
>> +{
>> +    g_assert(current_cpu);
>> +
>> +    g_autoptr(GArray) regs =3D gdb_get_register_list(current_cpu);
>> +    return regs->len ? create_register_handles(current_cpu, regs) : NUL=
L;
>> +}
>> +
>> +int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteAr=
ray *buf)
>> +{
>> +    g_assert(current_cpu);
>> +
>> +    return gdb_read_register(current_cpu, buf, reg->gdb_reg_num);
>> +}
>> +
>> +static void __attribute__((__constructor__)) qemu_api_init(void)
>> +{
>> +    qemu_mutex_init(&reg_handle_lock);
>> +
>> +}
>> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
>> index adb67608598..27fe97239be 100644
>> --- a/plugins/qemu-plugins.symbols
>> +++ b/plugins/qemu-plugins.symbols
>> @@ -3,6 +3,7 @@
>>     qemu_plugin_end_code;
>>     qemu_plugin_entry_code;
>>     qemu_plugin_get_hwaddr;
>> +  qemu_plugin_get_registers;
>>     qemu_plugin_hwaddr_device_name;
>>     qemu_plugin_hwaddr_is_io;
>>     qemu_plugin_hwaddr_phys_addr;
>> @@ -19,6 +20,7 @@
>>     qemu_plugin_num_vcpus;
>>     qemu_plugin_outs;
>>     qemu_plugin_path_to_binary;
>> +  qemu_plugin_read_register;
>>     qemu_plugin_register_atexit_cb;
>>     qemu_plugin_register_flush_cb;
>>     qemu_plugin_register_vcpu_exit_cb;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

