Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4258AD35E3D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 20:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8QPC-0001UH-HL; Tue, 05 Nov 2024 15:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1t8QP4-0001Ti-HL; Tue, 05 Nov 2024 15:43:54 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1t8QP0-0003cU-LN; Tue, 05 Nov 2024 15:43:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05FCB21E5F;
 Tue,  5 Nov 2024 20:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730839428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9fLECKiSedarvOIO5ZAVVkrgdR/GUIR6ESjw0qifQ8=;
 b=0CzAynwkNOQkk85+d0RJ+yMisBTHw4+Gqf8suCoiJHLnBmXGXRNBdQLuz1obLAJUXMiILq
 9EmeNR1mPqdVQsJWnTAGRa5rYXC4umOQ+hmMxQd97DUv4aYouOiymwNr6H30o94WbgkfY9
 BREaaCX6x+iPboDT6HOKSwIJNsfmiEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730839428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9fLECKiSedarvOIO5ZAVVkrgdR/GUIR6ESjw0qifQ8=;
 b=xIORfUGY4bAL0HmwSmJehHFTrd1xp4meXxCg6qTVqxOp9pMJUSFowIJmSYfExAqKfpxBus
 fF/AYAILFF6N4+BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=I6upXl6Q;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PveMPvSI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730839426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9fLECKiSedarvOIO5ZAVVkrgdR/GUIR6ESjw0qifQ8=;
 b=I6upXl6Q+n/gimgqaez3qXaCWv2LVQc2CgVUCTkazVWTc4mzDIcHA2AyJGV3d0KwJR2xeZ
 iu0kdtYdXegpPg+bKfYpCxa5QG5rKT4deM3xMe545VwksLbqqJQXMkazeaYalWUpnr4Gre
 91b7NS7JZvNcvl4efhI4eHbMq6xbP/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730839426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9fLECKiSedarvOIO5ZAVVkrgdR/GUIR6ESjw0qifQ8=;
 b=PveMPvSI2oV4yO/uN7BzE2bWiv5LNUAdY7O3XR3s8INlYhmKxlgKHOkrHHDdmHFybYX12g
 4wQTHvjyZCA3TXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7942E1394A;
 Tue,  5 Nov 2024 20:43:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G5IIEIGDKmcmEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 20:43:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, farosas@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: Re: [RFC PATCH v5 1/2] target/riscv: Add RISC-V CSR qtest support
In-Reply-To: <20241105142840.59617-2-ivan.klokov@syntacore.com>
References: <20241105142840.59617-1-ivan.klokov@syntacore.com>
 <20241105142840.59617-2-ivan.klokov@syntacore.com>
Date: Tue, 05 Nov 2024 17:43:42 -0300
Message-ID: <87zfmdwgw1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 05FCB21E5F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[nongnu.org,dabbelt.com,wdc.com,gmail.com,ventanamicro.com,linux.alibaba.com,redhat.com,syntacore.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, syntacore.com:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Ivan Klokov <ivan.klokov@syntacore.com> writes:

> The RISC-V architecture supports the creation of custom
> CSR-mapped devices. It would be convenient to test them in the same way
> as MMIO-mapped devices. To do this, a new call has been added
> to read/write CSR registers.
>
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> ---
>  hw/riscv/riscv_hart.c  | 65 ++++++++++++++++++++++++++++++++++++++++++
>  tests/qtest/libqtest.c | 27 ++++++++++++++++++
>  tests/qtest/libqtest.h | 14 +++++++++
>  3 files changed, 106 insertions(+)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 613ea2aaa0..e65a1a28a1 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -21,6 +21,8 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
> +#include "qemu/cutils.h"
> +#include "sysemu/qtest.h"
>  #include "sysemu/reset.h"
>  #include "hw/sysbus.h"
>  #include "target/riscv/cpu.h"
> @@ -42,6 +44,66 @@ static void riscv_harts_cpu_reset(void *opaque)
>      cpu_reset(CPU(cpu));
>  }
>  
> +#ifndef CONFIG_USER_ONLY
> +static uint64_t csr_call(char *cmd, uint64_t cpu_num, int csrno,
> +                                uint64_t *val)

Bad indentation here^

> +{
> +    RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
> +    CPURISCVState *env = &cpu->env;
> +
> +    int ret = RISCV_EXCP_NONE;
> +    if (strcmp(cmd, "get_csr") == 0) {
> +        ret = riscv_csrr(env, csrno, (target_ulong *)val);
> +    } else if (strcmp(cmd, "set_csr") == 0) {
> +        ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS));

Please run scripts/checkpatch.pl before submitting:

$ ./scripts/checkpatch.pl build/0001-target-riscv-Add-RISC-V-CSR-qtest-support.patch
ERROR: line over 90 characters
#46: FILE: hw/riscv/riscv_hart.c:58:
+        ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS));

> +    }
> +
> +    if (ret == RISCV_EXCP_NONE) {
> +        ret = 0;
> +    } else {
> +        g_assert_not_reached();
> +    }
> +
> +    return ret;
> +}
> +
> +static bool csr_qtest_callback(CharBackend *chr, gchar **words)
> +{
> +    if (strcmp(words[0], "csr") == 0) {
> +
> +        uint64_t res, cpu;
> +
> +        uint64_t val;
> +        int rc, csr;
> +
> +        rc = qemu_strtou64(words[2], NULL, 0, &cpu);
> +        g_assert(rc == 0);
> +        rc = qemu_strtoi(words[3], NULL, 0, &csr);
> +        g_assert(rc == 0);
> +        rc = qemu_strtou64(words[4], NULL, 0, &val);
> +        g_assert(rc == 0);
> +        res = csr_call(words[1], cpu, csr, &val);
> +
> +        qtest_send_prefix(chr);
> +        qtest_sendf(chr, "OK %"PRIx64" "TARGET_FMT_lx"\n", res, (target_ulong)val);

You could omit 'res', as it will always be 0, otherwise csr_call() will
have aborted already.

> +
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static void riscv_cpu_register_csr_qtest_callback(void)
> +{
> +    static gsize reinit_done;
> +    if (g_once_init_enter(&reinit_done)) {
> +        qtest_set_command_cb(csr_qtest_callback);
> +
> +        g_once_init_leave(&reinit_done, 1);
> +    }

This seems to be the same as the simpler:

    static GOnce once;
    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback);

> +}
> +#endif
> +
>  static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
>                                 char *cpu_type, Error **errp)
>  {
> @@ -49,6 +111,9 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
>      qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
>      s->harts[idx].env.mhartid = s->hartid_base + idx;
>      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
> +#ifndef CONFIG_USER_ONLY
> +    riscv_cpu_register_csr_qtest_callback();
> +#endif

This could be one level up at riscv_harts_realize().

>      return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
>  }
>  
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 9d07de1fbd..661f7f0e84 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1202,6 +1202,33 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
>      return 0;
>  }
>  
> +static void qtest_rsp_csr(QTestState *s, uint64_t *val)
> +{
> +    gchar **args;
> +    uint64_t ret;
> +    int rc;
> +
> +    args = qtest_rsp_args(s, 3);
> +
> +    rc = qemu_strtou64(args[1], NULL, 16, &ret);
> +    g_assert(rc == 0);
> +    rc = qemu_strtou64(args[2], NULL, 16, val);
> +    g_assert(rc == 0);
> +
> +    g_strfreev(args);
> +}
> +
> +uint64_t qtest_csr_call(QTestState *s, const char *name,
> +                         uint64_t cpu, int csr,
> +                         uint64_t *val)
> +{
> +    qtest_sendf(s, "csr %s 0x%"PRIx64" %d 0x%"PRIx64"\n",
> +                    name, cpu, csr, *val);
> +
> +    qtest_rsp_csr(s, val);
> +    return 0;
> +}
> +
>  void qtest_add_func(const char *str, void (*fn)(void))
>  {
>      gchar *path = g_strdup_printf("/%s/%s", qtest_get_arch(), str);
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index beb96b18eb..b516a16bd4 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -575,6 +575,20 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
>                           uint32_t nargs, uint64_t args,
>                           uint32_t nret, uint64_t ret);
>  
> +/**
> + * qtest_csr_call:
> + * @s: #QTestState instance to operate on.
> + * @name: name of the command to call.
> + * @cpu: hart number.
> + * @csr: CSR number.
> + * @val: Value for reading/writing.
> + *
> + * Call an RISC-V CSR read/write function
> + */
> +uint64_t qtest_csr_call(QTestState *s, const char *name,
> +                         uint64_t cpu, int csr,
> +                         unsigned long *val);
> +
>  /**
>   * qtest_bufread:
>   * @s: #QTestState instance to operate on.

