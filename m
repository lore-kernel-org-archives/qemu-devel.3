Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325CEFD4F19
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 18:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w025U-0006Fu-Qw; Tue, 10 Mar 2026 14:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w025T-0006Ee-5S; Tue, 10 Mar 2026 14:45:47 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w025M-0001fE-6V; Tue, 10 Mar 2026 14:45:44 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 816385969F3;
 Tue, 10 Mar 2026 19:45:35 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 6ubxyQ1YR4qN; Tue, 10 Mar 2026 19:45:32 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 295825969EB; Tue, 10 Mar 2026 19:45:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 274895966F4;
 Tue, 10 Mar 2026 19:45:32 +0100 (CET)
Date: Tue, 10 Mar 2026 19:45:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Trieu Huynh <vikingtc4@gmail.com>
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Thomas Huth <huth@tuxfamily.org>, 
 Laurent Vivier <laurent@vivier.eu>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 1/4] hw/core/loader: fix error handling for
 load_image_targphys callers
In-Reply-To: <20260310182801.196443-2-viking4@gmail.com>
Message-ID: <c07847f8-a2c2-34ac-8caf-875b06a78cb2@eik.bme.hu>
References: <20260310182801.196443-1-viking4@gmail.com>
 <20260310182801.196443-2-viking4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Wed, 11 Mar 2026, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
>
> Check return value of load_image_targphys() and return early on
> failure instead of continuing with invalid state.
> - Use ret < 0 to handle negative return value.
> - No functional changes.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
> hw/alpha/dp264.c       |  8 ++++++--
> hw/hppa/machine.c      |  7 +++++--
> hw/m68k/next-cube.c    |  9 ++++++++-
> hw/m68k/q800.c         |  7 +++++--
> hw/m68k/virt.c         |  7 +++++--
> hw/microblaze/boot.c   |  4 ++++

I don't know about these above,

> hw/ppc/amigaone.c      |  9 +++++++++
> hw/ppc/e500.c          | 10 ++++++++++
> hw/ppc/mac_newworld.c  | 10 ++++++++++
> hw/ppc/mac_oldworld.c  | 10 ++++++++++
> hw/ppc/pegasos.c       |  5 +++++
> hw/ppc/pnv.c           | 20 ++++++++++++++++----
> hw/ppc/ppc440_bamboo.c |  4 ++++
> hw/ppc/prep.c          | 10 ++++++++++
> hw/ppc/sam460ex.c      |  5 +++++
> hw/ppc/spapr.c         |  8 ++++++++
> hw/ppc/virtex_ml507.c  |  9 +++++++++

but unless I missed something all these call it with error_fatal so the 
check added should never be reached therefore should not be needed.

Regards,
BALATON Zoltan

