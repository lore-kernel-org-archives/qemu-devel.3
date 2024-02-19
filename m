Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E704C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4xo-0001Mf-GR; Mon, 19 Feb 2024 09:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc4xm-0001Ds-4w; Mon, 19 Feb 2024 09:49:46 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc4xk-0007Dw-JM; Mon, 19 Feb 2024 09:49:45 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 26E394E6012;
 Mon, 19 Feb 2024 15:49:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id rLp9AcV-9rvg; Mon, 19 Feb 2024 15:49:41 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2E84A4E602D; Mon, 19 Feb 2024 15:49:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2CA577456B4;
 Mon, 19 Feb 2024 15:49:41 +0100 (CET)
Date: Mon, 19 Feb 2024 15:49:41 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PULL 22/49] hw/pci-host/raven.c: Mark raven_io_ops as
 implementing unaligned accesses
In-Reply-To: <20240219082938.238302-23-npiggin@gmail.com>
Message-ID: <754804d1-8bde-b23b-d136-e93d6d967987@eik.bme.hu>
References: <20240219082938.238302-1-npiggin@gmail.com>
 <20240219082938.238302-23-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-885738078-1708354181=:77986"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-885738078-1708354181=:77986
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 19 Feb 2024, Nicholas Piggin wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
>
> The raven_io_ops MemoryRegionOps is the only one in the source tree
> which sets .valid.unaligned to indicate that it should support
> unaligned accesses and which does not also set .impl.unaligned to
> indicate that its read and write functions can do the unaligned
> handling themselves.  This is a problem, because at the moment the
> core memory system does not implement the support for handling
> unaligned accesses by doing a series of aligned accesses and
> combining them (system/memory.c:access_with_adjusted_size() has a
> TODO comment noting this).
>
> Fortunately raven_io_read() and raven_io_write() will correctly deal
> with the case of being passed an unaligned address, so we can fix the
> missing unaligned access support by setting .impl.unaligned in the
> MemoryRegionOps struct.
>
> Fixes: 9a1839164c9c8f06 ("raven: Implement non-contiguous I/O region")
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Tested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Hm, this seems to be missing the actual patch.

Regards,
BALATON Zoltan
--3866299591-885738078-1708354181=:77986--

