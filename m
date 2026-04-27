Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870DAFF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5a-0000PG-50; Mon, 27 Apr 2026 17:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5R-0000CV-7c
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:50 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5L-0003Tn-UR
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:45 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A997360138;
 Mon, 27 Apr 2026 21:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE350C19425;
 Mon, 27 Apr 2026 21:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323702;
 bh=qF/E4NTHGEzqRslmvhkeGAs4imRoAsHDEXNz7p4ViJw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dolpgwhFKQTL1J8SAS2gLOQ+ffjAi00MC5jjjJsUSgIdbJtS3upO1e7Nz1THbqmTu
 fEAsM8D3PyNRWCzXJoWlJtOfUJgoTfu5r6D+WFYTf05YpC8jc/ObdAb4Dkg7PJ4lH0
 4hV4w3RiTKmEOfr/Ybw8Q2/+wx0OBlXqpcDd4NxkE3my8GxHMj2+bESMhGn0lQ+tOD
 oKJPCSj6J95ZBFIDWo3WRn8bCm1PyFtoUnFizvoI3NBrNVvwMmY8Ke9JwVyUmiGNVc
 lJpS+WM1ikcXqUtxVdU54Q7/bFflFveQUmMZU2WMRd9TCaCY6hXjDfw1nRmGGSZaFt
 c77TzS2rVMhkg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 03/15] linux-user: fix off-by-one in
 host_to_target_for_each_rtattr()
Date: Mon, 27 Apr 2026 23:01:21 +0200
Message-ID: <20260427210133.6016-4-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210133.6016-1-deller@kernel.org>
References: <20260427210133.6016-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Yixin Wei <easonwei1998@gmail.com>

host_to_target_for_each_rtattr() uses "len > sizeof(struct rtattr)"
as its loop condition. When the last rtattr in a netlink message has
exactly sizeof(struct rtattr) (4) bytes remaining, the loop exits
without byte-swapping its rta_len and rta_type. A big-endian guest
then reads rta_len in the wrong byte order and fails validation.

The companion function target_to_host_for_each_rtattr() correctly
uses ">=" (added in commit fa2229dbf8). The kernel's RTA_OK macro
also uses ">=". Fix the host_to_target direction to match.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2485
Signed-off-by: Yixin Wei <yixinwei@meta.com>
Fixes: 6c5b5645ae0 ("linux-user: add rtnetlink(7) support")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: qemu-stable@nongnu.org
---
 linux-user/fd-trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 64dd0745d2..7f55a0690b 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -480,7 +480,7 @@ static abi_long host_to_target_for_each_rtattr(struct rtattr *rtattr,
     unsigned short aligned_rta_len;
     abi_long ret;
 
-    while (len > sizeof(struct rtattr)) {
+    while (len >= sizeof(struct rtattr)) {
         rta_len = rtattr->rta_len;
         if (rta_len < sizeof(struct rtattr) ||
             rta_len > len) {
-- 
2.53.0


