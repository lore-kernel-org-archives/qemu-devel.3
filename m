Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01BCC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 15:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM6nQ-0003ZT-8S; Mon, 02 Jun 2025 11:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uM6nO-0003Yw-AZ
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 11:09:50 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uM6nM-000761-7G
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 11:09:50 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6046ecc3e43so7566649a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748876984; x=1749481784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDnPoN1nG0y+VpqF+5BKHPqktxoYylULrUPn7d7ulus=;
 b=Tw82gAeVrhah9HonwO6Yup+0GKiyk1hjVX+Qr43NmEkxDWJCtCTqQTWmbJb20ePL01
 8G5xlX82OCBZuS8/sgp9jJ673JhiBZJnMBb65JT1AMsDko88eNwKbTdc2gUMohYYuuWM
 urfDYs3o9amsJa6cbxEoX6Ba8xQBmi1/K2ZFjjzTooQCJz6/VHeOVFIXLXevddXirOfD
 GJ7bOqgx6e4br+gLkpBF0foC7BuIuiWSaXUADVsaSFRFFG+Ja2Xs2F3ZEjHY+kQ+VVKM
 ER6rLt588gb53aaK3clmdvwTd8qfbExieZ47FHqp33KfLBJaJArVn5hM1fjVFYKdAKf1
 mPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748876984; x=1749481784;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JDnPoN1nG0y+VpqF+5BKHPqktxoYylULrUPn7d7ulus=;
 b=Xwyj8kq8ygO9fB6h/LfmTiexSzQvue0VntAvZ9DxDc9m4gylU9yGESmNBRfj0azrAL
 kqoNJjqsfNuiojg82hzD9oPO0hfZatQnuMUeIHKEd6fnA1u5FF4FjuvxzLec/piUWUAJ
 xs8L4PVnxy52P0UfkaKB+eteDwsQkzAUjC0XqOXsVKprPCY4VXWxDcpDeU6bV/XFMuNM
 EEPVW4rNWpgttNhV4OrdAZNGY7tzZ+KyBu9AApb3RABqzCsQBGZSUPdOjtMy+gsB1T9F
 HgtvKfbTA1JCPp3yzzMd8MMozxdneYiuTAPfjLOCZfpYI1KKRV+1ndX35BCPqSXBEGxh
 9YGQ==
X-Gm-Message-State: AOJu0YzUYZ0ycE50j3NxJ1WfCkDB5eWCBetA7kHgaOnHu6qrkZP7REvA
 dJ3R2SUeWycaUMrIBbhgNcYESSerR8KoUzFzLqaiP78gr0p1NFeaRX6db1Ivb7NegGI=
X-Gm-Gg: ASbGncvQd9C63XRNTUXR6qCTWn+qT+EhzNhiB4s2sfECc95tud5488i+ESHJe/biX+Y
 C72GsOzf0VUDXCXBTrkkGM35tKIjG3mk14nBvtutbNjUNwzYS5jNDouUkfcSKO2Os8FBIeWgrW2
 yM1wdSR3nHPwd5LlOKDdYRKuWOkbriwVfvMu1NP7LOx0ZJr8kwjO26pluQEYQ9Px8hR74RoA3Ee
 E9uyDYeI74hyreorDD/PWtMqfCA1lbnKlh6ODcCx3WNR/KW0bzyzdcgKU2Qh1ZBlOddmhTH80aY
 RGwC+Og3nXinNPNalWHk+Qqf0VoxeyOozfqaGQZmpYE3/8ps/0qbeXX+7e3yMvI=
X-Google-Smtp-Source: AGHT+IGCJB3N1J9BJXkP1ruPnkyE4fXmuX1XP8XtDmisfenF5zSJHJqSgCDsoy4QYFR5ZfEF8R96CQ==
X-Received: by 2002:a05:6402:27cc:b0:601:965e:2a44 with SMTP id
 4fb4d7f45d1cf-6056df45aaemr12423055a12.12.1748876983921; 
 Mon, 02 Jun 2025 08:09:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60567169d07sm6098365a12.73.2025.06.02.08.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 08:09:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 935675F76F;
 Mon, 02 Jun 2025 16:09:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Wilson <jonwilson030981@googlemail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: TCG Address Sanitizer Optimization.
In-Reply-To: <CAJHT5-JwrQ31MEKKSNL-E0RPm+cg7UOiqzV5cPL-mnTOPa7eUA@mail.gmail.com>
 (Jon Wilson's message of "Mon, 2 Jun 2025 13:02:08 +0100")
References: <CAJHT5-JwrQ31MEKKSNL-E0RPm+cg7UOiqzV5cPL-mnTOPa7eUA@mail.gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 02 Jun 2025 16:09:42 +0100
Message-ID: <87h60y41u1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

(Adding Richard, the TCG maintainer to CC)

> I am attempting to optimize some TCG code which I have previously written=
 for
> qemu-libafl-bridge (https://github.com/AFLplusplus/qemu-libafl-bridge), t=
he=20
> component used by the LibAFL project when fuzzing binaries using QEMU to=
=20
> provide runtime instrumentation. The code is used to write additional TCG=
 into=20
> basic blocks whenever a load or store operation is performed in order to =
provide
> address sanitizer functionality.

I would like to figure out if we can push any of this instrumentation
into TCG plugins so you can avoid patching QEMU itself. I guess you need
something that allows you to hook a memory address into some sort of
gadget?

> Address sanitizer is quite simple and works by mapping each 8-byte region=
 of
> address space to single byte within a region called the shadow map. The a=
ddress
> (on a 64-bit platform) of the shadow map for a given address is:
>
>     Shadow =3D (Mem >> 3) + 0x7fff8000;
>
> The value in the shadow map encodes the accessibility of an address:
>
>     0  - The whole 8 byte region is accessible.
>     1 .. 7 - The first n bytes are accessible.
>     negative - The whole 8 byte region is inaccessible.
>
> The following pseudo code shows the algorithm:
>
> /////////////////////////////////////////////////////////////////////////=
///////
>
> https://github.com/google/sanitizers/wiki/addresssanitizeralgorithm
>
> byte *shadow_address =3D MemToShadow(address);
> byte shadow_value =3D *shadow_address;
> if (shadow_value) {
>   if (SlowPathCheck(shadow_value, address, kAccessSize)) {
>     ReportError(address, kAccessSize, kIsWrite);
>   }
> }
>
> // Check the cases where we access first k bytes of the qword
> // and these k bytes are unpoisoned.
> bool SlowPathCheck(shadow_value, address, kAccessSize) {
>   last_accessed_byte =3D (address & 7) + kAccessSize - 1;
>   return (last_accessed_byte >=3D shadow_value);
> }
>
> /////////////////////////////////////////////////////////////////////////=
///////
>
> My current implementation makes use of conditional move instructions to t=
rigger
> a segfault by way of null dereference in the event that the shadow map in=
dicates
> that a memory access is invalid.
>
> /////////////////////////////////////////////////////////////////////////=
///////
>
> #if TARGET_LONG_BITS =3D=3D 32
> #define SHADOW_BASE (0x20000000)
> #elif TARGET_LONG_BITS =3D=3D 64
> #define SHADOW_BASE (0x7fff8000)
> #else
> #error Unhandled TARGET_LONG_BITS value
> #endif
>
> void libafl_tcg_gen_asan(TCGTemp * addr, size_t size)
> {
>     if (size =3D=3D 0)
>         return;
>
>     TCGv addr_val =3D temp_tcgv_tl(addr);
>     TCGv k =3D tcg_temp_new();
>     TCGv shadow_addr =3D tcg_temp_new();
>     TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();
>     TCGv shadow_val =3D tcg_temp_new();
>     TCGv test_addr =3D tcg_temp_new();
>     TCGv_ptr test_ptr =3D tcg_temp_new_ptr();
>
>     tcg_gen_andi_tl(k, addr_val, 7);
>     tcg_gen_addi_tl(k, k, size - 1);
>
>     tcg_gen_shri_tl(shadow_addr, addr_val, 3);
>     tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BASE);
>     tcg_gen_tl_ptr(shadow_ptr, shadow_addr);
>     tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);
>
>     /*
>      * Making conditional branches here appears to cause QEMU issues with=
 dead
>      * temporaries so we will instead avoid branches.

This sounds like a TCG bug that may have been fixed.

>      We will cause the guest
>      * to perform a NULL dereference in the event of an ASAN fault. Note =
that
>      * we will do this by using a store rather than a load, since the TCG=
 may
>      * otherwise determine that the result of the load is unused and simp=
ly
>      * discard the operation. In the event that the shadow memory doesn't
>      * detect a fault, we will simply write the value read from the shadow
>      * memory back to it's original location. If, however, the shadow mem=
ory
>      * detects an invalid access, we will instead attempt to write the va=
lue
>      * at 0x0.
>      */

Why not conditionally call a helper here? Forcing the guest to actually
fault seems a bit hammer like.

>     tcg_gen_movcond_tl(TCG_COND_EQ, test_addr,
>         shadow_val, tcg_constant_tl(0),
>         shadow_addr, tcg_constant_tl(0));
>
>     if (size < 8)
>     {
>         tcg_gen_movcond_tl(TCG_COND_GE, test_addr,
>             k, shadow_val,
>             test_addr, shadow_addr);
>     }
>
>     tcg_gen_tl_ptr(test_ptr, test_addr);
>     tcg_gen_st8_tl(shadow_val, test_ptr, 0);
> }
>
> /////////////////////////////////////////////////////////////////////////=
///////
>
> However, I would like test an implementation more like the following to s=
ee how
> the performance compares. Whilst this introduces branches, the fast path =
is much
> more likely to be executed than the slow path and hence bypassing the add=
itional
> checks and unnecessary memory writes I am hopeful it will improve perform=
ance.
>
> /////////////////////////////////////////////////////////////////////////=
///////
>
> void libafl_tcg_gen_asan(TCGTemp* addr, size_t size)
> {
>     if (size =3D=3D 0) {
>         return;
>     }
>
>     if (size > 8) {
>         size =3D 8;
>     }
>
>     TCGLabel *done =3D gen_new_label();
>
>     TCGv addr_val =3D temp_tcgv_tl(addr);
>     TCGv shadow_addr =3D tcg_temp_new();
>     TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();
>     TCGv shadow_val =3D tcg_temp_new();
>     TCGv k =3D tcg_temp_new();
>     TCGv zero =3D tcg_constant_tl(0);
>     TCGv_ptr null_ptr =3D tcg_temp_new_ptr();
>
>     tcg_gen_shri_tl(shadow_addr, addr_val, 3);
>     tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BASE);
>     tcg_gen_tl_ptr(shadow_ptr, shadow_addr);
>     tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);
>
>     tcg_gen_brcond_tl(TCG_COND_EQ, shadow_val, zero, done);
>
>     tcg_gen_andi_tl(k, addr_val, 7);
>     tcg_gen_addi_tl(k, k, size - 1);
>
>     tcg_gen_brcond_tl(TCG_COND_LT, shadow_val, k, done);
>
>     tcg_gen_tl_ptr(null_ptr, zero);
>     tcg_gen_st8_tl(zero, null_ptr, 0);
>
>     gen_set_label(done);
> }
>
> /////////////////////////////////////////////////////////////////////////=
///////
>
> However, when I change to using this implementation, I get the following =
error.
> I have tested it with a trivial hello world implementation for x86_64 run=
ning in
> qemu-user. It doesn't occur the first time the block is executed, therefo=
re I
> think the issue is caused by the surrounding TCG in the block it is injec=
ted
> into?
>
> /////////////////////////////////////////////////////////////////////////=
///////
> runner-x86_64: ../tcg/tcg.c:4852: tcg_reg_alloc_mov: Assertion `ts->val_t=
ype =3D=3D TEMP_VAL_REG' failed.
> Aborted (core dumped)
> /////////////////////////////////////////////////////////////////////////=
///////
>
> I would be very grateful for any advice of how to resolve this issue, or =
any
> alternative approaches I could use to optimize my original implementation=
. The
> code is obviously a very hot path and so even a tiny performance improvem=
ent
> could result in a large performance gain overall.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

