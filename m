Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5075C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKbE-00045k-UI; Tue, 18 Aug 2026 10:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wwKbD-00045S-PO; Tue, 18 Aug 2026 10:15:31 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wwKbA-0007oR-SZ; Tue, 18 Aug 2026 10:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=mXiW1zXqd2/kQq4I3ksyn+QKzPEbkkWGOWqSoGK74eg=; b=TYEsBUjbtCgtHcRy
 dNMKK1F/Wm/tcBGFJHOYw8Hs0nkJNHul//eClnKMwrELtN5x0sZIINWLDVy5VvK49SXtMwGZhehSk
 uuSyzhcFnRNX6xXIxMM77USBiP7BVz4p5j4ZiNs1DO490PbSfILqK/rDHb3Bd8kkIQsIAz8wkd+bk
 M4cyw/HbzabbaZDWDqP47dmdEz9BPknDq0+/9S3jLJ67W/b52EpvQHTLz9K7WE+NYxU8go/TfkCE8
 2UUHHZ486x5uLTdxG+ptcIATfROgRSLUWrmmRxuIEeXQ8IGJinZZxqg4maDOkfvdkwMJ9udQwsxYO
 LiZ4t9iz67xroyXahw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wwKav-00000002t6A-3w5H;
 Tue, 18 Aug 2026 14:15:13 +0000
Date: Tue, 18 Aug 2026 14:15:13 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 36/49] monitor: tighten monitor_set_cpu()/get_cpu()
Message-ID: <aoRo8UcTqAUu5lkP@gallifrey>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-36-e53fc35bc550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-36-e53fc35bc550@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.101+deb13-amd64 (x86_64)
X-Uptime: 14:15:10 up 11 days, 17:52,  2 users,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Marc-André Lureau (marcandre.lureau@redhat.com) wrote:
> These functions access mon_cpu_path, which is a MonitorHMP-specific
> field. Narrowing their signatures from Monitor* to MonitorHMP* makes the
> type system enforce what was already true at runtime: every caller is in
> an HMP context. The expression parser's MONITOR_HMP() casts are safe
> because it is only reachable from handle_hmp_command(), they will be
> dropped with later patches.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  hw/core/machine-hmp-cmds.c |  4 ++--
>  include/monitor/hmp.h      |  7 +++---
>  include/monitor/monitor.h  |  1 -
>  monitor/hmp-cmds.c         | 53 ++++++++++++++++++++++------------------------
>  monitor/hmp.c              | 18 ++++++++--------
>  monitor/monitor-internal.h |  2 +-
>  monitor/qmp-cmds.c         |  2 +-
>  stats/stats-hmp-cmds.c     |  2 +-
>  target/i386/cpu-apic.c     |  2 +-
>  target/i386/cpu.c          |  4 ++--
>  target/i386/monitor.c      |  4 ++--
>  target/m68k/monitor.c      |  2 +-
>  target/ppc/monitor.c       |  2 +-
>  target/riscv/monitor.c     |  2 +-
>  target/sh4/monitor.c       |  2 +-
>  target/sparc/monitor.c     |  2 +-
>  target/xtensa/monitor.c    |  2 +-
>  17 files changed, 54 insertions(+), 57 deletions(-)
> 
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index 4e2f0c212b0d..702c798ccc56 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -36,7 +36,7 @@ void hmp_info_cpus(MonitorHMP *hmp, const QDict *qdict)
>          g_autofree char *cpu_model = cpu_model_from_type(cpu->value->qom_type);
>          int active = ' ';
>  
> -        if (cpu->value->cpu_index == monitor_get_cpu_index(mon)) {
> +        if (cpu->value->cpu_index == monitor_hmp_get_cpu_index(hmp)) {
>              active = '*';
>          }
>  
> @@ -228,7 +228,7 @@ void hmp_memsave(MonitorHMP *hmp, const QDict *qdict)
>      const char *filename = qdict_get_str(qdict, "filename");
>      uint64_t addr = qdict_get_int(qdict, "val");
>      Error *err = NULL;
> -    int cpu_index = monitor_get_cpu_index(mon);
> +    int cpu_index = monitor_hmp_get_cpu_index(hmp);
>  
>      if (cpu_index < 0) {
>          monitor_printf(mon, "No CPU available\n");
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 6aa562ddbaa2..3fd17048b319 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -30,7 +30,7 @@ OBJECT_DECLARE_TYPE(MonitorHMP, MonitorHMPClass, MONITOR_HMP);
>  struct MonitorDef {
>      const char *name;
>      int offset;
> -    int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
> +    int64_t (*get_value)(MonitorHMP *hmp, const MonitorDef *md, int offset);
>  };
>  
>  void monitor_new_hmp(const char *id, const char *chardev_id,
> @@ -53,8 +53,9 @@ void monitor_register_hmp_info_hrt(const char *name,
>                                     HumanReadableText *(*handler)(Error **errp));
>  
>  
> -CPUArchState *mon_get_cpu_env(Monitor *mon);
> -CPUState *mon_get_cpu(Monitor *mon);
> +CPUArchState *monitor_hmp_get_cpu_env(MonitorHMP *hmp);
> +CPUState *monitor_hmp_get_cpu(MonitorHMP *hmp);
> +int monitor_hmp_get_cpu_index(MonitorHMP *hmp);
>  
>  bool hmp_handle_error(MonitorHMP *hmp, Error *err);
>  void hmp_help_cmd(Monitor *mon, const char *name);
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 72a8f6ea5b4f..2a550aec023f 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -39,7 +39,6 @@ int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
>  
>  int monitor_puts(Monitor *mon, const char *str);
>  void monitor_flush(Monitor *mon);
> -int monitor_get_cpu_index(Monitor *mon);
>  
>  int monitor_puts_locked(Monitor *mon, const char *str);
>  void monitor_flush_locked(Monitor *mon);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index d1e7e4de6585..89cc19c2431d 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -182,10 +182,10 @@ void hmp_cpu(MonitorHMP *hmp, const QDict *qdict)
>      Monitor *mon = MONITOR(hmp);
>      int64_t cpu_index;
>  
> -    /* XXX: drop the monitor_set_cpu() usage when all HMP commands that
> +    /* XXX: drop the monitor_hmp_set_cpu() usage when all HMP commands that
>              use it are converted to the QAPI */
>      cpu_index = qdict_get_int(qdict, "index");
> -    if (monitor_set_cpu(mon, cpu_index) < 0) {
> +    if (monitor_hmp_set_cpu(hmp, cpu_index) < 0) {
>          monitor_printf(mon, "invalid CPU index\n");
>      }
>  }
> @@ -512,39 +512,37 @@ void hmp_dumpdtb(MonitorHMP *hmp, const QDict *qdict)
>  #endif
>  
>  /* Set the current CPU defined by the user. Callers must hold BQL. */
> -int monitor_set_cpu(Monitor *mon, int cpu_index)
> +int monitor_hmp_set_cpu(MonitorHMP *hmp, int cpu_index)
>  {
> -    MonitorHMP *hmp_mon = MONITOR_HMP(mon);
>      CPUState *cpu;
>  
>      cpu = qemu_get_cpu(cpu_index);
>      if (cpu == NULL) {
>          return -1;
>      }
> -    g_free(hmp_mon->mon_cpu_path);
> -    hmp_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
> +    g_free(hmp->mon_cpu_path);
> +    hmp->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
>      return 0;
>  }
>  
>  /* Callers must hold BQL. */
> -static CPUState *mon_get_cpu_sync(Monitor *mon, bool synchronize)
> +static CPUState *monitor_hmp_get_cpu_sync(MonitorHMP *hmp, bool synchronize)
>  {
> -    MonitorHMP *hmp_mon = MONITOR_HMP(mon);
>      CPUState *cpu = NULL;
>  
> -    if (hmp_mon->mon_cpu_path) {
> -        cpu = (CPUState *) object_resolve_path_type(hmp_mon->mon_cpu_path,
> +    if (hmp->mon_cpu_path) {
> +        cpu = (CPUState *) object_resolve_path_type(hmp->mon_cpu_path,
>                                                      TYPE_CPU, NULL);
>          if (!cpu) {
> -            g_free(hmp_mon->mon_cpu_path);
> -            hmp_mon->mon_cpu_path = NULL;
> +            g_free(hmp->mon_cpu_path);
> +            hmp->mon_cpu_path = NULL;
>          }
>      }
> -    if (!hmp_mon->mon_cpu_path) {
> +    if (!hmp->mon_cpu_path) {
>          if (!first_cpu) {
>              return NULL;
>          }
> -        monitor_set_cpu(mon, first_cpu->cpu_index);
> +        monitor_hmp_set_cpu(hmp, first_cpu->cpu_index);
>          cpu = first_cpu;
>      }
>      assert(cpu != NULL);
> @@ -554,21 +552,21 @@ static CPUState *mon_get_cpu_sync(Monitor *mon, bool synchronize)
>      return cpu;
>  }
>  
> -CPUState *mon_get_cpu(Monitor *mon)
> +CPUState *monitor_hmp_get_cpu(MonitorHMP *hmp)
>  {
> -    return mon_get_cpu_sync(mon, true);
> +    return monitor_hmp_get_cpu_sync(hmp, true);
>  }
>  
> -CPUArchState *mon_get_cpu_env(Monitor *mon)
> +CPUArchState *monitor_hmp_get_cpu_env(MonitorHMP *hmp)
>  {
> -    CPUState *cs = mon_get_cpu(mon);
> +    CPUState *cs = monitor_hmp_get_cpu(hmp);
>  
>      return cs ? cpu_env(cs) : NULL;
>  }
>  
> -int monitor_get_cpu_index(Monitor *mon)
> +int monitor_hmp_get_cpu_index(MonitorHMP *hmp)
>  {
> -    CPUState *cs = mon_get_cpu_sync(mon, false);
> +    CPUState *cs = monitor_hmp_get_cpu_sync(hmp, false);
>  
>      return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
>  }
> @@ -586,7 +584,7 @@ void hmp_info_registers(MonitorHMP *hmp, const QDict *qdict)
>              cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
>          }
>      } else {
> -        cs = vcpu >= 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
> +        cs = vcpu >= 0 ? qemu_get_cpu(vcpu) : monitor_hmp_get_cpu(hmp);
>  
>          if (!cs) {
>              if (vcpu >= 0) {
> @@ -602,13 +600,14 @@ void hmp_info_registers(MonitorHMP *hmp, const QDict *qdict)
>      }
>  }
>  
> -static void memory_dump(Monitor *mon, int count, int format, int wsize,
> +static void memory_dump(MonitorHMP *hmp, int count, int format, int wsize,
>                          uint64_t addr, bool is_physical)
>  {
> +    Monitor *mon = MONITOR(hmp);
>      int l, line_size, i, max_digits, len;
>      uint8_t buf[16];
>      uint64_t v;
> -    CPUState *cs = mon_get_cpu(mon);
> +    CPUState *cs = monitor_hmp_get_cpu(hmp);
>      const unsigned int addr_width = is_physical ? 8 : (target_long_bits() / 4);
>      const bool big_endian = target_big_endian();
>  
> @@ -712,24 +711,22 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>  
>  void hmp_memory_dump(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int count = qdict_get_int(qdict, "count");
>      int format = qdict_get_int(qdict, "format");
>      int size = qdict_get_int(qdict, "size");
>      vaddr addr = qdict_get_int(qdict, "addr");
>  
> -    memory_dump(mon, count, format, size, addr, false);
> +    memory_dump(hmp, count, format, size, addr, false);
>  }
>  
>  void hmp_physical_memory_dump(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int count = qdict_get_int(qdict, "count");
>      int format = qdict_get_int(qdict, "format");
>      int size = qdict_get_int(qdict, "size");
>      hwaddr addr = qdict_get_int(qdict, "addr");
>  
> -    memory_dump(mon, count, format, size, addr, true);
> +    memory_dump(hmp, count, format, size, addr, true);
>  }
>  
>  void hmp_gpa2hva(MonitorHMP *hmp, const QDict *qdict)
> @@ -757,7 +754,7 @@ void hmp_gva2gpa(MonitorHMP *hmp, const QDict *qdict)
>  {
>      Monitor *mon = MONITOR(hmp);
>      vaddr addr = qdict_get_int(qdict, "addr");
> -    CPUState *cs = mon_get_cpu(mon);
> +    CPUState *cs = monitor_hmp_get_cpu(hmp);
>      TranslateForDebugResult tres;
>  
>      if (!cs) {
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 47fb7cef6de2..2484a2310dff 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -411,10 +411,10 @@ void hmp_help_cmd(Monitor *mon, const char *name)
>   * Set @pval to the value in the register identified by @name.
>   * return %true if the register is found, %false otherwise.
>   */
> -static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
> +static bool gdb_get_register(MonitorHMP *hmp, int64_t *pval, const char *name)
>  {
>      g_autoptr(GArray) regs = NULL;
> -    CPUState *cs = mon_get_cpu(mon);
> +    CPUState *cs = monitor_hmp_get_cpu(hmp);
>  
>      if (cs == NULL) {
>          return false;
> @@ -452,7 +452,7 @@ static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
>  static const char *pch;
>  static sigjmp_buf expr_env;
>  
> -static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
> +static int get_monitor_def(MonitorHMP *mon, int64_t *pval, const char *name);
>  
>  static G_NORETURN G_GNUC_PRINTF(2, 3)
>  void expr_error(Monitor *mon, const char *fmt, ...)
> @@ -535,8 +535,8 @@ static int64_t expr_unary(Monitor *mon)
>                  pch++;
>              }
>              *q = 0;
> -            if (!gdb_get_register(mon, &reg, buf)
> -                && get_monitor_def(mon, &reg, buf) < 0) {
> +            if (!gdb_get_register(MONITOR_HMP(mon), &reg, buf)
> +                && get_monitor_def(MONITOR_HMP(mon), &reg, buf) < 0) {
>                  expr_error(mon, "unknown register");
>              }
>              n = reg;
> @@ -1733,9 +1733,9 @@ void monitor_register_hmp_info_hrt(const char *name,
>   * Set @pval to the value in the register identified by @name.
>   * return 0 if OK, -1 if not found
>   */
> -static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
> +static int get_monitor_def(MonitorHMP *hmp, int64_t *pval, const char *name)
>  {
> -    CPUState *cs = mon_get_cpu(mon);
> +    CPUState *cs = monitor_hmp_get_cpu(hmp);
>      const MonitorDef *md;
>      void *ptr;
>  
> @@ -1750,9 +1750,9 @@ static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>      for (; md->name != NULL; md++) {
>          if (hmp_compare_cmd(name, md->name)) {
>              if (md->get_value) {
> -                *pval = md->get_value(mon, md, md->offset);
> +                *pval = md->get_value(hmp, md, md->offset);
>              } else {
> -                CPUArchState *env = mon_get_cpu_env(mon);
> +                CPUArchState *env = monitor_hmp_get_cpu_env(hmp);
>                  ptr = (uint8_t *)env + md->offset;
>                  *pval = *(int32_t *)ptr;
>              }
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index a0fa37c887ed..afdda1386080 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -215,7 +215,7 @@ int monitor_can_read(void *opaque);
>  void monitor_cancel_out_watch(Monitor *mon);
>  void monitor_list_append(Monitor *mon);
>  void monitor_fdsets_cleanup(void);
> -int monitor_set_cpu(Monitor *mon, int cpu_index);
> +int monitor_hmp_set_cpu(MonitorHMP *mon, int cpu_index);
>  
>  void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
>  void monitor_data_destroy_qmp(MonitorQMP *mon);
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 6cb0b587fbd4..b16119f4858c 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -169,7 +169,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      MonitorHMP *hmp = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
>  
>      if (has_cpu_index) {
> -        int ret = monitor_set_cpu(&hmp->parent_obj, cpu_index);
> +        int ret = monitor_hmp_set_cpu(hmp, cpu_index);
>          if (ret < 0) {
>              error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
>                         "a CPU number");
> diff --git a/stats/stats-hmp-cmds.c b/stats/stats-hmp-cmds.c
> index f280ad8c4314..cd1f1deb58bc 100644
> --- a/stats/stats-hmp-cmds.c
> +++ b/stats/stats-hmp-cmds.c
> @@ -226,7 +226,7 @@ void hmp_info_stats(MonitorHMP *hmp, const QDict *qdict)
>          filter = stats_filter(target, names, -1, provider);
>          break;
>      case STATS_TARGET_VCPU: {}
> -        int cpu_index = monitor_get_cpu_index(mon);
> +        int cpu_index = monitor_hmp_get_cpu_index(hmp);
>          filter = stats_filter(target, names, cpu_index, provider);
>          break;
>      case STATS_TARGET_CRYPTODEV:
> diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
> index 2cb3147837d1..3ae20f004b64 100644
> --- a/target/i386/cpu-apic.c
> +++ b/target/i386/cpu-apic.c
> @@ -93,7 +93,7 @@ void hmp_info_local_apic(MonitorHMP *hmp, const QDict *qdict)
>              cpu_synchronize_state(cs);
>          }
>      } else {
> -        cs = mon_get_cpu(mon);
> +        cs = monitor_hmp_get_cpu(hmp);
>      }
>  
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index e5ffb10d1565..f0687b5c482d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10853,10 +10853,10 @@ static const Property x86_cpu_properties[] = {
>  
>  #ifndef CONFIG_USER_ONLY
>  
> -static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
> +static int64_t monitor_get_pc(MonitorHMP *hmp, const struct MonitorDef *md,
>                                int offset)
>  {
> -    CPUArchState *env = mon_get_cpu_env(mon);
> +    CPUArchState *env = monitor_hmp_get_cpu_env(hmp);
>      int64_t ret = env->eip + env->segs[R_CS].base;
>  
>      if (!(env->hflags & HF_CS64_MASK)) {
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index f68dd38ac225..72bcab131f77 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -215,7 +215,7 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>      CPUArchState *env;
>      AddressSpace *as;
>  
> -    env = mon_get_cpu_env(mon);
> +    env = monitor_hmp_get_cpu_env(hmp);
>      if (!env) {
>          monitor_printf(mon, "No CPU available\n");
>          return;
> @@ -542,7 +542,7 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
>      CPUArchState *env;
>      AddressSpace *as;
>  
> -    env = mon_get_cpu_env(mon);
> +    env = monitor_hmp_get_cpu_env(hmp);
>      if (!env) {
>          monitor_printf(mon, "No CPU available\n");
>          return;
> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
> index 0414474f2ffb..5645a5d4d4f5 100644
> --- a/target/m68k/monitor.c
> +++ b/target/m68k/monitor.c
> @@ -13,7 +13,7 @@
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
>      Monitor *mon = MONITOR(hmp);
> -    CPUArchState *env1 = mon_get_cpu_env(mon);
> +    CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
>  
>      if (!env1) {
>          monitor_printf(mon, "No CPU available\n");
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index 99eda7351877..5769829bdd7e 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -14,7 +14,7 @@
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
>      Monitor *mon = MONITOR(hmp);
> -    CPUArchState *env1 = mon_get_cpu_env(mon);
> +    CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
>  
>      if (!env1) {
>          monitor_printf(mon, "No CPU available\n");
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index 496d519c978d..4c9c0c793b36 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -220,7 +220,7 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
>      Monitor *mon = MONITOR(hmp);
>      CPUArchState *env;
>  
> -    env = mon_get_cpu_env(mon);
> +    env = monitor_hmp_get_cpu_env(hmp);
>      if (!env) {
>          monitor_printf(mon, "No CPU available\n");
>          return;
> diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
> index 50da650b2e04..4e443152bf56 100644
> --- a/target/sh4/monitor.c
> +++ b/target/sh4/monitor.c
> @@ -41,7 +41,7 @@ static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
>      Monitor *mon = MONITOR(hmp);
> -    CPUArchState *env = mon_get_cpu_env(mon);
> +    CPUArchState *env = monitor_hmp_get_cpu_env(hmp);
>      int i;
>  
>      if (!env) {
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index 09a15b821a1a..e826e584a918 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -30,7 +30,7 @@
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
>      Monitor *mon = MONITOR(hmp);
> -    CPUArchState *env1 = mon_get_cpu_env(mon);
> +    CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
>  
>      if (!env1) {
>          monitor_printf(mon, "No CPU available\n");
> diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
> index a1082c44e11c..b7b7387706f3 100644
> --- a/target/xtensa/monitor.c
> +++ b/target/xtensa/monitor.c
> @@ -29,7 +29,7 @@
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
>      Monitor *mon = MONITOR(hmp);
> -    CPUArchState *env1 = mon_get_cpu_env(mon);
> +    CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
>  
>      if (!env1) {
>          monitor_printf(mon, "No CPU available\n");
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

