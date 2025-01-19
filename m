Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AEBC02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 04:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZN7w-0005Tl-CR; Sat, 18 Jan 2025 23:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZN7u-0005TO-Ny
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 23:41:34 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tZN7t-0003X1-6a
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 23:41:34 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D95965C03EC;
 Sun, 19 Jan 2025 04:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB46C4CEE2;
 Sun, 19 Jan 2025 04:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737261688;
 bh=PF3vG23YlFSjPb37uVPotxsYubEj0ljU7NCWJ+lvwYw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LcX1oYELxwt47lRW1Nh/RMAei4+/etMxhLEzGQdgRwgRnkFlWi3eeIneINCy1c8gm
 mq8h4HBahoHbnZI3scW63qG31Jeqjkpg/1myqfN7C6J6odwOT/gE+cX+kdWmzHb4mg
 JuXUkWA+u13Whv/7dlLvfLZSGUjup2qIJKzTirju0ill+iOKl11GFU32aR+tVA/KEg
 ZmjIeCEkLazhgX564MOcg27nbdptp852K7CKEP0a+CS3190HbTv73GwULDi3cvYXp+
 rP3jCePGSiuZQL5KktwWnR2ls5zRL/LRihFYukB271frfr8is7nw9vB73wnVo30X9P
 SqTTIw13YqN3g==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
Subject: [PATCH v3 1/6] linux-user: netlink: Add missing IFA_PROTO to
 host_to_target_data_addr_rtattr()
Date: Sun, 19 Jan 2025 05:41:17 +0100
Message-ID: <20250119044122.9637-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250119044122.9637-1-deller@kernel.org>
References: <20250119044122.9637-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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

Fixes this warning:
 Unknown host IFA type: 11

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/fd-trans.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index c04a97c73a..a86ed2f4b4 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -1140,6 +1140,7 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
     /* binary: depends on family type */
     case IFA_ADDRESS:
     case IFA_LOCAL:
+    case IFA_PROTO:
         break;
     /* string */
     case IFA_LABEL:
-- 
2.47.0


