Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B6CE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO06T-0005fV-4x; Wed, 18 Dec 2024 14:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tO06S-0005fF-6R
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:04 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tO06Q-0001bD-Kj
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:03 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id BD9A7A40A4B;
 Wed, 18 Dec 2024 19:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BDEC4CECD;
 Wed, 18 Dec 2024 19:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734551574;
 bh=dFdJHS2fcUNzhLS8OVysMDJhrwIxQcz7Tz5F4UM1A7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LoxGscyP6I3jg3cx+GU6idlGWX1yyppPy/9zUd+Hy+/KKKMToDBX0s+Q/tLt1OR2A
 wswWIg84d5vo28pknY0de6TDb8kFYyoGAqkXYJVgYGCnlsX2ji25mnaXhviqG5TZCC
 4xOLI/jSf9Ydt74yNRJlamMuGOFRiMU+Lj/lBe3E50xuH8PLO0Lq423LEOeg3F/5o+
 o4S9R9+Kwmyck4lTcu1f8T80oWHpxHemEU5g7Yxc/chK6MHcQoOFml5CmafDvr36mh
 loDdSFOfHjjAnTWadoZEw0cmDKxFBnhHRAFHvbcA6V9boPcsB45HGyIUBg1aCOWmbI
 HpagaI4SuwIxQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 2/6] linux-user: Use unique error messages for cmsg parsing
Date: Wed, 18 Dec 2024 20:52:43 +0100
Message-ID: <20241218195247.5459-3-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241218195247.5459-1-deller@kernel.org>
References: <20241218195247.5459-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Avoid using the same error message for two different code paths
as it complicates determining the one which actually triggered.

Signed-off-by: Helge Deller <deller@gmx.de>
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


