Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07998606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=D2AWVZmM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQ6U-00083Y-Gt; Wed, 21 Oct 2026 02:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJQ6B-00081f-UA
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:46:58 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJQ68-0005nN-VM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:46:55 -0400
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792565210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zYi9+hUERbBWZ+iFNVKnfXcdc4fIOpc033d9WEysbwk=;
 b=D2AWVZmMrO+YtC7Ka1SjprM389WNIpUUvVbyAA+vOioFgpeIgB8fOzDuqGbgkO8g3l4pZM
 UkBWXF69+QQf81byqC/+N5ztKc3gBjdeqWqm24dZVUpOqDjYkdr7Whf0wQUtzFyjA1/cl1
 5HvV7BTHqJ1Wyn3fdNit9GJ94oHGke8=
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, Stian Halseth <stian@itx.no>
Subject: [PATCH v2 0/7] target/sparc: Add support for SPARC crypto instructions
Date: Wed, 21 Oct 2026 08:46:33 +0200
Message-ID: <20261021064640.3591682-1-stian@itx.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series implements SPARC crypto instructions for QEMU. Most other
arches already support crypto instructions, but SPARC is lagging behind.

The following instructions are added:
- AES rounds and key expansions
- CRC32C
- SHA1/256/512
- RDCFR (Compatibility Feature Register)

Camellia is intentionally left out as it's possibly being removed from
the kernel code, and does not seem to be needed. DES/MD5/MPMUL also left
out, as Linux doesn't use them.

Motivated by the need for QEMU-testable SPARC crypto code without access
to real hardware. An issue was raised by kernel maintainer Eric Biggers
in: https://github.com/sparclinux/issues/issues/77

A new +crypto CPU feature enables the instructions and the CFR. This is
off by default, and does not change default behaviour.

The most difficult part to get right, and the biggest patch, was the
SHA instructions. On SPARC, a single instruction hashes one whole block.
sha1, sha256 and sha512 each do a complete FIPS 180-4 compression.

Testing:
- Every instruction tested against SPARC T4-1 and SPARC T7-1
- Tested QEMU on big-endian host (sparc64 T7-1)
- Linux 7.3-rc5 crypto and CRC KUnit suites (208 passed, 0 failed)

The Linux test used an unsent kernel patch plus -prom-env nvramrc.

AI tool disclosure:
- An early incomplete prototype was made using LLM tools
- Used to research the OSA 2011 and FIPS 180-4 document. Implementation
  strategies and review of the _existing_ QEMU code.
- Local test tooling. Scripts for comparing the output vs real SPARC
  hardware.
- Review of patches, fixes made by me
- No code, comments or commit messages directly from AI tools

References:
OSA (Oracle SPARC Architecture) 2011:
https://www.oracle.com/technetwork/server-storage/sun-sparc-enterprise/documentation/140521-ua2011-d096-p-ext-2306580.pdf

qemu-devel RFC:
https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg09494.html

Changes in v2:
- 1/7: use suggested commit message (Philippe); R-b Philippe
- 2/7: start with an empty CFR. Bits set in each instruction patch
- 3/7: byte-order comment, rk half zeroed explicitly; T-b Philippe
- 4/7: sets CFR.aes; "3-operand"/"4-operand" wording.
- 5/7: sets CFR.crc32c; "3-operand" wording; explicit 64-bit return;
       R-b + T-b Philippe
- 6/7: sets the SHA bits; comment on the narrowing; R-b + T-b Philippe
- 7/7: -cpu TI-UltraSparc-II,+crypto mentioned; R-b Philippe
- Tests: Follow-up, as agreed (Philippe)

v1: https://lore.kernel.org/qemu-devel/20261020145530.3385376-1-stian@itx.no/

Stian Halseth (7):
  target/sparc: Add crypto feature
  target/sparc: Return CFR when crypto feature is enabled
  target/sparc: Add the eight AES round instructions
  target/sparc: Add the AES key expansion instructions
  target/sparc: Add the CRC32C instruction
  target/sparc: Add the SHA instructions
  linux-user/sparc: Report HWCAP_SPARC_CRYPTO for crypto CPU feature

 linux-user/sparc/elfload.c     |   1 +
 target/sparc/cpu-feature.h.inc |   1 +
 target/sparc/cpu.c             |   3 +
 target/sparc/crypto_helper.c   | 442 +++++++++++++++++++++++++++++++++
 target/sparc/helper.h          |  16 ++
 target/sparc/insns.decode      |  26 +-
 target/sparc/meson.build       |   2 +-
 target/sparc/translate.c       |  81 ++++++
 8 files changed, 570 insertions(+), 2 deletions(-)
 create mode 100644 target/sparc/crypto_helper.c


base-commit: 11661d857254b27fca5568c6deacf4f6b6f3460f
-- 
2.43.0


