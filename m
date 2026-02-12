Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD99EDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQAA-0008JS-Ag; Thu, 12 Feb 2026 01:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9t-00088D-Mo
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9q-0005Hg-RJ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2v6djobNSdTdF+YCpvzDQ17kkQi5jILZoPxzgDYLR8=;
 b=N91RSOogkor8hu4JuMLwNZd8DlGmGkooV474rc8tsq0fIADtW7tkplXofivGA1M2CkpyWT
 vuTTVZ02JHIgY/W8l0ydUcrtNeMKmOVxxJWS3oFjRLUwk7MIuR6W47NxbW7U9bQPuACLKd
 yvwQUce9cKFYIslXQY62gYQE8q20ftc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-rl7rtaKFN32K6QnAzU6ddg-1; Thu, 12 Feb 2026 01:26:32 -0500
X-MC-Unique: rl7rtaKFN32K6QnAzU6ddg-1
X-Mimecast-MFC-AGG-ID: rl7rtaKFN32K6QnAzU6ddg_1770877592
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3545cc84ab1so19431821a91.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877592; x=1771482392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2v6djobNSdTdF+YCpvzDQ17kkQi5jILZoPxzgDYLR8=;
 b=JBU0BMyzeegtxubNxyf5TWdESxO8A7/tQKZuWqCZJZmqUsnA34VpLrwvRxm2QJaSn9
 r+7bvjrZFjeCfs2JJoU6BZrwtFuPf4+1lAld8dIjr25lc49CDVIjyxiMVE2QSKbkDhva
 iz3b6tTLVx5ICRQqCCNOh+O/XdDTZzEdYTZxGXDtoA4i6NZPCe3cX04ISkgYfSPGwmXh
 Pma0fjt7tJt1La2gD7j/dHJO1OE6y7D+La+/XOc/fRd92+VW1L7ls51yvAwTLkmkYxv2
 zYkPLkN9wtrAq9YSsc4MerDpua9WmWqgTFhcNK8078iwfG01xIAWiHLGTRMhBtP7wXyP
 JR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877592; x=1771482392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N2v6djobNSdTdF+YCpvzDQ17kkQi5jILZoPxzgDYLR8=;
 b=Puyt9NFIbww/OvzdoPyLa7DRZia9zj0vW09iyireN2eA/pAOvUq1djn27VJSOJ79sT
 UCJ/bBRcQ6PQr7tjuwqoDZTvU1eqUhn6/F/fEQFc6K/AIfqpltlSunYhIc2DL/+VDXk0
 qtx5F2AeU5eRN8+uy/uDL9ydZECOj/ow1Zjk6hQbJtLjSHaa8eNnMX/Ylx9MZqAFJbUu
 9WXFZt+f7wrunN5KcunpbilvNPASqVD2bQ5kt4DZxKBS/UftOTnoHCXeyc8JqcRNbQgw
 OIc5hPwpZUSpf35kkkGvAgkx5CflgAQvcMjfGox+KEMLN7JdWAQJSodmnsSwFBAks2Yy
 HL5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEgb54NbT75TLwQZ01RwNP/dmWd+y5BUO46hGnUeTwfhJStVrjbD3nXRn/cKeBLR1aj+AwV1SMznH6@nongnu.org
X-Gm-Message-State: AOJu0YyVUaprweKjIVM3T5ODgAF6DuM/LfGpGKjNGMo12OkHwPp1MovN
 44UaoT6Y/gb2NbNWc7duWHiib/2uY4nh0z0DuuW7yliwlkJ+3rSoS8+O9VFq80V1mTKkihx6b3I
 RmfOuWnwZZWA+xf2EHQS4rTBYAQKSOMnQASbpjpNIfLALDc3dKWS/0nQG
X-Gm-Gg: AZuq6aLJwJgQ4vI2aaBr8m8NtijBZbNVoh4/3ASotLWNYjBnuj9Z5hXmVQgTILx6EHF
 G0zkliNNEHD3YcSQnnsU9sJ6if8CtCqVbC3n5yeOz8DlzsPmiZ0PH4hWVR7xXJ9foJ1NxnN3w7N
 m0tdNIxUGS/2DNA/72wM0lBWn8qDS9jvEo3Gjtr99jWRQvUZsp4ZS+u4bsLESjwv88ER94HmJ1E
 bHTi2sBTVCTfXkcsIWQvA82Av/28GcxlsgvfhH0xcvDh9snlP0UfIjV8SRGFLY1TFlrae8JP1jk
 GYqcVvhzbs789CCK7L5lNaTPk3Jc6VR/pyj2gBD+OtnGKJES1hufKw+YCvLdV/ZP+xZnMIpujp/
 JOWUNMY4ZLfyMx0PAHTQhyZpFM/ClZAWloRIokaEr1C/w22Z4mhDaMS8=
X-Received: by 2002:a17:90b:350c:b0:353:883:affc with SMTP id
 98e67ed59e1d1-3568f3e4ccdmr1651316a91.18.1770877591667; 
 Wed, 11 Feb 2026 22:26:31 -0800 (PST)
X-Received: by 2002:a17:90b:350c:b0:353:883:affc with SMTP id
 98e67ed59e1d1-3568f3e4ccdmr1651305a91.18.1770877591360; 
 Wed, 11 Feb 2026 22:26:31 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:31 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 18/31] i386/sev: add notifiers only once
Date: Thu, 12 Feb 2026 11:55:02 +0530
Message-ID: <20260212062522.99565-19-anisinha@redhat.com>
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


