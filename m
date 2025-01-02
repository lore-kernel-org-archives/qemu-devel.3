Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA8CE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIEn-0000Mp-DK; Thu, 02 Jan 2025 05:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tTIEm-0000Md-7n
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:15:32 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tTIEk-0002fQ-68
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:15:31 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8e52so19123727a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 02:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735812927; x=1736417727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9HBsCdUSNzIZbzp2sjIH7zCYgPhs1zVJqR7keXBtcI=;
 b=xbkpGDSRfq5cy0XAsKqg63wULogBQlY6RzhwlbH26SGOWuJtTRsX1p6xJ51luIVzlh
 4WUQVwjpbNuoQ0EEowJmhBVaxjGc4AznceMuSHk/DRRRiiusiFvdOM2EySXN4NrG3JLo
 V3plEO2UDAbzQcHphoBdVUGHRag/lesCVTPqu5Nkz3JvL+bZWk6gnZ6u9c3DN0NQvwjE
 vL3rtqiBJVxWad9kH5Pps5SvsYFx/3wQZyBtoRiS0STHoBp6iv+QES9URQe4Gz38gMut
 tQdDLWvSYYXKOKdcvSPU43WGP3EGN3SRpXlvsi4vNfVc8GeiHJtJpk88q9kzsqFsU4A/
 +0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735812927; x=1736417727;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U9HBsCdUSNzIZbzp2sjIH7zCYgPhs1zVJqR7keXBtcI=;
 b=rgecrB8Uy1d1xu2SZM5jlWG9sfk/kHvTa0lxmVjGmFP+q9Yy8HNFETJ2noqH6Tovlq
 k6qpOMLnAeZbevoFMHmfCTlD3PH3FHSgg/LKQpsid5FYMQsMkCKxd1fEhPxgKH8qDxlr
 1o5786+NtJxuGKqvN1nijx2Bz39Fl41YqbpwzrHSl44IUYCzAyIAl07zsAHu9tNXKvzp
 veeiuwuxmDnM7wBKyAimN+rZG8OO2+8+In3IbzNJPfKeXLr2XOzMcb7hvfsLmCftT3L0
 fIGyh+fN3GPpvDebTwN74o49K4Ntcdq4imX3EBU4ojJDa2iGvGk+wHFIAj96gQe6CqOQ
 ooxg==
X-Gm-Message-State: AOJu0YwsGNdSHRt/Vr7DfvYNmeWYarDzBr9qpSbC81zZKaBr/qSJI7Ka
 nVfuF2Dll4PS0MXkEL5rL81TcLLtPKw/vrnN9kZDtvQic86sUjJ6Lit7LXCdSxs=
X-Gm-Gg: ASbGncubdKYgl/EjIZj41KfSHT6fuo/fJC9yI46ZOnKqVeZPOcm8KTxn+eM/frTKiGA
 patGFiDZWBnkZsyvmh0Xl9KtO2Qy8cQ/JOppKyz6q4tQUEgaxIuSFCUhKkyBhIp3yGEQSeNmr92
 w92DErq/SFK83VZD2WLtadH+cLBNIAlYe8UxLOCJaOuhb9JvT+nqXPPdBVOf8wtAIiD5+TxwZGI
 SaLQkaV1pX5Awa0dZ9haeNRCPcUBCRtN+AcYlEYCIh7aVrfE2f9WHw=
X-Google-Smtp-Source: AGHT+IElyCM5Lw/4E5rjLikYlpCYT821EkWpCk139iAUlF4pAddCQhVnqjv/0f3goIrqUldZxeGwKA==
X-Received: by 2002:a05:6402:2690:b0:5d3:ba42:e9fe with SMTP id
 4fb4d7f45d1cf-5d81ddc0362mr36296686a12.12.1735812926984; 
 Thu, 02 Jan 2025 02:15:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80701c822sm18155296a12.77.2025.01.02.02.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 02:15:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B48B5F8C1;
 Thu,  2 Jan 2025 10:15:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gautam Bhat <mindentropy@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: How does "rsi" get set in x86 prologue?
In-Reply-To: <CAM2a4uxJFhw71emxdZrB4SF-JSzJy_-bL=g9ke7OmjUoOXUDYQ@mail.gmail.com>
 (Gautam Bhat's message of "Thu, 2 Jan 2025 00:56:47 +0530")
References: <CAM2a4uxJFhw71emxdZrB4SF-JSzJy_-bL=g9ke7OmjUoOXUDYQ@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 02 Jan 2025 10:15:23 +0000
Message-ID: <87jzbdv7wk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Gautam Bhat <mindentropy@gmail.com> writes:

> I am trying to understanding the generated code for the x86 target. On
> EPILOGUE code below:
>
> 0x7fff98000000:  55                       pushq    %rbp
> 0x7fff98000001:  53                       pushq    %rbx
> 0x7fff98000002:  41 54                    pushq    %r12
> 0x7fff98000004:  41 55                    pushq    %r13
> 0x7fff98000006:  41 56                    pushq    %r14
> 0x7fff98000008:  41 57                    pushq    %r15
> 0x7fff9800000a:  48 8b ef                 movq     %rdi, %rbp
> 0x7fff9800000d:  48 81 c4 78 fb ff ff     addq     $-0x488, %rsp
> 0x7fff98000014:  ff e6                    jmpq     *%rsi
> 0x7fff98000016:  33 c0                    xorl     %eax, %eax
> 0x7fff98000018:  48 81 c4 88 04 00 00     addq     $0x488, %rsp
> 0x7fff9800001f:  c5 f8 77                 vzeroupper
> 0x7fff98000022:  41 5f                    popq     %r15
> 0x7fff98000024:  41 5e                    popq     %r14
> 0x7fff98000026:  41 5d                    popq     %r13
> 0x7fff98000028:  41 5c                    popq     %r12
> 0x7fff9800002a:  5b                       popq     %rbx
> 0x7fff9800002b:  5d                       popq     %rbp
> 0x7fff9800002c:  c3                       retq
>
> Can someone help me understand in which file or where in the source
> does the "rsi" get set to jump? (0x7fff98000014:  ff e6   jmpq
> *%rsi)

The prologue/epilogue code is generated by:

  /* Generate global QEMU prologue and epilogue code */
  static void tcg_target_qemu_prologue(TCGContext *s)
  {
      int i, stack_addend;

      /* TB prologue */

      /* Reserve some stack space, also for TCG temps.  */
      stack_addend =3D FRAME_SIZE - PUSH_SIZE;
      tcg_set_frame(s, TCG_REG_CALL_STACK, TCG_STATIC_CALL_ARGS_SIZE,
                    CPU_TEMP_BUF_NLONGS * sizeof(long));

      /* Save all callee saved registers.  */
      for (i =3D 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
          tcg_out_push(s, tcg_target_callee_save_regs[i]);
      }

      if (!tcg_use_softmmu && guest_base) {
          int seg =3D setup_guest_base_seg();
          if (seg !=3D 0) {
              x86_guest_base.seg =3D seg;
          } else if (guest_base =3D=3D (int32_t)guest_base) {
              x86_guest_base.ofs =3D guest_base;
          } else {
              assert(TCG_TARGET_REG_BITS =3D=3D 64);
              /* Choose R12 because, as a base, it requires a SIB byte. */
              x86_guest_base.index =3D TCG_REG_R12;
              tcg_out_movi(s, TCG_TYPE_PTR, x86_guest_base.index, guest_bas=
e);
              tcg_regset_set_reg(s->reserved_regs, x86_guest_base.index);
          }
      }

      if (TCG_TARGET_REG_BITS =3D=3D 32) {
          tcg_out_ld(s, TCG_TYPE_PTR, TCG_AREG0, TCG_REG_ESP,
                     (ARRAY_SIZE(tcg_target_callee_save_regs) + 1) * 4);
          tcg_out_addi(s, TCG_REG_ESP, -stack_addend);
          /* jmp *tb.  */
          tcg_out_modrm_offset(s, OPC_GRP5, EXT5_JMPN_Ev, TCG_REG_ESP,
                               (ARRAY_SIZE(tcg_target_callee_save_regs) + 2=
) * 4
                               + stack_addend);
      } else {
          tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs=
[0]);
          tcg_out_addi(s, TCG_REG_ESP, -stack_addend);
          /* jmp *tb.  */
          tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, tcg_target_call_iarg_reg=
s[1]);
      }

      /*
       * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
       * and fall through to the rest of the epilogue.
       */
      tcg_code_gen_epilogue =3D tcg_splitwx_to_rx(s->code_ptr);
      tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_EAX, 0);

      /* TB epilogue */
      tb_ret_addr =3D tcg_splitwx_to_rx(s->code_ptr);

      tcg_out_addi(s, TCG_REG_CALL_STACK, stack_addend);

      if (have_avx2) {
          tcg_out_vex_opc(s, OPC_VZEROUPPER, 0, 0, 0, 0);
      }
      for (i =3D ARRAY_SIZE(tcg_target_callee_save_regs) - 1; i >=3D 0; i--=
) {
          tcg_out_pop(s, tcg_target_callee_save_regs[i]);
      }
      tcg_out_opc(s, OPC_RET, 0, 0, 0);
  }

The call into the prologue comes from:

  ret =3D tcg_qemu_tb_exec(cpu_env(cpu), tb_ptr);

in cpu_tb_exec. With env in RDI and tb_ptr (the code address) being in
RSI.

>
> Thanks,
> Gautam.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

