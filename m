Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C229C109879F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c5X-0006rV-49; Fri, 20 Mar 2026 11:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3c5P-0006r8-Il
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3c5L-0004xb-ET
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774021705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DKuhkeFeXS7Jd0XeIWPiXn4LbHD4gy847cS4YxDczJU=;
 b=f6FrQNXEezRGVMgTNBmfy9jIuP71iJbsArMEzz99c36DIcUfM1anFiM780vaD5Y2c53rdM
 szdt02Nash6kapybir2hFWVHim6Yt6x/rK7nZPA0fmSMEpLRbibQj/EVk1c5QWP5H6X+hl
 vuNHqm4UcH7hPMN6o26aPon4bmpqvXk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-5qnFCBn1MIioKvmjeWPZSw-1; Fri, 20 Mar 2026 11:48:24 -0400
X-MC-Unique: 5qnFCBn1MIioKvmjeWPZSw-1
X-Mimecast-MFC-AGG-ID: 5qnFCBn1MIioKvmjeWPZSw_1774021703
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82a88a2704fso852961b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774021703; x=1774626503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DKuhkeFeXS7Jd0XeIWPiXn4LbHD4gy847cS4YxDczJU=;
 b=XV0r/zIuyXQr8I5xfaORAmFYMRcO/lqdyPOrOnUwWgCKPZ0WNp8GIkmBjwuc9rMtYd
 t/628XgjzDA1SCEaSwrHvoBzq2DlmSHBqQQDi/VQJY0uqrIsOs78LOl8H7bHNcgcBE3U
 6j2tezgumm7keyVHEoOTtIvUEKBSMSKrf4oIgbnv/7I9+4mb0iO30d6nSgEgCU/p0Hju
 3TEYdvvOGrmXfl11EH1Libo7HvdmaHXeh735lRt1aXwrMySUtallzF9q+ViHAB0M+1SU
 jLRSZk+PabVfDZ7aq/+aFpumLjSZ556C+5OewR6w/8BKaAUMYILWZmG5kL1U8yGPnnDu
 0vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021703; x=1774626503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKuhkeFeXS7Jd0XeIWPiXn4LbHD4gy847cS4YxDczJU=;
 b=abLFKmLIpLrvfAhDjq3ipR4sLx8bomaq4ngd6sd7OLmCf+GsKvhfeI9cHmRN8vCDLq
 C1oSvRfoL1NjXXa1+H0zKYXdKG5/hBzu8bTs0plcES7XiS6CHBeq1AVkfavx33UrYl7Y
 z4n0vmEdnQdqbTM9Sul7ATwkUxba+WwmC0e52dBw1zMcCT5Z/GrpOll+egOlzx5K2VFo
 7Ki0zbG6+zFBvBgcKBXH2pi2WPrVsjUYdZtuHwY+Q6a85iI1FQZYP9TcRpB5LDpL70NZ
 +a9fA+EX95ZiiS1X6dyiPek50xQiku5LsjqDaMh9+VhAoi4+BNWXnGNvOfbAcdbGZvbD
 o/XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9KvoUsyGwEG9q0fPVexC8YSmr1kIrFLEGSDNAUfAf8t0l1EWtr5DGLSLK8McD1AWjtdExMLIXnFF2@nongnu.org
X-Gm-Message-State: AOJu0YyTwFQMfRNuMcP7DklW1yDsTPLuN7hanvN3CGidRIHzWJiO5K2N
 gxgvTmrW+5LnG3lJJehQiClOskOQHyM7S8tQwwEzZdhXFIP2eifV81fOyCFpME0urteJtMzNtwT
 ZwSs+t+rX1Lo+nLHGEIYG3WnhajExF1Acm8T9YIWGLAXZuLCQM+UoWJ6w
X-Gm-Gg: ATEYQzzTTjyjT4UZTqvhYas5f6793NaJVuuqDvGRYXKFon1VmNO5nla6pfmd9Lzmoq5
 JuL+VhFjdXBaMqSCdRhDlrAUHLemxXirVconM13X5jvtYLBop+wmPim3ojbO40P9XeYKgXdTvIT
 r36K4dYyPQKuJckdL9XN4PZq0Gug78tUTFZB7xk4F2mxGNqkVGvAgUz39iJFnA4LYl7/gkvhLwN
 PIPdHGUdHsF7OoV6JF2Twrae8YSal+3toAfNB+bjsfoM9XcTSgv4nHl7yWgpI8qv/xQXOh2cYdP
 XPgcNZ3A95d0pg5F+HWmFZ5JQDUS0cCnAR14wM+j+d0ebai4A9LbO5l5sWuA4lHNCLpnE6UQnmc
 UGUwzSUq66OWXmXJYJ0s7bXjbiwq6CtJ6M5NpM5OHk6jvcZCGSYKmEFrqgw==
X-Received: by 2002:a05:6a00:3e12:b0:81f:ac1c:709e with SMTP id
 d2e1a72fcca58-82a8c45c006mr2610777b3a.31.1774021702831; 
 Fri, 20 Mar 2026 08:48:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e12:b0:81f:ac1c:709e with SMTP id
 d2e1a72fcca58-82a8c45c006mr2610756b3a.31.1774021702368; 
 Fri, 20 Mar 2026 08:48:22 -0700 (PDT)
Received: from ani-lenovo.lan ([122.163.114.34])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82b0409b448sm2267092b3a.39.2026.03.20.08.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:48:22 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Sourav Poddar <souravpoddar93042@gmail.com>,
 Xudong Hao <xudong.hao@intel.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH for-11.0 v2] hw/hyperv: fix SynIC not initialized for CPUs
 after the first
Date: Fri, 20 Mar 2026 21:17:52 +0530
Message-ID: <20260320154752.204725-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Sourav Poddar <souravpoddar93042@gmail.com>

hyperv_is_synic_enabled() is a global flag that returns true after the
first CPU initializes SynIC. With -smp N, all subsequent CPUs skip
hyperv_x86_synic_add(), leaving them without a synic object. This causes
get_synic() to return NULL, making hyperv_sint_route_new() fail and
triggering an assertion crash in hyperv_testdev.

Fix by introducing hyperv_is_synic_present() which checks per-CPU
whether a synic object is already attached instead of using the global
flag.

Fixes: c4cf32fc63f1 ("kvm/hyperv: add synic feature to CPU only if its not enabled")
Reported-by: Xudong Hao <xudong.hao@intel.com>
Co-authored-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Sourav Poddar <souravpoddar93042@gmail.com>
---
 hw/hyperv/hyperv.c         | 5 +++++
 include/hw/hyperv/hyperv.h | 1 +
 target/i386/kvm/hyperv.c   | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 27e323a819..3d6212613e 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -60,6 +60,11 @@ static SynICState *get_synic(CPUState *cs)
     return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
 }
 
+bool hyperv_is_synic_present(CPUState *cs)
+{
+    return get_synic(cs);
+}
+
 static void synic_update(SynICState *synic, bool sctl_enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr)
 {
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 63a8b65278..23091301d0 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -81,6 +81,7 @@ void hyperv_synic_reset(CPUState *cs);
 void hyperv_synic_update(CPUState *cs, bool enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr);
 bool hyperv_is_synic_enabled(void);
+bool hyperv_is_synic_present(CPUState *cs);
 
 /*
  * Process HVCALL_RESET_DEBUG_SESSION hypercall.
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index bd3c26d02b..420c76b5ff 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -27,7 +27,7 @@ int hyperv_x86_synic_add(X86CPU *cpu)
 int hyperv_enable_synic(X86CPU *cpu)
 {
     int ret = 0;
-    if (!hyperv_is_synic_enabled()) {
+    if (!hyperv_is_synic_present(CPU(cpu))) {
         ret = hyperv_x86_synic_add(cpu);
     }
     return ret;
-- 
2.52.0


