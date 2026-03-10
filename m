Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358A6FD4F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 20:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w03XL-0007r3-Si; Tue, 10 Mar 2026 16:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w03XK-0007qs-IF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:18:38 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w03XI-0003sX-OW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:18:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 702D63F839;
 Tue, 10 Mar 2026 20:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773173915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52N4tnakCBbQp7mnAEHTB2gKrv4bJ8TzMYc56fgl/IM=;
 b=RaudJAX9geYFanJdZGzlP9g6q55qZpuNK51Fk2yBObGeMikJLCDQXaiPFGFVnyhrSe3QWD
 mF4jwFJ4u+OcNr/e8hNSA9qnM2y7wq0v9y7Ru6eyc1s7pHc3h1U2DBBMEZazDPNvTZw2bj
 Qws4YNMUx8LtOu1D+rCgoCx/aLZtopc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773173915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52N4tnakCBbQp7mnAEHTB2gKrv4bJ8TzMYc56fgl/IM=;
 b=yM8pVpewTpTohN/VtFTuYVWf9O1N1sHIMjdpKe5lIqeeEppPOFV8jMZfibZEnBYa2nNWpg
 q2cKBPmzSX1eVoBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RaudJAX9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yM8pVpew
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773173915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52N4tnakCBbQp7mnAEHTB2gKrv4bJ8TzMYc56fgl/IM=;
 b=RaudJAX9geYFanJdZGzlP9g6q55qZpuNK51Fk2yBObGeMikJLCDQXaiPFGFVnyhrSe3QWD
 mF4jwFJ4u+OcNr/e8hNSA9qnM2y7wq0v9y7Ru6eyc1s7pHc3h1U2DBBMEZazDPNvTZw2bj
 Qws4YNMUx8LtOu1D+rCgoCx/aLZtopc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773173915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52N4tnakCBbQp7mnAEHTB2gKrv4bJ8TzMYc56fgl/IM=;
 b=yM8pVpewTpTohN/VtFTuYVWf9O1N1sHIMjdpKe5lIqeeEppPOFV8jMZfibZEnBYa2nNWpg
 q2cKBPmzSX1eVoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF3943F632;
 Tue, 10 Mar 2026 20:18:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y0LaLJp8sGnuAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 20:18:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Laurent
 Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 2/2] tests/qtest/test-x86-cpuid-compat: Switch
 test_feature_flag to data-driven
In-Reply-To: <20260308185421.972734-3-peter.maydell@linaro.org>
References: <20260308185421.972734-1-peter.maydell@linaro.org>
 <20260308185421.972734-3-peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 17:18:32 -0300
Message-ID: <87qzprzbdz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, linaro.org:email]
X-Rspamd-Queue-Id: 702D63F839
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Peter Maydell <peter.maydell@linaro.org> writes:

> As with add_cpuid_test(), the add_feature_test() function also
> allocates memory that is leaked if the test case is not run.  Fix
> this in the same way, by moving all the allocations into
> test_feature_flag() and passing it a pointer to a struct with the
> necessary parameters which is a compile-time constant.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/test-x86-cpuid-compat.c | 134 +++++++++++++++-------------
>  1 file changed, 72 insertions(+), 62 deletions(-)
>
> diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
> index fc90a46d37..17c0965827 100644
> --- a/tests/qtest/test-x86-cpuid-compat.c
> +++ b/tests/qtest/test-x86-cpuid-compat.c
> @@ -94,8 +94,12 @@ static void test_cpuid_prop(const void *data)
>  
>  /* Parameters to a add_feature_test() test case */
>  typedef struct FeatureTestArgs {
> -    /* cmdline to start QEMU */
> -    const char *cmdline;
> +    /* Test name */
> +    const char *name;
> +    /* CPU type */
> +    const char *cpu;
> +    /* CPU features, may be NULL */
> +    const char *cpufeat;
>      /*
>       * cpuid-input-eax and cpuid-input-ecx values to look for,
>       * in "feature-words" and "filtered-features" properties.
> @@ -140,10 +144,17 @@ static void test_feature_flag(const void *data)
>  {
>      const FeatureTestArgs *args = data;
>      char *path;
> +    char *cmdline;
>      QList *present, *filtered;
>      uint32_t value;
>  
> -    qtest_start(args->cmdline);
> +    if (args->cpufeat) {
> +        cmdline = g_strdup_printf("-cpu %s,%s", args->cpu, args->cpufeat);
> +    } else {
> +        cmdline = g_strdup_printf("-cpu %s", args->cpu);
> +    }
> +
> +    qtest_start(cmdline);
>      path = get_cpu0_qom_path();
>      present = qobject_to(QList, qom_get(path, "feature-words"));
>      filtered = qobject_to(QList, qom_get(path, "filtered-features"));
> @@ -156,40 +167,7 @@ static void test_feature_flag(const void *data)
>      qobject_unref(present);
>      qobject_unref(filtered);
>      g_free(path);
> -    g_free((void *)args->cmdline);
> -    g_free((void *)data);
> -}
> -
> -/*
> - * Add test case to ensure that a given feature flag is set in
> - * either "feature-words" or "filtered-features", when running QEMU
> - * using cmdline
> - */
> -static void add_feature_test(const char *name, const char *cpu,
> -                             const char *cpufeat, uint32_t eax,
> -                             uint32_t ecx, const char *reg,
> -                             int bitnr, bool expected_value)
> -{
> -    FeatureTestArgs *args = g_new0(FeatureTestArgs, 1);
> -    char *cmdline;
> -
> -    if (!qtest_has_cpu_model(cpu)) {
> -        return;
> -    }
> -
> -    if (cpufeat) {
> -        cmdline = g_strdup_printf("-cpu %s,%s", cpu, cpufeat);
> -    } else {
> -        cmdline = g_strdup_printf("-cpu %s", cpu);
> -    }
> -
> -    args->cmdline = cmdline;
> -    args->in_eax = eax;
> -    args->in_ecx = ecx;
> -    args->reg = reg;
> -    args->bitnr = bitnr;
> -    args->expected_value = expected_value;
> -    qtest_add_data_func(name, args, test_feature_flag);
> +    g_free(cmdline);
>  }
>  
>  static void test_plus_minus_subprocess(void)
> @@ -381,6 +359,56 @@ static const CpuidTestArgs cpuid_tests[] = {
>      },
>  };
>  
> +/*
> + * Test cases to ensure that a given feature flag is set in
> + * either "feature-words" or "filtered-features", when running QEMU
> + * using cmdline
> + */
> +static const FeatureTestArgs feature_tests[] = {
> +    /* Test feature parsing */
> +    {
> +        "x86/cpuid/features/plus",
> +        "486", "+arat",
> +        6, 0, "EAX", 2, true,
> +    },
> +    {
> +        "x86/cpuid/features/minus",
> +        "pentium", "-mmx",
> +        1, 0, "EDX", 23, false,
> +    },
> +    {
> +        "x86/cpuid/features/on",
> +        "486", "arat=on",
> +        6, 0, "EAX", 2, true,
> +    },
> +    {
> +        "x86/cpuid/features/off",
> +        "pentium", "mmx=off",
> +        1, 0, "EDX", 23, false,
> +    },
> +
> +    {
> +        "x86/cpuid/features/max-plus-invtsc",
> +        "max" , "+invtsc",
> +        0x80000007, 0, "EDX", 8, true,
> +    },
> +    {
> +        "x86/cpuid/features/max-invtsc-on",
> +        "max", "invtsc=on",
> +        0x80000007, 0, "EDX", 8, true,
> +    },
> +    {
> +        "x86/cpuid/features/max-minus-mmx",
> +        "max", "-mmx",
> +        1, 0, "EDX", 23, false,
> +    },
> +    {
> +        "x86/cpuid/features/max-invtsc-on,mmx=off",
> +        "max", "mmx=off",
> +        1, 0, "EDX", 23, false,
> +    },
> +};
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -397,32 +425,14 @@ int main(int argc, char **argv)
>                              &cpuid_tests[i], test_cpuid_prop);
>      }
>  
> -    /* Test feature parsing */
> -    add_feature_test("x86/cpuid/features/plus",
> -                     "486", "+arat",
> -                     6, 0, "EAX", 2, true);
> -    add_feature_test("x86/cpuid/features/minus",
> -                     "pentium", "-mmx",
> -                     1, 0, "EDX", 23, false);
> -    add_feature_test("x86/cpuid/features/on",
> -                     "486", "arat=on",
> -                     6, 0, "EAX", 2, true);
> -    add_feature_test("x86/cpuid/features/off",
> -                     "pentium", "mmx=off",
> -                     1, 0, "EDX", 23, false);
>  
> -    add_feature_test("x86/cpuid/features/max-plus-invtsc",
> -                     "max" , "+invtsc",
> -                     0x80000007, 0, "EDX", 8, true);
> -    add_feature_test("x86/cpuid/features/max-invtsc-on",
> -                     "max", "invtsc=on",
> -                     0x80000007, 0, "EDX", 8, true);
> -    add_feature_test("x86/cpuid/features/max-minus-mmx",
> -                     "max", "-mmx",
> -                     1, 0, "EDX", 23, false);
> -    add_feature_test("x86/cpuid/features/max-invtsc-on,mmx=off",
> -                     "max", "mmx=off",
> -                     1, 0, "EDX", 23, false);
> +    for (int i = 0; i < ARRAY_SIZE(feature_tests); i++) {
> +        if (!qtest_has_cpu_model(feature_tests[i].cpu)) {
> +            continue;
> +        }
> +        qtest_add_data_func(feature_tests[i].name,
> +                            &feature_tests[i], test_feature_flag);
> +    }
>  
>      return g_test_run();
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

