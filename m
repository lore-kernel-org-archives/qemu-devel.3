Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9CCF55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vn-0000tC-S4; Tue, 24 Feb 2026 22:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vl-0000iU-Kf
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vj-0008Ab-Qd
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2v6djobNSdTdF+YCpvzDQ17kkQi5jILZoPxzgDYLR8=;
 b=CC59T1L5KncXP9Chj8bwDPmR4hwA2HMZtL1UdSCQK9w178TjHoVT/SdXuzmT7jN7y3A+YB
 qA6c9+9G8YN4puUrfxxcPKlxWNSPyFHVxQThW7/3ln1/8FqSZ/gA3OdZkHpFKojjloG2Jg
 I4fss1GMEz+gCDWWD5z/x510PoXxct0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-fFKpwEG_NQqUZCQ8dWHGcg-1; Tue, 24 Feb 2026 22:51:17 -0500
X-MC-Unique: fFKpwEG_NQqUZCQ8dWHGcg-1
X-Mimecast-MFC-AGG-ID: fFKpwEG_NQqUZCQ8dWHGcg_1771991476
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3562692068aso363770a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991476; x=1772596276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2v6djobNSdTdF+YCpvzDQ17kkQi5jILZoPxzgDYLR8=;
 b=igRWTpXvp0SrU9ocUSkvEauqYEDOsSeBB9otdPRZHghzeWU2NLBl192Spzohtj7Zyl
 XLCfuG8EtPjyYpekTe6iXSLrSXhUMjEGSOTkJjtkY5vQf1L/HxkJrN2gIXZ3W0GB1t9T
 F75Am7e85aaz6bhDrMxlX1WIwIaUlCjYcM5JkTfku8axWH2QXr1fQTs8rYulPJoM6G+F
 wg1fdfRyCTqGKC6+/HP+XGkRABZV8pt+Rxr/VOSJ28LnPDu8LPSQ1ZaQ9IEP0duG3zkj
 zk4jCGrIFgttMQQDV6fo5PdLMj8jp28Mae2i0Yz2V6P4wV0U3REg8zsiIpPhk8Y3eu8F
 uDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991476; x=1772596276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N2v6djobNSdTdF+YCpvzDQ17kkQi5jILZoPxzgDYLR8=;
 b=Tlq2sn20HdB98BjkoFpQvQUwqLrwk62mjew13YQpbeq2Wi6ba6cjCFbgD6v+4JutmY
 RA7tkpdNKRHVxj7Ygo/lZRdIouTkZbYRqT3zzAzb1ktxMVxc1NeISeSi2/eFCl9nHkbr
 YgvfF80uhP64nkOKyFjXrklnD0PychfLsH4S19sqGYneOdZU+H6O1Mmu9LjdTuHKWyOX
 K0SUMx5Vx4XLuN6zRABvEWOQFV2zppyYkdPMNKR5iGumae5PcSYm7D7Zq5tK7lRKmXAO
 7RhzPvj73eadJSO2B5KeC3sun1rc2v1WBSpcc/zwUz8asTaJBf56By6yVr/+9+yKJHCG
 egOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3BMAFzmP+1FsVVVc/3xM/3X90caezQ8ECzkclXCWWIwqdbJ4FRWnDHqlcqE2JYkXwCc8KkfHI80NQ@nongnu.org
X-Gm-Message-State: AOJu0YypdcMleeP/lyB/k4JNd8pl//IvcVmJJpVAF9tm/tPhYOo1x4op
 3DtkoEYI+Na/ksnqAWanF9GInWgIOibMXFIcdJTbqSMHh+blG5whnwPBLevDv2rykcftLvPnzdV
 PrZtR6sgdB6zbJB0DSsCVdWJJRRIwbRJ0uYmdgt8eM4I/TypzT6gGX8uY
X-Gm-Gg: ATEYQzxQ2U1Kf7eDk86GK87ccnic3GkSvM8KpIgG8nELBCoQBU6QwJ72vcij7qj32ha
 fzSd9wcOSSMu6IIdHqTICKlL4XUUBVGs+oa7u0yJfdQG92wBZGOI77FDdWy4NO+Kz5Bf6+ZcaZk
 C/laBXcMSrkKRM7fnETla0b58nTL2lWxl+gvdpCBsHMYW/WglwvEgOWSo3PedrLcLp/v4QBElj3
 q1GvudcXJhFo88zvptUD2kEbQ0KzVc4Sjk1iFOJdy43VkdVHEQperX0FC32A8fonCP3yCAnrmoy
 4PW35jRwJ2j3x2B50bihuSVsPew++I4AHQHX/oCMS9nHwpU3XH9btz5UaM8OMxGZDD6kxASyTft
 zN5EARl3Dwa2vHebfQBWDeZ2vg0o2a+a5HnEe143LwBmut5/POVrivtM=
X-Received: by 2002:a17:90b:2547:b0:34a:be93:72ee with SMTP id
 98e67ed59e1d1-35903824bd2mr1989219a91.8.1771991475898; 
 Tue, 24 Feb 2026 19:51:15 -0800 (PST)
X-Received: by 2002:a17:90b:2547:b0:34a:be93:72ee with SMTP id
 98e67ed59e1d1-35903824bd2mr1989193a91.8.1771991475466; 
 Tue, 24 Feb 2026 19:51:15 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:15 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 20/35] i386/sev: add notifiers only once
Date: Wed, 25 Feb 2026 09:19:25 +0530
Message-ID: <20260225035000.385950-21-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The various notifiers that are used needs to be installed only once not on
every initialization. This includes the vm state change notifier and others.
This change uses 'cgs->ready' flag to install the notifiers only one time,
the first time.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 260d8ef88b..647f4bf63d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1920,8 +1920,9 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
-    qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
-
+    if (!cgs->ready) {
+        qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
+    }
     cgs->ready = true;
 
     return 0;
@@ -1943,22 +1944,23 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
-    /*
-     * SEV uses these notifiers to register/pin pages prior to guest use,
-     * but SNP relies on guest_memfd for private pages, which has its
-     * own internal mechanisms for registering/pinning private memory.
-     */
-    ram_block_notifier_add(&sev_ram_notifier);
-
-    /*
-     * The machine done notify event is used for SEV guests to get the
-     * measurement of the encrypted images. When SEV-SNP is enabled, the
-     * measurement is part of the guest attestation process where it can
-     * be collected without any reliance on the VMM. So skip registering
-     * the notifier for SNP in favor of using guest attestation instead.
-     */
-    qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
+    if (!cgs->ready) {
+        /*
+         * SEV uses these notifiers to register/pin pages prior to guest use,
+         * but SNP relies on guest_memfd for private pages, which has its
+         * own internal mechanisms for registering/pinning private memory.
+         */
+        ram_block_notifier_add(&sev_ram_notifier);
 
+        /*
+         * The machine done notify event is used for SEV guests to get the
+         * measurement of the encrypted images. When SEV-SNP is enabled, the
+         * measurement is part of the guest attestation process where it can
+         * be collected without any reliance on the VMM. So skip registering
+         * the notifier for SNP in favor of using guest attestation instead.
+         */
+        qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
+    }
     return 0;
 }
 
-- 
2.42.0


