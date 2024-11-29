Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936E1D6EC13
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 14:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH29N-0003JT-A6; Fri, 29 Nov 2024 09:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tH29M-0003Ib-4t
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:39:16 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tH29K-0005yJ-98
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:39:15 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 90405A43E4A;
 Fri, 29 Nov 2024 14:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E064C4CED2;
 Fri, 29 Nov 2024 14:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732891145;
 bh=v6f7yFrp+w1dSGSDB/8wjHwhrFGDFL1edLYfFUIV1GU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WawiFro3NVkGj6ow66v4Wd5mDcGiszeN4wsxcwoPYU8ZAk20zYdYm8KPn59WI8zfE
 cZ2wGBAjWpvSEO8EK6hGjRkE30DqH1ucco8FDIZZE9KeIfgodXFzgovYTWv64tDivq
 N/IXpDwAfLbH/MoexhLbmlx07pmXCp5M8hmt4kjWfmaaT9tBvALUCRtUL9n/HMR0fr
 kWrkEsfdDa4CuTZaKx5hJ3YyuhBcT/d4qFx/uE5zBKjERB640G656bGFREbVq4cRRg
 37boZWvOcGHRNV9j1lS7QBbGypm8AuLwsDAVrNIkdrga0Odnz6BcLXcFboJn1+0hRH
 GLRPWxeMOfxGg==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 1/6] linux-user: netlink: Add missing IFA_PROTO to
 host_to_target_data_addr_rtattr()
Date: Fri, 29 Nov 2024 15:38:56 +0100
Message-ID: <20241129143901.11291-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129143901.11291-1-deller@kernel.org>
References: <20241129143901.11291-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index c04a97c73a..6191e3115b 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -1143,6 +1143,7 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
         break;
     /* string */
     case IFA_LABEL:
+    case IFA_PROTO:
         break;
     /* u32 */
     case IFA_FLAGS:
-- 
2.47.0


