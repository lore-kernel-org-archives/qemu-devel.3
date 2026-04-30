Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0039FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7l-0007j1-S8; Thu, 30 Apr 2026 13:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7e-0006sN-PF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7c-0004rL-Vp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbjWcZdrNQsZzCJqWUMwt6OVdlowLhocYfWplzHM/v4=;
 b=dm+1Af891dvptvEnUdduX/Bw4IefBn+wWVtZJ1KnIEbYxEPE3hI6jfKttT2IcGvsIKl1ad
 XlufvZeAvcw4NJs8TlR5RuBYg3lOXn2pvvWOL2g88/jZ0r8Q/DMOUgUhEWKwrXYc62trZU
 gbPQ4ThNc1jBbj2NwPKTEUBolGm6P0w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-n4ZmW-4kODaucQzitUKmAw-1; Thu, 30 Apr 2026 13:24:17 -0400
X-MC-Unique: n4ZmW-4kODaucQzitUKmAw-1
X-Mimecast-MFC-AGG-ID: n4ZmW-4kODaucQzitUKmAw_1777569857
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8eb04352924so224228385a.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569856; x=1778174656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbjWcZdrNQsZzCJqWUMwt6OVdlowLhocYfWplzHM/v4=;
 b=sZpWnjvk7M+FTNxtPCToff0ciun3BlV/yMxTXMdY0Akn/M3yKkYn0LR4M1TtimCijB
 u3zXDilgK2PoCrfJ7mQKVmkJIbO/FmzNZQUWaK3AqRRslyysO/Cu08MLlk3grwIFV1Q3
 UXEuYlTOmD9DHqbZC+UnXHHC2f+RXD0bK9p17Zt31V4QFAywevOncHvYZOjCdvyFoQ+v
 8Y8iaDQRJ+S6vDjLoA7kF92oorQ++z8+tTMa4l6mSJt5Qy+zAS9aGrj69by5O645VoIr
 OyR1C8D0odk0UVMcdt8UPAkSEorjufn378rI+Qh16080IApQCTlzsFz07Fnp+Ww5jSHc
 8JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569856; x=1778174656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sbjWcZdrNQsZzCJqWUMwt6OVdlowLhocYfWplzHM/v4=;
 b=bkc6hClnPsbx7fWiz2YiR47pYGDFZXY3cD04FnVaUFJt5SeXPh9zXRtaJdvcVdTQ0p
 Hohf5G3E7eFncw864n+IPSQh12dbZHwRjvuNUukma6INTygJ4WhanPGUb4AzRnI7us86
 6MlFKgiznbRToIN7tSb6hTLRj5O8W8kP9WCIR+T9L1RqwOrjNdpEItXFodCnAOkbt5/4
 n6N5tyszd24ZchWF/DVqlQQm1wUqwYgap2Pqp8AcrnexsaYKjHjrnm0eZ8TTa9wB3YRm
 +q1TBuyN2bCrWPQvjOn2F4BJS70/T7/x5sYNOVXD0rtmK42nwyeIAPxcK2nEL/a+KvnS
 7WvQ==
X-Gm-Message-State: AOJu0YwyexAmYgl/2s8s3FoJBNUXkAzU6CWX+lMiPRcfdbM7t6AuoXRO
 r3fDd1hwmddFjfZt2Aw1nlU+/Adn6snosShGuoLgJqj3PF8KkKEHfLVVvQ2Bkni/aCOAZE3b2IA
 Q+fqulOaxGTL491Yj2oP6MFRW7NYOUneJi5hwfNiQ20T9Aemv6GEkRvoIGvLc+AlZdfe9q409Jo
 BYOWPTtMs3XtnuJlr5UiIOAZNXykf0qc9qH7TY3huB
X-Gm-Gg: AeBDies8Bw6EfBYxKoqcGe5JSYmMNQHIHS4hAfnloWIHEv0ROvkgZcq0iYzHAhYq1bD
 qq9laxXw+Kkp3Pp2IddZpEpcjFygc2HxsrFrB374Q9Av3ON0yyYNjf1upURqxrVIwc/h1FXu7nY
 vtagLveQ3lEUgANav22sdwMfS4H8e0q87U0NEQDDQZIcplgBcNtPOTLkgaRK7bHZwtTU4kifF91
 1OuaIlwCO5C/Vbhc3/8bkm8l6o3d2pzdgwM6XuegL8XcRjq35h1T+NMx6Sqpu6kaMSkB1O94t0W
 s843SDLg0UKvsSz3PlD1h07mvGjoFN1bbl4roVjonUQQ62Bl3ffJf7NjVL7jgjjxHtoU9btfMd3
 dm3g4wXqF3/urKe9mnHNC5HJkhslO4g49CslwlJ+qe5sda0VusYcsmGFqxw4WkoOVdQze6Ne7Xi
 TyUvTEHKWhIA3NLFSZGIJAox9cm5pmXrMCZjQ=
X-Received: by 2002:a05:620a:4455:b0:8ea:bddc:690b with SMTP id
 af79cd13be357-8fa89324cd3mr587589785a.51.1777569855918; 
 Thu, 30 Apr 2026 10:24:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4455:b0:8ea:bddc:690b with SMTP id
 af79cd13be357-8fa89324cd3mr587580385a.51.1777569855175; 
 Thu, 30 Apr 2026 10:24:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb0fe8595sm34097085a.11.2026.04.30.10.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 41/58] whpx: i386: don't increment eip on MSR access raising GPF
Date: Thu, 30 Apr 2026 19:21:47 +0200
Message-ID: <20260430172204.1006673-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Link: https://lore.kernel.org/r/20260422214225.2242-33-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index eecc7f48ed9..4bb99a8e900 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2048,6 +2048,7 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
             bool is_known_msr = 0; 
+            bool raises_gpf = false;
             uint64_t val;
 
             if (vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
@@ -2086,6 +2087,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     } else {
                         whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                     }
@@ -2105,6 +2107,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     reg_values[1].Reg64 = val;
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     }
                 } else {
                     bql_lock();
@@ -2112,6 +2115,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     bql_unlock();
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     }
                 }
             }
@@ -2135,6 +2139,13 @@ int whpx_vcpu_run(CPUState *cpu)
 
             if (!is_known_msr && !whpx->ignore_unknown_msr) {
                 x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                raises_gpf = true;
+            }
+
+            /* When a GPF is raised, do not change Rip. */
+            if (raises_gpf) {
+                reg_values[0].Reg64 =
+                    vcpu->exit_ctx.VpContext.Rip;
             }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
-- 
2.54.0


