Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC917C61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylKc-0004SI-84; Tue, 25 Aug 2026 03:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylKa-0004JN-5J; Tue, 25 Aug 2026 03:12:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylKY-00077U-DC; Tue, 25 Aug 2026 03:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641903; bh=7xb9enhUKDyhCmqCLRelZQYgOujhFvjWLt6eabUybBQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=LTpp8kbd2V3lOyBfingE/cVKVZqukP6Sm62Ce7AuMKCkJ99/pIKuDWSDuaZZz4jLl
 Cr9g0nf7xNZrHrUEnC9l0kzYZ6TNNUjxDkpRIDYcrqUZWEgDcB0JvHCUWQTgqadmun
 fAJdnGcZSGzPsxfeh7+m2/jv4Ohvk4040+Kz2rgwNnFMo6gFSCAieQSgmF7llFqR/d
 U0K6Y8ueawqNRXHtLpdFE26U/nwTDtRvNLtECgkJ1idVBf0D9Wfc8PyHzzzNFRT7m+
 lBNc9wiRV4DHx6jAoe9sIOzcdHJUSoHFaqXVw3pnFkFt0xQU27mrCq+YTuMBw3SCy2
 7q0Qw/+Tv8+dA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD99C1CE258;
 Tue, 25 Aug 2026 10:11:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6D2F4415FC3;
 Tue, 25 Aug 2026 10:12:20 +0300 (MSK)
Message-ID: <e350bfda-cd57-4b25-9c72-40585e30a488@tls.msk.ru>
Date: Tue, 25 Aug 2026 10:11:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/riscv: Fix seed CSR sign extension
To: Ivan Efremov <nendensu@ispras.ru>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 farosas@suse.de, lvivier@redhat.com
References: <20260802113130.7818-1-nendensu@ispras.ru>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260802113130.7818-1-nendensu@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/2/26 14:31, Ivan Efremov wrote:
> The seed CSR value on RV64 was sign extended while converting to target_ulong.
> 
> The first patch makes SEED_OPST_* unsigned.
> The second patch adds qtest to check that upper 32 bits are zero.
> 
> Tests ran:
> - riscv-csr-test
> - make check: 324 passed, 11 skipped
> - RISC-V Zkr-00 architectural test
> 
> Ivan Efremov (2):
>    target/riscv: Fix seed CSR sign extension
>    tests/qtest: Add seed CSR zero extension test

I'm picking this patch set for the currently active qemu stable
series (10.0 LTS, 11.0, 11.1).  However, it does not work on
11.0.x already (it works ok on 11.1.x), the test fails:

TAP version 14
# random seed: R02Sac6635c76a7dc335fadd70845da72f99
1..2
# Start of riscv64 tests
# Start of cpu tests
# starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-182934.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-182934.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -machine virt -cpu 
veyron-v1 -accel qtest
ok 1 /riscv64/cpu/csr
# Start of csr tests
# starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-182934.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-182934.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -machine virt -cpu 
tt-ascalon -accel qtest
**
ERROR:../../build/qemu/11.0/hw/riscv/riscv_hart.c:78:csr_call: assertion failed: (ret == RISCV_EXCP_NONE)
Bail out! ERROR:../../build/qemu/11.0/hw/riscv/riscv_hart.c:78:csr_call: assertion failed: (ret == RISCV_EXCP_NONE)
Broken pipe
../../build/qemu/11.0/tests/qtest/libqtest.c:210: kill_qemu() detected QEMU death from signal 6 (Aborted)
Aborted

Should I pick something else for 11.0 and 10.0 (on 10.0 it fails the same way),
so the test succeeds, or should I drop this patch set from 11.1.x?

Thanks,

/mjt

