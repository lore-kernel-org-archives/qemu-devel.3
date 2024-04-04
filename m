Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7EDCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 13:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNcn-0003rw-70; Thu, 04 Apr 2024 09:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1rsNcl-0003qP-Ch; Thu, 04 Apr 2024 09:59:27 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1rsNcY-0006Cs-BL; Thu, 04 Apr 2024 09:59:27 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 096EBCE0ED9;
 Thu,  4 Apr 2024 13:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FD1C433F1;
 Thu,  4 Apr 2024 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712239142;
 bh=ilFSR6zorR3NeTqG088TPsN1S2UHXMceAy2nu+jr7Ag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OAmEko5ipxoqBxXy1TrSI23jJ9baf+N3tgxq/UnhXAFNUkxzn58CVfinp894HkeQB
 +2dlQdHbDC9xHcwuRf59z62qcfvfKGI9o9l4EkEbtkETkxpmxbrdRW8VG/qHS5uN97
 uFqEwlo2wiqTISW6tUex7Mk3/1dglM3F2npCnbNGU0+JWeqAnzNMhvVrVmSg0qcQVC
 HQUYItHjiQiQQeimIQL+LXNwdkYk+ZGX5FMYk00yvS5Jd/EdjLI1xdebJBaQQJ8fIR
 FB+86ZEZcM1SZgmcPEGdxq5jNf81EK0KX4nV6i+BzCpbPmoGRjysz9hGUIkXSY1O7N
 A/cWoTHqvWo9w==
Date: Thu, 4 Apr 2024 07:59:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Berg <jhnberg@amazon.co.uk>
Cc: qemu-devel@nongnu.org, its@irrelevant.dk, foss@defmacro.it,
 qemu-block@nongnu.org, John Berg <jhnberg@amazon.com>
Subject: Re: [PATCH] hw/nvme: Add support for setting the MQES for the NVMe
 emulation
Message-ID: <Zg6yJIuY_IiJaL0g@kbusch-mbp.dhcp.thefacebook.com>
References: <20240404120418.1611513-1-jhnberg@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404120418.1611513-1-jhnberg@amazon.co.uk>
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=kbusch@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Apr 04, 2024 at 01:04:18PM +0100, John Berg wrote:
> The MQES field in the CAP register describes the Maximum Queue Entries
> Supported for the IO queues of an NVMe controller. Adding a +1 to the
> value in this field results in the total queue size. A full queue is
> when a queue of size N contains N - 1 entries, and the minimum queue
> size is 2. Thus the lowest MQES value is 1.
> 
> This patch adds the new mqes property to the NVMe emulation which allows
> a user to specify the maximum queue size by setting this property. This
> is useful as it enables testing of NVMe controller where the MQES is
> relatively small. The smallest NVMe queue size supported in NVMe is 2
> submission and completion entries, which means that the smallest legal
> mqes value is 1.
> 
> The following example shows how the mqes can be set for a the NVMe
> emulation:
> 
> -drive id=nvme0,if=none,file=nvme.img,format=raw
> -device nvme,drive=nvme0,serial=foo,mqes=1
> 
> If the mqes property is not provided then the default mqes will still be
> 0x7ff (the queue size is 2048 entries).

Looks good. I had to double check where nvme_create_sq() was getting its
limit from when processing the host command, and sure enough it's
directly from the register field.

Reviewed-by: Keith Busch <kbusch@kernel.org>

