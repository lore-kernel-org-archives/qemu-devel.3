Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DF5C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHLq-0008Dg-2x; Fri, 08 Aug 2025 03:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHLI-000763-Mg
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHLF-0007Mi-Oj
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=amzKuTkXsl7R/UHJRMqWOtsNkEHBgFBs+aAFF8D3A0U=;
 b=fSbD+IHlVQpiwRM/3PvHY1+CL1Hk1dGlEmn5xJao+7uZi1O4NAZl98TPaFzwumNVMVNMSI
 V3PeSUkHX/XXNt3tFaCKnRzZWr5f6bySCLfDNsl5IKDmz3H4tWZdd7DwdJqOP0ISLdVSsw
 CnkZZLTjgYORUCTI90c+r9n/U2+bFFg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-z8mmBUuVMC6PRk_0pR_gqA-1; Fri, 08 Aug 2025 03:16:37 -0400
X-MC-Unique: z8mmBUuVMC6PRk_0pR_gqA-1
X-Mimecast-MFC-AGG-ID: z8mmBUuVMC6PRk_0pR_gqA_1754637396
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23fe98c50daso15747035ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637396; x=1755242196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amzKuTkXsl7R/UHJRMqWOtsNkEHBgFBs+aAFF8D3A0U=;
 b=AvY33SKFhnufxqQzYLqarHFcUfjjGpzSoOFjzgCCNnUKZPjVODoYr44SJP02QVbVKI
 5SkhBjSHMnhG6VYhVmmNgeYep6YsbCWvuUbmn/scpdVP5J2evzGfrhh7Vn9tOOPwjk+1
 axr8etRdRoW/izFTqkCk9rOq2SK56ZcuR+J7bvy8hfSfLl3sU0UfWkusAb+F4V3cd6bH
 3Rt6GoFaYKOrPyTcj32xm9zu10akLSi/jL4Z+lPl7aHBbiWYYJrEsWns5tQ/OtDzcqd1
 UCSTigYbG0kAKEiZwu51gl35mU2PvdKz5+OYbw7bfcnnd0IEiG3t5BC7dRuGJ+wJj4sH
 dy6w==
X-Gm-Message-State: AOJu0YwaRrC0km4tUBbhn7TG/PoUq43Lyl8Taf39T8KyvExraiJa0W3z
 Fg83SUPtjdqaBz9o1XtAgx31bt2c54mMfQSnzMtuNkYfFLWEJggbegsWTkNmR5Y2WCuOZclpMkF
 5GVi0QCqRzyqNEz+AliknwvxDfM445+sOBOpkxNfU2o4uEmaJBtq7ReBi
X-Gm-Gg: ASbGncuTPiDzcGZY58PwBS0mFa28R3Wo1aNpOepzWqxrLVViOOkWNgfjaKmp6iQxF+c
 58NCv4v3wdMRa8PKXOPprNMjyx+GKQjivqK6JkUrpYqoz0oSqRAwboPLc7kNwJgdyHVQ52AFUyB
 O45QyxCfz/+3M0vh2/KhRYUeQMWa0DpcRmYIL4Nb/Qg/o3TKdsPInkcJuq+XJsr/sQppvNookzA
 cusT+k3SkKJYKePEHHx/83rLNHqr+qdIAth6/1HiH6ZCPJjxTmF1AtJTUVxokecIa2JiYPCDy5f
 4PENMH20+CrHB3kQYcmSvTfmUvakst+NqNn7kTkwJGIDWG7wWDTvLg==
X-Received: by 2002:a17:903:18d:b0:242:bfdd:4100 with SMTP id
 d9443c01a7336-242c226ee95mr30029775ad.47.1754637396354; 
 Fri, 08 Aug 2025 00:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4G9xBtTmqeQPtB1y5xUJut5oCP+eKxYtNWaEb7P68V/HDbgMCR5Zwu4To1SFFqeL98nGurg==
X-Received: by 2002:a17:903:18d:b0:242:bfdd:4100 with SMTP id
 d9443c01a7336-242c226ee95mr30029275ad.47.1754637395870; 
 Fri, 08 Aug 2025 00:16:35 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:16:35 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:39 +0530
Subject: [PATCH v10 13/27] migration: make loadvm_postcopy_handle_resume() void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-13-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=armenon@redhat.com;
 h=from:subject:message-id; bh=29coSXNbzWH67exh9WDq539ziVC1mp+QMBuk0dbIxOo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVfzLG5z2/Xwu3xvu1iyU9tsj8LK60pZ8St2HJ9x7
 84SoQVhHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACYSxMrIsPM5q03EzWlS3ybM
 rYz7HrxvzZJSZ42ehQ0eTh8l1lzb08nIcMdTaNv0hKecz35+b21rP6mw4PO7MytcV3ZuDCl+I2+
 zjhUA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.

Use warn_report() instead of error_report(); it ensures that
a resume command received while the migration is not
in postcopy recover state is not fatal. It only informs that
the command received is unusual, and therefore we should not set
errp with the error string.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ce5be8f0b95c798d3740d0949d468d7cbadf7020..41e9533f985b0b9d69fb704d957938e2dae4781f 100644
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
@@ -2649,7 +2647,8 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return ret;
 
     case MIG_CMD_POSTCOPY_RESUME:
-        return loadvm_postcopy_handle_resume(mis);
+        loadvm_postcopy_handle_resume(mis);
+        return 0;
 
     case MIG_CMD_RECV_BITMAP:
         ret = loadvm_handle_recv_bitmap(mis, len);

-- 
2.50.1


