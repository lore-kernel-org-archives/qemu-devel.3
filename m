Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F46C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 05:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBQPn-00063w-3w; Tue, 29 Sep 2026 01:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBQPk-00060k-3M
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 01:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBQPg-0001sF-UU
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 01:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790659799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hPHYqyincn+hTxABnHqYb3lQyR9iHe/92i946z4LVu8=;
 b=QPpdITYtllYfMPRMjNqC6ILVLny9xxU6sz7r3ycSKJLLeZ56KuWZGo9aXSv5KtAPxxcwzw
 ewjnmrD6REjAgZ3YobjwocaobulguObk4PNg2VWq0MP4aSYdKh0c0A7zbSYWEUfbtQIbUN
 mjHoYL/8qUlDjpg69Yjy62O5cjUx3ws=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-1AcjYyaTNxahvrEnWu64Cg-1; Tue, 29 Sep 2026 01:29:56 -0400
X-MC-Unique: 1AcjYyaTNxahvrEnWu64Cg-1
X-Mimecast-MFC-AGG-ID: 1AcjYyaTNxahvrEnWu64Cg_1790659796
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d9057fab9eso39834095ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 22:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790659796; cv=none;
 d=google.com; s=arc-20260327;
 b=BWPa+eAjs8lgW7X3FUfrqwDnNEgHcW4lqTMb0NCyIFOhK+X2SPezjh7KBT/LROsl6C
 fNspjLguF5WIMVGVKBIn5MVmFUa+yXIN+F3X7h36bM5f3gEzDh6gQ4HvWjh8n8q62qKG
 hEkn9qLJOz6OnIKV9E7gemhiyMKztMtPH8+sIhMJFLS6CNvAvTAWuhLsZ6SVSlV8OZko
 lD6/vpfwOpr1cee2Pzrjya8H7jfP13F65qgpq/f5FEbu/aZMxh+7jJjnEoCxuMFHSZ3E
 V8BI3o418U7seL3Zha3nYTgFxCYlU7h/mRH36f5wXBn7mT6e1JHG9SY1s4pQgXSAGsWD
 uuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hPHYqyincn+hTxABnHqYb3lQyR9iHe/92i946z4LVu8=;
 fh=BczC7wlOznS5cCuz2KIKmgq1AOmESaf64TGj1WF9WFM=;
 b=napQPfkKifS7ubwpEc4UkgTlai8cVrV0Y48pfiaIiXL2DQHdLgZEtauSyrYa9/hghc
 pjRFHFbEz1nRo8NbEspoYJS4gTKdGHIQJkDse0ael8NzEN0PnOmkOsdzK4N9n7CY1nHI
 QZey2OCnJ7PCXd1oyTKf2qi9eJWYvx6j8PV5aZyJxIX9GG+kQ58+mlhM0MAsNS7gl0hg
 udXRO4dmBoCoWdJSqFnu81Pqt4XdJfFp/keJk/+s82aMsc3Clxkssb2qrpFX1afcr8yG
 U2OPOGh3BhjY6ga//tRCn31pXq8lTfjv2tsPM4HGltkJdkJ9IZ45pvqYRqOmAwoMZ6Tu
 nE/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790659796; x=1791264596; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hPHYqyincn+hTxABnHqYb3lQyR9iHe/92i946z4LVu8=;
 b=Dmfb9NZxmYZ3XnpV/9KYj5oG1rOhz6LcSj/wwschdq2J8frqjqMM7a4IK3pCDqEcX4
 Ptx7nvWYV9tfOu0R/vyoo3N7tdV5EyCDu3V4VTmolXbWGiEnFGHklonTzn72PSjlUIjb
 2hO09Hr4r8m6vN2mWtRa7tDy+ftp6ZA+sIp5FdRPPJMmpAzp3asuctiCEIP8A1QBs1Fi
 d9FOuIqW8q2VMhooW0kJLBDTMIdld02UG7wSWkV/7GlF5kUCpu7hNPm90IIq+4NbtRet
 KyWLNlmWtzUKBIPzS+ACmlKG2jaVyfEsEkV2sRDn6UKovzTdLDb2uh3pGi22wBZ+hGzv
 futw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790659796; x=1791264596;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hPHYqyincn+hTxABnHqYb3lQyR9iHe/92i946z4LVu8=;
 b=jLkSyCPHQLENj1NCGk8Q1EA3fiIzSK63vfglO75Mq2n/5RgFWZyKiQtID6tn0OPIRT
 upl/Q0GlSAhppTMiZFHe+1ADy4FjT4f9EvY9EBU0fqBJNW+0h+6A4xoiRTUq35sqVqxi
 ZuRX3Yv1qmolBlnI3HbPGhn31LIFfxBLA41XkvjnjYRQOak98t3QN4UoxJeMMW7jkr9d
 ecNbdZ2cYI22BSDXv3nzejeyoDV8iSIrV3tWI3npaNjE69M2TgEl62n7rpJacz8vD2Ux
 M2JvKvprZHVJRYDw6yIxvpOrkeSf/TOg0rrlHKrqw9cX+n6RmwWsuRLUQAip2tXTinye
 yw1A==
X-Gm-Message-State: AFq9FYLMJW7YdNm7xavs5iUKiNoUD7TA0dp6i4SAsrbtoDVgFxjk2pPJ
 udR3B3T8bAkMZyo6hqy5knQ8LGnjSor6P5sna3w95i/DwQX2OptxJDSQfobHznBPATUohymxxf/
 XSlNh+rh+lxigWXbz85iz26Ed6PcESv57W7Lb89CLarJ/f7t+fGgnZymWmeRo6ep/EMLtnoqQsU
 Zw33QvYzQRvqKxn3zFLlfjXSwNRj8ohFA=
X-Gm-Gg: AYBFou2xg8S6bwN6bn2LThWbF3yT0OGBhBzgECics0X+8FV5KOay8VoLjyV4rTrCOBF
 NlS68jpTDus2R76yUO01PxYmHQDG+Zy6g/1Zz4iSOocOWwv9Q6dMQd8lVlGkMcMzuC/BPxbrOl2
 Nadot3kExXu6Zmpnqy4dm+ltUsIFbuj1Vmx9kQCkQB6NS9NKZFDTrCf389FLHexgtIBWxqFuSHV
 5eBqtI9hYDjrFUWXPnYMUV4w19bxo7jP2RbiV0nFEKDK0LiC6HGfyDWPFdf1g==
X-Received: by 2002:a17:903:2c0d:b0:2df:8513:882 with SMTP id
 d9443c01a7336-2df85130a8bmr110888245ad.62.1790659795646; 
 Mon, 28 Sep 2026 22:29:55 -0700 (PDT)
X-Received: by 2002:a17:903:2c0d:b0:2df:8513:882 with SMTP id
 d9443c01a7336-2df85130a8bmr110888155ad.62.1790659795117; Mon, 28 Sep 2026
 22:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260928130228.877003-1-pbonzini@redhat.com>
 <20260928130228.877003-7-pbonzini@redhat.com>
 <CAGscdFvd5kzKM4DbkCm3EsBNTr5vmk6nCfQCP=bzTkZn+tcWdA@mail.gmail.com>
In-Reply-To: <CAGscdFvd5kzKM4DbkCm3EsBNTr5vmk6nCfQCP=bzTkZn+tcWdA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Sep 2026 07:29:36 +0200
X-Gm-Features: AclHuK9N4m3qiTGbhD6BNIRD2DuvHU7Yb_u9cjzYnDf7mjPC2rJUHmuP_FEB8As
Message-ID: <CABgObfa9ZucyDLFtfv+ShrKNq4uAD8YwUfJe+TYpYR2Rf4J5Lw@mail.gmail.com>
Subject: Re: [PULL 06/30] target/i386/tcg: ignore VEX.L for unary scalar
 instructions
To: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000007f38065c987947"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

--000000000000007f38065c987947
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 29 set 2026, 04:22 Andrey Polivoda <apolivodaa433@gmail.com> ha
scritto:

> Hi Paolo,
>
> In its current form, this patch makes VROUNDSS (and possibly other
> instructions) use 256-bit operand size when VEX.L=3D1
>

Thanks for the test case. I will take a look. The ordering of
validate_vex() and decode_op_*() is tricky, I should fix it once and for
all...

Paolo

This happens because the operand sizes are set in `decode_op_size()`,
> which is called in `decode_insn()`
>
> `decode_op_size()` reaches the code below (irrelevant parts of pwndbg
> UI are omitted):
> ```
> pwndbg> set $decode=3D&decode
> pwndbg> watch $decode->op[0].ot
> Hardware watchpoint 3: $decode->op[0].ot
> pwndbg> c
> Continuing.
>
> Thread 1 hit Hardware watchpoint 3: $decode->op[0].ot
>
> Old value =3D MO_8
> New value =3D MO_256
> decode_op_size (s=3D0x7b1a3af02020, e=3D0x7b1a3ae08e20, size=3DX86_SIZE_x=
,
> ot=3D0x7b1a3ae08e44) at ../target/i386/tcg/decode-new.c.inc:2289
> 2289            return true;
> =3D> 0x000055e7af160d5a <decode_op_size+4186>:    c6 45 ff 01
>  mov    BYTE PTR [rbp-0x1],0x1
>    0x000055e7af160d5e <decode_op_size+4190>:    e9 91 04 00 00
>  jmp    0x55e7af1611f4 <decode_op_size+5364>
> ...
> =E2=94=80[ SOURCE (CODE) ]=E2=94=80
> In file: .../QEMU/target/i386/tcg/decode-new.c.inc:2289
>    2283             return true;
>    2284         }
>    2285         /* fall through */
>    2286     case X86_SIZE_ps: /* SSE/AVX packed single precision */
>    2287     case X86_SIZE_pd: /* SSE/AVX packed double precision */
>    2288         *ot =3D s->vex_l ? MO_256 : MO_128;
>  =E2=96=BA 2289         return true;
>    2290
>    2291     case X86_SIZE_xh: /* SSE/AVX packed half register */
>    2292         *ot =3D s->vex_l ? MO_128 : MO_64;
>    2293         return true;
>    2294
>    2295     case X86_SIZE_d64:  /* Default to 64-bit in 64-bit mode */
>    2296         *ot =3D CODE64(s) && s->dflag =3D=3D MO_32 ? MO_64 : s->d=
flag;
> ...
> =E2=94=80[ BACKTRACE ]=E2=94=80
>  =E2=96=BA 0 0x55e7af160d5a decode_op_size+4186
>    1 0x55e7af0b6598 decode_insn+1288
>    2 0x55e7af0b1edd disas_insn+14861
>    3 0x55e7af0ac8a9 i386_tr_translate_insn+1385
>    4 0x55e7aed5a57d translator_loop+5261
>    5 0x55e7af0a99d4 x86_translate_code+500
>    6 0x55e7aed56cdc setjmp_gen_code+1052
>    7 0x55e7aed53f45 tb_gen_code+4933
> ...
> pwndbg> p s->vex_l
> $5 =3D 0x1
> pwndbg>
> ```
>
> Then `validate_vex()` is called, which sets the `s->vex_l` to 0. But
> by the time it is called, it is already too late:
> ```
> pwndbg> set $s=3Ds
> pwndbg> watch $s->vex_l
> Hardware watchpoint 4: $s->vex_l
> pwndbg> c
> Continuing.
>
> Thread 1 hit Hardware watchpoint 4: $s->vex_l
>
> Old value =3D 0x1
> New value =3D 0x0
> validate_vex (s=3D0x7b1a3af02020, decode=3D0x7b1a3ae08e20) at
> ../target/i386/tcg/decode-new.c.inc:2889
> 2889            break;
> =3D> 0x000055e7af0ba0ad <validate_vex+1645>:      e9 69 0a 00 00
>  jmp    0x55e7af0bab1b <validate_vex+4315>
> ...
> =E2=94=80[ SOURCE (CODE) ]=E2=94=80
> In file: /home/user/Projects/QEMU/target/i386/tcg/decode-new.c.inc:2889
>    2883     switch (e->vex_special) {
>    2884     case X86_VEX_None:
>    2885         break;
>    2886
>    2887     case X86_VEX_LIG:
>    2888         s->vex_l =3D 0;
>  =E2=96=BA 2889         break;
>    2890
>    2891     case X86_VEX_REPScalar:
>    2892         /*
>    2893          * Instructions which differ between 00/66 and F2/F3 in t=
he
>    2894          * exception classification and the size of the memory
> operand.
>    2895          */
>    2896         assert(e->vex_class =3D=3D 1 || e->vex_class =3D=3D 2 ||
> e->vex_class =3D=3D 4);
> ...
> =E2=94=80[ BACKTRACE ]=E2=94=80
>  =E2=96=BA 0 0x55e7af0ba0ad validate_vex+1645
>    1 0x55e7af0b2948 disas_insn+17528
>    2 0x55e7af0ac8a9 i386_tr_translate_insn+1385
>    3 0x55e7aed5a57d translator_loop+5261
>    4 0x55e7af0a99d4 x86_translate_code+500
>    5 0x55e7aed56cdc setjmp_gen_code+1052
>    6 0x55e7aed53f45 tb_gen_code+4933
>    7 0x55e7aed294da cpu_exec_loop+1738
> ...
> pwndbg> p *decode
> $6 =3D {
>   e =3D {
>     {
>       gen =3D 0x55e7af15a3b0 <gen_VROUNDSS>,
>       decode =3D 0x55e7af15a3b0 <gen_VROUNDSS>
>     },
>     op0 =3D X86_TYPE_V,
>     s0 =3D X86_SIZE_x,
>     op1 =3D X86_TYPE_H,
>     s1 =3D X86_SIZE_x,
>     op2 =3D X86_TYPE_W,
>     s2 =3D X86_SIZE_ss,
>     op3 =3D X86_TYPE_I,
>     s3 =3D X86_SIZE_b,
>     special =3D X86_SPECIAL_None,
>     ext0 =3D X86_EXT_None,
>     ext1 =3D X86_EXT_None,
>     ext2 =3D X86_EXT_None,
>     cpuid =3D X86_FEAT_SSE41,
>     vex_class =3D 0x3,
>     vex_special =3D X86_VEX_LIG,
>     valid_prefix =3D 0x100,
>     check =3D 0x0,
>     intercept =3D 0x0,
>     has_intercept =3D 0x0,
>     is_decode =3D 0x0
>   },
>   op =3D {{
>       n =3D 0x0,
>       ot =3D MO_256,
>       unit =3D X86_OP_SKIP,
>       ext =3D X86_EXT_None,
>       has_ea =3D 0x0,
>       offset =3D 0x0,
>       {
>         imm =3D 0x0,
>         v_ptr =3D 0x0
>       }
>     }, {
>       n =3D 0x0,
>       ot =3D MO_256,
>       unit =3D X86_OP_SKIP,
>       ext =3D X86_EXT_None,
>       has_ea =3D 0x0,
>       offset =3D 0x0,
>       {
>         imm =3D 0x0,
>         v_ptr =3D 0x0
>       }
>     }, {
>       n =3D 0x0,
>       ot =3D MO_32,
>       unit =3D X86_OP_SKIP,
>       ext =3D X86_EXT_None,
>       has_ea =3D 0x0,
>       offset =3D 0x0,
>       {
>         imm =3D 0x0,
>         v_ptr =3D 0x0
>       }
>     }},
>   immediate =3D 0x0,
>   mem =3D {
>     def_seg =3D 0x0,
>     base =3D 0x0,
>     index =3D 0x0,
>     scale =3D 0x0,
>     disp =3D 0x0
>   },
>   cc_dst =3D 0x0,
>   cc_src =3D 0x0,
>   cc_src2 =3D 0x0,
>   cc_op_dynamic =3D 0x0,
>   cc_op =3D 0xff,
>   b =3D 0xa
> }
> pwndbg> p s->pc_save
> $7 =3D 0x201194
> pwndbg> x/i s->pc_save
>    0x201194:    vroundss xmm0,xmm0,xmm1,0x0
> pwndbg> x/6xb s->pc_save
> 0x201194:       0xc4    0xe3    0xfd    0x0a    0xc1    0x00
> pwndbg>
> ```
>
> Since the operand size is already set to `MO_256`, that size will
> eventually be used by the TCG frontend. This is seen in the TCG ops
> dump (annotated a little for better readability):
> ```
> $ .../QEMU/build_asan_ubsan_dbg/qemu-x86_64 -d in_asm,op
> --one-insn-per-tb ./vroundss_test
> ...
> # VEX.L =3D 0
> ----------------
> IN:
> 0x0020117a:  c4 e3 f9 0a c1 00        vroundss $0, %xmm1, %xmm0, %xmm0
>
> OP:
>  ld_i32 loc3,env,$0xffffffffffffffec
>  brcond_i32 loc3,$0x0,lt,$L0
>
>  ---- 000000000020117a 000000000000003c 0000000000000000
>  add_i64 loc5,env,$0x3c0
>  add_i64 loc7,env,$0x3c0
>  add_i64 loc8,env,$0x400
>  call roundss_xmm,$0x0,$0,env,loc5,loc7,loc8,$0x0
> # v128 ops present in VEX.L =3D 0 case!
> mov_vec v128,e8,tmp10,v128$0x0
> st_vec v128,e8,tmp10,env,$0x3d0
>  mov_i64 rip,$0x201180
>  exit_tb $0x0
>  set_label $L0
>  exit_tb $0x7b1a30a003c3
> ...
> # VEX.L =3D 1
> ----------------
> IN:
> 0x00201194:  c4 e3 fd 0a c1 00        vroundss $0, %xmm1, %xmm0, %xmm0
>
> OP:
>  ld_i32 loc3,env,$0xffffffffffffffec
>  brcond_i32 loc3,$0x0,lt,$L0
>
>  ---- 0000000000201194 000000000000003c 0000000000000000
>  add_i64 loc5,env,$0x3c0
>  add_i64 loc7,env,$0x3c0
>  add_i64 loc8,env,$0x400
>  call roundss_xmm,$0x0,$0,env,loc5,loc7,loc8,$0x0
> # No v128 ops in VEX.L =3D 1 case!
>  mov_i64 rip,$0x20119a
>  exit_tb $0x0
>  set_label $L0
>  exit_tb $0x7b1a30a00883
> ...
> ----------------
> IN:
> 0x002011bf:  f4                       hlt
>
> OP:
>  ld_i32 loc3,env,$0xffffffffffffffec
>  brcond_i32 loc3,$0x0,lt,$L0
>
>  ---- 00000000002011bf 000000000000003c 0000000000000000
>  mov_i64 rip,$0x2011bf
>  call raise_exception,$0xa,$0,env,$0xd
>  set_label $L0
>  exit_tb $0x7b1a30a01003
>
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> ```
>
> Test binary source below:
> ```nasm
> bits 64
> default rel
>
> global _start
> _start:
> mov dword [rounding_mode], 0x40200000
>
> vmovups ymm0, [garbage]
> vmovups ymm1, [rounding_mode]
> ; VEX.L =3D 0
> db 0xc4, 0xe3, 0xf9, 0x0a, 0xc1, 0x00
> vmovups ymm3, ymm0
>
> vmovups ymm0, [garbage]
> vmovups ymm1, [rounding_mode]
> ; VEX.L =3D 1
> db 0xc4, 0xe3, 0xfd, 0x0a, 0xc1, 0x00
>
> vmovups [out_vex_l_0], ymm3
> vmovups [out_vex_l_1], ymm0
>
> vpxor ymm2, ymm0, ymm3
> vptest ymm2, ymm2
> jnz .bug_detected
>
> mov rax, 60
> xor rdi, rdi
> syscall
>
> .bug_detected:
> hlt
>
> section .data
> align 32
> garbage: times 32 db 0xAA
> rounding_mode: times 32 db 0xBB
>
> out_vex_l_0: times 32 db 0xff
> out_vex_l_1: times 32 db 0xff
> ```
> ```
> $ nasm -f elf64 vroundss_test.asm
> $ ld.lld -o vroundss_test vroundss_test.o
> ```
>
> And here are the results in the `out_vex_l_0` and `out_vex_l_1`:
> ```
> $ .../QEMU/build_asan_ubsan_dbg/qemu-x86_64 -d in_asm,op
> --one-insn-per-tb -g 1234 ./vroundss_test
> ```
> ```
> pwndbg> x/i $pc
> =3D> 0x2011b3 <_start+83>:        jne    0x2011bf <_start.bug_detected>
> pwndbg> info r eflags
> eflags         0x203               [ IOPL=3D0 IF CF ]
> pwndbg> x/32xb &out_vex_l_0
> 0x202200:       0x00    0x00    0x00    0x40    0xaa    0xaa    0xaa
> 0xaa
> 0x202208:       0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xaa
> 0xaa
> 0x202210:       0x00    0x00    0x00    0x00    0x00    0x00    0x00
> 0x00
> 0x202218:       0x00    0x00    0x00    0x00    0x00    0x00    0x00
> 0x00
> pwndbg> x/32xb &out_vex_l_1
> 0x202220:       0x00    0x00    0x00    0x40    0xaa    0xaa    0xaa
> 0xaa
> 0x202228:       0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xaa
> 0xaa
> 0x202230:       0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xaa
> 0xaa
> 0x202238:       0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xaa
> 0xaa
> pwndbg>
> ```
>
> (Sorry for the late response, got burned out a little recently. Still,
> couldn't let this issue go into the upstream unnoticed)
>
>

--000000000000007f38065c987947
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 29 set 2026, 04:22 Andrey Polivoda &lt;<a href=
=3D"mailto:apolivodaa433@gmail.com" target=3D"_blank" rel=3D"noreferrer">ap=
olivodaa433@gmail.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Hi Paolo,<br>
<br>
In its current form, this patch makes VROUNDSS (and possibly other<br>
instructions) use 256-bit operand size when VEX.L=3D1<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks for the test ca=
se. I will take a look. The ordering of validate_vex() and decode_op_*() is=
 tricky, I should fix it once and for all...</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
This happens because the operand sizes are set in `decode_op_size()`,<br>
which is called in `decode_insn()`<br>
<br>
`decode_op_size()` reaches the code below (irrelevant parts of pwndbg<br>
UI are omitted):<br>
```<br>
pwndbg&gt; set $decode=3D&amp;decode<br>
pwndbg&gt; watch $decode-&gt;op[0].ot<br>
Hardware watchpoint 3: $decode-&gt;op[0].ot<br>
pwndbg&gt; c<br>
Continuing.<br>
<br>
Thread 1 hit Hardware watchpoint 3: $decode-&gt;op[0].ot<br>
<br>
Old value =3D MO_8<br>
New value =3D MO_256<br>
decode_op_size (s=3D0x7b1a3af02020, e=3D0x7b1a3ae08e20, size=3DX86_SIZE_x,<=
br>
ot=3D0x7b1a3ae08e44) at ../target/i386/tcg/decode-new.c.inc:2289<br>
2289=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=3D&gt; 0x000055e7af160d5a &lt;decode_op_size+4186&gt;:=C2=A0 =C2=A0 c6 45 =
ff 01<br>
=C2=A0mov=C2=A0 =C2=A0 BYTE PTR [rbp-0x1],0x1<br>
=C2=A0 =C2=A00x000055e7af160d5e &lt;decode_op_size+4190&gt;:=C2=A0 =C2=A0 e=
9 91 04 00 00<br>
=C2=A0jmp=C2=A0 =C2=A0 0x55e7af1611f4 &lt;decode_op_size+5364&gt;<br>
...<br>
=E2=94=80[ SOURCE (CODE) ]=E2=94=80<br>
In file: .../QEMU/target/i386/tcg/decode-new.c.inc:2289<br>
=C2=A0 =C2=A02283=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return tru=
e;<br>
=C2=A0 =C2=A02284=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A02285=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>
=C2=A0 =C2=A02286=C2=A0 =C2=A0 =C2=A0case X86_SIZE_ps: /* SSE/AVX packed si=
ngle precision */<br>
=C2=A0 =C2=A02287=C2=A0 =C2=A0 =C2=A0case X86_SIZE_pd: /* SSE/AVX packed do=
uble precision */<br>
=C2=A0 =C2=A02288=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ot =3D s-&gt;vex_l ? MO=
_256 : MO_128;<br>
=C2=A0=E2=96=BA 2289=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A02290<br>
=C2=A0 =C2=A02291=C2=A0 =C2=A0 =C2=A0case X86_SIZE_xh: /* SSE/AVX packed ha=
lf register */<br>
=C2=A0 =C2=A02292=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ot =3D s-&gt;vex_l ? MO=
_128 : MO_64;<br>
=C2=A0 =C2=A02293=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A02294<br>
=C2=A0 =C2=A02295=C2=A0 =C2=A0 =C2=A0case X86_SIZE_d64:=C2=A0 /* Default to=
 64-bit in 64-bit mode */<br>
=C2=A0 =C2=A02296=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ot =3D CODE64(s) &amp;&=
amp; s-&gt;dflag =3D=3D MO_32 ? MO_64 : s-&gt;dflag;<br>
...<br>
=E2=94=80[ BACKTRACE ]=E2=94=80<br>
=C2=A0=E2=96=BA 0 0x55e7af160d5a decode_op_size+4186<br>
=C2=A0 =C2=A01 0x55e7af0b6598 decode_insn+1288<br>
=C2=A0 =C2=A02 0x55e7af0b1edd disas_insn+14861<br>
=C2=A0 =C2=A03 0x55e7af0ac8a9 i386_tr_translate_insn+1385<br>
=C2=A0 =C2=A04 0x55e7aed5a57d translator_loop+5261<br>
=C2=A0 =C2=A05 0x55e7af0a99d4 x86_translate_code+500<br>
=C2=A0 =C2=A06 0x55e7aed56cdc setjmp_gen_code+1052<br>
=C2=A0 =C2=A07 0x55e7aed53f45 tb_gen_code+4933<br>
...<br>
pwndbg&gt; p s-&gt;vex_l<br>
$5 =3D 0x1<br>
pwndbg&gt;<br>
```<br>
<br>
Then `validate_vex()` is called, which sets the `s-&gt;vex_l` to 0. But<br>
by the time it is called, it is already too late:<br>
```<br>
pwndbg&gt; set $s=3Ds<br>
pwndbg&gt; watch $s-&gt;vex_l<br>
Hardware watchpoint 4: $s-&gt;vex_l<br>
pwndbg&gt; c<br>
Continuing.<br>
<br>
Thread 1 hit Hardware watchpoint 4: $s-&gt;vex_l<br>
<br>
Old value =3D 0x1<br>
New value =3D 0x0<br>
validate_vex (s=3D0x7b1a3af02020, decode=3D0x7b1a3ae08e20) at<br>
../target/i386/tcg/decode-new.c.inc:2889<br>
2889=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=3D&gt; 0x000055e7af0ba0ad &lt;validate_vex+1645&gt;:=C2=A0 =C2=A0 =C2=A0 e=
9 69 0a 00 00<br>
=C2=A0jmp=C2=A0 =C2=A0 0x55e7af0bab1b &lt;validate_vex+4315&gt;<br>
...<br>
=E2=94=80[ SOURCE (CODE) ]=E2=94=80<br>
In file: /home/user/Projects/QEMU/target/i386/tcg/decode-new.c.inc:2889<br>
=C2=A0 =C2=A02883=C2=A0 =C2=A0 =C2=A0switch (e-&gt;vex_special) {<br>
=C2=A0 =C2=A02884=C2=A0 =C2=A0 =C2=A0case X86_VEX_None:<br>
=C2=A0 =C2=A02885=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A02886<br>
=C2=A0 =C2=A02887=C2=A0 =C2=A0 =C2=A0case X86_VEX_LIG:<br>
=C2=A0 =C2=A02888=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;vex_l =3D 0;<br>
=C2=A0=E2=96=BA 2889=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A02890<br>
=C2=A0 =C2=A02891=C2=A0 =C2=A0 =C2=A0case X86_VEX_REPScalar:<br>
=C2=A0 =C2=A02892=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A02893=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Instructions which di=
ffer between 00/66 and F2/F3 in the<br>
=C2=A0 =C2=A02894=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * exception classificat=
ion and the size of the memory operand.<br>
=C2=A0 =C2=A02895=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A02896=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(e-&gt;vex_class =
=3D=3D 1 || e-&gt;vex_class =3D=3D 2 ||<br>
e-&gt;vex_class =3D=3D 4);<br>
...<br>
=E2=94=80[ BACKTRACE ]=E2=94=80<br>
=C2=A0=E2=96=BA 0 0x55e7af0ba0ad validate_vex+1645<br>
=C2=A0 =C2=A01 0x55e7af0b2948 disas_insn+17528<br>
=C2=A0 =C2=A02 0x55e7af0ac8a9 i386_tr_translate_insn+1385<br>
=C2=A0 =C2=A03 0x55e7aed5a57d translator_loop+5261<br>
=C2=A0 =C2=A04 0x55e7af0a99d4 x86_translate_code+500<br>
=C2=A0 =C2=A05 0x55e7aed56cdc setjmp_gen_code+1052<br>
=C2=A0 =C2=A06 0x55e7aed53f45 tb_gen_code+4933<br>
=C2=A0 =C2=A07 0x55e7aed294da cpu_exec_loop+1738<br>
...<br>
pwndbg&gt; p *decode<br>
$6 =3D {<br>
=C2=A0 e =3D {<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 gen =3D 0x55e7af15a3b0 &lt;gen_VROUNDSS&gt;,<br>
=C2=A0 =C2=A0 =C2=A0 decode =3D 0x55e7af15a3b0 &lt;gen_VROUNDSS&gt;<br>
=C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 op0 =3D X86_TYPE_V,<br>
=C2=A0 =C2=A0 s0 =3D X86_SIZE_x,<br>
=C2=A0 =C2=A0 op1 =3D X86_TYPE_H,<br>
=C2=A0 =C2=A0 s1 =3D X86_SIZE_x,<br>
=C2=A0 =C2=A0 op2 =3D X86_TYPE_W,<br>
=C2=A0 =C2=A0 s2 =3D X86_SIZE_ss,<br>
=C2=A0 =C2=A0 op3 =3D X86_TYPE_I,<br>
=C2=A0 =C2=A0 s3 =3D X86_SIZE_b,<br>
=C2=A0 =C2=A0 special =3D X86_SPECIAL_None,<br>
=C2=A0 =C2=A0 ext0 =3D X86_EXT_None,<br>
=C2=A0 =C2=A0 ext1 =3D X86_EXT_None,<br>
=C2=A0 =C2=A0 ext2 =3D X86_EXT_None,<br>
=C2=A0 =C2=A0 cpuid =3D X86_FEAT_SSE41,<br>
=C2=A0 =C2=A0 vex_class =3D 0x3,<br>
=C2=A0 =C2=A0 vex_special =3D X86_VEX_LIG,<br>
=C2=A0 =C2=A0 valid_prefix =3D 0x100,<br>
=C2=A0 =C2=A0 check =3D 0x0,<br>
=C2=A0 =C2=A0 intercept =3D 0x0,<br>
=C2=A0 =C2=A0 has_intercept =3D 0x0,<br>
=C2=A0 =C2=A0 is_decode =3D 0x0<br>
=C2=A0 },<br>
=C2=A0 op =3D {{<br>
=C2=A0 =C2=A0 =C2=A0 n =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 ot =3D MO_256,<br>
=C2=A0 =C2=A0 =C2=A0 unit =3D X86_OP_SKIP,<br>
=C2=A0 =C2=A0 =C2=A0 ext =3D X86_EXT_None,<br>
=C2=A0 =C2=A0 =C2=A0 has_ea =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 offset =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 v_ptr =3D 0x0<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }, {<br>
=C2=A0 =C2=A0 =C2=A0 n =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 ot =3D MO_256,<br>
=C2=A0 =C2=A0 =C2=A0 unit =3D X86_OP_SKIP,<br>
=C2=A0 =C2=A0 =C2=A0 ext =3D X86_EXT_None,<br>
=C2=A0 =C2=A0 =C2=A0 has_ea =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 offset =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 v_ptr =3D 0x0<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }, {<br>
=C2=A0 =C2=A0 =C2=A0 n =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 ot =3D MO_32,<br>
=C2=A0 =C2=A0 =C2=A0 unit =3D X86_OP_SKIP,<br>
=C2=A0 =C2=A0 =C2=A0 ext =3D X86_EXT_None,<br>
=C2=A0 =C2=A0 =C2=A0 has_ea =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 offset =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 imm =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 v_ptr =3D 0x0<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }},<br>
=C2=A0 immediate =3D 0x0,<br>
=C2=A0 mem =3D {<br>
=C2=A0 =C2=A0 def_seg =3D 0x0,<br>
=C2=A0 =C2=A0 base =3D 0x0,<br>
=C2=A0 =C2=A0 index =3D 0x0,<br>
=C2=A0 =C2=A0 scale =3D 0x0,<br>
=C2=A0 =C2=A0 disp =3D 0x0<br>
=C2=A0 },<br>
=C2=A0 cc_dst =3D 0x0,<br>
=C2=A0 cc_src =3D 0x0,<br>
=C2=A0 cc_src2 =3D 0x0,<br>
=C2=A0 cc_op_dynamic =3D 0x0,<br>
=C2=A0 cc_op =3D 0xff,<br>
=C2=A0 b =3D 0xa<br>
}<br>
pwndbg&gt; p s-&gt;pc_save<br>
$7 =3D 0x201194<br>
pwndbg&gt; x/i s-&gt;pc_save<br>
=C2=A0 =C2=A00x201194:=C2=A0 =C2=A0 vroundss xmm0,xmm0,xmm1,0x0<br>
pwndbg&gt; x/6xb s-&gt;pc_save<br>
0x201194:=C2=A0 =C2=A0 =C2=A0 =C2=A00xc4=C2=A0 =C2=A0 0xe3=C2=A0 =C2=A0 0xf=
d=C2=A0 =C2=A0 0x0a=C2=A0 =C2=A0 0xc1=C2=A0 =C2=A0 0x00<br>
pwndbg&gt;<br>
```<br>
<br>
Since the operand size is already set to `MO_256`, that size will<br>
eventually be used by the TCG frontend. This is seen in the TCG ops<br>
dump (annotated a little for better readability):<br>
```<br>
$ .../QEMU/build_asan_ubsan_dbg/qemu-x86_64 -d in_asm,op<br>
--one-insn-per-tb ./vroundss_test<br>
...<br>
# VEX.L =3D 0<br>
----------------<br>
IN:<br>
0x0020117a:=C2=A0 c4 e3 f9 0a c1 00=C2=A0 =C2=A0 =C2=A0 =C2=A0 vroundss $0,=
 %xmm1, %xmm0, %xmm0<br>
<br>
OP:<br>
=C2=A0ld_i32 loc3,env,$0xffffffffffffffec<br>
=C2=A0brcond_i32 loc3,$0x0,lt,$L0<br>
<br>
=C2=A0---- 000000000020117a 000000000000003c 0000000000000000<br>
=C2=A0add_i64 loc5,env,$0x3c0<br>
=C2=A0add_i64 loc7,env,$0x3c0<br>
=C2=A0add_i64 loc8,env,$0x400<br>
=C2=A0call roundss_xmm,$0x0,$0,env,loc5,loc7,loc8,$0x0<br>
# v128 ops present in VEX.L =3D 0 case!<br>
mov_vec v128,e8,tmp10,v128$0x0<br>
st_vec v128,e8,tmp10,env,$0x3d0<br>
=C2=A0mov_i64 rip,$0x201180<br>
=C2=A0exit_tb $0x0<br>
=C2=A0set_label $L0<br>
=C2=A0exit_tb $0x7b1a30a003c3<br>
...<br>
# VEX.L =3D 1<br>
----------------<br>
IN:<br>
0x00201194:=C2=A0 c4 e3 fd 0a c1 00=C2=A0 =C2=A0 =C2=A0 =C2=A0 vroundss $0,=
 %xmm1, %xmm0, %xmm0<br>
<br>
OP:<br>
=C2=A0ld_i32 loc3,env,$0xffffffffffffffec<br>
=C2=A0brcond_i32 loc3,$0x0,lt,$L0<br>
<br>
=C2=A0---- 0000000000201194 000000000000003c 0000000000000000<br>
=C2=A0add_i64 loc5,env,$0x3c0<br>
=C2=A0add_i64 loc7,env,$0x3c0<br>
=C2=A0add_i64 loc8,env,$0x400<br>
=C2=A0call roundss_xmm,$0x0,$0,env,loc5,loc7,loc8,$0x0<br>
# No v128 ops in VEX.L =3D 1 case!<br>
=C2=A0mov_i64 rip,$0x20119a<br>
=C2=A0exit_tb $0x0<br>
=C2=A0set_label $L0<br>
=C2=A0exit_tb $0x7b1a30a00883<br>
...<br>
----------------<br>
IN:<br>
0x002011bf:=C2=A0 f4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0hlt<br>
<br>
OP:<br>
=C2=A0ld_i32 loc3,env,$0xffffffffffffffec<br>
=C2=A0brcond_i32 loc3,$0x0,lt,$L0<br>
<br>
=C2=A0---- 00000000002011bf 000000000000003c 0000000000000000<br>
=C2=A0mov_i64 rip,$0x2011bf<br>
=C2=A0call raise_exception,$0xa,$0,env,$0xd<br>
=C2=A0set_label $L0<br>
=C2=A0exit_tb $0x7b1a30a01003<br>
<br>
qemu: uncaught target signal 11 (Segmentation fault) - core dumped<br>
```<br>
<br>
Test binary source below:<br>
```nasm<br>
bits 64<br>
default rel<br>
<br>
global _start<br>
_start:<br>
mov dword [rounding_mode], 0x40200000<br>
<br>
vmovups ymm0, [garbage]<br>
vmovups ymm1, [rounding_mode]<br>
; VEX.L =3D 0<br>
db 0xc4, 0xe3, 0xf9, 0x0a, 0xc1, 0x00<br>
vmovups ymm3, ymm0<br>
<br>
vmovups ymm0, [garbage]<br>
vmovups ymm1, [rounding_mode]<br>
; VEX.L =3D 1<br>
db 0xc4, 0xe3, 0xfd, 0x0a, 0xc1, 0x00<br>
<br>
vmovups [out_vex_l_0], ymm3<br>
vmovups [out_vex_l_1], ymm0<br>
<br>
vpxor ymm2, ymm0, ymm3<br>
vptest ymm2, ymm2<br>
jnz .bug_detected<br>
<br>
mov rax, 60<br>
xor rdi, rdi<br>
syscall<br>
<br>
.bug_detected:<br>
hlt<br>
<br>
section .data<br>
align 32<br>
garbage: times 32 db 0xAA<br>
rounding_mode: times 32 db 0xBB<br>
<br>
out_vex_l_0: times 32 db 0xff<br>
out_vex_l_1: times 32 db 0xff<br>
```<br>
```<br>
$ nasm -f elf64 vroundss_test.asm<br>
$ ld.lld -o vroundss_test vroundss_test.o<br>
```<br>
<br>
And here are the results in the `out_vex_l_0` and `out_vex_l_1`:<br>
```<br>
$ .../QEMU/build_asan_ubsan_dbg/qemu-x86_64 -d in_asm,op<br>
--one-insn-per-tb -g 1234 ./vroundss_test<br>
```<br>
```<br>
pwndbg&gt; x/i $pc<br>
=3D&gt; 0x2011b3 &lt;_start+83&gt;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 jne=C2=A0 =
=C2=A0 0x2011bf &lt;_start.bug_detected&gt;<br>
pwndbg&gt; info r eflags<br>
eflags=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x203=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0[ IOPL=3D0 IF CF ]<br>
pwndbg&gt; x/32xb &amp;out_vex_l_0<br>
0x202200:=C2=A0 =C2=A0 =C2=A0 =C2=A00x00=C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 0x0=
0=C2=A0 =C2=A0 0x40=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=
=C2=A0 =C2=A0 0xaa<br>
0x202208:=C2=A0 =C2=A0 =C2=A0 =C2=A00xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xa=
a=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=
=C2=A0 =C2=A0 0xaa<br>
0x202210:=C2=A0 =C2=A0 =C2=A0 =C2=A00x00=C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 0x0=
0=C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 0x00=
=C2=A0 =C2=A0 0x00<br>
0x202218:=C2=A0 =C2=A0 =C2=A0 =C2=A00x00=C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 0x0=
0=C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 0x00=
=C2=A0 =C2=A0 0x00<br>
pwndbg&gt; x/32xb &amp;out_vex_l_1<br>
0x202220:=C2=A0 =C2=A0 =C2=A0 =C2=A00x00=C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 0x0=
0=C2=A0 =C2=A0 0x40=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=
=C2=A0 =C2=A0 0xaa<br>
0x202228:=C2=A0 =C2=A0 =C2=A0 =C2=A00xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xa=
a=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=
=C2=A0 =C2=A0 0xaa<br>
0x202230:=C2=A0 =C2=A0 =C2=A0 =C2=A00xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xa=
a=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=
=C2=A0 =C2=A0 0xaa<br>
0x202238:=C2=A0 =C2=A0 =C2=A0 =C2=A00xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xa=
a=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=C2=A0 =C2=A0 0xaa=
=C2=A0 =C2=A0 0xaa<br>
pwndbg&gt;<br>
```<br>
<br>
(Sorry for the late response, got burned out a little recently. Still,<br>
couldn&#39;t let this issue go into the upstream unnoticed)<br>
<br>
</blockquote></div></div></div>

--000000000000007f38065c987947--


