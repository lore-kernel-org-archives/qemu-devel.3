Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75818CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 10:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSYEI-0001AI-NV; Thu, 28 May 2026 06:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSYEF-0001A3-FB
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:44:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSYED-0003M7-Du
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:44:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso40117065e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 03:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779965079; x=1780569879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qyKBTPwowMAI3HLllj++BA5U+ZhI6e1QOQhOQaMSVSI=;
 b=OsHzaleMLLNJhN2/TINk1SWXEfcbHkbFrSVwWQr7CET6e771vJ406JnBgPfAtjPk+D
 aKpaLAuW7M7s1uxT3tjnwupn5euwSNJUtzB+JQ4b3fIQMWmRMFmR88yMEHR6QqJOKW0F
 8YsDOG7TgTdqY0Yl1bFxMRFuUQiJIBzLioEl78tT31ncDwZ70AqEu4X+c8e9I8E6jTPe
 2N5egaac/xbdog00sR4OS0eLeZ0WAP5jqS4RRNFmvTbomSSAngUhD9MkYT8TSV3mmsEF
 eQNBHhshFHCVGyzU2bEg/aFf5Mvb4znjZTe/r7MoSv/8G9VItfoWu3ZD0SrunRCLAvzy
 AhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779965079; x=1780569879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qyKBTPwowMAI3HLllj++BA5U+ZhI6e1QOQhOQaMSVSI=;
 b=NWKWJtvmzYhxpDetLsuP/rgoy/hJPwbOrDmA/WwBS1EqzTA62sKJ4i88Un05tnqaaK
 TTx9ZfMOjt8hzKVaH4U5+I3Gmg10EVHOKwQkag1ZMMmrKIxn8T4z3Afe1TmkKQQiWTHI
 5/RGF559bXr/Z3HHPjBx29Maki64I/aKisjGEFvXBLNwYqwYiKqrXNtl+itFsye+0hpa
 uIBuPxF044rrzVTHLq4neaFbdz3C5leopPSkuJFEZ0HMcFbSvszeWtoz3uOzG/NPGjIJ
 7KJnX0gNS4reePWPli5W6BeYkt2DRCKL8Kt4Qa6voV4iwTzjnJwJnKgH/2S7IXp3tXxT
 +rDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+r+plvMIYNl/x7RQW/GtMSX7FLXTr18qfH/Muk2uqq8JOqb8//scXl1OF8EN40as21y0JL1+wYKwMk@nongnu.org
X-Gm-Message-State: AOJu0Yx4JrHtyCUColE9CSBSuyH5Hzoox62ycQ0MtTUM+394jEIwTRfR
 5OZ7NWqKE71tTHKyR3rqtDzyTqOdLClPOvmqHX/H3Nwm1C20CVQZ6ZchTaHGA/TDdgm6i/dOM9w
 9/+GLY8rR9Q==
X-Gm-Gg: Acq92OHW7r+fbzdUtYK9ViWpenpDPOGJlRqqqupQxWDMkUlf45EUfWDFNwxEq9FkQd8
 jdKKoFzT5PfjfvRu/YcUEBX+KnNL41NrzfM2ocvcBjRPnXy2m04hnKk611/SkM6Cg3C5FIHEv10
 mj+NPxHuwqBcWy49bfl8ByYvEEteQw6aCpxzMFy3wlqKE+YpSpiCEAdF3pG4GVCf9tNR8GryuLx
 zCKMUfkEofdPzFWriIrB04bSR/mY7Ka0OAxjLq04+hav6GHqeKl2Lhn7Ur8AdCC867wwV0+aj4U
 VeXdNk8kR2JYCVJ+7Xq96JZwtw06+b2Fh3xL7kGVw/Q/Wwr44VCWTVs9nCPsfzxJ1RtCoXa0Pt8
 ftZSLE9ZYwuVmGy+O1DwJZmRRn5vaPlK1cWm7bsihyGxuCwgDKSL3ubGMHwzvxu7unfU2oYyx2i
 844aVbyQlH17xPhHNlNjONX34rb2QU5kwU65Oz9CDddoSQmSNVcKHbXZOpNHC6zmM3JJeICRzEy
 k23fmY5vpGLh6s=
X-Received: by 2002:a05:600c:35cf:b0:490:3bad:3784 with SMTP id
 5b1f17b1804b1-490426bc6demr498721765e9.18.1779965079167; 
 Thu, 28 May 2026 03:44:39 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909235d43esm54940215e9.1.2026.05.28.03.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 03:44:38 -0700 (PDT)
Message-ID: <9bfbda41-6f3d-4bb0-8ee9-14df28165526@linaro.org>
Date: Thu, 28 May 2026 12:44:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/tcg: Expand on multi-threaded TCG
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260528082022.32359-1-philmd@linaro.org>
 <893dd362-b70c-4c24-bb19-428808ceaa6d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <893dd362-b70c-4c24-bb19-428808ceaa6d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 28/5/26 11:04, Paolo Bonzini wrote:
> Before looking at the specifics, I appreciate you bold and experimenting 
> with how to improve our documentation. I can see that this is largely 
> unedited LLM output, and honestly, that is actually a good thing for 
> this experiment.
> 
> On the other hand, it exposes where the tool falls short, and highlights 
> very clearly the risks of accepting AI-generated content too leisurely.
> 
> On 5/28/26 10:20, Philippe Mathieu-Daudé wrote:
>> Significantly expands the TCG documentation to provide more
>> comprehensive overview of its internal architecture.
>>
>> Use more rST anchors to improve cross-referencing across the
>> documentation.
>>
>> Clarify front-end / optimization / back-end phases.
>>
>> Detail a bit memory consistency barriers under MTTCG mode.
>>
>> Add the following new sections:
>>
>>   - Register Allocation and Liveness analysis
>>   - Overviews of the Vector/SIMD internal strategy
>>   - Deterministic Execution (icount)
>>   - TCG Plugins
>>   - Instruction Decoding with decodetree
> 
> This commit message is not really up to the standards.  It is purely a 
> "what" which can be obtained just by glancing at the section headers.
> 
> It should explain the purpose of tcg.rst and why these new sections were 
> singled out.
>> +The translation process occurs in several distinct passes:
>> +
>> +1. **Front-end**: Guest instructions are parsed (often using the
>> +   `decodetree <Instruction Decoding (decodetree)_>`_ tool) and 
>> converted
>> +   into target-independent TCG Intermediate Representation (IR) opcodes.
>> +2. **Optimization**: TCG performs passes such as constant folding, 
>> liveness
>> +   analysis, and dead code elimination on the IR.
>> +3. **Back-end**: The optimized IR is converted by a host-specific code
>> +   generator into native instructions for the host CPU.
> 
> The sections below should be sorted according to these sections, when 
> applicable.
> 
> Register allocation also fits somewhere, probably in "back-end".
> 
> There should be also another sentence for the TCG run-time (accel/tcg).
>> +Register Allocation and Liveness
>> +--------------------------------
>> +
>> +During the translation phase, guest instructions are converted into 
>> TCG IR
>> +using an **unlimited number of temporaries (TEMPs)**.
>> +This allows guest translators to express logic without being constrained
>> +by the finite register set of the host CPU.
>> +
>> +To resolve these TEMPs into physical registers, TCG performs two passes:
>> +
>> +1. **Liveness Analysis**: This pass determines the "live range" of each
>> +   temporary within a basic block. By identifying when a variable
>> +   becomes "dead" (i.e., its value is no longer needed), TCG can 
>> suppress
>> +   redundant moves and remove instructions that compute unused results.
>> +2. **Register Allocation**: The Global Register Allocator maps live 
>> TEMPs
>> +   to host physical registers. Fixed globals, such as the pointer
>> +   to the CPU architecture state (``cpu_env``), are often permanently
>> +   held in host registers to minimize memory traffic during execution.
>> +
>> +Vector/SIMD Internal Strategy
>> +-----------------------------
>> +
>> +TCG supports SIMD operations through a set of generic vector 
>> instructions
>> +(e.g., ``add_vec``, ``shli_vec``) parameterized by vector length and 
>> element
>> +size. The length is specified as a ``TCGType`` (V64, V128, or V256), 
>> and the
>> +element size is given in log2 8-bit units.
>> +
>> +The internal strategy relies on the backend mapping these generic 
>> opcodes
>> +to native host SIMD instructions, such as x86 AVX or ARM NEON. If the 
>> host
>> +backend does not support a specific vector operation  or length, TCG's
>> +expansion layer automatically decomposes the opcode into smaller 
>> supported
>> +vector sizes or standard integer operations.
>> +
>> +Deterministic Execution (icount)
>> +--------------------------------
>> +
>> +The :ref:`icount` mechanism provides deterministic execution by ensuring
>> +that each Translation Block executes a fixed number of instructions.
> 
> Hallucination (to put it kindly).  It ensures that QEMU_CLOCK_VIRTUAL is 
> a multiple of the number of instructions executed.
> 
>> This
>> +is essential for features like record/replay and deterministic 
>> virtual time,
>> +where instruction counts serve as the system clock.
>> +
>> +Instrumentation and Plugins
>> +---------------------------
>> +
>> +:ref:`TCG Plugins` provide a mechanism for runtime instrumentation. 
>> Opcodes
>> +like ``plugin_cb`` and ``plugin_mem_cb`` are inserted during 
>> translation to
>> +trigger callbacks in external modules, allowing analysis of instruction
>> +execution or memory access.
>> +
>> +Instruction Decoding (decodetree)
>> +---------------------------------
>> +
>> +The first step of the translation process is converting a raw 
>> bitstream of
>> +guest instructions into a structured format that the translator can 
>> process.
> 
> Is this true?  Maybe "extracting operands from the raw bitstream of 
> guest instructions, for easier processing in the translator"?
> 
>> +QEMU simplifies this using the ``decodetree.py`` script, which 
>> generates C
>> +code decoders from a domain-specific language defined in ``.decode`` 
>> files.
>> +
>> +The decodetree tool allows developers to define instruction **patterns**
>> +based on a bitmask and fixed bits. When a match is found, the generated
>> +decoder automatically  extracts defined **fields** (such as registers or
>> +immediates) and passes  them to a manually written translation function.
>> +
>> +This declarative approach drastically reduces the amount of error-prone
>> +manual bit-shifting and nested "if-else" logic required in guest 
>> translators.
> 
> I would just say "``decodetree`` simplifies writing and maintaining the 
> front-end compared to manual decoding".  Maybe it's worth adding 
> something like "Note however that it is mostly applicable to processors 
> whose instruction encoding is fixed length, or mostly fixed length.".
> 
>> +For detailled implementation see :ref:`decodetree`.
> 
> "detailed".
> 
> Honestly, I'm not impressed by the quality of the output.  There's no 
> organization, just a bunch of new sections in no order (decodetree comes 
> last).  They might be good enough for a glossary, but for developer 
> documentation it would just add structural debt(*).  At the very least 
> all the "----"-level sections should be split into front-end, 
> optimization, back-end and run-time.
> 
> Again, this is not about you---I hope you knew that this wasn't going to 
> be included as is. :)  Submitting this without manual editing shows the 
> baseline capabilities of the LLM and highlights the importance of human 
> steering.

Thanks for the quick feedback. Yeah I wanted to test the water with a
patch (and ought to post as RFC). Some TCG concepts are hard to grasp,
and I indeed trusted the LLM too much to be an English fluent and
technical expert. I told it "You are what best understand QEMU
internals, and a TCG expert. You don't make mistakes and do not lie.
You write in a perfectly understandable technical English language."

Blame on me for being to confident here <:)

> 
> Paolo
> 
> (*) I have just made this term up, but I think it should be a thing - we 
> have a lot of it already in QEMU docs
> 


