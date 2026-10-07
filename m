Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCBACA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQCl-0008L7-SF; Wed, 07 Oct 2026 07:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xEQCi-0008Kn-3c; Wed, 07 Oct 2026 07:53:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xEQCf-0007vT-Tn; Wed, 07 Oct 2026 07:52:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2C2455835D6;
 Wed, 07 Oct 2026 13:52:53 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GDi7I7KAsEOX; Wed,  7 Oct 2026 13:52:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ADCEC5835CA; Wed, 07 Oct 2026 13:52:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB5B4583581;
 Wed, 07 Oct 2026 13:52:50 +0200 (CEST)
Date: Wed, 7 Oct 2026 13:52:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bin Meng <bin.meng@processmission.com>
cc: QEMU <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 01/17] target/ppc: Correct PIR write access on e500 cores
In-Reply-To: <20261006094921.110871-2-bin.meng@processmission.com>
Message-ID: <8c6780c7-0871-c5bf-5e2d-1778dd060efa@eik.bme.hu>
References: <20261006094921.110871-1-bin.meng@processmission.com>
 <20261006094921.110871-2-bin.meng@processmission.com>
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

On Tue, 6 Oct 2026, Bin Meng wrote:
> The BookE PIR registration reuses the classic PowerPC 604 write
> callback, which writes SPR 1023 and masks the value to four bits.
> BookE PIR is SPR 286; on e500, SPR 1023 is SVR, so a PIR write can
> corrupt SVR while leaving PIR unchanged.
>
> The e500v1/e500v2 manual defines PIR as read-only. The e500mc, e5500
> and e6500 manuals allow hypervisor software to write PIR after reset.
> Reject writes on e500v1/e500v2 and use the generic 32-bit SPR write
> callback on the other three cores to update the correct register
> without the four-bit restriction.
>
> Reference:
> - E500CORERM (Rev.1), section 2.5.2
>  https://www.nxp.com/docs/en/reference-manual/E500CORERM.pdf
> - E500MCRM (Rev.3), section 2.9.7
>  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
> - E5500RM (Rev.4), section 2.9.7
>  https://www.nxp.com/webapp/Download?colCode=E5500RM
> - E6500RM (Rev.0), section 2.9.8
>  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

I'm not sure about URLs in commit messages which might go stale. I think 
the reference to title and section is enough without the URL but whatever 
others prefer is fine with me too.

Regards,
BALATON Zoltan

