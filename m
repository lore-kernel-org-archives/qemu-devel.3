Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDEDC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 07:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF6p2-0004G4-Eb; Wed, 14 May 2025 03:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1uF6oz-0004Fg-RD
 for qemu-devel@nongnu.org; Wed, 14 May 2025 03:46:33 -0400
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1uF6ow-0000Id-Pm
 for qemu-devel@nongnu.org; Wed, 14 May 2025 03:46:33 -0400
Received: from [192.168.1.4] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 54E7kJgV1188897
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Wed, 14 May 2025 07:46:22 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=UwW50cuy header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1747208785;
 bh=ouh2Gt06bzkO5uthzTqI7krTWBr8mkpoM9Mb0UjJ17M=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=UwW50cuyIwlOn13q67HnRliyPoey95Hniff+DNgUhGqJguNeqBq7eaOwVVMhrmgXZ
 YQxzqTev5uUS2LSt7Ax/fnjKzh6YEeTBYjV16DQO1eJWYu31ba0+RLeiQZRND2JM27
 Ir6MVyAoLgzhdQPTLtMjNlFIuzxBKcqIj07vE+d/47BkIF3VsbR1FNha6fq3vqMPkf
 Uv7sarpZbz6sclg8gp9CYQ2icrIa93U5TEwiQRJLfxRbM0zWOblfmfCqEIuAJGlKxT
 EbL37Q+d5J87s8aahoeIyXf201ucHJ1StjdaW8ySOwkprNeeXFjyBBq/83Gkn6H4xL
 /a0Ze7qE/xo1g==
Message-ID: <4d13e769-b2f7-4afe-be77-c9525141548e@anarch128.org>
Date: Wed, 14 May 2025 19:46:14 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] x86-disas: port x86-mini disassembler to QEMU
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250514073927.2735727-1-michael@anarch128.org>
Content-Language: en-US
From: Michael Clark <michael@anarch128.org>
In-Reply-To: <20250514073927.2735727-1-michael@anarch128.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
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

Hi Folks,

this is tangentially related because it is the reason for
developing the x86 assembler and disassembler library.

introducing a new RISC instruction set with a variable length
instruction packet using a super regular extension scheme with
compression techniques to separate the instruction stream into
two streams, one for instructions and and one for constants:

- latest: https://metaparadigm.com/~mclark/glyph.pdf
- current: https://metaparadigm.com/~mclark/glyph-20250512.pdf
- emulator: https://github.com/michaeljclark/glyph

Michael.

On 5/14/25 19:39, Michael Clark wrote:
> a port of an embeddable x86-mini disassembler to QEMU.
> 
> - https://github.com/michaeljclark/qemu/tree/x86-mini-v3
> 
> # x86-mini disassembler
> 
> the x86-mini library is a lightweight x86 encoder, decoder, and
> disassembler that uses extensions to the Intel instruction set
> metadata format to encode modern VEX/EVEX instructions and legacy
> instructions using a parameterized LEX (legacy extension) format.
> 
> - metadata-driven disassembler with Intel format output.
> - written in C11 for compatibility with projects written in C.
> - low-level instruction encoder and decoder uses <= 32-bytes.
> - python tablegen program to generate C tables from CSV metadata.
> - metadata table tool to inspect operand encode and decode tables.
> - carefully checked machine-readable instruction set metadata.
> - support for REX/VEX/EVEX and preliminary support for REX2.
> 
> the x86-mini x86 encoder and decoder library has been written from
> scratch to be modern and as simple as possible while also covering
> recent additions to the Intel and AMD 64-bit instruction sets such
> as the EVEX encodings for recent AVX-512 extensions and soon REX2/
> EVEX encodings for Intel APX, as it is written with that in mind.
> 
> ## interest to the QEMU community
> 
> - x86-mini is fast. raw decode performance is ~100-200MiB/sec.
> - x86-mini is small. 5 files, ~5 KLOC or ~13 KLOC including tables.
> - x86-mini is complete and includes the latest AVX-512 extensions.
> - x86-mini is easy to extend and uses extended Intel format metadata.
> - x86-mini is documented with detailed info on the metadata format.
> - x86-mini has CLI tools for searching x86 instruction set metadata.
> 
> it would be nice to have an x86 disassembler building out-of-the-box
> as I find QEMU's built-in tracing extremely useful and given x86 is
> a popular target, a small embedded disassembler might be useful.
> 
> - https://github.com/michaeljclark/x86/tree/x86-mini
> 
> ## techinical notes
> 
> - the decoder is table-based and uses a metadata interpreter.
> - the decode table is ~66KiB with a ~150KiB acceleration trie.
> - there are currently 3658 opcode entries active on x86-64
>    which expands to 4775 table entries due to parameterization.
> 
> after cherry-picking the commits, one can test host and target
> disassembly support. e.g. for an x86-64 target on an x86-64 host:
> 
> $ echo aaa | qemu-x86_64 -d in_asm,out_asm /usr/bin/openssl sha256
> 
> ## caveats
> 
> - supports 32-bit and 64-bit disassembly, and theoretically 16-bit.
> - designed to support 16-bit. base index formats are not done yet.
> - x86-64 is exhaustively fuzz-tested against the LLVM disassembler.
> - but x86-mini is new and hasn't been battle-tested in production.
> 
> ## conclusion
> 
> the metadata is based on x86-csv but has had numerous inaccuracies
> fixed plus conversion of legacy instructions to the new LEX format.
> in effect the metadata has been fuzz-tested against LLVM for x86-64
> and ISA coverage is in the order of ~99.9%. the main branch of the
> linked repo has a procedural fuzzer for metadata-based instruction
> synthesis that could be useful for generating test cases for QEMU.
> 
> ## summary of changes
> 
> v3
> - add SPDX license identifier to source files.
> - fix some typographical mistakes in header comments.
> - add control register, debug register, and MSR enumerations.
> - add x86_flag enumeration values for rflags register.
> - removed custom snprintf.
> 
> v2
> - improve grouping of encode, decode, and disasm functions.
> - fix some metadata documentation errors and ommissions.
> - use g_malloc/g_malloc0/g_free instead of malloc/calloc/free.
> - use cpu_to_{le16|le32|le64}, {le16|le32|le64}_to_cpu.
> - move bitfield documentation comments next to definitions.
> - redefine condition codes enum and remove redundant functions.
> - reduce snprintf performance cost with optimized version.
> - remove duplicate unused definition of ctz/clz/popcnt.
> - remove duplicate host endianness conversion functions.
> - remove some magic constants and replace with math.
> - remove some unnecessary casts.
> 
> v1
> - simplification to memory operand formatting logic.
> - fixed VSIB pointer formatting for consistency with LLVM.
> - 64-bit disasembly exhaustively fuzz tested against LLVM.
> - includes x86 metadata and x86-tablegen.py python script.
> - includes x86 metadata opcode and operand documentation.
> - addressed non-whitespace related checkpatch.pl warnings.
> 
> Michael Clark (4):
>    x86-disas: add x86-mini instruction set metadata
>    x86-disas: add x86-mini metadata documentation
>    x86-disas: add x86-mini metadata tablegen script
>    x86-disas: add x86-mini disassembler implementation
> 
>   disas/disas-host.c                        |    5 +
>   disas/meson.build                         |   97 +
>   disas/x86-core.c                          | 2716 +++++++++++++++++++++
>   disas/x86-data/x86_adx.csv                |    5 +
>   disas/x86-data/x86_aes.csv                |   13 +
>   disas/x86-data/x86_aeskle.csv             |    3 +
>   disas/x86-data/x86_aesklewide.csv         |    3 +
>   disas/x86-data/x86_avx.csv                |  375 +++
>   disas/x86-data/x86_avx2.csv               |  171 ++
>   disas/x86-data/x86_avx5124fmaps.csv       |    5 +
>   disas/x86-data/x86_avx5124vnniw.csv       |    3 +
>   disas/x86-data/x86_avx512b.csv            |    3 +
>   disas/x86-data/x86_avx512bf16.csv         |   10 +
>   disas/x86-data/x86_avx512bitalg.csv       |   10 +
>   disas/x86-data/x86_avx512bw.csv           |  291 +++
>   disas/x86-data/x86_avx512cd.csv           |   19 +
>   disas/x86-data/x86_avx512d.csv            |    2 +
>   disas/x86-data/x86_avx512dq.csv           |  143 ++
>   disas/x86-data/x86_avx512er.csv           |   11 +
>   disas/x86-data/x86_avx512f.csv            |  901 +++++++
>   disas/x86-data/x86_avx512fp16.csv         |  237 ++
>   disas/x86-data/x86_avx512ifma.csv         |    7 +
>   disas/x86-data/x86_avx512pf.csv           |   17 +
>   disas/x86-data/x86_avx512vbmi.csv         |   13 +
>   disas/x86-data/x86_avx512vbmi2.csv        |   61 +
>   disas/x86-data/x86_avx512vl.csv           |    2 +
>   disas/x86-data/x86_avx512vnni.csv         |   13 +
>   disas/x86-data/x86_avx512vp2intersect.csv |    7 +
>   disas/x86-data/x86_avx512vpopcntdq.csv    |    7 +
>   disas/x86-data/x86_avxneconvert.csv       |   15 +
>   disas/x86-data/x86_avxvnni.csv            |    9 +
>   disas/x86-data/x86_avxvnniint8.csv        |   13 +
>   disas/x86-data/x86_base.csv               |  549 +++++
>   disas/x86-data/x86_bmi1.csv               |   13 +
>   disas/x86-data/x86_bmi2.csv               |   17 +
>   disas/x86-data/x86_cet.csv                |   15 +
>   disas/x86-data/x86_cldemote.csv           |    2 +
>   disas/x86-data/x86_clwb.csv               |    2 +
>   disas/x86-data/x86_enqcmd.csv             |    3 +
>   disas/x86-data/x86_f16c.csv               |    5 +
>   disas/x86-data/x86_fma.csv                |   97 +
>   disas/x86-data/x86_fsgsbase.csv           |    9 +
>   disas/x86-data/x86_gfni.csv               |   19 +
>   disas/x86-data/x86_hreset.csv             |    2 +
>   disas/x86-data/x86_invpcid.csv            |    2 +
>   disas/x86-data/x86_lzcnt.csv              |    3 +
>   disas/x86-data/x86_mmx.csv                |   60 +
>   disas/x86-data/x86_movdir64b.csv          |    2 +
>   disas/x86-data/x86_movdiri.csv            |    3 +
>   disas/x86-data/x86_mpx.csv                |    9 +
>   disas/x86-data/x86_msrlist.csv            |    4 +
>   disas/x86-data/x86_ospke.csv              |    3 +
>   disas/x86-data/x86_pclmulqdq.csv          |    3 +
>   disas/x86-data/x86_pconfig.csv            |    2 +
>   disas/x86-data/x86_prefetchw.csv          |    7 +
>   disas/x86-data/x86_raoint.csv             |    9 +
>   disas/x86-data/x86_rdpid.csv              |    2 +
>   disas/x86-data/x86_rdrand.csv             |    2 +
>   disas/x86-data/x86_rdseed.csv             |    2 +
>   disas/x86-data/x86_rtm.csv                |    5 +
>   disas/x86-data/x86_serialize.csv          |    2 +
>   disas/x86-data/x86_sha.csv                |    8 +
>   disas/x86-data/x86_smap.csv               |    3 +
>   disas/x86-data/x86_sse.csv                |   58 +
>   disas/x86-data/x86_sse2.csv               |  148 ++
>   disas/x86-data/x86_sse3.csv               |   11 +
>   disas/x86-data/x86_sse4_1.csv             |   48 +
>   disas/x86-data/x86_sse4_2.csv             |    7 +
>   disas/x86-data/x86_sse4_3.csv             |    2 +
>   disas/x86-data/x86_ssse3.csv              |   33 +
>   disas/x86-data/x86_uintr.csv              |    6 +
>   disas/x86-data/x86_vaes.csv               |   17 +
>   disas/x86-data/x86_vmx.csv                |   14 +
>   disas/x86-data/x86_waitpkg.csv            |    4 +
>   disas/x86-data/x86_wbnoinvd.csv           |    2 +
>   disas/x86-data/x86_x87.csv                |  145 ++
>   disas/x86-data/x86_xsaveopt.csv           |    3 +
>   disas/x86-disas.c                         |   96 +
>   disas/x86.h                               | 1860 ++++++++++++++
>   docs/x86-metadata.txt                     |  303 +++
>   include/disas/dis-asm.h                   |    1 +
>   scripts/x86-tablegen.py                   |  695 ++++++
>   target/i386/cpu.c                         |    7 +
>   83 files changed, 9511 insertions(+)
>   create mode 100644 disas/x86-core.c
>   create mode 100644 disas/x86-data/x86_adx.csv
>   create mode 100644 disas/x86-data/x86_aes.csv
>   create mode 100644 disas/x86-data/x86_aeskle.csv
>   create mode 100644 disas/x86-data/x86_aesklewide.csv
>   create mode 100644 disas/x86-data/x86_avx.csv
>   create mode 100644 disas/x86-data/x86_avx2.csv
>   create mode 100644 disas/x86-data/x86_avx5124fmaps.csv
>   create mode 100644 disas/x86-data/x86_avx5124vnniw.csv
>   create mode 100644 disas/x86-data/x86_avx512b.csv
>   create mode 100644 disas/x86-data/x86_avx512bf16.csv
>   create mode 100644 disas/x86-data/x86_avx512bitalg.csv
>   create mode 100644 disas/x86-data/x86_avx512bw.csv
>   create mode 100644 disas/x86-data/x86_avx512cd.csv
>   create mode 100644 disas/x86-data/x86_avx512d.csv
>   create mode 100644 disas/x86-data/x86_avx512dq.csv
>   create mode 100644 disas/x86-data/x86_avx512er.csv
>   create mode 100644 disas/x86-data/x86_avx512f.csv
>   create mode 100644 disas/x86-data/x86_avx512fp16.csv
>   create mode 100644 disas/x86-data/x86_avx512ifma.csv
>   create mode 100644 disas/x86-data/x86_avx512pf.csv
>   create mode 100644 disas/x86-data/x86_avx512vbmi.csv
>   create mode 100644 disas/x86-data/x86_avx512vbmi2.csv
>   create mode 100644 disas/x86-data/x86_avx512vl.csv
>   create mode 100644 disas/x86-data/x86_avx512vnni.csv
>   create mode 100644 disas/x86-data/x86_avx512vp2intersect.csv
>   create mode 100644 disas/x86-data/x86_avx512vpopcntdq.csv
>   create mode 100644 disas/x86-data/x86_avxneconvert.csv
>   create mode 100644 disas/x86-data/x86_avxvnni.csv
>   create mode 100644 disas/x86-data/x86_avxvnniint8.csv
>   create mode 100644 disas/x86-data/x86_base.csv
>   create mode 100644 disas/x86-data/x86_bmi1.csv
>   create mode 100644 disas/x86-data/x86_bmi2.csv
>   create mode 100644 disas/x86-data/x86_cet.csv
>   create mode 100644 disas/x86-data/x86_cldemote.csv
>   create mode 100644 disas/x86-data/x86_clwb.csv
>   create mode 100644 disas/x86-data/x86_enqcmd.csv
>   create mode 100644 disas/x86-data/x86_f16c.csv
>   create mode 100644 disas/x86-data/x86_fma.csv
>   create mode 100644 disas/x86-data/x86_fsgsbase.csv
>   create mode 100644 disas/x86-data/x86_gfni.csv
>   create mode 100644 disas/x86-data/x86_hreset.csv
>   create mode 100644 disas/x86-data/x86_invpcid.csv
>   create mode 100644 disas/x86-data/x86_lzcnt.csv
>   create mode 100644 disas/x86-data/x86_mmx.csv
>   create mode 100644 disas/x86-data/x86_movdir64b.csv
>   create mode 100644 disas/x86-data/x86_movdiri.csv
>   create mode 100644 disas/x86-data/x86_mpx.csv
>   create mode 100644 disas/x86-data/x86_msrlist.csv
>   create mode 100644 disas/x86-data/x86_ospke.csv
>   create mode 100644 disas/x86-data/x86_pclmulqdq.csv
>   create mode 100644 disas/x86-data/x86_pconfig.csv
>   create mode 100644 disas/x86-data/x86_prefetchw.csv
>   create mode 100644 disas/x86-data/x86_raoint.csv
>   create mode 100644 disas/x86-data/x86_rdpid.csv
>   create mode 100644 disas/x86-data/x86_rdrand.csv
>   create mode 100644 disas/x86-data/x86_rdseed.csv
>   create mode 100644 disas/x86-data/x86_rtm.csv
>   create mode 100644 disas/x86-data/x86_serialize.csv
>   create mode 100644 disas/x86-data/x86_sha.csv
>   create mode 100644 disas/x86-data/x86_smap.csv
>   create mode 100644 disas/x86-data/x86_sse.csv
>   create mode 100644 disas/x86-data/x86_sse2.csv
>   create mode 100644 disas/x86-data/x86_sse3.csv
>   create mode 100644 disas/x86-data/x86_sse4_1.csv
>   create mode 100644 disas/x86-data/x86_sse4_2.csv
>   create mode 100644 disas/x86-data/x86_sse4_3.csv
>   create mode 100644 disas/x86-data/x86_ssse3.csv
>   create mode 100644 disas/x86-data/x86_uintr.csv
>   create mode 100644 disas/x86-data/x86_vaes.csv
>   create mode 100644 disas/x86-data/x86_vmx.csv
>   create mode 100644 disas/x86-data/x86_waitpkg.csv
>   create mode 100644 disas/x86-data/x86_wbnoinvd.csv
>   create mode 100644 disas/x86-data/x86_x87.csv
>   create mode 100644 disas/x86-data/x86_xsaveopt.csv
>   create mode 100644 disas/x86-disas.c
>   create mode 100644 disas/x86.h
>   create mode 100644 docs/x86-metadata.txt
>   create mode 100755 scripts/x86-tablegen.py
> 


