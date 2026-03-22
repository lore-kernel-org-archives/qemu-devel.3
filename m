Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFB5D58CB0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 23:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4SNr-0004ru-9Z; Sun, 22 Mar 2026 19:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w4SNo-0004r0-Er
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 19:39:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w4SNm-0001G0-4q
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 19:38:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5DA0B5969E6;
 Mon, 23 Mar 2026 00:38:55 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 28UQ-xPPkVqK; Mon, 23 Mar 2026 00:38:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 548445969E4; Mon, 23 Mar 2026 00:38:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4F1E95968DD;
 Mon, 23 Mar 2026 00:38:53 +0100 (CET)
Date: Mon, 23 Mar 2026 00:38:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Monitor address printing
Message-ID: <e4f35870-7b04-c9f3-300f-909599a199fe@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

Hello,

Noticed that now addresses are printed with a lot of leading zeros in 
monitor:

$ qemu-system-ppc -monitor stdio -S
QEMU 10.2.90 monitor - type 'help' for more information
(qemu) x/x 0
0000000000000000000000000000000000000000000000000000000000000000: 0x00000000
(qemu) x/x 0xfff00000
00000000000000000000000000000000000000000000000000000000fff00000: 0x60000000

I suspected maybe the recent changes around 42cc2028a43 might have 
something to do with that so I tried to find a point to bisect but looks 
like some build system changes also broke that:

$ git checkout 42cc2028a43^
$ configure...
[...]
mkvenv: installing meson==1.10.0, pycotap==1.3.1, qemu.qmp==0.0.5, setuptools>=44.1.1, wheel>=0.34.2, pip>=20.3.4
ERROR: Could not find a version that satisfies the requirement wheel>=0.34.2 (from versions: none)
ERROR: No matching distribution found for wheel>=0.34.2

*** Ouch! ***

Could not provide build dependency 'meson==1.10.0':

master still builds and I get the above error with earlier version even 
with a new empty build dir so looks like some build system problem. Could 
you please check and fix these?

Regards,
BALATON Zoltan

