Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6A7C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMWM-0007Wf-QP; Tue, 05 Aug 2025 14:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMVG-0002SN-F9
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMRG-0004cS-9z
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tugtLfDHs8KwfJFZEQdUUwiLj5Ix7NdURwlIQi3EhOw=;
 b=ZKt5v2rllNQOE0ITyZRvTrWx6UzMXBJmCojXHHQt0Xl6ZF8pxINCIM9J9JFd7y3BDRARXa
 ag8UuZCUU/W25KUdd4fC0EeqJHbDo+T8xB+ciA8dLQXuL15dlU6Y97V48dwweN5xC6tZAh
 aHwATg49KZKQpbveGguaOmrXlcKiaMY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-KS5_4e1vO5OYXnvcJOW0jw-1; Tue, 05 Aug 2025 14:31:04 -0400
X-MC-Unique: KS5_4e1vO5OYXnvcJOW0jw-1
X-Mimecast-MFC-AGG-ID: KS5_4e1vO5OYXnvcJOW0jw_1754418663
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24004ac2ecdso82625275ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418663; x=1755023463;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tugtLfDHs8KwfJFZEQdUUwiLj5Ix7NdURwlIQi3EhOw=;
 b=tGbS+IBYsJd5/rancoLoG/m4xz37+noFBv+YB70MswWvU2D7yintBz+bcJz5mL7hIX
 wwoTubSPZa2BFvXylLAPMGCTeUMMrOkcZNiem7GBpUFogUKaKg15WjCuf0h66lSs6ig2
 7PPQ0oWTPmNf93VffKZo00Ee3u0hTaZj2JrZ+qmVJ8g8BXEMJ13YHpv5emVZDH1Wd4h0
 XzQOAEViTB9hz8hKcd16e2kYfstFGcEQDp3hcz5KI+xb3GurswduouYjiKJh3WzI6XR3
 yR/fTlllOYIi4N48Uq0siIyloo7KOqyKz9gg0mdL32xasG5qZgKdkKhljEPuB5ukkRjK
 CGig==
X-Gm-Message-State: AOJu0YxA0V8bbdC/8F9mzNAllFE2Ni4y3z89yTcPczr93ZixdpKnOfej
 /yb32/Mue92f767QKXPRVNuja+bd8NYkWr305IKOPfhrWv8OCzZELFJg++4vLDBRmPfBW6SAti/
 0+nlgXTgwCm2rJ2it2vsE5q7qFXdpK6iqZv0P1hcWkmMTlZSvYrU5DshP
X-Gm-Gg: ASbGncu+5SnEenVIqsxlxYAtyYfIuX9cxTh65Kstr8VtB3A9qBGjmmgbdendu5Z0qL3
 6Q0JS+OwKzz4pa4d1ioiGIFFzHdsCSRMNDpIPdLENXGtXGfcHQ7715An4XAPRRAfgJQ9aOO0g4s
 6v0emSDHhdXoJ6lnFvA0+Pr1bMO0nz1V8vfVmwamuwQDSlREM5xNx9zBHKl/ZrnOy0WuqU4ipmh
 +CWAxUZU0Ct5EurZbI4nAMOHhX22+XwlyDX+1qasIAwwcqTa8ZUvV+GTy35dU7JUmBLmgm1b6HL
 I4OLGw34szArWcX/cqHS3I1ap3ru+RtjwqxPTV14hUvQFhdd/w==
X-Received: by 2002:a17:903:2f89:b0:240:1953:f9a with SMTP id
 d9443c01a7336-2429f1d9ae8mr1583435ad.2.1754418663061; 
 Tue, 05 Aug 2025 11:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVJqb7wykthF/9LH+CDINP7viuvzFmMyxXeTVcYCZt37LeI7eXnPSoYUSX3p+JLdFB5WT06w==
X-Received: by 2002:a17:903:2f89:b0:240:1953:f9a with SMTP id
 d9443c01a7336-2429f1d9ae8mr1583035ad.2.1754418662615; 
 Tue, 05 Aug 2025 11:31:02 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:31:02 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:28 +0530
Subject: [PATCH v9 21/27] migration: push Error **errp into
 loadvm_postcopy_handle_switchover_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-21-123450810db7@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=armenon@redhat.com;
 h=from:subject:message-id; bh=WcIaXxDqhz3hsqgGVmmXRWkfk64gvb6L4XfIOd4pokA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX9ka5SLm7Ru/Wj++vWPfvnA71kMnjlbnM6/VeRznn
 jTB92B5RykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIlYOzMynDsSJy+cOmdt6t2H
 HyTybB5e9A3j/blflDPq1+Z7/05Uf2dk2HFUe6Odx+KiXdbusnFbpveuPXq/f+nnzbesTn88v+P
 +f14A
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

This is an incremental step in converting vmstate loading code to report
error via Error objects instead of directly printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_switchover_start() must report
an error in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index a6b71a958aeda31e89043f8103bfe2fc89542fb5..c89fa59161fd1c4f20d0c3f8f14e86f014223dd6 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2538,7 +2538,7 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis,
     return ret;
 }
 
-static int loadvm_postcopy_handle_switchover_start(void)
+static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
 
@@ -2551,6 +2551,7 @@ static int loadvm_postcopy_handle_switchover_start(void)
 
         ret = se->ops->switchover_start(se->opaque);
         if (ret < 0) {
+            error_setg(errp, "Switchover start failed: %d", ret);
             return ret;
         }
     }
@@ -2655,11 +2656,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
-        ret = loadvm_postcopy_handle_switchover_start();
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_switchover_start(errp);
     }
 
     return 0;

-- 
2.50.1


