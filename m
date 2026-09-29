Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF618CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 02:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBNUB-0003Az-AD; Mon, 28 Sep 2026 22:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xBNU8-0003AW-MF
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 22:22:24 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xBNU6-0002mh-J9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 22:22:24 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-13fc403e373so515773c88.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 19:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790648540; cv=none;
 d=google.com; s=arc-20260327;
 b=Np3dtHrsglu0/BiEZ56dOsiAI/FlIQ0pt2+gUJHzTzpGpmZtDl9h8XskXtcm1trBsH
 953dP2+YVdS3AtS81IP3QzQ79fJh2PRUoq4kMpaImKGoWvPBpOHZ0Z8MkuPa/9LEdUWp
 ciNXyui96zQqIzIawvc1adHcuN0awJeDlRGVoIfC5xXGQA44YQiZIIaj7eMFwDePJmlc
 bHseaiAcyBljpxuIWn9LLZEJ47Klv0QMpFNFXWZBTSOu8oW8EKmppGdAgs0A7K/x/NZh
 +BuvxnOkjdXEmJL7WrJrQQUNFrQPE0op2rQyOi3wBgTwH3M8/gSSHEX9MmvrTRo58pL+
 olUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Glv5NLTQubEYktMeZJbosgRjn3g9PFPONh5X9c7EHJ4=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=qclRgCsPNc2Ox25M4zRPQgTUYEZPGfWTHn03fId/rutdZUIl7Dw+UlndeRO/tOMFvo
 Y4lA/QWOSZXWrvHdJy8KHbhWnZs41o9COonxBXkvLZrzxNeXN0hjrRK12Jq/fyPZDJEC
 bdoUbQ0z4wDbpPg4BVGCysgXk/uT0PZfca5cYG80RiAEp2OkI8+avBG+z9W1gkHPmxRE
 /3LNeF8LK45zRxJDopaG5Ec/6xKQ3UaXK+SFeqRjyZ3ZKElo1S/28HDn5xWK/Ktjo5PD
 VMsxFAnMBy68OqnTMnV2VMSvuFT3JK7r8eozgkoMfG98T2/BRqg2a7SYxT0DujCvecxh
 HY/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790648540; x=1791253340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Glv5NLTQubEYktMeZJbosgRjn3g9PFPONh5X9c7EHJ4=;
 b=IKs9Tf1cnirZ9CxtcqBKLgyvojj76weyVBIVBvPrxeyuHrv521d5A/cSWiSFWtrKp2
 r3BfT65KSCfQcN2HrrS+4jz3Y9VWjEDW4TwYhh56RaBxuNLr526Ek/aTPi2rWNnOvSv9
 Kra27thXb+gS9UM5dv9HnTz9J+Pz7+qewZi21KnVNKcIiryth47eAXAkwmkWPWgoRVnh
 sffFMHS4RDy1vOzKyN0i/FQ33QtdKmSfoJBHum/rcwOelCPVV/5+bq7OhlabsbdyQ6pZ
 t2qI/hG8tm1hl6h74FLwzm9nHncmOnBE45n9zdqnnL4mORTkzezsTaaFFS4Liiy19nH3
 RRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790648540; x=1791253340;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Glv5NLTQubEYktMeZJbosgRjn3g9PFPONh5X9c7EHJ4=;
 b=kTJgWloHzcc5m9glY40HoOilor0qZP/QynQ7o0pnJnOW2lHc09G7TKz7kS/dKp7z9f
 I72gyulsOb+Nmu2pbINrumPR5pqAoBRaexMYT7uyX9VtuzDQrNqnK6u8vzXVUxtrEOVi
 6Ff5VB9ETk+7KyFus14z3vJoKoQ/AkSw+iyM5QJWHNqvZQcSEWB1+E6LwTGCFT4qfDzl
 5q+9/doP33StiqUdMQJXnZjaPMc0dbTkEQTAJsSZTSe1wknGSTNPxrGRr8BkBiJfJ9pE
 Rg00rl+oFlrkFnd3gjTer9P1/u8IlhlwSAysBvXfPL5CbfA9gsdmZC/vy+HLOUeX7smZ
 Qf2g==
X-Gm-Message-State: AFuF++lJ8P9r89DMxTbD1W4mN5MhGWZXSmDW54+smvQX+4HXCQJm5X5K
 giF1Mxw1lOMzAYz9YzZzOUu/VVGiJU4GtGnmDaulOkmyBHP5Qya/kdY08qPfyUyqA4XrSFC3r0b
 fqyqJ0lZuXAiWfU08Y5aQdFY4skYFd5Q=
X-Gm-Gg: AYBFou0ocvMU8ULddIh8Z2mCca+s8dzSxhYzU14v4J71IjKSwRHM6u7jm4Pd/zoQKPy
 OefzqiF9Nv3OZZvr67xa2mbOE5uF5PQNX4AfNqiMp83dXvgIPKuOqmHnRxWq5ZuxtA63gCpEzio
 bRSTKf+hyutRQ7MIf0mXRuFAD6MdZlR74FDBQDRsd5iAcgSEhiPsLbgzK3aVH4lxY7TuPSMsh14
 BTHdyYJFyhwXZsTdPz0smCzcehzO077p75UoVLhXS85TZUUFa6mJM3KNvZGP40Vk8M36yN1uwUu
 BEnavOuJHoDCYoEkRAeXowgFfwZoM5N1A3lQtcJmQi7TWKjKhQZKJ9hD1EmnXiMjdt9B5MSU/o5
 tOqg+emNVf9E=
X-Received: by 2002:a05:7022:288:b0:13c:f65c:d5b5 with SMTP id
 a92af1059eb24-14b2b6c2a13mr1242926c88.3.1790648540099; Mon, 28 Sep 2026
 19:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260928130228.877003-1-pbonzini@redhat.com>
 <20260928130228.877003-7-pbonzini@redhat.com>
In-Reply-To: <20260928130228.877003-7-pbonzini@redhat.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Tue, 29 Sep 2026 12:22:05 +1000
X-Gm-Features: AclHuK8g4JKmGu8FUfpQq4hAGOTnsh6ncp6N0l3RppKkeVOrguCbNQXUz-UHOxw
Message-ID: <CAGscdFvd5kzKM4DbkCm3EsBNTr5vmk6nCfQCP=bzTkZn+tcWdA@mail.gmail.com>
Subject: Re: [PULL 06/30] target/i386/tcg: ignore VEX.L for unary scalar
 instructions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dl1-x1230.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Paolo,

In its current form, this patch makes VROUNDSS (and possibly other
instructions) use 256-bit operand size when VEX.L=3D1

This happens because the operand sizes are set in `decode_op_size()`,
which is called in `decode_insn()`

`decode_op_size()` reaches the code below (irrelevant parts of pwndbg
UI are omitted):
```
pwndbg> set $decode=3D&decode
pwndbg> watch $decode->op[0].ot
Hardware watchpoint 3: $decode->op[0].ot
pwndbg> c
Continuing.

Thread 1 hit Hardware watchpoint 3: $decode->op[0].ot

Old value =3D MO_8
New value =3D MO_256
decode_op_size (s=3D0x7b1a3af02020, e=3D0x7b1a3ae08e20, size=3DX86_SIZE_x,
ot=3D0x7b1a3ae08e44) at ../target/i386/tcg/decode-new.c.inc:2289
2289            return true;
=3D> 0x000055e7af160d5a <decode_op_size+4186>:    c6 45 ff 01
 mov    BYTE PTR [rbp-0x1],0x1
   0x000055e7af160d5e <decode_op_size+4190>:    e9 91 04 00 00
 jmp    0x55e7af1611f4 <decode_op_size+5364>
...
=E2=94=80[ SOURCE (CODE) ]=E2=94=80
In file: .../QEMU/target/i386/tcg/decode-new.c.inc:2289
   2283             return true;
   2284         }
   2285         /* fall through */
   2286     case X86_SIZE_ps: /* SSE/AVX packed single precision */
   2287     case X86_SIZE_pd: /* SSE/AVX packed double precision */
   2288         *ot =3D s->vex_l ? MO_256 : MO_128;
 =E2=96=BA 2289         return true;
   2290
   2291     case X86_SIZE_xh: /* SSE/AVX packed half register */
   2292         *ot =3D s->vex_l ? MO_128 : MO_64;
   2293         return true;
   2294
   2295     case X86_SIZE_d64:  /* Default to 64-bit in 64-bit mode */
   2296         *ot =3D CODE64(s) && s->dflag =3D=3D MO_32 ? MO_64 : s->dfl=
ag;
...
=E2=94=80[ BACKTRACE ]=E2=94=80
 =E2=96=BA 0 0x55e7af160d5a decode_op_size+4186
   1 0x55e7af0b6598 decode_insn+1288
   2 0x55e7af0b1edd disas_insn+14861
   3 0x55e7af0ac8a9 i386_tr_translate_insn+1385
   4 0x55e7aed5a57d translator_loop+5261
   5 0x55e7af0a99d4 x86_translate_code+500
   6 0x55e7aed56cdc setjmp_gen_code+1052
   7 0x55e7aed53f45 tb_gen_code+4933
...
pwndbg> p s->vex_l
$5 =3D 0x1
pwndbg>
```

Then `validate_vex()` is called, which sets the `s->vex_l` to 0. But
by the time it is called, it is already too late:
```
pwndbg> set $s=3Ds
pwndbg> watch $s->vex_l
Hardware watchpoint 4: $s->vex_l
pwndbg> c
Continuing.

Thread 1 hit Hardware watchpoint 4: $s->vex_l

Old value =3D 0x1
New value =3D 0x0
validate_vex (s=3D0x7b1a3af02020, decode=3D0x7b1a3ae08e20) at
../target/i386/tcg/decode-new.c.inc:2889
2889            break;
=3D> 0x000055e7af0ba0ad <validate_vex+1645>:      e9 69 0a 00 00
 jmp    0x55e7af0bab1b <validate_vex+4315>
...
=E2=94=80[ SOURCE (CODE) ]=E2=94=80
In file: /home/user/Projects/QEMU/target/i386/tcg/decode-new.c.inc:2889
   2883     switch (e->vex_special) {
   2884     case X86_VEX_None:
   2885         break;
   2886
   2887     case X86_VEX_LIG:
   2888         s->vex_l =3D 0;
 =E2=96=BA 2889         break;
   2890
   2891     case X86_VEX_REPScalar:
   2892         /*
   2893          * Instructions which differ between 00/66 and F2/F3 in the
   2894          * exception classification and the size of the memory oper=
and.
   2895          */
   2896         assert(e->vex_class =3D=3D 1 || e->vex_class =3D=3D 2 ||
e->vex_class =3D=3D 4);
...
=E2=94=80[ BACKTRACE ]=E2=94=80
 =E2=96=BA 0 0x55e7af0ba0ad validate_vex+1645
   1 0x55e7af0b2948 disas_insn+17528
   2 0x55e7af0ac8a9 i386_tr_translate_insn+1385
   3 0x55e7aed5a57d translator_loop+5261
   4 0x55e7af0a99d4 x86_translate_code+500
   5 0x55e7aed56cdc setjmp_gen_code+1052
   6 0x55e7aed53f45 tb_gen_code+4933
   7 0x55e7aed294da cpu_exec_loop+1738
...
pwndbg> p *decode
$6 =3D {
  e =3D {
    {
      gen =3D 0x55e7af15a3b0 <gen_VROUNDSS>,
      decode =3D 0x55e7af15a3b0 <gen_VROUNDSS>
    },
    op0 =3D X86_TYPE_V,
    s0 =3D X86_SIZE_x,
    op1 =3D X86_TYPE_H,
    s1 =3D X86_SIZE_x,
    op2 =3D X86_TYPE_W,
    s2 =3D X86_SIZE_ss,
    op3 =3D X86_TYPE_I,
    s3 =3D X86_SIZE_b,
    special =3D X86_SPECIAL_None,
    ext0 =3D X86_EXT_None,
    ext1 =3D X86_EXT_None,
    ext2 =3D X86_EXT_None,
    cpuid =3D X86_FEAT_SSE41,
    vex_class =3D 0x3,
    vex_special =3D X86_VEX_LIG,
    valid_prefix =3D 0x100,
    check =3D 0x0,
    intercept =3D 0x0,
    has_intercept =3D 0x0,
    is_decode =3D 0x0
  },
  op =3D {{
      n =3D 0x0,
      ot =3D MO_256,
      unit =3D X86_OP_SKIP,
      ext =3D X86_EXT_None,
      has_ea =3D 0x0,
      offset =3D 0x0,
      {
        imm =3D 0x0,
        v_ptr =3D 0x0
      }
    }, {
      n =3D 0x0,
      ot =3D MO_256,
      unit =3D X86_OP_SKIP,
      ext =3D X86_EXT_None,
      has_ea =3D 0x0,
      offset =3D 0x0,
      {
        imm =3D 0x0,
        v_ptr =3D 0x0
      }
    }, {
      n =3D 0x0,
      ot =3D MO_32,
      unit =3D X86_OP_SKIP,
      ext =3D X86_EXT_None,
      has_ea =3D 0x0,
      offset =3D 0x0,
      {
        imm =3D 0x0,
        v_ptr =3D 0x0
      }
    }},
  immediate =3D 0x0,
  mem =3D {
    def_seg =3D 0x0,
    base =3D 0x0,
    index =3D 0x0,
    scale =3D 0x0,
    disp =3D 0x0
  },
  cc_dst =3D 0x0,
  cc_src =3D 0x0,
  cc_src2 =3D 0x0,
  cc_op_dynamic =3D 0x0,
  cc_op =3D 0xff,
  b =3D 0xa
}
pwndbg> p s->pc_save
$7 =3D 0x201194
pwndbg> x/i s->pc_save
   0x201194:    vroundss xmm0,xmm0,xmm1,0x0
pwndbg> x/6xb s->pc_save
0x201194:       0xc4    0xe3    0xfd    0x0a    0xc1    0x00
pwndbg>
```

Since the operand size is already set to `MO_256`, that size will
eventually be used by the TCG frontend. This is seen in the TCG ops
dump (annotated a little for better readability):
```
$ .../QEMU/build_asan_ubsan_dbg/qemu-x86_64 -d in_asm,op
--one-insn-per-tb ./vroundss_test
...
# VEX.L =3D 0
----------------
IN:
0x0020117a:  c4 e3 f9 0a c1 00        vroundss $0, %xmm1, %xmm0, %xmm0

OP:
 ld_i32 loc3,env,$0xffffffffffffffec
 brcond_i32 loc3,$0x0,lt,$L0

 ---- 000000000020117a 000000000000003c 0000000000000000
 add_i64 loc5,env,$0x3c0
 add_i64 loc7,env,$0x3c0
 add_i64 loc8,env,$0x400
 call roundss_xmm,$0x0,$0,env,loc5,loc7,loc8,$0x0
# v128 ops present in VEX.L =3D 0 case!
mov_vec v128,e8,tmp10,v128$0x0
st_vec v128,e8,tmp10,env,$0x3d0
 mov_i64 rip,$0x201180
 exit_tb $0x0
 set_label $L0
 exit_tb $0x7b1a30a003c3
...
# VEX.L =3D 1
----------------
IN:
0x00201194:  c4 e3 fd 0a c1 00        vroundss $0, %xmm1, %xmm0, %xmm0

OP:
 ld_i32 loc3,env,$0xffffffffffffffec
 brcond_i32 loc3,$0x0,lt,$L0

 ---- 0000000000201194 000000000000003c 0000000000000000
 add_i64 loc5,env,$0x3c0
 add_i64 loc7,env,$0x3c0
 add_i64 loc8,env,$0x400
 call roundss_xmm,$0x0,$0,env,loc5,loc7,loc8,$0x0
# No v128 ops in VEX.L =3D 1 case!
 mov_i64 rip,$0x20119a
 exit_tb $0x0
 set_label $L0
 exit_tb $0x7b1a30a00883
...
----------------
IN:
0x002011bf:  f4                       hlt

OP:
 ld_i32 loc3,env,$0xffffffffffffffec
 brcond_i32 loc3,$0x0,lt,$L0

 ---- 00000000002011bf 000000000000003c 0000000000000000
 mov_i64 rip,$0x2011bf
 call raise_exception,$0xa,$0,env,$0xd
 set_label $L0
 exit_tb $0x7b1a30a01003

qemu: uncaught target signal 11 (Segmentation fault) - core dumped
```

Test binary source below:
```nasm
bits 64
default rel

global _start
_start:
mov dword [rounding_mode], 0x40200000

vmovups ymm0, [garbage]
vmovups ymm1, [rounding_mode]
; VEX.L =3D 0
db 0xc4, 0xe3, 0xf9, 0x0a, 0xc1, 0x00
vmovups ymm3, ymm0

vmovups ymm0, [garbage]
vmovups ymm1, [rounding_mode]
; VEX.L =3D 1
db 0xc4, 0xe3, 0xfd, 0x0a, 0xc1, 0x00

vmovups [out_vex_l_0], ymm3
vmovups [out_vex_l_1], ymm0

vpxor ymm2, ymm0, ymm3
vptest ymm2, ymm2
jnz .bug_detected

mov rax, 60
xor rdi, rdi
syscall

.bug_detected:
hlt

section .data
align 32
garbage: times 32 db 0xAA
rounding_mode: times 32 db 0xBB

out_vex_l_0: times 32 db 0xff
out_vex_l_1: times 32 db 0xff
```
```
$ nasm -f elf64 vroundss_test.asm
$ ld.lld -o vroundss_test vroundss_test.o
```

And here are the results in the `out_vex_l_0` and `out_vex_l_1`:
```
$ .../QEMU/build_asan_ubsan_dbg/qemu-x86_64 -d in_asm,op
--one-insn-per-tb -g 1234 ./vroundss_test
```
```
pwndbg> x/i $pc
=3D> 0x2011b3 <_start+83>:        jne    0x2011bf <_start.bug_detected>
pwndbg> info r eflags
eflags         0x203               [ IOPL=3D0 IF CF ]
pwndbg> x/32xb &out_vex_l_0
0x202200:       0x00    0x00    0x00    0x40    0xaa    0xaa    0xaa    0xa=
a
0x202208:       0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xa=
a
0x202210:       0x00    0x00    0x00    0x00    0x00    0x00    0x00    0x0=
0
0x202218:       0x00    0x00    0x00    0x00    0x00    0x00    0x00    0x0=
0
pwndbg> x/32xb &out_vex_l_1
0x202220:       0x00    0x00    0x00    0x40    0xaa    0xaa    0xaa    0xa=
a
0x202228:       0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xa=
a
0x202230:       0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xa=
a
0x202238:       0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xaa    0xa=
a
pwndbg>
```

(Sorry for the late response, got burned out a little recently. Still,
couldn't let this issue go into the upstream unnoticed)

