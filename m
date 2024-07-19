Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B268EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 10:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUkWU-0005Qj-2j; Fri, 19 Jul 2024 06:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUkWS-0005Pk-Ad
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 06:07:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUkWP-0007NK-Un
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 06:07:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266b1f1b21so11882205e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721383648; x=1721988448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IFOLi8NXOCMWyDvg1hIo0JGInqxwDebjjy5EYeDkZmw=;
 b=hngnIeNuOsOIsvJZZUMr+5o7ApuBw1pJUJ3f5oThFrvTNu6+sDQXis9RslExHYP1g2
 9Dwrqz9Tp2zzBmnW6CeRFo7mNkFILPFd3sOAxuRXd6AkkvWauJxwGnbKAkpisv+cpVGr
 jLOMfvcNQaOisAly+rGDOZtpmKnyV3H1Ms7SFFAevr779TTOd9wnxLLwISILvtnoVTbQ
 Jrjz7KlU0mYRaR78JsmgoDv0EJexHJTc2SN2tqs9VyOazdKP9PA2dZgNEVnvY+KwK3TU
 ArnB3oz3STaFH0POKRhDleZ5FOOTFX33p+0S4aBDUYU1cI9Qs/FXXluwiuAP7DYl0X/C
 O0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721383648; x=1721988448;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFOLi8NXOCMWyDvg1hIo0JGInqxwDebjjy5EYeDkZmw=;
 b=GUg3Rm/wSIaljDSNRCOpF32PzIhq5H9xV2+z4QMy8I49KS0ml4jWOskSwisO26cqzl
 arPB7+uapgyRXMM8J0a39+ab1WwQxXZ9nu5f8FLk4RJxdNqAaz26fuVrhliHenj77sg/
 qFp4o8Vr6lNFpFQI7xm5Mb29ILJhpZ0YO/R8H2WLe0DBfIZQiutvN5gSe8TZWFBw+mzK
 wmOqYwBeRWg4Wbkt/uY9euSl19jxeDGWCf9Qg6x3xjwZ66919qG/ygQJuRBT99if4sX9
 19HpdFuM0BjE6liL2eup2yb7qMhHmflhoxDavfwLgn5sdKYuwBxFLqdOKBgFU20rK7xI
 zcBw==
X-Gm-Message-State: AOJu0YxY09DbC4v/Cu0JzMpK+iHiGR5LFbMUVabDl33wuS6bARLjnCTA
 dnnWGx8WexN0LGNlEfNCP0eFQjZxmYCztNs73Gtl21SjyPZsmZ5ldCYhmZ4E/Ng=
X-Google-Smtp-Source: AGHT+IEDs5CtbnkSXnF4xCBPfkAQDcsIYfVn0mVu3zduMsoo5RZdyuFwG5ZFHJmn6Xg46QL8+xXDpQ==
X-Received: by 2002:a05:600c:4ec6:b0:427:9dad:8063 with SMTP id
 5b1f17b1804b1-427c2cc3000mr53448875e9.12.1721383647632; 
 Fri, 19 Jul 2024 03:07:27 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68f789csm18907515e9.6.2024.07.19.03.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 03:07:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 256955F880;
 Fri, 19 Jul 2024 11:07:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Gustavo Romero <gustavo.romero@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [RFC PATCH v3] contrib/plugins: control flow plugin
In-Reply-To: <604e16a4-a316-4a18-a9f2-f7c8a77be17c@linaro.org> (Pierrick
 Bouvier's message of "Thu, 18 Jul 2024 10:17:38 -0700")
References: <20240718145958.1315270-1-alex.bennee@linaro.org>
 <604e16a4-a316-4a18-a9f2-f7c8a77be17c@linaro.org>
Date: Fri, 19 Jul 2024 11:07:26 +0100
Message-ID: <87frs5g0f5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 7/18/24 07:59, Alex Benn=C3=A9e wrote:
>> This is a simple control flow tracking plugin that uses the latest
>> inline and conditional operations to detect and track control flow
>> changes. It is currently an exercise at seeing how useful the changes
>> are.
>> Based-on: <20240312075428.244210-1-pierrick.bouvier@linaro.org>
>> Cc: Gustavo Romero <gustavo.romero@linaro.org>
>> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20240311153432.1395190-1-alex.bennee@linaro.org>
<snip>
>> +/*
>> + * Called when we detect a non-linear execution (pc !=3D
>> + * pc_after_block). This could be due to a fault causing some sort of
>> + * exit exception (if last_pc !=3D block_end) or just a taken branch.
>> + */
>> +static void vcpu_tb_branched_exec(unsigned int cpu_index, void *udata)
>> +{
>> +    uint64_t lpc =3D qemu_plugin_u64_get(last_pc, cpu_index);
>> +    uint64_t ebpc =3D qemu_plugin_u64_get(end_block, cpu_index);
>> +    uint64_t npc =3D qemu_plugin_u64_get(pc_after_block, cpu_index);
>> +    uint64_t pc =3D GPOINTER_TO_UINT(udata);
>> +
>> +    /* return early for address 0 */
>> +    if (!lpc) {
>> +        return;
>> +    }
>> +
>> +    NodeData *node =3D fetch_node(lpc, true);
>
> I would suggest a different approach here.
>
> This plugin keeps data as a graph between instructions.
> Another possibility would be to use a *per vcpu* hashtable, which
> simply associates the key (source_addr, dest_addr), to a number of
> hits.
> (uint64, uint64) -> uint64. This is all we really need at exec time,
> the rest can be reconstructed for data gathered at translation time.

Hmm I'm not sure how to deal with 128 bit keys with glib's hash table
implementation. I think the gpointer can be an opaque pointer though
with GEqualFunc to compare - but adding multiple records to a hash table
seems wrong.

> This way, you can do all the work in vcpu_tb_branched_exec without
> needing a single lock. (here, we lock twice, once globally to fetch
> all the nodes, and once for the node itself).
>
> Then, at exit, you can merge hashtables from all vcpu, and do the work
> to rebuild the full graph from all transitions collected.

Well a lot of transitions are just continuations (although maybe not I
guess I need to check that hunch).

> As a bonus, you can get the true list of hottest branches, when now,
> it's the hottest insn only you have.

I'm not sure I follow. Are you saying there are control flow changes I
don't detect? The fall-through cases?

> The Node structure would simply becomes Insn, as you want to keep the
> pc, symbols and disassembly of every instruction.
> And you need to keep track of all tb too, with length and pointing to
> the list of instructions.

What would I do with the TB information that I couldn't encode in Insn
at translation time?

>
> It's a different paradigm from what is doing here, but I think it
> would scale much better, especially with multithreaded programs.
>
>> +    DestData *data =3D NULL;
>> +    bool early_exit =3D (lpc !=3D ebpc);
>> +    GArray *dests;
>> +
>> +    /* the condition should never hit */
>> +    g_assert(pc !=3D npc);
>> +
>> +    g_mutex_lock(&node->lock);
>> +
>> +    if (early_exit) {
>> +        fprintf(stderr, "%s: pc=3D%"PRIx64", epbc=3D%"PRIx64
>> +                " npc=3D%"PRIx64", lpc=3D%"PRIx64", \n",
>> +                __func__, pc, ebpc, npc, lpc);
>> +        node->early_exit++;
>> +        if (!node->mid_count) {
>> +            /* count now as we've only just allocated */
>> +            node->mid_count++;
>> +        }
>> +    }
>> +
>> +    dests =3D node->dests;
>> +    for (int i =3D 0; i < dests->len; i++) {
>> +        if (g_array_index(dests, DestData, i).daddr =3D=3D pc) {
>> +            data =3D &g_array_index(dests, DestData, i);
>> +        }
>> +    }
>> +
>> +    /* we've never seen this before, allocate a new entry */
>> +    if (!data) {
>> +        DestData new_entry =3D { .daddr =3D pc };
>> +        g_array_append_val(dests, new_entry);
>> +        data =3D &g_array_index(dests, DestData, dests->len - 1);
>> +        g_assert(data->daddr =3D=3D pc);
>> +    }
>> +
>> +    data->dcount++;
>> +    node->dest_count++;
>> +
>> +    g_mutex_unlock(&node->lock);
>> +}
>> +
>> +/*
>> + * At the start of each block we need to resolve two things:
>> + *
>> + *  - is last_pc =3D=3D block_end, if not we had an early exit
>> + *  - is start of block last_pc + insn width, if not we jumped
>> + *
>> + * Once those are dealt with we can instrument the rest of the
>> + * instructions for their execution.
>> + *
>> + */
>> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *t=
b)
>> +{
>> +    uint64_t pc =3D qemu_plugin_tb_vaddr(tb);
>> +    size_t insns =3D qemu_plugin_tb_n_insns(tb);
>> +    struct qemu_plugin_insn *first_insn =3D qemu_plugin_tb_get_insn(tb,=
 0);
>> +    struct qemu_plugin_insn *last_insn =3D qemu_plugin_tb_get_insn(tb, =
insns - 1);
>> +
>> +    /*
>> +     * check if we are executing linearly after the last block. We can
>> +     * handle both early block exits and normal branches in the
>> +     * callback if we hit it.
>> +     */
>> +    gpointer udata =3D GUINT_TO_POINTER(pc);
>> +    qemu_plugin_register_vcpu_tb_exec_cond_cb(
>> +        tb, vcpu_tb_branched_exec, QEMU_PLUGIN_CB_NO_REGS,
>> +        QEMU_PLUGIN_COND_NE, pc_after_block, pc, udata);
>> +
>> +    /*
>> +     * Now we can set start/end for this block so the next block can
>> +     * check where we are at. Do this on the first instruction and not
>> +     * the TB so we don't get mixed up with above.
>> +     */
>> +    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
>> +                                                      QEMU_PLUGIN_INLIN=
E_STORE_U64,
>> +                                                      end_block, qemu_p=
lugin_insn_vaddr(last_insn));
>> +    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
>> +                                                      QEMU_PLUGIN_INLIN=
E_STORE_U64,
>> +                                                      pc_after_block,
>> +                                                      qemu_plugin_insn_=
vaddr(last_insn) +
>> +                                                      qemu_plugin_insn_=
size(last_insn));
>> +
>> +    for (int idx =3D 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
>> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i=
dx);
>> +        uint64_t ipc =3D qemu_plugin_insn_vaddr(insn);
>> +        /*
>> +         * If this is a potential branch point check if we could grab
>> +         * the disassembly for it. If it is the last instruction
>> +         * always create an entry.
>> +         */
>> +        NodeData *node =3D fetch_node(ipc, last_insn);
>> +        if (node) {
>> +            g_mutex_lock(&node->lock);
>> +            if (!node->insn_disas) {
>> +                node->insn_disas =3D qemu_plugin_insn_disas(insn);
>> +            }
>> +            if (!node->symbol) {
>> +                node->symbol =3D qemu_plugin_insn_symbol(insn);
>> +            }
>> +            if (last_insn =3D=3D insn) {
>> +                node->last_count++;
>> +            } else {
>> +                node->mid_count++;
>> +            }
>> +            g_mutex_unlock(&node->lock);
>> +        }
>> +
>> +        /* Store the PC of what we are about to execute */
>> +        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
>> +                                                            QEMU_PLUGIN=
_INLINE_STORE_U64,
>> +                                                            last_pc, ip=
c);
>> +    }
>> +}
>> +
>> +QEMU_PLUGIN_EXPORT
>> +int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>> +                        int argc, char **argv)
>> +{
>> +    for (int i =3D 0; i < argc; i++) {
>> +        char *opt =3D argv[i];
>> +        g_auto(GStrv) tokens =3D g_strsplit(opt, "=3D", 2);
>> +        if (g_strcmp0(tokens[0], "sort") =3D=3D 0) {
>> +            if (g_strcmp0(tokens[1], "hottest") =3D=3D 0) {
>> +                report =3D SORT_HOTDEST;
>> +            } else if (g_strcmp0(tokens[1], "early") =3D=3D 0) {
>> +                report =3D SORT_EARLY;
>> +            } else if (g_strcmp0(tokens[1], "popular") =3D=3D 0) {
>> +                report =3D SORT_POPDEST;
>> +            } else {
>> +                fprintf(stderr, "failed to parse: %s\n", tokens[1]);
>> +                return -1;
>> +            }
>> +        } else {
>> +            fprintf(stderr, "option parsing failed: %s\n", opt);
>> +            return -1;
>> +        }
>> +    }
>> +
>> +    plugin_init();
>> +
>> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>> +    return 0;
>> +}
>> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
>> index 98a89d5c40..ea81fde2b5 100644
>> --- a/contrib/plugins/Makefile
>> +++ b/contrib/plugins/Makefile
>> @@ -29,6 +29,7 @@ NAMES +=3D cache
>>   NAMES +=3D drcov
>>   NAMES +=3D ips
>>   NAMES +=3D stoptrigger
>> +NAMES +=3D cflow
>>     ifeq ($(CONFIG_WIN32),y)
>>   SO_SUFFIX :=3D .dll

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

