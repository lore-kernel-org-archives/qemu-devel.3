Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481CCE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsi0W-0002MF-Vl; Wed, 18 Feb 2026 08:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vsi0V-0002Lv-97; Wed, 18 Feb 2026 08:54:23 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vsi0T-0002xF-Iv; Wed, 18 Feb 2026 08:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=avViAHnZ/4M6Cj/G6GZcWDVPgXLbv16ACnQ8pngUpKs=; b=HtM7eIsRBUx5H2d/
 elpLS0WVxZjxM38oTgZNk7HKaWio1qeYDWC24eSGxVbokB10gqPDgodEQO6kmriy0Y9aPKCBEkkn3
 t9/C11hVgxZGgKQdUmXorYMAJ+oTcG0pKhVvhAhNJa48EthXfOcHXOBGlXRxuqV4SmMJ6S/VyMg3x
 aKJJCtI28XLtpsBeAbQsQ/RkUBbeHkLdRcPlV1zlNuz1hSKFEbAu/YseXy4h4bC89uNGnbLQpr423
 ROu7hKWX7Mu1UqKNOEIxcZajmInxzHRSNr6u33oD8ckNCRKmlfRN7yEPD3Vg4PQs6ri3eQC+qEy8V
 6Lq+aHGwnzVvrJoNIA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vsi0I-000000048TJ-1LTQ;
 Wed, 18 Feb 2026 13:54:10 +0000
Date: Wed, 18 Feb 2026 13:54:10 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 07/11] monitor/hmp: Handle gdb-xml exposed registers via
 gdb_get_register()
Message-ID: <aZXEgrLH1Jsjz_Cc@gallifrey>
References: <20260216225228.53959-1-philmd@linaro.org>
 <20260216225228.53959-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216225228.53959-8-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 13:52:07 up 114 days, 13:28,  3 users,  load average: 0.01, 0.01,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, GB_FAKE_RF=0.754,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> Implement the gdb_get_register() helper and call it before the
> regular get_monitor_def() one. Registers is exposed via the
> GDB XML files will be directly handled, possibily allowing new
> registers added to XML files to be automatically accessible in
> QEMU monitor. All targets having GDB XML files can now be used
> within the monitor.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Nice;  I might be tempted to add more checks on the return size of
gdb_read_register(..) just in case any arch is a bit screwy
(e.g. if they're 0 for example?) - but it should fine.

So for HMP;

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>


> ---
>  monitor/hmp.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 0a5bbf82197..0e5913fabb1 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -27,14 +27,18 @@
>  #include "hw/core/qdev.h"
>  #include "monitor-internal.h"
>  #include "monitor/hmp.h"
> +#include "monitor/hmp-target.h"
>  #include "qobject/qdict.h"
>  #include "qobject/qnum.h"
> +#include "qemu/bswap.h"
>  #include "qemu/config-file.h"
>  #include "qemu/ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
>  #include "qemu/option.h"
> +#include "qemu/target-info.h"
>  #include "qemu/units.h"
> +#include "exec/gdbstub.h"
>  #include "system/block-backend.h"
>  #include "trace.h"
>  
> @@ -306,6 +310,46 @@ void hmp_help_cmd(Monitor *mon, const char *name)
>      free_cmdline_args(args, nb_args);
>  }
>  
> +/*
> + * Set @pval to the value in the register identified by @name.
> + * return %true if the register is found, %false otherwise.
> + */
> +static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
> +{
> +    g_autoptr(GArray) regs = NULL;
> +    CPUState *cs = mon_get_cpu(mon);
> +
> +    if (cs == NULL) {
> +        return false;
> +    }
> +
> +    regs = gdb_get_register_list(cs);
> +
> +    for (int i = 0; i < regs->len; i++) {
> +        GDBRegDesc *reg = &g_array_index(regs, GDBRegDesc, i);
> +        g_autoptr(GByteArray) buf = NULL;
> +        int reg_size;
> +
> +        if (!reg->name || g_strcmp0(name, reg->name)) {
> +            continue;
> +        }
> +
> +        buf = g_byte_array_new();
> +        reg_size = gdb_read_register(cs, buf, reg->gdb_reg);
> +        if (reg_size > sizeof(*pval)) {
> +            return false;
> +        }
> +
> +        if (target_big_endian()) {
> +            *pval = ldn_be_p(buf->data, reg_size);
> +        } else {
> +            *pval = ldn_le_p(buf->data, reg_size);
> +        }
> +        return true;
> +    }
> +    return false;
> +}
> +
>  /*******************************************************************/
>  
>  static const char *pch;
> @@ -338,7 +382,6 @@ static int64_t expr_unary(Monitor *mon)
>  {
>      int64_t n;
>      char *p;
> -    int ret;
>  
>      switch (*pch) {
>      case '+':
> @@ -393,8 +436,8 @@ static int64_t expr_unary(Monitor *mon)
>                  pch++;
>              }
>              *q = 0;
> -            ret = get_monitor_def(mon, &reg, buf);
> -            if (ret < 0) {
> +            if (!gdb_get_register(mon, &reg, buf)
> +                && get_monitor_def(mon, &reg, buf) < 0) {
>                  expr_error(mon, "unknown register");
>              }
>              n = reg;
> -- 
> 2.52.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

