Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B7BEDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9v-000895-OQ; Thu, 12 Feb 2026 01:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9q-0007qm-46
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9o-0005HI-PC
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zpSCPimmyA0e0qP7Kcivb9yeJXq4znZSTQUpfrxyiE=;
 b=UABHAlq0PpfeQMQHoTOolnwfzXaiTB3q7/d4YlrM1xa8U0Tv1nM/uULPoT3K/JAe5zbCzk
 OgwdRfUsqUDZEvb4ifhNu9cPHGDNE07NjL6bQitUvZ8Qcy3e+dHY2VdkouMDXPKIx191cE
 wLMNjHxQjaTNr5rHNEsuKR60pq3uomE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-e_VCarWfNDSnPbfqHNC5Dw-1; Thu, 12 Feb 2026 01:26:29 -0500
X-MC-Unique: e_VCarWfNDSnPbfqHNC5Dw-1
X-Mimecast-MFC-AGG-ID: e_VCarWfNDSnPbfqHNC5Dw_1770877588
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-354c44bf176so5391282a91.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877588; x=1771482388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zpSCPimmyA0e0qP7Kcivb9yeJXq4znZSTQUpfrxyiE=;
 b=GTqX+k7T75a2wPzxcLtZVBrJA/OMlqExTYG3gk6c8dhgzC8VSfPSgKFJv+7xik05v8
 BR22StZFY67C+JGRJ9YVxfQJpk/AluVumHSO0qwWi9CxhIT+UXLrRfWheQk1iWrkGQ4j
 OO3zpYzboBkcVpkSCGPtJE6HpEbaKoGCTLgqLHdFLOoJogQeAxkDhN6LMB2O1MM7m2kX
 WLMTfpOPIcEmqt2p63G7Ko0JV6f1NMbwoehOaKTSNnvp06JzAvQeUJOGfUEJ9f6L0T2J
 vN/MP6sgCm8cDmWJpLAMDnh+qBWQqEdaHkid/fqLduUi02jknmj5uNiPomyl9H+yv3Bv
 SnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877588; x=1771482388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8zpSCPimmyA0e0qP7Kcivb9yeJXq4znZSTQUpfrxyiE=;
 b=gVClAPTiMOwkdJ07i9Ccxq589X4gf8kXX2rQqWfgjptL9K8+zPHk3KF3mU+eKg0B13
 G7zr5Uc/Im2UUT+72TyMoo8KlXV43OWVBrNAF+sJOkRPSOV18doQSSGxNt9gsSb0XjyL
 hvoAAy7+/rTFV+DbJX4iripWL1VL+IFD6NTQoScbNhm9JDgTOVoI5Rm3ijaQ8stRDDH+
 54tF2ZlUDEg1jBuRgEWEK8XRvZoplBBGY1Ou0Q7kYMFTYQk3qc8dPKDK4Q7ZMvMf4Y3Z
 OvepJfuGLfR1V/891j0vr2rKEt7RdV+AGSJrzS1d93+vVubbwIhiiWQo1MycylBRcU8V
 GhpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkJ7Q+i6Hc8HyRRgaqipNmPX2WA5SPYeNV7+pPZhCjSu9psM8VG9Mi3nihuiLRitCD0l0u35yBo6Nq@nongnu.org
X-Gm-Message-State: AOJu0YzfU24ACV4QwUsSafU//DxtrmHdSvSw/781AuoaFAE8IBgSB6ks
 A5OdgdTa4nUPtl++M36KZlxO1Y5LTG2IC9YnD9TQPudf0vKxkvNct076WpyDZctYxmP4vQaEg4/
 0BquMZ2vN87XnRGheEPK8X6VquOlnFGaBJYPyU5NMm2gmh79igudlAkXV
X-Gm-Gg: AZuq6aLrSoIfCt8VAAR/XAS1eKXMYj+jaGNO41/X42gSAtAByMiY8wZfY0x9haLPpyl
 ntkZxcpWCTztX8ExrhksjYe6tYq4lVsHAyDJdrLTadFk8fu7p4/rgKBZ0O99oVkFbprNsZiI2cu
 vILae5kC34DgOxmaczAXsmPAPfn69+4LGf+wEqMrYlsM/TWokVvSx9tARzAaOICPqMz/8D8Ar4j
 NY6B08wigX2epYI+SUnEh70DPnaqdWHTM/HI4murhale0cdT4RmkUm+M/4JalkHRvT/zZKl7ww6
 1bJ4ToSuVdyJoNkl7HxpRfIw2NoVNXkDq+kz4bpTpzglW0fy+oB8Nx+zAb/PI5VlfSaoDFnGJXt
 0ZP9jW8W6VNETFwvCR2MKRgAV2qShityVmI4gcIH1Z0ZpcWxfa5/VlDI=
X-Received: by 2002:a17:90b:3503:b0:352:c995:808a with SMTP id
 98e67ed59e1d1-3568f327382mr1457960a91.14.1770877588516; 
 Wed, 11 Feb 2026 22:26:28 -0800 (PST)
X-Received: by 2002:a17:90b:3503:b0:352:c995:808a with SMTP id
 98e67ed59e1d1-3568f327382mr1457945a91.14.1770877588157; 
 Wed, 11 Feb 2026 22:26:28 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:27 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 17/31] i386/sev: add migration blockers only once
Date: Thu, 12 Feb 2026 11:55:01 +0530
Message-ID: <20260212062522.99565-18-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


