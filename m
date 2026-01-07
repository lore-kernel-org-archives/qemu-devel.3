Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C69FCF6BE4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 04:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdKjO-0002xC-9a; Tue, 06 Jan 2026 23:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdKjM-0002vb-SM
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:01:08 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdKjK-0001bF-Uu
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:01:08 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0C5AD596A0A;
 Wed, 07 Jan 2026 05:01:04 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id j_DR0hKe-Kx4; Wed,  7 Jan 2026 05:01:02 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 10DC25969FD; Wed, 07 Jan 2026 05:01:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0F9125969F6;
 Wed, 07 Jan 2026 05:01:02 +0100 (CET)
Date: Wed, 7 Jan 2026 05:01:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 8/9] ati-vga: Implement HOST_DATA register writes
In-Reply-To: <DFHZC7DG5UZG.157Y4WLZ0MF3L@jablonski.xyz>
Message-ID: <c17e68fd-fe8f-b508-495b-79cc1c9c1a2c@eik.bme.hu>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
 <20260106185700.2102742-9-chad@jablonski.xyz>
 <bcce15ee-9f83-128a-0894-2e7c87ceff8c@eik.bme.hu>
 <DFHZC7DG5UZG.157Y4WLZ0MF3L@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 6 Jan 2026, Chad Jablonski wrote:
>> Is it documented somewhere that writing these registers reset the host
>> data or is it from experiments? Are there any other registers that may
>> need to reset or are these the only place (apart from HOST_DATA_LAST) that
>> terminate host data?
>
> I haven't seen documentation on this or done extensive testing on it yet. My
> reasoning for placing them here was that these writes kick off blits and so
> it seemed like a safe place to do this. I agree though, it would be much better
> to know how this actually behaves. I suspect at the very least there are more
> register writes that do this. I'll see what else I can learn here
> through testing.

It's OK for now, we can fix it up later if new info is found I was just 
asking if this was something known or a guess. If you can do testing with 
real card that's better but not needed if it would take too much time.

Regards,
BALATON Zoltan

