Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638B7CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RrQ-00050G-Up; Tue, 30 Sep 2025 00:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RrG-0004nD-RJ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RrA-0002tk-7l
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrUD5lf6tAHm8WITk9QYY+K3/gMUJ0Fyx6x74O1qOwI=;
 b=SdkVmgk8MInEJA1GwTKZM8EqORr2BTpnVTEG5njc5HO26bhfw6onydPawUpclcdPAz/Ki5
 4LdBOrIfOQArh9qhN5QATZgG5aH4HTPAZbh8kcC5XgroLB82aoTy3COp9W8Y2DcQhahxk7
 jxCwJnHLtWYJiCSBkFFaK1ms88ameRg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-xVO_BsxWMwq6AjH4IJx1og-1; Tue, 30 Sep 2025 00:20:43 -0400
X-MC-Unique: xVO_BsxWMwq6AjH4IJx1og-1
X-Mimecast-MFC-AGG-ID: xVO_BsxWMwq6AjH4IJx1og_1759206042
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b4f93fe3831so7414809a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759206042; x=1759810842;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrUD5lf6tAHm8WITk9QYY+K3/gMUJ0Fyx6x74O1qOwI=;
 b=QrEeIYIsvqvA/mhc3Ebnath2pKs/FSt3WOXuOna/fHJurBcWMgfvdcN6v+Z15zDLHg
 ZLyJtb/fpXugu6xmXC3svQU0i2gvFHUvdJaZLcg6IoCLhXTqq2MIx9wxtw4VGfUaXFRH
 TaqdCJw7CsKtXf5DDINOoObT0+FPS2kKoPMvAbqflQvbpfJ6iBHnup+o+rncP++3zNqi
 51u5N/TBFQi3m8dCRAoJrxknYYh+TILFNq4VfXLpX/MIugJTdM8eLwTbcGrk6XMEhWCp
 nOh6BjuBguGtuIt4iRZnJ7nGV8nWj+B16hGDgKraMcIVM6L/1+3Lz0663EkUAdpNCYJ9
 PU7w==
X-Gm-Message-State: AOJu0YwhEnlAYGO2E0uM7YTy5zOt41y6PZw63+DCqaPfKZ+mnksQg+0r
 zmpZdc8Oj1eSgbWU5MnZxwlbUQcHUSCUQkBZqhQUQtJ7lO7zQhlXWYuucd/9hOaZqr8GyrsZ3z6
 b0U4PBLD8ih36DU9hpBkyd2xgUJSM6k/THJCMBBB5orI4Fp8oDffmlIgl
X-Gm-Gg: ASbGncsa6EZGEaiQE4FZ2jY0uLO0Z2Qr2fET+bNjsZ+GCFSxGSg7BNJ31Lam7/CCTIl
 7zEiEoO1SPwZ1AynMUurcnTgYcIqylTSJ5KNIDQV0h0gw77kLjAgak2uFjfhWUtb9CgRMBRYe2W
 +KVhMNt6SmL9ygi2UpE7f3nj9RxNb6bgyTUN68c5idhqYECck+cb7844PMdTtZ7WHaebzHZf+zZ
 86iTnuhW4SU6f0bgJss4gAhQe5IWGDxb+gZSwBNWhR+7xJU42b9OIb65e8w++KzPrClIVyTEfKQ
 fdvdL7HdO0DGAyhiGHPrPRGX/1jOPyobDRtT0XAJJIO5WA49+pf0YNNnrA==
X-Received: by 2002:a05:6a20:3d08:b0:2df:37cb:6b7d with SMTP id
 adf61e73a8af0-2e7c1bd0cbcmr23349148637.8.1759206041998; 
 Mon, 29 Sep 2025 21:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFku6zSDp9+LO2Obuu12aHqDuJXSKIl/YwVmwKh+cD+/P45ohePuS8dA6jxCOgLYvNlsE+h8Q==
X-Received: by 2002:a05:6a20:3d08:b0:2df:37cb:6b7d with SMTP id
 adf61e73a8af0-2e7c1bd0cbcmr23349129637.8.1759206041644; 
 Mon, 29 Sep 2025 21:20:41 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:20:41 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:22 +0530
Subject: [PATCH v15 13/26] migration: make loadvm_postcopy_handle_resume() void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-13-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2155; i=armenon@redhat.com;
 h=from:subject:message-id; bh=CsLuncBihtMLZA9HzPd6iFxu43uveu3nBLMn7jx6xmo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKMGGC8L/yy3XPtE/sPr9j+DqL90sWYIaC1y3GmQH2
 iXInGntKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJEgeYb/wcef7qjQinUImThl
 UhHvuh1+R6cZv/x62dO19XnFuSrhGkaGExKFdsHKZ4/WlRoJnmhN+BGxfXWBpxHnUfekoDn7HjG
 xAgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index eb2a905f32eabccf56f3444d0705409c7d765a0b..d145e7b1e55942fbcca57cc309327958526a6514 100644
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
2.51.0


