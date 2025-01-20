Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F99C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 22:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZzta-0001yX-RO; Mon, 20 Jan 2025 17:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tZztZ-0001ws-1O
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 17:05:21 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tZztW-00076L-I5
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 17:05:20 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so8470183a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 14:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737410716; x=1738015516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HAcEusjzYH3QqmuK9Xi8ykEJwD47DNBc0rTmFjn7ETU=;
 b=H+INtctJHU7KTr7BTysL3Wkd7w0hxQzxRScugLG4mFw7hipeLUWo9hcAf7soEY+lO5
 nnfH6mxYwjrSOxP1w4w1eyQLUMhnk6YxvPRYHF2t951nXQW4kapn8KLzdBrjkYFP0kQb
 E8PdyFFP5D1HFTEB0WUqFwZulVGwwmLK6rESwoWBmlGwZJncohRula0lVAWrxugx0foi
 cEInfENGFzHJELiEsoGHwjozWMRdd95b7fu8QFKt4TJyR+paFl8dNoko0nHVMnScQd/O
 Hji+/TwuA/rhE5HUYw1bofAFxw/Jbm3qx4VGKQMrgOvQshgFAp75f6BCJEHnr7+HFSIM
 Yd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410716; x=1738015516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HAcEusjzYH3QqmuK9Xi8ykEJwD47DNBc0rTmFjn7ETU=;
 b=jDn1XOhliK2MrDwJuF0EJgsuHDHkybl7fsEa3ecYLjfEsHSg8g7k3yebOmxXjVDMoI
 pT5CRguhLmbK0c+Bih1ap7a/QG788rf1QYJQ/dvAsMfRRFf+slz3DeIj83Sp23fiwmYC
 pAiJkEiU+F6BZQ69G7ulFvy5VVVteL8mK6Id899GURnxQt+L96rajbAau7Ii3XZmGDEm
 lQEJlvH2BVQHm5puWoc0pHNBlAuhcOu+7xpUuuD3Nf6g6eO5FYf75md9A+Ag2UBm56q4
 gjJABFO5hJ7sLREzXNyFyqm8LEF4y/GpqRi+ZmmC4V6ZMEEkmpvUKASnguzlH7UVSna6
 xusQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgA7mudPomuhaCnwqqP5VLjWMMQsCgW4KKECng+btaUkQiPm+sBKwG/7UPwKR2uwCPsg4JVvzS8lGN@nongnu.org
X-Gm-Message-State: AOJu0Yy7NWnxoV8vvgQUa8dSdDvsbpeSRGj6iDIFB6tB3SDZPDiuD+0O
 RglvhZvBNRB4CYB3EmlPvo9pv4yOdP7ZSIwp3T9fjeWI/kdNkvbqHO5B4/iH+vY=
X-Gm-Gg: ASbGncs2huu3Wi1gE4tvpY+4tlpq+oWrApFAklC9D6hutaO+IVjyVB3sYisY7RY5aWM
 PHU1Jl/ojRyjqNyN1u76fDOCFPlRGeC3FIBtasxOEOOdj1BEXnFU3581SbHNpxOkBXwZ+ddXv4V
 /w5MfGWLEqhUc69UYZDEYTVlUtLgmNg1H0Cdv/NE0DudWsmtTZQmkRseY7B5/fR1qHZ9+9UQIWh
 MmelTJcXrmzbkl9ANwfIQCQ+54VQnh6wYZ9qVca9kwNGNDIqtK+8Jm284xv+qquy7tsce9IQjjw
 JWhAY5sZ
X-Google-Smtp-Source: AGHT+IFmvruijp1BEvAnBJfOm1j9+gPPi9V7Kkx3ueo6O/d/NXd36XGCBQQTWZBTOae1S2dEL7DSTw==
X-Received: by 2002:a17:90b:5485:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-2f782c4bd9amr23642731a91.7.1737410716602; 
 Mon, 20 Jan 2025 14:05:16 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c17f6cdsm12535617a91.12.2025.01.20.14.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 14:05:16 -0800 (PST)
Message-ID: <5dfb0ac1-5f1b-4132-8041-16d6a8907319@ventanamicro.com>
Date: Mon, 20 Jan 2025 19:05:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] tests/qtest: rename qtest_send_prefix and roll-up
 into qtest_send
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
 <20250120210212.3890255-6-alex.bennee@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250120210212.3890255-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 1/20/25 6:02 PM, Alex Bennée wrote:
> qtest_send_prefix never actually sent something over the chardev, all
> it does is print the timestamp to the QTEST_LOG when enabled. So
> rename the function, make it static, remove the unused CharDev and
> simplify all the call sites by handling that directly with
> qtest_send (and qtest_log_send).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   include/system/qtest.h |  1 -
>   hw/ppc/spapr_rtas.c    |  1 -
>   hw/riscv/riscv_hart.c  |  1 -
>   system/qtest.c         | 26 +++-----------------------
>   4 files changed, 3 insertions(+), 26 deletions(-)
> 
> diff --git a/include/system/qtest.h b/include/system/qtest.h
> index c161d75165..6ddddc501b 100644
> --- a/include/system/qtest.h
> +++ b/include/system/qtest.h
> @@ -24,7 +24,6 @@ static inline bool qtest_enabled(void)
>   }
>   
>   #ifndef CONFIG_USER_ONLY
> -void qtest_send_prefix(CharBackend *chr);
>   void G_GNUC_PRINTF(2, 3) qtest_sendf(CharBackend *chr, const char *fmt, ...);
>   void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words));
>   bool qtest_driver(void);
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index df2e837632..503d441b48 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -565,7 +565,6 @@ static bool spapr_qtest_callback(CharBackend *chr, gchar **words)
>           g_assert(rc == 0);
>           res = qtest_rtas_call(words[1], nargs, args, nret, ret);
>   
> -        qtest_send_prefix(chr);
>           qtest_sendf(chr, "OK %"PRIu64"\n", res);
>   
>           return true;
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index ad67cd7645..a55d156668 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -94,7 +94,6 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
>           g_assert(rc == 0);
>           csr_call(words[1], cpu, csr, &val);
>   
> -        qtest_send_prefix(chr);
>           qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
>   
>           return true;
> diff --git a/system/qtest.c b/system/qtest.c
> index bb1efba9fd..28b6fac37c 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -265,7 +265,7 @@ static int hex2nib(char ch)
>       }
>   }
>   
> -void qtest_send_prefix(CharBackend *chr)
> +static void qtest_log_timestamp(void)
>   {
>       if (!qtest_log_fp || !qtest_opened) {
>           return;
> @@ -282,7 +282,7 @@ static void G_GNUC_PRINTF(1, 2) qtest_log_send(const char *fmt, ...)
>           return;
>       }
>   
> -    qtest_send_prefix(NULL);
> +    qtest_log_timestamp();
>   
>       va_start(ap, fmt);
>       vfprintf(qtest_log_fp, fmt, ap);
> @@ -301,6 +301,7 @@ static void qtest_server_char_be_send(void *opaque, const char *str)
>   
>   static void qtest_send(CharBackend *chr, const char *str)
>   {
> +    qtest_log_timestamp();
>       qtest_server_send(qtest_server_send_opaque, str);
>   }
>   
> @@ -324,7 +325,6 @@ static void qtest_irq_handler(void *opaque, int n, int level)
>       if (irq_levels[n] != level) {
>           CharBackend *chr = &qtest->qtest_chr;
>           irq_levels[n] = level;
> -        qtest_send_prefix(chr);
>           qtest_sendf(chr, "IRQ %s %d\n",
>                       level ? "raise" : "lower", n);
>       }
> @@ -380,19 +380,16 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           is_outbound = words[0][14] == 'o';
>           dev = DEVICE(object_resolve_path(words[1], NULL));
>           if (!dev) {
> -            qtest_send_prefix(chr);
>               qtest_send(chr, "FAIL Unknown device\n");
>               return;
>           }
>   
>           if (is_named && !is_outbound) {
> -            qtest_send_prefix(chr);
>               qtest_send(chr, "FAIL Interception of named in-GPIOs not yet supported\n");
>               return;
>           }
>   
>           if (irq_intercept_dev) {
> -            qtest_send_prefix(chr);
>               if (irq_intercept_dev != dev) {
>                   qtest_send(chr, "FAIL IRQ intercept already enabled\n");
>               } else {
> @@ -419,7 +416,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>               }
>           }
>   
> -        qtest_send_prefix(chr);
>           if (interception_succeeded) {
>               irq_intercept_dev = dev;
>               qtest_send(chr, "OK\n");
> @@ -438,7 +434,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>   
>           dev = DEVICE(object_resolve_path(words[1], NULL));
>           if (!dev) {
> -            qtest_send_prefix(chr);
>               qtest_send(chr, "FAIL Unknown device\n");
>               return;
>           }
> @@ -457,7 +452,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           irq = qdev_get_gpio_in_named(dev, name, num);
>   
>           qemu_set_irq(irq, level);
> -        qtest_send_prefix(chr);
>           qtest_send(chr, "OK\n");
>       } else if (strcmp(words[0], "outb") == 0 ||
>                  strcmp(words[0], "outw") == 0 ||
> @@ -480,7 +474,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           } else if (words[0][3] == 'l') {
>               cpu_outl(addr, value);
>           }
> -        qtest_send_prefix(chr);
>           qtest_send(chr, "OK\n");
>       } else if (strcmp(words[0], "inb") == 0 ||
>           strcmp(words[0], "inw") == 0 ||
> @@ -501,7 +494,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           } else if (words[0][2] == 'l') {
>               value = cpu_inl(addr);
>           }
> -        qtest_send_prefix(chr);
>           qtest_sendf(chr, "OK 0x%04x\n", value);
>       } else if (strcmp(words[0], "writeb") == 0 ||
>                  strcmp(words[0], "writew") == 0 ||
> @@ -537,7 +529,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>               address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
>                                   &data, 8);
>           }
> -        qtest_send_prefix(chr);
>           qtest_send(chr, "OK\n");
>       } else if (strcmp(words[0], "readb") == 0 ||
>                  strcmp(words[0], "readw") == 0 ||
> @@ -571,7 +562,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>                                  &value, 8);
>               tswap64s(&value);
>           }
> -        qtest_send_prefix(chr);
>           qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
>       } else if (strcmp(words[0], "read") == 0) {
>           g_autoptr(GString) enc = NULL;
> @@ -593,7 +583,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>   
>           enc = qemu_hexdump_line(NULL, data, len, 0, 0);
>   
> -        qtest_send_prefix(chr);
>           qtest_sendf(chr, "OK 0x%s\n", enc->str);
>   
>           g_free(data);
> @@ -613,7 +602,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
>                              len);
>           b64_data = g_base64_encode(data, len);
> -        qtest_send_prefix(chr);
>           qtest_sendf(chr, "OK %s\n", b64_data);
>   
>           g_free(data);
> @@ -649,7 +637,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>                               len);
>           g_free(data);
>   
> -        qtest_send_prefix(chr);
>           qtest_send(chr, "OK\n");
>       } else if (strcmp(words[0], "memset") == 0) {
>           uint64_t addr, len;
> @@ -673,7 +660,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>               g_free(data);
>           }
>   
> -        qtest_send_prefix(chr);
>           qtest_send(chr, "OK\n");
>       }  else if (strcmp(words[0], "b64write") == 0) {
>           uint64_t addr, len;
> @@ -705,10 +691,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
>                               len);
>   
> -        qtest_send_prefix(chr);
>           qtest_send(chr, "OK\n");
>       } else if (strcmp(words[0], "endianness") == 0) {
> -        qtest_send_prefix(chr);
>           if (target_words_bigendian()) {
>               qtest_sendf(chr, "OK big\n");
>           } else {
> @@ -726,7 +710,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>                                               QEMU_TIMER_ATTR_ALL);
>           }
>           new_ns = qemu_clock_advance_virtual_time(old_ns + ns);
> -        qtest_send_prefix(chr);
>           qtest_sendf(chr, "%s %"PRIi64"\n",
>                       new_ns > old_ns ? "OK" : "FAIL", new_ns);
>       } else if (strcmp(words[0], "module_load") == 0) {
> @@ -734,7 +717,6 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           int rv;
>           g_assert(words[1] && words[2]);
>   
> -        qtest_send_prefix(chr);
>           rv = module_load(words[1], words[2], &local_err);
>           if (rv > 0) {
>               qtest_sendf(chr, "OK\n");
> @@ -752,13 +734,11 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           ret = qemu_strtoi64(words[1], NULL, 0, &ns);
>           g_assert(ret == 0);
>           new_ns = qemu_clock_advance_virtual_time(ns);
> -        qtest_send_prefix(chr);
>           qtest_sendf(chr, "%s %"PRIi64"\n",
>                       new_ns == ns ? "OK" : "FAIL", new_ns);
>       } else if (process_command_cb && process_command_cb(chr, words)) {
>           /* Command got consumed by the callback handler */
>       } else {
> -        qtest_send_prefix(chr);
>           qtest_sendf(chr, "FAIL Unknown command '%s'\n", words[0]);
>       }
>   }


