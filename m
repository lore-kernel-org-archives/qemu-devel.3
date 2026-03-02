Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2484FD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytp-0002o9-BF; Mon, 02 Mar 2026 03:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytJ-0001np-QP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytH-0001Zv-Sg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5AI3avZm19KLQD7LDt8OMGbB5svIMdjv1ikVmHJAqqY=;
 b=BCw08yHgUJi46UoJhxsxrF13ROV0h4wx/rCkwBt+3AsT3QEPiMDP7FEp7mQXXH2gQIObt+
 aV7MpLu7EgcbcYcK3Qj0Z0cHmi3Lx3NR6qEOEoZ/ohqopHcHtv2FvK03Dxmmp6/Q6GsSTF
 86RjLmVudTYgD/BcaIPiGf18+3Ydktw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-5qoZuhWDMFuOlbsMlUI-ag-1; Mon, 02 Mar 2026 03:44:33 -0500
X-MC-Unique: 5qoZuhWDMFuOlbsMlUI-ag-1
X-Mimecast-MFC-AGG-ID: 5qoZuhWDMFuOlbsMlUI-ag_1772441073
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439b50dfca1so584722f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441072; x=1773045872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AI3avZm19KLQD7LDt8OMGbB5svIMdjv1ikVmHJAqqY=;
 b=li4i2XgBKbrAPokC2f0TWqIXNBE161jr5J6HEECnO9NvOrXsYk4Ch9Fo18QKWEkTnb
 Q/OxdiBDqNarPtQO+WhzyvEFendxEWAvHPdr5dPglPcczEJkCc46iL8+IqmS7tQe20tw
 +bbbn6qeOiMd1hb4VgG0Jt9xbTQsmY4/CSdOtPfUtFZfc9pPrCccm/S8s5qwb0H1Dwd6
 4xTycoWtydULgC5CpaSVo7Mose3xC39FMAkE1ejCzimbfCTEUhact3q8l8j4k/WXQU+J
 EQvOFL/oG3YpImHw0yxzws6C9rXaWO0KaZaLulHfcJJDZ7TmB6RPkCZ97qPC8u9YbPEC
 68RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441072; x=1773045872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5AI3avZm19KLQD7LDt8OMGbB5svIMdjv1ikVmHJAqqY=;
 b=n2/9oP2YPVNHoYjDp3/oYvYqr5rNJ4JFUedefYyjpcdLSXjBhWD5OZ9TJ+CGPoxw/e
 C0ZOXP3Yn2eZ9Z+PUg2+frPbnp5D+uPFvrc8TDw8E5lBSbpAEjLSnxAR1uJeOZmnxhpi
 //ua5EZph3ajuo4Lp2AXiF0OM0MQiuQeErAWTuL8NXClW/I3/xSO3+AZMcuoS+Bl5bjO
 doQ+xheTijGlvDgMabJV6jvKNgQ1Z80DqL+306IlpDGrOEpBG57JlDC5dg2bR/aofG0y
 RXWA7wrEBTJA4IlmhoIOZ3LYUnUJOggKDGcYhMaPCx9l6quVmueqPFOIGAq+Tr5b6Zu9
 orEQ==
X-Gm-Message-State: AOJu0YzkBAAJXGc6P+vOZ7wrrw5aJXs4cquqH3BMxl3A3GfuDIPGF85I
 xMcJtZbVgVSTsK3hSFUni5CgJewdyD6wPuhMe+R3Q+ZPWEJ3NIe1NkrbmWAqEUoCFxCchQjWJEd
 x9zDnIjeYDiweDcpx0aYXp9O+50sW+/L33xaE3VRm4ubO+oKxMPcH83FHJB9jVur/sVoYKY42CA
 Um3uDUJ0DNuMk/JuvDh+y7T9sk44ttUTmtWbCpWqSM
X-Gm-Gg: ATEYQzyhnzidwG9pgHl/aGaNMj1treE994G0cd7v9yr0CTEM2bWQxFXFtqAcmKwBd8R
 yfaCQOC+BdZyiffVKH0ojIMBXqtAnDgvhgu4zO0XGEpfJl308ZoJEJbqY3tcB9zqNq28RqNLiyi
 /SwXfRoVtEoDT6Ro8x651Ag1vFhhSF2rc+5DUueCjcu5bXLsf5EbBXwTF3IydoVtN7xf1yFY7j3
 tlBFF83BMRlP5EQddsxYLQYooVCT58q/GkinuZEIXsxUrxruqvLWZZ0JJ9MY6j7q2g71svVNYXH
 aEjw8PlMqVwzR0cwyvxmmvSJLqZBQdcofTLbO8YHdxSfW4wyW4d9j9UgOdZuSHPxQ9q3q3PO1fD
 7W+e/Gi/b/zOOA39DVzCnaJUoPIgd2q9zST7scf/0QY9ILFgLx4a6UbfTQ94lB8lqpEb033+YSH
 lsS4UJnSRJ4HVxapqqvUAh1D2v0fg=
X-Received: by 2002:a05:6000:61e:b0:435:a501:359 with SMTP id
 ffacd0b85a97d-4399de36b18mr21323460f8f.41.1772441072134; 
 Mon, 02 Mar 2026 00:44:32 -0800 (PST)
X-Received: by 2002:a05:6000:61e:b0:435:a501:359 with SMTP id
 ffacd0b85a97d-4399de36b18mr21323409f8f.41.1772441071638; 
 Mon, 02 Mar 2026 00:44:31 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b55d15besm8962989f8f.30.2026.03.02.00.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 019/102] target/i386: emulate: 5-level paging for the page
 table walker
Date: Mon,  2 Mar 2026 09:42:14 +0100
Message-ID: <20260302084338.473368-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-19-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86.h         | 1 +
 target/i386/emulate/x86_helpers.c | 8 ++++++++
 target/i386/emulate/x86_mmu.c     | 3 +++
 target/i386/hvf/x86.c             | 5 +++++
 4 files changed, 17 insertions(+)

diff --git a/target/i386/emulate/x86.h b/target/i386/emulate/x86.h
index 73edccfba00..caf0e3be50e 100644
--- a/target/i386/emulate/x86.h
+++ b/target/i386/emulate/x86.h
@@ -263,6 +263,7 @@ bool x86_is_protected(CPUState *cpu);
 bool x86_is_real(CPUState *cpu);
 bool x86_is_v8086(CPUState *cpu);
 bool x86_is_long_mode(CPUState *cpu);
+bool x86_is_la57(CPUState *cpu);
 bool x86_is_long64_mode(CPUState *cpu);
 bool x86_is_paging_mode(CPUState *cpu);
 bool x86_is_pae_enabled(CPUState *cpu);
diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index 0700cc05efb..7bdd7e4c2a1 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -236,6 +236,14 @@ bool x86_is_long_mode(CPUState *cpu)
     return ((efer & lme_lma) == lme_lma);
 }
 
+bool x86_is_la57(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t is_la57 = env->cr[4] & CR4_LA57_MASK;
+    return is_la57;
+}
+
 bool x86_is_long64_mode(CPUState *cpu)
 {
     error_report("unimplemented: is_long64_mode()");
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index b82a55a3da7..35987a897aa 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -56,6 +56,9 @@ static int gpt_top_level(CPUState *cpu, bool pae)
         return 2;
     }
     if (x86_is_long_mode(cpu)) {
+        if (x86_is_la57(cpu)) {
+            return 5;
+        }
         return 4;
     }
 
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 2fa210ff601..e98f480f411 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -138,6 +138,11 @@ bool x86_is_long_mode(CPUState *cpu)
     return rvmcs(cpu->accel->fd, VMCS_GUEST_IA32_EFER) & MSR_EFER_LMA;
 }
 
+bool x86_is_la57(CPUState *cpu)
+{
+    return false;
+}
+
 bool x86_is_long64_mode(CPUState *cpu)
 {
     struct vmx_segment desc;
-- 
2.53.0


