Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECE6CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSb7s-0001iu-L8; Thu, 28 May 2026 09:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSb7o-0001hu-6i
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:50:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSb7l-0003lk-EQ
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:50:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so82142995e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779976211; x=1780581011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NsdN7CeCDhmLk9u6DNv20vpChFhuhsKQXvdM6wjh10I=;
 b=Rr/Icvk290M+TJOtvrtGqZIoSCE/N0C+TVHV3EJvoxlwjgokfYhhuach64T1fN7Z1Q
 x7+9d7wE8chbt9xlVGv7LhHS8bKJyd1ZrJ+dHbvs9GjQIIwdWdw8ecPj4Ok4FFNrvrj/
 8usL2X9NCgwy1MPzfxRXlWC7jgqgaYXFNNNkKBspUP8Jm/yif9EubHtFmo5VLQOkLt5a
 CBm6vJPyPEcssCrLNTCwzJF7Hr7W5J9+AG1P+TwkdogZFrxVEsFNx7QWNoam2h3AYs3A
 wWbYZPw71Ixv3INmYe34edPEpu6zUlvk1lzF6ZOCXOM1VBbYN3o1JFs8KPYCHx2xzILn
 4cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976211; x=1780581011;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NsdN7CeCDhmLk9u6DNv20vpChFhuhsKQXvdM6wjh10I=;
 b=jJ50t1E8HUx2rkJdH27Amc/V7eUMpBK7w4jNfgfQ5SqcBUApNHS8d8hVwehSgGPbhS
 Mth6tCD9P/0U0h51OK+UkotHsSWvpivqYik6v6f2fyf+XEkbqXhVJPErlcI2rkP+CImj
 gTvVHzMzhAmVGIgCm1xJ3DayV03KoH09b/CnrKHgG4ZguvCcpSUjFf8IO72hZ9SW+nW8
 kpO+/NllwZsY1fSrgKCbuMnCCHjVykX23ojV+E6sv5/bWyziUTLXrpxALF7/mFMNaMv7
 /JETF613NxHsG3Nq5Q81Xyg0SnaHstxr3xj23O6s+WomrlpxQS4KMrHBGKw+QArU3yvL
 TFDQ==
X-Gm-Message-State: AOJu0YyU4kBpl11r1PW0GBYAV/kXigr6BAU6VE8CxDVq/l4Z3UFaNe8j
 mEywzoY/jOr/Mawoo5KOKtfmKiR4nM1BrACHloTXLozjn7+o0GnuIrQzRTFN4IefWUk=
X-Gm-Gg: Acq92OFnf49TVVT5A957Xg4UxpkVKmoF9U0eI4JggDAOJf88qwhiKUCvWXTdIPnmWsL
 NhedhrNi6zZAJBszQ3yIGoNAu0Axu755mJjlppOP283BylMlt4h6AY3IOgPsfosgRoKxtgH2/pG
 mJBkd9UTPIV2PWIo+cDi7y8Dmc17NU6IKlqJ1bzJFTTZyGu3DRD5xE9MgglLMVKJ9pP0CGhUV6U
 zfPoyrYEI6tBMp6vDR5V2XkBQFQy1gEiD/8QRVIVQwGTmCmpmdr4XdKwZg1hO1A0yj3dUg0CpBx
 4Itr2jlpJXgdORoso5rHYVSwaqH6T+qPkZCaE7lh78Ey2wVQ9xFF3/hTXrIklDsXTSIqaatYxx8
 RWTR/wkLKHFOekKeJwkJ6n4SXlSKxsQhy/yPV7T6R2MAua0JEaHhLVEEeEDV8bJEN+oKmIr1Ytn
 6UnUk7IVuF/kxWkpcpACkfo5Juha/CXI374w==
X-Received: by 2002:a05:600c:8484:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-490426cd8c4mr475241395e9.20.1779976211243; 
 Thu, 28 May 2026 06:50:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092a82ea2sm73928135e9.9.2026.05.28.06.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:50:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 913145F7DC;
 Thu, 28 May 2026 14:50:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Anton Johansson
 <anjo@rev.ng>
Subject: Re: [PATCH] docs/devel/tcg: Expand on multi-threaded TCG
In-Reply-To: <20260528082022.32359-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 28 May 2026 10:20:22
 +0200")
References: <20260528082022.32359-1-philmd@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 28 May 2026 14:50:09 +0100
Message-ID: <87cxyfwsmm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Significantly expands the TCG documentation to provide more
> comprehensive overview of its internal architecture.
>
> Use more rST anchors to improve cross-referencing across the
> documentation.
>
> Clarify front-end / optimization / back-end phases.
>
> Detail a bit memory consistency barriers under MTTCG mode.
>
> Add the following new sections:
>
>  - Register Allocation and Liveness analysis
>  - Overviews of the Vector/SIMD internal strategy
>  - Deterministic Execution (icount)
>  - TCG Plugins
>  - Instruction Decoding with decodetree
>
> AI-used-for: docs
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Based-on: <20260528073412.551117-1-pbonzini@redhat.com>
> ---
>  docs/devel/multi-thread-tcg.rst |  2 +-
>  docs/devel/tcg-icount.rst       |  1 +
>  docs/devel/tcg.rst              | 89 +++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tc=
g.rst
> index da9a1530c9f..aa0b11ab360 100644
> --- a/docs/devel/multi-thread-tcg.rst
> +++ b/docs/devel/multi-thread-tcg.rst
> @@ -4,7 +4,7 @@
>    This work is licensed under the terms of the GNU GPL, version 2 or
>    later. See the COPYING file in the top-level directory.
>=20=20
> -.. _mttcg:
> +.. _MTTCG:
>=20=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Multi-threaded TCG
> diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
> index a1dcd79e0fd..848c19a746f 100644
> --- a/docs/devel/tcg-icount.rst
> +++ b/docs/devel/tcg-icount.rst
> @@ -2,6 +2,7 @@
>     Copyright (c) 2020, Linaro Limited
>     Written by Alex Benn=C3=A9e
>=20=20
> +.. _icount:
>=20=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  TCG Instruction Counting
> diff --git a/docs/devel/tcg.rst b/docs/devel/tcg.rst
> index 2786f2f6791..9af06018f6a 100644
> --- a/docs/devel/tcg.rst
> +++ b/docs/devel/tcg.rst
> @@ -13,6 +13,16 @@ performances.
>  QEMU's dynamic translation backend is called TCG, for "Tiny Code
>  Generator". For more information, please take a look at :ref:`tcg-ops-re=
f`.
>=20=20
> +The translation process occurs in several distinct passes:
> +
> +1. **Front-end**: Guest instructions are parsed (often using the
> +   `decodetree <Instruction Decoding (decodetree)_>`_ tool) and converted
> +   into target-independent TCG Intermediate Representation (IR) opcodes.
> +2. **Optimization**: TCG performs passes such as constant folding, liven=
ess
> +   analysis, and dead code elimination on the IR.

Not all optimisation is done here by the way, some of the front-end ops
will select operations based on TCG_TARGET_HAS_ before we get to the
optimisation pass.

> +3. **Back-end**: The optimized IR is converted by a host-specific code
> +   generator into native instructions for the host CPU.
> +
>  The following sections outline some notable features and implementation
>  details of QEMU's dynamic translator.
>=20=20
> @@ -44,6 +54,12 @@ translating it from the guest architecture if it isn=
=E2=80=99t already available
>  in memory. Then QEMU proceeds to execute this next TB, starting at the
>  prologue and then moving on to the translated instructions.
>=20=20
> +In :ref:`MTTCG` mode, each guest CPU is emulated by a separate host thre=
ad.
> +TCG ensures memory consistency by inserting memory barrier (``mb``) opco=
des
> +for guest instructions with ordering side effects. Direct block chaining
> +across page boundaries is restricted to ensure that changes to memory
> +mappings in one thread are correctly handled by others.
> +
>  Exiting from the TB this way will cause the ``cpu_exec_interrupt()``
>  callback to be re-evaluated before executing additional instructions.
>  It is mandatory to exit this way after any CPU state changes that may
> @@ -175,6 +191,12 @@ virtual to physical address translation is done at e=
very memory
>  access.
>=20=20
>  QEMU uses an address translation cache (TLB) to speed up the translation.
> +The software MMU partitions accesses into a **TLB fast-path** and a
> +**TLB slow-path**. The fast-path handles RAM and ROM areas, where the TLB
> +provides the direct offset between guest virtual addresses and host memo=
ry.
> +If an access does not match a fast-path entry, it falls through to the
> +slow-path, which calls C helper functions to handle MMIO device emulatio=
n.
> +
>  In order to avoid flushing the translated code each time the MMU
>  mappings change, all caches in QEMU are physically indexed.  This
>  means that each basic block is indexed with its physical address.
> @@ -190,6 +212,73 @@ memory areas instead calls out to C code for device =
emulation.
>  Finally, the MMU helps tracking dirty pages and pages pointed to by
>  translation blocks.
>=20=20
> +Register Allocation and Liveness
> +--------------------------------
> +
> +During the translation phase, guest instructions are converted into TCG =
IR
> +using an **unlimited number of temporaries (TEMPs)**.
> +This allows guest translators to express logic without being constrained
> +by the finite register set of the host CPU.
> +
> +To resolve these TEMPs into physical registers, TCG performs two passes:
> +
> +1. **Liveness Analysis**: This pass determines the "live range" of each
> +   temporary within a basic block. By identifying when a variable
> +   becomes "dead" (i.e., its value is no longer needed), TCG can suppress
> +   redundant moves and remove instructions that compute unused results.
> +2. **Register Allocation**: The Global Register Allocator maps live TEMPs
> +   to host physical registers. Fixed globals, such as the pointer
> +   to the CPU architecture state (``cpu_env``), are often permanently
> +   held in host registers to minimize memory traffic during execution.
> +
> +Vector/SIMD Internal Strategy
> +-----------------------------
> +
> +TCG supports SIMD operations through a set of generic vector instructions
> +(e.g., ``add_vec``, ``shli_vec``) parameterized by vector length and ele=
ment
> +size. The length is specified as a ``TCGType`` (V64, V128, or V256), and=
 the
> +element size is given in log2 8-bit units.
> +
> +The internal strategy relies on the backend mapping these generic opcodes
> +to native host SIMD instructions, such as x86 AVX or ARM NEON. If the ho=
st
> +backend does not support a specific vector operation  or length, TCG's
> +expansion layer automatically decomposes the opcode into smaller support=
ed
> +vector sizes or standard integer operations.
> +
> +Deterministic Execution (icount)
> +--------------------------------
> +
> +The :ref:`icount` mechanism provides deterministic execution by ensuring
> +that each Translation Block executes a fixed number of instructions. This
> +is essential for features like record/replay and deterministic virtual t=
ime,
> +where instruction counts serve as the system clock.
> +
> +Instrumentation and Plugins
> +---------------------------
> +
> +:ref:`TCG Plugins` provide a mechanism for runtime instrumentation. Opco=
des
> +like ``plugin_cb`` and ``plugin_mem_cb`` are inserted during translation=
 to
> +trigger callbacks in external modules, allowing analysis of instruction
> +execution or memory access.
> +
> +Instruction Decoding (decodetree)
> +---------------------------------
> +
> +The first step of the translation process is converting a raw bitstream =
of
> +guest instructions into a structured format that the translator can proc=
ess.
> +QEMU simplifies this using the ``decodetree.py`` script, which generates=
 C
> +code decoders from a domain-specific language defined in ``.decode`` fil=
es.
> +
> +The decodetree tool allows developers to define instruction **patterns**
> +based on a bitmask and fixed bits. When a match is found, the generated
> +decoder automatically  extracts defined **fields** (such as registers or
> +immediates) and passes  them to a manually written translation function.
> +
> +This declarative approach drastically reduces the amount of error-prone
> +manual bit-shifting and nested "if-else" logic required in guest transla=
tors.
> +
> +For detailled implementation see :ref:`decodetree`.
> +
>  Profiling JITted code
>  ---------------------

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

