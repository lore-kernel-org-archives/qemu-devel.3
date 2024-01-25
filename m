Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9907C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 09:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSvnq-0003q1-0h; Thu, 25 Jan 2024 04:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rSvno-0003pe-4N
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 04:13:40 -0500
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rSvnl-0002i3-S7
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 04:13:39 -0500
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0W.JuljN_1706174004; 
Received: from 30.198.0.95(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W.JuljN_1706174004) by smtp.aliyun-inc.com;
 Thu, 25 Jan 2024 17:13:24 +0800
Message-ID: <546f0981-bcab-429b-b3a6-35308c872ff9@linux.alibaba.com>
Date: Thu, 25 Jan 2024 17:13:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu riscv, thead c906, Linux boot regression
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/1/24 20:49, Björn Töpel wrote:
> Hi!
>
> I bumped the RISC-V Linux kernel CI to use qemu 8.2.0, and realized that
> thead c906 didn't boot anymore. Bisection points to commit d6a427e2c0b2
> ("target/riscv/cpu.c: restrict 'marchid' value")
>
> Reverting that commit, or the hack below solves the boot issue:
>
> --8<--
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8cbfc7e781ad..e18596c8a55a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -505,6 +505,9 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>       cpu->cfg.ext_xtheadsync = true;
>   
>       cpu->cfg.mvendorid = THEAD_VENDOR_ID;
> +    cpu->cfg.marchid = ((QEMU_VERSION_MAJOR << 16) |
> +                        (QEMU_VERSION_MINOR << 8)  |
> +                        (QEMU_VERSION_MICRO));
>   #ifndef CONFIG_USER_ONLY
>       set_satp_mode_max_supported(cpu, VM_1_10_SV39);
>   #endif
> --8<--
>
> I'm unsure what the correct qemu way of adding a default value is,
> or if c906 should have a proper marchid.
>
> Maybe Christoph or Zhiwei can answer?
>
> qemu command-line:
> qemu-system-riscv64 -nodefaults -nographic -machine virt,acpi=off \
>     -cpu thead-c906 ...

Hi  Björn,

I think it is caused by an mmu extension(named XTheadMaee) not 
implemented on QEMU which is conflicts with Svpbmt, which is the reason 
for error-ta in Linux.

I will try to fix this on QEMU and at the same time give a way to 
implement vendor custom CSR(XTheadMaee is controlled by an CSR named 
mexstatus)  on QEMU.

Thanks,
Zhiwei

>
> Thanks,
> Björn

