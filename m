Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED830FEFB47
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxX7-0007FE-5N; Fri, 27 Feb 2026 08:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vvxX4-0007Eo-1M; Fri, 27 Feb 2026 08:05:26 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vvxX1-0004BB-Bo; Fri, 27 Feb 2026 08:05:25 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 81D5559731B;
 Fri, 27 Feb 2026 14:05:19 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id o25WkUJVEr3F; Fri, 27 Feb 2026 14:05:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 19D2A597312; Fri, 27 Feb 2026 14:05:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 17C275972E2;
 Fri, 27 Feb 2026 14:05:17 +0100 (CET)
Date: Fri, 27 Feb 2026 14:05:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Aditya Gupta <adityag@linux.ibm.com>
cc: shivang upadhyay <shivangu@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 npiggin@gmail.com, milesg@linux.ibm.com, qemu-devel@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
In-Reply-To: <aaFv56FZ6Z50G_T4@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Message-ID: <33d78dda-6df8-3825-7cf5-7bf7e21d010e@eik.bme.hu>
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
 <CAFEAcA9+-5=hVzRMu9n1YtcOazMLQDx65T=NLy9wxv5RNLwYAg@mail.gmail.com>
 <48b13f0b-bb53-4316-923d-77a20ffdfab1@linux.ibm.com>
 <aaFv56FZ6Z50G_T4@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 27 Feb 2026, Aditya Gupta wrote:
> On 26/02/27 03:43PM, shivang upadhyay wrote:
>>> <...snip...>
>>>
>>> Q: can the generated DBT genuinely be different on a
>>> subsequent reset than it was when QEMU first starts?
>>> The comments in the pnv_reset() code seem to suggest it,
>>> but on the other hand the code as written will only
>>> call pnv_dt_create() and update machine->fdt once on first
>>> reset, not on later resets. So perhaps the comment is
>>> just confusingly worded ?
>>
>> Yes, I am not much familiar with the design here. But, as per
>>
>> my current understanding of this code, DTB content should not
>>
>> not be changed.
>
> To add to this, yes, normally reset path doesn't change the device tree,
> since all reboots are the same as the first boot.
>
> As of upstream this is true, I don't see dtb changing between resets.

Isn't VOF allowing clients to do setprop that would be changing the device 
tree? Some settings are stored there so maybe it can be changed by the 
guest that should be preserved between reboots?

Regards,
BALATON Zoltan

> One case where reset path does change the device tree compared to
> pnv_init part is Memory-Preserving IPL (MPIPL), which is a
> dump-collection feature in powernv for collecting dumps after kernel
> crashes.
> This is not merged yet in upstream, and is currently in discussion [1].
>
> I am okay with the dead if condition in pnv_reset to be removed for now,
> we can add it later for mpipl purpose if needed.
>
> [1]: https://lore.kernel.org/qemu-devel/20260225124633.1841222-1-adityag@linux.ibm.com/
>
> Thanks,
> - Aditya G
>
>
>

