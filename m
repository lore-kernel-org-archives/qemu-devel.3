Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B5FC9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuH-0003Uk-RT; Mon, 12 Jan 2026 08:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHti-0002rQ-Md
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtg-0003jo-GW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IcSPzaL3tdDhSxoArxuWvrysyc9k+MnXqGfZnJng8Z4=;
 b=YQ1DPGKhwFFV8kl9uPVKu8sl8HDseFggh7ypLoFXEpFjIX8gIR5AGSdQ2rgCMgPzMLDKWJ
 fYkNVF8+lLcPnW938VabAXXVYuW2EZORzYYPhdqeVGRFsWV2fCR26q0q4jfBZVbpgalEYN
 WW9WYMTMllvP9F7qS91iJmmlgww19yM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-B-fsx9AFOA6AZTF9GU-7sQ-1; Mon, 12 Jan 2026 08:23:49 -0500
X-MC-Unique: B-fsx9AFOA6AZTF9GU-7sQ-1
X-Mimecast-MFC-AGG-ID: B-fsx9AFOA6AZTF9GU-7sQ_1768224228
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c1290abb178so4687422a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224228; x=1768829028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcSPzaL3tdDhSxoArxuWvrysyc9k+MnXqGfZnJng8Z4=;
 b=NIJIBzya6wm7HCBtgoPDriDfaPvjUZiqfEiIEkQKWzS+fw9ALLp3H5dxsxgfpJ/RSr
 GWDjKa/ykTCf7TJ5uA9KCTLcdCIETCnIu3ciHqc7ZZ+HR9ZyqYY8MQRf7pYFMoUVxFfh
 MPXSmHHVFhIOVMi/3RKXDRLN5dwg6Z0Qi+fw682eGsODOvixlS58w34gEUtMIc2KVLKh
 cr4iC5k9NuOLKkkeGtHsCAaRSvrFGUFPqVLU9iP55XH5GSREVIguzI5hNaw9Vn4svcWB
 kSDrkyVrdph00FAAgpNsUbVqr6JflOYNl4hOtXz9/vx5FTXI337nm6znXbBeYp4JFsD0
 NwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224228; x=1768829028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IcSPzaL3tdDhSxoArxuWvrysyc9k+MnXqGfZnJng8Z4=;
 b=Qlv1Q4zI0rb4rbVIBqY+jdVQ/jgLTZ4KhgkQryl7AOIGBMT0Wk9PqcjOV/EdolKmZu
 I0ufmtnLN/H+yJ90kQvEaEVHqdmnvyjzeQlNRrfLKVEcO1sRbxX1EPGiS9y7J4oG4Rh4
 r5Ucjwj0YgNbRuFCfzL+oBnnTS5sCZMapKSjzxA3/MMq81k/W0pf33iU8p1Y+PlzgpX0
 FJHr2ENW0gTKhevCF+fCWC49zHOlRkM6W/Ccb2FnKiDwyBYbw2FDtSG0lbE2Y/x9eLrM
 hzf4+hlwypEgcx/IUvj1R8gtn/oT15TohhnG9gqv/HrbE9BzcLbfQH5enu6I/flq1Df7
 8SlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbntYquIeR4fepRWPQwVrLd3iiXh6twGBPdkCRm57rSZ9qJbCLTkmJak08BoxjmRqpmjLuNqgukFzb@nongnu.org
X-Gm-Message-State: AOJu0YzwgKAmY17uhMH2zFkzi16i60xY2B3/lGuUC6a7mgvxC9Svf14O
 K5VEeE7crAmlZIML9k4z1JXESeSncRkBFHaYh3I1blyJoz1z/SxbBPehCkhpZaWUCEzXJxvZtlw
 PnTzrv5uSZsN9zIAogk/wo8ntwFFVCylvbKBcKpgrYaxcwf+sORoQPOPo
X-Gm-Gg: AY/fxX7uOX/3huz1vNut2Jwo7+tGckTacLHuMUGws1EKDCwm+ApJ6UXgJy/JL+4BaNz
 akUZvYG3rGLXpXOtAloHoxElXDgxMA2H7418vC9QZQSid5hVW5gjMKEaBtBEsRRLjOWtt0V8XQo
 tvGxGrKrSr6tugCGXTFLNu84J+V1+ttI6Ly5yOCFzc5SCnWdUAbJhj/o0uDIksZwphBGH+whp4n
 Od01iFa51/kzq/zvCKg9j/Lq4A4ERcmsGu+WMIbWugDoCeUz8nyJ8HlRGMuo2JmBoHMWyNcns1h
 aqvdOqHt2erVvwaQuHY3kzj/m6So2MgCu5hAScckKDy+/jBM5WNPvbq7RwrSls8iXx8a7cz6FYO
 iP+qJ415a0fMVDai8Ak9XLvfQkUv/XL6bG56wGuB0PXU=
X-Received: by 2002:a05:6a20:7f9a:b0:35d:b5a1:a61d with SMTP id
 adf61e73a8af0-3898f91b4c0mr17844578637.26.1768224228101; 
 Mon, 12 Jan 2026 05:23:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLoLDLLXWJii1UGy/1Y4n9jx/3GMA07Q3THZ5tL3NC3wN6HPLqvOEWGOm5zr8R6DDH6syVkg==
X-Received: by 2002:a05:6a20:7f9a:b0:35d:b5a1:a61d with SMTP id
 adf61e73a8af0-3898f91b4c0mr17844560637.26.1768224227677; 
 Mon, 12 Jan 2026 05:23:47 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:47 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 08/32] i386/kvm: unregister smram listeners prior to vm
 file descriptor change
Date: Mon, 12 Jan 2026 18:52:21 +0530
Message-ID: <20260112132259.76855-9-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 target/i386/kvm/kvm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6aa17cecba..89f9e11d3a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -113,6 +113,11 @@ typedef struct {
 static void kvm_init_msrs(X86CPU *cpu);
 static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                           QEMUWRMSRHandler *wrmsr);
+static int unregister_smram_listener(NotifierWithReturn *notifier,
+                                     void *data, Error** errp);
+NotifierWithReturn kvm_vmfd_pre_change_notifier = {
+    .notify = unregister_smram_listener,
+};
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -2749,6 +2754,13 @@ static void register_smram_listener(Notifier *n, void *unused)
     }
 }
 
+static int unregister_smram_listener(NotifierWithReturn *notifier,
+                                     void *data, Error** errp)
+{
+    memory_listener_unregister(&smram_listener.listener);
+    return 0;
+}
+
 /* It should only be called in cpu's hotplug callback */
 void kvm_smm_cpu_address_space_init(X86CPU *cpu)
 {
@@ -3401,6 +3413,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    kvm_vmfd_add_pre_change_notifier(&kvm_vmfd_pre_change_notifier);
+
     return 0;
 }
 
-- 
2.42.0


