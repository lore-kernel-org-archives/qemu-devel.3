Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12578D58E48
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx6gN-0005zF-Ab; Mon, 02 Mar 2026 12:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vx6g6-0005uf-Ku
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:03:31 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vx6g4-0006BU-PM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:03:30 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0A3E35969FA;
 Mon, 02 Mar 2026 18:03:25 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id u4bSRfeWMsA0; Mon,  2 Mar 2026 18:03:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E53995969F4; Mon, 02 Mar 2026 18:03:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E38EB5969F0;
 Mon, 02 Mar 2026 18:03:22 +0100 (CET)
Date: Mon, 2 Mar 2026 18:03:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v9 17/18] ati-vga: Implement HOST_DATA register writes
In-Reply-To: <DGSEYLNI8QYM.H1MSRR2IWS1F@jablonski.xyz>
Message-ID: <2f680b56-8f02-77ad-e8e2-9f2791c65f42@eik.bme.hu>
References: <20260227203944.746471-1-chad@jablonski.xyz>
 <20260227203944.746471-18-chad@jablonski.xyz>
 <bacdcf5e-6382-734d-d29e-c1ec435f5572@eik.bme.hu>
 <DGSEYLNI8QYM.H1MSRR2IWS1F@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 2 Mar 2026, Chad Jablonski wrote:
>> I think these may not be the best constants as you still do a lot of
>> calculation with them so maybe it could be simplified but I don't know
>> how. If there's no visible difference in output with normal usage only in
>> corned cases that only happened during testing then maybe it's too early
>> to try to implement this and we could go back to the previous 128 bit
>> accumulator unless you found some real world usage where this would
>> matter. Otherwise I think this would only matter with a concurent 2D
>> engine where host data writes could continue in the other half of the 256
>> bit register while the 2D engine does the operation on the already written
>> half. So if we get the same graphical result with only storing 128 bits
>> for now we could do that and rething this when we can run the 2D engine
>> concurrently.
>>
>
> With well-behaved drivers there should be no difference. The only real
> behavioral difference I've seen is when host_data blits are ended early.
> I have tests covering this behavior now and it's documented so I have no problem
> going back to the 128-bit implementation for now. If we do run into real
> drivers that depend on this we can always easily resurrect it.

We only have a week left before the freeze for next release so I think we 
should finalize the series with the next version without adding much more 
complexity at the last minute so I think we should go back to 128 bit as 
was in previous version and add the simple fixes from the last version and 
use that for now and not start bigger rewrite now. This should work with 
Xorg and MorphOS and we can do more accurate emulation on top in the next 
devel cycle if it's found needed. If errors are found we can still fix 
that during the freeze but only if the series is merged by then. Will you 
make a version in the coming days or should I help and compile a series 
with the patches I think should work?

Regards,
BALATON Zoltan

