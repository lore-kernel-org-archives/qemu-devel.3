Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=l6nOfXGa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDgG-0003hD-Gs; Fri, 23 Oct 2026 07:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xKDg9-0003ga-TQ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:43:22 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xKDg7-0006oK-HN
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:43:21 -0400
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792755796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uu9Sq8gdJzlF+8s3EV1WZMilWQ0P3YgwHZkCaA8XErE=;
 b=l6nOfXGa6ohWsD3bL60e2qUK/fhq++WKym77lSe5XM0E6tjfqFcwqX57F0p0eAy1ti4YBf
 5OQXmNUrslMODDS8gWYXlgrKw2e6A9Yyya8tgRiDTcPKo78b9GAqk0R2GdL/4Z492GLyY+
 Kj+wF5EHyjvCWSCKyvYRIanbFWgZGHA=
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, Stian Halseth <stian@itx.no>
Subject: [PATCH 0/2] target/sparc: Block-init stores for the crypto feature
Date: Fri, 23 Oct 2026 13:43:00 +0200
Message-ID: <20261023114303.576319-1-stian@itx.no>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This completes the SPARC crypto series. It goes on top of patches 1-6 of
v3 and replaces the withdrawn 7/8 and 8/8.

With the crypto feature, guests treat the CPU as a T4 or later. On those
CPUs a block-initializing store (ASI 0xe2 and the other twin ASIs) to the
first doubleword of a 32-byte block also zeroes the rest of the block.
glibc's niagara4 memset and Linux's NG4memset depend on it, and OpenSSL's
T4 AES code uses the FP form (stdfa). Patch 1 models this for both forms;
patch 2 then reports HWCAP_SPARC_CRYPTO in linux-user, unchanged from v3
8/8.

Testing:
- Zero-fill behaviour measured on a SPARC T4 (stxa and stdfa, cached and
  uncached); QEMU now produces the same result.
- glibc memcpy/mempcpy/memset checked against byte loops over many sizes
  and alignments, with a Gentoo stage3 sysroot (multiarch glibc, niagara4
  routines): passes, and fails without patch 1.
- Real userspace from that stage3 under qemu-sparc64 with and without
  +crypto, output identical: OpenSSL (AES CBC/CTR/ECB/CFB/OFB, digests,
  HMAC, PBKDF2, RSA/EC, speed), Python, perl, coreutils, gzip/xz/bzip2,
  tar, sed/awk.
- Instruction vectors still match M7 silicon, also on a big-endian host;
  Linux crypto KUnit 208/0.

While testing I hit a separate upstream TCG crash in qemu-user, not caused
by this series. Testing these patches with real programs under qemu-user
is more reliable with that fix applied:
https://lore.kernel.org/qemu-devel/20261023113245.562358-1-stian@itx.no/

Based-on: <20261022070059.3861291-1-stian@itx.no>

Stian Halseth (2):
  target/sparc: Model block-initializing stores
  linux-user/sparc: Report HWCAP_SPARC_CRYPTO for crypto CPU feature

 linux-user/sparc/elfload.c |  1 +
 target/sparc/translate.c   | 42 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.43.0


