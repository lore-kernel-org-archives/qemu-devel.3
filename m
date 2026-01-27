Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7633CD25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbRz-0006tB-Lv; Tue, 27 Jan 2026 00:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRu-0006oX-00
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRs-0008Mj-K3
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oG/eU7ht67ZLCzu+4byuSdKHIRYwTxnvqkeHA3qrxYc=;
 b=Uq1L5yTGfppU/WaGUh4fEQ6E+KlYe25MR529GU/bimcJlSMybbohbYsCDt0q5dYWmuxwEd
 BhiwQ2us7CEIT2uYw82sAIHRlGKmCuKBr+/qLjuxR/ysdj1mbNvrdspy6qZIKScCV8HXta
 FlsB6TanJE7e8AtmfFXN0KEK+9IByqI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-uh4tCgzfN22JbrvQvOApLw-1; Tue, 27 Jan 2026 00:17:05 -0500
X-MC-Unique: uh4tCgzfN22JbrvQvOApLw-1
X-Mimecast-MFC-AGG-ID: uh4tCgzfN22JbrvQvOApLw_1769491024
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a871c32cdbso1413575ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491024; x=1770095824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oG/eU7ht67ZLCzu+4byuSdKHIRYwTxnvqkeHA3qrxYc=;
 b=SrhJqTsNVpWRNQ99oWcMP1hwVSG4TAH10I0c+hyO0OrMhVW6A7dcs8X11HQ8QSbfLt
 6zCNDP+Z4jcgCxuUySTRJ26AiOuX28t/QdMjHZoyAKMg0yEojnBjfm9kjMMAwGV5BDU5
 na/ZpEqt9CvCybIINJqGhsh4/7uyzoUIBDsqIk/SmoFOste4+IZak5SnwgOS2Lpq2VhB
 KH06wSzgKwNzEpY1uF7BOrlGPBeyFOhqNCla0dGPqFHmdjcZJ63DJOf4aZr8QNJKueU/
 I42GVpDLQ41A6V4cwlAEqSdCWxxn8vGw7jHPiE3ZR8IxnU2hb0KVFh7oeNR1NICFOikr
 1E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491024; x=1770095824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oG/eU7ht67ZLCzu+4byuSdKHIRYwTxnvqkeHA3qrxYc=;
 b=gchiSLr8NbuvYEeH1zCKHzu+oAembQItPRT0wFV818U0dogRSI+9rjGuR/h6cXYJ1L
 iHBKht7gYtaf9WkJkbLUguScZwKecohoTIgA5SIHyMcOpiXTUN1Ngj7RIenb7URU5xNz
 JnR02T8N3lgvFF/D9sSYHz/2GsZEXtQxU6TDg3PMC9bLkNvMYOGoE9AWW0aJ56xfaTw9
 6RMdPzl/kcQRvvbJTxzcVMVerA+mY3NV/q0AcKA0psx9fTopTd62h+MQRslKF+0UfUM/
 wtS6i0AaUenIJujnZVP5YWr2ZOI8PFumnxZPxczOR5Qpj61i0FJWAWGF6rK/CmDc85v5
 fNCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeSkmitkHua2xrp0VUmiXwWwQRxjDprWCzJLiePAjf95CFuI4YoWgw9TlogZ/6LNEG/nUHGTvPwK4V@nongnu.org
X-Gm-Message-State: AOJu0YxZY80doPaW5dBA3Ew+ftQ1aFshC/I85wOb6rV/rBXPl3xY4Xl+
 r4snUpL5Z2/bxbzR+hTFLQt2swQbeLtFJSZZqJVCQ2jllJmY+z5RkR/uCTs7wvT8pCGYUR6SleO
 zZrGndWAgWjer7xS9AxiLN/S/48vOz6Bjn/akad7LWcSG6ZMGwWKCaByNAVlsbli6
X-Gm-Gg: AZuq6aKenGj3H9EN7z8RF6W16ckuuUeV5FDPbhEe+8x2mph0krCksdz442ovKGBGNdN
 3fE67ZAYkPyvTPaXAG5JiWkQPoHWaNuEi2mIMQ88YuB4it0NuXRdln36kkf+hQtsFffBwBL1iMV
 QdbHnm55bNbjP/67HGrsdfB1nSFec3Kod/mXL6VuQqiwhl51FKly02Ae/7aeocOqyBYx4wgqreS
 jt8iU2s1a0WwS8kY2uIxmo5YO6pY11fNIQkXrHSgfJAUmA6mPADtqFdALGhMylkBIu/5mg6tmPu
 xI6bxMilmmZ174Fui06iJHOSWCBrjMB7073RDEZLI+cKAYOKy5+xjIjFBSSprVVdK2IaAzIpenp
 ioxGvWgOvYd/4qfnyFqTnNdGwesJiptlu6t0zvRT0UA==
X-Received: by 2002:a17:903:1249:b0:295:5da6:6011 with SMTP id
 d9443c01a7336-2a870d458cdmr5977545ad.11.1769491023744; 
 Mon, 26 Jan 2026 21:17:03 -0800 (PST)
X-Received: by 2002:a17:903:1249:b0:295:5da6:6011 with SMTP id
 d9443c01a7336-2a870d458cdmr5977435ad.11.1769491023393; 
 Mon, 26 Jan 2026 21:17:03 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:03 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 09/33] i386/kvm: unregister smram listeners prior to vm
 file descriptor change
Date: Tue, 27 Jan 2026 10:45:37 +0530
Message-ID: <20260127051612.219475-10-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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
index 346e1ef6f7..e28ab18a14 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -113,6 +113,11 @@ typedef struct {
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
@@ -2749,6 +2754,17 @@ static void register_smram_listener(Notifier *n, void *unused)
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
@@ -3401,6 +3417,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
+
     return 0;
 }
 
-- 
2.42.0


