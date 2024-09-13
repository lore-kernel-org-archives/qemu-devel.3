Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3906FA373F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 10:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp3TG-0001qm-Lp; Fri, 13 Sep 2024 06:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sp3TC-0001pD-1z
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:24:06 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sp3T9-0002h3-Ga
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:24:05 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a90349aa7e5so196225966b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 03:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726223041; x=1726827841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmYxsUlKrTQrTL6fy/gYgLOJOnbnLsWnE3zKHSbMwZo=;
 b=bh3ilI5ox2jSJeezzYXA3PvzYqJJgPRZeiI0ST0n76kO0MkbKgWks0tAwvjVZVz1Ej
 CH2kscbANIjjmM+XSOMQ5qV/y3EcghUZCGk3KsfJMs2LoezDVdKQ5zxSz+RrVcLNQT7A
 LkwQpM5asCWl5hbE8ZkqHz3MrOTCgyDIkj7NGFtoxGcHLA21lE6meX3sxlcpEFoqsXMc
 CWeIoU/1rxf3X+9zSAaI1Q5I61YLRd6ViS2THS4Qyc5Ib/ER2XypCJlu6j9gY7XMQK4u
 GBVmt7Mejpl/RQ3wA4dI98SPtrhVcd1TCfN6sm7CKiZo5KrXxoi/N+Rki0LfpkEF8Axb
 pNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726223041; x=1726827841;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dmYxsUlKrTQrTL6fy/gYgLOJOnbnLsWnE3zKHSbMwZo=;
 b=lDLjufODwHe7CCoZWBZtIvUroLK+GLrZJ2ieBxR5XV1x0vgavnxstwMmIiG9BVCyjf
 DHo+3yHHtmU2LQZkZjkXQ/01IPSvzYC7Sct4g35goFtK7DHvTSqjnfejymT94WsXStwM
 r9Jr15aOUw8oZttR5jwNIi0EeN4r3zOPVbEPJ3U+3bgT6Ogm+lZ8ZiDEaghZ/ZH31Nym
 eCIzeHcYlYB1Yl7j3M+72dDZVydUQbCSLqwT2tiadVSa/FSgp1e/o9t/69ts/3pgnanx
 C8TvxQi6SDaFJ0/Tvme5AN1e0JyvLo9R3rifCC2SLR42OKNzppCuf7ONzoFUtr0Hm2jW
 /bZQ==
X-Gm-Message-State: AOJu0YyNiXdu1fqm19vQbUAjoj8tPXGYwa91DJxeIYYnLCJw9qNm8U35
 ujwm0CzagYc8s3MPGzBYZD/BVSNW0XNOjYGvpDEFs/0RJmiZEI474KAyhUuig4w=
X-Google-Smtp-Source: AGHT+IEWLbGVipNtGAqFwwzBRE1SZCR6ID9Kco+GPqT2MuFlj+JZf3Y0M/5kPCV3kyIt5gnA+XlSRg==
X-Received: by 2002:a17:907:e699:b0:a8a:8c4c:3e2a with SMTP id
 a640c23a62f3a-a902944e6cfmr481374166b.23.1726223040471; 
 Fri, 13 Sep 2024 03:24:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c72ed3sm854121466b.135.2024.09.13.03.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 03:23:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1488B5F8B7;
 Fri, 13 Sep 2024 11:23:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 0/2] tcg: Fix branch/label link during plugin expansion
In-Reply-To: <f7f1cb70-08f8-48aa-9db7-cc7a119a4234@linaro.org> (Richard
 Henderson's message of "Tue, 10 Sep 2024 14:28:15 -0700")
References: <20240910212351.977753-1-richard.henderson@linaro.org>
 <f7f1cb70-08f8-48aa-9db7-cc7a119a4234@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 13 Sep 2024 11:23:59 +0100
Message-ID: <87jzffrgw0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/10/24 14:23, Richard Henderson wrote:
>> With tcg_last_op(), we always get the last op of the stream.
>> With TCGContext.emit_before_op, the most recently emitted op
>> is no longer the last op.
>> Instead, pass the op being emitted back from the allocator so
>> that we can link it to the label without needing to look it up.
>
> Oh, I meant to point out from whence this comes.
> The plugin uses a conditional

    size_t n_insns =3D qemu_plugin_tb_n_insns(tb);
    qemu_plugin_u64 quantum_insn =3D
        qemu_plugin_scoreboard_u64_in_struct(vcpus, vCPUTime, quantum_insn);
    /* count (and eventually trap) once per tb */
    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
        tb, QEMU_PLUGIN_INLINE_ADD_U64, quantum_insn, n_insns);

>  ld_i32 tmp18,env,$0xffffffffffffdb10
>  mul_i32 tmp18,tmp18,$0x18
>  ext_i32_i64 tmp17,tmp18
>  add_i64 tmp17,tmp17,$0x575410edadc8

    qemu_plugin_register_vcpu_tb_exec_cond_cb(
        tb, every_quantum_insn,
        QEMU_PLUGIN_CB_NO_REGS, QEMU_PLUGIN_COND_GE,
        quantum_insn, max_insn_per_quantum, NULL);

?

>  ld_i64 tmp21,tmp17,$0x0
>  brcond_i64 tmp21,$0x0,ltu,$L1
>  ld_i32 tmp18,env,$0xffffffffffffdb10
>  call plugin(0x79a2abfde66a),$0x1,$0,tmp18,$0x0
>  set_label $L1
>
> Note that the branch is X < 0 (unsigned), which is always false, and
> thus the branch is optimized away.

I'm obviously missing something reading this. How can TCG know the state
of the scoreboard variables and optimise away the branch?

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

