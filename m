Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF122C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 04:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZN7x-0005UJ-45; Sat, 18 Jan 2025 23:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZN7v-0005Tj-UN
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 23:41:36 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZN7t-0003XD-RY
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 23:41:35 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 640B0A4005E;
 Sun, 19 Jan 2025 04:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AC8C4CED6;
 Sun, 19 Jan 2025 04:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737261691;
 bh=BS3tR4Akvbj/4B9tMkagVRFMT0yEiYwE3uNPhrWhlsg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WfE26Vx+AVNqDuRtKLbiHymO/YNa6WvEIaom2YMqRN5gwCDFMjfLtc24iZrMu2KgL
 v7ZOwOKrA4ncxK3I2co48dCY9AGQ3gwOqcO0su8nyo1FTKqQrYu++erM+GJq1wKjws
 rtglb0GB1R+rB1CpQvng4yQs1lt9YLWXl/6vzr9XF0nVGcegGjVolPFsvYtytbUmAB
 ngOFNHe+pQQC+ne0OAbBlF0BOoZSvtFsancb6/53ztqmHc4y8QvVXgywnBYith2HO3
 iVUutAYWNaxhyAEGTsxEJcmAdQMhdoApJQKtR0xXQEyJMRCkaF1dqRTALBQ55vSEcI
 Lf+codCDM2lBg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
Subject: [PATCH v3 3/6] linux-user: netlink: Add IP_PKTINFO cmsg parsing
Date: Sun, 19 Jan 2025 05:41:19 +0100
Message-ID: <20250119044122.9637-4-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250119044122.9637-1-deller@kernel.org>
References: <20250119044122.9637-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

v2: (based on feedback by Laurent Vivier)
- add target_in_pktinfo struct and fix copying target_in_addr fields
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


