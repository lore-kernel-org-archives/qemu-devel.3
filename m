Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5411AD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvJ-0006aW-Nr; Mon, 02 Mar 2026 03:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyvA-0005qR-Jr
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyv6-00020p-PY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zptzdiIhn5oW9SnPOXdirIkkuvYnT1Lz9FHCyHx3ZYY=;
 b=cA+MYE+gL6kK7dupk6XxhyR45DUGqa3jTJyuOOOW2/sg7aAOIION4883r6ZKTfXZVMZyXL
 Os0OA4xZsGJD0PD62KEO1T+OlKuAZl3DraN7zhoT6RrrH8sJBH/UF4quQA5Olt9wTNpGrj
 nAMGxZT4yKpPUm7Gq8yzskK7R18qjwg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-Hph6q55BN3K4NQdL9Gkghw-1; Mon, 02 Mar 2026 03:46:25 -0500
X-MC-Unique: Hph6q55BN3K4NQdL9Gkghw-1
X-Mimecast-MFC-AGG-ID: Hph6q55BN3K4NQdL9Gkghw_1772441184
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483bcfdaf7dso39970825e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441183; x=1773045983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zptzdiIhn5oW9SnPOXdirIkkuvYnT1Lz9FHCyHx3ZYY=;
 b=KNulbXnwnbLgRIxsIIvMKDG4kGV2q18UPRMXUHe7cz/IDsWoITPtPxhz9/WxHJEnpD
 nkDw8O4lDh9RQa6HrgruQ0J6p15lrq89vaz9uV34DF6JdNPZppP2fi+SvSvsDt6NL2r5
 75YVKDqvy7Fazx87XGGDNoNZ1yJMdHX5t6b8/9QqeSgXNqvm5MZp2ULr6QbxrA6Ff98s
 MCnbPKpV2uXi3pcJt55+yutjWY5oCVqk6WxEnb5LueE8DqYjbDLwCtfSbvpyU5ue8UGL
 bzoqgrHHHZSYFGe8SOZJMTBJ4WxWSRKxCJoJ5m38yVd+pWtzwjnW6xBFS1D7HZaa7GVi
 tC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441183; x=1773045983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zptzdiIhn5oW9SnPOXdirIkkuvYnT1Lz9FHCyHx3ZYY=;
 b=Wr8B6CV63EmWaRJL63DuoX0Nwl+v4cRPQ13TjHcnlC6DvQ6GQ7VkE5lqMQs7mtnx62
 Zm0x9WkPO4ykXMgV6Z48io1Yg97CuQAZU9T22PU/yxplB/tPGIBrqTFBJdy2VBcoof5T
 Kzu/K/msUAWCFtS9YipixH6dy5X90U0ZanLnFY5VqKcpd8rV7sHqaZqAUMhHdLZW3vlv
 z3DTF7GHgLb8NwFaBCFsdTVMUbjWwgBzQ+Lxbme/LYMrUawD6fgqXU0YUS50KbUJMSsj
 Nqdk9Ebl0ChRTVt5KxD1sXVaB8+fwbL5nL9EWj/oNot2X17JWrAkOqP4p0Wxy/qCqigi
 /RNA==
X-Gm-Message-State: AOJu0YwzUEEYM8H5+Ud1R89dTfPitF4Pc8Gadrna/4Ts/dBQHB5seDt8
 Bhk02CeO7qJwyAifHunLgDmO2xuHtZyZRFdqDHFXDob79i1xh7TxGUZURDW5qcHE6gHyGFAr+tb
 Io4fo0QgR0dKFMVabK6l70j/1mLunA55Vr/niL5pJHoEg5c6WjbNVKc9k3srXWa9OzGXI5vi2Qu
 B3VsBVJgI6PXrClCIZtnG71ipC9SiNDd1r7SAb9LVX
X-Gm-Gg: ATEYQzxspumnJM9k7PeUgJRAzCyYcNcC+HU3xhfTBWnyybVatfhN7c92YM/Pjdd5oCp
 2pR/frBjGTieNqKkGZjaS09yYIEV/xCr7E8jEZK1uVEAJv8lppO5JKNSqujLMvVW8z/3BZlHyYw
 TQSQcgt2imkp+9KeUX2rGMw8kLNd2wyZfoUKaydGXuymYh346ivzbUH0Zdb0gW23gGpRNeogSut
 THd+UgaCAxFnw9UKEO70TkNzo0zzODK8/cVzQ5RIFemuX1xXGguJfomn7TyFTcgeeP+Q9/Sy7iO
 16twUA9FDs0oEXyePnhIxDfwSN9erFyFf9OiBY270/uxDnTF/sq8tH0XajWm0UcV3hOk5s1DVGy
 2/RYPIlUt33vBbdx7rbtWasfPbSA724nFYqZfBTSvMZuH2q+TRlNllKpJXIB++pbEUkjgntNTwM
 h8SE7Q5zzbxOMw94cgHUsMTfvCGM0=
X-Received: by 2002:a05:600c:190c:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-483c9ba7d51mr208098585e9.5.1772441182922; 
 Mon, 02 Mar 2026 00:46:22 -0800 (PST)
X-Received: by 2002:a05:600c:190c:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-483c9ba7d51mr208098205e9.5.1772441182378; 
 Mon, 02 Mar 2026 00:46:22 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm395134185e9.1.2026.03.02.00.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 061/102] i386/sev: add notifiers only once
Date: Mon,  2 Mar 2026 09:42:56 +0100
Message-ID: <20260302084338.473368-62-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

The various notifiers that are used needs to be installed only once not on
every initialization. This includes the vm state change notifier and others.
This change uses 'cgs->ready' flag to install the notifiers only one time,
the first time.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-21-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 260d8ef88bf..647f4bf63d5 100644
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
2.53.0


