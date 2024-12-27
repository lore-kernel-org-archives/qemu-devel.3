Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345FEE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 20:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRHMK-00042k-Uk; Fri, 27 Dec 2024 15:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRHMJ-00042B-D0
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:54:59 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRHMH-0000xm-QC
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:54:59 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 07C8EA414AD;
 Fri, 27 Dec 2024 20:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475CCC4CED4;
 Fri, 27 Dec 2024 20:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735332895;
 bh=++yLiwF1vMXtmMJcl0mx0RivzvJ7PQ5W2ExsxlhLhr4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KT6atdWbuYOyc0uQEpri562gx5pUm57oimhFnTffrWu7zX7NJ4WyTqKpyw1cjXtbM
 RWhY6NGGBpfRFz2/8+l7p5WkTDTVvLP+gVDyqxUvto654Yd0A60971p3gJ7drUtSiN
 I88RSF1l7F/SV7VjhVaC+0UM9aQZXP39lkia3JBSqTA3t4a8tm9IFFHWlB65Cg6yQe
 H2FDNPz+Wu/k/lxcCZufRq5YuLP9B0mAgqgOX71xCo0X7NTlj5cZQstpF8p5p88iri
 uIxouMjR4zirHpmGaZK+Dlo9eBa+f/UwS8qrVrP7yB5aAl75BDOgRM8xPzgxIdpvrK
 CJTiJrW7dtPoQ==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de
Subject: [PATCH v2 2/6] linux-user: Use unique error messages for cmsg parsing
Date: Fri, 27 Dec 2024 21:54:45 +0100
Message-ID: <20241227205449.29311-3-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241227205449.29311-1-deller@kernel.org>
References: <20241227205449.29311-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
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

Avoid using the same error message for two different code paths
as it complicates determining the one which actually triggered.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1ce4c79784..494323efba 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1825,7 +1825,7 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
                 *dst = tswap32(*dst);
             }
         } else {
-            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+            qemu_log_mask(LOG_UNIMP, "Unsupported target ancillary data: %d/%d\n",
                           cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(data, target_data, len);
         }
@@ -2047,7 +2047,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
 
         default:
         unimplemented:
-            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+            qemu_log_mask(LOG_UNIMP, "Unsupported host ancillary data: %d/%d\n",
                           cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(target_data, data, MIN(len, tgt_len));
             if (tgt_len > len) {
-- 
2.47.0


