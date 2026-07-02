Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B866DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGvO-0002Rf-J3; Thu, 02 Jul 2026 08:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wfGvM-0002R2-Ix; Thu, 02 Jul 2026 08:53:48 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wfGvK-0007sf-SN; Thu, 02 Jul 2026 08:53:48 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 35FAA59672D;
 Thu, 02 Jul 2026 14:53:42 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id OGZLjt-fHQKo; Thu,  2 Jul 2026 14:53:40 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 285CD59672C; Thu, 02 Jul 2026 14:53:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 23653596727;
 Thu, 02 Jul 2026 14:53:40 +0200 (CEST)
Date: Thu, 2 Jul 2026 14:53:40 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Matt Jacobson <mhjacobson@me.com>
cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/5] hw/block: add Sony/Apple "SuperDrive" diskette
 drive
In-Reply-To: <20260702022927.46510-2-mhjacobson@me.com>
Message-ID: <4ac46a1a-4125-c792-1d6c-9ccd204d6ed4@eik.bme.hu>
References: <20260702022927.46510-1-mhjacobson@me.com>
 <20260702022927.46510-2-mhjacobson@me.com>
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

On Wed, 1 Jul 2026, Matt Jacobson wrote:
> The Mac Quadra 800 contains a "SuperDrive" floppy drive that supports
> both GCR (400 kB and 800 kB) and MFM (720 kB and 1440 kB) diskettes.
> Implement an emulated version, to be controlled by a forthcoming SWIM2
> device.
>
> For GCR, the emulated drive encodes the BlockBackend's data in the Apple
> GCR format and exposes it to the controller via sony_drive_read_byte().
> The bytes are decoded not by the controller but rather in software by
> the Macintosh ".Sony" driver.  The drive also adds the sync bytes and
> addressing marks that software expects.
>
> For MFM, much less encoding is needed.  The sector data passes through
> from the BlockBackend unmodified, and the drive only adds sync bytes and
> addresssing marks.

Maybe these last two paragraphs explaining theory of operation could go in 
a comment but which is easier to see than looking up a commit message but 
I'm OK with it either way.

> Signed-off-by: Matt Jacobson <mhjacobson@me.com>

I can't tell if all of it is correct but looks reasonable to me so

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

