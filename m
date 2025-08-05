Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34ECC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMUe-0002Mz-RH; Tue, 05 Aug 2025 14:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMQD-000083-5A
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMQ9-0004Eq-1R
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZTX/SUHTw4T4A2lKDjmLG0aCTOrTAcJZ1w0sIZxspY=;
 b=USFo1VzBkJMx5UG8dZCL/UPI4eMx34p4Pzaf2i++pUzd4GiQo1E2ZwoUbKcARfOqOYs9XA
 At3rArOGc42ukHmh42mZWm/0ZZNILZgVXagkIOV+wAMfyy4h/I9xiiBzaVp4gIbrlDfIG6
 nzkHmqEfCFw9Z9s54nRg9siGCloI3bU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-iJ4W7IILO6ymvp3JzEVYHw-1; Tue, 05 Aug 2025 14:29:52 -0400
X-MC-Unique: iJ4W7IILO6ymvp3JzEVYHw-1
X-Mimecast-MFC-AGG-ID: iJ4W7IILO6ymvp3JzEVYHw_1754418591
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2400cbd4241so82484785ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418591; x=1755023391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xZTX/SUHTw4T4A2lKDjmLG0aCTOrTAcJZ1w0sIZxspY=;
 b=vhdjynPWlF42tBOSBX/9T1gLBlASoEP9NJUoMlOYnj1JOIhgu6QQQpCFkUKScNNjnj
 tJCdkWpRiIAmBrQPva39FPyAilYiPoTMpgZtsRyLLceaqYYKKaphM19RDaql6RdNWjYz
 kggAxF3SYZw1jUym6MeUYv3W+PH4MrVfKYpRL8lWDX4vUIP8L6BvLRAl3M9ms4EwYz+n
 3A+d2Xh5yec5JxnK5In9OK4UpnXPNqt+bZM91JJjRVrxilEPF3FO1iivAQP0LVrnxCgg
 QBXHQp4piedyaSuZLblzhNFtEKo/UccC4ZgsTPTMWsqFE4lFOXKMpowb0vZY6x3pxTzf
 RHtw==
X-Gm-Message-State: AOJu0Yx+8lMblBAozNWIPo5+YQVJMe4QxLZOOB94sukQKSj7w2rq+Vb8
 3VeX9rt+KxEa7tClkIiIZvZh9ocX2de/woKgYj7NcYIOZL4vP2WALwGs5lbNzd1OXlP7HUF6HbE
 qjOFdTgAbyCm1zSR4+XJk3zyD8nZYBWhXa7fq9cmFiTBGOmt/B7CXBNra
X-Gm-Gg: ASbGnctfJivKzne34BDC0xqzdtPqS2OvsSCYwrR81icvMWiWO/5drd68G3YRRM0EfHZ
 xCl171gu8LWI6/Kiihb5pKNJKpOmdAhQT5LgfI9lZt+8PsomLeyigl4YyxGp8xdHL6BboE/ic98
 3otXJnq7YK4eQBQ/G05H5OMiR6z5A0aoDoZUmVQ+38Tw5yggv97cSLbh0DRu33tWvaLmCFdA5w7
 sgABCtHEwcuihLhfcEHW4nrUg+Ycxx1dPe3UMNHZF7juRa1BnazSsuCLBRD9QE+Td174K7ZVcCp
 VOJXDv6vp5vgcGpXaM1i/uC+KRG4CW5lxS3KZczmRli/VyRfDg==
X-Received: by 2002:a17:903:1b4d:b0:240:5c38:7544 with SMTP id
 d9443c01a7336-2429f59d791mr770615ad.50.1754418591183; 
 Tue, 05 Aug 2025 11:29:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfJ6PTvfEsWtm+rBSHZzQ8eHlnkfVtL9qFvTicnPsucIsBikxvMNNAqyClvA/RWAgX+PZ9RQ==
X-Received: by 2002:a17:903:1b4d:b0:240:5c38:7544 with SMTP id
 d9443c01a7336-2429f59d791mr770305ad.50.1754418590841; 
 Tue, 05 Aug 2025 11:29:50 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:29:50 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:20 +0530
Subject: [PATCH v9 13/27] migration: make loadvm_postcopy_handle_resume() void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-13-123450810db7@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=armenon@redhat.com;
 h=from:subject:message-id; bh=P7iwYC2/YwpuEX6VmGoFGQyEuB3Mm2xzs+nfJGhPeRY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkXxmJP1+zbc7EXM4WW+0yj+2ZzsaZs0Xk1xrH167qP
 M/7aUdJRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIlwFTP8LxJ+d3f6jaDIoKWi
 3TM3TDWM3no6cU4477xZFb/mqdw91MXI8CaxJPy7Wi3L9uZHq0rei1+9l2T3gd+sXrHzlkXy/aY
 HnAA=
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
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b6b3f3fae742ae9d72d3af6e68440e14ffd30b0c..3517609ac661af618cf4d97e7f8fa1ef2b64bd4d 100644
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


