Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E58EE7718F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 20:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRHMK-00042l-VH; Fri, 27 Dec 2024 15:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRHMJ-000426-7s
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:54:59 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRHMH-0000y2-Tt
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:54:58 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9CFB3A41A1E;
 Fri, 27 Dec 2024 20:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEF6C4CED6;
 Fri, 27 Dec 2024 20:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735332897;
 bh=Z3ILH7yeOybgi1/CJ1rwkFp19U43yvxFnde7k2lHHz8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PlR8oqtUk8XOSQizVUGjjH29Y9ZUhjVs28/uA6qv8zFqpxElAFiWco/SbXyUATtaZ
 xYEEujWKEofrJl2X94vWoV6ZSav1567spsnCgvS0OaeMVxAeG4vUwsVLnDVz3oiHes
 lVgxk01fM1CPXYSIPDPHXYkRPlZVOLKb0HDeakRTrawKb/6lAyrj+W+50FVEA/OMmr
 caNcWJ+jrzNmKigJvP9Z9bXVuBnRcqLfgjPMwSKcRn6gQYXsiaKg3y7AiY9r1ZAQiM
 GSYi8wI1WrIGhX1j/XmjsZ1RJcDraVuPHOfMD1QtWMrUpfozWzYUqxGj9wcIdEM2TD
 6wTQQuwGm6GnQ==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de
Subject: [PATCH v2 3/6] linux-user: netlink: Add IP_PKTINFO cmsg parsing
Date: Fri, 27 Dec 2024 21:54:46 +0100
Message-ID: <20241227205449.29311-4-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241227205449.29311-1-deller@kernel.org>
References: <20241227205449.29311-1-deller@kernel.org>
MIME-Version: 1.0
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

Fixes those warnings:
 Unsupported host ancillary data: 0/8

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 494323efba..bbe2560927 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1996,6 +1996,18 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                     (void *) &errh->offender, sizeof(errh->offender));
                 break;
             }
+            case IP_PKTINFO:
+            {
+                struct in_pktinfo *pkti = data;
+                struct in_pktinfo *target_pkti = target_data;
+
+                __put_user(pkti->ipi_ifindex, &target_pkti->ipi_ifindex);
+                host_to_target_sockaddr((unsigned long) &target_pkti->ipi_spec_dst,
+                    (void *) &pkti->ipi_spec_dst, sizeof(pkti->ipi_spec_dst));
+                host_to_target_sockaddr((unsigned long) &target_pkti->ipi_addr,
+                    (void *) &pkti->ipi_addr, sizeof(pkti->ipi_addr));
+                break;
+            }
             default:
                 goto unimplemented;
             }
-- 
2.47.0


