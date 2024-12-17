Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3AAE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZdO-0005Vw-Qy; Tue, 17 Dec 2024 10:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZdM-0005Vf-Rx
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:37:16 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZdK-00073F-5n
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:37:16 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-71e16519031so2756063a34.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734449832; x=1735054632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YPrQ0r2/xWowohm2IMiBnuTWjC7ZSc3tti5cr8GkCr8=;
 b=dRzib3p/XDHcETCOcapWmFZFML6o7W11BPdHnLDpG6EW5B3e1NPFb1Q9Q9ZaeTRBp+
 YCOumABOm4XjZybNBEj5pm2YMEJ69R51SXITyZEg9cN6mqPrIb2ulkImY1IW9FafOxQH
 tkX2DthcaEAnmDtGcMNHbRoIX8WOtSNt+jBFGYhHhksY7P4irzVL8bdYnQ1NGudb5BGt
 LDLsf4OizB66tx6X1/VJCH/3suNoySTfYN40m3YgwERq4DoCYlBtL3jz8c1wXP/M9Nak
 Gt0WmON1xeUQilFfQL8DWrVJjcCkTBCFG8hSiTMRFGuhZh/HxhMQD7tBgXB0+EPiU74W
 hpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734449832; x=1735054632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPrQ0r2/xWowohm2IMiBnuTWjC7ZSc3tti5cr8GkCr8=;
 b=ngXm4lc/ZAmbOmyk1pfY6hOeEso5m70rB4WL7gsxPn4efWaygK0+83zf+dKDKJV4O8
 SVoYZFz2OkE0nMCOQvuWXi+ZckocLOV9JGMIXhGn2wTLIESVPdAxBHUlEu6UxHllKFPN
 V5urazQsz0499pNqdk1x3iCYBenQEfrth9wuhNOFr2oRierQ5YMblYph8uFO4D13gui8
 nyewmE+x/3jD0D9uEyvkaYI0cZHNtd5Dm9JivhpZTaBF7HnD7XUWN2Lb97+nrJJRxkfR
 Qo9NCDfz6yfqUY9Zb3jZTpJRZRPgUmu0s3BmAkypV/cuG7hlGzQ9R0RsndaWR92Wv9Mh
 OeOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1oFfzaRthQe2187t3KBQ5Sx5CBBueefv1r7naLPyjgfCDccU7YLR3YnX8RGR1X2n1SZdeDuCVjBFO@nongnu.org
X-Gm-Message-State: AOJu0Yxa5+BWIxpYwfyvlthjKl6uoALAfAkAR3ULq5nxmqnyN6ldCDWy
 Iq8H64pCNGgbEb8Qvf63RLUxqqtXJTSLAGHM85u/QKl2QxnZMthL6q1WcwRqh9M=
X-Gm-Gg: ASbGnctbN5gTvgeWA76C08ibrKUzfL1u0aFJh0YXkY1bydVyaFQYQYXCESfPU4dYe7a
 dWqm9kcIkTnP7Anad4+YX04LCpJZF7QURKySvIeSULLur9qLdOQqDQK7XLrzoIKAppXkmhuXhxJ
 fXMuXFBPorbsFMi9XGjXEop7l/SNu1kRr1ed6k7axN3BdORv3FSeEhhlplzt37hkXdFwvt94pj8
 Ya6HdYNzNHdSrQFOHHkWQ4QxP/ch6wlMsJSnWtlhrsLp7NhZjG41Ah4BxCsVJloitfCP3hSAQ==
X-Google-Smtp-Source: AGHT+IFG+7LKbzH28KPPbcGkpXv36wDs1pKsbH4Cc1AiewxYR3njeHdvp/RHDsvfzqX/ZuXt2JojRQ==
X-Received: by 2002:a05:6830:398c:b0:71e:15f7:1a3a with SMTP id
 46e09a7af769-71f489ee75amr2469995a34.2.1734449831875; 
 Tue, 17 Dec 2024 07:37:11 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e483543absm2135472a34.23.2024.12.17.07.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 07:37:11 -0800 (PST)
Message-ID: <d50ae0d8-f180-485b-8bfb-cdcf572fc45b@linaro.org>
Date: Tue, 17 Dec 2024 09:37:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] contrib/plugins/hwprofile: fix 32-bit build
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-12-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217010707.2557258-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 12/16/24 19:07, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/hwprofile.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
> index 739ac0c66b5..2a4cbc47d40 100644
> --- a/contrib/plugins/hwprofile.c
> +++ b/contrib/plugins/hwprofile.c
> @@ -43,6 +43,8 @@ typedef struct {
>   
>   static GMutex lock;
>   static GHashTable *devices;
> +static struct qemu_plugin_scoreboard *source_pc_scoreboard;
> +static qemu_plugin_u64 source_pc;
>   
>   /* track the access pattern to a piece of HW */
>   static bool pattern;
> @@ -159,7 +161,7 @@ static DeviceCounts *new_count(const char *name, uint64_t base)
>       count->name = name;
>       count->base = base;
>       if (pattern || source) {
> -        count->detail = g_hash_table_new(NULL, NULL);
> +        count->detail = g_hash_table_new(g_int64_hash, g_int64_equal);
>       }
>       g_hash_table_insert(devices, (gpointer) name, count);
>       return count;
> @@ -169,7 +171,7 @@ static IOLocationCounts *new_location(GHashTable *table, uint64_t off_or_pc)
>   {
>       IOLocationCounts *loc = g_new0(IOLocationCounts, 1);
>       loc->off_or_pc = off_or_pc;
> -    g_hash_table_insert(table, (gpointer) off_or_pc, loc);
> +    g_hash_table_insert(table, &loc->off_or_pc, loc);
>       return loc;
>   }
>   
> @@ -224,12 +226,12 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>   
>           /* either track offsets or source of access */
>           if (source) {
> -            off = (uint64_t) udata;
> +            off = qemu_plugin_u64_get(source_pc, cpu_index);
>           }
>   
>           if (pattern || source) {
>               IOLocationCounts *io_count = g_hash_table_lookup(counts->detail,
> -                                                             (gpointer) off);
> +                                                             &off);
>               if (!io_count) {
>                   io_count = new_location(counts->detail, off);
>               }
> @@ -247,10 +249,14 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>   
>       for (i = 0; i < n; i++) {
>           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> -        gpointer udata = (gpointer) (source ? qemu_plugin_insn_vaddr(insn) : 0);
> +        if (source) {
> +            uint64_t pc = qemu_plugin_insn_vaddr(insn);
> +            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
> +                    insn, rw, QEMU_PLUGIN_INLINE_STORE_U64,
> +                    source_pc, pc);
> +        }
>           qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
> -                                         QEMU_PLUGIN_CB_NO_REGS,
> -                                         rw, udata);
> +                                         QEMU_PLUGIN_CB_NO_REGS, rw, NULL);
>       }
>   }
>   
> @@ -306,10 +312,9 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>           return -1;
>       }
>   
> -    /* Just warn about overflow */
> -    if (info->system.smp_vcpus > 64 ||
> -        info->system.max_vcpus > 64) {
> -        fprintf(stderr, "hwprofile: can only track up to 64 CPUs\n");
> +    if (source) {
> +        source_pc_scoreboard = qemu_plugin_scoreboard_new(sizeof(uint64_t));
> +        source_pc = qemu_plugin_scoreboard_u64(source_pc_scoreboard);
>       }
>   
>       plugin_init();


