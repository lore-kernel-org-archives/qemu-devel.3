Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D077C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMWU-0008C7-Tn; Tue, 05 Aug 2025 14:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMVV-0002SN-Ht
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMQh-0004X4-IP
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w61Gnp0t2sZwEjjwtLcy7ZKQ7sSrZonMXuzBo7mvhs8=;
 b=eZ6Am3O4nnVp6KTwBRrTnjXU/VWSJ9QMgpTckYIqGElHptQ/DCupIQmff7GceQYQ9VN9dd
 3UlIIXqashQEDfZIPf8pwhP/fRhiLI+bei1OeOScgwjVGwRHLA3I2d/fJ/GUORKvQF1cO6
 8tasjNJsY0rqt7JXIAqT8F6qBMYQ820=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-ysuS_RArOgGjv59lvlzB2w-1; Tue, 05 Aug 2025 14:30:29 -0400
X-MC-Unique: ysuS_RArOgGjv59lvlzB2w-1
X-Mimecast-MFC-AGG-ID: ysuS_RArOgGjv59lvlzB2w_1754418629
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-240b9c0bddcso52315705ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418628; x=1755023428;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w61Gnp0t2sZwEjjwtLcy7ZKQ7sSrZonMXuzBo7mvhs8=;
 b=I1HfIgo/NkigGbpnDjCKMr6IPXLhm8vR/zFJYtEh3+1Q6jogGCySqAeFErgNbfRMx3
 TQqGiP1YxRtVes7VqAdrkpS7pECa0s3Lx24KPcNHGt/pViDfNe0MT1SPlDSOi5dswE6F
 eVhQjnl5k2T8WEx3iKCaGzpcwlXnzHEFm0zN8dzmzhi4nRBNMuZA0kFwDrDYpilO60W1
 rS8Y81sRbdpC9X3AkWkHTUqEOwhIUPu1d6oYxoLojSvWCXWIaHSwJfKD8CgmlDbPvhdZ
 7rcc7gd8mo0pUwC+u+TWqI0ISbIq6mLh9oRrwikSaZtvdQozZiL4HfPFG6xeif2NeplL
 cvwA==
X-Gm-Message-State: AOJu0YwFaZaliKooU6cVGDZiC51Rxg6iNgjul3sXELFQrSMxxl+EZPUZ
 Q7phU8JVUZ3w3M94LC8mBUsloGCr92P2bVMdotTB/iRoAx1tdbCYV+AABnsjbFsOtRr5R4yERgn
 d7f65WZVMoLHXJUA6zt9DEECMOcPIucAKdvtZ7FKEuNQkFBMbaZsOHtWK
X-Gm-Gg: ASbGncvFBy+NCpCT1e0O2UvTbl6v900MOShzdjDmkWwYQcOZ3d/p7zgXTz6+reSgo/v
 qgdKLyqlGr6SXIWbBaIF2OjLLq9r0YwHCBgbZED60DWyRjjH5K/CtB+BKh2a0Ydf4B5A/H1B2qL
 lvRTI0oQgiaxi8DOp3sOz8AgLAWu2jqW/IMRhdUC0WfNJkj/UgEz/N2pRDl+RtOiH+qPeQNitZx
 eImwXC/1xOV3OEnuRB6ufyHvwrNaWychn+cLyxeNJouCJfjPR56+X/KLA/rGxj1CGqFIXK9kyH1
 1ah589R5CZ4QqmIRNpi2iz0hnpAuYm/8qe405EvZzD+nZBa5Ow==
X-Received: by 2002:a17:903:4b47:b0:240:38ee:9434 with SMTP id
 d9443c01a7336-2429f6579d1mr527385ad.47.1754418628521; 
 Tue, 05 Aug 2025 11:30:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYS2luwgN+pQ3awnWNgzPwnCqzhpWZhVipt8DdrIc+fKvwE36gTQreTacXVhKrw5PZEvtBbA==
X-Received: by 2002:a17:903:4b47:b0:240:38ee:9434 with SMTP id
 d9443c01a7336-2429f6579d1mr526875ad.47.1754418628118; 
 Tue, 05 Aug 2025 11:30:28 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:30:27 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:24 +0530
Subject: [PATCH v9 17/27] migration: push Error **errp into
 loadvm_postcopy_handle_run()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-17-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=armenon@redhat.com;
 h=from:subject:message-id; bh=woHIZhT9LbzEegfZSEr5X6AfcsGWBUDyPBaEHeXXZlE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX5mXZ3ueiEkeVdn5xP+e58u555uL31ec3ikbbh+V3
 aSQtPd+RykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgInsDGdk2JnpuvHf0jPfj0s+
 7F6yJEZFz7aXN+uzZtSSki2FR+X1+BkZWuYsFdBJEFKc8Pdf67tjS/0vqF6d177ti5ARe7nbNXF
 bPgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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
It is ensured that loadvm_postcopy_handle_run() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index be77da66d813392625c6d701b24d1bcffe26cdce..eb90873a750ded354b3db31cba40b44d1be79864 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2273,13 +2273,13 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 }
 
 /* After all discards we can start running and asking for pages */
-static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
 {
     PostcopyState ps = postcopy_state_get();
 
     trace_loadvm_postcopy_handle_run();
     if (ps != POSTCOPY_INCOMING_LISTENING) {
-        error_report("CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
         return -1;
     }
 
@@ -2626,11 +2626,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
-        ret = loadvm_postcopy_handle_run(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         ret = loadvm_postcopy_ram_handle_discard(mis, len);

-- 
2.50.1


