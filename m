Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB91C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayGj-0006yC-9r; Fri, 16 Feb 2024 08:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rayGh-0006xr-PY; Fri, 16 Feb 2024 08:28:43 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rayGg-0005Rf-7f; Fri, 16 Feb 2024 08:28:43 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C345C4E602D;
 Fri, 16 Feb 2024 14:28:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ybgoBxecQugd; Fri, 16 Feb 2024 14:28:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D13D64E601F; Fri, 16 Feb 2024 14:28:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CF7427456B4;
 Fri, 16 Feb 2024 14:28:36 +0100 (CET)
Date: Fri, 16 Feb 2024 14:28:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/6] target/ppc: Fix 440 tlbwe TLB invalidation gaps
In-Reply-To: <20240117151238.93323-1-npiggin@gmail.com>
Message-ID: <4ee51a3d-6a71-e45a-2902-d133fadfff4c@eik.bme.hu>
References: <20240117151238.93323-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

On Thu, 18 Jan 2024, Nicholas Piggin wrote:
> The 440 software TLB write entry misses several cases that must flush
> the TCG TLB:
> - If the new size is smaller than the existing size, the EA no longer
>  covered should be flushed. This looks like an inverted inequality test.
> - If the TLB PID changes.
> - If the TLB attr bit 0 (translation address space) changes.
> - If low prot (access control) bits change.
>
> Fix this by removing tricks to avoid TLB flushes, and just invalidate
> the TLB if any valid entry is being changed, similarly to 4xx.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

This series was missing a cover letter so patchew did not pick it up 
correctly. However this improves the sam460ex performance a lot so I'd 
like this to be included in 9.0 release. Nick, maybe it's time to start 
merging patches and send a pull request to avoid getting conflicts in last 
minute that could cause series to miss release. So an early pull request 
would help to get everybody on the same page.

Regards,
BALATON Zoltan

