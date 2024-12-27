Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEFBE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 20:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRHML-00043D-Lz; Fri, 27 Dec 2024 15:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRHMK-00042S-6f
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:55:00 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRHMI-0000yD-RB
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:54:59 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A13FE5C1368;
 Fri, 27 Dec 2024 20:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAB3C4CED6;
 Fri, 27 Dec 2024 20:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735332893;
 bh=AftUXuUWx9ZD4I5XBHONp6je4n2JUSbFwJicQRR9IxY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pEf3ovt6kVsWjHKkSS0iwG2Hjk1iZpCd/CIej9PJTOKBfL22tPrEXFNlifu55pMel
 TDSG7GvEdZ4WM8unAa10+cYJw33ja8/LSaqxMFwrzycBHk/q8qqWhtldtKVdHd++Df
 Xox5C7KT3nI7POVxs6DDgcRm4iogEB1RmLIlTR265ua1H3yLS1MTIVRB/qX08RxsoV
 Hlh9bjzhcWZ8WyhuExnKBQCO7578sItWoGOT/HhEcAlS9iVobR18mnN7F5pfkM/dZ2
 NEgmvvUVmYwbFZ1rv4/bBit6OdPh8NRs23WmKrtD9Y4uxXV9NVXtdPaeuMhQgv0j9b
 dNnh9YfGMeczg==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de
Subject: [PATCH v2 1/6] linux-user: netlink: Add missing IFA_PROTO to
 host_to_target_data_addr_rtattr()
Date: Fri, 27 Dec 2024 21:54:44 +0100
Message-ID: <20241227205449.29311-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241227205449.29311-1-deller@kernel.org>
References: <20241227205449.29311-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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

Fixes this warning:
 Unknown host IFA type: 11

Signed-off-by: Helge Deller <deller@gmx.de>
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


