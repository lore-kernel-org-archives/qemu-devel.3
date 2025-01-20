Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45614C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZzPX-0005mu-I3; Mon, 20 Jan 2025 16:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzPD-0005iY-Nx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:33:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZzPA-0000w1-Pd
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:33:58 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DEE705C5E4E;
 Mon, 20 Jan 2025 21:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FC3C4CEE0;
 Mon, 20 Jan 2025 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737408829;
 bh=ccz5LM+xc8j0WKFoIHGpIfYu4qedCCNtwYrf+iuAPzY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DS0Zmd1939gRRIXbXGh+heY73ujrYY18lgrHVBHZkGuLIarXqog//en0fMuCsIXG4
 IsT/3+Mr4PXR62ZPf148X+m1A/ffvAD3Q3v9gmPE/089cCuHT9C6nX5p9GSQJjjLVQ
 E6dHkIB+B/zCIPjHUxsikqKmtMzb4uzF3iETHj/Jow5kYjYFMIoHSdTUEv0FQosxPZ
 gs31Fbb0qR9zT7XHxN3Gr7D4n5T7kzUrIQssp45V33ixmfCSM0Y6FRAc9vG/5flpFx
 cJVqrA6VidoPVPthblTlqjrQwwJGME6p1BbdS5JY9Pzl4B3M9LOBMykOXQFEFKt/dU
 5vVztGVkfBqAw==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
Subject: [PATCH v4 3/7] linux-user: netlink: Add IP_PKTINFO cmsg parsing
Date: Mon, 20 Jan 2025 22:33:36 +0100
Message-ID: <20250120213340.359195-4-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250120213340.359195-1-deller@kernel.org>
References: <20250120213340.359195-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Fixes those warnings:
 Unsupported host ancillary data: 0/8

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c      | 10 ++++++++++
 linux-user/syscall_defs.h |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a157abc40c..df8609b4d8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1998,6 +1998,16 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                     (void *) &errh->offender, sizeof(errh->offender));
                 break;
             }
+            case IP_PKTINFO:
+            {
+                struct in_pktinfo *pkti = data;
+                struct target_in_pktinfo *target_pi = target_data;
+
+                __put_user(pkti->ipi_ifindex, &target_pi->ipi_ifindex);
+                target_pi->ipi_spec_dst.s_addr = pkti->ipi_spec_dst.s_addr;
+                target_pi->ipi_addr.s_addr = pkti->ipi_addr.s_addr;
+                break;
+            }
             default:
                 goto unimplemented;
             }
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index faad9147c9..86d773add7 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2622,6 +2622,12 @@ struct target_ucred {
     abi_uint gid;
 };
 
+struct target_in_pktinfo {
+    abi_int               ipi_ifindex;
+    struct target_in_addr ipi_spec_dst;
+    struct target_in_addr ipi_addr;
+};
+
 typedef abi_int target_timer_t;
 
 #define TARGET_SIGEV_MAX_SIZE 64
-- 
2.47.0


