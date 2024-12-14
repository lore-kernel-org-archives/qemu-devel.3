Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A89DE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 03:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMJ5R-0007Lo-GU; Fri, 13 Dec 2024 22:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tMJ5P-0007Le-Sk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 22:44:59 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tMJ5N-0006V5-Or
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 22:44:59 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ef28f07dbaso1668039a91.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 19:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734147894; x=1734752694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y25GbSlcda+N8rqP7pwO3LNxhy+C5I1ik7XFPVz/aD8=;
 b=fmGTTeHNTO6rESUHz6EpITGzDFsKoHx7fDD5ORrE+jMKXUrWW+fVpj+km/BGvi286Y
 hdnSs6SxrtEq6AUUqbAvyfYrNOwSJNYOjs8vWFOMBLRudpzllVN/FfEucV7ysg4qvIYb
 EEjQwaccFP8S1qXJukkG1gg0tSsosAF0kRCtdgQGkWVBVddlnHAnXjrSh3YNSt+qRPMg
 KmOjqb5uDQsatZdwEDSzHoCa7LyVWCdpuEVI8RaK8+M29CB+nl1pUxkrKFPpl5KjYuga
 HQLInUFRmG58novd/73n/0n958cEwMsL0rs/svtXOMqYcaeqAEtd72FxyHNQAubm+DQy
 zFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734147894; x=1734752694;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y25GbSlcda+N8rqP7pwO3LNxhy+C5I1ik7XFPVz/aD8=;
 b=DXUY7fzWJAwV58HmumEnhg8Pa6MK3C4SJg5vMS7WnxtbF+dVIcYfvyWVld6csLK13O
 y/nJdUQZDa2rV+5rdHGhxP7fZcR4UjQv+vrBkQGW+RPoF+L7jbHVwwn1Fyo5cTaaQ/mm
 S39VmUm46CKOYgxBzkBuMCdqZYZQ3gBoDkpappoGZmwSVdKB0Z7YfQB4SfkttGLY43Rb
 upWokSfo+VS14WDbXLRPWhGJlgkJCFVmOZjMKZZnxVVlrpoNCq/gLkzsxWMPOrBROgvK
 mRTwVdibodEbfR7e9jUWIfyqKZVrVJRhHIiZB3i0brgpxH2x/0/ya5SA9EC4+xQ4st0v
 CArQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVemaYZUwNfbzhQO0lNCURUcsl9S6wxXcx7s9r3OzVocX6Tib/haVozgyozPM02phUvaat8T3vAxAg2@nongnu.org
X-Gm-Message-State: AOJu0YyHoMlEB0dRwiKkhoe0FnqomZKiHZge1rvztKdCTbUKvjU0GmLf
 Kg3T6bgYbzTIN2jERRbV17zjeNDsGvxX9PIW0urbx+ITS3Ajmgp6Faf32M4wCxs=
X-Gm-Gg: ASbGnctTJYdWIAt0RZZEFjWmb3sSMAP1thmazzlbla4u9W3amRUaCWpejVkSPGdmEaB
 UxtYtz6Nf1XDYvVQzFAuehJC5pA0RtlS94R50tR4JVkHT+KB4BBoE6VhP6ptLGpM5MfnUhLKuml
 K1U3tO1g6gIcArJdEhIOAIOkHUpIj/hj9G+XXBYQQTQa3TSaDGfLVAeeaRTnFSjfqR6rtKdeOFt
 FU0DoMMcjveRsJ+pIUuzylFB5pbILeMcARVd02dKntEAoLvGNB6WRLesHULeZU6M9/R7gHT9NY7
 aUfpK+BpXWWp+DHvCYSrbsKhV9qj
X-Google-Smtp-Source: AGHT+IH3vRaXpNjOPPT+wB0SZwUFcOWR/r6ekG18V3VbNmFvQdnxmrHN73nev/0rtevQDm6+KD+9Ag==
X-Received: by 2002:a17:90b:3803:b0:2ee:8358:385 with SMTP id
 98e67ed59e1d1-2f28fa5476amr7473176a91.4.1734147894349; 
 Fri, 13 Dec 2024 19:44:54 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2a2434a4asm620662a91.32.2024.12.13.19.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 19:44:52 -0800 (PST)
Message-ID: <718f3f80-eb3b-4d9b-b2a0-24946a8c5b79@linaro.org>
Date: Fri, 13 Dec 2024 19:44:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: contrib/plugins does not build on 32-bit host
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <dbb6dbf1-1ceb-48c0-8174-ee5dea7533dc@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <dbb6dbf1-1ceb-48c0-8174-ee5dea7533dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

Hi Richard,

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

This is something I already tried to fix this way, but alas, casting 
values is not enough, we might lose information (in the case where guest 
is 64 bits). Some plugins need a refactoring to allocate data 
dynamically, instead of hiding it under a pointer.

See this previous series:
https://patchew.org/QEMU/20240814233645.944327-1-pierrick.bouvier@linaro.org/

Finally, we discussed it was not worth the effort, and Alex simply 
deactivated plugins by default for 32 bits platform, so it should not be 
built for arm 32 bits. If we really have someone that needs this 
usecase, we might make the effort, but for now, it does not seem worth 
the hassle.

Note: we already had those warnings before, but since plugins used to be 
built by an external Makefile, werror was not enabled, so functionally 
it was already "broken".

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


