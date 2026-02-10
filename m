Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1409EA3F34
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpkS4-0004W5-IT; Tue, 10 Feb 2026 04:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpkS2-0004VF-HR
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:54:34 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpkS0-0006xh-6q
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:54:34 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7CA47596A0A;
 Tue, 10 Feb 2026 10:54:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wxTqX0rgOT8Y; Tue, 10 Feb 2026 10:54:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7D8A65969F6; Tue, 10 Feb 2026 10:54:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7BF095969FF;
 Tue, 10 Feb 2026 10:54:26 +0100 (CET)
Date: Tue, 10 Feb 2026 10:54:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>, 
 =?ISO-8859-15?Q?Phil_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Implement frame number overflow event
In-Reply-To: <CAFEAcA-HwiOfh6sXa3OvFtrMotoaEpB9ZoLXq_5aXDoVqh8wqA@mail.gmail.com>
Message-ID: <61b053d3-70e0-4b63-8b32-c8c7bef36229@eik.bme.hu>
References: <20260209001836.5413F5969F2@zero.eik.bme.hu>
 <CAFEAcA-HwiOfh6sXa3OvFtrMotoaEpB9ZoLXq_5aXDoVqh8wqA@mail.gmail.com>
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

On Tue, 10 Feb 2026, Peter Maydell wrote:
> On Mon, 9 Feb 2026 at 00:19, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> According to specification 6.5.6 FrameNumberOverflow Event when bit 15
>> of frame count changes (either from 1 to 0 or 0 to 1) a
>> FrameNumberOverflow interrupt should be generated.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Is this a bug fix for some specific problem (e.g. it fixes
> handling for some guest OS)? If so, we should say what it's
> fixing in the commit message, so that if we ever come back
> to this in future we know what we need to test to make sure
> we don't re-break it.

Primarily it fixes what it says in the commit message: compliance to the 
actual specification but it also seems to help MacOS to be able to use 
usb-audio which was how Howard found it. Unless there's something else to 
change in the patch I'm not sending a v2 feel free to tweak commit message 
on merge if needed.

Regards,
BALATON Zoltan

