Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EFACAC5A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGVv-00051P-AO; Thu, 18 Sep 2025 11:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGVi-0004cc-9T
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGVg-0002yw-K4
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wm02YWFPgXK6tLalWRdl7gepF4qWtk92F6eyDxpJHBE=;
 b=e21f0Uuj0BcD8S04Nr5IRolzvaEhaJ9dWCehbp3IFXKs5JJPnfg3eKLEJvCDqELcNg2uWM
 k/uNH2adTpHwSmvKb0vKph89Ks6bXpXoSVUjwHuA2W61hErsfiHM3EuvSi/GfiOoZyp+gP
 qFyVgVKuy6r57kMBSksxXh5tzMM4R/U=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339--oGhrJhtO_2KbfK62k2ZvQ-1; Thu, 18 Sep 2025 11:25:22 -0400
X-MC-Unique: -oGhrJhtO_2KbfK62k2ZvQ-1
X-Mimecast-MFC-AGG-ID: -oGhrJhtO_2KbfK62k2ZvQ_1758209122
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-77df7f0d7a3so282799b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209122; x=1758813922;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wm02YWFPgXK6tLalWRdl7gepF4qWtk92F6eyDxpJHBE=;
 b=krbt85/kV/nMhNS2CtfwfPeA9pmoCH8EmMA/Z5GNuPEXT4nUcht1s4Qp+AiFkMcYm4
 hVZ2mvYF0ul1s4KHBywbX9qGRKdbhUetSJoYw0Pz6FpAAsYnyKW3ynaJQtDWUdVnlfWe
 GIuBmUjUNFSmfah84ogwNUOvnXKAv56k28I67H4ExNSXmNxuWDmH1avztodqCtqfe+cp
 LieQwk2ROJaCRGJkRuqQndNevhXO7IyWqo9Z9ZP01aSdQSmn+ZRRNFmG9o7Xm/sQSg/Y
 RwpM19UKqRy6C+vzg+e13Kxzhy6NQxvUXOFA01nEftFqk69CKM0RNhHGSvhOhIymZiDB
 +5rg==
X-Gm-Message-State: AOJu0YxmkK5Lz63q/xxwEFU0kBMpAWfk1aE58iG2HAovfQecqx91HBya
 vJp+M01E9wu65P7dts+xQnR49YSK/uPV7Af6ItLLtkbHjwTQBe4dwcm2pAlJRE4Y2Rz01+nd8Cd
 TUa4OkR6J5j17dAHBycgc9fG2lqyK2ejVikwc+pDfbrzNyhaaNSLfBqO8
X-Gm-Gg: ASbGncuGg487pc2n9I6rGorHGrgXzxmTHeC+9ynewsnV3k1mNewPj3c2YBiRUApH1yw
 wwFaYKaC3M9X3tWWD1ViDRQSU3negwX7yY/NbJ3LJxdQExIEpTPt75FFNEZZiD3sSIGvHyKO91S
 cajPDMc80kQLN1zzcdRE1Ueda2BffHm9l3iQw2dbTfu0vB/P7FQ0/kyJ68AMtF1mMJYGTx5I2Tg
 9okOeQm7V0j9kJt5isCjH4JVCumlttKCookNaYJ3NhorZXvGOz5RXB8cfizRrazV+D52ut9v2vF
 WnBwgKMWN5ZCQp6X/ucLQRKpEQrongtnOskNdyv+77oo8etvOgYuow==
X-Received: by 2002:a05:6a00:3e10:b0:776:8bcc:f1d5 with SMTP id
 d2e1a72fcca58-77bf77bbe00mr6673483b3a.10.1758209121257; 
 Thu, 18 Sep 2025 08:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuO9Wuwk1h9gt9j+0DHBVF1aFPzs1mBWlURDBqfShlqhbA2ZqM9bnNi0ulWwJcH8LI9m1phw==
X-Received: by 2002:a05:6a00:3e10:b0:776:8bcc:f1d5 with SMTP id
 d2e1a72fcca58-77bf77bbe00mr6673426b3a.10.1758209120775; 
 Thu, 18 Sep 2025 08:25:20 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:25:20 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:28 +0530
Subject: [PATCH v14 11/27] migration: push Error **errp into
 qemu_loadvm_section_part_end()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-11-36f11a6fb9d3@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3094; i=armenon@redhat.com;
 h=from:subject:message-id; bh=CgLPVCj6slw8FkUxePJRDJzlIhYmWPhKwDSIMzJ0/CA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5e8NP5ffiNZ4t8pJ6r/z+eLVCzJn+yzrZXr03No09
 d7Et5KrO0pZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAEzE8B8jwxJRMzlJrbjPwtMv
 zJ0onafvUP80iDX18bXTl/bPe1nbGs/IsEC5LvEzn/bWTKH1n5N25UvFvCstejcrtVHCwONlt1M
 9OwA=
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_loadvm_section_part_end() must report an error
in errp, in case of failure.
This patch also removes the setting of errp when errp is NULL in the
out section as it is no longer required in the series.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 01e1a9739aa784d90f80bf2b561fd62f5e4678f8..c8234f2ef7f413b207aebae7192c82f1f4d6d91d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2803,21 +2803,19 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 }
 
 static int
-qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 {
     bool trace_downtime = (type == QEMU_VM_SECTION_END);
     int64_t start_ts, end_ts;
     uint32_t section_id;
     SaveStateEntry *se;
     int ret;
-    Error *local_err = NULL;
 
     section_id = qemu_get_be32(f);
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read section ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read section ID: %d", ret);
         return ret;
     }
 
@@ -2828,7 +2826,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         }
     }
     if (se == NULL) {
-        error_report("Unknown savevm section %d", section_id);
+        error_setg(errp, "Unknown section %d", section_id);
         return -EINVAL;
     }
 
@@ -2836,9 +2834,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, &local_err);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
@@ -2849,6 +2846,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Section footer error, section_id: %d",
+                   section_id);
         return -EINVAL;
     }
 
@@ -3108,7 +3107,7 @@ retry:
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, section_type);
+            ret = qemu_loadvm_section_part_end(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
@@ -3132,9 +3131,6 @@ retry:
 
 out:
     if (ret < 0) {
-        if (*errp == NULL) {
-            error_setg(errp, "Loading VM state failed: %d", ret);
-        }
         qemu_file_set_error(f, ret);
 
         /* Cancel bitmaps incoming regardless of recovery */

-- 
2.51.0


