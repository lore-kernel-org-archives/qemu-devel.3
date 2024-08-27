Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45277C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 16:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siydB-0003J3-7M; Tue, 27 Aug 2024 12:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1siyd7-00037Q-A1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:01:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1siyd5-0006ME-4j
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:01:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-714114be925so4889490b3a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724774469; x=1725379269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=She6dLh7EB94KM+e5VTra8kYvo7BYX1BYNjLG+58MxY=;
 b=FaLG3iBas2gBoD2zT5EPTFrsT56Ebz5PDKBzK13+Pzmg0IWajvqn8+fM/VG56hY/+1
 TJssVQZxwk3in2v4DzofiEr3ppLIxv9xx9fNImMBUV+ym+S5s5tAUrxsq1cLNwv4bLEm
 q9ARrsAFLBUevgi7RpTnxQqHaODrSX9JvKXTyxO9KShYzWgE86mxFc1P29vfpoAXXxNd
 msHdf5wk7wtC8/xRF9c4cTrsI8Xq3lDYbECo8OFIoUzd2KED88PpA94FBtCpebFlbAiB
 XaGc1C8Ws5DkO7L7YPXxZsFullbmyIQ8JheP9mgAfsxz2l4RkgqxGrUrlsZ2LWbzOk90
 5Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724774469; x=1725379269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=She6dLh7EB94KM+e5VTra8kYvo7BYX1BYNjLG+58MxY=;
 b=EHBYochdJglvYjBrced987IbXLkrh6Kr/oCuriBTkl390xkNbNCwvGOpEL8GdGzKVY
 hmYy7i5wCbe+OfI5FZa9yIobCwn39J1LNtqnvZOBtRBS9WWFU9UbD1h7aSTVelqQOoEK
 PgS2U07dug59j7xczzri6wxJpifIg3fs0j8NbC22v/2StEO27xZuvB3prAwa55h/iH2Z
 UdAotMeHQnF/8dFZ6v2BGL2wTpjEGWxbuwPFVsq5E1u70kTTz4EYqlUEov9XALZF2GVX
 VhKlTb72LXBpAatyDdJHL16Wh6oIR6/ITXJefGEybQybpVlyz1iKSLMoiQEfpkb6LG92
 0b+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe6ZseNJ58FiW4AoA31F0V8gsyRUnY1pStifTA9easn0Bv1/wH9mQa7D3gOsvBD3kibLj6TcRhC6q6@nongnu.org
X-Gm-Message-State: AOJu0YyzT/4XDP/CbvL/xL8731SUrScKxYe78FpRBJLCs+XYZdDalxaU
 pFSTyTU5IeUTrtAhjLwTsTRDy0SsNt8IxvFjCYhb7Cyx46EpBut0YaFlWxqA/hI=
X-Google-Smtp-Source: AGHT+IFuwyokgPZpgXpW9URk5MKIXiKR7PUrM/PXhT+20AfQdq4qWtPd/UGRiDZ/unixfWhpN12Nzw==
X-Received: by 2002:a05:6a20:9f08:b0:1c4:c3a1:f479 with SMTP id
 adf61e73a8af0-1ccc098661fmr3617452637.39.1724774469352; 
 Tue, 27 Aug 2024 09:01:09 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00:5b09:8db7:b002:cf61?
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9ad6ba10sm8191971a12.78.2024.08.27.09.01.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 09:01:08 -0700 (PDT)
Message-ID: <a972a1f1-b418-47a9-8ef1-8de1737d7822@linaro.org>
Date: Tue, 27 Aug 2024 09:01:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] plugins: add option to dump write argument to
 syscall plugin
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240827021847.218390-1-rowanbhart@gmail.com>
 <20240827021847.218390-3-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240827021847.218390-3-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 8/26/24 19:18, Rowan Hart wrote:
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   docs/about/emulation.rst    |  14 ++++-
>   tests/tcg/plugins/syscall.c | 117 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index eea1261baa..e85d494ff0 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -388,6 +388,19 @@ run::
>     160          1      0
>     135          1      0
>   
> +Behaviour can be tweaked with the following arguments:
> +
> +.. list-table:: Syscall plugin arguments
> +  :widths: 20 80
> +  :header-rows: 1
> +
> +  * - Option
> +    - Description
> +  * - print=true|false
> +    - Print the number of times each syscall is called
> +  * - log_writes=true|false
> +    - Log the buffer of each write syscall in hexdump format
> +
>   Test inline operations
>   ......................
>   
> @@ -777,4 +790,3 @@ Other emulation features
>   When running system emulation you can also enable deterministic
>   execution which allows for repeatable record/replay debugging. See
>   :ref:`Record/Replay<replay>` for more details.
> -
> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 72e1a5bf90..7c92f798b5 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -22,8 +22,57 @@ typedef struct {
>       int64_t errors;
>   } SyscallStats;
>   
> +struct SyscallInfo {
> +    const char *name;
> +    int64_t write_sysno;
> +};
> +
> +const struct SyscallInfo arch_syscall_info[] = {
> +    { "aarch64", 64 },
> +    { "aarch64_be", 64 },
> +    { "alpha", 4 },
> +    { "arm", 4 },
> +    { "armeb", 4 },
> +    { "avr", -1 },
> +    { "cris", -1 },
> +    { "hexagon", 64 },
> +    { "hppa", -1 },
> +    { "i386", 4 },
> +    { "loongarch64", -1 },
> +    { "m68k", 4 },
> +    { "microblaze", 4 },
> +    { "microblazeel", 4 },
> +    { "mips", 1 },
> +    { "mips64", 1 },
> +    { "mips64el", 1 },
> +    { "mipsel", 1 },
> +    { "mipsn32", 1 },
> +    { "mipsn32el", 1 },
> +    { "or1k", -1 },
> +    { "ppc", 4 },
> +    { "ppc64", 4 },
> +    { "ppc64le", 4 },
> +    { "riscv32", 64 },
> +    { "riscv64", 64 },
> +    { "rx", -1 },
> +    { "s390x", -1 },
> +    { "sh4", -1 },
> +    { "sh4eb", -1 },
> +    { "sparc", 4 },
> +    { "sparc32plus", 4 },
> +    { "sparc64", 4 },
> +    { "tricore", -1 },
> +    { "x86_64", 1 },
> +    { "xtensa", 13 },
> +    { "xtensaeb", 13 },
> +    { NULL, -1 },
> +};
> +
>   static GMutex lock;
>   static GHashTable *statistics;
> +static GByteArray *memory_buffer;
> +static bool do_log_writes;
> +static int64_t write_sysno = -1;
>   
>   static SyscallStats *get_or_create_entry(int64_t num)
>   {
> @@ -39,6 +88,44 @@ static SyscallStats *get_or_create_entry(int64_t num)
>       return entry;
>   }
>   
> +/*
> + * Hex-dump a GByteArray to the QEMU plugin output in the format:
> + * 61 63 63 65 6c 09 09 20 20 20 66 70 75 09 09 09  | accel.....fpu...
> + * 20 6d 6f 64 75 6c 65 2d 63 6f 6d 6d 6f 6e 2e 63  | .module-common.c
> + */
> +static void hexdump(const GByteArray *data)
> +{
> +    g_autoptr(GString) out = g_string_new("");
> +
> +    for (guint index = 0; index < data->len; index += 16) {
> +        for (guint col = 0; col < 16; col++) {
> +            if (index + col < data->len) {
> +                g_string_append_printf(out, "%02x ", data->data[index + col]);
> +            } else {
> +                g_string_append(out, "   ");
> +            }
> +        }
> +
> +        g_string_append(out, " | ");
> +
> +        for (guint col = 0; col < 16; col++) {
> +            if (index + col >= data->len) {
> +                break;
> +            }
> +
> +            if (g_ascii_isgraph(data->data[index + col])) {
> +                g_string_append_printf(out, "%c", data->data[index + col]);
> +            } else {
> +                g_string_append(out, ".");
> +            }
> +        }
> +
> +        g_string_append(out, "\n");
> +    }
> +
> +    qemu_plugin_outs(out->str);
> +}
> +
>   static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
>                            int64_t num, uint64_t a1, uint64_t a2,
>                            uint64_t a3, uint64_t a4, uint64_t a5,
> @@ -54,6 +141,14 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
>           g_autofree gchar *out = g_strdup_printf("syscall #%" PRIi64 "\n", num);
>           qemu_plugin_outs(out);
>       }
> +
> +    if (do_log_writes && num == write_sysno) {
> +        if (qemu_plugin_read_memory_vaddr(a2, memory_buffer, a3)) {
> +            hexdump(memory_buffer);
> +        } else {
> +            fprintf(stderr, "Error reading memory from vaddr %lu\n", a2);
> +        }
> +    }
>   }
>   
>   static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
> @@ -127,6 +222,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>               if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_print)) {
>                   fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>               }
> +        } else if (g_strcmp0(tokens[0], "log_writes") == 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_log_writes)) {
> +                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
> +            }
>           } else {
>               fprintf(stderr, "unsupported argument: %s\n", argv[i]);
>               return -1;
> @@ -137,6 +236,24 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>           statistics = g_hash_table_new_full(NULL, g_direct_equal, NULL, g_free);
>       }
>   
> +    if (do_log_writes) {
> +        for (const struct SyscallInfo *syscall_info = arch_syscall_info;
> +            syscall_info->name != NULL; syscall_info++) {
> +
> +            if (g_strcmp0(syscall_info->name, info->target_name) == 0) {
> +                write_sysno = syscall_info->write_sysno;
> +                break;
> +            }
> +        }
> +
> +        if (write_sysno == -1) {
> +            fprintf(stderr, "write syscall number not found\n");
> +            return -1;
> +        }
> +
> +        memory_buffer = g_byte_array_new();
> +    }
> +
>       qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
>       qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);

Works as expected.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

