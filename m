Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6CFCA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKB7-0003oY-6e; Thu, 01 Oct 2026 13:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1xCKB4-0003nQ-Pp
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:02:38 -0400
Received: from mail-lr2-x0d.google.com ([2a00:1450:4864:38::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1xCKB2-0004mT-GV
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:02:38 -0400
Received: by mail-lr2-x0d.google.com with SMTP id
 38308e7fff4ca-3a7847d8aadso8783621fa.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790874153; x=1791478953; darn=nongnu.org;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+Uim3iXrs9ptxuIhoMLTn8RI7K3gzSqP7VAadz6nUvA=;
 b=LS6DnaU3jIzDVUymuT9DNMKZU+2EqyiRggXac/66jbVZ3dAZmjypbISsWAskdl9859
 hXq+sSg+wze3G33DCgEc9og71umr9on9aLx9C95NvAtbLCVk99+ybiS2aZCD+1T3MEC9
 0Y9tBecMY9iXrjkoIsNZxMrjqz9mNPEPI33SemjbG2tgNIUaLY/7spDcaS1fghSDPEjn
 rf9M+BjUXelo/Ji8FIcl6iuq3LQIB96JLVl7bx6LOMEEDHGDmwmgWoghm2usmxuo/Odl
 SoR+hJUj2smxRoVtrNHsuaEY5rGXfiuCpFWDCBmid2iJjggSOYE8TaYAvybCyiQebnOh
 LOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790874153; x=1791478953;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Uim3iXrs9ptxuIhoMLTn8RI7K3gzSqP7VAadz6nUvA=;
 b=pBSAqU0ilvNROG0YrrOG+UJ3hAMasBUzWkuvpC8h2/1x/CNpXP4SQIVkRDZVvJb5Kw
 aq00sw23DT0Vsn8pr+PxQHNmGNr50NE2r7xXlUSi24gnJI004ZIuBGx0bLTyqurHkJUa
 avqGirkUo+E5q61yQCdkfvmRhmKhAbxlkpzQg+zWPUTkE710s7J2kcRI0DJTy4+ggmnm
 xeegg1iUW5yb/RdnE7bW50wfOGvaUySMtlaSv6suN842IP7kytblvDKQG/kIFojy2VrN
 VMTICciwRQA8+qnGErsa9FsSrHy0SNnSPxZh+0rXtCuQ/TW3e7UnBLQ/IMLCbPM7JomC
 /t5w==
X-Forwarded-Encrypted: i=1;
 AKwUvByrLP/VLMTxQMlpd+hbuXtDTNvUZ9ploSnM+Io+/LJ6rvCBkyR14Qtxt6xp6StetC2KMswE9Dk8G9Yo@nongnu.org
X-Gm-Message-State: AFq9FYJcktAKkbiSgbB97ywdv53cCRRK/EGsxXtIcUFV+d5vIybTZF7V
 x/ihotd1u0AlzKpd7u2Js5mim0CrsHSvVmJB5nXeNtcpaBLPdLeJuc8p0dzkrVvHsLI=
X-Gm-Gg: AYBFou0j7CPgpH21uOVNyflzOVOd9rWXpLEMYFNxBJbeAEm9DC6k6BLGAL9OAZJDAML
 Igb2PNJ3HxoRZiBSvg7q7GVDynfgHreXAlIbDh82u8IbNxTSBPdIq48vSTIbcarhhID11+w1oKM
 xKgS3MKGnYlg6JxzC6uy6wE2pZ7+RFzuGglkdf2FEz+/YH4NGyIc+IP9Woz/JyE9QXX+7Cfn4BS
 E8sRXbJHbT3QHeBpwzGmq0LHTN74SrDAPPWWEgbOx5mgtaS2yn/1gbyus+y7Yed5rLqkv0LpEMB
 To/S2r/JljiM0cMhtG2SsLa0fVhzfLxq+uqTqzR/IQ5JlU5azakqG9X/zG+dICSZ+GcOK9+eBIZ
 lolzZnbHmfkYqrbgHtmp2R3Iml7PyiyZlhWinRgk+DJ0NtkEOmQ3N4nRTjj+9aHz5QrAGW+Ocuf
 hwnHC52HYWxrUyD8UkaDa3BJKW4Vy4XhDweoQDLUfnjISyhMDkGDETN+jwA42sfEge/LQ103vpx
 Fxp1abl8pEhZ+ZFQaIg3a/pb1USqru2ww==
X-Received: by 2002:a2e:a989:0:b0:3a8:7db9:3b28 with SMTP id
 38308e7fff4ca-3a87db93f65mr769791fa.20.1790874153635; 
 Thu, 01 Oct 2026 10:02:33 -0700 (PDT)
Received: from localhost ([2001:1970:3847:e000:1977:be2f:4a71:2892])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e32c6ccsm470601fa.38.2026.10.01.10.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 10:02:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 13:02:25 -0400
Message-Id: <DLTNWGSL7L7F.LNM2NJ62JNLJ@baylibre.com>
To: "Alistair Francis" <Alistair.Francis@wdc.com>, "tgamblin@baylibre.com"
 <tgamblin@baylibre.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: "Trevor Gamblin" <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 2/2] target/riscv: add helper_tlb_flush_page(), use
 for sfence.vma with vaddr operand
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
X-Mailer: aerc 0.22.0
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
 <20260904-riscv_tlb_page_flush-v2-2-defec3f29312@baylibre.com>
 <322f18f233ae985970ba75eede7d3623110b13f3.camel@wdc.com>
In-Reply-To: <322f18f233ae985970ba75eede7d3623110b13f3.camel@wdc.com>
Received-SPF: pass client-ip=2a00:1450:4864:38::d;
 envelope-from=tgamblin@baylibre.com; helo=mail-lr2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu Oct 1, 2026 at 1:14 AM EDT, Alistair Francis wrote:
> On Fri, 2026-09-04 at 14:43 -0400, Trevor Gamblin wrote:
>> sfence.vma unconditionally called helper_tlb_flush(), regardless of
>> the
>> rs1 (vaddr) and rs2 (asid) operands, forcing a page-table walk on the
>> next access. Create a page-level counterpart to helper_tlb_flush()
>> called helper_tlb_flush_page(), and use it whenever rs1 !=3D 0, falling
>> back to the existing full flush for rs1 =3D=3D 0. This makes RISC-V
>> behaviour more similar to ARM's equivalent (tlbi_aa64_vae1_write),
>> which
>> already does tlb_flush_page_by_mmuidx() instead of a full flush.
>>=20
>> Pass get_address(ctx, a->rs1, 0) to gen_helper_tlb_flush_page()
>> rather
>> than get_gpr(), so that the address being passed matches the current
>> addr_xl width regardless of '-cpu' input. Otherwise, the raw register
>> value can carry garbage above that width and never match the address
>> the
>> TLB entry was actually filled under, so the flush silently misses and
>> a
>> stale mapping survives.
>>=20
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Can you fixup sinval.vma and hinval.* as well please?

Sure! I'm travelling next week, but I'll see if I can get patches written i=
n
downtime or right afterward.

Trevor
>
> Alistair
>
>> ---
>> =C2=A0target/riscv/helper.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
>> =C2=A0target/riscv/tcg/insn_trans/trans_privileged.c.inc | 6 +++++-
>> =C2=A0target/riscv/tcg/op_helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 6 ++++++
>> =C2=A03 files changed, 12 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>> index 4fc2d3a155..652f85a5c7 100644
>> --- a/target/riscv/helper.h
>> +++ b/target/riscv/helper.h
>> @@ -137,6 +137,7 @@ DEF_HELPER_1(ctr_clear, void, env)
>> =C2=A0DEF_HELPER_1(wfi, void, env)
>> =C2=A0DEF_HELPER_1(wrs_nto, void, env)
>> =C2=A0DEF_HELPER_1(tlb_flush, void, env)
>> +DEF_HELPER_2(tlb_flush_page, void, env, tl)
>> =C2=A0DEF_HELPER_1(tlb_flush_all, void, env)
>> =C2=A0DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
>> =C2=A0/* Native Debug */
>> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
>> b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
>> index a8eaccef67..8655fa332e 100644
>> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
>> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
>> @@ -155,7 +155,11 @@ static bool trans_sfence_vma(DisasContext *ctx,
>> arg_sfence_vma *a)
>> =C2=A0{
>> =C2=A0#ifndef CONFIG_USER_ONLY
>> =C2=A0=C2=A0=C2=A0=C2=A0 decode_save_opc(ctx, 0);
>> -=C2=A0=C2=A0=C2=A0 gen_helper_tlb_flush(tcg_env);
>> +=C2=A0=C2=A0=C2=A0 if (a->rs1 =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_tlb_flush(tcg_env=
);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_tlb_flush_page(tc=
g_env, get_address(ctx, a->rs1,
>> 0));
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> =C2=A0#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> diff --git a/target/riscv/tcg/op_helper.c
>> b/target/riscv/tcg/op_helper.c
>> index 7f63f3ada5..178b4d271b 100644
>> --- a/target/riscv/tcg/op_helper.c
>> +++ b/target/riscv/tcg/op_helper.c
>> @@ -607,6 +607,12 @@ void helper_tlb_flush(CPURISCVState *env)
>> =C2=A0=C2=A0=C2=A0=C2=A0 tlb_flush(cs);
>> =C2=A0}
>> =C2=A0
>> +void helper_tlb_flush_page(CPURISCVState *env, target_ulong addr)
>> +{
>> +=C2=A0=C2=A0=C2=A0 check_sfence_vma(env, GETPC());
>> +=C2=A0=C2=A0=C2=A0 tlb_flush_page(env_cpu(env), addr);
>> +}
>> +
>> =C2=A0void helper_tlb_flush_all(CPURISCVState *env)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 CPUState *cs =3D env_cpu(env);



