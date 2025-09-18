Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C649BCA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGWr-0000Dx-8p; Thu, 18 Sep 2025 11:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGWq-0000AY-8m
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGWo-0003Br-7C
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yZ5qpT0ubEUqCdewMRwilIH2qM78jxpQ70y0QUZWscE=;
 b=Z0Vcy/Uu/VEbhRrnMsPGspruF1rTNQGO7iNQAYTsk76CNGrM77mvZF2Z4X+b92dtCwWxWg
 XbH44WrVOu5O2MF7idr/iGOT20JsSWbuiNi49/Zz4s3bNV/W0zUN7TyWDxc3LtqTcwstKN
 /46MFXbHSbY8HrcNJkKxWon+0BNJ6fg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-GaAQpgFONzqSJ46lMf2o8A-1; Thu, 18 Sep 2025 11:26:32 -0400
X-MC-Unique: GaAQpgFONzqSJ46lMf2o8A-1
X-Mimecast-MFC-AGG-ID: GaAQpgFONzqSJ46lMf2o8A_1758209191
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-77ddaa4caabso471676b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209191; x=1758813991;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZ5qpT0ubEUqCdewMRwilIH2qM78jxpQ70y0QUZWscE=;
 b=NwLIK4c3Wklc01ApzzHYj+VnoIRjkjpGV6xtQ4dPcDwbcdAHR72MKusyf48T6crkp5
 gCl53JBJ7XDy9KzeXKk42dyCTv65M8XZQjwdnjZv6i+hAhEZaLaoltergI/JlLYNafCY
 AiLuLpKvnzY1+HrtVN8fsllR6K4xuBUN/1QAeA1gDQ7VUnynbJB7ITGfHZhw9uo3iZdV
 a2yl8N3ezdMUoZvW3r8elvdMOQYFdq9arYmAUp22axjwLtXqXdWIrFMlUaGuP6qo2j1p
 8NhiSVcrxMUouN7UIcsVrtkM6btDjBD3wN7gfWRqjgOb6dreqAKbuynGkaxK4IFCqiw8
 kwLA==
X-Gm-Message-State: AOJu0Yzeeu/4FlCORFJz0NsweR1E/YBNMSG5vbZvui/A8B7EjhUAwyZA
 gfDA6SqyjBkE6joIWIlTkrwldCia6tY21IgIxARha3JgAWLNCYiyrZZSzWZBWyWvbw3oFFmPmB0
 CaVjDrEZWhTha6h3yFAF2YnWUH0XtMxYYAG/bbJvnLXdkv+UV+pGFUSrP
X-Gm-Gg: ASbGnctldHzLX7u15hIR3Q1VVr9ZxMw6GDQhBf7dvpz7YDjyFxxZwel9PwUzbFvA/Mb
 tg2LPQYcyjqEqzKP4eH+RKoivQARszOtFbzjiBQfsLlTqIbraAGEbnIxRICC6iO9c0Vfs3/qmBe
 f4XWvwzoNrIVdoPJEYbeG7xLSeB+xQgrQmdGP/ZGxrQyPHTygax81qaurXMi18FMgkMMn1rv/4e
 dbakM8+df75GINisViloLFmWFiutsY+uwMBraf0FAqFN0ngKQ+nI07xX+WO8EpXEQpcoX0kNqXb
 BDqcXMl6mAMi9S24cbuoeBLgimmyTuQ/mcd454EmHBg5j87EdyZc4Q==
X-Received: by 2002:a05:6a00:99b:b0:771:ea51:690e with SMTP id
 d2e1a72fcca58-77bf9c4d94bmr7352650b3a.20.1758209190760; 
 Thu, 18 Sep 2025 08:26:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKRRBw1BskaFN7/JIkIFV12GleRGCrEwmRIDIk0wc5g/Y9S2IE3Fj3UYTFFmZtaOxw1DMBPQ==
X-Received: by 2002:a05:6a00:99b:b0:771:ea51:690e with SMTP id
 d2e1a72fcca58-77bf9c4d94bmr7352618b3a.20.1758209190394; 
 Thu, 18 Sep 2025 08:26:30 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:26:30 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:36 +0530
Subject: [PATCH v14 19/27] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-19-36f11a6fb9d3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2645; i=armenon@redhat.com;
 h=from:subject:message-id; bh=sWsUM8lShaPXtDP2lf9BQ1xaS+5SyRjp1vtDn8Aau4A=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5R953c+DXhZGB1bf9VC5f3fBpslsc/aYXV6wTYP3t
 ME05b+8HaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACaiW8/wT8X4sI3ZIRZBpQaJ
 Bbm8HxPE5Vt2VwguM2XNv3Jni+LCXYwMTW8CqhwjuTxqToanTCg1Pf1b+NGm20HOP3Pn7y2YMtu
 PEwA=
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
It is ensured that loadvm_handle_recv_bitmap() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 01cc186b9e0324053e804c4fedebee02d8df4052..13a809564aebf6346228f46fd60f611ba6104bea 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2476,32 +2476,35 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
  * len (1 byte) + ramblock_name (<255 bytes)
  */
 static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
-                                     uint16_t len)
+                                     uint16_t len, Error **errp)
 {
     QEMUFile *file = mis->from_src_file;
     RAMBlock *rb;
     char block_name[256];
     size_t cnt;
+    int ret;
 
     cnt = qemu_get_counted_string(file, block_name);
     if (!cnt) {
-        error_report("%s: failed to read block name", __func__);
+        error_setg(errp, "failed to read block name");
         return -EINVAL;
     }
 
     /* Validate before using the data */
-    if (qemu_file_get_error(file)) {
-        return qemu_file_get_error(file);
+    ret = qemu_file_get_error(file);
+    if (ret < 0) {
+        error_setg(errp, "loadvm failed: stream error: %d", ret);
+        return ret;
     }
 
     if (len != cnt + 1) {
-        error_report("%s: invalid payload length (%d)", __func__, len);
+        error_setg(errp, "invalid payload length (%d)", len);
         return -EINVAL;
     }
 
     rb = qemu_ram_block_by_name(block_name);
     if (!rb) {
-        error_report("%s: block '%s' not found", __func__, block_name);
+        error_setg(errp, "block '%s' not found", block_name);
         return -EINVAL;
     }
 
@@ -2640,11 +2643,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return 0;
 
     case MIG_CMD_RECV_BITMAP:
-        ret = loadvm_handle_recv_bitmap(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
         ret = loadvm_process_enable_colo(mis);

-- 
2.51.0


