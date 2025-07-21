Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A0EC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udooL-0004oA-T9; Mon, 21 Jul 2025 07:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udokq-0002p2-FP
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udokm-0001A6-KY
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/f6UP9sBy6SbL+S5EjCbNoztA4em6pGbHeWM92+jUM=;
 b=NmZ4njgxHVtrDAXSQM4PEkYYTn7iE38+09bKMMt4QgKrfvqL3It+9uwX0gwyUYe+JoBdCo
 5xju4QdmE1sb+1ITf4pQaySqOwPGdIQr6s2Pr0roVRYaJRwra6plkocGquaa1jzDeyZXFd
 CahlJ+nAp1wM5Dh8Y8F/83TqgKwCKhY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-1zWU7FHcNPOFQ3vMU2ZraQ-1; Mon, 21 Jul 2025 07:32:08 -0400
X-MC-Unique: 1zWU7FHcNPOFQ3vMU2ZraQ-1
X-Mimecast-MFC-AGG-ID: 1zWU7FHcNPOFQ3vMU2ZraQ_1753097525
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2369dd58602so32947765ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097525; x=1753702325;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/f6UP9sBy6SbL+S5EjCbNoztA4em6pGbHeWM92+jUM=;
 b=iPcuk0gh4To/fco0eq5UuLYF5+D/g42RIHiQ0wH+cWpWYdjRa0IS4Lv8oeV9fTqTgF
 kuptuAbnTcs/ZmSxaxZhspzMXpPlFKdftYQDdsXPaIfDKA+J3iF+XyuT+eyvSOtWZYPG
 GUfTrxxJwrXIuTehpID0a1QTUbwFsTZMZqkDpCx68dGWW5LnNlP+PfjfzZtQ7cucVOBs
 Om22wtZiAzYD+R8C6bQb5mXmSq7V17HBhiY/W66uLW9v502psjM0fjeHIXaphM/2nF6N
 QnGm+WzT2yrIi5m26jon6+RsZeRGMe4JWSYLLZwX3lSw/+sgI92DGW/UYf2wo71x4iRz
 twvw==
X-Gm-Message-State: AOJu0YxxQrTh26wpp661y3xwiWi0/xJ9yGupmOPDTrIaBGx+k/ebxiCC
 XoS6MeCcsP9WKWY/Cgum2O8yspCU7d0o90hfMxwMYOL3Y0q8NDnV1ss2tqCHQp1oMlLeKkXbXKB
 sxYrFaC6OlFe10rfkcGXnsQNqB9ZLYVuKrcigWHNqc604qyLCwgEk1kXQ
X-Gm-Gg: ASbGncsiIYpVnTAFEt5equf6vHKEe1xa7yLoFHQSmHrkYkl3oJg08EVQIbAUeMjbnJN
 T5zITEC6tI6ITyUoDUD3itmy0L+I76Y2z3EOftuJhDkPBCw25H2qnDRdkCLIfXnT95+rYZCJjpt
 kCeoeaEUcVgnkg4P8dYI3spqWbNwprd51mHZD8XUrT1vSGXw0hjuypMqM2chm3s5oebBWNClhU8
 9kcIf65m1N4AHSorgdJPaASp2TRRnKyUIaeo4OoWr9c0HqyXHzY/boDFnpya4uWyuBMTGKuNoSh
 cVySSABWTHaovQQXHD4hSNF1bK7ZoM9bt8UHBYnS4dU85r2KI8g+
X-Received: by 2002:a17:903:166e:b0:234:c5c1:9b63 with SMTP id
 d9443c01a7336-23e256b73f3mr218889045ad.18.1753097525401; 
 Mon, 21 Jul 2025 04:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6avsZ1LangP5a7zyDdFZbeEybORwVnG7N0UbwWlKapyea8s6d1KfCiSc4Mb+66e1VRsKjjQ==
X-Received: by 2002:a17:903:166e:b0:234:c5c1:9b63 with SMTP id
 d9443c01a7336-23e256b73f3mr218888665ad.18.1753097525003; 
 Mon, 21 Jul 2025 04:32:05 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:32:04 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:23 +0530
Subject: [PATCH v6 18/24] migration: push Error **errp into
 loadvm_postcopy_handle_switchover_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-propagate_tpm_error-v6-18-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=armenon@redhat.com;
 h=from:subject:message-id; bh=T4ESedbEFaWlt3KKuF3jtYtJa1dU5jJIREayOIFOE3M=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyiSm3qcTMn39rVa2b/h83Dy4LyJv/6rCHSIBCz+un
 +dTPNOno5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwESO8DH8YrZvLKmfFVpQ3VV8
 rnfKoV2zCpL6g6cUyLUWeh3qrj69meGvnE/2DrPkJoG7i2W36L36xDUpMHTWY8vDvlMWvO84Lnu
 XEQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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

This is an incremental step in converting vmstate loading code to report
error via Error objects instead of directly printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_switchover_start() must report
an error in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 49eb629a8dcd909274e78ecb2f31eb10f57c5425..679abf7c668ea7990da10ca8caba09fbb7bdd2ea 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2534,7 +2534,7 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis,
     return ret;
 }
 
-static int loadvm_postcopy_handle_switchover_start(void)
+static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
 
@@ -2547,6 +2547,7 @@ static int loadvm_postcopy_handle_switchover_start(void)
 
         ret = se->ops->switchover_start(se->opaque);
         if (ret < 0) {
+            error_setg(errp, "Switchover start failed: %d", ret);
             return ret;
         }
     }
@@ -2651,12 +2652,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
-        ret = loadvm_postcopy_handle_switchover_start();
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_postcopy_handle_switchover_start(errp);
     }
 
     return 0;

-- 
2.50.0


