Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A1B109C033
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RM6-0004tJ-QP; Wed, 25 Mar 2026 12:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RM5-0004rm-LF
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RM3-0004dv-T4
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMwtdu8zITy6FiC5AzTGmGzrMXxG2qh+5n3w3ZMaSQU=;
 b=ZA+QL2/lkDGfxxQ1f5apcaizDDPpKn4I0DSaOyCJeynDnnfoRFKr2mtfcpyqvs4XvDwBb5
 RLYK5mMw6oPhP1J1ALxHsw1QfGjOPy6DcpVacophNUbpBE/7R9/HCZa+OyIUg0EI4lgCoQ
 OthSCKUpSspweXmQi9mHQDgiMqTtRW8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-LBxyhtXbP6eaYcTxyLDq3Q-1; Wed, 25 Mar 2026 12:45:13 -0400
X-MC-Unique: LBxyhtXbP6eaYcTxyLDq3Q-1
X-Mimecast-MFC-AGG-ID: LBxyhtXbP6eaYcTxyLDq3Q_1774457112
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4362197d1easo2237311f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457112; x=1775061912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMwtdu8zITy6FiC5AzTGmGzrMXxG2qh+5n3w3ZMaSQU=;
 b=iQ5ILKyqB+vyjqTodZWQ7hgiN9S7Gnoq67JHB0JTE5s1lGgERaxCKDox74EIFpaBbH
 AZ7t9z+fKJ1T1AVwXEgf3/ky5WZuQz73Le38/v8dBiKpSPJiOJ+UazkyaNKS1aYzuKb3
 sbDPuRE0LjXOtYtEZ8fXJpNMced98GKvNxAQWDmQqhTB1gfG0Nf97eGzMInYPsYN+Jf0
 l5Qkq02zhyMYyiaM7nfYw6/u8EWs6JuHaFSr1VPc1j1pFaVZER9tl8O+shof8XjqNLRK
 A1ipDdqMXOUsYa6i7NLmqoPRw2Q4D+Czdrnn/AYCYAXscsf8MJ0ACxk8r/QotJuyYKcc
 cEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457112; x=1775061912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iMwtdu8zITy6FiC5AzTGmGzrMXxG2qh+5n3w3ZMaSQU=;
 b=LWvY1fwKyXJ+2zWdgdGn6q0J2lMqp72mAczNBsX7WFBQ9fyf3lKByyC3DAbt/cPfla
 +hnc7VQUJjg90eMHRVqYpEBAolTWXWmKVmvJpjGzxqv0BGR2msZliHs3yTWPqz0guBTp
 9fchr7V8XztiTynXBNSqE/AZhlgRFmx9NLOn3Y0qaHBRa7zc+G+QaQkzT4nQbpTOHgxC
 xcLzc8pqJhC4Rl4URmJ23VBrYhgnda3AGxyxMyT7xvjmV24ijsvtI8s3SfHq0eqExnrZ
 MBwBDW/EcnPhc9/16vlj/1V8gzkPpfgEbz+uWWF4PiHRIgukk86V4npPW6+Xf1Erj1pr
 sMfQ==
X-Gm-Message-State: AOJu0Yyut0rpNIRFq4G9imiNTtQO2ThT3ymunsi08SNcy84qbhYjf9L8
 oy7JdyE+kveTqrHGzSVD/7JJ+9wIdca63/J5oIab1SFuwWNfRzB4zHa2b61N6ANS86xy+R9d1HD
 TWIFf9Cm2b4dbhcePtBke6B+n8eu/Qx0rUtSFKkxlxyveSsKX43y4vN1KV+2W0DoyzdXZGMQQQ7
 u/+ljyhuWjY2OQaslP2/J4xNM46NFpjARZskyLoo6V
X-Gm-Gg: ATEYQzwpPGQ3SGZlpbzcZUGj/0rxKEBSoodtHuVVcUp8m4lQ8I7sJ5tJnTK1zW5mxE9
 cJM7Jq6FtWFIZJQpgI0OTynUBNBhrxmaTxZWaXsEwtRNCKw8NPS09c1VqEybxK6bhChjcLmPvmr
 91Dx4YECFdhx0WHyJekestMRNnwOj8z+nhWfUqqyt2k4rzRUxCO9UuuyB0slVyICBfsISEEDIUF
 utHrGLT2kilvj089N/9MsyTtgd5YExzvsg98TP1eTkSPehH1TFA5AZjS/GKaaTCz9etB6COEZz8
 z40jqEi+/oLGsm5U5VSnhFmCAhsaWTb82vwrQDRpN1gVQ98Pm+rK0jCD/tdXcDKJ5gHuqgK6NlW
 DekpGhg16UTe03bd+f8CZX6CVSgEYTiAZpFoHIwENsNH4Ufqa9LtOJA3wVV07EzGYGMTd4Eqqen
 h5FNAl7jHpmSx2pALhBz0iqvmR
X-Received: by 2002:a05:600c:1548:b0:487:338:b4df with SMTP id
 5b1f17b1804b1-48715fffad0mr67833705e9.15.1774457111618; 
 Wed, 25 Mar 2026 09:45:11 -0700 (PDT)
X-Received: by 2002:a05:600c:1548:b0:487:338:b4df with SMTP id
 5b1f17b1804b1-48715fffad0mr67833235e9.15.1774457111068; 
 Wed, 25 Mar 2026 09:45:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919df903sm886778f8f.30.2026.03.25.09.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 09/19] target/i386: emulate: add new callbacks
Date: Wed, 25 Mar 2026 17:44:43 +0100
Message-ID: <20260325164453.72127-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Hyper-V fetching some guest registers is really expensive, so
add a way to query some state from information provided by Hyper-V
to save time on vmexits.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-7-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_emu.h     | 3 +++
 target/i386/emulate/x86_helpers.c | 6 ++++++
 target/i386/emulate/x86_mmu.c     | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 0f284b0c3d1..4ed970bd536 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -32,6 +32,9 @@ struct x86_emul_ops {
                       int size, int count);
     void (*simulate_rdmsr)(CPUState *cs);
     void (*simulate_wrmsr)(CPUState *cs);
+    bool (*is_protected_mode)(CPUState *cpu);
+    bool (*is_long_mode)(CPUState *cpu);
+    bool (*is_user_mode)(CPUState *cpu);
 };
 
 extern const struct x86_emul_ops *emul_ops;
diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index 024f9a2afcf..ebbf40f2b05 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -211,6 +211,9 @@ bool x86_is_protected(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     uint64_t cr0 = env->cr[0];
+    if (emul_ops->is_protected_mode) {
+        return emul_ops->is_protected_mode(cpu);
+    }
 
     return cr0 & CR0_PE_MASK;
 }
@@ -234,6 +237,9 @@ bool x86_is_long_mode(CPUState *cpu)
     uint64_t efer = env->efer;
     uint64_t lme_lma = (MSR_EFER_LME | MSR_EFER_LMA);
 
+    if (emul_ops->is_long_mode) {
+        return emul_ops->is_long_mode(cpu);
+    }
     return ((efer & lme_lma) == lme_lma);
 }
 
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 4e39bae025e..670939acdba 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -49,6 +49,9 @@
 
 static bool is_user(CPUState *cpu)
 {
+    if (emul_ops->is_user_mode) {
+        return emul_ops->is_user_mode(cpu);
+    }
     return false;
 }
 
-- 
2.53.0


