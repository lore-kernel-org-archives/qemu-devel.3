Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC855E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM7L-0007ul-Jh; Mon, 16 Dec 2024 20:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM7J-0007u0-6A
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:11:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM7H-0005Mr-6Q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:11:16 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-216728b1836so33639425ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397872; x=1735002672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T38toxWe2zyFDZkjKBpC+q/USaVHR4L5qR4fAw95AOU=;
 b=y2xbqSly65rR718OFukyNmP31Oh67O6nA4Y1fBq5dvE8lKdNBkJ580hi39zlP2jPxk
 GLCaO+X+p3gZy3uoFJ89xmtHcpcZeVdWqQhFwBlZ286XMHNGUv03DLSFg2ZZ08DOaZAf
 uGDhyfwwnF1lpy2dDmxcUzfzk+Pny7/9Bf/1cn8UDwHtl7bhBvX717ELCk8ji4fxPyCx
 uTWKG8nfRhKMky1EdQTrluM2unCsVAxQVzSsmAyGFbE3HbEIK0hxESdxdUdJ6qROvvHf
 0QzCCt93BCTvTmC99TuzQCIuOVb8VOGRbO2Y9mUYth28uaovCz+l/VfouXhhOI1k6X5C
 HfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397872; x=1735002672;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T38toxWe2zyFDZkjKBpC+q/USaVHR4L5qR4fAw95AOU=;
 b=ai+3jY29qJgmv1tAjmQvWSgmKwRRMcPrjOTpHX5H3gLVLHjOHoKuLf+zoYboaD3Pf2
 TaWiYqRL/zsXmaIhldqJ+4raMNWaO7h2mi9VqMRe393d5+XZn9h0tlMCRmGBDJfXzV/w
 b6aanbtlu2wDQ4kvFumqE3/UBR/0NlDNyq0Dd4C0+VC00FxUMGHnUEX6Lydf8cBEp7UV
 Y6HfUXGsubxsXkaQXPvKy7VeUGk0t8lOZJPixBKzU5JbRwCPdlRYNHlpduQRB2DV2GUB
 QToHzkmJZ/DC2R/KtSmOfi465Ly7maePKL5KVdNQg7DcCO8poOjg00xi+6aFZ9Iroz+N
 +lng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/AjkRIj3SdYv5981NcHjg2jSIcRNZ7IPmRs9qXR9t5fz2DD98sClLMEBPOdQdxjYZWKIAVFI8Jf6D@nongnu.org
X-Gm-Message-State: AOJu0Yy1B8MG1oLzqlJ6zzqmJASdiM2JkvTw4tMcFaU9ICnFGGgxeTas
 ddo30QIdw5Mr1e+pOF/IS55SXqWFc8HriwuFssvbNd2k+bg93q7v9JodIK6UsfLnEyBgIU5KZgN
 icco=
X-Gm-Gg: ASbGncuqQ/4GTPuvc0r50mcgod0pUGpmosNqtdNM+VSl1hmv5y39RHHsK+XfasdfH/P
 INjJ0w8a/6+eQfKyUHE+Q+cBgcVFCdT25ffkCfImvFd0r7/PZpmf6orqIlDnGnRBYVC/5vnXKr8
 6BpDC983DOCIXse5DUtpvHuYT/SuoFY1PHkEMUnAKSXJxzTFKR5IxGc84pBVLvJ87/cuAIyW3UO
 TaLEKW2WRjz+hYTbS0yZdi/02lawpydQy2Tr465Il19JpLhYZuY5JlL4aZfDVCyDKRoD1+OjsDI
 aJEFQH2YuOk7sMGSAL5aze736FkF
X-Google-Smtp-Source: AGHT+IEZq/aoanLn5yxoqPKLkfG767twUD87iwKdNd4dIvCOgSbPD3Lwkf8q1Lo+I0su/yfnNeuR9w==
X-Received: by 2002:a17:902:fc87:b0:216:4972:f8e0 with SMTP id
 d9443c01a7336-21892a5af3dmr238966735ad.44.1734397872290; 
 Mon, 16 Dec 2024 17:11:12 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e63896sm48651465ad.223.2024.12.16.17.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 17:11:11 -0800 (PST)
Message-ID: <0fc01e08-8f4c-47f7-bbb9-c7c78346ba3d@linaro.org>
Date: Mon, 16 Dec 2024 17:11:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: contrib/plugins does not build on 32-bit host
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <dbb6dbf1-1ceb-48c0-8174-ee5dea7533dc@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <dbb6dbf1-1ceb-48c0-8174-ee5dea7533dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 12/13/24 13:47, Richard Henderson wrote:
> Hi,
> 
> Several of the recent contrib/plugins/ patches do not build on e.g. arm32.
> All of the issues are related to casting between pointers and uint64_t; there is a Werror
> generated for casting between pointers and integers of different sizes.
> 
> I suspect all of the instances will need to use separate structures to store uint64_t
> within the hash tables.  The hash values themselves can use uintptr_t, as "hash" by
> definition loses data.
> 
> The following is *not* a suggested patch, just touches every place with an error to
> highlight all of the places.
> 
> 
> r~
> 
> 
> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
> index 512ef6776b..9f1b05fc35 100644
> --- a/contrib/plugins/cache.c
> +++ b/contrib/plugins/cache.c
> @@ -474,7 +474,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>            uint64_t effective_addr;
> 
>            if (sys) {
> -            effective_addr = (uint64_t) qemu_plugin_insn_haddr(insn);
> +            effective_addr = (uint64_t)(uintptr_t) qemu_plugin_insn_haddr(insn);
>            } else {
>                effective_addr = (uint64_t) qemu_plugin_insn_vaddr(insn);
>            }
> diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
> index b39974d1cf..8f8ebf87cd 100644
> --- a/contrib/plugins/cflow.c
> +++ b/contrib/plugins/cflow.c
> @@ -215,10 +215,10 @@ static NodeData *fetch_node(uint64_t addr, bool create_if_not_found)
>        NodeData *node = NULL;
> 
>        g_mutex_lock(&node_lock);
> -    node = (NodeData *) g_hash_table_lookup(nodes, (gconstpointer) addr);
> +    node = (NodeData *) g_hash_table_lookup(nodes, (gconstpointer)(uintptr_t) addr);
>        if (!node && create_if_not_found) {
>            node = create_node(addr);
> -        g_hash_table_insert(nodes, (gpointer) addr, (gpointer) node);
> +        g_hash_table_insert(nodes, (gpointer)(uintptr_t) addr, (gpointer) node);
>        }
>        g_mutex_unlock(&node_lock);
>        return node;
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 02bc5078bd..9b3d356dea 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -111,7 +111,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>        ExecCount *cnt;
>        uint64_t pc = qemu_plugin_tb_vaddr(tb);
>        size_t insns = qemu_plugin_tb_n_insns(tb);
> -    uint64_t hash = pc ^ insns;
> +    uintptr_t hash = pc ^ insns;
> 
>        g_mutex_lock(&lock);
>        cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
> diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
> index 739ac0c66b..6d84ea77f2 100644
> --- a/contrib/plugins/hwprofile.c
> +++ b/contrib/plugins/hwprofile.c
> @@ -169,7 +169,7 @@ static IOLocationCounts *new_location(GHashTable *table, uint64_t
> off_or_pc)
>    {
>        IOLocationCounts *loc = g_new0(IOLocationCounts, 1);
>        loc->off_or_pc = off_or_pc;
> -    g_hash_table_insert(table, (gpointer) off_or_pc, loc);
> +    g_hash_table_insert(table, (gpointer)(uintptr_t) off_or_pc, loc);
>        return loc;
>    }
> 
> @@ -201,7 +201,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t
> meminfo,
>            return;
>        } else {
>            const char *name = qemu_plugin_hwaddr_device_name(hwaddr);
> -        uint64_t off = qemu_plugin_hwaddr_phys_addr(hwaddr);
> +        uintptr_t off = qemu_plugin_hwaddr_phys_addr(hwaddr);
>            bool is_write = qemu_plugin_mem_is_store(meminfo);
>            DeviceCounts *counts;
> 
> @@ -224,7 +224,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t
> meminfo,
> 
>            /* either track offsets or source of access */
>            if (source) {
> -            off = (uint64_t) udata;
> +            off = (uintptr_t) udata;
>            }
> 
>            if (pattern || source) {
> @@ -247,7 +247,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> 
>        for (i = 0; i < n; i++) {
>            struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> -        gpointer udata = (gpointer) (source ? qemu_plugin_insn_vaddr(insn) : 0);
> +        gpointer udata = (gpointer)(uintptr_t) (source ? qemu_plugin_insn_vaddr(insn) : 0);
>            qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
>                                             QEMU_PLUGIN_CB_NO_REGS,
>                                             rw, udata);
> 

The series fixing this was sent:
https://lore.kernel.org/qemu-devel/20241217010707.2557258-1-pierrick.bouvier@linaro.org/T/#t

Pierrick

