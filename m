Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917F606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=MrK2+MrR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2JV-00059v-Il; Wed, 28 Oct 2026 07:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xM2JH-00050M-8A; Wed, 28 Oct 2026 07:59:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xM2JE-0006MU-MV; Wed, 28 Oct 2026 07:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793188748; bh=X6KNqLjLKsXRH3CJc+TSJaxpUTE1hWW3xLDU5lub1Gc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=MrK2+MrRITi13nDYDbyDNHsGUvtSrN4FbAD6lbfxnc4d2rnSl6m2scGd/VbQGQJFf
 H1UjQTPjeZa3zCnKM7zlpPER2mW6qHjCXWisED8jCY9Axy5c2mmG3LdPTloGx0dMGK
 al9QucCVeDjUN+KPNDcxZIjQrz545jfuZR50SJ4tbhiA9+3jcLKZ0mHPPZ7XctFy5V
 W0VEBL4Jy9ldSDSJmsFuxJ+bDkZMQvV/fycrQ2q5oBrqRWI95+mkAa39RDyyHPu9od
 dkOpQhwX0JsmmO8R28lKTbtVB6/QDL7PteF62kvKvyd7gl/D+Rthwoy35nVWedoQ4p
 7LRsmpcNsIBFA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BA7EB1E1E57;
 Wed, 28 Oct 2026 14:59:08 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 95C1944D703;
 Wed, 28 Oct 2026 14:59:08 +0300 (MSK)
Message-ID: <4b06318e-a363-4ac3-b087-6ac0d605005b@tls.msk.ru>
Date: Wed, 28 Oct 2026 14:59:08 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: fix uninitialised upper half in
 pmu_timer_trigger_irq()
To: Harshit Mukhedkar <harshit007k@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-stable@nongnu.org
References: <20261023093522.34335-1-harshit007k@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261023093522.34335-1-harshit007k@gmail.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 12:35, Harshit Mukhedkar wrote:
> pmu_timer_trigger_irq() reads the counter by passing
> (target_ulong *)&curr_ctr_val to riscv_pmu_read_ctr(). On RV32 that
> pointer is to a 32 bit type, so only half of the uint64_t gets written
> and the rest is whatever was on the stack. The high word read from
> riscv_pmu_read_ctr() is then ORed in on top of that, and the result is
> compared against the software written counter to decide whether to raise
> LCOFI. A stray bit in the garbage half can make that comparison wrong.
> 
> Read the low and high halves into their own target_ulong variables and
> assemble the 64-bit value explicitly.
> 
> This was found while looking at #4724, whose reported mhpmcounterh
> mismatch is fixed separately by 57b484e2d232.
> 
> Fixes: 74112400df65 ("target/riscv: More accurately model priv mode filtering.")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Harshit Mukhedkar <harshit007k@gmail.com>

This change has been marked for-stable.  However, just like a previous
change for RV32, I'm not applying it to 10.0.x branch, because it lacks
a few other commits in this area, and because RV32 is a very niche
platform to support in older stable releases.  Only 11.1.x gets it.

FWIW.

Thanks,

/mjt

