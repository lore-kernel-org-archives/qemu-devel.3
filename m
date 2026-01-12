Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68517C9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuK-0003e1-6Y; Mon, 12 Jan 2026 08:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHu2-0003As-UW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHu0-0003nQ-R4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qYAaN0FILWaSu0nPli0Usb4itaQvJcTN3FzK6m+/4vg=;
 b=hzjUI3uG2OHVhMNqaApDlNOZ2bwgzxPXH7ijxlWIQMXdv6UKZG/eOq3Tr60TV0eHBnhEBY
 aYiBKza2kO8egaqAO5YTG2Myq4m9h8fgdcqr7+n1lencNBEI/wQWtIeSGqr0YQE26k8Jv7
 1ds82ety1oAboGz3nBUI2LUTCnYh730=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-SQXCPEVJMy-QeSErzojfKQ-1; Mon, 12 Jan 2026 08:24:08 -0500
X-MC-Unique: SQXCPEVJMy-QeSErzojfKQ-1
X-Mimecast-MFC-AGG-ID: SQXCPEVJMy-QeSErzojfKQ_1768224248
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b5edecdf94eso1467487a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224248; x=1768829048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYAaN0FILWaSu0nPli0Usb4itaQvJcTN3FzK6m+/4vg=;
 b=hNpz5cqQ7OHVFWMvl3/dZDAtr2TUnaxAI7GYmIE9IadJ7F+6pRjhuQQ2UQYhv8yyjC
 rwDy9uyQEt5KmHiB3JlV8S8sXsJd9wtDqVb9VqwszwBPIQs5sIoo0S+uUQ+sFNDUP8QA
 2PAyp+cIkLvrGHE5JwEbTakk+iTJtUgIbSjaGTtSI5oEcyXvZ5+U7MgmNQYCmr8MeSvK
 itkpZR1kTLQrns0irRF0+wa44Ruy2COd55eAHNk4Yw1rtMeAtH844JDYGDMQM3ZNbvVs
 wBW2sKHqJPPjCZL8xv9mIbMFNT7k9wswZ+ASaUliKN7syokaBchIwCQB4UwahxDwG2MI
 VRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224248; x=1768829048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qYAaN0FILWaSu0nPli0Usb4itaQvJcTN3FzK6m+/4vg=;
 b=Xgw3+BotCbnxk/WkWaLLeCkMe/XGBR3Q0QjP20OO2yv06cIqulWS4HZVU3AImpe8Uu
 PLUkd2I/9V9i02EkBLYPm7KoVwLj0H5pBJoE51B52nSwDjAzYvXtGBCfcn377IJcNcyR
 x/A5M3hGR99rE37Jyzm2UOVISBcYqkMnAconrVErlrCEpFzO2RsqAAX4X0pcT9ixFFXj
 N9M1CdrPDPGNtbiw5JKcp5TeIEl9Mvy+gWdXuSmVFeUYJBzvY2/UZekB+xILvavm6DxW
 V4QRLHYy0VTE4ht3niJsVCEV8KZAFREN1sEAWYo9lcpbwvAoopeZugfmIzLNvviSwuyd
 OpKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe/3NbzXUdnaqa4yNW42Yxgv/rnGEC3O0tdummrgi6mLTgrvyMgTa7sp7SC57iCTZ5V7mNQtiYOr5P@nongnu.org
X-Gm-Message-State: AOJu0Yy/COnuWuR9APPD2d5JA2Y69WbZEtyjnGglfTfMNYBKua5tWLat
 2syQ3re2dfajP7ZEiNtYYVhLPRSUHLuCW48ZG6LEaNPze7KKUijmd16Et7BntsEOI2CHy0XbBeV
 +pX1Z7yMvaWwC0sk08ULjKXMryMvTlWRrsa7Ayu84eDriLtBzuCqsAsAL
X-Gm-Gg: AY/fxX4zDqpTtDridVelrgqiLnTdBLBarcVt777TPn/m4pf+AfLHD5zduOZP+F+HsIT
 hS1EPVoEWn74XwJE9TU2JR9aBrWBLj2NkDMXZoHmFabzU5vNHTpynJgTeMgqONH1xmlYcqNFwem
 JhGpYRJ24R6Y6Q9BPUX9sx3A/lcgsW6kgHiY04xWOD3xDTpFCztRWRhKTcwI7CwKVG4eXjP+lcK
 i0+KQ8AZcIAgSZduUr0Wk2JH32MONWDeGvg74q6ZPUp/9GL2gxiM3yhqO8AvxX5FD7oZd/ubJ0k
 h45IAC2WQ+rukUMy0UwBtYdogG3jtsdwK80w7ZSNi/cbtvyvlsZiOdHqgB3k9mMZ7IEk8KPhH5Y
 I1h0GXvWAv7lMkyJWVIuH521nGJH4XvAbTUVMGeWiLxo=
X-Received: by 2002:a05:6a21:6da1:b0:350:3436:68de with SMTP id
 adf61e73a8af0-3898f9ba491mr15321620637.53.1768224247831; 
 Mon, 12 Jan 2026 05:24:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOtkQ45tyb3QTZGZrDgFq0z0H3Qt+mAbmV6EBRPgB7nC3YcwaVegyFHgedWmQohGcEWT7WNg==
X-Received: by 2002:a05:6a21:6da1:b0:350:3436:68de with SMTP id
 adf61e73a8af0-3898f9ba491mr15321596637.53.1768224247424; 
 Mon, 12 Jan 2026 05:24:07 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:07 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 16/32] i386/sev: add migration blockers only once
Date: Mon, 12 Jan 2026 18:52:29 +0530
Message-ID: <20260112132259.76855-17-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
if the confidential guest is capable of being reset/rebooted. The migration
blockers should not be added multiple times, once per invocation. This change
makes sure that the migration blockers are added only one time by adding the
migration blockers from sev instance init code which is called only once.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index fb5a3b5d77..c260c162b1 100644
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
 
 
@@ -2764,6 +2749,11 @@ sev_common_instance_init(Object *obj)
     cgs->set_guest_policy = cgs_set_guest_policy;
 
     QTAILQ_INIT(&sev_common->launch_vmsa);
+
+    /* add migration blocker */
+    error_setg(&sev_mig_blocker,
+               "SEV: Migration is not implemented");
+    migrate_add_blocker(&sev_mig_blocker, &error_fatal);
 }
 
 /* sev guest info common to sev/sev-es/sev-snp */
-- 
2.42.0


