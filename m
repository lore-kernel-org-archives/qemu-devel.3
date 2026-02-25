Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF288F55456
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vJ-0007WL-0o; Tue, 24 Feb 2026 22:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vG-0007OM-S4
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vF-00088Q-Ex
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPmsaquE3JdAXLnO3ruw5k4aSto0QbPW72QvF6hvRt4=;
 b=cx1XrfX+MYfUyO4lwwKKj16+KzBzNNDhakwXOuKYKggbSBZPVA9lXm9BzjSTMpfjQjGGsn
 fQHjpP9QEmmtvRW7Ua//kM6CJhwWQtxbBEWrI4qu2DIvbhPpC3k070ppP6IcadVQXdWjlE
 YqllFvHdDIR6bhZykHIRcagOJlAVWF4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-2jhEJT13M3yHS99PO94L8g-1; Tue, 24 Feb 2026 22:50:46 -0500
X-MC-Unique: 2jhEJT13M3yHS99PO94L8g-1
X-Mimecast-MFC-AGG-ID: 2jhEJT13M3yHS99PO94L8g_1771991445
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35449510446so6218299a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991445; x=1772596245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPmsaquE3JdAXLnO3ruw5k4aSto0QbPW72QvF6hvRt4=;
 b=fdfeu5pYmhqruo8yAYbiyq8oyf9TDJIbx8BfNEBAwhQ0h78lo4HYUUH3qmgsi6X62r
 TnFca0bz+rl+JRXOA6KgcULuWp7jbBK6cskzva4MxBEtKWGd4VoCl22xKBcm0B/ZnAm5
 s9U7tmFOiPLnlF/jxkjV/fSwYK5tbKZ8ys9NkdMUJjjfv85HTRTJ6a22rMHifiZUJEnI
 OJthqne2z2tkrPHLLg28Ntp4lgNL0qqhQcWCFR65baOTv/Sv7F3nUlStx7xdGOxaxMca
 y9Oibj+B5nR+dZRR1YF29kmnI+kEy0i8+r7FqQ0KSdScW/L80N4TwYOg3yzrhRCdTmPH
 gVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991445; x=1772596245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oPmsaquE3JdAXLnO3ruw5k4aSto0QbPW72QvF6hvRt4=;
 b=P2TzqCjHQA4Aj9tuf1pvTkrL0Y1X/E7FADXLRc63r3XCdw5PJURrKCMUPHrWZfLKRO
 ZCgoNmtdKR1hXS9nbMwKHThS89YKCNoIQva9yOIj27RhIBmiuLEmfebTkJtJo1+5CohC
 wKWIgyuVM/z7JEKPXkwwt7yP8YqqXEgfi3fvZISQ2oWdIkYGS0NrWwbb/4/fOPBfPqs8
 chok4jP4UlgKxHEG8GMRre97s4ItuqaAo59qAx0ydoGkuHJ07rti6HQPKjlYL2798Gy0
 H8FANGilnFoU60KWbMXVknQP49xUfzQ1spIg53OY9RIiM8yEjGGPQuOxiRwpwaIEQSwf
 bvMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2ahIw/sajEWzZuCtIHoGTf6saLv5q2g94Dm6JiG/ckOt5uyU85VXn/CPtxdv16HmdsbVaDLISV+7g@nongnu.org
X-Gm-Message-State: AOJu0Ywu63jqb9rnD0gLe1DHQvLYnaHAku3wbp6fUmuRx7la/16fuMfh
 v3DbVLmRSAYyXgiON8lko2RKboCjjKwgLh6sZHyKEyeBhjXsnKJ+Hb7THra43l8FCBMBIHWEZpv
 yi/9gRoSxMvktRmC1DrHZlxSc5PGJde+9V045TZTLF8GUYnFqJhD10lWL
X-Gm-Gg: ATEYQzxDmGvNwHcE+thHdoXAGpVMVgyVGnQEAfDQZiNGMX2AX2GrENYsIGvqIwdYygY
 rhFuu+PkkwCHwPZ2OiTQuOwTLl1ERHYIfiQ8zaahhy4TmjFwWguocJ4Bgwr33f39Ww+x+CTebAz
 aCjLmrpWSlWA26aKLZIsIhc9XAZEGV0lOYKYecDizw33TMtPh33cjGnDxZ1pGbvYXk98lCy7SmN
 SlqbtfwgJnjzDMXHoMEq/OGZ3ldLr4d/0/cj9CFB++x8p+bTTzUnLUVuVobAv1QXbRprNlJAuAw
 fXTuzJ2t+IfzSGih8g5HNoZBd0wvDMhzo8osfq97PJeVxZFhyqqRqWe1EOOAHWsTBVkcxBbWElD
 kCIm/0ClQOlfIhL9QBybxZIwQ6X62aWF5HlgKm88IoU80WrDE8SxG+Ug=
X-Received: by 2002:a17:90b:5747:b0:33b:bed8:891c with SMTP id
 98e67ed59e1d1-358ae8c6c31mr13176617a91.23.1771991444899; 
 Tue, 24 Feb 2026 19:50:44 -0800 (PST)
X-Received: by 2002:a17:90b:5747:b0:33b:bed8:891c with SMTP id
 98e67ed59e1d1-358ae8c6c31mr13176593a91.23.1771991444503; 
 Tue, 24 Feb 2026 19:50:44 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:44 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 11/35] i386/kvm: refactor xen init into a new function
Date: Wed, 25 Feb 2026 09:19:16 +0530
Message-ID: <20260225035000.385950-12-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

Cosmetic - no new functionality added. Xen initialisation code is refactored
into its own function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8679e7d3fa..feb3f3cf3c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3433,6 +3433,24 @@ bool kvm_arch_supports_vmfd_change(void)
     return true;
 }
 
+static int xen_init(MachineState *ms, KVMState *s)
+{
+#ifdef CONFIG_XEN_EMU
+    int ret = 0;
+    if (!object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)) {
+        error_report("kvm: Xen support only available in PC machine");
+        return -ENOTSUP;
+    }
+    /* hyperv_enabled() doesn't work yet. */
+    uint32_t msr = XEN_HYPERCALL_MSR;
+    ret = kvm_xen_init(s, msr);
+    return ret;
+#else
+    error_report("kvm: Xen support not enabled in qemu");
+    return -ENOTSUP;
+#endif
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret;
@@ -3467,21 +3485,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     if (s->xen_version) {
-#ifdef CONFIG_XEN_EMU
-        if (!object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)) {
-            error_report("kvm: Xen support only available in PC machine");
-            return -ENOTSUP;
-        }
-        /* hyperv_enabled() doesn't work yet. */
-        uint32_t msr = XEN_HYPERCALL_MSR;
-        ret = kvm_xen_init(s, msr);
+        ret = xen_init(ms, s);
         if (ret < 0) {
             return ret;
         }
-#else
-        error_report("kvm: Xen support not enabled in qemu");
-        return -ENOTSUP;
-#endif
     }
 
     ret = kvm_get_supported_msrs(s);
-- 
2.42.0


