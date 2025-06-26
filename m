Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28F6C7EE31
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 19:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUsRR-00061H-A1; Thu, 26 Jun 2025 15:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uUqjN-0006O0-SC
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 13:49:50 -0400
Received: from quyllur.org ([185.247.226.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uUqjK-0003My-Kw
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 13:49:49 -0400
Received: from quyllur.org (localhost [127.0.0.1])
 by quyllur.org (OpenSMTPD) with ESMTP id 44a084c1
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 20:49:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=quyllur.org; h=message-id
 :date:mime-version:to:from:subject:content-type
 :content-transfer-encoding; s=dkimselector; bh=ohDy2Pb/0xkdaoDuu
 /K+6q5Rzn8=; b=Ih5uf73lmMfCoHBu3QvWywqOkInAxZGtEeM3ErQ7ts1XnKuNl
 PVUVBmpgUjR7eDmD5sR4Ya55x4gMjnGTXW24GXu8LcG36WlueA4O3vIjES0h2n+7
 MgfEmF1yFAvfj2asj1ZZDILagnRfaViPmbp5JirgPzucXXpTHUGh1ayzjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=quyllur.org; h=message-id
 :date:mime-version:to:from:subject:content-type
 :content-transfer-encoding; q=dns; s=dkimselector; b=w/b4rQMivFG
 lTVKG74NJrmkHZ+bg9ryfVkgnQ4FHJ+GsUNQqxSu7FYpjQCvYG5rAj8m1t3t9xL7
 igMH7As0onJUsh5mes/qLRHpLFZ4mQIGgYovgA3N9gLQmN+AENl61X8TZrstspF7
 fPlhyyRPKw3dE8YSyzndrPI/QOI+iDhQ=
Received: from [10.137.0.57] (<unknown> [185.65.134.217])
 by quyllur.org (OpenSMTPD) with ESMTPSA id 16f0f22e
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 20:49:05 +0300 (EEST)
Message-ID: <76c629ab-7ffd-48e7-b442-1afe74e58180@quyllur.org>
Date: Thu, 26 Jun 2025 12:48:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Rot127 <unisono@quyllur.org>
Subject: TCG plugins segfault for Sparc, seemingly related to -d plugin
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.247.226.42; envelope-from=unisono@quyllur.org;
 helo=quyllur.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Jun 2025 15:39:12 -0400
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

Sparc QEMU segfaults directly if a TCG plugin is used but no logging is 
specified via `-d plugin`.
If logging is enabled it segfaults also. But a little later.

I tested it also with PPC32 and Hexagon. They seem to work fine.

Host: Fedora 41 - Linux 6.12.25-1.qubes.fc37.x86_64

Anyone had this problem before as well?

## Steps to reproduce

Build
```bash
mkdir build
cd build
../configure --disable-capstone  --enable-plugins --enable-asan 
--enable-debug 
--target-list=sparc-linux-user,sparc64-linux-user,hexagon-linux-user,ppc-linux-user
ninja
```

Run with `execlog` plugin:

```
./qemu-sparc64 -plugin file=./contrib/plugins/libexeclog.so 
~/Downloads/base77/bin/ls
Segmentation fault (core dumped)
./qemu-sparc64 -plugin file=./contrib/plugins/libexeclog.so -d plugin 
~/Downloads/base77/bin/ls
0, 0x7160e0600380, 0x10bc, "mov  %g0, %fp"
0, 0x7160e0600384, 0xb0a0239c, "sub  %sp, 0xb0, %sp"
0, 0x7160e0600388, 0xafa803a6, "add  %sp, 0x8af, %l3"
# snip ...
0, 0x7160e0600608, 0x440a180, "cmp  %g5, %g4"
0, 0x7160e060060c, 0x19006008, "bleu,pn   %xcc, "
0, 0x7160e0600610, 0xff3f1082, "mov  -1, %g1"
0, 0x7160e0600614, 0x2070309b, "srlx  %g1, 0x20, %o5"
0, 0x7160e0600618, 0x82059c6, "ldx  [ %g4 + 8 ], %g3"
Segmentation fault (core dumped)
```

Sparc binaries: 
https://ftp2.eu.openbsd.org/pub/OpenBSD/7.7/sparc64/base77.tgz
Gitlab issue: https://gitlab.com/qemu-project/qemu/-/issues/3008


