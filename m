Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201A7CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuM8-0006ys-Cr; Tue, 12 May 2026 17:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLO-000303-Ny; Tue, 12 May 2026 17:08:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLN-00038b-0Y; Tue, 12 May 2026 17:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619301; bh=FeMR9GM9i6SwKGLVhcJuzNQK7do177MIgrQ3yktR+ZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=of5nw8OR4QwYtKxwMksy+ZEt+NoHtoEfJCONxE4mNx0ZZxb+SNFL+o9N/l3levAhs
 +jYkP4LMYoeK7q3ZnCn8HWMZcnanNBB01RHmImvyYOFBz+zVz7OBw0+910ViRxgtVC
 m8mojCDjHg2gfPrHXwga5TaiE5rqtDtXvlRbr4EfucdfymzEuklCyVmPFkbweG0NWA
 N4cecZfsgXHnDfd263xFAWU37d4ve5KFjK4mYGMexiWo+P9QBPggs+201CLL6hJTjM
 HFrKHgzCLh76Z2F7bbt0amKDkASf4Ta87n49lt2rL2FwCXaVJ24zQmdVdKAVpEqsAT
 QmMp/ujFbSujA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B6A5F1AA35B;
 Tue, 12 May 2026 23:55:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B8D753ABCCB;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 030/117] tdx: fix use-after-free in tdx_fetch_cpuid
Date: Tue, 12 May 2026 23:53:32 +0300
Message-ID: <20260512205503.361097-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Paolo Bonzini <pbonzini@redhat.com>

This is mostly harmless right now because the "if" is never
hit, but the code as written makes no sense.

Reported-by: Stefan Weil <sw@weilnetz.de>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit f093ee7ac3af06e4ed7c86663717cf571b42241e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index dbf0fa2c91..7dcf5b4e4e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -799,7 +799,7 @@ static struct kvm_cpuid2 *tdx_fetch_cpuid(CPUState *cpu, int *ret)
         r = tdx_vcpu_ioctl(cpu, KVM_TDX_GET_CPUID, 0, fetch_cpuid, &local_err);
         if (r == -E2BIG) {
             g_free(fetch_cpuid);
-            size = fetch_cpuid->nent;
+            size *= 2;
         }
     } while (r == -E2BIG);
 
-- 
2.47.3


