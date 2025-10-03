Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD76CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 12:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4f64-0002yX-Uf; Fri, 03 Oct 2025 08:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v4f5p-0002vh-NI
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 08:41:02 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v4f5i-0005wg-D6
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 08:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=wHNy9GCiqX4OOTvf36QyMM7/U4C8gF101nhL5xFuDhM=; b=Ih0fiqgHxdVSrdx
 v3uqTN1XkGm8PoTGpkjlJWh2xAISnow1M20OlnvIFKw+/iIT7/78uB1L1PGPykWZT/Q5nS4hYaE8W
 GusbgoIS4E/zGzo+piloDNdSUR/WiRS4dndMsUuW/7SjZRl1X1yrrXvAbvMN9ZQwI8xo71DhN+Xuj
 lo=;
Date: Fri, 3 Oct 2025 14:43:19 +0200
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, richard.henderson@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Subject: Re: [PATCH v2 11/33] target/riscv: Fix size of pc, load_[val|res]
Message-ID: <5awovsvugga5stmdkkfn2sg4ueabgboa3s3dsrkfpfsx2h53pw@j4s3t3zd2mzu>
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-12-anjo@rev.ng>
 <645487b6-d98a-454b-9e73-aaca6fe9fb3b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <645487b6-d98a-454b-9e73-aaca6fe9fb3b@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 02/10/25, Pierrick Bouvier wrote:
> On 10/1/25 12:32 AM, Anton Johansson wrote:
> > Fix to 64 bits in size and as these are mapped to TCG globals, be
> > careful with host endianness when allocating globals.  Casts are
> > added to logging expressions to retain the correct size for
> > TARGET_RISCV32.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/riscv/cpu.h        |  6 +++---
> >   target/riscv/cpu.c        |  3 ++-
> >   target/riscv/cpu_helper.c |  4 ++--
> >   target/riscv/machine.c    |  6 +++---
> >   target/riscv/translate.c  | 12 +++++++-----
> >   5 files changed, 17 insertions(+), 14 deletions(-)
> I guess you'll update string formats later when really getting rid of
> target_ulong. For now it's good.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks!:) Yes exactly follow up patchsets will get rid of target_ulong,
the goal of this one is to simply fix the size of CPUArchState and
retain all behaviour.

