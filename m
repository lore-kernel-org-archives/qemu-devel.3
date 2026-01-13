Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8ADD2F357
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 18:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfing-0001cF-Aa; Tue, 13 Jan 2026 13:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aidan@aktech.ai>) id 1vfhWD-0005uF-DA
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:45:22 -0500
Received: from omta34.uswest2.a.cloudfilter.net ([35.89.44.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aidan@aktech.ai>) id 1vfhWB-0002n2-Pu
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:45:21 -0500
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
 by cmsmtp with ESMTPS
 id fgJbvW1BeKjfofhVyvM88c; Tue, 13 Jan 2026 16:45:06 +0000
Received: from gator4203.hostgator.com ([108.167.189.28]) by cmsmtp with ESMTPS
 id fhVwvrtnRh8QWfhVxvGepY; Tue, 13 Jan 2026 16:45:05 +0000
X-Authority-Analysis: v=2.4 cv=Mcdsu4/f c=1 sm=1 tr=0 ts=69667691
 a=fpD4kzfX7W8RbeKAuMGPiQ==:117 a=fpD4kzfX7W8RbeKAuMGPiQ==:17
 a=vUbySO9Y5rIA:10 a=HaeQS5oA3WMA:10 a=no2vxl2JlCt9nLFxYVgA:9
 a=tGAC0SnQRR4URLD-nMig:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aktech.ai; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V90O7fOL/DI+oJVWmRp7sUiVWkk8X0wg0cklyr5NtCg=; b=OOiK2/xJ7wD8KSu48op7+TDLMq
 vFnAlm0OcLuPWqFb8CynCun3c/CO5KVB9B8sFonFZJU9tge/ijHWmgQU6TjZegFyqIFqi6SkWJedR
 1fISXpLXmJJUtVL1y03NybiV1lFSxewi0vH59AFkvK3RSDi9bulnHUhVFFBJjk7iObU2smoCGZNU6
 0n8C92ipTxzP/vIwBBSyu6BO50sPIw3LteGuSWlkHMMpuB/q+s9OjkKpQXFi3McE1GbADLM7PFGQP
 WRkQ7iQCTG1fRexUTjhPP0VICXnIswT1eS4Ih+iSF+5d6WPdIqr1ZYz9jxHTKAN9ViQRuJz3ks5o0
 7YTGOI1A==;
Received: from fctnnbsc51w-159-2-155-244.dhcp-dynamic.fibreop.nb.bellaliant.net
 ([159.2.155.244]:56614 helo=localhost.localdomain)
 by gator4203.hostgator.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <aidan@aktech.ai>) id 1vfhVw-00000003usM-1HEb;
 Tue, 13 Jan 2026 10:45:04 -0600
From: Aidan Khoury <aidan@aktech.ai>
To: qemu-devel@nongnu.org
Cc: aidan@revers.engineering,
	Aidan Khoury <aidan@aktech.ai>
Subject: [PATCH] i386/cpu: Fix unexpected initializer override in CPU model
 definition for Diamond Rapids
Date: Tue, 13 Jan 2026 12:43:56 -0400
Message-ID: <20260113164355.1623966-2-aidan@aktech.ai>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4203.hostgator.com
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - aktech.ai
X-BWhitelist: no
X-Source-IP: 159.2.155.244
X-Source-L: No
X-Exim-ID: 1vfhVw-00000003usM-1HEb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: fctnnbsc51w-159-2-155-244.dhcp-dynamic.fibreop.nb.bellaliant.net
 (localhost.localdomain) [159.2.155.244]:56614
X-Source-Auth: aidan@aktech.ai
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: YWt0ZWNoYWk7YWt0ZWNoYWk7Z2F0b3I0MjAzLmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIwTYKscVGJ3dTHlIThM7NTFiAlzqbdnVI18HecsaHa4PNtSD9QaO/VgbXIT3YtouyCwmXhqRTa64ET1BDhLT/Kusu+4qNo0sMepRP47Ay4GYUTlkXwm
 8GsITT9NLYbA6H0zN3OC1tUs+PeDGROjtOXTxuy7Gn/dfjq4ka/9q6Ho/bry17fNMFEx0hCLbw2WRhF4xjTEw10zAx4Sz6B3HdI=
Received-SPF: pass client-ip=35.89.44.33; envelope-from=aidan@aktech.ai;
 helo=omta34.uswest2.a.cloudfilter.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 13 Jan 2026 13:05:51 -0500
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

The new Diamond Rapids x86 cpu model definition that was added in 7a6dd8bde159 has an unexpected comma in
the `.features[FEAT_VMX_EXIT_CTLS]` subobject initializer causing the prior initialization to be overridden,
meaning that `VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE` is not included.

Fix this by replacing the comma with the missing bitwise OR to properly combine all the flags into a single
bitmask value.

Fixes: 7a6dd8bde159 ("i386/cpu: Add CPU model for Diamond Rapids")
Signed-off-by: Aidan Khoury <aidan@aktech.ai>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 37803cd724..917b37d128 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5589,7 +5589,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
         .features[FEAT_VMX_EXIT_CTLS] =
-            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE,
+            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
-- 
2.43.0


