Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE9ED2FFE1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jZG-0003ef-JZ; Fri, 18 Oct 2024 05:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t1jZD-0003WD-7g
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:46:43 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t1jZA-0002CO-Ad
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:46:42 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so3408218a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729244798; x=1729849598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qAhYOjYwYnTUgJvVsGGd3RC/MiaDZR+oKlZB5tHMco=;
 b=HcekgZAoGLd4Z9eUiJhusgXbVPAXB0oHcNplnKNPZAORJ+ajpMTzynj0PL+VLb4BBL
 /AYdxHpQq4A+jIcYbb62VBHKq4X8pS+6qqPmzHn64eGUpts+3cNzVHb0qXP3sRKX7nJy
 4gWUXGSmpb+oasgij5WwzgZHubYDeNnfmELdQAwwlMIWxX65EsnV9XGhsWmhNUVNClQZ
 shaFCeV87JNcqD2jHiUWLgsAGNlNuB5tNHW7zi6M2KxL0Ab5mSER3F19HlnT+i643LSn
 fCLOlY8j3qvtinYWO/6aGP/Sofn4Yzhw5n1E3C7s1MlLpcdOCVNBsCGt1B03bY0uo+c7
 LeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729244798; x=1729849598;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6qAhYOjYwYnTUgJvVsGGd3RC/MiaDZR+oKlZB5tHMco=;
 b=tmd8pJ3+eclZVG+pr2roMvg8AtIcD7NmCxb3NztOXNjr4qCGF/7eaxFXJ9Mu5JvzaH
 wPoQ3INK0NzHqhya9G3baHf8z7TsUQarw/d8lCFmjvcCNOaFEV3DI+Nzdct9y+Suu1P8
 shFMZwrdtlxtvFzlHGhoMEtDKCFnokJu7uPy37N2O4rGHQI0sRqhIoGNJtSlCI0J1TjE
 rmmvtprswczch/0fPpmt0gJUFNpDcORhNC5qBK5tffkpwpxhLJxDn/YGHEv3Q3uTaWlC
 FNTRTdA8Z9PmJ1YbRmkLiKbYA6wNQ47iEWPOyFI7z0gUFn0Y/d6oR40JhHv+it229zn/
 Hmow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLNMeT8ndvEbnXcO0F903Z+g+RDezVETLVbhLONvyi7cqKp9lmz9JJBMtO3msj5YV+CyW16tivKQJe@nongnu.org
X-Gm-Message-State: AOJu0YwSHG2MLXV6rsTc/UQk+ftWYnsy5Evmthcax2k/bS7/ej1OdRQ9
 SJfEcle7HpnVYwhvSQY0yc+wlncfpfHU54RFPxNiBpHzKrYTz93sjyutQJjMJjA=
X-Google-Smtp-Source: AGHT+IFGBhEqaGJcgl5GIoQ9Q6A2WuElJLkh9++CZInNLyHznA6vWlThz5m+uvCvt8AmZx05e2VKzA==
X-Received: by 2002:a05:6402:28ca:b0:5c9:46a7:527 with SMTP id
 4fb4d7f45d1cf-5ca0b117cacmr1725253a12.17.1729244797647; 
 Fri, 18 Oct 2024 02:46:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ca0b0ff6c1sm496118a12.93.2024.10.18.02.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 02:46:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 063C25F863;
 Fri, 18 Oct 2024 10:46:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,  Linux ARM
 <linux-arm-kernel@lists.infradead.org>,  qemu-devel@nongnu.org,
 lkft-triage@lists.linaro.org,  Linux Regressions
 <regressions@lists.linux.dev>,  Catalin Marinas <catalin.marinas@arm.com>,
 Mark Brown <broonie@kernel.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Anders Roxell <anders.roxell@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>,  Dan Carpenter <dan.carpenter@linaro.org>,
 Aishwarya TCV <aishwarya.tcv@arm.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm64 with Linux next-20241017 tag
In-Reply-To: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>
 (Naresh Kamboju's message of "Fri, 18 Oct 2024 12:56:01 +0530")
References: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 18 Oct 2024 10:46:34 +0100
Message-ID: <871q0daglh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Naresh Kamboju <naresh.kamboju@linaro.org> writes:

> The QEMU-arm64 boot has failed with the Linux next-20241017 tag.
> The boot log is incomplete, and no kernel crash was detected.
> However, the system did not proceed far enough to reach the login prompt.
>
> Please find the incomplete boot log links below for your reference.
> The Qemu version is 9.0.2.
> The arm64 devices boot pass.

Can confirm it also fails on the current master of QEMU:

  #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsi=
gno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
  #1  0x00007ffff4a3ae9f in __pthread_kill_internal (signo=3D6, threadid=3D=
<optimized out>) at ./nptl/pthread_kill.c:78
  #2  0x00007ffff49ebfb2 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
posix/raise.c:26
  #3  0x00007ffff49d6472 in __GI_abort () at ./stdlib/abort.c:79
  #4  0x00007ffff6e47ec8 in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
  #5  0x00007ffff6ea7e1a in g_assertion_message_expr () at /lib/x86_64-linu=
x-gnu/libglib-2.0.so.0
  #6  0x0000555555f45732 in regime_is_user (env=3D0x555557f805f0, mmu_idx=
=3DARMMMUIdx_E10_0) at ../../target/arm/internals.h:978
  #7  0x0000555555f5b0f1 in aa64_va_parameters (env=3D0x555557f805f0, va=3D=
18446744073709551615, mmu_idx=3DARMMMUIdx_E10_0, data=3Dtrue, el1_is_aa32=
=3Dfalse)
      at ../../target/arm/helper.c:12048
  #8  0x0000555555f4e3e5 in tlbi_aa64_get_range (env=3D0x555557f805f0, mmui=
dx=3DARMMMUIdx_E10_0, value=3D107271103184929) at ../../target/arm/helper.c=
:5214
  #9  0x0000555555f4e5a4 in do_rvae_write (env=3D0x555557f805f0, value=3D10=
7271103184929, idxmap=3D21, synced=3Dtrue) at ../../target/arm/helper.c:5260
  #10 0x0000555555f4e6d9 in tlbi_aa64_rvae1is_write (env=3D0x555557f805f0, =
ri=3D0x555557ffda90, value=3D107271103184929) at ../../target/arm/helper.c:=
5302
  #11 0x00005555560553c8 in helper_set_cp_reg64 (env=3D0x555557f805f0, rip=
=3D0x555557ffda90, value=3D107271103184929) at ../../target/arm/tcg/op_help=
er.c:965
  #12 0x00007fff60fc3939 in code_gen_buffer ()

while with:

./qemu-system-aarch64 \
                  -machine type=3Dvirt,virtualization=3Don,gic-version=3D3,=
mte=3Don \
                  -cpu max,pauth-impdef=3Don \
                  -smp 4 \
                  -accel tcg \
                  -serial mon:stdio \
                  -m 8192 \
                  -kernel /home/alex/lsrc/qemu.git/builds/all/Image -append=
 "root=3D/dev/sda2 console=3DttyAMA0  kvm-arm.mode=3Dprotected earlycon" \
                  -display none

Specifically kvm-arm.mode=3Dprotected has to be on.

With more detail I can see:

(gdb) p/x value
$1 =3D 0x619000000021
(gdb) p *ri
$2 =3D {name =3D 0x555557ffdb28 "TLBI_RVAALE1IS", cp =3D 19 '\023', crn =3D=
 8 '\b', crm =3D 2 '\002', opc0 =3D 1 '\001', opc1 =3D 0 '\000', opc2 =3D 7=
 '\a',=20
  state =3D ARM_CP_STATE_AA64, type =3D 1024, access =3D PL1_W, secure =3D =
ARM_CP_SECSTATE_NS, fgt =3D FGT_TLBIRVAALE1IS, nv2_redirect_offset =3D 0, o=
paque =3D 0x0,=20
  resetvalue =3D 0, fieldoffset =3D 0, bank_fieldoffsets =3D {0, 0}, access=
fn =3D 0x555555f46703 <access_ttlbis>, readfn =3D 0x0,=20
  writefn =3D 0x555555f4e6a2 <tlbi_aa64_rvae1is_write>, raw_readfn =3D 0x0,=
 raw_writefn =3D 0x0, resetfn =3D 0x0, orig_readfn =3D 0x0, orig_writefn =
=3D 0x0,=20
  orig_accessfn =3D 0x0}

It seems the asset fires because:

    case ARMMMUIdx_E10_0:
    case ARMMMUIdx_E10_1:
    case ARMMMUIdx_E10_1_PAN:
        g_assert_not_reached();

But the function:

static int vae1_tlbmask(CPUARMState *env)
{
    uint64_t hcr =3D arm_hcr_el2_eff(env);
    uint16_t mask;

    if ((hcr & (HCR_E2H | HCR_TGE)) =3D=3D (HCR_E2H | HCR_TGE)) {
        mask =3D ARMMMUIdxBit_E20_2 |
               ARMMMUIdxBit_E20_2_PAN |
               ARMMMUIdxBit_E20_0;
    } else {
        mask =3D ARMMMUIdxBit_E10_1 |
               ARMMMUIdxBit_E10_1_PAN |
               ARMMMUIdxBit_E10_0;
    }
    return mask;
}

returns that while handling tlbi_aa64_rvae1is_write(). I don't have an
Arm ARM handy with me in the airport. Peter/Richard can you check what
the logic should be and if this is a QEMU bug or the kernel doing
something it shouldn't?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

