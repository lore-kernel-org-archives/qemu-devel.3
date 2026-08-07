Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4736C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsLlq-0006es-LO; Fri, 07 Aug 2026 10:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsLlm-0006e4-AX
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 10:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsLlk-0006cO-Pj
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 10:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786113715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntOkQz4rb6jGTkKzaUq5VrksdNoZdB8doBNUmyxRMzA=;
 b=RQg1BNG8oGGIrPiVoHboO1U77IXXYnAAa3rmdHC3L4CMhiBGgla4YorRW7XvC8qanBpoDg
 5f/P+LWvpeClEDnUfYKcO2digE9mPZpSlTDO3jPaGGGMMPgRQSvm375CR3apRm6mt//OKB
 Tev+vfXr5XFoPBVLP+rcc4G1dkV4ueA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-A-PkpwnyNq60Z3--3E-9Iw-1; Fri, 07 Aug 2026 10:41:42 -0400
X-MC-Unique: A-PkpwnyNq60Z3--3E-9Iw-1
X-Mimecast-MFC-AGG-ID: A-PkpwnyNq60Z3--3E-9Iw_1786113702
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4954c2d4081so25952295e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786113701; x=1786718501; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ntOkQz4rb6jGTkKzaUq5VrksdNoZdB8doBNUmyxRMzA=;
 b=tm2Eao4l5GaoM+3usV2OwhJw/w3mvIdlh4deTzOQaCExXEwZOv+ZUFbJZVXTpkWTiV
 koQ0l6YAN1/c2cWNc9tUZHgnR8tobODu/OVGl1QVtJosRa6o+9Cles2nDBN1dPHv0D96
 1M9PS0hXtpgr2BNR3IKZey1ceCJ74+j+iMfPvrZdlsOnLfiNnV5Td+C0CJPCjjYdnv76
 86gnHyBR5qxsCBLG1PFQoE3wR/zqD6IlXaFUVOuX6yNv8veV478kpXErkHKzE8GWn2vs
 assLMu9uUYa4d20pG47/NLWs+oawwfSbWod63RzxB4tZ/YsLY+TOLgws2g0rebhqDOBX
 K5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786113701; x=1786718501;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ntOkQz4rb6jGTkKzaUq5VrksdNoZdB8doBNUmyxRMzA=;
 b=an1bHDUSwlld8C+F4VaDihiqdZPrC/5DBJ1m6yGiPX0PTK0mDsKXRmULuGpzFsZuIE
 eUkvLcYDeDMKdeIBrLnDkWzezjhUR2dXLyeQgkl551BCKWEjHvxeWa7xek2Qnss5o9sw
 /Za75rRPo0mo+ZodcBTgO8SsiXS4GF1XbS9kyv4g6LDEk/Gw0m7CRO930jz6Pnd/Kgmu
 PhZJxG+Dox9okUHgfxCdLpqmjuTxsRRM4RKZrzKqO9L6VXssj/yC2tYarSL4/DJDErg1
 PbAU6J38Tr9DPXCpHTY5WiqmUNUq/41iC00HjCV9bJ6+kqSK1eWCZYWU7S/hbGPxESLL
 m+eQ==
X-Gm-Message-State: AOJu0Yy1roneU0yET+x542Gje/SUmX6zgsDatJSDcDzGEeIh3UX0B0fU
 +AngAYtu/LJizWF5gQ4xSiazSzgG/pSx9ux+o0NWqf+qd06rxX+EcynfbsZdORvlqAk3jX6yhJ3
 iyGId3yXYIl12yHOWsb7X+4ZzG3bRWBQ3Etf5t2kgfp4QYAQeTuW+wnEjbqoeK64M0JJL5dHSCC
 9e23oglQ9JA0rUzF91+5TPIocxrcQ5ZmYGJRLfewd5
X-Gm-Gg: AR+sD13WwBidJ61j3U5ntGMDqkAyfGeURRxebWy96vI4vSeleAg4YlvNOxBh/v0v1gw
 tjCoUrtq/nrNqPvu+HDuECXmibf14kx5Z8faxNo/WUnEHg4uhlMGxNTi2nZH+llmt2PKyVN4uys
 M48qij7BbyD7Q1ARf0zWUkTHqDwvNkZDqn2qwjfB2xY5QB1yh6Ejr9pzlX58boW7GRZ+h82VTtf
 PG1aNBHCh38i2Fa6Lpu6ayMWHv1W+zOdWJkIritKEFTiLBmRyc5Rz5+/Pbk+MdDA78RvLQZYsCw
 UsftuidlCSk4z5nSCfhriMdQOZgwu92OK+0UcSxCrR1lWpL25uQ9oWURxzJPYmx0OXRXT0/1D+u
 9SlU/9qscw1+mGzDarm5RMnoZikvPwTxLQ6nRqMFDCh7gQ8KxdWG6RL/gZ7gI1eGdCn3KLDGApR
 hSGwo=
X-Received: by 2002:a7b:c7d7:0:b0:495:4811:d71c with SMTP id
 5b1f17b1804b1-4994e7c55bcmr266966225e9.13.1786113701692; 
 Fri, 07 Aug 2026 07:41:41 -0700 (PDT)
X-Received: by 2002:a7b:c7d7:0:b0:495:4811:d71c with SMTP id
 5b1f17b1804b1-4994e7c55bcmr266965725e9.13.1786113701322; 
 Fri, 07 Aug 2026 07:41:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800214557esm6412333f8f.2.2026.08.07.07.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:41:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Saul Freedman <fre3dm4n@gmail.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/1] target/i386/kvm: Fix CET SSP MSR read feature check
Date: Fri,  7 Aug 2026 16:41:36 +0200
Message-ID: <20260807144136.2637416-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807144136.2637416-1-pbonzini@redhat.com>
References: <20260807144136.2637416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.55.0


