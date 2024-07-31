Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39866C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 00:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYwx8-0005qG-9B; Tue, 30 Jul 2024 20:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sYwx6-0005pN-JO
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 20:12:24 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sYwx2-0001l6-LT
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 20:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Q+j+gxXo9FX1pUGb7N3v76QML702ePVk7sMrCJeeDPI=; b=aZeMzIbhhUn1g+oL
 AFGYFZsVBLQDNWm6V+Yc8lH8uHuRfL3rlbwIEg8mjyPtyuX10CyVIuE2vWobeEZOvp811Jw5zYMf7
 wfsLPKknyUBXRptHN4I1sAB+UeyZHOmEOUVltN4ohP8/8arZF81wo07JuiPGnCk232FUtjDNx6QbH
 4nON4JYyWjfVnt46bFOlQ5dB11wSmU1EAkeIutlgV8y0K/Q+UFtBUUWHEvCvqJvWxQT37Vgqk050/
 9AhCA0IcMnPcWq9DGVd9wrjeMBHXNqdRZg7y8vXSvj4jsY7X77FxiayLRxfL5aKOw4axGOeU2ZB/z
 8kvbcUsdgSLrdsTY0w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sYwww-00EBsm-08;
 Wed, 31 Jul 2024 00:12:14 +0000
Date: Wed, 31 Jul 2024 00:12:13 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Josh Junon <junon@oro.sh>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] qmp: Add 'memtranslate' QMP command
Message-ID: <ZqmBXTVV52qkk9Ed@gallifrey>
References: <20240730213432.18074-1-junon@oro.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240730213432.18074-1-junon@oro.sh>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:09:19 up 83 days, 11:23, 1 user, load average: 0.02, 0.03, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
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

* Josh Junon (junon@oro.sh) wrote:

Hi Josh,

> This commit adds a new QMP/HMP command `memtranslate`,
> which translates a virtual address to a physical address
> using the guest's MMU.
> 
> This uses the same mechanism that `[p]memsave` does to
> perform the translation.
> 
> This commit also fixes a long standing issue of `[p]memsave`
> not properly handling higher-half virtual addresses correctly,
> namely when used over QMP/the monitor. The use and assumption of
> signed integers caused issues when parsing otherwise valid
> virtual addresses that instead caused signed integer overflow
> or ERANGE errors.
> 
> Signed-off-by: Josh Junon <junon@oro.sh>

There's a few different changes in this one patch; so the first
thing is it needs splitting up; I suggest at least:
   a) Fixing the signedness problems
   b) The QMP implementation of the new command
   c) The HMP implementation of the new command

That would make it a lot easier to review - also, it's good
to get fixes in first!

Now, going back a step; how does this compare to the existing
'gva2gpa' command which HMP has?

Dave

> ---
>  docs/devel/loads-stores.rst |  11 ++
>  hmp-commands.hx             |  16 ++-
>  hw/core/machine-hmp-cmds.c  |  34 ++++-
>  include/exec/cpu-common.h   |   5 +
>  include/monitor/hmp.h       |   1 +
>  include/qapi/qmp/qdict.h    |   4 +
>  monitor/hmp-expr.inc        | 200 ++++++++++++++++++++++++++++++
>  monitor/hmp.c               | 241 ++++++++----------------------------
>  qapi/machine.json           |  42 ++++++-
>  qobject/qdict.c             |  38 ++++++
>  system/cpus.c               |  31 ++++-
>  system/physmem.c            |  18 +++
>  tests/qtest/test-hmp.c      |   1 +
>  tests/unit/check-qdict.c    |  39 ++++++
>  14 files changed, 482 insertions(+), 199 deletions(-)
>  create mode 100644 monitor/hmp-expr.inc
> 
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index ec627aa9c0..c2bf4bd015 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -465,6 +465,17 @@ For new code they are better avoided:
>  Regexes for git grep:
>   - ``\<cpu_physical_memory_\(read\|write\|rw\)\>``
>  
> +``cpu_memory_translate``
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Translates a virtual address to a physical address.
> +
> +This function is intended for use by QMP/HMP and similar code.
> +It takes a virtual address and returns the physical address
> +as it's seen by the MMU via a lookup, along with other attributes
> +of the page as well as what occurred during the lookup itself.
> +
> +
>  ``cpu_memory_rw_debug``
>  ~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 06746f0afc..213279e340 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -796,12 +796,24 @@ SRST
>    Stop capture with a given *index*, index can be obtained with::
>  
>      info capture
> +ERST
> +
> +    {
> +        .name       = "memtranslate",
> +        .args_type  = "val:u",
> +        .params     = "addr",
> +        .help       = "translate a guest virtual address 'addr' to a physical address",
> +        .cmd        = hmp_memtranslate,
> +    },
>  
> +SRST
> +``memtranslate`` *addr*
> +  translate a guest virtual address *val* to a physical address
>  ERST
>  
>      {
>          .name       = "memsave",
> -        .args_type  = "val:l,size:i,filename:s",
> +        .args_type  = "val:u,size:u,filename:s",
>          .params     = "addr size file",
>          .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
>          .cmd        = hmp_memsave,
> @@ -814,7 +826,7 @@ ERST
>  
>      {
>          .name       = "pmemsave",
> -        .args_type  = "val:l,size:i,filename:s",
> +        .args_type  = "val:u,size:u,filename:s",
>          .params     = "addr size file",
>          .help       = "save to disk physical memory dump starting at 'addr' of size 'size'",
>          .cmd        = hmp_pmemsave,
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index 8701f00cc7..cf4adfa80a 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -194,11 +194,37 @@ void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
>      qmp_system_powerdown(NULL);
>  }
>  
> +void hmp_memtranslate(Monitor *mon, const QDict *qdict)
> +{
> +    uint64_t addr = qdict_get_uint(qdict, "val");
> +    Error *err = NULL;
> +    int cpu_index = monitor_get_cpu_index(mon);
> +    MemTranslation *translation;
> +
> +    if (cpu_index < 0) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +
> +    translation = qmp_memtranslate(addr, true, cpu_index, &err);
> +
> +    if (err == NULL) {
> +        if (translation->phys == -1) {
> +            monitor_printf(mon, "failed to translate\n");
> +        } else {
> +            monitor_printf(mon, "phys: 0x%" PRIx64 "\n", translation->phys);
> +        }
> +    }
> +
> +    qapi_free_MemTranslation(translation);
> +    hmp_handle_error(mon, err);
> +}
> +
>  void hmp_memsave(Monitor *mon, const QDict *qdict)
>  {
> -    uint32_t size = qdict_get_int(qdict, "size");
> +    uint64_t size = qdict_get_uint(qdict, "size");
>      const char *filename = qdict_get_str(qdict, "filename");
> -    uint64_t addr = qdict_get_int(qdict, "val");
> +    uint64_t addr = qdict_get_uint(qdict, "val");
>      Error *err = NULL;
>      int cpu_index = monitor_get_cpu_index(mon);
>  
> @@ -213,9 +239,9 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
>  
>  void hmp_pmemsave(Monitor *mon, const QDict *qdict)
>  {
> -    uint32_t size = qdict_get_int(qdict, "size");
> +    uint64_t size = qdict_get_uint(qdict, "size");
>      const char *filename = qdict_get_str(qdict, "filename");
> -    uint64_t addr = qdict_get_int(qdict, "val");
> +    uint64_t addr = qdict_get_uint(qdict, "val");
>      Error *err = NULL;
>  
>      qmp_pmemsave(addr, size, filename, &err);
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 2e1b499cb7..9484c82fe0 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -178,6 +178,11 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
>  
>  #endif
>  
> +/* Returns: translated physical address on success, -1 on error.
> + * If the address is not valid, `*attrs` is left untouched.
> + */
> +hwaddr cpu_memory_translate(CPUState *cpu, vaddr addr, MemTxAttrs *attrs);
> +
>  /* Returns: 0 on success, -1 on error */
>  int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>                          void *ptr, size_t len, bool is_write);
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index ae116d9804..febccf13cc 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -47,6 +47,7 @@ void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
>  void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
>  void hmp_announce_self(Monitor *mon, const QDict *qdict);
>  void hmp_cpu(Monitor *mon, const QDict *qdict);
> +void hmp_memtranslate(Monitor *mon, const QDict *qdict);
>  void hmp_memsave(Monitor *mon, const QDict *qdict);
>  void hmp_pmemsave(Monitor *mon, const QDict *qdict);
>  void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> index 82e90fc072..38c310becb 100644
> --- a/include/qapi/qmp/qdict.h
> +++ b/include/qapi/qmp/qdict.h
> @@ -52,17 +52,21 @@ const QDictEntry *qdict_next(const QDict *qdict, const QDictEntry *entry);
>  
>  void qdict_put_bool(QDict *qdict, const char *key, bool value);
>  void qdict_put_int(QDict *qdict, const char *key, int64_t value);
> +void qdict_put_uint(QDict *qdict, const char *key, uint64_t value);
>  void qdict_put_null(QDict *qdict, const char *key);
>  void qdict_put_str(QDict *qdict, const char *key, const char *value);
>  
>  double qdict_get_double(const QDict *qdict, const char *key);
>  int64_t qdict_get_int(const QDict *qdict, const char *key);
> +uint64_t qdict_get_uint(const QDict *qdict, const char *key);
>  bool qdict_get_bool(const QDict *qdict, const char *key);
>  QList *qdict_get_qlist(const QDict *qdict, const char *key);
>  QDict *qdict_get_qdict(const QDict *qdict, const char *key);
>  const char *qdict_get_str(const QDict *qdict, const char *key);
>  int64_t qdict_get_try_int(const QDict *qdict, const char *key,
>                            int64_t def_value);
> +uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
> +                          uint64_t def_value);
>  bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value);
>  const char *qdict_get_try_str(const QDict *qdict, const char *key);
>  
> diff --git a/monitor/hmp-expr.inc b/monitor/hmp-expr.inc
> new file mode 100644
> index 0000000000..789a957ed2
> --- /dev/null
> +++ b/monitor/hmp-expr.inc
> @@ -0,0 +1,200 @@
> +#ifndef HMP_EXPR_INC_TY
> +#error "missing HMP_EXPR_INC_TY"
> +#endif
> +
> +#ifndef HMP_EXPR_INC_IDENT
> +#error "missing HMP_EXPR_INC_IDENT"
> +#endif
> +
> +static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_sum)(Monitor *mon);
> +
> +static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_unary)(Monitor *mon)
> +{
> +    HMP_EXPR_INC_TY n;
> +    char *p;
> +    int ret;
> +
> +    switch (*pch) {
> +    case '+':
> +        next();
> +        n = HMP_EXPR_INC_IDENT(expr_unary)(mon);
> +        break;
> +    case '-':
> +        next();
> +        n = -HMP_EXPR_INC_IDENT(expr_unary)(mon);
> +        break;
> +    case '~':
> +        next();
> +        n = ~HMP_EXPR_INC_IDENT(expr_unary)(mon);
> +        break;
> +    case '(':
> +        next();
> +        n = HMP_EXPR_INC_IDENT(expr_sum)(mon);
> +        if (*pch != ')') {
> +            expr_error(mon, "')' expected");
> +        }
> +        next();
> +        break;
> +    case '\'':
> +        pch++;
> +        if (*pch == '\0') {
> +            expr_error(mon, "character constant expected");
> +        }
> +        n = *pch;
> +        pch++;
> +        if (*pch != '\'') {
> +            expr_error(mon, "missing terminating \' character");
> +        }
> +        next();
> +        break;
> +    case '$':
> +        {
> +            char buf[128], *q;
> +            int64_t reg = 0;
> +
> +            pch++;
> +            q = buf;
> +            while ((*pch >= 'a' && *pch <= 'z') ||
> +                   (*pch >= 'A' && *pch <= 'Z') ||
> +                   (*pch >= '0' && *pch <= '9') ||
> +                   *pch == '_' || *pch == '.') {
> +                if ((q - buf) < sizeof(buf) - 1) {
> +                    *q++ = *pch;
> +                }
> +                pch++;
> +            }
> +            while (qemu_isspace(*pch)) {
> +                pch++;
> +            }
> +            *q = 0;
> +            ret = get_monitor_def(mon, &reg, buf);
> +            if (ret < 0) {
> +                expr_error(mon, "unknown register");
> +            }
> +            n = (HMP_EXPR_INC_TY)reg;
> +        }
> +        break;
> +    case '\0':
> +        expr_error(mon, "unexpected end of expression");
> +        n = 0;
> +        break;
> +    default:
> +        errno = 0;
> +        n = strtoull(pch, &p, 0);
> +        if (errno == ERANGE) {
> +            expr_error(mon, "number too large");
> +        }
> +        if (pch == p) {
> +            expr_error(mon, "invalid char '%c' in expression", *p);
> +        }
> +        pch = p;
> +        while (qemu_isspace(*pch)) {
> +            pch++;
> +        }
> +        break;
> +    }
> +    return n;
> +}
> +
> +static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_prod)(Monitor *mon)
> +{
> +    HMP_EXPR_INC_TY val, val2;
> +    int op;
> +
> +    val = HMP_EXPR_INC_IDENT(expr_unary)(mon);
> +    for (;;) {
> +        op = *pch;
> +        if (op != '*' && op != '/' && op != '%') {
> +            break;
> +        }
> +        next();
> +        val2 = HMP_EXPR_INC_IDENT(expr_unary)(mon);
> +        switch (op) {
> +        default:
> +        case '*':
> +            val *= val2;
> +            break;
> +        case '/':
> +        case '%':
> +            if (val2 == 0) {
> +                expr_error(mon, "division by zero");
> +            }
> +            if (op == '/') {
> +                val /= val2;
> +            } else {
> +                val %= val2;
> +            }
> +            break;
> +        }
> +    }
> +    return val;
> +}
> +
> +static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_logic)(Monitor *mon)
> +{
> +    HMP_EXPR_INC_TY val, val2;
> +    int op;
> +
> +    val = HMP_EXPR_INC_IDENT(expr_prod)(mon);
> +    for (;;) {
> +        op = *pch;
> +        if (op != '&' && op != '|' && op != '^') {
> +            break;
> +        }
> +        next();
> +        val2 = HMP_EXPR_INC_IDENT(expr_prod)(mon);
> +        switch (op) {
> +        default:
> +        case '&':
> +            val &= val2;
> +            break;
> +        case '|':
> +            val |= val2;
> +            break;
> +        case '^':
> +            val ^= val2;
> +            break;
> +        }
> +    }
> +    return val;
> +}
> +
> +static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_sum)(Monitor *mon)
> +{
> +    HMP_EXPR_INC_TY val, val2;
> +    int op;
> +
> +    val = HMP_EXPR_INC_IDENT(expr_logic)(mon);
> +    for (;;) {
> +        op = *pch;
> +        if (op != '+' && op != '-') {
> +            break;
> +        }
> +        next();
> +        val2 = HMP_EXPR_INC_IDENT(expr_logic)(mon);
> +        if (op == '+') {
> +            val += val2;
> +        } else {
> +            val -= val2;
> +        }
> +    }
> +    return val;
> +}
> +
> +static int HMP_EXPR_INC_IDENT(get_expr)(Monitor *mon, HMP_EXPR_INC_TY *pval, const char **pp)
> +{
> +    pch = *pp;
> +    if (sigsetjmp(expr_env, 0)) {
> +        *pp = pch;
> +        return -1;
> +    }
> +    while (qemu_isspace(*pch)) {
> +        pch++;
> +    }
> +    *pval = HMP_EXPR_INC_IDENT(expr_sum)(mon);
> +    *pp = pch;
> +    return 0;
> +}
> +
> +#undef HMP_EXPR_INC_TY
> +#undef HMP_EXPR_INC_IDENT
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 460e8832f6..95d965a20a 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -332,195 +332,13 @@ static void next(void)
>      }
>  }
>  
> -static int64_t expr_sum(Monitor *mon);
> +#define HMP_EXPR_INC_TY int64_t
> +#define HMP_EXPR_INC_IDENT(name) name ## _int64
> +#include "monitor/hmp-expr.inc"
>  
> -static int64_t expr_unary(Monitor *mon)
> -{
> -    int64_t n;
> -    char *p;
> -    int ret;
> -
> -    switch (*pch) {
> -    case '+':
> -        next();
> -        n = expr_unary(mon);
> -        break;
> -    case '-':
> -        next();
> -        n = -expr_unary(mon);
> -        break;
> -    case '~':
> -        next();
> -        n = ~expr_unary(mon);
> -        break;
> -    case '(':
> -        next();
> -        n = expr_sum(mon);
> -        if (*pch != ')') {
> -            expr_error(mon, "')' expected");
> -        }
> -        next();
> -        break;
> -    case '\'':
> -        pch++;
> -        if (*pch == '\0') {
> -            expr_error(mon, "character constant expected");
> -        }
> -        n = *pch;
> -        pch++;
> -        if (*pch != '\'') {
> -            expr_error(mon, "missing terminating \' character");
> -        }
> -        next();
> -        break;
> -    case '$':
> -        {
> -            char buf[128], *q;
> -            int64_t reg = 0;
> -
> -            pch++;
> -            q = buf;
> -            while ((*pch >= 'a' && *pch <= 'z') ||
> -                   (*pch >= 'A' && *pch <= 'Z') ||
> -                   (*pch >= '0' && *pch <= '9') ||
> -                   *pch == '_' || *pch == '.') {
> -                if ((q - buf) < sizeof(buf) - 1) {
> -                    *q++ = *pch;
> -                }
> -                pch++;
> -            }
> -            while (qemu_isspace(*pch)) {
> -                pch++;
> -            }
> -            *q = 0;
> -            ret = get_monitor_def(mon, &reg, buf);
> -            if (ret < 0) {
> -                expr_error(mon, "unknown register");
> -            }
> -            n = reg;
> -        }
> -        break;
> -    case '\0':
> -        expr_error(mon, "unexpected end of expression");
> -        n = 0;
> -        break;
> -    default:
> -        errno = 0;
> -        n = strtoull(pch, &p, 0);
> -        if (errno == ERANGE) {
> -            expr_error(mon, "number too large");
> -        }
> -        if (pch == p) {
> -            expr_error(mon, "invalid char '%c' in expression", *p);
> -        }
> -        pch = p;
> -        while (qemu_isspace(*pch)) {
> -            pch++;
> -        }
> -        break;
> -    }
> -    return n;
> -}
> -
> -static int64_t expr_prod(Monitor *mon)
> -{
> -    int64_t val, val2;
> -    int op;
> -
> -    val = expr_unary(mon);
> -    for (;;) {
> -        op = *pch;
> -        if (op != '*' && op != '/' && op != '%') {
> -            break;
> -        }
> -        next();
> -        val2 = expr_unary(mon);
> -        switch (op) {
> -        default:
> -        case '*':
> -            val *= val2;
> -            break;
> -        case '/':
> -        case '%':
> -            if (val2 == 0) {
> -                expr_error(mon, "division by zero");
> -            }
> -            if (op == '/') {
> -                val /= val2;
> -            } else {
> -                val %= val2;
> -            }
> -            break;
> -        }
> -    }
> -    return val;
> -}
> -
> -static int64_t expr_logic(Monitor *mon)
> -{
> -    int64_t val, val2;
> -    int op;
> -
> -    val = expr_prod(mon);
> -    for (;;) {
> -        op = *pch;
> -        if (op != '&' && op != '|' && op != '^') {
> -            break;
> -        }
> -        next();
> -        val2 = expr_prod(mon);
> -        switch (op) {
> -        default:
> -        case '&':
> -            val &= val2;
> -            break;
> -        case '|':
> -            val |= val2;
> -            break;
> -        case '^':
> -            val ^= val2;
> -            break;
> -        }
> -    }
> -    return val;
> -}
> -
> -static int64_t expr_sum(Monitor *mon)
> -{
> -    int64_t val, val2;
> -    int op;
> -
> -    val = expr_logic(mon);
> -    for (;;) {
> -        op = *pch;
> -        if (op != '+' && op != '-') {
> -            break;
> -        }
> -        next();
> -        val2 = expr_logic(mon);
> -        if (op == '+') {
> -            val += val2;
> -        } else {
> -            val -= val2;
> -        }
> -    }
> -    return val;
> -}
> -
> -static int get_expr(Monitor *mon, int64_t *pval, const char **pp)
> -{
> -    pch = *pp;
> -    if (sigsetjmp(expr_env, 0)) {
> -        *pp = pch;
> -        return -1;
> -    }
> -    while (qemu_isspace(*pch)) {
> -        pch++;
> -    }
> -    *pval = expr_sum(mon);
> -    *pp = pch;
> -    return 0;
> -}
> +#define HMP_EXPR_INC_TY uint64_t
> +#define HMP_EXPR_INC_IDENT(name) name ## _uint64
> +#include "monitor/hmp-expr.inc"
>  
>  static int get_double(Monitor *mon, double *pval, const char **pp)
>  {
> @@ -882,7 +700,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      }
>                      typestr++;
>                  }
> -                if (get_expr(mon, &val, &p)) {
> +                if (get_expr_int64(mon, &val, &p)) {
>                      goto fail;
>                  }
>                  /* Check if 'i' is greater than 32-bit */
> @@ -900,6 +718,51 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                  qdict_put_int(qdict, key, val);
>              }
>              break;
> +        case 'd':
> +        case 'u':
> +        case 'm':
> +            {
> +                uint64_t val;
> +
> +                while (qemu_isspace(*p)) {
> +                    p++;
> +                }
> +                if (*typestr == '?' || *typestr == '.') {
> +                    if (*typestr == '?') {
> +                        if (*p == '\0') {
> +                            typestr++;
> +                            break;
> +                        }
> +                    } else {
> +                        if (*p == '.') {
> +                            p++;
> +                            while (qemu_isspace(*p)) {
> +                                p++;
> +                            }
> +                        } else {
> +                            typestr++;
> +                            break;
> +                        }
> +                    }
> +                    typestr++;
> +                }
> +
> +                if (get_expr_uint64(mon, &val, &p)) {
> +                    goto fail;
> +                }
> +
> +                /* Check if 'd' is greater than 32-bit */
> +                if ((c == 'd') && ((val >> 32) & 0xffffffff)) {
> +                    monitor_printf(mon, "\'%s\' has failed: ", cmd->name);
> +                    monitor_printf(mon, "integer is for 32-bit values\n");
> +                    goto fail;
> +                } else if (c == 'm') {
> +                    val *= MiB;
> +                }
> +
> +                qdict_put_uint(qdict, key, val);
> +            }
> +            break;
>          case 'o':
>              {
>                  int ret;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index fcfd249e2d..7c2627c3e2 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -825,6 +825,44 @@
>     'policy': 'HmatCacheWritePolicy',
>     'line': 'uint16' }}
>  
> +##
> +# @MemTranslation:
> +#
> +# Result of a virtual-to-physical memory translation via @memtranslate.
> +#
> +# @phys: the physical address corresponding to the virtual address,
> +#     or -1 if the translation failed
> +#
> +# Since: TBD
> +##
> +{ 'struct': 'MemTranslation',
> +  'data': { 'phys': 'uint64' } }
> +
> +##
> +# @memtranslate:
> +#
> +# Translate a guest virtual address to a physical address.
> +#
> +# @val: the virtual address of the guest to translate
> +#
> +# @cpu-index: the index of the virtual CPU to use for translating the
> +#     virtual address (defaults to CPU 0)
> +#
> +# Returns:
> +#     @MemTranslation
> +#
> +# Since: TBD
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "memtranslate",
> +#          "arguments": { "val": 10 } }
> +#     <- { "return": { "phys": 20 } }
> +##
> +{ 'command': 'memtranslate',
> +  'data': {'val': 'uint64', '*cpu-index': 'int'},
> +  'returns': 'MemTranslation' }
> +
>  ##
>  # @memsave:
>  #
> @@ -852,7 +890,7 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'memsave',
> -  'data': {'val': 'int', 'size': 'int', 'filename': 'str', '*cpu-index': 'int'} }
> +  'data': {'val': 'uint64', 'size': 'uint64', 'filename': 'str', '*cpu-index': 'int'} }
>  
>  ##
>  # @pmemsave:
> @@ -878,7 +916,7 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'pmemsave',
> -  'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
> +  'data': {'val': 'uint64', 'size': 'uint64', 'filename': 'str'} }
>  
>  ##
>  # @Memdev:
> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index 8faff230d3..9696eee57d 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -136,6 +136,11 @@ void qdict_put_int(QDict *qdict, const char *key, int64_t value)
>      qdict_put(qdict, key, qnum_from_int(value));
>  }
>  
> +void qdict_put_uint(QDict *qdict, const char *key, uint64_t value)
> +{
> +    qdict_put(qdict, key, qnum_from_uint(value));
> +}
> +
>  void qdict_put_bool(QDict *qdict, const char *key, bool value)
>  {
>      qdict_put(qdict, key, qbool_from_bool(value));
> @@ -209,6 +214,19 @@ int64_t qdict_get_int(const QDict *qdict, const char *key)
>      return qnum_get_int(qobject_to(QNum, qdict_get(qdict, key)));
>  }
>  
> +/**
> + * qdict_get_int(): Get an unsigned integer mapped by 'key'
> + *
> + * This function assumes that 'key' exists and it stores a
> + * QNum representable as uint.
> + *
> + * Return integer mapped by 'key'.
> + */
> +uint64_t qdict_get_uint(const QDict *qdict, const char *key)
> +{
> +    return qnum_get_uint(qobject_to(QNum, qdict_get(qdict, key)));
> +}
> +
>  /**
>   * qdict_get_bool(): Get a bool mapped by 'key'
>   *
> @@ -272,6 +290,26 @@ int64_t qdict_get_try_int(const QDict *qdict, const char *key,
>      return val;
>  }
>  
> +/**
> + * qdict_get_try_uint(): Try to get unsigned integer mapped by 'key'
> + *
> + * Return integer mapped by 'key', if it is not present in the
> + * dictionary or if the stored object is not a QNum representing an
> + * unsigned integer, 'def_value' will be returned.
> + */
> +uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
> +                          uint64_t def_value)
> +{
> +    QNum *qnum = qobject_to(QNum, qdict_get(qdict, key));
> +    uint64_t val;
> +
> +    if (!qnum || !qnum_get_try_uint(qnum, &val)) {
> +        return def_value;
> +    }
> +
> +    return val;
> +}
> +
>  /**
>   * qdict_get_try_bool(): Try to get a bool mapped by 'key'
>   *
> diff --git a/system/cpus.c b/system/cpus.c
> index 5e3a988a0a..25d7d7c93f 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -792,7 +792,34 @@ int vm_stop_force_state(RunState state)
>      }
>  }
>  
> -void qmp_memsave(int64_t addr, int64_t size, const char *filename,
> +MemTranslation *qmp_memtranslate(uint64_t val, bool has_cpu_index, int64_t cpu_index, Error **errp)
> +{
> +    CPUState *cpu;
> +    hwaddr phys_addr;
> +    MemTxAttrs attrs;
> +    MemTranslation *translation;
> +
> +    if (!has_cpu_index) {
> +        cpu_index = 0;
> +    }
> +
> +    cpu = qemu_get_cpu(cpu_index);
> +    if (cpu == NULL) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
> +                   "a CPU number");
> +        return NULL;
> +    }
> +
> +    phys_addr = cpu_memory_translate(cpu, val, &attrs);
> +
> +    translation = g_new0(MemTranslation, 1);
> +
> +    translation->phys = phys_addr;
> +
> +    return translation;
> +}
> +
> +void qmp_memsave(uint64_t addr, uint64_t size, const char *filename,
>                   bool has_cpu, int64_t cpu_index, Error **errp)
>  {
>      FILE *f;
> @@ -840,7 +867,7 @@ exit:
>      fclose(f);
>  }
>  
> -void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
> +void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
>                    Error **errp)
>  {
>      FILE *f;
> diff --git a/system/physmem.c b/system/physmem.c
> index 0e19186e1b..d2fab35e3a 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3524,6 +3524,24 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
>  #define RCU_READ_UNLOCK()        ((void)0)
>  #include "memory_ldst.c.inc"
>  
> +/* virtual memory translation */
> +hwaddr cpu_memory_translate(CPUState *cpu, vaddr addr, MemTxAttrs *attrs)
> +{
> +    hwaddr phys_addr, phys_addr_rel;
> +    vaddr page;
> +
> +    page = addr & TARGET_PAGE_MASK;
> +    phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, attrs);
> +
> +    if (phys_addr == -1) {
> +        return -1;
> +    }
> +
> +    phys_addr_rel = phys_addr + (addr & ~TARGET_PAGE_MASK);
> +
> +    return phys_addr_rel;
> +}
> +
>  /* virtual memory access for debug (includes writing to ROM) */
>  int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>                          void *ptr, size_t len, bool is_write)
> diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
> index 1b2e07522f..13c45deb35 100644
> --- a/tests/qtest/test-hmp.c
> +++ b/tests/qtest/test-hmp.c
> @@ -44,6 +44,7 @@ static const char *hmp_cmds[] = {
>      "i /w 0",
>      "log all",
>      "log none",
> +    "memtranslate 0",
>      "memsave 0 4096 \"/dev/null\"",
>      "migrate_set_parameter xbzrle-cache-size 64k",
>      "migrate_set_parameter downtime-limit 1",
> diff --git a/tests/unit/check-qdict.c b/tests/unit/check-qdict.c
> index b5efa859b0..09ebe08900 100644
> --- a/tests/unit/check-qdict.c
> +++ b/tests/unit/check-qdict.c
> @@ -99,6 +99,21 @@ static void qdict_get_int_test(void)
>      qobject_unref(tests_dict);
>  }
>  
> +static void qdict_get_uint_test(void)
> +{
> +    int ret;
> +    const unsigned int value = 100;
> +    const char *key = "int";
> +    QDict *tests_dict = qdict_new();
> +
> +    qdict_put_uint(tests_dict, key, value);
> +
> +    ret = qdict_get_uint(tests_dict, key);
> +    g_assert(ret == value);
> +
> +    qobject_unref(tests_dict);
> +}
> +
>  static void qdict_get_try_int_test(void)
>  {
>      int ret;
> @@ -121,6 +136,28 @@ static void qdict_get_try_int_test(void)
>      qobject_unref(tests_dict);
>  }
>  
> +static void qdict_get_try_uint_test(void)
> +{
> +    int ret;
> +    const unsigned int value = 100;
> +    const char *key = "int";
> +    QDict *tests_dict = qdict_new();
> +
> +    qdict_put_uint(tests_dict, key, value);
> +    qdict_put_str(tests_dict, "string", "test");
> +
> +    ret = qdict_get_try_uint(tests_dict, key, 0);
> +    g_assert(ret == value);
> +
> +    ret = qdict_get_try_uint(tests_dict, "missing", -42);
> +    g_assert_cmpuint(ret, ==, -42);
> +
> +    ret = qdict_get_try_uint(tests_dict, "string", -42);
> +    g_assert_cmpuint(ret, ==, -42);
> +
> +    qobject_unref(tests_dict);
> +}
> +
>  static void qdict_get_str_test(void)
>  {
>      const char *p;
> @@ -358,7 +395,9 @@ int main(int argc, char **argv)
>      /* Continue, but now with fixtures */
>      g_test_add_func("/public/get", qdict_get_test);
>      g_test_add_func("/public/get_int", qdict_get_int_test);
> +    g_test_add_func("/public/get_uint", qdict_get_uint_test);
>      g_test_add_func("/public/get_try_int", qdict_get_try_int_test);
> +    g_test_add_func("/public/get_try_uint", qdict_get_try_uint_test);
>      g_test_add_func("/public/get_str", qdict_get_str_test);
>      g_test_add_func("/public/get_try_str", qdict_get_try_str_test);
>      g_test_add_func("/public/haskey_not", qdict_haskey_not_test);
> -- 
> 2.34.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

