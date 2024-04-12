Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9037C04FF8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 16:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvK8v-0006wU-63; Fri, 12 Apr 2024 12:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rvK8s-0006vq-Pc; Fri, 12 Apr 2024 12:52:46 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rvK8p-0004jG-JD; Fri, 12 Apr 2024 12:52:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 6CFD5C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1712940757;
 bh=BBmmbKara4R1Zd8EtGoGIxyUR2plUHt+3L1+qAVxGCI=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=C1cssY2it4Qw2BByE/GVMXw4pMu+PQohpAo2Ct5Hy9VDOrLqZ2SuwjQd17LzbDGtD
 nO01hNDWh+hiCLqOUsE0Mr4/9dEdTUS1jAdmaTPgtFBQIy4k3nmSY9EaMYCqEBJ8fc
 fYxpt66UcA2zn9muUxQLOXmwtfgrPh3BFQXxVJlMygTjG0MEoAeGtVSO/7jLucgLli
 f/z3H+LfVVsLlMgLXZxDGI03nffb/VqWmJNdZklR0yusv+Hrlnfu/AHeICAaZfpHxE
 7SoXGezxC2QMUWSKmLSPKdI3jCF5RMaMD2HCbBAuDCkh1Vna213OJNM3qMie5w4uRA
 IoDW1woYwmdRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1712940757;
 bh=BBmmbKara4R1Zd8EtGoGIxyUR2plUHt+3L1+qAVxGCI=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=AnFg+CKxikn+x0pKN3mLt9cK3cLYhVOyM4oMr2uzsaBCXc9sWCjHTLv58lckyY/ts
 AvDawaZTOT/ZzoaoZBwYduhKjS6aPzHqkAABLJbAIM3LQ3HcJyQCMXrBLmXjzb0iON
 RBhZnSBUHUovbcFe5YyR/eFdElWbge5PSsDN1ueI10BzUCkGFIicPeY1v26p3B+r6M
 a79dU20gQ1vUHPpgS5wXCWZAiUb3QZ16HUGHRrbLthsNQqiVD799qHj5pKWrBnsJot
 rp7qdBNu/zsTnuoP8WKyNTAjGloG5EmzVo8c2o/Y78T0Ujqx3MFFfoZ5uC5ZqI3S+U
 A7mLODNCBfB+A==
Message-ID: <a4a23a7a-04fb-494d-b13a-933ab1a93ffa@syntacore.com>
Date: Fri, 12 Apr 2024 19:52:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <alistair.francis@wdc.com>, <bmeng@tinylab.org>, 
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <palmer@rivosinc.com>, 
 <richard.henderson@linaro.org>, Joseph Chan <jchan@ventanamicro.com>
References: <20240409175241.1297072-1-dbarboza@ventanamicro.com>
 <a8680fb3-8547-4b68-98d1-fd2d2d278375@syntacore.com>
 <6947ea59-ccbd-43b8-b8a0-bc543b9992f9@ventanamicro.com>
Content-Language: en-US
From: Aleksei Filippov <alexei.filippov@syntacore.com>
Organization: Syntacore
In-Reply-To: <6947ea59-ccbd-43b8-b8a0-bc543b9992f9@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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



On 12.04.2024 19:00, Daniel Henrique Barboza wrote:

> Thanks for giving it a go. You're right, this patch alone is not enough and we'll
> need your patch too.
> 
> But note that, with what you've said in mind, your patch will also end up setting
> mtval2 and env->guest_phys_fault_addr in case a PMP fault occurs during the
> get_physical_address() right at the start of second stage:
> 
>          if (ret == TRANSLATE_SUCCESS) {
>              /* Second stage lookup */
>              im_address = pa;
> 
>              ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
>                                         access_type, MMUIdx_U, false, true,
>                                         false);
> 
> 
> I think your patch needs to also prevent env->guest_phys_fault_addr to be set when
> ret == TRANSLATE_PMP_FAIL.
> 
> With these changes in your patch, and this patch, we're free to set 
> "first_stage_error = false;"
> at the start of second stage lookup, keeping consistency, because 
> raise_mmu_exception is now
> able to deal with it. I can amend this change in this patch. This patch would 
> prioritize
> PMP errors, your patch will fix the problem with mtval2.
> 
> Let me know what do you think. If you agree I can re-send both patches together.
> 
> 
> Thanks,
> 
> 
> Daniel

Oh, I actually missed that, thx, you are right. I could prepare patch to fix
this, do you want it in this thread or in previous with only my patch in?

-- 
Sincerely,
Aleksei Filippov

