Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5DBCCD182
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huM-00053p-R3; Fri, 03 Oct 2025 11:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htf-0004nm-Mi
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htO-0007ci-2C
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8snYAntIlSoQihnGXwjBK8d8TBMrh1tO3gltOLcn7s=;
 b=ZIDCQRjn1qxEM03awIHcYTaZ2tNyhTGQbI/CVGcNR2mz7qq4s/Kyz+D2tD+rc89geuA9ip
 QODlBF6EJaHLukj52dudjdythsSFn7gJ3LuAxaqo5QvtkIRyLi55hj6Khp2tndDu4vX3X3
 +C+LTT7Hw99d4W8A3PvnVlcUDpd/J4A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-0FpQcUzoN8iu6SyBrUSqeQ-1; Fri, 03 Oct 2025 11:40:13 -0400
X-MC-Unique: 0FpQcUzoN8iu6SyBrUSqeQ-1
X-Mimecast-MFC-AGG-ID: 0FpQcUzoN8iu6SyBrUSqeQ_1759506013
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-7f78d761f74so50339026d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506013; x=1760110813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8snYAntIlSoQihnGXwjBK8d8TBMrh1tO3gltOLcn7s=;
 b=rOC5cOWABqLl1wg7UtCgFy7jlwt5hx32gfbfGhOGnCr0H/EZ70NsQlWkBJThRRXycf
 oqRuk4lslJ5t2tBIkflbntuOwbu7K5i/4Je48lr8zjAQ/ovPEm10N7ou6FFgz3xEX5R+
 Uewz1yNneg1mMBQ4K0FICPUPfNewCj9kUQSUd4Se1X1wKpaVGBQX7AWbgTe/umu++0B4
 +ZQre3rIszgkvCAg/uV22BwWSlMPetoFZnQq9+lrF4n/uTcnsl6/LDoL88rLMQJdeDRT
 ESoHjS6TeFw1ptZIxXHjbzOgtCwWKBIl/LnJyiNUWJ7L1SUIEcWyyV3ALiPBTmFKHxbL
 yn9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXV0PucUCsGl6j8kya9sfigY4Wqks65Y9MbnrCUy7/qnl2I+Wh8Deef9N6KFREOMF+36r3VdgQQg1m@nongnu.org
X-Gm-Message-State: AOJu0YxO825vET8bpWkEzx7pnJDxaohoNO5vqgFF4gGghOsSskp7Ho6I
 vhG6KeyJxG9ExfYXFTqqGhKvofaY9EDGsFO/MgAGXgvGMrZ5c0kYhg8nX5MAE+qnt+oeiSAi4Zd
 iJ3J3MVFjVliqkToHCUz+SdLn0qoMRDkOFKRvHcDR1pNPejH0+pvlbGIB
X-Gm-Gg: ASbGncurZVZ55vOzTHl04AZws8jMfLVEZARRICVfHQ0bUXkq6cJ1QLQZRDnLpIHsDoI
 LB9SBNbj6VGXRHp/cDLPuUL+2FKRzLtf8k1U66lUkaBToVPAud/LZ1Qp8d3E7w181nYL/DHxIoJ
 LOox8si/uzePJf47hGKS/8LRUcXBcj08+tbAEFTFnVNFf+95duUq1sAkaQy6W1D6onlkgDAtbuj
 4nDMIHN34LE7bom+4oMtgyon8m/jfYZ3jWcDUWfqfnPh2ejvb1opGSnmGT9ov4tJDTEv3puq3eT
 C3rbITfwmSa7SaMs2WQFfrJZAR1nZwQSkA+p3g==
X-Received: by 2002:a05:6214:d4f:b0:792:51e1:b85d with SMTP id
 6a1803df08f44-879dc797709mr45458756d6.27.1759506012716; 
 Fri, 03 Oct 2025 08:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNfOkGD3TCo+TPeRbFf/Z3pB2+gETbBeNmCKJMSZ+DJJTK67+Eb1HFuB6Eidc4pwnBKpwMSA==
X-Received: by 2002:a05:6214:d4f:b0:792:51e1:b85d with SMTP id
 6a1803df08f44-879dc797709mr45458066d6.27.1759506011961; 
 Fri, 03 Oct 2025 08:40:11 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 13/45] migration: make loadvm_postcopy_handle_resume() void
Date: Fri,  3 Oct 2025 11:39:16 -0400
Message-ID: <20251003153948.1304776-14-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.

Use warn_report() instead of error_report(); it ensures that
a resume command received while the migration is not
in postcopy recover state is not fatal. It only informs that
the command received is unusual, and therefore we should not set
errp with the error string.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-13-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index eb2a905f32..d145e7b1e5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2334,12 +2334,12 @@ static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
     }
 }
 
-static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
+static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 {
     if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        error_report("%s: illegal resume received", __func__);
+        warn_report("%s: illegal resume received", __func__);
         /* Don't fail the load, only for this. */
-        return 0;
+        return;
     }
 
     /*
@@ -2391,8 +2391,6 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
         /* Kick the fast ram load thread too */
         qemu_sem_post(&mis->postcopy_pause_sem_fast_load);
     }
-
-    return 0;
 }
 
 /**
@@ -2647,7 +2645,8 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return ret;
 
     case MIG_CMD_POSTCOPY_RESUME:
-        return loadvm_postcopy_handle_resume(mis);
+        loadvm_postcopy_handle_resume(mis);
+        return 0;
 
     case MIG_CMD_RECV_BITMAP:
         ret = loadvm_handle_recv_bitmap(mis, len);
-- 
2.50.1


