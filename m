Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D48BC47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 21:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reMSx-0003XY-Kq; Sun, 25 Feb 2024 16:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1reMSt-0003XP-S8
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 16:55:20 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1reMSo-0006ee-FR
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 16:55:16 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BD7E34E6013;
 Sun, 25 Feb 2024 22:55:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id bfgOlsNH1CFQ; Sun, 25 Feb 2024 22:55:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7C3054E6076; Sun, 25 Feb 2024 22:55:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7B1087456B4;
 Sun, 25 Feb 2024 22:55:09 +0100 (CET)
Date: Sun, 25 Feb 2024 22:55:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: benlunt@fysnet.net
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/us/bus.c PCAP adding 0xA in Windows version
In-Reply-To: <000101da6823$ce1bbf80$6a533e80$@fysnet.net>
Message-ID: <5c3f66e1-e2a3-b26d-f598-fb7fc1f780df@eik.bme.hu>
References: <000101da6823$ce1bbf80$6a533e80$@fysnet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Sun, 25 Feb 2024, benlunt@fysnet.net wrote:
> Since Windows text files use CRLFs for all \n, the Windows version of QEMU
> inserts a CR in the PCAP stream when a LF is encountered when using USB PCAP
> files. This is due to the fact that the PCAP file is opened as TEXT instead
> of BINARY.
>
> To show an example, when using a very common protocol to USB disks, the BBB
> protocol uses a 10-byte command packet. For example, the READ_CAPACITY(10)
> command will have a command block length of 10 (0xA). When this 10-byte
> command (part of the 31-byte CBW) is placed into the PCAP file, the Windows
> file manager inserts a 0xD before the 0xA, turning the 31-byte CBW into a
> 32-byte CBW.
>
> Actual CBW:
>  0040 55 53 42 43 01 00 00 00 08 00 00 00 80 00 0a 25 USBC...........%
>  0050 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00       ...............
>
> PCAP CBW
>  0040 55 53 42 43 01 00 00 00 08 00 00 00 80 00 0d 0a USBC............
>  0050 25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 %..............
>
> I believe simply opening the PCAP file as BINARY instead of TEXT will fix
> this issue.

Do you believe or also tested it? :-) There's a typo in the subject, 
should be hw/usb/. No need to resend, just noting it for whoever will 
manage this patch.

Regards,
BALATON Zoltan

> Resolves: https://bugs.launchpad.net/qemu/+bug/2054889
> Signed-off-by: Benjamin David Lunt <benlunt@fysnet.net>
> ---
> hw/usb/bus.c | 2 +-
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -u a/hw/usb/bus.c b/hw/usb/bus.c
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -273,13 +273,13 @@
>     }
>
>     if (dev->pcap_filename) {
> -        int fd = qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY |
> O_TRUNC, 0666);
> +        int fd = qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY |
> O_TRUNC | O_BINARY, 0666);
>         if (fd < 0) {
>             error_setg(errp, "open %s failed", dev->pcap_filename);
>             usb_qdev_unrealize(qdev);
>             return;
>         }
> -        dev->pcap = fdopen(fd, "w");
> +        dev->pcap = fdopen(fd, "wb");
>         usb_pcap_init(dev->pcap);
>     }
> }
>
>
>
>

