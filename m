Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B1606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoH7-0003bz-2J; Fri, 27 Nov 2026 00:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zakinko@snowrabbit.org>)
 id 1xWoH4-0003bQ-VK; Fri, 27 Nov 2026 00:13:31 -0500
Received: from bambi.snowrabbit.org ([182.48.54.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zakinko@snowrabbit.org>)
 id 1xWoH1-0006TB-GV; Fri, 27 Nov 2026 00:13:30 -0500
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
 id B8CA0C9306; Fri, 27 Nov 2026 14:13:21 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Date: Fri, 27 Nov 2026 08:35:46 +0900
Message-ID: <179573614689.97996.17899066722176586988@snowrabbit.org>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Showta Ishizaki <zakinko@snowrabbit.org>
Subject: Re: [PATCH] hw/ppc/spapr: Match the CAS PVR list terminator as PAPR
 requires
In-Reply-To: <20261127004815.9e9da3b9-e3-amachhiw@linux.ibm.com>
References: <20261028194120.C7B72C9296@bambi.snowrabbit.org>
 <179562717261.21196.2381142528834233384@snowrabbit.org>
 <20261127004815.9e9da3b9-e3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=182.48.54.220;
 envelope-from=zakinko@snowrabbit.org; helo=bambi.snowrabbit.org
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Amit,

Thank you for trying it, and sorry for the trouble.  My description
was misleading: the ofwboot that makes this call is not in any NetBSD
release.  It is from a 64-bit pseries port I am working on, here:

  https://github.com/zakinko/NetBSD-src/tree/ppc64-pseries

The ofppc ofwboot in 11.1 is 32-bit and never calls
"ibm,client-architecture-support", so what you found is right.

Its PVR list is:

  mask 0xffff0000 value 0x003c0000    970FX
  mask 0xffff0000 value 0x00440000    970MP
  mask 0xffff0000 value 0x004d0000    POWER8
  mask 0xffff0000 value 0x004e0000    POWER9
  mask 0xffff0000 value 0x0080ffff    Power10, also the terminator

followed by option vectors 1 to 5.  Vector 5 asks for XIVE when
ibm,arch-vec-5-platform-support offers it.  The code is in
sys/arch/ofppc/stand/ofwboot/boot.c.

The command line was:

  qemu-system-ppc64 -M pseries,cap-hpt-max-page-size=16M -cpu power10 \
      -smp 1 -m 1024 -nographic -serial stdio -monitor none \
      -prom-env 'auto-boot?=false' -cdrom boot.iso

where boot.iso holds ofwboot and the kernel, and "boot cdrom:ofwboot
netbsd" is typed at the SLOF prompt.

With master as of 9751c62358, under TCG:

  >> NetBSD/ofppc OpenFirmware Boot, Revision 1.13 (Wed Oct 28 15:16:17 UTC 2026)
  qemu-system-ppc64: Couldn't negotiate a suitable PVR during CAS
  ibm,client-architecture-support: error

ofwboot goes on, and the kernel comes up on XICS instead of the XIVE
that vector 5 asked for.  With the patch the CAS error is gone and the
kernel attaches XIVE:

  xive: exploitation mode, priority 6, 65536-byte queues

So the effect is that the option vectors are ignored, not that boot
stops; I overstated it in my ping, sorry.

I will send you the ofwboot and kernel binaries in a separate mail.

Thanks,
Showta

