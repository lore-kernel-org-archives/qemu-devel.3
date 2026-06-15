Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D5CCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 06:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ0Pq-00049t-Ow; Mon, 15 Jun 2026 02:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fre3dm4n@gmail.com>)
 id 1wYy5B-0005zn-3L
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 23:33:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fre3dm4n@gmail.com>)
 id 1wYy59-0003x5-Mh
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 23:33:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c0c2a68d01so18073815ad.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 20:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781494429; x=1782099229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r2rvojVLS1d55N6BPyuEoOHN6DHrIDzWcczFK27664Q=;
 b=Gwwe5aNmCQ6LhPwlR9JFdbJ8YqYtqFpmJRMs8+m4EyPPpLFofSLj/r5sCjfOteNxdZ
 GdHF3NJivOxRApdsF+Rg7w/XQrco+Xthw+JyDhJQG2W2K4DrISnuBDIRFy701zJmNkCo
 STq7ZXPL5NF344dTSMlSwJz6GMxvRPnucVZzPpt0hSXCy3sgTOf1eSq9ggrwKb22TShk
 kKH405CjXTZJ8RkuCHZAf86rS6zsb6pb+iq9Xu+DUE20uWjo5oec+NUsCJMQRxXF3AvR
 RYRGJNN7vLOcR/YpenrWkMLoc7+elIFqFYuisKqJY7KLlcnrI9/XfX8jA2dEZov504k/
 vA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781494429; x=1782099229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2rvojVLS1d55N6BPyuEoOHN6DHrIDzWcczFK27664Q=;
 b=hnBC1yr+RyrLJCbFXBvglBsD0AV0Nw9CdqAtHp+LWg7cAw1Y3WhidKzoHQZ2yIaLDJ
 G7HM70QGR65ZNxPKAcKcbUMHl1xZvQv7sTF7bMWNWjTd2Tx2qltyXH7nKdIcBi4R3P5S
 3DjUXJN01uhJnIG/fI1WWd+xmEUsy/w8n7yUyEwXOYO8dMdwEi1CBqkUN1rlu5ELn880
 eAyBdEx4QD4fwhPVEHFxzFw8zi3gxf6DlCqAInpbgjZYiDItAjjYEaGeSFWjBpnnUYw7
 YDxYcsZddJMDJ7PoWIdIjRvTqV8L2pKgkEEg6D8QnikNL+sVMQQtEUs+mkEirlkxhTao
 sa/A==
X-Gm-Message-State: AOJu0Yy8zAG5BF2A4lSOETX7u1LnD207VOnm85NM6SCkKowFBftpUcIJ
 ACN62wnGNjmJLCoOitSFTb3U1iTkOIwlqlQ+wR9W03muPL+DXPSaNUFRo6WhALgBKOhMXOBZ
X-Gm-Gg: Acq92OH6l4/NE9hX6kbWAFDb09cU1htwlHr7PFZI3/plujCpH4DjC8nRJTxTzhVsYLm
 TjZvUYRO7mT8rT6ffKkKbpczQUGK1kOua40vgX/SR2cIBFwKO9h4ugjmOaFO9KjpljXN6oR5ijT
 DykFA47jwPot4khRl8H26lWkDS+cRVnkAQQPPtSzma1aWLd9DODr1ahkpuURAgRYS3candsvS5b
 2x+YdxQWjqgXSwthP0Jjk8cHkxTJ/B1mFcHjuhkD+77FV8Jmvo7CaUTM2pTrvwcZOFcLIkEDQsh
 F1ZYUhIz6fHzGaeF0cgLeA67vf0jThYXEKwo8N5pDhU0nkhB8tgsImFuqg/3wyJF+6LlXlRgtGG
 4wgC5Wn88YSu9CUCnWHOPrUEwzSHQ9pz57dpWdiKfTgpBZR67x/6JMrvko7TZeq41I4uGyM0CG2
 VqJqXtSvapM1oQyn1h42si3S+3pgFToXJhtyPx47n0mo0WCQ==
X-Received: by 2002:a17:903:19eb:b0:2c1:ee75:56bb with SMTP id
 d9443c01a7336-2c41188b334mr130331905ad.20.1781494428646; 
 Sun, 14 Jun 2026 20:33:48 -0700 (PDT)
Received: from localhost.localdomain ([120.244.221.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4328a43c9sm85094975ad.41.2026.06.14.20.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 20:33:48 -0700 (PDT)
From: Saul Freedman <fre3dm4n@gmail.com>
To: qemu-devel@nongnu.org
Cc: Saul Freedman <fre3dm4n@gmail.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, kvm@vger.kernel.org, qemu-stable@nongnu.org
Subject: [PATCH] target/i386/kvm: Fix CET SSP MSR read feature check
Date: Sun, 14 Jun 2026 23:33:38 -0400
Message-Id: <20260615033338.1563854-1-fre3dm4n@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=fre3dm4n@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Jun 2026 02:03:15 -0400
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
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e35288..3f4a241 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5021,7 +5021,7 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
         kvm_msr_entry_add(cpu, MSR_IA32_S_CET, 0);
 
-        if (env->features[FEAT_7_0_EDX] & CPUID_7_0_ECX_CET_SHSTK) {
+        if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) {
             kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, 0);
-- 
2.39.5


