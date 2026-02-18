Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A4FE9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfyc-000440-0a; Wed, 18 Feb 2026 06:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfy7-0003Ul-Mm
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfy6-0007uT-7k
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=av9X0K8K/0DXwv9tLYeu3Bap1JDHpXgcHRbzm207TyQ=;
 b=OHJzLQf9ByniAKSF4pau2muw4VY0Ew6Z58hK9GMh4SHrqQRsgUx1fymSpEQfGQ5C4gX/j4
 5ql8XezIu//pSVyY+D9zL2JBNBWFvEAEkU/o251FoYAWqreiXsiVWGg2adRdNKhM2vXORU
 FyBdRu+qZftG9kKyxM2Phgh0xpEWBrI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-08Iqm_SwPfmV4-Elw-4rbw-1; Wed, 18 Feb 2026 06:43:42 -0500
X-MC-Unique: 08Iqm_SwPfmV4-Elw-4rbw-1
X-Mimecast-MFC-AGG-ID: 08Iqm_SwPfmV4-Elw-4rbw_1771415022
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a944e6336eso304900085ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415021; x=1772019821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=av9X0K8K/0DXwv9tLYeu3Bap1JDHpXgcHRbzm207TyQ=;
 b=Dc8Lqk+UMAQWHknILNs3nNTErY0ZsxZ45SEQJgj3eEDXLy6eY6XRkg/CYiQwgNlTHs
 JdVBVRzAOW7CyWjMlQRMgh+FOjI0/NIpyJ0Ma42qMtQKIF2du8SYxzFwsLfcKFR0KK6y
 ya9PWALoT1KGkQGk0jqKw4L8XjQa9rGpD+6g5S0YX+OoSBWW9JSbidjdOMQ5vRaMOm5o
 bNLzujRnjA3aJqNNis5b+GLW59WX1VqtC0wYFNShiYSLlqWnt/xeuOjdLSLNBPJbSJzK
 7POLsdlO/Juoy3T3vFhlKASJpuoO6ypXyI2TVk/6GWQxJMjhFsWbNRt9vGLWn6u9GAZE
 vfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415021; x=1772019821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=av9X0K8K/0DXwv9tLYeu3Bap1JDHpXgcHRbzm207TyQ=;
 b=FZar5mWEoCtIOGyxY1GRtoQSIuhNFx1qQ56vT84v/OtKY0PV71mliZ9DzAG63U3tLP
 K/Ih+jkm21vHp6l+azWUJyYAeJCfrJLjyW7HIBrkqRoVLlW+ZhiX6L3uqP3MxJF9s+ku
 iEW9O+TTwwax4E35T+3NmjxKX+ABD4F3N7jKLLLMEjVzhlL5rjayDHsAW88iHJcoh9q+
 VHtNJICusEKCwTuExqSZgF9ZH2ZJhxskWg51tS9w/yaZaFoYJO1YbhzmUIFrUo6+Adbq
 iVbsVsUpAsqWe3yzGRxRfQcpAKqKBAIrkjqlmxaJNJ5OjMnVfwRT1XIRQadnIONKZAaV
 V8hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOkmvOYLVd7A2jEN5KRISboKcyknCoI2kccinNLP99OqW4lEYA9B+p8q34/Hsg8F6oH/t5VOFvfaQG@nongnu.org
X-Gm-Message-State: AOJu0YwHluo4wPy9kfKCyKJrNF1cnc1KK0UE/syvDNVeREGqYgwbJOEr
 FuStHTD2HyzNCJN1G/aAdLvUz0YqApU3SghWA/FqxqWmlcQxEs5Id/ay5mrWil7jOZM27NjDCeO
 18CD06tI3E/A8Ux1n7cD3Foc5IS3yaXet/Ep13VRp8wy0DwzFJizPjTgRpOyxRu8b
X-Gm-Gg: AZuq6aKNljLL6vDLXjic9lVb0Fhy+f7p6GGAxBDT+6sQwmeCe2U7RN5ObM2lyqnPUlW
 30Yi7XFgtBfjYs/HtqzH5UkIWvjY3Z6tX6mZJg6xlxhNnG3HecK/9cVo0t8my/+OYNXbs5l//uz
 PNZW+8HjZnbCXVgr9ob8pjkd0fpiZXk+29tekY7CjCBZAhNBCSzU46elehgJUiFDdeIkeRv0ayl
 aAatysMfCtRrQn4is5nAgRROJsPnj9hsl2ZO5PDM1MWNqLLLmgwidIMS1wIy9X1yjffTgB6UdUR
 cmZ6Sf7r3IOYncIQ6699vt9kZLhEv8M8RrdZUPvaGeHwCCQH+63+wF4b3qE68+pdgc2n4Vzt1yF
 2C5YmCukYnBnlaYM4W2VsDkrVBBbJRNMpLe9mCjDEDD9oG5Ntz53u
X-Received: by 2002:a17:903:2b05:b0:2aa:3b3:d633 with SMTP id
 d9443c01a7336-2ad50ff1164mr17117415ad.61.1771415021474; 
 Wed, 18 Feb 2026 03:43:41 -0800 (PST)
X-Received: by 2002:a17:903:2b05:b0:2aa:3b3:d633 with SMTP id
 d9443c01a7336-2ad50ff1164mr17117305ad.61.1771415021124; 
 Wed, 18 Feb 2026 03:43:41 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:40 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 18/34] i386/sev: add migration blockers only once
Date: Wed, 18 Feb 2026 17:12:11 +0530
Message-ID: <20260218114233.266178-19-anisinha@redhat.com>
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

sev_launch_finish() and sev_snp_launch_finish() could be called multiple times
when the confidential guest is being reset/rebooted. The migration
blockers should not be added multiple times, once per invocation. This change
makes sure that the migration blockers are added only one time by adding the
migration blockers to the vm state change handler when the vm transitions to
the running state. Subsequent reboots do not change the state of the vm.

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 66e38ca32e..260d8ef88b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1421,11 +1421,6 @@ sev_launch_finish(SevCommonState *sev_common)
     }
 
     sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
-
-    /* add migration blocker */
-    error_setg(&sev_mig_blocker,
-               "SEV: Migration is not implemented");
-    migrate_add_blocker(&sev_mig_blocker, &error_fatal);
 }
 
 static int snp_launch_update_data(uint64_t gpa, void *hva, size_t len,
@@ -1608,7 +1603,6 @@ static void
 sev_snp_launch_finish(SevCommonState *sev_common)
 {
     int ret, error;
-    Error *local_err = NULL;
     OvmfSevMetadata *metadata;
     SevLaunchUpdateData *data;
     SevSnpGuestState *sev_snp = SEV_SNP_GUEST(sev_common);
@@ -1655,15 +1649,6 @@ sev_snp_launch_finish(SevCommonState *sev_common)
 
     kvm_mark_guest_state_protected();
     sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
-
-    /* add migration blocker */
-    error_setg(&sev_mig_blocker,
-               "SEV-SNP: Migration is not implemented");
-    ret = migrate_add_blocker(&sev_mig_blocker, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        exit(1);
-    }
 }
 
 
@@ -1676,6 +1661,11 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
     if (running) {
         if (!sev_check_state(sev_common, SEV_STATE_RUNNING)) {
             klass->launch_finish(sev_common);
+
+            /* add migration blocker */
+            error_setg(&sev_mig_blocker,
+                       "SEV: Migration is not implemented");
+            migrate_add_blocker(&sev_mig_blocker, &error_fatal);
         }
     }
 }
-- 
2.42.0


