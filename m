Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9936CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB0O-00059P-Pp; Mon, 28 Sep 2026 09:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0H-00058L-Qn
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0G-0004Kn-7c
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8xh6U/mkKR+NkoNetETMDGnTrpdlOFIsC41PL8P3Kg=;
 b=G3hzeL7uJbzO/SmjAkt1HmRx9Q2OPFgRdgYwUdLlvKQhqnLeBkE4QHe7IwBnxXHIrBEs6d
 mJjXgN2fCxnUDC7VjDIz7TSoPg/2NkYBxl5GcPH+4BPhiQ7a5Mf0Pc/Q4rie/PGn0Uj9XL
 3eNi8zrtuh+KNFiMHrmpOPrZfzhkNj8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-_ITox9ZmNPa_ohNYBbxy2g-1; Mon, 28 Sep 2026 09:02:41 -0400
X-MC-Unique: _ITox9ZmNPa_ohNYBbxy2g-1
X-Mimecast-MFC-AGG-ID: _ITox9ZmNPa_ohNYBbxy2g_1790600561
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-69e70c286ecso3146566a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600560; x=1791205360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+8xh6U/mkKR+NkoNetETMDGnTrpdlOFIsC41PL8P3Kg=;
 b=NnWnrodqV4pH9qia0dsJ2dL/xiuQHfYnEn7mijm0zMW6xgHrqt5HNqL8Wx8AnnbhU8
 cLfJJPLc5fwN53+0HaqxFB45+H4Iha0KTQVIPhR4teV+f5E32lh3tbgZxvgALxKYyBSP
 URBpqmDPx3gFIgUAOolTaXQPQjUmOQ6uYz73bFkBiyOdRpjcUH5UYnqyPANA5QnlowSj
 4MXiklQkoNbO33LO3mxm0vVVAR9kwhzJ0pz8zZIwYxH/xm09gQl/Mddl7AFmRcCye+Jm
 aDsmlIiINDMYdamNgJJ9pxtqvb+Q8zMjN+OqmuZikdLj+mGwjvqHS3HpptOm3GpCgrWb
 ApmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600560; x=1791205360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+8xh6U/mkKR+NkoNetETMDGnTrpdlOFIsC41PL8P3Kg=;
 b=LUstB5C8/NAuR1V5PiUdZYCKszd/PDiJhL95Qwp/ZTHCneeJXThukZegVBDnCXFPce
 dZ5rIJFCiRgA5+J26qbhVEuvSkI0XTDOxxI/w9Za4/V8Kn4SLEwx3f5ZSmd5pk7QhKUz
 FG//b8IspYjTKr3j0umUkKfd5x2Mp5fkxvntFRTI/2hlucoaC8ALpptKbqQYyQp7FGOy
 kY199fQStHtSJreCzw156wAlOVaa/YtstwSG4S2xorGtKcQqamtcJMZDCJlKEp8F2aPp
 7hqti4fAMWluHwVwZGUbrYDdCz2Qiagic9UvPHZPl0+hncqFQpzDOkHOdYswVgcQK4Oj
 +VDQ==
X-Gm-Message-State: AFq9FYK5S9uwwF66TPMKFyMxmkmroURTuWVlVwa/SxKF4PSEAI7vJFds
 m3BlaYgL5J7JJyOdzqN8IJ25yhiAsmhDEd10YsbERi01cz37CLaogFxRfin69Jz+uolEiS2v4JD
 IHCMcrVkvR4869PCrAMwJL5UcCvgQl++Bve1yHYX1mez/A+WafVwxHekWR+yW05cf1gBU+mKiqA
 Ufy86hVb5WgcZXpwNBx4D0//GA1cGF4R86oNrQhT+B
X-Gm-Gg: AYBFou16AEXyojnrRcbOsURmz5hEy5IvCsid4Uot/q+F4SKWkV9hqTr59aRnMxGYxYV
 ugbaYkviUsMqE7VYwUkPAYsTWyYDHde5TwMjHoYQhxkPKS9UDt7lbEFc2mXR6Uao3Enur8aiS8X
 pK81ot/950+oGMqXsN8Bb/hoLtZOJ4lxbPtvL6k5bHMMovjKofzMDgfSpxIE8tYp2vV4TLflqWD
 5NSUT1vQgHk3myuQaEdy/7EpXjIgpfp47jaL9+GigJ+tmXnGhEH4ogJt99LvRSgaK2JiDL96UzG
 aU565p/A8CNFwyMpuQeTRdgsR7hoVPrG1ErE9R70y3O+biX03V4kwr/QPKaN3wptvsa7W5nx0il
 2T3ngjUQ4UHnYl0wFy3Hc7Py5dhb+vEoEEh9o3zb9N4SQeXCNpW7pDumV3WZUcwwf1EbBFdFv+6
 aoRWnC
X-Received: by 2002:a05:6402:e96:b0:6a9:cb3:7022 with SMTP id
 4fb4d7f45d1cf-6aac90f568dmr10493210a12.40.1790600560587; 
 Mon, 28 Sep 2026 06:02:40 -0700 (PDT)
X-Received: by 2002:a05:6402:e96:b0:6a9:cb3:7022 with SMTP id
 4fb4d7f45d1cf-6aac90f568dmr10493177a12.40.1790600560115; 
 Mon, 28 Sep 2026 06:02:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aae5dd5e49sm4041944a12.19.2026.09.28.06.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:02:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, qemu-stable@nongnu.org,
 Yuxuan Li <liyuxuan.darfux@bytedance.com>
Subject: [PULL 03/30] target/i386: Migrate error code only with an exception
Date: Mon, 28 Sep 2026 15:02:01 +0200
Message-ID: <20260928130228.877003-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yanfei Xu <yanfei.xu@bytedance.com>

An exception that carries an error code must retain it across migration.
Otherwise the destination reinjects it with error_code 0, which can make
the guest panic. Do not suppress this required state for old machine
types; an incompatible destination should abort migration instead.

The chance of stopping a vCPU while an exception is pending or injected
is extremely low, so the cpu/error_code subsection should rarely be
needed.

It is currently emitted much more often because KVM does not clear
has_error_code and error_code after completing exception injection.
Require a valid exception_nr before sending the subsection. This filters
stale KVM state while preserving the error code for a real exception.

Fixes: 1b80f1009d ("target/i386: add compat for migrating error code")
Cc: qemu-stable@nongnu.org
Reported-by: Yuxuan Li <liyuxuan.darfux@bytedance.com>
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Message-Id: <20260914113817.2212058-1-yanfei.xu@bytedance.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 1 -
 hw/i386/pc.c          | 1 -
 target/i386/cpu.c     | 1 -
 target/i386/machine.c | 2 +-
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 786957fadd0..4b9df1d3329 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2389,7 +2389,6 @@ struct ArchCPU {
     bool expose_tcg;
     bool migratable;
     bool migrate_smi_count;
-    bool migrate_error_code;
     uint32_t apic_id;
 
     /* Enables publishing of TSC increment and Local APIC bus frequencies to
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9006e7c29e1..6ebac0c20b1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -85,7 +85,6 @@ const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
 
 GlobalProperty pc_compat_10_1[] = {
     { "mch", "extended-tseg-mbytes", "16" },
-    { TYPE_X86_CPU, "x-migrate-error-code", "false" },
 };
 const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b97f144aea5..2a69ffeda40 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10818,7 +10818,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
     DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
                      true),
-    DEFINE_PROP_BOOL("x-migrate-error-code", X86CPU, migrate_error_code, true),
     /*
      * lecacy_cache defaults to true unless the CPU model provides its
      * own cache information (see x86_cpu_load_def()).
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 8d69d7e25ef..b5c6b127c9c 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -466,7 +466,7 @@ static bool cpu_errcode_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
 
-    return cpu->env.has_error_code != 0 && cpu->migrate_error_code;
+    return cpu->env.exception_nr != -1 && cpu->env.has_error_code != 0;
 }
 
 static const VMStateDescription vmstate_error_code = {
-- 
2.55.0


