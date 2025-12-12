Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E592D49232
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4i6-0002fq-H3; Fri, 12 Dec 2025 10:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hr-0002Hc-KG
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hp-00063a-6A
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsdNlrFz9EGrun/Uh+cGSSljZDj/Qg580O6DUWM5YJw=;
 b=VJXV0cbZ4/38EqgeSeyb0gkuzF2BT+BGmDEprqeguWGumngCklpwYgeRzmIN+2uWUj5JDm
 7i0JeqUIqETTt/+SBhgywWL7m3+wFKS87D7hEh0moYyDD5CP46kOuO8NBjQsSYDXLnA/HK
 w7pp7vnS7/1EQ35fO1On4W1lZjRCV1I=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-AzWvr069MVmNF5Sy5I2yaA-1; Fri, 12 Dec 2025 10:05:13 -0500
X-MC-Unique: AzWvr069MVmNF5Sy5I2yaA-1
X-Mimecast-MFC-AGG-ID: AzWvr069MVmNF5Sy5I2yaA_1765551912
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29f2381ea85so12940605ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551912; x=1766156712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsdNlrFz9EGrun/Uh+cGSSljZDj/Qg580O6DUWM5YJw=;
 b=SU+ZPYuhXdw+MqNVgMyitUKU8nCXScT378V9GZoVow0DQlauU6YWgbRyogmUBq78GT
 1aE1b7gMe6pXolkkmx4qt/M3WHgZCMpjNciMyEwZGUzCXnAQes+HWHfuN8GP9SmAwmKn
 TMlHPjV3wAIAqdSj/xay453lpvZ1yHeit447pdfe0wjizPEPH+l33hfSvTj1f87+ykgG
 MXIsjIEsApnM5dbyKNlDXU9/oagDywgcwnh5tm/DwNATMbzpErE0ZCYU2tsjj7vpUpOQ
 soeGf0eGuwETQzYWsuFxBnPotSmtAgQhG3oSzBMJUwsEAQqiqKI6iwG4GCz+RM+dgU6T
 AUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551912; x=1766156712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LsdNlrFz9EGrun/Uh+cGSSljZDj/Qg580O6DUWM5YJw=;
 b=rrIoag1Exuj3AUFaz/L5iTAp9B2mBMeDiMPU+s9VLF8RZbz039iy5cYft2j6Ia8x/B
 TlOlqDi6P23KigCQQmPfJ/t1E4jfphTk9PuLuWgEhscUG/I/vsp6EgcDe57hIAWfegyr
 13DanQyQAOONrRYPAN1zl/GTnfk32iznCXvGT1fsOUxLsrwfqtTLzScC9LTy6NFJocXT
 AE2gYWgC68SWK4Q6PDcjnXXKAg/vs6v9S5qHPnMvwDBIdJkxzxPHB78VDIvNNEeghlJL
 nNfJjhD1z7Qje0TzA2KEKvZzqj/Dwuqguh5xr4TIHcinwopp6UMH05r5rslL6n7GDZtm
 jlaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqem+snMF6U6zU/0pPn49KtZ8XUklh6t5WMhALynvoTDTWES8kJDbdmMavETV0ttZdRcexPpPDETVL@nongnu.org
X-Gm-Message-State: AOJu0Yyrkzepm/xeJvRK1ckN04wykM/ecxVOOHjeM66xB58Aqr7LRhBL
 E5Oly07b3r4ayX23t+j5AjSbPEDlPuVtsXahNY5gdnNpt8g5tKwU/No0rO/NhDl28Tw3eeuRWve
 Y8XUVYwFc5YPKWnKseoGvFPMvuADD5Yaz70WPb/qzf5rygNZEjgz3Hgqy
X-Gm-Gg: AY/fxX6A2tF39Fq8pra2SjluL750cHheHwkhWhDHjdQ+RZgYyiJ4USzmsRB+IsBOzV0
 EUG8+YLitwPhqpUFGOOhU9Zzcvmt/lKSog/nfb2Pbd3V29pFsGEFoKHx2ynXHiWZb6nZqdILrzh
 9N1x/mJTwMblpk5skn3pCEVpX6lKnCNra6O07M8D7GJ1TO+3VLU67ilfxor/rUGCmPNPnS2bII8
 8h4H8gAgkMRzaaeAWXSzYF47Jr+N5JTvrx9lGuHs2bMnvcEp5WmyQ+FJYgTMfHR/ShLnffk7Fqq
 8xOqWWpn1OJon/zK9L+Kavk8tg/TFfSO78iDz2qqAP9NElL1DgpPrtkyvjL4Tpph5FOW/geQtwb
 c/awkA9Je0eo22udEgSLW6P52cydLPy2ditk8gvxYo5E=
X-Received: by 2002:a17:902:ebc2:b0:262:9c4:5470 with SMTP id
 d9443c01a7336-29f2404b199mr28726295ad.28.1765551911996; 
 Fri, 12 Dec 2025 07:05:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkoxBLlDC0IBA4TUcGuzRYGD7mbavLzDucIBkcmhvL5++uimoBU2V3fxAkUHD3REawLNk6eg==
X-Received: by 2002:a17:902:ebc2:b0:262:9c4:5470 with SMTP id
 d9443c01a7336-29f2404b199mr28725795ad.28.1765551911481; 
 Fri, 12 Dec 2025 07:05:11 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:11 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 15/28] i386/sev: add migration blockers only once
Date: Fri, 12 Dec 2025 20:33:43 +0530
Message-ID: <20251212150359.548787-16-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
if the confidential guest is capable of being reset/rebooted. The migration
blockers should not be added multiple times, once per invocation. This change
makes sure that the migration blockers are added only one time and not every
time upon invocvation of launch_finish() calls.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index fd2dada013..9a3f488b24 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1409,6 +1409,7 @@ static void
 sev_launch_finish(SevCommonState *sev_common)
 {
     int ret, error;
+    static bool added_migration_blocker;
 
     trace_kvm_sev_launch_finish();
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_FINISH, 0,
@@ -1421,10 +1422,13 @@ sev_launch_finish(SevCommonState *sev_common)
 
     sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
 
-    /* add migration blocker */
-    error_setg(&sev_mig_blocker,
-               "SEV: Migration is not implemented");
-    migrate_add_blocker(&sev_mig_blocker, &error_fatal);
+    if (!added_migration_blocker) {
+        /* add migration blocker */
+        error_setg(&sev_mig_blocker,
+                   "SEV: Migration is not implemented");
+        migrate_add_blocker(&sev_mig_blocker, &error_fatal);
+        added_migration_blocker = true;
+    }
 }
 
 static int snp_launch_update_data(uint64_t gpa, void *hva, size_t len,
@@ -1608,6 +1612,7 @@ sev_snp_launch_finish(SevCommonState *sev_common)
 {
     int ret, error;
     Error *local_err = NULL;
+    static bool added_migration_blocker;
     OvmfSevMetadata *metadata;
     SevLaunchUpdateData *data;
     SevSnpGuestState *sev_snp = SEV_SNP_GUEST(sev_common);
@@ -1655,13 +1660,16 @@ sev_snp_launch_finish(SevCommonState *sev_common)
     kvm_mark_guest_state_protected();
     sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
 
-    /* add migration blocker */
-    error_setg(&sev_mig_blocker,
-               "SEV-SNP: Migration is not implemented");
-    ret = migrate_add_blocker(&sev_mig_blocker, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        exit(1);
+    if (!added_migration_blocker) {
+        /* add migration blocker */
+        error_setg(&sev_mig_blocker,
+                   "SEV-SNP: Migration is not implemented");
+        ret = migrate_add_blocker(&sev_mig_blocker, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            exit(1);
+        }
+        added_migration_blocker = true;
     }
 }
 
-- 
2.42.0


