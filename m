Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09160CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3ec-00010o-EF; Fri, 26 Jun 2026 06:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eU-0000Zd-Nt
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eT-0005N1-1u
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3FPFtWK7Hdsxwe36pUBqav5XMaIfU9fErfGMcCg2SxE=;
 b=MeFLt/psNpf1kcecarZA+JJvuGCU6A/QtpNFynK9EEqvLpqrEEtprNX2aWcbUKbaTauWA+
 xOd4AWZ29kF2zGLiXzFfU3WhXYp3pJs4LGY7tKFfP4mTH6+pd5YDRjahMwqLT1+TAFeTje
 6AzYlHRvQ7suSkXR8mA0jhFNdruqwG8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-YaYKYSK0NWSnZp1Hdwyeug-1; Fri, 26 Jun 2026 06:19:11 -0400
X-MC-Unique: YaYKYSK0NWSnZp1Hdwyeug-1
X-Mimecast-MFC-AGG-ID: YaYKYSK0NWSnZp1Hdwyeug_1782469150
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b4d3d3e6so6054405e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469150; x=1783073950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FPFtWK7Hdsxwe36pUBqav5XMaIfU9fErfGMcCg2SxE=;
 b=p2v00i3AvWQjewibzoqIb6p38mI4SKeE+v/7vqk3aoe4Um4wfDc5kQQHR/5ajwfqmz
 zrjhXMtNIi+mxQ4bd9CRBVueQrt8ImVJyBKB04AqDNuy2PTYBZTSsOlRt1PzGt9TUdwr
 W1qReHSRXLCSt3fbSBk4IfBTLVlo4Zt/RoNNEgAuWaqVJwZlzMTULUnfEEKPRK4/VShq
 Y9bj2MITu+eNTXFucHn5SG6dE3GcmdNDbLPHB2O1CAbHOjYZIxiGNeFY21WGuJxkT0EM
 B0+XCQKpcMRIFn008CJkCbUdIeFR5a3GQX7Q/3CbyA0U0jMTMJk3dGw2idDmgK4UEJ1E
 EjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469150; x=1783073950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3FPFtWK7Hdsxwe36pUBqav5XMaIfU9fErfGMcCg2SxE=;
 b=nOtaZ51vC13abi+WveQEpZ0W3D2q9K9JnuogLgixFhTKhWg5QRLve0RGci7WY596/L
 LaoK0Yxs1NVsd7kGZtDHekMdMQG2b6xZB3EyfwyIi2vnSPaaffE10WCjwfyCFZevJZEK
 f7taDnY8TLfi0aAIq0twvwRcDRfF6fZpiCDnRJ2QXEdi7KwsX3eczYqsRMpkh/Nyn1V1
 HQXA1G1NupKzVZSJr3OZbXyKQSFO072rp+CUieU0I3xfeIcSEBlkH3R4tHzMi70YMjTN
 P2YHCFE6uOrOxL+H2xs1t+EZr7Xd+c3rPT6a3x4s7F8gI0pJYRr8pNaGwie+2SoctEoG
 R8Fg==
X-Gm-Message-State: AOJu0YzgjCC4VKzLu0ozKUMEsNIzVcyX5Hpiqup1YAgYH76yX2PqrCyq
 8Tq0zv0nu52CfGVETi1p9giLl3kMV8QPvToYmMiEqu5ksSOEu52eE330JoYNsGwiG/cvZ4WvrjG
 U+1V7S6307h7N+TObQstnJUnoo4rJbGF3++x01oJ+VI3WwaBWzU+0zWXGq2csrmJHS/pvzlKPR6
 Q/9EDfnKTQZ6w+GwYHMWRe224IwBEBwQxMnl5pk4iI
X-Gm-Gg: AfdE7clhegk97duJ7yIMmsASlpwxyCLHn3JvY0OOSZ7tNXY9qTcA7WyoqvnoS6c1rQT
 eJondEdJmwuc6XB/PHKPHI4xQKx46Oj/nhtGMHNCb0cR7n2wjDgO8Q6VfCFxcVnr540NrEEt4FX
 kC9cLKZYsE2Zy82ntjhjXAlIkYWNa9TBfcRNHdLw2lWHkTwqDSD8RIrj/pu/CQ1FJFRWbVTcPfJ
 cakxEOwuif5y0mnqfbBeU7LVc3+8BQutJ3X0/ROtO6rVEpw4dFiXgVt25+gl6GBOyyt5f8wCGU7
 WtVHlTKWqS0VbpcjQrvf0827WlEVbtV+Nz1UjC/+zim3Lt9vaGMuCxkQMuHXiQT7TyHCN+py4+6
 6Pto+t/OzonQO63xDIsVM8wofusHZl3d0vE4PfK6GkSAoIdz4RyB3hmVaGO0Ih9f+lbRXFFB0UF
 RsJgBBi1oOB+0IFK1o
X-Received: by 2002:a05:600c:82cd:b0:492:48c8:c705 with SMTP id
 5b1f17b1804b1-4926fc2fa58mr1600735e9.1.1782469150088; 
 Fri, 26 Jun 2026 03:19:10 -0700 (PDT)
X-Received: by 2002:a05:600c:82cd:b0:492:48c8:c705 with SMTP id
 5b1f17b1804b1-4926fc2fa58mr1600285e9.1.1782469149586; 
 Fri, 26 Jun 2026 03:19:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1b754471sm22958631f8f.0.2026.06.26.03.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 29/45] target/i386/mshv: reconstruct hflags after load
Date: Fri, 26 Jun 2026 12:17:32 +0200
Message-ID: <20260626101748.1728079-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

hflags is a cached bitmap derived from standard and special regs. We
want to reconstruct this state after regs and sregs have been read from
the hypervisor, similar to how it's one in other accelerators.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-33-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index bbf874f6413..8bd63bd9628 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -765,6 +765,16 @@ static int set_vcpu_events(const CPUState *cpu)
     return 0;
 }
 
+static int update_hflags(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+
+    x86_update_hflags(env);
+
+    return 0;
+}
+
 int mshv_arch_load_vcpu_state(CPUState *cpu)
 {
     int ret;
@@ -779,6 +789,9 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    /* INVARIANT: hflags are derived from regs+sregs, need to get both first */
+    update_hflags(cpu);
+
     ret = get_xc_reg(cpu);
     if (ret < 0) {
         return ret;
-- 
2.54.0


