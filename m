Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C944CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHMQ-00021V-Is; Thu, 15 Oct 2026 05:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xHHMN-00021K-AF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 05:02:47 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xHHML-0002yt-DQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 05:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=+rtTUmQcjwbuylarGYo+vVUq0iWWBIKZ/BVbtXw5YeI=; b=btZ4hHJ3XcUXU5L
 0bUmxuizswwwQwzoR9q5uWs9UeMcvKcDqg/2/amgLp1xC8EGW3xzEZ3v2eH8brSU0wTrEqfjqJmnu
 dT+ZF+gl/msnCm0NrIrZ3fLLLgcedOmZw7NlhEnHTJBlU6mM+2OzkfjbebZVUznoIFcdvBOr3MW4i
 rU=;
Date: Thu, 15 Oct 2026 11:08:24 +0200
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 00/19] multi-target: remove dump functions duplication
Message-ID: <atCWOW9cDfUFky13@hive.localdomain>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/10/26, Pierrick Bouvier wrote:
> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
> target. For this, we define a new set of Dump operations for a given cpu, and
> implement it per target.
> 
> Existing implementations were using first_cpu, which is what we continue to do.
> When we'll work on heterogeneous later, we can revisit this to either forbid a
> dump, or perform a dump for each target active.
> 
> Based-on: 20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com
> "[PATCH v3 00/12] multi-target: add hexagon"
> This base is only needed due to conflicts with current wip, it's not important
> for this series implementation.

I have a very similar series going locally here

  https://gitlab.com/AntonJohansson/qemu/-/commits/b4/arch-dump

where I added get_dump_info()/get_note_size() to SysemuCPUOps given
that we already have write_elf[32|64]_note() there.  Any reason it would
be preferable to have a new struct of function pointers?

Also I saw some uses of first_cpu in the write_elf[32|64]_note()
functions on i386 at least that we should eliminate.

-- 
Anton Johansson
rev.ng Labs Srl.

