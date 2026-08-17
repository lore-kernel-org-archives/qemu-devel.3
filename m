Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABBFC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtI1-0003HZ-Lh; Mon, 17 Aug 2026 05:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHs-0003FJ-Dh; Mon, 17 Aug 2026 05:05:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHo-0001d7-6o; Mon, 17 Aug 2026 05:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=43uJTwGhU1Yf9bwuYArraYNXHY95dHcolTRWR+tqb+Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vGEJaFd14niZiqKWvcMRtbu7RcfMEzuDkNHx85vUzthYeh9l94IhdD0IbxTRK9Kq/
 vk3GgxQNJW5N+JXPw+A6mz0YKUYMB9mp9GO5ajVUW8mq+GibPGthAtFJmG5Cvx2Rhp
 AzvT3am3nurFPXT7TkOE5Rb/x+O9D22NHvz5tDMdd8AU7C5Li7Ghp3MM2xht4ajxsz
 j5ezR7KGNmO2hAEZ5ftcqwxTp9TLHdbN5uthVsQ9b3dC6/bd4Y7QTMqjKDOnv6dYkz
 2WRu1s8hG+2oZjN0harp+/odVzV/nbKi/2xt+03KOj3v2raVfO4ENBk3FOdx9qkMRj
 jo1xIAHpGvUBg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 112DA1CBA38;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E293540D01A;
 Mon, 17 Aug 2026 12:05:26 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A9FC930CE8; Mon, 17 Aug 2026 12:05:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Saul Freedman <fre3dm4n@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 04/42] target/i386/kvm: Fix CET SSP MSR read feature
 check
Date: Mon, 17 Aug 2026 12:04:09 +0300
Message-ID: <20260817090453.2034156-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Saul Freedman <fre3dm4n@gmail.com>

kvm_get_msrs() adds U_CET and S_CET when CET shadow stacks or IBT are
enabled, but it checks FEAT_7_0_EDX with the ECX-defined
CPUID_7_0_ECX_CET_SHSTK bit before adding the PL0-PL3 SSP MSRs.

CPUID_7_0_ECX_CET_SHSTK belongs to FEAT_7_0_ECX. The current check
therefore skips MSR_IA32_PL0_SSP through MSR_IA32_PL3_SSP even when
guest shadow stacks are enabled.

kvm_put_msrs() already uses FEAT_7_0_ECX for the same shadow-stack
condition. Use the same feature word in kvm_get_msrs() so QEMU does
not restore CET enablement with stale or zero SSP values.

Fixes: b6f85c5e4527 ("i386/kvm: Add save/restore support for CET MSRs")
Cc: qemu-stable@nongnu.org
Signed-off-by: Saul Freedman <fre3dm4n@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260615033338.1563854-1-fre3dm4n@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 01b4e06b5225787139dae760e8b4fe0c39e5c04d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4272b6770c7..644c45fb0a0 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5022,7 +5022,7 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
         kvm_msr_entry_add(cpu, MSR_IA32_S_CET, 0);
 
-        if (env->features[FEAT_7_0_EDX] & CPUID_7_0_ECX_CET_SHSTK) {
+        if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) {
             kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, 0);
-- 
2.47.3


