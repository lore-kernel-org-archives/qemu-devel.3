Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9038AF55455
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vA-0007NX-Lz; Tue, 24 Feb 2026 22:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5v9-0007N9-BR
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5v7-00087s-SX
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eq6qLXbyXLJc54ZDJbb9jP08uxtrOMIUIN9nTu5R5VE=;
 b=SLOXksu5iaTUJHVzIpLsnBrPaomYVitDrHWPwocDLkYO1NQ7rGXWEIFHPlqIx8KT+Ks7Pn
 YCxdon8hxwkezndAVjjNsy4ZeaTMqghceqnnHYmraE2VPmaAUB8F2Qyp6wIGC9YMbzKwgB
 75W12h97+9/l+6hX3ZHbpgCYkeV870k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-XbIEKNMpN_u3qF9JLMLMWQ-1; Tue, 24 Feb 2026 22:50:39 -0500
X-MC-Unique: XbIEKNMpN_u3qF9JLMLMWQ-1
X-Mimecast-MFC-AGG-ID: XbIEKNMpN_u3qF9JLMLMWQ_1771991439
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3561f5bd22eso5249345a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991438; x=1772596238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eq6qLXbyXLJc54ZDJbb9jP08uxtrOMIUIN9nTu5R5VE=;
 b=V7HDHnVwTTXC3YoNH/ZWv/MfBufDaQ/yoQikHQbmpJU27r4FGP1m3z12lkfayZl2nd
 IYvCk6KRtLr4IHPqZ0oosVpCmCtx7pxkMsfIpNuT2uYEDDR71YVuijLs04Fhj58yADC0
 86ZVJ9L9fPq2vdeNcvZzoT36aV7KNfyb9rGSWgtf2ZqWMg5roXPYQGo07k/9sSDljrpu
 v92/dSnAs8at8+S/YlGvZrHYFn7Sv6g5kL76m0f30SDVbduw9jPWCXJ3uY7/NXQQaMJ3
 JZTyFwKMmPdxfItrSwJn7P3kukbmqe65WhgGA4EUv5YVNPBOQ/VJH1a5OnDa+r4Yy4Je
 Uw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991438; x=1772596238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eq6qLXbyXLJc54ZDJbb9jP08uxtrOMIUIN9nTu5R5VE=;
 b=H9sXrpzBtjR3K0nW+5mB0feSSfr92/cxqR1lZCUX74xbCwBiB30AYsv5HZaE4P6Uvb
 aTBBoszVnbR8noyyUKWeIJjbAyGBXpJOV7O/SlwRdbXc3WzN/L3gN0Jdx1hvd2+MsDub
 l/Ee2kn7fbaVoFHui33aKP3xfjdsfcbGYbuGADJKA5exl3xb1RJA/seCYNGZUuqVZKxR
 EElFV+FJlhFMSQN66vT78a6/p6a55jtQPGLIGEzpogsa4o0T9fpXtIs+Mwj7Vo/rVtHX
 Uyn+Um0k4LH5MBDYmW89UZfipx7XbztLfaqbbNEi3tSY4td7lztw71BRbOGst8CjL2uc
 W4Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa9qb4oGNghEvet1ITHXzqKIHwuj0Gn5uAMjz6PRo+YvDBHtufhiokNfO+ehRgkRsSVnKXKqzrpRti@nongnu.org
X-Gm-Message-State: AOJu0YyclR5Xzh3NZZPORa9C9ybjfuX69iUiJxexQFj+625P5IF+kLrZ
 08hWYJ032cANNGKAvkDqLd3WEiD86nt/SJBMjp7E64bnn4r4ptuUVj4XRNELwLKbof2tyUzNhP7
 stLG7JRIvD+SV6F9ppqVEq6pir+OWAYRlB6aJoYXP/D3E3hDixEORZ5hejvOif1cu
X-Gm-Gg: ATEYQzyjV4+5Jgwn9ck2S8wAd5dyf3HB9H0pBfkgV+zCYYMIhlWXLDzuHdIcKR3MDFx
 +hLsG34PaM/1QfU4JoMmGVKcNeyF22gaWmPt8cd5KyfgmQqHKEJYBCQTVJgHz9grSJC0PFBttc/
 F8vr1lyr+sz3jqs+WM2hXbkMhqKbzn+1p3M4KVl/13rlvSMvuysg+tTqr+XRT8mljT7jmqFzVi3
 wi71VIllcHHTHBwg7wESvtSqDsT2XeLfguG50Pkn8GG3vcw3743CXjBU2hZ6FZxL7u1snFsSk8X
 9BGBONIEhI94Lv9/Qm95hbwMIw7JZPeWXJl5GRGwJyED3vjmMsp6qhSjgsBt/HvYs30/QFktoPO
 du/xC3ChbikOamsUq4SMwSYmjm/UpSjGAdu70i01GPcpYd7DAa1axbDQ=
X-Received: by 2002:a17:90b:1cc6:b0:341:8ad7:5f7a with SMTP id
 98e67ed59e1d1-358ae8b2e1fmr14340060a91.18.1771991438370; 
 Tue, 24 Feb 2026 19:50:38 -0800 (PST)
X-Received: by 2002:a17:90b:1cc6:b0:341:8ad7:5f7a with SMTP id
 98e67ed59e1d1-358ae8b2e1fmr14340034a91.18.1771991438033; 
 Tue, 24 Feb 2026 19:50:38 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:37 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 09/35] i386/kvm: unregister smram listeners prior to vm
 file descriptor change
Date: Wed, 25 Feb 2026 09:19:14 +0530
Message-ID: <20260225035000.385950-10-anisinha@redhat.com>
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

We will re-register smram listeners after the VM file descriptors has changed.
We need to unregister them first to make sure addresses and reference counters
work properly.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a4e18734b1..83657fe832 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -112,6 +112,11 @@ typedef struct {
 static void kvm_init_msrs(X86CPU *cpu);
 static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                           QEMUWRMSRHandler *wrmsr);
+static int unregister_smram_listener(NotifierWithReturn *notifier,
+                                     void *data, Error** errp);
+NotifierWithReturn kvm_vmfd_change_notifier = {
+    .notify = unregister_smram_listener,
+};
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -2885,6 +2890,17 @@ static void register_smram_listener(Notifier *n, void *unused)
     }
 }
 
+static int unregister_smram_listener(NotifierWithReturn *notifier,
+                                     void *data, Error** errp)
+{
+    if (!((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    memory_listener_unregister(&smram_listener.listener);
+    return 0;
+}
+
 /* It should only be called in cpu's hotplug callback */
 void kvm_smm_cpu_address_space_init(X86CPU *cpu)
 {
@@ -3538,6 +3554,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
+    kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
 
     return 0;
 }
-- 
2.42.0


