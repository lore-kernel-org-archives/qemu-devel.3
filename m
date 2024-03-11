Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACECC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhoa-0000Eo-M3; Mon, 11 Mar 2024 11:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjhoY-0000Ea-SF
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:43:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjhoX-00086q-2C
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:43:46 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41329a665a8so6203425e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710171822; x=1710776622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3Y3zS9CQ8NaFfD/jftOGx3sdvZq7h1i3dnbj28ehbg=;
 b=MlPJadPPBrARQtK1eWkciWJiCHG24/TKRmQO19aXeJkWxsBnIFoM0X9AHc8gFTnKOk
 5trHQYYQ4NOO61AlYG9mbbbYp6q7N/hlyzG+0//BHSyi0gMjoLV2ueHz/N4xrix/HYzR
 ntXhJRwLijTt2eHuNg7YLV2NP/yqo+LdBt2o3i2YB4BPph8bTqRTxsaqB7bzJavFxwqs
 mkjndDlgEkXZinmWvomllRu+qrwcodPXKSCjgruNxJPa9inJBq41m/nMpCFh4PEyQjYq
 GfmSieqtKg8XGalzpkRpa5FbzfqF1O6Fi2jtEMadvyW9ntJjEyQWhUxmME4J9GY9Sjmj
 fE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710171822; x=1710776622;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q3Y3zS9CQ8NaFfD/jftOGx3sdvZq7h1i3dnbj28ehbg=;
 b=EMYCwLsHfAS5RX7zy/fvZ9FXYe8pI0YUup8zgmDOE9Fk9yt4I7eOqq7iHRknZQCveD
 jtjQvF/moRUNpxBwX8ETzkxb6Ooh5CVgbMFUUCJNd+hE3egg7axG09ntUy6fd32ZY+tJ
 ilnabSP0NJE1Sib/FljuOFxQ8bmGdQfqXnrAVp5hUwJTd4x5YMkv44lZxuxOQDx9YLS2
 wa6Zd0vGIrnND4YXj4Peu8NPT1UeY6EfoyKkaEaO7IPgqpajn9FivwfMCzVqah0bBZ5F
 W7sqpf9XCvuUnexptEcF15VL/cQUOjkBmiAxQKkoRmhS/SV52l+HzA6qb6gfMa5hUi9H
 CZLw==
X-Gm-Message-State: AOJu0YzBTCXjuiG/yud6Dd6lWJDNqacHl5LeaAZH0g/pzXJb3dmN2a9t
 N4Nm3b2bi+udOwXagJAxouC4Q40VEyAy3ahzur2HMi9ws3nLLy5Qg5qOaDYGl10=
X-Google-Smtp-Source: AGHT+IFG6zhvjdPEW/eNVnuNK0KYTM65QNAbz/Yk3UX8a2FI6Z7/wf+IPqASZ75ZOcHIdlQgtYCq1A==
X-Received: by 2002:a05:600c:1e21:b0:413:2f40:1a8f with SMTP id
 ay33-20020a05600c1e2100b004132f401a8fmr565235wmb.28.1710171822140; 
 Mon, 11 Mar 2024 08:43:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fl7-20020a05600c0b8700b004132b28209asm2944949wmb.24.2024.03.11.08.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 08:43:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F7585F756;
 Mon, 11 Mar 2024 15:43:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 4/5] plugins: conditional callbacks
In-Reply-To: <20240229055359.972151-5-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 29 Feb 2024 09:53:58 +0400")
References: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
 <20240229055359.972151-5-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Mon, 11 Mar 2024 15:43:41 +0000
Message-ID: <87zfv4pydu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Extend plugins API to support callback called with a given criteria
> (evaluated inline).
>
> Added functions:
> - qemu_plugin_register_vcpu_tb_exec_cond_cb
> - qemu_plugin_register_vcpu_insn_exec_cond_cb
>
> They expect as parameter a condition, a qemu_plugin_u64_t (op1) and an
> immediate (op2). Callback is called if op1 |cond| op2 is true.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
<snip>
>=20=20
> +static TCGCond plugin_cond_to_tcgcond(enum qemu_plugin_cond cond)
> +{
> +    switch (cond) {
> +    case QEMU_PLUGIN_COND_EQ:
> +        return TCG_COND_EQ;
> +    case QEMU_PLUGIN_COND_NE:
> +        return TCG_COND_NE;
> +    case QEMU_PLUGIN_COND_LT:
> +        return TCG_COND_LTU;
> +    case QEMU_PLUGIN_COND_LE:
> +        return TCG_COND_LEU;
> +    case QEMU_PLUGIN_COND_GT:
> +        return TCG_COND_GTU;
> +    case QEMU_PLUGIN_COND_GE:
> +        return TCG_COND_GEU;
> +    default:
> +        /* ALWAYS and NEVER conditions should never reach */
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static TCGOp *append_cond_udata_cb(const struct qemu_plugin_dyn_cb *cb,
> +                                   TCGOp *begin_op, TCGOp *op, int *cb_i=
dx)
> +{
> +    char *ptr =3D cb->cond_cb.entry.score->data->data;
> +    size_t elem_size =3D g_array_get_element_size(
> +        cb->cond_cb.entry.score->data);
> +    size_t offset =3D cb->cond_cb.entry.offset;
> +    /* Condition should be negated, as calling the cb is the "else" path=
 */
> +    TCGCond cond =3D tcg_invert_cond(plugin_cond_to_tcgcond(cb->cond_cb.=
cond));
> +
> +    op =3D copy_const_ptr(&begin_op, op, ptr);
> +    op =3D copy_ld_i32(&begin_op, op);
> +    op =3D copy_mul_i32(&begin_op, op, elem_size);
> +    op =3D copy_ext_i32_ptr(&begin_op, op);
> +    op =3D copy_const_ptr(&begin_op, op, ptr + offset);
> +    op =3D copy_add_ptr(&begin_op, op);
> +    op =3D copy_ld_i64(&begin_op, op);
> +    op =3D copy_brcondi_i64(&begin_op, op, cond, cb->cond_cb.imm);
> +    op =3D copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
> +    op =3D copy_set_label(&begin_op, op);
> +    return op;

I think we are missing something here to ensure that udata is set
correctly for the callback, see my RFC:

  Subject: [RFC PATCH] contrib/plugins: control flow plugin (WIP!)
  Date: Mon, 11 Mar 2024 15:34:32 +0000
  Message-Id: <20240311153432.1395190-1-alex.bennee@linaro.org>

which is seeing the same value every time in the callback.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

