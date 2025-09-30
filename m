Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4F3CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RqQ-0003Km-Gt; Tue, 30 Sep 2025 00:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RqA-0003Ag-Jb
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rq2-0002Lj-KI
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759205980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/BHqQEys25VDInV4tMhybM5zLRTf2PUynoguPJtWYxY=;
 b=bh0ar34ODK9Ru671v6AC9cVtSrvCUWVYSSiQP58FGvX/TaQIFORHsoW7i9adSFpIczTBAM
 3/bT1L1a/9BpgKKdzi0/IOQuqlIz+iwReqQ1VvklwMyM54dx9+wvtBz4fin1vd5tPKrdh4
 VPxlOQHQBWRZPzhbhwnZvP8f6axDsME=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-4-Ol7KSbNfWY7I0f6Ej19Q-1; Tue, 30 Sep 2025 00:19:35 -0400
X-MC-Unique: 4-Ol7KSbNfWY7I0f6Ej19Q-1
X-Mimecast-MFC-AGG-ID: 4-Ol7KSbNfWY7I0f6Ej19Q_1759205975
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-33826e101ecso1779268a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205975; x=1759810775;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/BHqQEys25VDInV4tMhybM5zLRTf2PUynoguPJtWYxY=;
 b=P5R0Ze+QIveR44Km6BCRnpa4naFnrm6nrCkiF5HLKbxDgjtBMyrh6b2fdvlr8wo1Hg
 mCZTt9ZPiWLY+zTWpyULjOEx8VwMtzXP2pfGZH7hKICOiqWl7ApJqp1gTYX35LmlyiER
 mQE1kOV/ldgZCKeYsM6feDBnuVJq1r3KufwEZ6Hv5MsuolOkTPaOB8fAsD9sZlkcYC3s
 Ln7lTMO/JhpyypZ+VCMgwfUwLaNwXBQPU0sqwGqWxdw7srgIbMht3foqUPtLKvC3+FBt
 LgpH2AnQoTPhC/bt5wrpeZkyz4mYlCt7EVp04YI00M9RP7uWkF4NOjwaLg3PPc3oIUgs
 oPfQ==
X-Gm-Message-State: AOJu0YyIGYS94btPCZeXudFWK5R84YDWUReQ/QqNTy52NwcGrlphhHgG
 /ABVjfqZtF6mc4BzIB+GxCLKGKP7U+ZPPVw0Rcm8E9mUSFWQ/MGFcu/Bm3lmolsjFvNZamLoGUd
 VXyXRn2CUOx3M8B/RlkmdtpeDv6gDQFQcDEAMzCgiL8lDjP80P6qnlhYM
X-Gm-Gg: ASbGncsuU810Sg5haOjjZx9bxLkg1LAeJWHPLUx49aCE9BNBqMx1Dl/T2IptTQLGCA8
 dnewjG8h24veNQkHQx+i8QUuIw+1HGrwamT5+nnTJCIu+1xhkDC+epJcoO/Lpa4h+Wmob/fvZ0Y
 f9NQOwAfx4CWzYOXBx6yl1GyWvCqePLWnJkCVDmRqoRPprgA87yhkGhXkgj7ONQJprkzjo/wKpb
 6T8Xi15pn4Mm8rqbsuonIHb7uVUUEREsDH8qZKtj5WC2fqfk30+NwT82gl15rVIF4KzmHS982BO
 Kw1vmkG5za/vSCtYcQAjNK+fWDk9S+osozDleykBThyqdLl1BZkweQaSKQ==
X-Received: by 2002:a17:90b:1c91:b0:32e:7ff6:6dbd with SMTP id
 98e67ed59e1d1-3383ab1c984mr3496662a91.0.1759205974569; 
 Mon, 29 Sep 2025 21:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXzWjh8kDSfRbxRfoZ8if5oeGKLB+2WXfzJD5pmOX4dsz9fTSVxA8skyWa/XTLmNA1bKeJzQ==
X-Received: by 2002:a17:90b:1c91:b0:32e:7ff6:6dbd with SMTP id
 98e67ed59e1d1-3383ab1c984mr3496535a91.0.1759205973793; 
 Mon, 29 Sep 2025 21:19:33 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:19:33 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:15 +0530
Subject: [PATCH v15 06/26] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-6-84afd3af1e47@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2872; i=armenon@redhat.com;
 h=from:subject:message-id; bh=InVVNoEy2g1zpO8kJPGk7ZyyaFhdbz8TWnnxAHWCl+M=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKAGOyNi4jK7AWxO0189LbD131vnj1J0iO56taX+2L
 XzGprXNHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACaiwMbIsEYrqF2L6fKz33PD
 WBMbQnOKLlx6aLXI6EbVE5VTZ6U5xBgZ7hxkyNUs55pmfvnxZHv3khnsic8fMjRwZDK1ZX56O2E
 pNwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
It is ensured that loadvm_handle_cmd_packaged() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d1ed2e1cde54913d7fcc4b6808d08cd5b3a17745..5e54651652e9562939e61cf488c809a369824edb 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2405,7 +2405,7 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  * Returns: Negative values on error
  *
  */
-static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
+static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
 {
     int ret;
     size_t length;
@@ -2415,7 +2415,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     trace_loadvm_handle_cmd_packaged(length);
 
     if (length > MAX_VM_CMD_PACKAGED_SIZE) {
-        error_report("Unreasonably large packaged state: %zu", length);
+        error_setg(errp, "Unreasonably large packaged state: %zu", length);
         return -1;
     }
 
@@ -2426,8 +2426,8 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
                           length);
     if (ret != length) {
         object_unref(OBJECT(bioc));
-        error_report("CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
-                     ret, length);
+        error_setg(errp, "CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
+                   ret, length);
         return (ret < 0) ? ret : -EAGAIN;
     }
     bioc->usage += length;
@@ -2457,6 +2457,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     } while (1);
 
     ret = qemu_loadvm_state_main(packf, mis);
+    if (ret < 0) {
+        error_setg(errp, "VM state load failed: %d", ret);
+    }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -2620,11 +2623,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         break;
 
     case MIG_CMD_PACKAGED:
-        ret = loadvm_handle_cmd_packaged(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
         ret = loadvm_postcopy_handle_advise(mis, len);

-- 
2.51.0


