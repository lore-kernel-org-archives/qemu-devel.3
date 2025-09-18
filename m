Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85D3CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGXP-0001dI-AT; Thu, 18 Sep 2025 11:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGXF-0001MD-Sn
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGXD-0003Gm-Uj
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRbqiAPNISkqVRppZsP2Vwbcn9nh/EQ6BOnJNHC9Ojs=;
 b=hLV58RsgzsezSpk6ucySqGdPJanP7mTHrWgaYJwozKarsQwr1ohH3++W3ClwvwKnlvSGtl
 6mScdGHwBdT58kFqD9Kr4ifhe+kBao56lRkez4oOLHb+v8/uyDt26bfx4UT6NQJDlw1iSV
 6JX1dZWJO09k7T3+0pJ1QkKcfigS4d8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-UKIscowsOcKup7Jq1z2Jcg-1; Thu, 18 Sep 2025 11:26:57 -0400
X-MC-Unique: UKIscowsOcKup7Jq1z2Jcg-1
X-Mimecast-MFC-AGG-ID: UKIscowsOcKup7Jq1z2Jcg_1758209217
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-77b73bddbdcso1244208b3a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209216; x=1758814016;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRbqiAPNISkqVRppZsP2Vwbcn9nh/EQ6BOnJNHC9Ojs=;
 b=GRm0VeVfRMW34nx1mPxEkHubLQvwBxJwV2PQ5hHgKDDeiTiyIW1vy9+QgcbwET6/MM
 jMcYXMj3y+ok0RDnGpnfk7Nl//xqGFM3ajc/7xFiIazQEV1/ah76XGHSIWIv2coKFR14
 MMBGXAV3I3nRUIwu2I+gqo1Zm55urppKIMBE3oqkdhbLqrTSOhWx8LoKftEMNv/y+G3g
 xHEGvJJXzFyrVDcG9sez+VmOylZ6xRf52QJ/2ZcDpwOTWg85ltIxrzU0Jy2HLkYzIOw9
 hFQMl0RrRyvChB/6NLFMiM17pJvEfL5WjPzDaVZ7NgCUsVoKtspXVI2xtLnU1lwlwaR9
 TPaw==
X-Gm-Message-State: AOJu0Yxo6lRtCjOSkeJSuMqVIyhOsLLqAu/7eoS1H0SSnZMiJm1DSYRs
 8EhQCQ1BeMKFh9QYJiPsTJCrUEGWXR3XLQVVN746U+x75qTbTlrKVRpdyw0PYNdlDGRbPLlA7VV
 UH7za2i3zBJgLNcdGsxPN7wWBneWod4qSuUDSOof6rY5Pdk3AoF/v0Vrf
X-Gm-Gg: ASbGncuL6UvqXF6nnp50r9NCFQ1aN5svjzHg/rhdiiEm5zPO4Haes755NeVeWMdiQRf
 Kp3KPiT/vOTw3biUqm8ZlZQjzKVEDKDXsQSk+mWOMKGHGHZ13iTQBfogirw2SydNOGsb7ILAjQY
 72xpThCrYab17SJtjcpUH6W8kQBJj6HYinNA3h9dDKiA5mtdK0PGNtV2x/fIjXCV2uCcmiAPHPC
 IaFvLSlNAPsZZLxnY8UsuyU6X6cPVh+ZzTsXXbI4vyp+Ht2TZ7NKZaf8601vbvK5hwmnnWUwZ25
 0FYz/yF1wzxowPXpIID0x2Agb0DAGNyCAtarD7uczwF28V/vgPLDjQ==
X-Received: by 2002:a05:6a00:4a07:b0:772:6bee:9ff4 with SMTP id
 d2e1a72fcca58-77ce050d597mr3208402b3a.5.1758209216590; 
 Thu, 18 Sep 2025 08:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGr6LusWLuwq56qkztQyHByRvQKkTaC4b2GsSVfCnPWR844zG4OWuIeFom70xJ6zhMmcOYDQ==
X-Received: by 2002:a05:6a00:4a07:b0:772:6bee:9ff4 with SMTP id
 d2e1a72fcca58-77ce050d597mr3208366b3a.5.1758209216201; 
 Thu, 18 Sep 2025 08:26:56 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:26:55 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:39 +0530
Subject: [PATCH v14 22/27] migration: push Error **errp into
 loadvm_postcopy_handle_switchover_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-22-36f11a6fb9d3@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
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
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5R+9DVsYDwv83SW99QGn/x9H5rUSensNNm8+6+azl
 2npU6b5HaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACayQIDhv49xHq/2s0vbt0xL
 knfflBbaml+te/7zKRuP9XuPnmMubGT4zVan9vyhxJtH39rk90k9nXdPT8flvd2Rjt2N3gvlngf
 u4wQA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


