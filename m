Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DA3C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHPq-0005K8-8M; Fri, 25 Jul 2025 08:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHPZ-0004WW-IL
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHPU-0000HA-UV
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/bRxXSXdvpmnYEcHoZw7NYIBt9Dlm830fISQSz5x0Q=;
 b=GhEL6I/aY1AFqKIZG5045Omq6xdd0muepifPa8GJw6SWvb8aNGZhbbsMZ5/IkfSHW96jvi
 MIe8sM3JznHDvNroNE5TCCm1n0JrCS3z7lsj9fEvjEn57GNxmZOgm8h/Q/j9zNAQIrxfdr
 EfTdCaNuMD3j0wvkVmk8M5w3EuwtghE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-XwsOIT-sOKODBKlu0CfDuQ-1; Fri, 25 Jul 2025 08:20:14 -0400
X-MC-Unique: XwsOIT-sOKODBKlu0CfDuQ-1
X-Mimecast-MFC-AGG-ID: XwsOIT-sOKODBKlu0CfDuQ_1753446013
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b38ec062983so1443720a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446013; x=1754050813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/bRxXSXdvpmnYEcHoZw7NYIBt9Dlm830fISQSz5x0Q=;
 b=PjmeYJKNRXlI0iswIHABjhlpe0PUCuh6iK0hNcoKFJjDzoGrB5BkjWZXVdR34X+cgH
 LwNWQuPkmmtsWvFw16fyXozIGCHhVLUx2QuYjIv0W/uE2RxeFFPkMRydqlwJs2UV1mHN
 7MF1tVYOKYnWnD8/EGUTGnYJV6g4+ChxmeogK5it1vII2LXn8uGqagPOq4GDGUZyRE4g
 +1UIMJymVLSDj+ZLEvnjMwh8BP7ztpgvElFrdNZUGWq5AfndJFC7rtw/31rW5p4TJnV5
 pKbP+hEZI3Zm9PNtit+4UYYCWONLVTNhlj2Sm0kIMGlASnx4KyfIfdFRT4VPAMqps9AN
 81fw==
X-Gm-Message-State: AOJu0YzdwNG7piBCYFyEwVGX1iVKgzznLSR/hvruqE7UEUA8HdeT2vZf
 Ri5xIGHXiabSFYopDzY40zPfFvkmkKFqxZMQ6DXEfGJgj+bzVkDEFcVrKGXyvx5JmmFLiK+w0RW
 tpiMT9S/1LwFhfzjK4Ov1i51ohV+XRivQOVPSFEUyvhm3OSIB+fUr9Jua
X-Gm-Gg: ASbGnctDHcigrdZevNX41rvlRhyupcZDo/G7gL8+jMKcBZv2AJ198QxJSr+yOf6CGsh
 MBtWVcwvAUAIrGqECgqpwTn7fsmEZnVElrxXzIr1asj+Phr/evpUsopx1thVnfgK17GL2liyuFt
 5ASbw9mhwynTjNFB+8RKRdLPVBofMgg00OiP7fl/xXG4bZqSDgf+bfmvzMGpnm4uva8kHjq5pVq
 bC/yKKl6fQ8VNlStYRXqxlL+2ajzJfJ+k0NTD53dpc7qfTcoU1bC9HH7Is2QEyaokUZrqgpU6KW
 aas/GX7GMsowOoVls2FjqetRN9ZKZ5asBScl3fuWSRxJXblN1anIYQ==
X-Received: by 2002:a17:90a:d40e:b0:313:31ca:a74 with SMTP id
 98e67ed59e1d1-31e778f7826mr2700255a91.16.1753446012800; 
 Fri, 25 Jul 2025 05:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErgGQqX+8qSN8HP2D9wG1sZ0iEjoIeE/wEcZnbmLQRRxkBBDP11OJXj8kE/5MWVlKdfDCIMQ==
X-Received: by 2002:a17:90a:d40e:b0:313:31ca:a74 with SMTP id
 98e67ed59e1d1-31e778f7826mr2700177a91.16.1753446012311; 
 Fri, 25 Jul 2025 05:20:12 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:20:11 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:47 +0530
Subject: [PATCH v7 08/24] migration: make loadvm_postcopy_handle_resume() void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-propagate_tpm_error-v7-8-d52704443975@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=armenon@redhat.com;
 h=from:subject:message-id; bh=oAgONcyO1hsCxg2sA52HwUdxYnvOBShzygXt8RSP+TI=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0ZzmXbwNJEYVqazj+9nLUiM2Hu6r4Z33mtrMbGzq+rVj
 u6QFNDuKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJE9jAz/M5nT3tdfdX/NpJ3h
 3CBxn2vH5Cd5TivnNW2YkiIq9XDrJYb/EU2BjgKLjyWZrPZoEvlk0G4WrvdBOepjvcMJda83H21
 YAQ==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d8f5f1966fda831899596173f20fbef25d78829d..ad96da3651b89023e4b70ffeecab46d176bae6f5 100644
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
@@ -2627,7 +2625,8 @@ static int loadvm_process_command(QEMUFile *f)
         return loadvm_postcopy_ram_handle_discard(mis, len);
 
     case MIG_CMD_POSTCOPY_RESUME:
-        return loadvm_postcopy_handle_resume(mis);
+        loadvm_postcopy_handle_resume(mis);
+        return 0;
 
     case MIG_CMD_RECV_BITMAP:
         return loadvm_handle_recv_bitmap(mis, len);

-- 
2.50.0


