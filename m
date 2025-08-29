Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9190BCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNed-0004cz-PV; Sat, 30 Aug 2025 11:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Nn-0006YV-Sz
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Nm-0005GH-Cx
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756498053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRbqiAPNISkqVRppZsP2Vwbcn9nh/EQ6BOnJNHC9Ojs=;
 b=QcYwMAB/AEJqJS8g+nlakOovtL0AFhQPMefZW6wLp90SpbLNUpS+Ahk9j0Duzpqj2PWo3w
 uryAdVueanKsUDGdASGAGE750h8nHXhyP/FzNrjrX5X+pkfOK1vz9zwtz/mYbeuZTTJ7R2
 hlLdozfz+rTLYw6Uz7X/2gG0EZ3w0C4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-913E5fz5O8apV-G2DSBk4g-1; Fri, 29 Aug 2025 16:07:19 -0400
X-MC-Unique: 913E5fz5O8apV-G2DSBk4g-1
X-Mimecast-MFC-AGG-ID: 913E5fz5O8apV-G2DSBk4g_1756498038
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3234811cab3so2841511a91.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756498038; x=1757102838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRbqiAPNISkqVRppZsP2Vwbcn9nh/EQ6BOnJNHC9Ojs=;
 b=p4K5H5+Pw9aWpo332Tjgqbi/0i8dlcqruEhqSZDUokca3pKaQ8zZOR6pWZoI9hD8jF
 7vvy+WyvHfcMMlhVs3969lIABDN+W58wTL+FIwFfd7GJNrnTE/gAMPugNQyneu9s7fSx
 Q49mFVIrfyA3NPiVp9jdeGg0zq2gjbA4qobqBCjZW+OA4Nq97A22c2JIFKXhAKGWRrmB
 pLZgsR6hojux1BRdgWevU/LsR0sHzqzbVCtmd2Fmw/oVUoI2p8r5prqB3z7AvRxC+x7x
 BI9ciiRdBpgX4eFgq32sE6vpRGieOXnjf/O1qBcpl09n8lMu037jVlF17TxSP0YyHH/9
 gHJg==
X-Gm-Message-State: AOJu0YwCuMdRwYnrfSDK94P9aUpLMqss3eFfo2GuMPjOK8plbj1HkTpw
 hnZZieVVEwW+2NYb4xMxURccp9wSXcF6XhWDw6y4qbiaJE0YXMxX4g4tklRZQA/pOd+OmwfJ+qd
 5FnumpdkUwTqE+cFnHdHksZQoC4DcaHW516vOcYhn7WQqS2gTSL/4cItQ
X-Gm-Gg: ASbGncu/idzJwI23aDe5FOJRnPA0Vt8M5645uWZi1JpQ3QNLt4oPMT+BFsglNHqacF+
 RB51DFLbj+VM9hVFOweBJwM2fRumm5MkiNEFv31KpsG/QU8M7dW8acuuBU81Bzwf4zoZtuWSmmP
 qxfgYcXL6R2GV6Xc4O923xdv7vVuMlnWAAp/muyjGg3iw9ioiCHeeB8RgJNlISW66PdWncPV3w9
 W5/u/7B+k/4Liy5bXkLou8QiRWp55qzMXPlb3q5fGNOR2Wy6VA9yImNbBCvyVIwPjBX9yIsIYOx
 7arSVxmTXA4wJaUHYdTy1ilyAS7KPzCJa6OGeFmiARh4tPaVPef2fg==
X-Received: by 2002:a17:90b:3b86:b0:327:d8e1:faea with SMTP id
 98e67ed59e1d1-327d8e1fc98mr7387291a91.20.1756498037785; 
 Fri, 29 Aug 2025 13:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSA+umRYBhjmB+zDANRnxaj/OjOFTsAMCJs0OV+MDGSzS572ruE5lu43L+hyLGvsXdaOOuVQ==
X-Received: by 2002:a17:90b:3b86:b0:327:d8e1:faea with SMTP id
 98e67ed59e1d1-327d8e1fc98mr7387235a91.20.1756498037260; 
 Fri, 29 Aug 2025 13:07:17 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:07:17 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:32:02 +0530
Subject: [PATCH v13 22/27] migration: push Error **errp into
 loadvm_postcopy_handle_switchover_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-22-a4e777b7eb2c@redhat.com>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
In-Reply-To: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=armenon@redhat.com;
 h=from:subject:message-id; bh=x/yKec8YqQYPuuXzcHNbQkCBg0poQ6E8l/qo+33kxFQ=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdr8Yab51+V9UWAP5d9l792u0vJu+bltI+nkDafeUw
 k1ex6Q7SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATKSnieF/mcFiH9s7HAKJK2e+
 OC/4svjp2a0VXfkbTPOUfJ7eXbRVmpHhnu/02Mui5yY6iMdYGuv9ehu/7fP1jZEW4ac38p3imbq
 NFQA=
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

This is an incremental step in converting vmstate loading code to report
error via Error objects instead of directly printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_switchover_start() must report
an error in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8e891243dc1e7f5d3bc3a4326c6c4a2f5c32e1a2..b0fd51d0f142c30ce21bdc02204ce947283fea49 100644
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
2.51.0


