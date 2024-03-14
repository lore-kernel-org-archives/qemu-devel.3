Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6711C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 12:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjnW-0003Xr-Pz; Thu, 14 Mar 2024 08:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkjnF-0003Sx-Vj
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:02:48 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkjms-0004Ye-9J
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:02:41 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a44e3176120so110668866b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 05:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710417722; x=1711022522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eteaIqbh2amjcWhiYQPvrkofHijvapw8cdvP3axaxSY=;
 b=dk+dHtdMMZoLg7A3xW6f1bYLSEPFQb0rdjIhiEIke49bfsZBQqeJyCy5fcOR68OVsO
 pRMdLfr8RnXlW6LiN9DTtYXGSGBtHR+pRTuWBFcYY6r28Kqp5QMq6FPCd6XOmV2n3bAB
 YE1ZPw/LUHghejIyPopq126GvTfnxWhip6ir2vn+31TfBAmi7DKrRNeg2xYtC4NemwV0
 vYPGDTL3EkvL12aEtzVq+Q4s0HNx1EvJu/VcyYrR8ejAyrbsLM8Bu0iNEFdEQVxp+AJ3
 /8s85UpWK2cZoMlz7ix8fFq5UbuknONAGn7MNuCybNvrJ6qk5VYUeFSomVqvG0ZUw2pn
 PRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710417722; x=1711022522;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eteaIqbh2amjcWhiYQPvrkofHijvapw8cdvP3axaxSY=;
 b=gaDEPTH1Y4cCisj7XGTjKT1+Y0wK8uIehi3R5/uJoFvWt7aFTllIDT1zcOi/gzScL8
 Gx6P3JkS+pLSVWkijApIjgkxXKz3CC5Julk4cnNFUesHKc974hM6ab7pxXYo4/Sr9/OS
 yp+PcUxI7A3HwWyPcrmBFXypbtCVlBbayWHb+xA/Ctub4Dt/mgYOYwiVadvT3IAb2fkm
 2tQUpkOiemePUGU9g1oK4i7sClFOgpltnqSQKMfwgayONdwYP2KIEOhXop5qG0SXw3g/
 yuuxTu/hVX+DQGvd1rjKyFiA8V+Lhvw7Taqv3uK/PrRmC/ocBSxB5ILL2TXe+gqooWvd
 9vpA==
X-Gm-Message-State: AOJu0Yz4vVUQT7HqvTJ2vkBxyz7GGeXcnggTaIH89UIYCxc3h/VnGCK7
 8zabAPRwWXl5t3/NpWIoAugyISmYHVjnd5bIT+VOTXt3Gn5XCKtPWnS4HmL6JDo=
X-Google-Smtp-Source: AGHT+IGV7HLJ8zPywFR7P4NEn7mfhAxUuAW1V1X7PpberUvCJFvB2nbCnCdVCIqo7V3+FM30Rh9pQQ==
X-Received: by 2002:a17:906:19c7:b0:a46:637c:db67 with SMTP id
 h7-20020a17090619c700b00a46637cdb67mr398584ejd.5.1710417721769; 
 Thu, 14 Mar 2024 05:02:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a9-20020a170906244900b00a46641e728bsm643786ejb.113.2024.03.14.05.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 05:02:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF5285F890;
 Thu, 14 Mar 2024 12:02:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v2] contrib/plugins: control flow plugin (WIP!)
In-Reply-To: <20240314114907.88890-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Thu, 14 Mar 2024 11:49:07 +0000")
References: <20240314114907.88890-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.2
Date: Thu, 14 Mar 2024 12:02:00 +0000
Message-ID: <87msr1ggxz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This is a simple control flow tracking plugin that uses the latest
> inline and conditional operations to detect and track control flow
> changes. It is currently an exercise at seeing how useful the changes
> are.
>
> Based-on: <20240312075428.244210-1-pierrick.bouvier@linaro.org>
> Cc: Gustavo Romero <gustavo.romero@linaro.org>
> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20240311153432.1395190-1-alex.bennee@linaro.org>
>
> ---
> v2
>   - only need a single call back
>   - drop need for INSN_WIDTH
>   - still don't understand the early exits
>
> I'm still seeing weirdness in the generated code, for example the
> plugin reports "early exits" which doesn't make sense for a ret which
> terminates a block:
>
>   addr: 0x403c88 hexchar: ret  (1/1)
>     early exits 1280
>     branches 1280
>       to 0x403d00 (639)
>       to 0x403d24 (639)
>
<snip>
> +
> +/*
> + * At the start of each block we need to resolve two things:
> + *
> + *  - is last_pc =3D=3D block_end, if not we had an early exit
> + *  - is start of block last_pc + insn width, if not we jumped
> + *
> + * Once those are dealt with we can instrument the rest of the
> + * instructions for their execution.
> + *
> + */
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    uint64_t pc =3D qemu_plugin_tb_vaddr(tb);
> +    size_t insns =3D qemu_plugin_tb_n_insns(tb);
> +    struct qemu_plugin_insn *last_insn =3D qemu_plugin_tb_get_insn(tb, i=
nsns - 1);
> +
> +    /*
> +     * check if we are executing linearly after the last block. We can
> +     * handle both early block exits and normal branches in the
> +     * callback if we hit it.
> +     */
> +    gpointer udata =3D GUINT_TO_POINTER(pc);
> +    qemu_plugin_register_vcpu_tb_exec_cond_cb(
> +        tb, vcpu_tb_branched_exec, QEMU_PLUGIN_CB_NO_REGS,
> +        QEMU_PLUGIN_COND_NE, pc_after_block, pc, udata);
> +
> +    /*
> +     * Now we can set start/end for this block so the next block can
> +     * check where we are at.
> +     */
> +    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(tb,
> +                                                      QEMU_PLUGIN_INLINE=
_STORE_U64,
> +                                                      end_block, qemu_pl=
ugin_insn_vaddr(last_insn));
> +    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(tb,
> +                                                      QEMU_PLUGIN_INLINE=
_STORE_U64,
> +                                                      pc_after_block,
> +                                                      qemu_plugin_insn_v=
addr(last_insn) +
> +
> qemu_plugin_insn_size(last_insn));

With the following:

modified   contrib/plugins/cflow.c
@@ -220,7 +220,7 @@ static void vcpu_tb_branched_exec(unsigned int cpu_inde=
x, void *udata)
     g_mutex_lock(&node->lock);
=20
     if (early_exit) {
-        fprintf(stderr, "%s: pc=3D%"PRIx64", epbc=3D%"PRIx64"
+        fprintf(stderr, "%s: pc=3D%"PRIx64", epbc=3D%"PRIx64
                 " npc=3D%"PRIx64", lpc=3D%"PRIx64", \n",
                 __func__, pc, ebpc, npc, lpc);
         node->early_exit++;
@@ -264,6 +264,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct q=
emu_plugin_tb *tb)
 {
     uint64_t pc =3D qemu_plugin_tb_vaddr(tb);
     size_t insns =3D qemu_plugin_tb_n_insns(tb);
+    struct qemu_plugin_insn *first_insn =3D qemu_plugin_tb_get_insn(tb, 0);
     struct qemu_plugin_insn *last_insn =3D qemu_plugin_tb_get_insn(tb, ins=
ns - 1);
=20
     /*
@@ -278,12 +279,13 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct=
 qemu_plugin_tb *tb)
=20
     /*
      * Now we can set start/end for this block so the next block can
-     * check where we are at.
+     * check where we are at. Do this on the first instruction and not
+     * the TB so we don't get mixed up with above.
      */
-    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(tb,
+    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
                                                       QEMU_PLUGIN_INLINE_S=
TORE_U64,
                                                       end_block, qemu_plug=
in_insn_vaddr(last_insn));
-    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(tb,
+    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
                                                       QEMU_PLUGIN_INLINE_S=
TORE_U64,
                                                       pc_after_block,
                                                       qemu_plugin_insn_vad=
dr(last_insn) +

The report looks more sane:

  collected 9013 control flow nodes in the hash table
    addr: 0x403c88 hexchar: ret  (0/1)
      branches 1280=20=20=20=20=20=20
        to 0x403d00 (639)=20=20=20=20=20=20=20=20=20=20=20=20
        to 0x403d24 (639)

So I think we need to think about preserving the ordering of
instrumentation (at least from the same plugin) so we are not laying any
API bear traps for users.

I assume because loads and stores are involved we won't see the
optimiser trying to swap stuff around.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

