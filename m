Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B86ED25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSQ-0007Cx-Ct; Tue, 27 Jan 2026 00:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSJ-00079c-P9
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSI-0008U0-4w
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8+47Sjna5VFWbMymGn/cKww5NGQWO1KmnHktF7E5FI=;
 b=fMOtX9H4T6rhKLM2wsPAJVqbhdDdWoaS0Z4egC3RPCutb3eaAaeyP6ZsyawHvVpt4aQLuY
 JV9wAVLI6tnCWmFHl7Px29rIRtR9Y7h8iYguaI4BG5PXN9H1QnFf2fMGFiXQHZaEGjj9yk
 hKxSVX+66zTWJuE31d0O9LXjduFkt0I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Y9Mo4NxRPR6OUnwzQQ1xDA-1; Tue, 27 Jan 2026 00:17:30 -0500
X-MC-Unique: Y9Mo4NxRPR6OUnwzQQ1xDA-1
X-Mimecast-MFC-AGG-ID: Y9Mo4NxRPR6OUnwzQQ1xDA_1769491050
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34ab8693a2cso709021a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491049; x=1770095849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8+47Sjna5VFWbMymGn/cKww5NGQWO1KmnHktF7E5FI=;
 b=cgU0Lbm5ujaMe7MvfUZ5Knv6sLMrCMAxk3ZfHNVD6YMwzXORK8aNlU3J+3mWDrMq66
 +v/xcBa6lWgYkvuzDi44s46oMIdI1Cst7t773rDu84oRaGTn39f9ocmb4/f1CGL956EA
 aG1ygxtfsnHbeqBDAnbhBHdgVS80L36om73NyEt6nMHAChgNtHnr9L7/U1ffWw6q0h28
 qw2nILur7dvV/zlRQ6pKRR8iLDQ1VyYPlnH4S6ZpR6CVRk3Tm4nMudBcwrm79j08wE9S
 /PIL+GZwv7Y3Xfiw0DQyzXWMwNUU3rWacmBhugv4gYpx/8eOMVGHn5Gskw7+PFFvex/V
 vwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491049; x=1770095849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j8+47Sjna5VFWbMymGn/cKww5NGQWO1KmnHktF7E5FI=;
 b=Ks4ny/Ua1g7PuBAsTml84y0UH9aicLh5cbRZR4adW+4YVBaW8zV7A0fA2BRfcRKfIv
 hoFbiFRemrgYcr0CD3onLzWAqJRqvKcse4WvVrKvrkLWGBXFoMrNjWVKI0+sbesJlfiy
 mLIA13g0Zi/2ZEFFPQVqwICB+k96zaltJwD0gjzCw8Bt9fAM7VF5OO5DdM4Lo0/24dHz
 cr+7TnBjqBbFA+bqtuAloVJSZxTmsYdUsBufvu6D0f86AJUgLXROVNoOA40XxmcHFz8E
 drcTGmMDQkWhGEh1HA/mBFTgHqGB2n+vk5brb0Xov2yoUTFzo+w5QVY9IZEGIG/JxlYr
 7Ljg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXoaM4e4+hlJ+SG8nknQj6YZekQ97mH2eNNwrtx+rZL9ng8hW8eBAaRbY1KmMyZ86rXC+3rUdyHyBh@nongnu.org
X-Gm-Message-State: AOJu0YzydyVSyS5yRcU4Cz9BMZZ0Pt8Pufd8dsCQXVIro+HVQnkLkvbu
 F+Tbm2u5UVA2J0nwKaJlYFq7zBYkIyRNbfr3z/HJHKtcAg9XWrA3bJibMaqMn1ZRyzqtS4cEpib
 pYmn4V/HwfPcx0agIdBKdPcrPfXmcgfaQ+1uvcl/7caCDGhu+3EOXLtqSsBek5Cqq
X-Gm-Gg: AZuq6aLPZDLh8OP+sLC7fQ5LOJ7jlRtLmznrP6lT89tnE8sTCFrqw4U8ym+NhafO2KS
 eHwBDx2S8UgnHk8IrxkuzaiOu+fHyFWs9LfUzzZHuPqFGg4ic9LSJy7sA3IsdcbF0d7qbYgBMai
 AfO3sBkk7SqmBT/jAK5F8bmBZlI2u1aV7R7NzhgKbHTbzMUIa5pvmTg4NfsgNIL/WMPru83lJlT
 cB0yQ5F6mF6awu3Tk5EE/JUJypmP+oGlBP2iROc8Fm8GE9Jyn6FcRH+0lBXCLVs/r27QWC0JEgP
 m5LG1yUAODH7ll0hGDEnmjMKf3Bwu1RM2FD06dFhDzPKmOLuuRHRWSo8mMMemmncKuCbs5aij7J
 D3XocFZKwa+5EH6Pmsafc0XwS4GVss0vm2PYMOz6CbA==
X-Received: by 2002:a17:90b:3a87:b0:353:356c:6840 with SMTP id
 98e67ed59e1d1-353fecf4310mr763133a91.14.1769491049489; 
 Mon, 26 Jan 2026 21:17:29 -0800 (PST)
X-Received: by 2002:a17:90b:3a87:b0:353:356c:6840 with SMTP id
 98e67ed59e1d1-353fecf4310mr763118a91.14.1769491049154; 
 Mon, 26 Jan 2026 21:17:29 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:28 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 18/33] i386/sev: add migration blockers only once
Date: Tue, 27 Jan 2026 10:45:46 +0530
Message-ID: <20260127051612.219475-19-anisinha@redhat.com>
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

sev_launch_finish() and sev_snp_launch_finish() could be called multiple times
when the confidential guest is being reset/rebooted. The migration
blockers should not be added multiple times, once per invocation. This change
makes sure that the migration blockers are added only one time by adding the
migration blockers to the vm state change handler when the vm transitions to
the running state. Subsequent reboots do not change the state of the vm.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 176329bd07..5524e7142d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1420,11 +1420,6 @@ sev_launch_finish(SevCommonState *sev_common)
     }
 
     sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
-
-    /* add migration blocker */
-    error_setg(&sev_mig_blocker,
-               "SEV: Migration is not implemented");
-    migrate_add_blocker(&sev_mig_blocker, &error_fatal);
 }
 
 static int snp_launch_update_data(uint64_t gpa, void *hva, size_t len,
@@ -1607,7 +1602,6 @@ static void
 sev_snp_launch_finish(SevCommonState *sev_common)
 {
     int ret, error;
-    Error *local_err = NULL;
     OvmfSevMetadata *metadata;
     SevLaunchUpdateData *data;
     SevSnpGuestState *sev_snp = SEV_SNP_GUEST(sev_common);
@@ -1654,15 +1648,6 @@ sev_snp_launch_finish(SevCommonState *sev_common)
 
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
 
 
@@ -1675,6 +1660,11 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
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


