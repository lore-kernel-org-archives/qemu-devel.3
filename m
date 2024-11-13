Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49543D637CD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 22:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBLSb-0006TP-KW; Wed, 13 Nov 2024 17:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tBLSW-0006Nf-Lr; Wed, 13 Nov 2024 17:03:32 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tBLSU-0001PP-07; Wed, 13 Nov 2024 17:03:32 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 244EF1F7C5;
 Wed, 13 Nov 2024 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731535408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5lK0zn96s7UodknqEKSCwXRLrysQOctypmDAeM9PQ8=;
 b=NnzIp6GQgJxcE2Xd/IRduiPIZG8TdWCyWLa/xH63DRcMOZ/oFudWTe3SMyP65fFvJ7oUQQ
 Zby/UYM+WPxmH2So+If8uKSGXVbFuLvPhlHBrlXJrEXSN7KqLyUJSwS4oKYjF9A/c+8269
 C6PnfJ5mzsddbTtBrN0e08bh/YrurE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731535408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5lK0zn96s7UodknqEKSCwXRLrysQOctypmDAeM9PQ8=;
 b=qgliPY/QAxuj4nCiKoPvfab9bMxkOmMwjLNouZsvu4CpqMT0VPTiWxz0PwwnAipXU4gNe5
 bJhd5vMzaYqR43Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731535408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5lK0zn96s7UodknqEKSCwXRLrysQOctypmDAeM9PQ8=;
 b=NnzIp6GQgJxcE2Xd/IRduiPIZG8TdWCyWLa/xH63DRcMOZ/oFudWTe3SMyP65fFvJ7oUQQ
 Zby/UYM+WPxmH2So+If8uKSGXVbFuLvPhlHBrlXJrEXSN7KqLyUJSwS4oKYjF9A/c+8269
 C6PnfJ5mzsddbTtBrN0e08bh/YrurE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731535408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5lK0zn96s7UodknqEKSCwXRLrysQOctypmDAeM9PQ8=;
 b=qgliPY/QAxuj4nCiKoPvfab9bMxkOmMwjLNouZsvu4CpqMT0VPTiWxz0PwwnAipXU4gNe5
 bJhd5vMzaYqR43Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9643313A91;
 Wed, 13 Nov 2024 22:03:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jaP9Fi8iNWfPGQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 22:03:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, lvivier@redhat.com, pbonzini@redhat.com,
 Ivan Klokov <ivan.klokov@syntacore.com>
Subject: Re: [RFC PATCH v6 1/2] target/riscv: Add RISC-V CSR qtest support
In-Reply-To: <20241112143826.88130-2-ivan.klokov@syntacore.com>
References: <20241112143826.88130-1-ivan.klokov@syntacore.com>
 <20241112143826.88130-2-ivan.klokov@syntacore.com>
Date: Wed, 13 Nov 2024 19:03:25 -0300
Message-ID: <877c96iyfm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,dabbelt.com,wdc.com,gmail.com,ventanamicro.com,linux.alibaba.com,redhat.com,syntacore.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Ivan Klokov <ivan.klokov@syntacore.com> writes:

> The RISC-V architecture supports the creation of custom
> CSR-mapped devices. It would be convenient to test them in the same way
> as MMIO-mapped devices. To do this, a new call has been added
> to read/write CSR registers.
>
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> ---
>  hw/riscv/riscv_hart.c  | 55 ++++++++++++++++++++++++++++++++++++++++++
>  tests/qtest/libqtest.c | 27 +++++++++++++++++++++
>  tests/qtest/libqtest.h | 14 +++++++++++
>  3 files changed, 96 insertions(+)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 613ea2aaa0..0b725ff9ce 100644
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
> @@ -42,6 +44,55 @@ static void riscv_harts_cpu_reset(void *opaque)
>      cpu_reset(CPU(cpu));
>  }
>=20=20
> +#ifndef CONFIG_USER_ONLY
> +static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *v=
al)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(cpu_num));
> +    CPURISCVState *env =3D &cpu->env;
> +
> +    int ret =3D RISCV_EXCP_NONE;
> +    if (strcmp(cmd, "get_csr") =3D=3D 0) {
> +        ret =3D riscv_csrr(env, csrno, (target_ulong *)val);
> +    } else if (strcmp(cmd, "set_csr") =3D=3D 0) {
> +        ret =3D riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
> +                MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
> +    }
> +
> +    g_assert(ret =3D=3D RISCV_EXCP_NONE);
> +}
> +
> +static bool csr_qtest_callback(CharBackend *chr, gchar **words)
> +{
> +    if (strcmp(words[0], "csr") =3D=3D 0) {
> +
> +        uint64_t cpu;
> +        uint64_t val;
> +        int rc, csr;
> +
> +        rc =3D qemu_strtou64(words[2], NULL, 0, &cpu);
> +        g_assert(rc =3D=3D 0);
> +        rc =3D qemu_strtoi(words[3], NULL, 0, &csr);
> +        g_assert(rc =3D=3D 0);
> +        rc =3D qemu_strtou64(words[4], NULL, 0, &val);
> +        g_assert(rc =3D=3D 0);
> +        csr_call(words[1], cpu, csr, &val);
> +
> +        qtest_send_prefix(chr);
> +        qtest_sendf(chr, "OK %"PRIx64" "TARGET_FMT_lx"\n", res, (target_=
ulong)val);

../hw/riscv/riscv_hart.c: In function =E2=80=98csr_qtest_callback=E2=80=99:
../hw/riscv/riscv_hart.c:81:60: error: =E2=80=98res=E2=80=99 undeclared (fi=
rst use in this function)
         qtest_sendf(chr, "OK %"PRIx64" "TARGET_FMT_lx"\n", res, (target_ul=
ong)val);
                                                            ^~~
compilation terminated due to -Wfatal-errors.

I'll leave the rest of the review to the riscv people. Please when you
resend add a:

Acked-by: Fabiano Rosas <farosas@suse.de>

> +
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static void riscv_cpu_register_csr_qtest_callback(void)
> +{
> +    static GOnce once;
> +    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback);
> +}
> +#endif
> +
>  static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
>                                 char *cpu_type, Error **errp)
>  {
> @@ -59,6 +110,10 @@ static void riscv_harts_realize(DeviceState *dev, Err=
or **errp)
>=20=20
>      s->harts =3D g_new0(RISCVCPU, s->num_harts);
>=20=20
> +#ifndef CONFIG_USER_ONLY
> +    riscv_cpu_register_csr_qtest_callback();
> +#endif
> +
>      for (n =3D 0; n < s->num_harts; n++) {
>          if (!riscv_hart_realize(s, n, s->cpu_type, errp)) {
>              return;
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 817fd7aac5..43bfa496e9 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1202,6 +1202,33 @@ uint64_t qtest_rtas_call(QTestState *s, const char=
 *name,
>      return 0;
>  }
>=20=20
> +static void qtest_rsp_csr(QTestState *s, uint64_t *val)
> +{
> +    gchar **args;
> +    uint64_t ret;
> +    int rc;
> +
> +    args =3D qtest_rsp_args(s, 3);
> +
> +    rc =3D qemu_strtou64(args[1], NULL, 16, &ret);
> +    g_assert(rc =3D=3D 0);
> +    rc =3D qemu_strtou64(args[2], NULL, 16, val);
> +    g_assert(rc =3D=3D 0);
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
>      gchar *path =3D g_strdup_printf("/%s/%s", qtest_get_arch(), str);
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index beb96b18eb..b516a16bd4 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -575,6 +575,20 @@ uint64_t qtest_rtas_call(QTestState *s, const char *=
name,
>                           uint32_t nargs, uint64_t args,
>                           uint32_t nret, uint64_t ret);
>=20=20
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

