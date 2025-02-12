Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DCDC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGy9-0005dP-5j; Wed, 12 Feb 2025 12:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1tiGy5-0005dD-4m
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:56:13 -0500
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1tiGy3-0000Q4-5W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1739382963; bh=G6B5vjDMrS+2EdJ+lzG+9d0WLdOIS+klVIM9taTqkq4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UynpbqFfhi/940LXxVWzJXGr8ne2I73j2PxHdDEoe45u+OrGQVjB8x49zcMJyQLIs
 Xit0N8+7KaYmlZFh556W42a0drWtcoFxYdbR1wGf+9EaDE/VdgACM/LBhEE3p4rmji
 FpMVNwjwfHkwZ8LP7JXU/T8F8/X5HF6g530nxABc=
Date: Wed, 12 Feb 2025 18:56:02 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Andreas Schwab <schwab@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] linux-user: Move TARGET_SA_RESTORER out of
 generic/signal.h
Message-ID: <f9a9c478-d3d9-4c06-9815-ba5d757bae40@t-8ch.de>
References: <mvmed060xc9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mvmed060xc9.fsf@suse.de>
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Andreas,

On 2025-02-10 13:59:34+0100, Andreas Schwab wrote:
> SA_RESTORER and the associated sa_restorer field of struct sigaction are
> an obsolete feature, not expected to be used by future architectures.
> They are also absent on RISC-V, LoongArch, Hexagon and OpenRISC, but
> defined due to their use of generic/signal.h.  This leads to corrupted
> data and out-of-bounds accesses.
> 
> Move the definition of TARGET_SA_RESTORER out of generic/signal.h into the
> target_signal.h files that need it.  Note that m68k has the sa_restorer
> field, but does not use it and does not define SA_RESTORER.
> 
> Reported-by: Thomas Weißschuh <thomas@t-8ch.de>
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Thanks for fixing this properly.

Reviewed-by: Thomas Weißschuh <thomas@t-8ch.de>

> ---
>  linux-user/aarch64/target_signal.h    | 2 ++
>  linux-user/arm/target_signal.h        | 2 ++
>  linux-user/generic/signal.h           | 1 -
>  linux-user/i386/target_signal.h       | 2 ++
>  linux-user/m68k/target_signal.h       | 1 +
>  linux-user/microblaze/target_signal.h | 2 ++
>  linux-user/ppc/target_signal.h        | 2 ++
>  linux-user/s390x/target_signal.h      | 2 ++
>  linux-user/sh4/target_signal.h        | 2 ++
>  linux-user/x86_64/target_signal.h     | 2 ++
>  linux-user/xtensa/target_signal.h     | 2 ++
>  11 files changed, 19 insertions(+), 1 deletion(-)

...

