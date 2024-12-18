Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B6FE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxMS-0000Pg-78; Wed, 18 Dec 2024 11:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNxMR-0000PT-3Z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:57:23 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNxMO-0000Tl-BP
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:57:22 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53e3778bffdso6934507e87.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734541038; x=1735145838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gewfvRSg1yvYtJsYr/1dBfhMLGPrisAa5MQCBDTJipY=;
 b=acMuM70cKtELw9xzcWn0Mm4fuFGbLVSnCNJGNceI0hH1qJeyZO+RGepHRRBiog2guH
 O57EXw76t7cnjran8qLYcU5l+2DFiPEQtpaRkjJsc3lVyG/ui2d6l+z/hNP3t8Du1Dga
 U5leLIa4Lkcbz4tnsDq4x46VeRY29JILTplasZS/o2iD6Ht/W9XpLoX8UKTu+pme5Nf7
 XOgpVLVDKqTogFR1CY2QyjFXSrTML3f2nS1nLz5msH8uC3jlDjnzXDRJeHqdKdGsqy5f
 BOPNu9Sbb6cv8ZkShCHXRQnBiwdC6M1P8i7mvuq2m6jS5qjNjW9SBPQs3CHP1Sc01bc6
 dxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541038; x=1735145838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gewfvRSg1yvYtJsYr/1dBfhMLGPrisAa5MQCBDTJipY=;
 b=KL4JtmrFOmc+7Cwg3D0ab00+KRBlBGJdkpD+Z3OrDhks9cPipnz5pkCjNpJVHSF7n4
 y99+s9eGaWxBWDJdAmPYvdCZsd1q6/+Af7N7LttlTlySNTojja9QrY7w33Mu94DAtC8d
 8SjrmxQNTFZQoepqDw4NGSDFcvKdjfABEVWyzVYVPwN3kGcI1li3eM0hu8Jd4qkJA/ef
 4As0G3gfF6bzovrIuP66XLqi9bojY2CsS/fNmQi50VhNGmuDh+j0XyJiqsEgYXYBES0U
 /P6azsp0svRGb71MOV2c8w7jldlo9GFI8dICTOI2cjhvVEr0YYhuR9j13fH/sRWac3h5
 eu5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwQuPa+wiWWd1P8cEtNjN0kxMpFiPzAuZ3fgrx9IhREv+/OGTv51eZancWFlVLiKhchOgUL1wnIuEv@nongnu.org
X-Gm-Message-State: AOJu0YyPDa/5c9xlwunzQm/D7XPR+01PphhvWQbYkZ66bmLakw+0ThfW
 1nJHLuaVUiDcr/Y44Q+si61E0glRG5JfCNuip6KQNcQfcYC20Y0EoNt+wI7rkJE=
X-Gm-Gg: ASbGnctOSQsogLdlH4Fn+lsyDshe8shoouYRB6ZIkjvwbDSDxMN+ydjxLR6EUbMnqaK
 98WdNDg7nGP9uEUE9ODXsXVlOjkKOnZ580lu0FixqNCzXyAk/1B4vXXWJk6hFKUmQlpXAzMJ/iz
 XweNwwZOpt9oMT89Krk6QKy3G0YPmDOzDVBpdRwvwDhbbGwYLHzg957S/ZJdaF+QFSFC2Kn4emB
 HpgJZfUt0ihyxrobjXY2tYbNq4ofV1nIkGlJTpDXDjwSpD+OeZd+Sh4zYeShcIoUYTm95DitW0=
X-Google-Smtp-Source: AGHT+IGBbd0d5hy5BHIVuxtD+h0XwgAA0H3Y1bQrHt17Vyho8mREAWaZcNAjZWbgwzmySPcGE2a7dQ==
X-Received: by 2002:a05:6512:3e0a:b0:540:2a92:7dae with SMTP id
 2adb3069b0e04-54220fd2c9emr81623e87.9.1734541037631; 
 Wed, 18 Dec 2024 08:57:17 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c1fd94sm1534173e87.245.2024.12.18.08.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:57:17 -0800 (PST)
Message-ID: <3453e6f7-3777-41e8-b98c-73ec983adbf3@linaro.org>
Date: Wed, 18 Dec 2024 10:57:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] contrib/plugins/stoptrigger: fix 32-bit build
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, philmd@linaro.org, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
 <20241217224306.2900490-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217224306.2900490-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
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

On 12/17/24 16:43, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/stoptrigger.c | 48 ++++++++++++++++++++---------------
>   1 file changed, 27 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
> index 03ee22f4c6a..b3a6ed66a7b 100644
> --- a/contrib/plugins/stoptrigger.c
> +++ b/contrib/plugins/stoptrigger.c
> @@ -21,9 +21,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>   /* Scoreboard to track executed instructions count */
>   typedef struct {
>       uint64_t insn_count;
> +    uint64_t current_pc;
>   } InstructionsCount;
>   static struct qemu_plugin_scoreboard *insn_count_sb;
>   static qemu_plugin_u64 insn_count;
> +static qemu_plugin_u64 current_pc;
>   
>   static uint64_t icount;
>   static int icount_exit_code;
> @@ -34,6 +36,11 @@ static bool exit_on_address;
>   /* Map trigger addresses to exit code */
>   static GHashTable *addrs_ht;
>   
> +typedef struct {
> +    uint64_t exit_addr;
> +    int exit_code;
> +} ExitInfo;
> +
>   static void exit_emulation(int return_code, char *message)
>   {
>       qemu_plugin_outs(message);
> @@ -43,23 +50,18 @@ static void exit_emulation(int return_code, char *message)
>   
>   static void exit_icount_reached(unsigned int cpu_index, void *udata)
>   {
> -    uint64_t insn_vaddr = GPOINTER_TO_UINT(udata);
> +    uint64_t insn_vaddr = qemu_plugin_u64_get(current_pc, cpu_index);
>       char *msg = g_strdup_printf("icount reached at 0x%" PRIx64 ", exiting\n",
>                                   insn_vaddr);
> -
>       exit_emulation(icount_exit_code, msg);
>   }
>   
>   static void exit_address_reached(unsigned int cpu_index, void *udata)
>   {
> -    uint64_t insn_vaddr = GPOINTER_TO_UINT(udata);
> -    char *msg = g_strdup_printf("0x%" PRIx64 " reached, exiting\n", insn_vaddr);
> -    int exit_code;
> -
> -    exit_code = GPOINTER_TO_INT(
> -        g_hash_table_lookup(addrs_ht, GUINT_TO_POINTER(insn_vaddr)));
> -
> -    exit_emulation(exit_code, msg);
> +    ExitInfo *ei = udata;
> +    g_assert(ei);
> +    char *msg = g_strdup_printf("0x%" PRIx64 " reached, exiting\n", ei->exit_addr);
> +    exit_emulation(ei->exit_code, msg);
>   }
>   
>   static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> @@ -67,23 +69,25 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>       size_t tb_n = qemu_plugin_tb_n_insns(tb);
>       for (size_t i = 0; i < tb_n; i++) {
>           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> -        gpointer insn_vaddr = GUINT_TO_POINTER(qemu_plugin_insn_vaddr(insn));
> +        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
>   
>           if (exit_on_icount) {
>               /* Increment and check scoreboard for each instruction */
>               qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>                   insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
> +            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +                insn, QEMU_PLUGIN_INLINE_STORE_U64, current_pc, insn_vaddr);
>               qemu_plugin_register_vcpu_insn_exec_cond_cb(
>                   insn, exit_icount_reached, QEMU_PLUGIN_CB_NO_REGS,
> -                QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, insn_vaddr);
> +                QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, NULL);
>           }
>   
>           if (exit_on_address) {
> -            if (g_hash_table_contains(addrs_ht, insn_vaddr)) {
> +            ExitInfo *ei = g_hash_table_lookup(addrs_ht, &insn_vaddr);
> +            if (ei) {
>                   /* Exit triggered by address */
>                   qemu_plugin_register_vcpu_insn_exec_cb(
> -                    insn, exit_address_reached, QEMU_PLUGIN_CB_NO_REGS,
> -                    insn_vaddr);
> +                    insn, exit_address_reached, QEMU_PLUGIN_CB_NO_REGS, ei);
>               }
>           }
>       }
> @@ -99,11 +103,13 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                              const qemu_info_t *info, int argc,
>                                              char **argv)
>   {
> -    addrs_ht = g_hash_table_new(NULL, g_direct_equal);
> +    addrs_ht = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, g_free);
>   
>       insn_count_sb = qemu_plugin_scoreboard_new(sizeof(InstructionsCount));
>       insn_count = qemu_plugin_scoreboard_u64_in_struct(
>           insn_count_sb, InstructionsCount, insn_count);
> +    current_pc = qemu_plugin_scoreboard_u64_in_struct(
> +        insn_count_sb, InstructionsCount, current_pc);
>   
>       for (int i = 0; i < argc; i++) {
>           char *opt = argv[i];
> @@ -124,13 +130,13 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>               exit_on_icount = true;
>           } else if (g_strcmp0(tokens[0], "addr") == 0) {
>               g_auto(GStrv) addr_tokens = g_strsplit(tokens[1], ":", 2);
> -            uint64_t exit_addr = g_ascii_strtoull(addr_tokens[0], NULL, 0);
> -            int exit_code = 0;
> +            ExitInfo *ei = g_malloc(sizeof(ExitInfo));
> +            ei->exit_addr = g_ascii_strtoull(addr_tokens[0], NULL, 0);
> +            ei->exit_code = 0;
>               if (addr_tokens[1]) {
> -                exit_code = g_ascii_strtoull(addr_tokens[1], NULL, 0);
> +                ei->exit_code = g_ascii_strtoull(addr_tokens[1], NULL, 0);
>               }
> -            g_hash_table_insert(addrs_ht, GUINT_TO_POINTER(exit_addr),
> -                                GINT_TO_POINTER(exit_code));
> +            g_hash_table_insert(addrs_ht, &ei->exit_addr, ei);
>               exit_on_address = true;
>           } else {
>               fprintf(stderr, "option parsing failed: %s\n", opt);


