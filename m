Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED33C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 07:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfwyd-0004aC-CS; Fri, 01 Mar 2024 02:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rfwyZ-0004Zw-J2
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:06:35 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rfwyU-0003Tu-64
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709276790; x=1740812790;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=68XP4YtqfhlxyjPcYbN0kCt66gNNqHsKY52+M+iFtE8=;
 b=TRN6rFPrIu2tWa9EqcJStAB+MIlvYiXv+jNIXwS+8AxDcVGTvwELjX2r
 x8pRwX2F6s/NBJEi3QCo2efmi+6rJFhAtMbVbFeKj2fj3l3h3lKFO52uF
 xm2UEqo++Bu5ifDszmr+yMfTujdvMZtagHYZ0mMMeifdjZsFnkZ1Y3uA5
 P094O9nrhULfGE518SPfbXzkh4lWHJ98NEAysG0vR838jMhqinpwLkAmz
 DzOBeU6O08V5obU/jgdcYQy5bvtklmLGkESt9Qo2PGtWPSISaSvhybb94
 n8y9IyE3ituJq8DUdNLAIRLOrFIrqAHIn6KPwHoxMQ6EFQCLVgQkbRoF8 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14505772"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; d="scan'208";a="14505772"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 23:06:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; d="scan'208";a="12792959"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 29 Feb 2024 23:06:07 -0800
Date: Fri, 1 Mar 2024 15:19:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 26/29] contrib/plugins: extend execlog to track register
 changes
Message-ID: <ZeGBl5eJoJ0PLrW3@intel.com>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
 <20240228115701.1416107-27-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228115701.1416107-27-alex.bennee@linaro.org>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Alex,

I hit the following warnings (with "./configure --enable-werror"):

/qemu/contrib/plugins/execlog.c: In function ¡®registers_init¡¯:
/qemu/contrib/plugins/execlog.c:330:17: warning: ¡®g_pattern_match_string¡¯ is deprecated: Use 'g_pattern_spec_match_string' instead [-Wdeprecated-declarations]
  330 |                 if (g_pattern_match_string(pat, rd->name) ||
      |                 ^~
In file included from /usr/include/glib-2.0/glib.h:65,
                 from /qemu/contrib/plugins/execlog.c:9:
/usr/include/glib-2.0/glib/gpattern.h:55:15: note: declared here
   55 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
      |               ^~~~~~~~~~~~~~~~~~~~~~
/qemu/contrib/plugins/execlog.c:331:21: warning: ¡®g_pattern_match_string¡¯ is deprecated: Use 'g_pattern_spec_match_string' instead [-Wdeprecated-declarations]
  331 |                     g_pattern_match_string(pat, rd_lower)) {
      |                     ^~~~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/glib-2.0/glib.h:65,
                 from /qemu/contrib/plugins/execlog.c:9:
/usr/include/glib-2.0/glib/gpattern.h:55:15: note: declared here
   55 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
      |               ^~~~~~~~~~~~~~~~~~~~~~
/qemu/contrib/plugins/execlog.c:339:63: warning: passing argument 2 of ¡®g_ptr_array_add¡¯ discards ¡®const¡¯ qualifier from pointer target type [-Wdiscarded-qualifiers]
  339 |                             g_ptr_array_add(all_reg_names, reg->name);
      |                                                            ~~~^~~~~~
In file included from /usr/include/glib-2.0/glib.h:31,
                 from /qemu/contrib/plugins/execlog.c:9:
/usr/include/glib-2.0/glib/garray.h:192:62: note: expected ¡®gpointer¡¯ {aka ¡®void *¡¯} but argument is of type ¡®const char *¡¯
  192 |                                            gpointer          data);
      |                                            ~~~~~~~~~~~~~~~~~~^~~~

In addition, I checked my glic version:

$ldd --version
ldd (Ubuntu GLIBC 2.35-0ubuntu3.5) 2.35

I think it's v2.35. Are these three warning reports valid?

I also noticed in target/arm/helper.c, there's another
g_pattern_match_string() but I haven't met the warning.

Regards,
Zhao

On Wed, Feb 28, 2024 at 11:56:58AM +0000, Alex Benn¨¦e wrote:
> Date: Wed, 28 Feb 2024 11:56:58 +0000
> From: Alex Benn¨¦e <alex.bennee@linaro.org>
> Subject: [PULL 26/29] contrib/plugins: extend execlog to track register
>  changes
> X-Mailer: git-send-email 2.39.2
> 
> With the new plugin register API we can now track changes to register
> values. Currently the implementation is fairly dumb which will slow
> down if a large number of register values are being tracked. This
> could be improved by only instrumenting instructions which mention
> registers we are interested in tracking.
> 
> Example usage:
> 
>   ./qemu-aarch64 -D plugin.log -d plugin \
>      -cpu max,sve256=on \
>      -plugin contrib/plugins/libexeclog.so,reg=sp,reg=z\* \
>      ./tests/tcg/aarch64-linux-user/sha512-sve
> 
> will display in the execlog any changes to the stack pointer (sp) and
> the SVE Z registers.
> 
> As testing registers every instruction will be quite a heavy operation
> there is an additional flag which attempts to optimise the register
> tracking by only instrumenting instructions which are likely to change
> its value. This relies on the QEMU disassembler showing up the register
> names in disassembly so is an explicit opt-in.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Based-On:  <20231025093128.33116-19-akihiko.odaki@daynix.com>
> Signed-off-by: Alex Benn¨¦e <alex.bennee@linaro.org>
> Message-Id: <20240227144335.1196131-27-alex.bennee@linaro.org>
> 
> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> index 81dcd43a612..fa7421279f5 100644
> --- a/docs/devel/tcg-plugins.rst
> +++ b/docs/devel/tcg-plugins.rst
> @@ -497,6 +497,22 @@ arguments if required::
>    $ qemu-system-arm $(QEMU_ARGS) \
>      -plugin ./contrib/plugins/libexeclog.so,ifilter=st1w,afilter=0x40001808 -d plugin
>  
> +This plugin can also dump registers when they change value. Specify the name of the
> +registers with multiple ``reg`` options. You can also use glob style matching if you wish::
> +
> +  $ qemu-system-arm $(QEMU_ARGS) \
> +    -plugin ./contrib/plugins/libexeclog.so,reg=\*_el2,reg=sp -d plugin
> +
> +Be aware that each additional register to check will slow down
> +execution quite considerably. You can optimise the number of register
> +checks done by using the rdisas option. This will only instrument
> +instructions that mention the registers in question in disassembly.
> +This is not foolproof as some instructions implicitly change
> +instructions. You can use the ifilter to catch these cases:
> +
> +  $ qemu-system-arm $(QEMU_ARGS) \
> +    -plugin ./contrib/plugins/libexeclog.so,ifilter=msr,ifilter=blr,reg=x30,reg=\*_el1,rdisas=on
> +
>  - contrib/plugins/cache.c
>  
>  Cache modelling plugin that measures the performance of a given L1 cache
> @@ -583,4 +599,3 @@ The following API is generated from the inline documentation in
>  include the full kernel-doc annotations.
>  
>  .. kernel-doc:: include/qemu/qemu-plugin.h
> -
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index f262e5555eb..a1dfd59ab71 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -1,7 +1,7 @@
>  /*
>   * Copyright (C) 2021, Alexandre Iooss <erdnaxe@crans.org>
>   *
> - * Log instruction execution with memory access.
> + * Log instruction execution with memory access and register changes
>   *
>   * License: GNU GPL, version 2 or later.
>   *   See the COPYING file in the top-level directory.
> @@ -15,29 +15,40 @@
>  
>  #include <qemu-plugin.h>
>  
> +typedef struct {
> +    struct qemu_plugin_register *handle;
> +    GByteArray *last;
> +    GByteArray *new;
> +    const char *name;
> +} Register;
> +
> +typedef struct CPU {
> +    /* Store last executed instruction on each vCPU as a GString */
> +    GString *last_exec;
> +    /* Ptr array of Register */
> +    GPtrArray *registers;
> +} CPU;
> +
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>  
> -/* Store last executed instruction on each vCPU as a GString */
> -static GPtrArray *last_exec;
> +static GArray *cpus;
>  static GRWLock expand_array_lock;
>  
>  static GPtrArray *imatches;
>  static GArray *amatches;
> +static GPtrArray *rmatches;
> +static bool disas_assist;
> +static GMutex add_reg_name_lock;
> +static GPtrArray *all_reg_names;
>  
> -/*
> - * Expand last_exec array.
> - *
> - * As we could have multiple threads trying to do this we need to
> - * serialise the expansion under a lock.
> - */
> -static void expand_last_exec(int cpu_index)
> +static CPU *get_cpu(int vcpu_index)
>  {
> -    g_rw_lock_writer_lock(&expand_array_lock);
> -    while (cpu_index >= last_exec->len) {
> -        GString *s = g_string_new(NULL);
> -        g_ptr_array_add(last_exec, s);
> -    }
> -    g_rw_lock_writer_unlock(&expand_array_lock);
> +    CPU *c;
> +    g_rw_lock_reader_lock(&expand_array_lock);
> +    c = &g_array_index(cpus, CPU, vcpu_index);
> +    g_rw_lock_reader_unlock(&expand_array_lock);
> +
> +    return c;
>  }
>  
>  /**
> @@ -46,13 +57,10 @@ static void expand_last_exec(int cpu_index)
>  static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
>                       uint64_t vaddr, void *udata)
>  {
> -    GString *s;
> +    CPU *c = get_cpu(cpu_index);
> +    GString *s = c->last_exec;
>  
>      /* Find vCPU in array */
> -    g_rw_lock_reader_lock(&expand_array_lock);
> -    g_assert(cpu_index < last_exec->len);
> -    s = g_ptr_array_index(last_exec, cpu_index);
> -    g_rw_lock_reader_unlock(&expand_array_lock);
>  
>      /* Indicate type of memory access */
>      if (qemu_plugin_mem_is_store(info)) {
> @@ -73,32 +81,91 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
>  }
>  
>  /**
> - * Log instruction execution
> + * Log instruction execution, outputting the last one.
> + *
> + * vcpu_insn_exec() is a copy and paste of vcpu_insn_exec_with_regs()
> + * without the checking of register values when we've attempted to
> + * optimise with disas_assist.
>   */
> -static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
> +static void insn_check_regs(CPU *cpu)
>  {
> -    GString *s;
> +    for (int n = 0; n < cpu->registers->len; n++) {
> +        Register *reg = cpu->registers->pdata[n];
> +        int sz;
>  
> -    /* Find or create vCPU in array */
> -    g_rw_lock_reader_lock(&expand_array_lock);
> -    if (cpu_index >= last_exec->len) {
> -        g_rw_lock_reader_unlock(&expand_array_lock);
> -        expand_last_exec(cpu_index);
> -        g_rw_lock_reader_lock(&expand_array_lock);
> +        g_byte_array_set_size(reg->new, 0);
> +        sz = qemu_plugin_read_register(reg->handle, reg->new);
> +        g_assert(sz == reg->last->len);
> +
> +        if (memcmp(reg->last->data, reg->new->data, sz)) {
> +            GByteArray *temp = reg->last;
> +            g_string_append_printf(cpu->last_exec, ", %s -> 0x", reg->name);
> +            /* TODO: handle BE properly */
> +            for (int i = sz; i >= 0; i--) {
> +                g_string_append_printf(cpu->last_exec, "%02x",
> +                                       reg->new->data[i]);
> +            }
> +            reg->last = reg->new;
> +            reg->new = temp;
> +        }
> +    }
> +}
> +
> +/* Log last instruction while checking registers */
> +static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
> +{
> +    CPU *cpu = get_cpu(cpu_index);
> +
> +    /* Print previous instruction in cache */
> +    if (cpu->last_exec->len) {
> +        if (cpu->registers) {
> +            insn_check_regs(cpu);
> +        }
> +
> +        qemu_plugin_outs(cpu->last_exec->str);
> +        qemu_plugin_outs("\n");
> +    }
> +
> +    /* Store new instruction in cache */
> +    /* vcpu_mem will add memory access information to last_exec */
> +    g_string_printf(cpu->last_exec, "%u, ", cpu_index);
> +    g_string_append(cpu->last_exec, (char *)udata);
> +}
> +
> +/* Log last instruction while checking registers, ignore next */
> +static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udata)
> +{
> +    CPU *cpu = get_cpu(cpu_index);
> +
> +    /* Print previous instruction in cache */
> +    if (cpu->last_exec->len) {
> +        if (cpu->registers) {
> +            insn_check_regs(cpu);
> +        }
> +
> +        qemu_plugin_outs(cpu->last_exec->str);
> +        qemu_plugin_outs("\n");
>      }
> -    s = g_ptr_array_index(last_exec, cpu_index);
> -    g_rw_lock_reader_unlock(&expand_array_lock);
> +
> +    /* reset */
> +    cpu->last_exec->len = 0;
> +}
> +
> +/* Log last instruction without checking regs, setup next */
> +static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
> +{
> +    CPU *cpu = get_cpu(cpu_index);
>  
>      /* Print previous instruction in cache */
> -    if (s->len) {
> -        qemu_plugin_outs(s->str);
> +    if (cpu->last_exec->len) {
> +        qemu_plugin_outs(cpu->last_exec->str);
>          qemu_plugin_outs("\n");
>      }
>  
>      /* Store new instruction in cache */
>      /* vcpu_mem will add memory access information to last_exec */
> -    g_string_printf(s, "%u, ", cpu_index);
> -    g_string_append(s, (char *)udata);
> +    g_string_printf(cpu->last_exec, "%u, ", cpu_index);
> +    g_string_append(cpu->last_exec, (char *)udata);
>  }
>  
>  /**
> @@ -111,6 +178,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>  {
>      struct qemu_plugin_insn *insn;
>      bool skip = (imatches || amatches);
> +    bool check_regs_this = rmatches;
> +    bool check_regs_next = false;
>  
>      size_t n = qemu_plugin_tb_n_insns(tb);
>      for (size_t i = 0; i < n; i++) {
> @@ -131,7 +200,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>          /*
>           * If we are filtering we better check out if we have any
>           * hits. The skip "latches" so we can track memory accesses
> -         * after the instruction we care about.
> +         * after the instruction we care about. Also enable register
> +         * checking on the next instruction.
>           */
>          if (skip && imatches) {
>              int j;
> @@ -139,6 +209,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>                  char *m = g_ptr_array_index(imatches, j);
>                  if (g_str_has_prefix(insn_disas, m)) {
>                      skip = false;
> +                    check_regs_next = rmatches;
>                  }
>              }
>          }
> @@ -153,8 +224,39 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>              }
>          }
>  
> +        /*
> +         * Check the disassembly to see if a register we care about
> +         * will be affected by this instruction. This relies on the
> +         * dissembler doing something sensible for the registers we
> +         * care about.
> +         */
> +        if (disas_assist && rmatches) {
> +            check_regs_next = false;
> +            gchar *args = g_strstr_len(insn_disas, -1, " ");
> +            for (int n = 0; n < all_reg_names->len; n++) {
> +                gchar *reg = g_ptr_array_index(all_reg_names, n);
> +                if (g_strrstr(args, reg)) {
> +                    check_regs_next = true;
> +                    skip = false;
> +                }
> +            }
> +        }
> +
> +        /*
> +         * We now have 3 choices:
> +         *
> +         * - Log insn
> +         * - Log insn while checking registers
> +         * - Don't log this insn but check if last insn changed registers
> +         */
> +
>          if (skip) {
> -            g_free(insn_disas);
> +            if (check_regs_this) {
> +                qemu_plugin_register_vcpu_insn_exec_cb(insn,
> +                                                       vcpu_insn_exec_only_regs,
> +                                                       QEMU_PLUGIN_CB_R_REGS,
> +                                                       NULL);
> +            }
>          } else {
>              uint32_t insn_opcode;
>              insn_opcode = *((uint32_t *)qemu_plugin_insn_data(insn));
> @@ -167,30 +269,124 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>                                               QEMU_PLUGIN_MEM_RW, NULL);
>  
>              /* Register callback on instruction */
> -            qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
> -                                                   QEMU_PLUGIN_CB_NO_REGS, output);
> +            if (check_regs_this) {
> +                qemu_plugin_register_vcpu_insn_exec_cb(
> +                    insn, vcpu_insn_exec_with_regs,
> +                    QEMU_PLUGIN_CB_R_REGS,
> +                    output);
> +            } else {
> +                qemu_plugin_register_vcpu_insn_exec_cb(
> +                    insn, vcpu_insn_exec,
> +                    QEMU_PLUGIN_CB_NO_REGS,
> +                    output);
> +            }
>  
>              /* reset skip */
>              skip = (imatches || amatches);
>          }
>  
> +        /* set regs for next */
> +        if (disas_assist && rmatches) {
> +            check_regs_this = check_regs_next;
> +        }
> +
> +        g_free(insn_disas);
>      }
>  }
>  
> +static Register *init_vcpu_register(qemu_plugin_reg_descriptor *desc)
> +{
> +    Register *reg = g_new0(Register, 1);
> +    g_autofree gchar *lower = g_utf8_strdown(desc->name, -1);
> +    int r;
> +
> +    reg->handle = desc->handle;
> +    reg->name = g_intern_string(lower);
> +    reg->last = g_byte_array_new();
> +    reg->new = g_byte_array_new();
> +
> +    /* read the initial value */
> +    r = qemu_plugin_read_register(reg->handle, reg->last);
> +    g_assert(r > 0);
> +    return reg;
> +}
> +
> +static GPtrArray *registers_init(int vcpu_index)
> +{
> +    g_autoptr(GPtrArray) registers = g_ptr_array_new();
> +    g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
> +
> +    if (rmatches && reg_list->len) {
> +        /*
> +         * Go through each register in the complete list and
> +         * see if we want to track it.
> +         */
> +        for (int r = 0; r < reg_list->len; r++) {
> +            qemu_plugin_reg_descriptor *rd = &g_array_index(
> +                reg_list, qemu_plugin_reg_descriptor, r);
> +            for (int p = 0; p < rmatches->len; p++) {
> +                g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
> +                g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
> +                if (g_pattern_match_string(pat, rd->name) ||
> +                    g_pattern_match_string(pat, rd_lower)) {
> +                    Register *reg = init_vcpu_register(rd);
> +                    g_ptr_array_add(registers, reg);
> +
> +                    /* we need a list of regnames at TB translation time */
> +                    if (disas_assist) {
> +                        g_mutex_lock(&add_reg_name_lock);
> +                        if (!g_ptr_array_find(all_reg_names, reg->name, NULL)) {
> +                            g_ptr_array_add(all_reg_names, reg->name);
> +                        }
> +                        g_mutex_unlock(&add_reg_name_lock);
> +                    }
> +                }
> +            }
> +        }
> +    }
> +
> +    return registers->len ? g_steal_pointer(&registers) : NULL;
> +}
> +
> +/*
> + * Initialise a new vcpu/thread with:
> + *   - last_exec tracking data
> + *   - list of tracked registers
> + *   - initial value of registers
> + *
> + * As we could have multiple threads trying to do this we need to
> + * serialise the expansion under a lock.
> + */
> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    CPU *c;
> +
> +    g_rw_lock_writer_lock(&expand_array_lock);
> +    if (vcpu_index >= cpus->len) {
> +        g_array_set_size(cpus, vcpu_index + 1);
> +    }
> +    g_rw_lock_writer_unlock(&expand_array_lock);
> +
> +    c = get_cpu(vcpu_index);
> +    c->last_exec = g_string_new(NULL);
> +    c->registers = registers_init(vcpu_index);
> +}
> +
>  /**
>   * On plugin exit, print last instruction in cache
>   */
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
>      guint i;
> -    GString *s;
> -    for (i = 0; i < last_exec->len; i++) {
> -        s = g_ptr_array_index(last_exec, i);
> -        if (s->str) {
> -            qemu_plugin_outs(s->str);
> +    g_rw_lock_reader_lock(&expand_array_lock);
> +    for (i = 0; i < cpus->len; i++) {
> +        CPU *c = get_cpu(i);
> +        if (c->last_exec && c->last_exec->str) {
> +            qemu_plugin_outs(c->last_exec->str);
>              qemu_plugin_outs("\n");
>          }
>      }
> +    g_rw_lock_reader_unlock(&expand_array_lock);
>  }
>  
>  /* Add a match to the array of matches */
> @@ -212,6 +408,18 @@ static void parse_vaddr_match(char *match)
>      g_array_append_val(amatches, v);
>  }
>  
> +/*
> + * We have to wait until vCPUs are started before we can check the
> + * patterns find anything.
> + */
> +static void add_regpat(char *regpat)
> +{
> +    if (!rmatches) {
> +        rmatches = g_ptr_array_new();
> +    }
> +    g_ptr_array_add(rmatches, g_strdup(regpat));
> +}
> +
>  /**
>   * Install the plugin
>   */
> @@ -223,11 +431,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>       * Initialize dynamic array to cache vCPU instruction. In user mode
>       * we don't know the size before emulation.
>       */
> -    if (info->system_emulation) {
> -        last_exec = g_ptr_array_sized_new(info->system.max_vcpus);
> -    } else {
> -        last_exec = g_ptr_array_new();
> -    }
> +    cpus = g_array_sized_new(true, true, sizeof(CPU),
> +                             info->system_emulation ? info->system.max_vcpus : 1);
>  
>      for (int i = 0; i < argc; i++) {
>          char *opt = argv[i];
> @@ -236,13 +441,22 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>              parse_insn_match(tokens[1]);
>          } else if (g_strcmp0(tokens[0], "afilter") == 0) {
>              parse_vaddr_match(tokens[1]);
> +        } else if (g_strcmp0(tokens[0], "reg") == 0) {
> +            add_regpat(tokens[1]);
> +        } else if (g_strcmp0(tokens[0], "rdisas") == 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &disas_assist)) {
> +                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
> +                return -1;
> +            }
> +            all_reg_names = g_ptr_array_new();
>          } else {
>              fprintf(stderr, "option parsing failed: %s\n", opt);
>              return -1;
>          }
>      }
>  
> -    /* Register translation block and exit callbacks */
> +    /* Register init, translation block and exit callbacks */
> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>      qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>  
> -- 
> 2.39.2
> 
> 

