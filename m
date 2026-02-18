Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17220E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfyd-0004Cs-Rc; Wed, 18 Feb 2026 06:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfy8-0003Uw-WF
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfy7-0007uZ-Io
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2v6djobNSdTdF+YCpvzDQ17kkQi5jILZoPxzgDYLR8=;
 b=HDtt0HIDHXefXcLNZg8r2hqk9kYp+pNpBnpCJqlvd7NH59gDdIloRFRWt9fSpnLVc//VyO
 Fi3GOTkQMP3oTk2fKYnrFvBQPq+K2lb6Z2n/Qwk8kYPIS7JI8XcWRAmoud5N9OGlkMDAQW
 m4KH/2TAQrgobIdJD1ehB+LVoLdyZrw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-W5PzG3PiMp-FLCJqcujqmQ-1; Wed, 18 Feb 2026 06:43:45 -0500
X-MC-Unique: W5PzG3PiMp-FLCJqcujqmQ-1
X-Mimecast-MFC-AGG-ID: W5PzG3PiMp-FLCJqcujqmQ_1771415025
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a944e6336eso304902475ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415024; x=1772019824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2v6djobNSdTdF+YCpvzDQ17kkQi5jILZoPxzgDYLR8=;
 b=EibTa4uF4YeWfoxl3kg8hQqvMkR6gDvJygsBBmRRC41XVuGIAm08crIJFj7pOOUz+Q
 gyPC6FPc+PDSrf1Ab7AG2yqK4D+iiOaRR0aViJoXv8JXVi6UkCtoT4wPCKp7KuqeqhDt
 ZZKDruaJufWh2B40oNx7nJz4dAEiI7rVSKjuhJ3bLqLNY0Od+CECnTQoq76aEpSM4l03
 AIDHzgTscgUiuMQ5RjiBw26YvSchT2rB9fcxv/+3P4AhFM7uFeoUTAYCCSVt7MNqQ66r
 oCtWAbVwgAQnZ3ul52xy4teU5ghXKjqIi7R7cpVRAmPTHIbk0Y3aN99+NaS2H5pduBwF
 Dozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415024; x=1772019824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N2v6djobNSdTdF+YCpvzDQ17kkQi5jILZoPxzgDYLR8=;
 b=uZjMxZv9BjJ3XZhrKucj+T/DSVbkqsR2LDxKHOcbmxwiqkvLW7VF/ZANYYCPx2ws/M
 tyS/qhjKbJeK27Cpidbebm91hbzVIBlEWNf1awpMSKAN8mGsb7U4YL+6r3fy/ctjFslC
 KihbO0VjXFx7V5w6BE4xmy1RJ6cJPju6F4w+AYrUO04UYE4Zb2PMRfY/LD84usYmHKkv
 GuEa9huCUXiiQmmRS9qyUUtfito1y5nlmlYDACqtfGwJsaCjHofUV9sQPUO7ewOMxE0S
 K5mMMi4Z+kLTAeax7mkjjV/Oo2B3qHjs8zHSWD/RFFNM3tS45EyeU0wRU+XmGWI0c/IY
 Q3mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmLQPm53rcumAlbCNXq0gAACEQ4PsOGoleVL333SH4kHjQWTdh6tZRTDyeUYtgkTIUJJP+DNBtJhCB@nongnu.org
X-Gm-Message-State: AOJu0YyGom+oFDED72QiJWbrLwQMMkYkseqG6IuZcVneuuPZMTlivauU
 Pl6euP7PLFpquIV9ragTs4uNHQ+vFGhueTwEV+h7/73ABjhzPbkSp47zivzeKmV58cG+3SkLAfv
 l/eCV+X0ILs68ekSyz8BT4WgbSGOnGbc4/HQkWyX6rJV7RS0Rv3pJ1jc7
X-Gm-Gg: AZuq6aJBOkozFcJZ3J+6lX+TIDUl4lcltil449qQh8DFgWuCKshNZAziNMS5xcqprau
 mdsyM7k4s5CQfI3DuYpVGqdmcQqE5t08nzTyVwJASnuKpI93OdIDMjup5Skl8Wv3a+At/ceMfpa
 Rf8my12hc6RRPbQL1NB9s2RqaWfNfNMP4+6gfi+xiPciXnKiHJCHUMlWDve7EnPIW1sy+qtvyDw
 1DRl/8RGSQbiCbq0nkE4bcWRHsFl8tmARo+bUHP+TwMxJhIBwAAzxVKTq9Yee4AvxQhmu3mJLIS
 UkVPUI6gDfxJeIkrjdwonV+F7R4xO7u2PqNnHwOMkLLYTsDXnieMtgMVe3uJR9ZNqutpXfbXz39
 FCjXKPhVxjDyw0fXR8Fmd5HJLkm4Heg/Xi30uXMGXgnIGcoe02lpx
X-Received: by 2002:a17:902:ccca:b0:295:9b73:b15c with SMTP id
 d9443c01a7336-2ad50f4c562mr14531485ad.42.1771415024598; 
 Wed, 18 Feb 2026 03:43:44 -0800 (PST)
X-Received: by 2002:a17:902:ccca:b0:295:9b73:b15c with SMTP id
 d9443c01a7336-2ad50f4c562mr14531355ad.42.1771415024293; 
 Wed, 18 Feb 2026 03:43:44 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:44 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 19/34] i386/sev: add notifiers only once
Date: Wed, 18 Feb 2026 17:12:12 +0530
Message-ID: <20260218114233.266178-20-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


