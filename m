Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38B7C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xBc-0004E7-6X; Mon, 31 Aug 2026 04:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x0xBZ-0004DW-4c; Mon, 31 Aug 2026 04:16:09 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x0xBS-0005kL-No; Mon, 31 Aug 2026 04:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788164139; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
 bh=3mOtK5HVWrO0c7khLTkhvRIt2EjJuwTAV+yVsqi/j1E=;
 b=uc6N0JpBTe89dJi0e9OMciMCsb2UtWNc4aMn+zxeG8ZqBIUe4hUe2Wvdrrt1MyIzDJ150Cd2QoRvP42lismsMMiQMv+QepkqmzMr7qoLwRPnkly025wxB5JipfU+ZeyYwZE5WpBuApRPcGDvwIt4J1h7WfcqBlZauAKfnRXv6hA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0X9vWv4j_1788164137; 
Received: from 30.166.80.78(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X9vWv4j_1788164137 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 31 Aug 2026 16:15:38 +0800
Message-ID: <6354eb8b-7319-4e03-ab16-12e8857added@linux.alibaba.com>
Date: Mon, 31 Aug 2026 16:15:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: TianCheng TANG <lyndra@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Fix LCOFI masking in sie/sip/mvip
To: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Gong Shuai <gsh517025@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260813134002.862578-1-mayuresh.chitale@oss.qualcomm.com>
In-Reply-To: <20260813134002.862578-1-mayuresh.chitale@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Hi Mayuresh,

Thanks for fixing this.

While testing related RISC-V PMU changes, I noticed the same read-back
issue reported by Gong: rmw_sip64() also needs to include LCOFI in its
read mask.

I also noticed that adding MIP_LCOFIP to the static masks exposes bit
13 when Sscofpmf is disabled. The specification requires sip.LCOFIP
and sie.LCOFIE to be read-only zero in that configuration. Would it
make sense to condition these masks on ext_sscofpmf?

For the virtual-interrupt path, Smcdeleg requires both mvip and mvien
LCOFI when Smcdeleg, Sscofpmf, and Smaia are implemented. Is mvien
support planned as a follow-up?

I have local TCG tests covering the base, extension-disabled, and
virtual-interrupt cases and can share them if useful.

This also appears to address:
https://gitlab.com/qemu-project/qemu/-/work_items/3969

Thanks,
Tiancheng

