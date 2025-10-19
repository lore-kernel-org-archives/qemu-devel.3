Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0E4CCD183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 12:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vASC0-00034v-8f; Sun, 19 Oct 2025 08:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vASBx-000345-FX; Sun, 19 Oct 2025 08:07:17 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vASBs-0002ym-7P; Sun, 19 Oct 2025 08:07:17 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8665F5972F2;
 Sun, 19 Oct 2025 14:07:08 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id nzz787utnyds; Sun, 19 Oct 2025 14:07:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8832E5972E5; Sun, 19 Oct 2025 14:07:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 862265972E1;
 Sun, 19 Oct 2025 14:07:06 +0200 (CEST)
Date: Sun, 19 Oct 2025 14:07:06 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Yogesh Vyas <yvyas1991@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v3 00/13] Pegasos2 clean up and pegasos1 emulation
In-Reply-To: <CAJOT6qN-n7LpVnLO-5CpOUF8z-j1Ogi=6cJBvvKZc-Eh5tHVzA@mail.gmail.com>
Message-ID: <a410ac54-d1dc-aa67-d1d7-690b2495e9df@eik.bme.hu>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <CAJOT6qN-n7LpVnLO-5CpOUF8z-j1Ogi=6cJBvvKZc-Eh5tHVzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, 19 Oct 2025, Yogesh Vyas wrote:
> When I run QEMU with the ROM option, the machine boots successfully with
> the below command:
>
> qemu-system-ppc64 -machine pegasos2 -bios pegasos2.rom \
>                  -cdrom debian-8.11.0-powerpc-netinst.iso \
>                  -device VGA,romfile="" -serial stdio
>
> However, when I try to boot the machine without the ROM using VOF, the
> machine does not come up and no logs appear on stdout:
>
> qemu-system-ppc64 -machine pegasos2 -serial stdio \
>                  -kernel vmlinuz-chrp.initrd -append "---" \
>                  -cdrom debian-8.11.0-powerpc-netinst.iso
>
> Please let me know if I am missing any parameters or setup required for
> booting via VOF on Pegasos2.
>
> Documentation referred: qemu/docs/system/ppc/amigang.rst

Maybe you did not use the right vmlinuz-chrp.initrd. Pegasos2 is a 32 bit 
machine so you need /install/powerpc/vmlinuz-chrp.initrd for it (see in 
the /install/pegasos script that is used with firmware). Even if you call 
it from qemu-system-ppc64 which includes both 32 bit and 64 bit machines 
but does not make 32 bit machines 64 bit so you still need the 32 bit OS.

Regards,
BALATON Zoltan

