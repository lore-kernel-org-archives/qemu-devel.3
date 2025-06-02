Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB9DC5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 16:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM803-0006Js-Eg; Mon, 02 Jun 2025 12:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uM800-0006Je-OG
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:26:56 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uM7zy-000097-1v
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:26:56 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-604e2a2f200so8884034a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748881612; x=1749486412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/M70wWMOLr7euTg0h+F7RBl+WrpBV1/uyXUrx4OSKY=;
 b=TAMqvzqoKufTiAdmATNc5lycQeDyQw6tpVMGVoW/ghQw4Xu6B2+RK3BIJlp3plLQ1l
 lfg0thgKR+azL5Qcq0wz4TZ5JVDpT9gP0T2QozGq6c+ETMthwxNM2pExyHQTcZwN2eXS
 +MybpdUxIJ8kZ+16FTeegs/AOsMTc1lZGFOLNWyyyRlpYAnOmQrAPmHMalQg+bS6p4C8
 L6LLzWkFzjH9pylNU3gUiNVybEBaY8EzkVCzwOPtMfo2JIH0j7FXPNFPeuOtC3ZoZIVR
 d1a/KBk/hb8lKYYbUvl72LZGxzrOChHQ5uC1dcODlJNAtrcpoT6q11t6r8FTk44If73e
 Gt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748881612; x=1749486412;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6/M70wWMOLr7euTg0h+F7RBl+WrpBV1/uyXUrx4OSKY=;
 b=PFMsRvVSyP+upxTuOn/UvS1ysJtYumA+1sx49JIPl9IMhwqba6U2yw7GCQsi3UOwAm
 J/CPe7Bv4d2y8L2MWI23eEDc2Lnzzkd9xiDRm9wa5eE7+CsjtEuSoNUkScXeuScDQAYZ
 nUPUsfFzbgsg+AZ2Q9dKky4rbjznk5T/zvmKJ4d5qexQ4sXH1pz0Qe1xepRgewnfXoGK
 6j6Kx5/g4leyDiIU8wfTb/TuGF9ERqqKzXzl9jllQAACto0xfv9ZV9IojAK4ByCyit16
 tBLOvlugqwBvbl0VED9k4yLGf0/yQcb5BHNpLwx63gjF5EgDUE1QKf7A3EO+/1FYh7QI
 38gg==
X-Gm-Message-State: AOJu0YwKVF5JjupJGS6Dz781H8XxvgldSoaXGtyPhS4O34IrZq0T1mB0
 KuENZcPNc8WleoyEs0l3sHd6323skfYXnwIzcsIoESh9lf+ftZS4p3TK4EybyVlKZeQ=
X-Gm-Gg: ASbGnctXPPcrMlv80lZIFg5ly9/r9d8wDoOIqReN0YmjzUfHGwnsKcnGe+I64fu7SPh
 7U63WJtd0MOPbKr1w7GwPFOx+KeMnuIDqcUBDg7335qc8UXbeBx1OfEsfKjRCT9B6OWSQao6j+g
 AN9hgmhctZ7rbACO5TF5FNUlP/V3vv06Xmv5kIy/ePtvM5sasbAnN2mAjECS2z/HYCDtuRLyP6q
 GBud4RDQfqunEWxG2x9HwpCQ/F0k4VvHJBJjSG3dOCL/SVrcPlZEwhgyrgZh4DBQrwOcDoFJE5b
 DkMVfhi2TXY/sF7OdjRlPEGGxVohzuofBCB0C18dGJY2DS8IThQ4IE4Q4hjgWOc=
X-Google-Smtp-Source: AGHT+IEx0NUQj32oXn9QON86B3agdeZld2cMwSUpywz+VQRc5mmSUT2cjFlJ7Pakjf+RCVmXaOErcQ==
X-Received: by 2002:a05:6402:5205:b0:604:abcd:b176 with SMTP id
 4fb4d7f45d1cf-605b793e26emr8730994a12.25.1748881611569; 
 Mon, 02 Jun 2025 09:26:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c2b301sm6403594a12.15.2025.06.02.09.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 09:26:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F8E15F76F;
 Mon, 02 Jun 2025 17:26:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Wilson <jonwilson030981@googlemail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: TCG Address Sanitizer Optimization.
In-Reply-To: <CAJHT5-+tAuCoDV2G=-bZfP-j0gvY8Um-8TO8un2uNSGZpA1pcg@mail.gmail.com>
 (Jon Wilson's message of "Mon, 2 Jun 2025 16:54:16 +0100")
References: <CAJHT5-JwrQ31MEKKSNL-E0RPm+cg7UOiqzV5cPL-mnTOPa7eUA@mail.gmail.com>
 <87h60y41u1.fsf@draig.linaro.org>
 <CAJHT5-+tAuCoDV2G=-bZfP-j0gvY8Um-8TO8un2uNSGZpA1pcg@mail.gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 02 Jun 2025 17:26:49 +0100
Message-ID: <87bjr63y9i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Jon Wilson <jonwilson030981@googlemail.com> writes:

> It would be good if we could have QEMU provide clean APIs to allow the so=
rt of additional instrumentation that fuzzing
> requires. I guess the qemu-libafl-bridge project show the sort of modific=
ation which has been required so far...
> https://github.com/AFLplusplus/qemu-libafl-bridge/tree/main/libafl
>
> I would like to conditionally call a helper, or even just insert a breakp=
oint instruction, but like I say I don't seem to be able to
> make use of any sort of branches.

For TCG plugins we have:

  /**
   * qemu_plugin_register_vcpu_tb_exec_cond_cb() - register conditional cal=
lback
   * @tb: the opaque qemu_plugin_tb handle for the translation
   * @cb: callback function
   * @cond: condition to enable callback
   * @entry: first operand for condition
   * @imm: second operand for condition
   * @flags: does the plugin read or write the CPU's registers?
   * @userdata: any plugin data to pass to the @cb?
   *
   * The @cb function is called when a translated unit executes if
   * entry @cond imm is true.
   * If condition is QEMU_PLUGIN_COND_ALWAYS, condition is never interprete=
d and
   * this function is equivalent to qemu_plugin_register_vcpu_tb_exec_cb.
   * If condition QEMU_PLUGIN_COND_NEVER, condition is never interpreted and
   * callback is never installed.
   */
  QEMU_PLUGIN_API
  void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct qemu_plugin_tb *tb,
                                                 qemu_plugin_vcpu_udata_cb_=
t cb,
                                                 enum qemu_plugin_cb_flags =
flags,
                                                 enum qemu_plugin_cond cond,
                                                 qemu_plugin_u64 entry,
                                                 uint64_t imm,
                                                 void *userdata);

Along with qemu_plugin_register_vcpu_insn_exec_cond_cb() for individual
instructions. They are designed work with per-cpu indexed scoreboards
using inline operations (e.g.
qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu) which can either add
or store values.

Currently we inline memory operations are a bit limited:

  /**
   * qemu_plugin_register_vcpu_mem_inline_per_vcpu() - inline op for mem ac=
cess
   * @insn: handle for instruction to instrument
   * @rw: apply to reads, writes or both
   * @op: the op, of type qemu_plugin_op
   * @entry: entry to run op
   * @imm: immediate data for @op
   *
   * This registers a inline op every memory access generated by the
   * instruction.
   */
  QEMU_PLUGIN_API
  void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
      struct qemu_plugin_insn *insn,
      enum qemu_plugin_mem_rw rw,
      enum qemu_plugin_op op,
      qemu_plugin_u64 entry,
      uint64_t imm);

Although you can get access to the memory information through helpers:

  /**
   * qemu_plugin_register_vcpu_mem_cb() - register memory access callback
   * @insn: handle for instruction to instrument
   * @cb: callback of type qemu_plugin_vcpu_mem_cb_t
   * @flags: (currently unused) callback flags
   * @rw: monitor reads, writes or both
   * @userdata: opaque pointer for userdata
   *
   * This registers a full callback for every memory access generated by
   * an instruction. If the instruction doesn't access memory no
   * callback will be made.
   *
   * The callback reports the vCPU the access took place on, the virtual
   * address of the access and a handle for further queries. The user
   * can attach some userdata to the callback for additional purposes.
   *
   * Other execution threads will continue to execute during the
   * callback so the plugin is responsible for ensuring it doesn't get
   * confused by making appropriate use of locking if required.
   */
  QEMU_PLUGIN_API
  void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                        qemu_plugin_vcpu_mem_cb_t cb,
                                        enum qemu_plugin_cb_flags flags,
                                        enum qemu_plugin_mem_rw rw,
                                        void *userdata);

where you can then process qemu_plugin_meminfo_t info in the callback to
get the value or address of a memory operation. I guess you want some
sort of operation to do an inline transform of the address to use a
lookup to compare and branch to. The trick is coming up with an
interface which is general and flexible enough and not just "what asan
needs for a specific use case".

> Even if I add a benign instrumentation that simply conditionally branches=
 at a label and
> nothing else (e.g. no actual functionality), I still have the same proble=
m.
> e.g.
>
> /////////////////////////////////////////////////////////////////////////=
///////=20
>
> TCGLabel *done =3D gen_new_label();
> TCGv addr_val =3D temp_tcgv_tl(addr);
> TCGv zero =3D tcg_constant_tl(0);
> tcg_gen_brcond_tl(TCG_COND_EQ, addr_val, zero, done);
> gen_set_label(done);
>
> /////////////////////////////////////////////////////////////////////////=
///////=20
>
> Hence the current implementation is a little clumsy!
>
> Thanks for your advice.
>
> Jon
>
> On Mon, Jun 2, 2025 at 4:09=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>
>  Jon Wilson <jonwilson030981@googlemail.com> writes:
>
>  (Adding Richard, the TCG maintainer to CC)
>
>  > I am attempting to optimize some TCG code which I have previously writ=
ten for
>  > qemu-libafl-bridge (https://github.com/AFLplusplus/qemu-libafl-bridge)=
, the=20
>  > component used by the LibAFL project when fuzzing binaries using QEMU =
to=20
>  > provide runtime instrumentation. The code is used to write additional =
TCG into=20
>  > basic blocks whenever a load or store operation is performed in order =
to provide
>  > address sanitizer functionality.
>
>  I would like to figure out if we can push any of this instrumentation
>  into TCG plugins so you can avoid patching QEMU itself. I guess you need
>  something that allows you to hook a memory address into some sort of
>  gadget?
>
>  > Address sanitizer is quite simple and works by mapping each 8-byte reg=
ion of
>  > address space to single byte within a region called the shadow map. Th=
e address
>  > (on a 64-bit platform) of the shadow map for a given address is:
>  >
>  >     Shadow =3D (Mem >> 3) + 0x7fff8000;
>  >
>  > The value in the shadow map encodes the accessibility of an address:
>  >
>  >     0  - The whole 8 byte region is accessible.
>  >     1 .. 7 - The first n bytes are accessible.
>  >     negative - The whole 8 byte region is inaccessible.
>  >
>  > The following pseudo code shows the algorithm:
>  >
>  > //////////////////////////////////////////////////////////////////////=
//////////
>  >
>  > https://github.com/google/sanitizers/wiki/addresssanitizeralgorithm
>  >
>  > byte *shadow_address =3D MemToShadow(address);
>  > byte shadow_value =3D *shadow_address;
>  > if (shadow_value) {
>  >   if (SlowPathCheck(shadow_value, address, kAccessSize)) {
>  >     ReportError(address, kAccessSize, kIsWrite);
>  >   }
>  > }
>  >
>  > // Check the cases where we access first k bytes of the qword
>  > // and these k bytes are unpoisoned.
>  > bool SlowPathCheck(shadow_value, address, kAccessSize) {
>  >   last_accessed_byte =3D (address & 7) + kAccessSize - 1;
>  >   return (last_accessed_byte >=3D shadow_value);
>  > }
>  >
>  > //////////////////////////////////////////////////////////////////////=
//////////
>  >
>  > My current implementation makes use of conditional move instructions t=
o trigger
>  > a segfault by way of null dereference in the event that the shadow map=
 indicates
>  > that a memory access is invalid.
>  >
>  > //////////////////////////////////////////////////////////////////////=
//////////
>  >
>  > #if TARGET_LONG_BITS =3D=3D 32
>  > #define SHADOW_BASE (0x20000000)
>  > #elif TARGET_LONG_BITS =3D=3D 64
>  > #define SHADOW_BASE (0x7fff8000)
>  > #else
>  > #error Unhandled TARGET_LONG_BITS value
>  > #endif
>  >
>  > void libafl_tcg_gen_asan(TCGTemp * addr, size_t size)
>  > {
>  >     if (size =3D=3D 0)
>  >         return;
>  >
>  >     TCGv addr_val =3D temp_tcgv_tl(addr);
>  >     TCGv k =3D tcg_temp_new();
>  >     TCGv shadow_addr =3D tcg_temp_new();
>  >     TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();
>  >     TCGv shadow_val =3D tcg_temp_new();
>  >     TCGv test_addr =3D tcg_temp_new();
>  >     TCGv_ptr test_ptr =3D tcg_temp_new_ptr();
>  >
>  >     tcg_gen_andi_tl(k, addr_val, 7);
>  >     tcg_gen_addi_tl(k, k, size - 1);
>  >
>  >     tcg_gen_shri_tl(shadow_addr, addr_val, 3);
>  >     tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BASE);
>  >     tcg_gen_tl_ptr(shadow_ptr, shadow_addr);
>  >     tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);
>  >
>  >     /*
>  >      * Making conditional branches here appears to cause QEMU issues w=
ith dead
>  >      * temporaries so we will instead avoid branches.
>
>  This sounds like a TCG bug that may have been fixed.
>
>  >      We will cause the guest
>  >      * to perform a NULL dereference in the event of an ASAN fault. No=
te that
>  >      * we will do this by using a store rather than a load, since the =
TCG may
>  >      * otherwise determine that the result of the load is unused and s=
imply
>  >      * discard the operation. In the event that the shadow memory does=
n't
>  >      * detect a fault, we will simply write the value read from the sh=
adow
>  >      * memory back to it's original location. If, however, the shadow =
memory
>  >      * detects an invalid access, we will instead attempt to write the=
 value
>  >      * at 0x0.
>  >      */
>
>  Why not conditionally call a helper here? Forcing the guest to actually
>  fault seems a bit hammer like.
>
>  >     tcg_gen_movcond_tl(TCG_COND_EQ, test_addr,
>  >         shadow_val, tcg_constant_tl(0),
>  >         shadow_addr, tcg_constant_tl(0));
>  >
>  >     if (size < 8)
>  >     {
>  >         tcg_gen_movcond_tl(TCG_COND_GE, test_addr,
>  >             k, shadow_val,
>  >             test_addr, shadow_addr);
>  >     }
>  >
>  >     tcg_gen_tl_ptr(test_ptr, test_addr);
>  >     tcg_gen_st8_tl(shadow_val, test_ptr, 0);
>  > }
>  >
>  > //////////////////////////////////////////////////////////////////////=
//////////
>  >
>  > However, I would like test an implementation more like the following t=
o see how
>  > the performance compares. Whilst this introduces branches, the fast pa=
th is much
>  > more likely to be executed than the slow path and hence bypassing the =
additional
>  > checks and unnecessary memory writes I am hopeful it will improve perf=
ormance.
>  >
>  > //////////////////////////////////////////////////////////////////////=
//////////
>  >
>  > void libafl_tcg_gen_asan(TCGTemp* addr, size_t size)
>  > {
>  >     if (size =3D=3D 0) {
>  >         return;
>  >     }
>  >
>  >     if (size > 8) {
>  >         size =3D 8;
>  >     }
>  >
>  >     TCGLabel *done =3D gen_new_label();
>  >
>  >     TCGv addr_val =3D temp_tcgv_tl(addr);
>  >     TCGv shadow_addr =3D tcg_temp_new();
>  >     TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();
>  >     TCGv shadow_val =3D tcg_temp_new();
>  >     TCGv k =3D tcg_temp_new();
>  >     TCGv zero =3D tcg_constant_tl(0);
>  >     TCGv_ptr null_ptr =3D tcg_temp_new_ptr();
>  >
>  >     tcg_gen_shri_tl(shadow_addr, addr_val, 3);
>  >     tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BASE);
>  >     tcg_gen_tl_ptr(shadow_ptr, shadow_addr);
>  >     tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);
>  >
>  >     tcg_gen_brcond_tl(TCG_COND_EQ, shadow_val, zero, done);
>  >
>  >     tcg_gen_andi_tl(k, addr_val, 7);
>  >     tcg_gen_addi_tl(k, k, size - 1);
>  >
>  >     tcg_gen_brcond_tl(TCG_COND_LT, shadow_val, k, done);
>  >
>  >     tcg_gen_tl_ptr(null_ptr, zero);
>  >     tcg_gen_st8_tl(zero, null_ptr, 0);
>  >
>  >     gen_set_label(done);
>  > }
>  >
>  > //////////////////////////////////////////////////////////////////////=
//////////
>  >
>  > However, when I change to using this implementation, I get the followi=
ng error.
>  > I have tested it with a trivial hello world implementation for x86_64 =
running in
>  > qemu-user. It doesn't occur the first time the block is executed, ther=
efore I
>  > think the issue is caused by the surrounding TCG in the block it is in=
jected
>  > into?
>  >
>  > //////////////////////////////////////////////////////////////////////=
//////////
>  > runner-x86_64: ../tcg/tcg.c:4852: tcg_reg_alloc_mov: Assertion `ts->va=
l_type =3D=3D TEMP_VAL_REG' failed.
>  > Aborted (core dumped)
>  > //////////////////////////////////////////////////////////////////////=
//////////
>  >
>  > I would be very grateful for any advice of how to resolve this issue, =
or any
>  > alternative approaches I could use to optimize my original implementat=
ion. The
>  > code is obviously a very hot path and so even a tiny performance impro=
vement
>  > could result in a large performance gain overall.
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

