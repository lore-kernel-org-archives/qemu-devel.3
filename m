Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC50BD25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSU-0007JG-Ib; Tue, 27 Jan 2026 00:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSM-0007CG-W3
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSK-0008VF-KE
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IsqW2ttd3J7072Zyk2vnpxdf7DB+tWB3Z4Y7tUzOjnk=;
 b=dp/nYSdTZYlgV+GZ+dTmeQ+tlHf3iknMzfCq4zonaVbcOJpN6C/gBO+d7FNxZOkh+4CMb9
 t6QvfWjQaSfSOmHAs5O1ntFE96XCcUSoepgxdov/iATGDvPUR9GbiJUgiD3+CvqNZchmpi
 2CeQHSrbFKUAe34v9FXV65S6U6kNhWE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-BA3W4YsLM8m0fGuLTLzscw-1; Tue, 27 Jan 2026 00:17:33 -0500
X-MC-Unique: BA3W4YsLM8m0fGuLTLzscw-1
X-Mimecast-MFC-AGG-ID: BA3W4YsLM8m0fGuLTLzscw_1769491052
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34c213419f5so3549608a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491052; x=1770095852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsqW2ttd3J7072Zyk2vnpxdf7DB+tWB3Z4Y7tUzOjnk=;
 b=iLKKviREmjNL9u+wB9YyWmaJyooTNPHYOMGzp228AGQvYehUMqLP1SlAQkauzf+WH+
 W4gYZo/zRa2uK2s55Am4My74saufJxEvzd86+V103bu6+o5XeE4yaFIycfYKK12yE6mn
 /aVLMJyUNxvYwJGC7jpo28a9Trwfcl7UDVCKw7yuPQDjYlh87/x4eNE+YmPkg9jAXNbn
 U3hlzVtXXX1LGS3VTl2psLVXI96TL1YXfUnLSWkTRak7fxQ4ZkKtY/ikVelaExByFcph
 rFlo6Xgke9XqqWtdOxawPhQ6BioMxCIpdgDWk+joOXY60fTFqk2viSkJqZhs9VITYi9u
 Wk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491052; x=1770095852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IsqW2ttd3J7072Zyk2vnpxdf7DB+tWB3Z4Y7tUzOjnk=;
 b=eU4L/JsTH2ZESlE83sjGL+Qg7ubWq3EXuzflAf36UvLmKYTuuRioJgDKwoHDqdfJ7i
 mmcdN+haP+UMTnY57ih0dXg1KUskmlOsOXCceMEyh1dMRr6iRlYQ3cWJEQ28J5QuLJuX
 gVxBUjwMW4O5UznkNC/+9tMujI2G6y3gvbSdWkupu3Hv+5LVkEJF2i+g34vJ8WIRrctr
 zUcsxyoCLTB7lA8gV4B+NEfyyEuUtpNhw/w51CDRwrBIqYpnn8J7eN22l1bcFhiEo2XI
 yTBBKX00KvbbMWrvKoJQ8MU0c/vHc/kUzckGXiV7srpo3/WBk0e/099c93i73jYlox0n
 +GEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnV9PcTb1FNDsUGEsneFJ3i14kHp/gOzW+MmZ3hxAZCfyo9jM586Gk3w9EALwG2OdINbfwGtxWp5ak@nongnu.org
X-Gm-Message-State: AOJu0YxnlAszAoRnrg0wHX7m78wmG5iYMI+rtKelgnSvZnW5ClV8O9lo
 QSXs7G3xBEzFuW3cYZnOpSh/IRGq9MWdX6bY2RDFib7+bd3HS+4gudDZQcWMI8ogwySiO8BTegT
 wrgcfpVdrt95oHpW4k4WC7R/LIbUZqJfiIDHDBSZAMPw/4rOx9bYdkSY6
X-Gm-Gg: AZuq6aKEI7TWp59lll341kz3EI4v88weQy7dCfulblffrUGbakPWxTW7dwlUPkBUEb6
 5O5YUwL6iYm3YvGrMAyi9LTeP3rDN1poRMkRVF8/eIizYYay9HhEcjAo8Ol1RvworNTC3Og/QAO
 XHTC+HR/yyA+3DzdILkdOA8d8t9qBiPzERXQKGfaIw7IaC69zFf24WEFuvcmUAvj+kqlNuPhvQy
 CFhzWOAaSgMwZAQVCdK/2GNiMXdgjBMikY/CEsq/J+7A3ztFqersDTqD838KgPjkCOu3cP8v0n6
 QqqgXpOfDsQDlsCeNVhEziP/I48nlRKjm6sFmurZeY7pqQK/WmG034UiDYm4x4K7FBxYfkwPknL
 F4rY38Ty3UoiUm7I5TfAQOGm7n4qnUa0wxyvSxOG4SA==
X-Received: by 2002:a17:90b:57d0:b0:321:9366:5865 with SMTP id
 98e67ed59e1d1-353feda367cmr685549a91.33.1769491052474; 
 Mon, 26 Jan 2026 21:17:32 -0800 (PST)
X-Received: by 2002:a17:90b:57d0:b0:321:9366:5865 with SMTP id
 98e67ed59e1d1-353feda367cmr685537a91.33.1769491052087; 
 Mon, 26 Jan 2026 21:17:32 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:31 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 19/33] i386/sev: add notifiers only once
Date: Tue, 27 Jan 2026 10:45:47 +0530
Message-ID: <20260127051612.219475-20-anisinha@redhat.com>
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

The various notifiers that are used needs to be installed only once not on
every initialization. This includes the vm state change notifier and others.
This change uses 'cgs->ready' flag to install the notifiers only one time,
the first time.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 5524e7142d..a65a924fb3 100644
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


