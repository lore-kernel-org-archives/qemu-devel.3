Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B811F55455
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vj-0000ax-Vh; Tue, 24 Feb 2026 22:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vh-0000Tb-FA
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vf-0008AE-Sv
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=av9X0K8K/0DXwv9tLYeu3Bap1JDHpXgcHRbzm207TyQ=;
 b=CRKibTyGmiITKZQuvTdcGat4LfJvYQr8RyHizlqB4N+S33KGob9T9u4sdV3Ll72zoBdUdH
 2zsSBKdY3ycWJz3miV1EHv5QMMr4PGdzG0iM+cyP55yxujYdB5Z4PQghisbBtDPQcjrEz8
 dEUzMzlQ4Mgyg52/QYbGNGIpEhixeOs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-sGWARIljMuWhY6a9CP5N_g-1; Tue, 24 Feb 2026 22:51:13 -0500
X-MC-Unique: sGWARIljMuWhY6a9CP5N_g-1
X-Mimecast-MFC-AGG-ID: sGWARIljMuWhY6a9CP5N_g_1771991472
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3562171b56dso6733477a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991472; x=1772596272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=av9X0K8K/0DXwv9tLYeu3Bap1JDHpXgcHRbzm207TyQ=;
 b=A2gf1lLF09F9ziXpoN0it2axmLEmmPp9+EvJwZ1Ci+9cTJXxgUm0IrkXzQB1te35sA
 05HQVy67zljz6DFGPi+r/vzZ3ikcRy6mmVBip14TWgV/0Qp2TUqJNVXqt9ggK/ggHAOU
 sdpZnlYgR0MJyvopu/bp0VWGHOD0dPM8Q+yFcGaqBLoD4kt358uFO4H76LtlgeoCMdvQ
 s0t41+K6BcycIX3SNEx3L9GAqtYRGtjMclup2D5knfkowSdTdsdW4LuevEkPSJQN9k5k
 TDRwG3+5uQuXJ+Reqd5kTV9PEnb/RYaOA1rjVjMb6rxX9s/a8Tb82CdiIH5JKsJhjNo1
 NP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991472; x=1772596272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=av9X0K8K/0DXwv9tLYeu3Bap1JDHpXgcHRbzm207TyQ=;
 b=Ormv4iJ5Xnz0Q9AtdBjUa9YtvB1AKoJw/gyZ2oXcSdBFu1GQYjwuheomHRvC24Nt/H
 UxVN2A5TrQxV3MB9UYdpKJcB4jqOl95OtMaec6E5jK/HFYLfpLZz74iK0kJHXJN5AH5P
 PuYj3fyHLpZ9kTvU2A1Psan4dXKgmObqldrBrGRP/sI+ZQP9yIVHy2VT2mZTt7yRAgBn
 5zduHeQ1phVqg8WlGPRDEc8klEUmyQhIxjGalLejAAwt3SCaDbql6koBf/Knu1IRv2Wy
 fxOdR//p0ZAx3poVI4vz+Gp1D5grUt4pHsrlzbl8OYh6w0B3NuZqdeg+CtwwoGt3bEbf
 J7BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+11pFOkAtFUJ7+n5l2B8/bilps2mj8pcNmTuwQSDrM5/x95Ie880ncyInyl3h2GOW+ZRmUWHc/sZh@nongnu.org
X-Gm-Message-State: AOJu0YyyofrSKgyKkmt28CQHPrxknEfUbTkqp4IvVmYR4cX1XBI0nHvo
 JPYvWLqGsqffps+jHo4vdqzjTScly5WXTth/i8IZ2EP7pRCVjrZ953vYkgt0AfAppHLGnzgU5Dq
 Y/zJDx3Ua04zI4Ccaq9JBEha3QwwjqftlriHRrPna4DOzE8CdC8QAGQcS
X-Gm-Gg: ATEYQzw+uzIKaEX0ELHPoR3+2S0e3DW7tZfI0Zu1ND9f9jm1FiUp1l7u6D2ftT4+3D1
 3gdPqZZx3n1UluyynVCQhlbY94pmtoFFaP0v1LWZf6Gd+wUfWFiUMW0UiHzlYDlHWaHBWDK21Ut
 +3Xtmh5KHuFDF3SFiYCVosNOw8r5vq/v4wrparaTFgHp5/uIZsVdOz+0lMK5z1ojR6KSeEStQ//
 Jl/oEN66eyPXEXr1D6i7Nq7EZUMpw5VFCu4wmoO0+VubIxM4QpjMxUxoLKPOvYX2ETLHuvAZ0Xv
 wJWZnfIQSkmqp4eUVWH6wxpgTaMuALmmuE4h07mMJM5SmBp0jHYpQD9U5m59CznSNCw+QxeYchi
 FlKs/lrR6a50fokeMQVWRW+YpK4GCQzSs6LDHDVt/9fn3vaJ99g881qI=
X-Received: by 2002:a17:90b:4b11:b0:356:24c8:229d with SMTP id
 98e67ed59e1d1-358ae8a48b4mr11520256a91.21.1771991472324; 
 Tue, 24 Feb 2026 19:51:12 -0800 (PST)
X-Received: by 2002:a17:90b:4b11:b0:356:24c8:229d with SMTP id
 98e67ed59e1d1-358ae8a48b4mr11520243a91.21.1771991471958; 
 Tue, 24 Feb 2026 19:51:11 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:11 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 Prasad Pandit <pjp@fedoraproject.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6 19/35] i386/sev: add migration blockers only once
Date: Wed, 25 Feb 2026 09:19:24 +0530
Message-ID: <20260225035000.385950-20-anisinha@redhat.com>
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


