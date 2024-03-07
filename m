Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437E9C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 15:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riG3U-0001Fp-7F; Thu, 07 Mar 2024 10:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riG3S-0001FW-4Z
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:53:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riG3O-00018L-AE
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:53:09 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrDNC2tlHz6D8dw;
 Thu,  7 Mar 2024 23:52:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id BC884140D1D;
 Thu,  7 Mar 2024 23:53:02 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 15:53:02 +0000
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, <qemu-devel@nongnu.org>,
 <richard.henderson@linaro.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Gregory Price
 <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, <linuxarm@huawei.com>
Subject: [PATCH v3 0/1] target/i386: Fix page walking from MMIO memory.
Date: Thu, 7 Mar 2024 15:53:03 +0000
Message-ID: <20240307155304.31241-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Previously: tcg/i386: Page tables in MMIO memory fixes (CXL)
Richard Henderson picked up patches 1 and 3 which were architecture independent
leaving just this x86 specific patch.

No change to the patch. Resending because it's hard to spot individual
unapplied patches in a larger series.

Original cover letter (edited).

CXL memory is interleaved at granularities as fine as 64 bytes.
To emulate this each read and write access undergoes address translation
similar to that used in physical hardware. This is done using
cfmws_ops for a memory region per CXL Fixed Memory Window (the PA address
range in the host that is interleaved across host bridges and beyond.
The OS programs interleaved decoders in the CXL Root Bridges, switch
upstream ports and the corresponding decoders CXL type 3 devices who
have to know the Host PA to Device PA mappings).

Unfortunately this CXL memory may be used as normal memory and anything
that can end up in RAM can be placed within it. As Linux has become
more capable of handling this memory we've started to get quite a few
bug reports for the QEMU support. However terrible the performance is
people seem to like running actual software stacks on it :(

This doesn't work for KVM - so for now CXL emulation remains TCG only.
(unless you are very careful on how it is used!)  I plan to add some
safety guards at a later date to make it slightly harder for people
to shoot themselves in the foot + a more limited set of CXL functionality
that is safe (no interleaving!)

Previously we had some issues with TCG reading instructions from CXL
memory but that is now all working. This time the issues are around
the Page Tables being in the CXL memory + DMA buffers being placed in it.

The test setup I've been using is simple 2 way interleave via 2 root
ports below a single CXL root complex.  After configuration in Linux
these are mapped to their own Numa Node and
numactl --membind=1 ls
followed by powering down the machine is sufficient to hit all the bugs
addressed in this series.

Thanks to Gregory, Peter and Alex for their help figuring this lot
out.

Whilst thread started back at:
https://lore.kernel.org/all/CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com/
The QEMU part is from.
https://lore.kernel.org/all/20240201130438.00001384@Huawei.com/

Gregory Price (1):
  target/i386: Enable page walking from MMIO memory

 target/i386/tcg/sysemu/excp_helper.c | 57 +++++++++++++++-------------
 1 file changed, 30 insertions(+), 27 deletions(-)

-- 
2.39.2


