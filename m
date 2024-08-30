Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A390CA0FE0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzRc-0007mQ-Mb; Fri, 30 Aug 2024 07:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1sjzRa-0007jF-UH; Fri, 30 Aug 2024 07:05:30 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1sjzRY-0005rT-VQ; Fri, 30 Aug 2024 07:05:30 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 3396CC0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1725015919;
 bh=sAr3E9Fn35Mo6C+1dszsP++274O+2deiwlmokajn63o=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=JOPeNpnq8oDtPbjqQ/K4dl0xjxedKBwdTmVHY+yB7lUMsF2yoQN/3W67T9oSMrERK
 zDydn8z8U/+tR65sLhRioyVMrqc8ATpEBApWbeAX5PWMzhbi6GgEpakgpAInTl4Ev1
 wtC63UDJHD7YabbWWzLcm0HgUpZ+0cNMTzITGp7KZKUuDrzrDUgfGmlZf2Ew3NG6qB
 DV5NZoYa2P1NHagnQdXv9Tn/j1pBlF0bGpx8BRZKfVASj35EE7n9ea1v8JVjZoQ6ep
 qzcpEhFvsc0tYZG8RLUGBSm2gD2V52xubAYOX5flJ3Y1SOJgUUc+cgxXYHqUmoCBqV
 OEtyMjQmAuLkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1725015919;
 bh=sAr3E9Fn35Mo6C+1dszsP++274O+2deiwlmokajn63o=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=m4kb3oerMKUgLlRHISCzvHPmJGI5A+Ss8qZPeEnphrA8CvsKnYluC6OQ5sN/IXD1T
 h7lRIdn8sPNpmMkBhOn8ubwSV9DV31p3U7VXYRiVdTlfYH+w87gsLgxYD0YzeuREGd
 l6+VujCTaT/Hb4NIOu6hIO/ytN7/rcfe0GOUA1bq39CZIuNd6QVjxSEowY1qB5q3Fq
 krsf7xr6oqphXyOu3el1zuzS/VGfYu5fUkC7splYUnU56j28EJVVdEqsxdEBTKG6YE
 /sH+l459TmsqH1PoqLJeh+hA9W0N1slAZlP5pdgJKP1AcmHojcgL+RYWVl9HXZkoEA
 b2ff5gS6IxA0g==
Message-ID: <5f547cd8-2068-4499-af7e-04f3f27ea617@syntacore.com>
Date: Fri, 30 Aug 2024 14:05:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Stop timer with infinite timecmp
To: Andrew Jones <ajones@ventanamicro.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>
CC: Anup Patel <apatel@ventanamicro.com>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, <atishp@rivosinc.com>
References: <20240829084002.1805006-2-ajones@ventanamicro.com>
Content-Language: en-US, ru-RU
From: Vladimir Isaev <vladimir.isaev@syntacore.com>
In-Reply-To: <20240829084002.1805006-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=vladimir.isaev@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Hi Andrew,

29.08.2024 11:40, Andrew Jones wrote:
> While the spec doesn't state it, setting timecmp to UINT64_MAX is
> another way to stop a timer, as it's considered setting the next
> timer event to occur at infinity. 

I think this should be explicitly stated in the spec, since some software
may initially set time and timecmp to big values just to check how overflow
is handled. And without it no chance that all HW implementations will interpret
UINT64_MAX as 'stop timer'.

Do we need github issue on SSTC/privileged?

Thank you,
Vladimir Isaev

> And, even if the time CSR does
> eventually reach UINT64_MAX, the very next tick will bring it back to
> zero, once again less than timecmp. For this reason
> riscv_timer_write_timecmp() special cases UINT64_MAX. However, if a
> previously set timecmp has not yet expired, then setting timecmp to
> UINT64_MAX to disable / stop it would not work, as the special case
> left the previous QEMU timer active, which would then still deliver
> an interrupt at that previous timecmp time. Ensure the stopped timer
> will not still deliver an interrupt by also deleting the QEMU timer
> in the UINT64_MAX special case.
> 
> Fixes: ae0edf2188b3 ("target/riscv: No need to re-start QEMU timer when timecmp == UINT64_MAX")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  target/riscv/time_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
> index 8d245bed3ae3..bc0d9a0c4c35 100644
> --- a/target/riscv/time_helper.c
> +++ b/target/riscv/time_helper.c
> @@ -92,6 +92,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>       * equals UINT64_MAX.
>       */
>      if (timecmp == UINT64_MAX) {
> +        timer_del(timer);
>          return;
>      }
>  




