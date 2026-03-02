Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D809D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvK-0006iF-VA; Mon, 02 Mar 2026 03:46:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyv8-0005pt-MU
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyv2-00020X-RF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yC2reODZ02Lvi21uVjw0SLAfTQm+6tGilWRlG3DnSxM=;
 b=f6BIcRuTOHfnFc199gMYk2efeR56HLBH3dvardx1hNRXLr4q9XV0A4qLR5vBoePIhYdUIt
 ZLYIaYAZJdgSB134QQNV3NseBfpQTsPvyHM+E9Ja+L3R3qf4gjtPWzrhavW566SftITg3F
 C3wM05/UE1canqv0w2VC6C2KhNJlC9o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-7JB1SjtjOZawUo3lQiwXMg-1; Mon, 02 Mar 2026 03:46:22 -0500
X-MC-Unique: 7JB1SjtjOZawUo3lQiwXMg-1
X-Mimecast-MFC-AGG-ID: 7JB1SjtjOZawUo3lQiwXMg_1772441181
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48378df3469so28246945e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441180; x=1773045980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yC2reODZ02Lvi21uVjw0SLAfTQm+6tGilWRlG3DnSxM=;
 b=sBWTw95kFcif3qN97TJoqpB6lQ6Ng585NGTbnDlIy+at7F69/6p0ZhholCJu65UdTG
 gSbQZ9Rsa2KKomcEwNimwF2ZUIM+8WZXWle6U5OCPwvkVYaXitRtCaUEoc6xQeAci6mK
 RSx3s6SBljsUKD6nkJmCI3UwgxOE8vWYdP4512qXPWcDXyA0VRcdrFOSykiXM2N73qfA
 /L2rZDwLPjvsvgbFPlHjp6kemFoLEsBRcKCFIyZOXdKzgu7P+O1xbILtEq17Td7yQ8k9
 Vr7Es9y1IANoB3AVQeUjkVxwRhnE99Lvs4WES6AV7BAc+bELyk5eBTtUk8bpkdVn+DWH
 gp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441180; x=1773045980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yC2reODZ02Lvi21uVjw0SLAfTQm+6tGilWRlG3DnSxM=;
 b=FWpqdadJ41Uwgxdv1PtIyk9ResfwCjJBXu8G4nJ/kOz+BMB2cd2rRISsoxx2GVySIs
 oTRTnPdLj8+pY9d4tX0oJts2oZoz2tLhnvUI7GNErJwJoPtniuhygVzqhQ5h4tf3YW/z
 crYPkb1Ebrn0wc6nrPen2aGkB7GOUbNZlWlkavj17UcJ+bt+b1CXWkC5jfdhcIoFpz7d
 VfKF5nbWQRwxCI9HkCuEIBFbtc/ccReoiY3PDLfJc9d16/C+htdpzEuufQfPBHTA3/tt
 e5m7qv1g4GEGegIulOsKf5WwFE1JiKCGycn+9JCb0f2EQnQlzgVZwKQitS+WGx+4+873
 XSZg==
X-Gm-Message-State: AOJu0Yz0Z12xDFYfWZYvm5hjdnJLOm6CX0G7XACnb0qusWboOm8wyqh0
 7kyqRX7XzfnUd2S9ggj0BFfocmfeZ47VNgTcAw51HbCm0C6PZotdEaUzwpAPNt9W2vUxOrJhi1d
 cZJrnEJGutPDw2A91gSqRleXLFgkjwP65O/9nM+q/O+rCUz7QjLymYRm7mL+95cQ0hzgZpDGO9/
 spJS7IBwT1/MWH+22RHz7YU8sHxfQvJDrC7dY05Qtp
X-Gm-Gg: ATEYQzwdK1Cub3SvAQIHwq3s/m7tnL2fLOhVvAHTro5ZEmUf7wsofTKjpB9BhOy01QS
 SnPhQyk7Dbg8RG4PZftH2g6FVufntkZTYCUPbNrKOpyETNI/LGsOCuzGRTvpomFEG+pmrm1Ei0O
 EAxM4IAgSH+aCbjL7d6rT2WJVWxLlzJcCeRdhDDRSE+tscVcFbooJGBF8iIcPr11jijLKKnk2Tw
 vh0KyJqod0JDkcM8QV5kIZLodRlJI3xM39/LMoQ/0fe+hh+uCzhSbeP9VWhxBgKRrYCPSI2VZvQ
 zuCMY7mM18rW2uNEyo74KYiINsmFdKPIPAB3w1pKm+o8V3qmsmZ8aLz8QBF0RQzoD25EMiBRzwp
 bY6whUAy2pR7PXZdNgx7hICNjuJlwzw0dtIYwERgvTqW4i5K8eYpMTjHvUhUl8EXsj0hcRaMAA3
 OC2D1OAHOTihXEaSgiZRWDMIDEQYU=
X-Received: by 2002:a05:600c:4e15:b0:483:29f4:26b3 with SMTP id
 5b1f17b1804b1-483c9906a11mr211730575e9.1.1772441180299; 
 Mon, 02 Mar 2026 00:46:20 -0800 (PST)
X-Received: by 2002:a05:600c:4e15:b0:483:29f4:26b3 with SMTP id
 5b1f17b1804b1-483c9906a11mr211730115e9.1.1772441179822; 
 Mon, 02 Mar 2026 00:46:19 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfabb84esm387560935e9.0.2026.03.02.00.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 060/102] i386/sev: add migration blockers only once
Date: Mon,  2 Mar 2026 09:42:55 +0100
Message-ID: <20260302084338.473368-61-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

sev_launch_finish() and sev_snp_launch_finish() could be called multiple times
when the confidential guest is being reset/rebooted. The migration
blockers should not be added multiple times, once per invocation. This change
makes sure that the migration blockers are added only one time by adding the
migration blockers to the vm state change handler when the vm transitions to
the running state. Subsequent reboots do not change the state of the vm.

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-20-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 66e38ca32e1..260d8ef88bf 100644
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
2.53.0


