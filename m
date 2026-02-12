Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F607EDF045
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9Z-0007jn-NT; Thu, 12 Feb 2026 01:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9N-0007bO-2d
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9L-0005EK-KY
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gaiZHj5SPB/rag/yYC6RdeZjL5+Ke47uV0afXoVShvg=;
 b=OVvsHA3BAmbJgjBmPSM9+a4U6kqdh/pDO3jXu7uWbDAxF07jvWRqgmoNuvYu4F0XC1eZ59
 ifla2RpsrQ8cpSlj5qDZQ6rCPoeCsmR26Vaq4jZNK0zofGF6caUWhxlKqH/nqgvVLvFDrL
 /zCaXgQ1X6P71lckZzD9tToQnRffj9o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-v7MLTPhYMsauQAnvAQS1kQ-1; Thu, 12 Feb 2026 01:26:01 -0500
X-MC-Unique: v7MLTPhYMsauQAnvAQS1kQ-1
X-Mimecast-MFC-AGG-ID: v7MLTPhYMsauQAnvAQS1kQ_1770877560
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35641c14663so4471201a91.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877560; x=1771482360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gaiZHj5SPB/rag/yYC6RdeZjL5+Ke47uV0afXoVShvg=;
 b=BuGZEbPIPwiN3sVKlh8crCIhv94c9F5Yx1d2cjLfGOaiZ93mlmLytthh55Cprnz1v3
 zwbqBOYnBR7RyTLNqja8bFbr6e1s4ttyqkgbiCqCNhP8Gd9OV/Db2H4S4bd6eeRxw4r6
 sJx6W/1KWaRXh1x/vq6QrquChbsY/wswTQB+8IhEV5uH/3yfkp4S2zevMfxQ5DeNQyT/
 pzsiadfL1+SJbzU6h79pjPRfAmSl7m95ygsHeev4mixmzLpC+34yWUDCiNen/20C4Udp
 vgMIu/IA8qdkLLXOEH3S2Q91WNhfKxnL3H+u07GT8jYoSqJReFoY77DM1ghi6WfbLxhd
 dz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877560; x=1771482360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gaiZHj5SPB/rag/yYC6RdeZjL5+Ke47uV0afXoVShvg=;
 b=j0zPV94jGO6B0p/hPK7CZnnshmhq+344pDlrlTWVhMB9QM78XjDW5EJRQKqeU2zKQF
 gY/fUBWHScZZYIVslF8ZWZJaCi7rfGl9I8wnO5ofZRVYHbVDJNpp+/sx2S1GSDDWXKXz
 WjgmmK9VceLch3MSQJVApOV0/DHh9tXHG47sQEfSVWdaUGERwpPY8Ex+tMSpvN5u+MFY
 e0K5mEvE94GhEi7KflOFdEVEhaPBAsgmn3f/k89V+VFIBuLawCa0tfqEwmf4xCDKd/QR
 7Fw6+Im7miNh1L3dhfI4l6GMWMoYGAHWz3d45wdDLzicTWUI3hbifyETQelVOatW0I3u
 Jahw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3kbtju14JDk1LlANDDUOkqH0UCT8Ya5iL2IMyfccopiLf4lGlH+pyvzz5ih8VKU6di12VvVS8zfEW@nongnu.org
X-Gm-Message-State: AOJu0YxU2yBGAo+JrC7PFGgY1OlHDKtBucqEGPSTuHbETSqcIU+lrVHb
 Qo92D+UWQj6Wu2B0XILvSglbykMD5Ep13o0PkurhSecHk+0XZ9jwXOOax/+VgVYk3p/YUFv5yJY
 CzfpmD/TlhBgigZc3CEOVV1VnBgnBKNZJxB7EIRQlCYd32d0cZuSfDMsL
X-Gm-Gg: AZuq6aI46F9zO7lN0Ci9cwfXRsIWhVpWYrsWGbLm7atDXbeXqTqceai549STLoTc5Xl
 pOUHLB43l0jex3BUQSKUhYFhdyHH+Nn6xWUa9bfj75ilq15caA6iNbai+KhywVnbk6RAmQx4ceB
 K9kUwKiP5sekOZMi9VjaYOPTun8uCpttwdr4Yca8OI9PJPbbnCM+lgXAnYHTReXkXxPG4RSO5Tw
 MTR5bsUHS6eeILYSBIHxdeeG6BK24mLCl0AJwn00D9u5KLKNZxji6Cz3FOFBVemEQqz0UscV9db
 ZsO1nGwRRC0VzAiOP1Il0hNPGijgryq97SRKbrMclnPO+FfTTLd23y8ykquzLelKIwSQalSB8c+
 RGhp3vov5rhvzyYCtdEyG+STs8nSzM4q43C6gDj/lKAG5GVfCwNQl79w=
X-Received: by 2002:a17:90b:3912:b0:353:356c:6821 with SMTP id
 98e67ed59e1d1-3568f2b7610mr1774883a91.8.1770877560308; 
 Wed, 11 Feb 2026 22:26:00 -0800 (PST)
X-Received: by 2002:a17:90b:3912:b0:353:356c:6821 with SMTP id
 98e67ed59e1d1-3568f2b7610mr1774860a91.8.1770877559964; 
 Wed, 11 Feb 2026 22:25:59 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:25:59 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 08/31] i386/kvm: unregister smram listeners prior to vm
 file descriptor change
Date: Thu, 12 Feb 2026 11:54:52 +0530
Message-ID: <20260212062522.99565-9-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

We will re-register smram listeners after the VM file descriptors has changed.
We need to unregister them first to make sure addresses and reference counters
work properly.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 83c15f098e..5d9b79529f 100644
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
@@ -2748,6 +2753,17 @@ static void register_smram_listener(Notifier *n, void *unused)
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
@@ -3400,6 +3416,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
+
     return 0;
 }
 
-- 
2.42.0


