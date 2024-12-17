Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DF2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZcG-0004vi-Ls; Tue, 17 Dec 2024 10:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZcE-0004vL-ST
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:36:06 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZcD-0006nf-7c
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:36:06 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71e35be77b5so1123196a34.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734449763; x=1735054563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7c07SxCbLApQqC2G/VYOfBV2d6FYtOGQLVAbsyP06HY=;
 b=B65ZWJ1BWR+k/dOhI1nhpCCO9VLtU71LhksyFWA+l80EdXDRTBZzJPKKhpGNqIy3qk
 6TrBMZWJlt/QzgfnnD2jSIxdK541DJoge2F390y/kxirvnArq0oG3uEXNbPqcLUod+x7
 C6+xScdkqb51FLhXKHwL8MJwXDS+JRyvYdWlc9MDvP/VIgnpmE0FSv8GADKIW3RqAJd9
 hjHmo2XZ7L1AUauGfuFqXrtYkj0j5mXKL3fDH3kzArkdBGsQocV3CoJwkiTQis5acRDs
 fM1aQv3xsFW3LDtQumuLNbhnj/LT+kg4Gg6pfywpBQU4LsdgBhiBHsv6JpilVTzuBxZR
 fC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734449763; x=1735054563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7c07SxCbLApQqC2G/VYOfBV2d6FYtOGQLVAbsyP06HY=;
 b=Slj5sIZg3wJFRdWHEWrLTMp7g/NexiuUd5xnIvWTO/2B5TQlECFOxWByLgtT/QdVZe
 BFIeMp29H09X5UIijKhwTdLNc0acZfH8V0Pzhkjd075mG3C9q7CQfGT6Gzks06QoCqfd
 n0K7cCRGYqVfsHJTPahcPBbh/CFPMhYuOkoYqZHquTGJPv4yup+iwFvUq8WpFQ+rflmv
 40Q3rcYeoNFKKox2xN2mWQprhKDqxHpH64W3VafU4PMFXWTi3f/SJnFheZc2XwJDAQWu
 TNx9fh3uOzy+QuAGarLHulSFo0oFbjUTpMjUzWPnxl/Ec1i/mI/wGapKpxrB8IMSAZMX
 9D2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkTr/SxlCkFaod10DS64b2e+3ums8QDUwoNzuauEjT8tesIAWZyW8TUaBpE9lBkE5irKxXGOq0yTnp@nongnu.org
X-Gm-Message-State: AOJu0YxNPBnZd4E4wOh+ji5mBoSdSNPsF04MGS/LkZuFlaKb/5z/9qLf
 U3B2Am7euMzCgylzP/P1RLUec9JAv0AxyKd3EtE4MhMP4gC+1EDADIssiyUQsqU=
X-Gm-Gg: ASbGnctvb4EpKTULyRs8inS/QROxLHCi4/+239i6Z/1Q4kqU1IdJ/0ekG09XunwQkqU
 Y2zHq27vkG84SmYO7B2zI1yZ7xpojvY49wgJBCzMqrfos3tmO6yF4L5YYLscIklJDBodBKGXhif
 3KoLApSEhkzzLSJDb67jToQabDflYf6l5/iFcqjsgMmv2XrNDADurL22P1uslWSj9XxH5ujhklg
 +tNxA3CuiTbyERx+WLedmvHct3l04cNrTGUZbou60CeVP5WRg6RzXsCGCO4vEKHRXZ/F1UtSg==
X-Google-Smtp-Source: AGHT+IG83LLhrzb0b12TqT/1UO1RIYDjSBjTM3GCYwtTi2wsRkrxv36XqIlVNCo20LLK9pueeXcLAA==
X-Received: by 2002:a9d:3e51:0:b0:71e:57b5:224a with SMTP id
 46e09a7af769-71e57b523b8mr5402665a34.11.1734449763566; 
 Tue, 17 Dec 2024 07:36:03 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm2033978a34.34.2024.12.17.07.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 07:36:03 -0800 (PST)
Message-ID: <fd608bb6-b0c1-4232-ac80-3fec3fb41c3b@linaro.org>
Date: Tue, 17 Dec 2024 09:35:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] contrib/plugins/cflow: fix 32-bit build
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-11-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217010707.2557258-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
>   contrib/plugins/cflow.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
> index b39974d1cf3..930ecb46fcd 100644
> --- a/contrib/plugins/cflow.c
> +++ b/contrib/plugins/cflow.c
> @@ -76,6 +76,8 @@ typedef struct {
>   
>   /* We use this to track the current execution state */
>   typedef struct {
> +    /* address of current translated block */
> +    uint64_t tb_pc;
>       /* address of end of block */
>       uint64_t end_block;
>       /* next pc after end of block */
> @@ -85,6 +87,7 @@ typedef struct {
>   } VCPUScoreBoard;
>   
>   /* descriptors for accessing the above scoreboard */
> +static qemu_plugin_u64 tb_pc;
>   static qemu_plugin_u64 end_block;
>   static qemu_plugin_u64 pc_after_block;
>   static qemu_plugin_u64 last_pc;
> @@ -189,10 +192,11 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>   static void plugin_init(void)
>   {
>       g_mutex_init(&node_lock);
> -    nodes = g_hash_table_new(NULL, g_direct_equal);
> +    nodes = g_hash_table_new(g_int64_hash, g_int64_equal);
>       state = qemu_plugin_scoreboard_new(sizeof(VCPUScoreBoard));
>   
>       /* score board declarations */
> +    tb_pc = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, tb_pc);
>       end_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard,
>                                                        end_block);
>       pc_after_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard,
> @@ -215,10 +219,10 @@ static NodeData *fetch_node(uint64_t addr, bool create_if_not_found)
>       NodeData *node = NULL;
>   
>       g_mutex_lock(&node_lock);
> -    node = (NodeData *) g_hash_table_lookup(nodes, (gconstpointer) addr);
> +    node = (NodeData *) g_hash_table_lookup(nodes, &addr);
>       if (!node && create_if_not_found) {
>           node = create_node(addr);
> -        g_hash_table_insert(nodes, (gpointer) addr, (gpointer) node);
> +        g_hash_table_insert(nodes, &node->addr, node);
>       }
>       g_mutex_unlock(&node_lock);
>       return node;
> @@ -234,7 +238,7 @@ static void vcpu_tb_branched_exec(unsigned int cpu_index, void *udata)
>       uint64_t lpc = qemu_plugin_u64_get(last_pc, cpu_index);
>       uint64_t ebpc = qemu_plugin_u64_get(end_block, cpu_index);
>       uint64_t npc = qemu_plugin_u64_get(pc_after_block, cpu_index);
> -    uint64_t pc = GPOINTER_TO_UINT(udata);
> +    uint64_t pc = qemu_plugin_u64_get(tb_pc, cpu_index);
>   
>       /* return early for address 0 */
>       if (!lpc) {
> @@ -305,10 +309,11 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>        * handle both early block exits and normal branches in the
>        * callback if we hit it.
>        */
> -    gpointer udata = GUINT_TO_POINTER(pc);
> +    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
> +        tb, QEMU_PLUGIN_INLINE_STORE_U64, tb_pc, pc);
>       qemu_plugin_register_vcpu_tb_exec_cond_cb(
>           tb, vcpu_tb_branched_exec, QEMU_PLUGIN_CB_NO_REGS,
> -        QEMU_PLUGIN_COND_NE, pc_after_block, pc, udata);
> +        QEMU_PLUGIN_COND_NE, pc_after_block, pc, NULL);
>   
>       /*
>        * Now we can set start/end for this block so the next block can


