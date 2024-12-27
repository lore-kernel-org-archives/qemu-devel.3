Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10088E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 20:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRHMJ-00042N-SD; Fri, 27 Dec 2024 15:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRHMI-00041j-Bz
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:54:58 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRHMG-0000xb-Vy
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:54:58 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 300CFA41A12;
 Fri, 27 Dec 2024 20:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06367C4CED0;
 Fri, 27 Dec 2024 20:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735332892;
 bh=EJC4yHtGCkP6Ve4vroj1rvWIWPqQDlQko3osllQ6Ods=;
 h=From:To:Cc:Subject:Date:From;
 b=PbZqQWMpQ+D70XOJJBR26NtdeIrtTnwsYMLcEysb2Q+kjCvQmh3lxGQ5FyjzhPy8f
 1g80XOhmPuTo4J/Ls5kNhDrBm5vRFO+fQyIfI9RoY8nWXI4R8+DvDIQQS8EH+rcEnj
 R+rbnoQ3NgRP3t5YY/ILACMLzaBu4ZCzRVeSCDeT4toX+D2kKwoVFz2+rZQWozYa/m
 uTqKPWe3CNz9bBJcMY1jBwRznqQ74KygeKWhLMi15DgATzu9sF01Nkj+gxvA3G5T70
 OYnU/t2eG9I+2lsdrRIQBACb0K3S15De/MxKwtfzGC8mDk7n+CXxAKXlURonn3LHZn
 i8lttBZ80gyCw==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de
Subject: [PATCH v2 0/6] linux-user: Add support for various missing netlink
 sockopt entries
Date: Fri, 27 Dec 2024 21:54:43 +0100
Message-ID: <20241227205449.29311-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

This patchset adds various missing sockopt calls, so that qemu linux-user
is able to successfully build the debian gupnp package in a chroot.

Tested with a 32-bit big-endian hppa linux-user chroot running on a phyiscal
x86-64 little-endian host.

This fixes debian's bug report:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1044651

Signed-off-by: Helge Deller <deller@gmx.de>

Changes in v2:
- Moved IFA_PROTO in patch 1 as suggested by Laurent Vivier
- Added Reviewed-by from Philippe Mathieu-Daudé and Laurent Vivier
  in patch 2

Helge Deller (6):
  linux-user: netlink: Add missing IFA_PROTO to
    host_to_target_data_addr_rtattr()
  linux-user: Use unique error messages for cmsg parsing
  linux-user: netlink: Add IP_PKTINFO cmsg parsing
  linux-user: netlink: Add emulation of IP_MULTICAST_IF
  linux-user: netlink: add netlink neighbour emulation
  linux-user: netlink: Add missing QEMU_IFLA entries

 linux-user/fd-trans.c | 137 +++++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall.c  |  29 +++++++--
 2 files changed, 161 insertions(+), 5 deletions(-)

-- 
2.47.0


