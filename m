Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C044E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBxD-0004mY-6e; Fri, 10 Jan 2025 05:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tWBxC-0004m4-70
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:09:22 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tWBx9-0004u5-T5
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:09:21 -0500
Received: from localhost.localdomain (default-rdns.vocus.co.nz
 [202.150.110.104] (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 50AA96QV1373110
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Fri, 10 Jan 2025 10:09:09 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=OI0HkQBj header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1736503750;
 bh=1n6KI0Q4uH1IgaUkQ2tkzkBToyc8YTrG4vuAOO6YuMs=;
 h=From:To:Cc:Subject:Date:From;
 b=OI0HkQBj22g1kKhe7fipHgP65qQp+A2Xpf9OD1LX/cej23F7E1I61WubOGiWR444j
 lYvP35I/ChX/Bk8515VVLkOp1gjagWjKx5Jt1t4UHe1mtInT+fKbH+XmQdDVU9Ro3l
 wCbKjaAkm/WsoSkux1VGWOymvi5LF1bJ+jdlrOgV7Wa2Cj4Yiohrs292hyW74TuhLP
 a0asKkr4TbZnSiBSvEru0cuicrDk7qWvd4DKP/kY0Jjupo526Spytpu7Sok39AMZv5
 pYq5P85BHBq0aL1a8X483KPXAGuk1sCvLhH2GfG+AjkkX3nHwHcRazH2/QecyYYZDH
 nvOc8jtssHM1A==
From: Michael Clark <michael@anarch128.org>
To: qemu-devel@nongnu.org
Cc: Michael Clark <michael@anarch128.org>
Subject: [RFC]: port of embedded x86-mini disassembler to QEMU
Date: Fri, 10 Jan 2025 23:08:21 +1300
Message-ID: <20250110100822.513498-1-michael@anarch128.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

a note to announce a port of the x86-mini disassembler to QEMU.

- https://github.com/michaeljclark/qemu/tree/x86-mini
- https://github.com/michaeljclark/x86/tree/x86-mini

# x86-mini

the x86-mini library is a lightweight x86 encoder, decoder, and
disassembler that uses extensions to the Intel instruction set
metadata format to encode modern VEX/EVEX instructions and legacy
instructions using a parameterized LEX (legacy extension) format.

- metadata-driven disassembler with Intel format output.
- written in C11 for compatibility with projects written in C.
- low-level instruction encoder and decoder uses <= 32-bytes.
- python tablegen program to generate C tables from CSV metadata.
- metadata table tool to inspect operand encode and decode tables.
- carefully checked machine-readable instruction set metadata.
- support for REX/VEX/EVEX and preliminary support for REX2.

the x86-mini x86 encoder and decoder library has been written from
scratch to be modern and as simple as possible while also covering
recent additions to the Intel and AMD 64-bit instruction sets such
as the EVEX encodings for recent AVX-512 extensions and soon REX2/
EVEX encodings for Intel APX, as it is written with that in mind.

## interest to the QEMU community

- x86-mini is fast. raw decode performance is ~100-200MiB/sec.
- x86-mini is small. 5 files, ~5 KLOC or ~13 KLOC including tables.
- x86-mini is complete and includes the latest AVX-512 extensions.
- x86-mini is easy to extend and uses extended Intel format metadata.
- x86-mini is documented with detailed info on the metadata format.
- x86-mini has CLI tools for searching x86 instruction set metadata.

## techinical notes

- the decoder is table-based and uses a metadata interpreter.
- the decode table is ~66KiB with a ~150KiB acceleration trie.
- there are currently 3658 opcode entries active on x86-64
  which expands to 4775 table entries due to parameterization.
- it could be made faster by vectorizing the prefix decoder and
  generating decode templates from the metadata to consteval
  metadata interpretation to eliminate some L1 D$ traffic.

after cherry-picking the commit, one can test host and target
disassembly support. e.g. for an x86-64 target on an x86-64 host:

$ echo aaa | qemu-x86_64 -d in_asm,out_asm /usr/bin/openssl sha256

## caveats and limitations

- supports 32-bit and 64-bit disassembly, and theoretically 16-bit.
- designed to support 16-bit but base index formats are not done yet.
- x86-64 is exhaustively fuzz-tested against the LLVM disassembler.
- but x86-mini is new and hasn't been battle-tested in production.

if you already link with capstone then it doesn't provide very many
immediate benefits, however, I think it is potentially useful as a
small embeddable disassembler to evaluate for potential inclusion.

## rationale

I worked on the QEMU disassembler while working on the QEMU RISC-V
target back in 2017/2018 and I was curious about vector support.
it seemed at the time that TCG vector support was piecemeal, plus
the old x86 disassembler seemed messy and incomplete. I also needed
an MIT-licensed disassembler to enable use in a commercial product.
basically, I was looking for a lightweight symmetric x86 instruction
encoder and decoder library in pure C with simple build requirements.
that is what prompted this initiative.

it would be nice to have an x86 disassembler building out-of-the-box
as I find QEMU's built-in tracing extremely useful and given x86 is
a popular target, a small embedded disassembler might be practical.

## summary and conclusion

at minimum, the metedata may be useful for x86 EVEX support. note
I see `tests/tcg/i386/x86.csv` in the source tree. the metadata is
also based on x86-csv but has had numerous inaccuracies fixed as
well as conversion of legacy instructions to the new LEX format.
in effect the metadata has been fuzz-tested against LLVM for x86-64
and ISA coverage is in the order of ~99.7%. the main branch of the
linked repo has a procedural fuzzer for metadata-based instruction
synthesis that could be useful for generating test cases for QEMU.

I am kind of throwing this over the fence, although the code is quite
self-contained and my stress and mental health is now under control.
also I have not yet run checkpatch.pl on this code. it is a preview.

x86-mini submaintainer.
Michael Clark.
--

