Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236DEC61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzM6J-0000Yd-DN; Wed, 26 Aug 2026 18:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nendensu@ispras.ru>)
 id 1wzM6H-0000YG-Aa; Wed, 26 Aug 2026 18:28:05 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nendensu@ispras.ru>)
 id 1wzM6F-0004tH-53; Wed, 26 Aug 2026 18:28:05 -0400
Received: from mail.ispras.ru (unknown [83.149.199.84])
 by mail.ispras.ru (Postfix) with ESMTPSA id D547040737A2;
 Wed, 26 Aug 2026 22:27:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D547040737A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1787783278;
 bh=pxpjJtrq7IRtQPwTLlPDihQrWVjfHKipPxwkahLd0lw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pX3IOBerzwwQ/jX4c5eb47/V2Ci1jbg4pd0gE7vvnPvKIZqvXc+/CLYnqIYPOwAOP
 nVaTxJOGX0Nb+ZdmiD7TbSPASlITXa077DXNPmydqKyMArEDL2pkMVaS+RgZPRmrg5
 9ZsGCZ4vUSsczwYJqHxqYD0cfRIRfpi04rRc7VcQ=
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 01:27:58 +0300
From: nendensu@ispras.ru
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, farosas@suse.de, lvivier@redhat.com
Subject: Re: [PATCH 0/2] target/riscv: Fix seed CSR sign extension
In-Reply-To: <e350bfda-cd57-4b25-9c72-40585e30a488@tls.msk.ru>
References: <20260802113130.7818-1-nendensu@ispras.ru>
 <e350bfda-cd57-4b25-9c72-40585e30a488@tls.msk.ru>
Message-ID: <a985157941bd10429a3048618e3fb977@ispras.ru>
X-Sender: nendensu@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=nendensu@ispras.ru;
 helo=mail.ispras.ru
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-08-25 10:11 AM, Michael Tokarev wrote:
> On 8/2/26 14:31, Ivan Efremov wrote:
>> The seed CSR value on RV64 was sign extended while converting to 
>> target_ulong.
>> 
>> The first patch makes SEED_OPST_* unsigned.
>> The second patch adds qtest to check that upper 32 bits are zero.
>> 
>> Tests ran:
>> - riscv-csr-test
>> - make check: 324 passed, 11 skipped
>> - RISC-V Zkr-00 architectural test
>> 
>> Ivan Efremov (2):
>>    target/riscv: Fix seed CSR sign extension
>>    tests/qtest: Add seed CSR zero extension test
> 
> I'm picking this patch set for the currently active qemu stable
> series (10.0 LTS, 11.0, 11.1).  However, it does not work on
> 11.0.x already (it works ok on 11.1.x), the test fails:
> 
> TAP version 14
> # random seed: R02Sac6635c76a7dc335fadd70845da72f99
> 1..2
> # Start of riscv64 tests
> # Start of cpu tests
> # starting QEMU: exec ./qemu-system-riscv64 -qtest 
> unix:/tmp/qtest-182934.sock -qtest-log /dev/null -chardev 
> socket,path=/tmp/qtest-182934.qmp,id=char0 -mon 
> chardev=char0,mode=control -display none -audio none -run-with 
> exit-with-parent=on -machine virt -cpu veyron-v1 -accel qtest
> ok 1 /riscv64/cpu/csr
> # Start of csr tests
> # starting QEMU: exec ./qemu-system-riscv64 -qtest 
> unix:/tmp/qtest-182934.sock -qtest-log /dev/null -chardev 
> socket,path=/tmp/qtest-182934.qmp,id=char0 -mon 
> chardev=char0,mode=control -display none -audio none -run-with 
> exit-with-parent=on -machine virt -cpu tt-ascalon -accel qtest
> **
> ERROR:../../build/qemu/11.0/hw/riscv/riscv_hart.c:78:csr_call: 
> assertion failed: (ret == RISCV_EXCP_NONE)
> Bail out! 
> ERROR:../../build/qemu/11.0/hw/riscv/riscv_hart.c:78:csr_call: 
> assertion failed: (ret == RISCV_EXCP_NONE)
> Broken pipe
> ../../build/qemu/11.0/tests/qtest/libqtest.c:210: kill_qemu() detected 
> QEMU death from signal 6 (Aborted)
> Aborted
> 
> Should I pick something else for 11.0 and 10.0 (on 10.0 it fails the 
> same way),
> so the test succeeds, or should I drop this patch set from 11.1.x?
> 
> Thanks,
> 
> /mjt
Thank you for testing. From my runs it seems that 10.0, 11.0 lack commit 
569aa628 (target/riscv: tt-ascalon: Enable Zkr extension), which enables 
Zkr for tt-ascalon, so reading the seed triggers an assertion in 
csr_call. Apologies if I`m missing something here. I`m not sure which is 
better for stable: backporting 569aa628, or skipping the test patch.

Best regards,
Ivan Efremov

