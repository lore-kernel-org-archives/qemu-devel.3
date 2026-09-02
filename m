Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E13AC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mKf-0004y9-Hx; Wed, 02 Sep 2026 10:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x1mKd-0004x6-3l
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:52:55 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x1mKb-0003C8-39
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:52:54 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c25b661d37dso175598466b.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788360769; x=1788965569; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fwvpFEnfTpgT3q0Qh5EpNXC0ncY0Cpnj1G69ubLzRaQ=;
 b=VO9LVRC9uD+DwbXHzUdXtvjmfisPSijzojCdxCxTOXu5jqef4i0sP2pxAAVUjqTnvt
 IsmICgJ5TcYpmOXDnwrF337Mr9Uf4fz1UzhLXpXi9d0N4X9ae/wSjneUjqrO4yY8ZvrA
 lRw8sKawZU6Md9rzuBxGTFBYouIpeN+K9sgNYLBulDDrubiPMoM1fZmjSWwmdxcljU7d
 XjoEsG5ktcpwoXQHU4MP3ecW/bFGyWc20Ky6uklrHDL5NuznkNXbx1s5pNano2CtcsHi
 InJASjuU2nkAmC/gUMirtsWBUY1N30UxQHEPq7Hy5TIcuHKCy7/ugbm4hbt4Qg4lTFdi
 5dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788360769; x=1788965569;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fwvpFEnfTpgT3q0Qh5EpNXC0ncY0Cpnj1G69ubLzRaQ=;
 b=pBn7h+U/0fl+CmCMGcjR5Mf/jLCjsd6oiF/Qxe4h09X0rmBU2r/67PSTj4pynQcSS1
 mzswHTNCvXlpTOpqpsWz324qTbznEfpx24GDadsPwTyN5CoaMILONwVPiWxUKMHyzxq3
 BBwZf4Ak/e+8MsAm/a6y0s9tiAzMkOCZHhkBYeGefHc9xtw+2Rb6vwwi1Z3IWdxqdkAr
 u/0F7xiYaYKHsZxP6/ALFs7JrY06Stnr0uRTmhpM3jXxHvzW7slnb4O0gRXxFkWOw7IH
 5VcApBirNdoWJFAoLPZRecGxEjeEiFHrbbqqyDAfMDYXgl6c43EKlQmTjZw0Q6oaNitM
 99yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9305/IUX3JspNCuZTPCQYGkccVBOncUl0c28Dw0sqlmPqH0SydhehGpNLlITO89TQAE9gXA427Tyz@nongnu.org
X-Gm-Message-State: AFuF++mUZa4Zar5EgI4+kVko1G5sdSZBgpiiS/ANI6NYoaDz8Yh8SmIQ
 x4N8eRaNiaIc+HozjwFleco21PkcMh+W9lfKVEAcKe+JTOA1BPkv6t5mWtyZyUi5D3Y=
X-Gm-Gg: AYBFou2GscWCexNf9+Z1AHUN1NxG67wyJNNk2fq2vVCM/C4KaJ65/mmhS0MhpttgFyZ
 RdReZvxwEZvzp1JI+0tYJwKGQvTO5wF97M41AjLivlRMPkY5IDHYp5qHFVLdKrNn4rn49KedwMd
 5EPGFiq6S4LIofKzgP9UqntAI5doAHIhs87/AbS+r7bDgwviNy8oAAg4jpQQ2v+m3H+F8B7uUhn
 p9uRYQukCn+gKTikhyY2uK+xmEHgo7QLDSg0gJYDmTqqHNcMeETuS0dcACMbZOLnD51aPOLtbk1
 vq0ga3lApCSg6HdLWkBCDH5XXh1+jWaPzb3TUPAWNT0i0gJ7teOznxi912L4xUoMSKyE/h8ovKu
 Z7b1QEJ4eVWxHumuOrc4dnufe8ZIXB7LvIp8WOLNGwGo31jm7IcCtoOeRxSE2rukhEpLzC36wmE
 QQEIF4rcCmMOyNEB8LFBvgnxf6zubifsyZymjVSMQkYRr+DwU9HsSUBZ28lXoUV6o=
X-Received: by 2002:a17:906:9c96:b0:c25:4b3e:ff24 with SMTP id
 a640c23a62f3a-c25d53dceaamr477043366b.10.1788360769532; 
 Wed, 02 Sep 2026 07:52:49 -0700 (PDT)
Received: from localhost ([2001:1970:3847:e000:1977:be2f:4a71:2892])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d043e6bcsm157333066b.61.2026.09.02.07.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 07:52:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 10:52:45 -0400
Message-Id: <DL4WZE1GUDFS.21LK9WLVD9S5X@baylibre.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Alistair Francis"
 <alistair.francis@wdc.com>, "Weiwei Li" <liwei1518@gmail.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, "Chao Liu" <chao.liu@processmission.com>,
 <qemu-riscv@nongnu.org>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH 3/3] target/riscv: use a targeted TLB page flush for
 sfence.vma with a vaddr operand
From: "Trevor Gamblin" <tgamblin@baylibre.com>
To: "Daniel Henrique Barboza" <daniel.barboza@oss.qualcomm.com>, "Trevor
 Gamblin" <tgamblin@baylibre.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.22.0
References: <20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com>
 <20260831-riscv_tlb_page_flush-v1-3-4fc6af95673a@baylibre.com>
 <b8ab3fbd-cf37-499b-8efa-26df5fd01fd9@oss.qualcomm.com>
In-Reply-To: <b8ab3fbd-cf37-499b-8efa-26df5fd01fd9@oss.qualcomm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=tgamblin@baylibre.com; helo=mail-ej1-x635.google.com
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

On Tue Sep 1, 2026 at 5:53 PM EDT, Daniel Henrique Barboza wrote:
>
>
> On 8/31/2026 3:59 PM, Trevor Gamblin wrote:
>> sfence.vma unconditionally called helper_tlb_flush(), regardless of the
>> rs1 (vaddr) and rs2 (asid) operands, forcing a page-table walk on the
>> next access. Use helper_tlb_flush_page() whenever rs1 !=3D 0, falling ba=
ck
>> to the existing full flush for rs1 =3D=3D 0. This makes RISC-V behaviour
>> more similar to ARM's equivalent (tlbi_aa64_vae1_write), which already
>> does tlb_flush_page_by_mmuidx() instead of a full flush.
>>=20
>> Pass get_address(ctx, a->rs1, 0) to gen_helper_tlb_flush_page() rather
>> than get_gpr(), so that the address being passed matches the current
>> addr_xl width regardless of '-cpu' input. Otherwise, the raw register
>> value can carry garbage above that width and never match the address the
>> TLB entry was actually filled under, so the flush silently misses and a
>> stale mapping survives.
>>=20
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
>>   target/riscv/tcg/insn_trans/trans_privileged.c.inc | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target=
/riscv/tcg/insn_trans/trans_privileged.c.inc
>> index a8eaccef67..8655fa332e 100644
>> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
>> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
>> @@ -155,7 +155,11 @@ static bool trans_sfence_vma(DisasContext *ctx, arg=
_sfence_vma *a)
>>   {
>>   #ifndef CONFIG_USER_ONLY
>>       decode_save_opc(ctx, 0);
>> -    gen_helper_tlb_flush(tcg_env);
>> +    if (a->rs1 =3D=3D 0) {
>> +        gen_helper_tlb_flush(tcg_env);
>> +    } else {
>> +        gen_helper_tlb_flush_page(tcg_env, get_address(ctx, a->rs1, 0))=
;
>> +    }
>
> As I said in patch 2 I believe patch 2 and 3 should be squashed.
>
> LGTM otherwise.  That's a nice performance boost for a handful of lines. =
 If only
> all optimizations were like that :)
>
Thanks for the review! I'll make the changes you suggested, but I'll also w=
ait a
couple of days before submitting a v2 in case others have feedback.

Trevor
>
>
> Thanks,
> Daniel
>
>>       return true;
>>   #endif
>>       return false;
>>=20



