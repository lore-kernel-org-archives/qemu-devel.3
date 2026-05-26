Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FFFCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRx6q-0000cc-Js; Tue, 26 May 2026 15:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRx6b-0000Uo-Ey; Tue, 26 May 2026 15:06:21 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRx6Z-0004hN-Jg; Tue, 26 May 2026 15:06:21 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CF0B438F3;
 Tue, 26 May 2026 19:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC33B1F000E9;
 Tue, 26 May 2026 19:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779822378;
 bh=YmDrG2TezwoliurUbxDzBvTiekL3RGYCv9IQwkBdxx8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=npX76Brbf2MixQO187ZMVQ6vKX5oeNNSSSsc3DreDvoucNyVrMptk6EhXpi4EwT+B
 MQt4VHAca8OORzlmY0DSKKa+e58MoiKCf/Wi1NrzbLsWH/R5Rm9dXBh5c2YIGvrGHA
 tf8gu7CwOtC2/uq/MPZ8LBSa0ZxbjPdyetlLkacH4LxND5e0sYoh+83T0KfGj/fDkg
 XUVW0imxoqakv0X4t0Ecm3JnBP75FuKt2NbD3Zxg2YCkDAm113G9CA11UOC00peA6Q
 Dtx9oiPOpKdcd2QMeIFN5/oAekKu4IFzZlrcjj3OJO6nCufz9uL7tpMDEBYUdmvoRF
 pVk+t/cKGPVXA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 10/12] linux-user: Fix loading static ARM cortex-m55 binaries
Date: Tue, 26 May 2026 21:05:33 +0200
Message-ID: <20260526190535.10833-11-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526190535.10833-1-deller@kernel.org>
References: <20260526190535.10833-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

Static built ARM binaries for Cortex-m55 may have been linked to have
their load address at address 0 (because they are effectively a
bare-metal image). When qemu-user is running as non-root user and will
try to mmap() a host address at 0 (which is smaller than mmap_min_addr
according to /proc/sys/vm/mmap_min_addr), it will fail with EPERM and as
such loading those guest program will fail.

Fix pgb_addr_set() to always return false if the guest_loaddr <
mmap_min_addr, that way a valdid guest_base address will be calculated
and the EPERM can be avoided.

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1890
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f7625c0952..62f12e4149 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -866,7 +866,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
         if (LO_COMMPAGE != -1 && LO_COMMPAGE < mmap_min_addr) {
             return false;
         }
-        if (guest_loaddr != 0 && guest_loaddr < mmap_min_addr) {
+        if (guest_loaddr < mmap_min_addr) {
             return false;
         }
     }
-- 
2.54.0


