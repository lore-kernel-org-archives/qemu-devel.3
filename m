Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA48CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huU-0005AZ-JP; Fri, 03 Oct 2025 11:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htt-0004qJ-KK
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htQ-0007ec-49
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YqJMd9O+36rRVKuc0NorDyN5G9tu3esgA8WMS0gguXM=;
 b=RO8cbynVH2HBw2phxPUEIrTcRlYsj4ev+crOWG16sQnWrhpg3N2k2O8ZV30cxEJJ+o/x2+
 U5jW7gprvj8UMKHiUdJ7sHwZhfLKSChV3PoNzarPZizu3Tys2DtnQ4eh9eLrwS1Ttg2qHR
 HC2w0GP6BMqADaG62/z+JXQx1NiV/7Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-XFQAjoCXNjigMxDd5rLIfg-1; Fri, 03 Oct 2025 11:40:21 -0400
X-MC-Unique: XFQAjoCXNjigMxDd5rLIfg-1
X-Mimecast-MFC-AGG-ID: XFQAjoCXNjigMxDd5rLIfg_1759506021
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-803339f345bso4227446d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506021; x=1760110821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqJMd9O+36rRVKuc0NorDyN5G9tu3esgA8WMS0gguXM=;
 b=rRMe8usG2mwiiyv685dtmNDpTBpQd9HqLjuzgfB0fDW8W7PTFE4/J9ziUnA0M40UEO
 MbXT2g0my32qYiV7UQgV3nF46ghP5ba949TdVy1uEi68aGxrI4r6X9qe+GONoDHUIJZ/
 AOtx+UfXVOfOE+6KnzKh1Uxcd3PB6gz2G2X9Q6qAFqdUnKYqbEb3zzvhYRipcFCIbco3
 6J2fGZandpzWh/2/MnXUpWNxCqJspeCMizmZZFYf+HnIu0aMCHRkOlhs7DYu0pleB7Hw
 Vi5Nb1YS0vZwPZ9PTn4xoUs8LrvC3AwrGm1lO1Motdzu11Vc41nz5aINXlWUiNauZCrF
 MsoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvJIz3WbqFdxF/fEHG8Lf+3ASVRAp4Rd+/qJJXVglRD1++iiEoWVDEMDOBORY9V3arNJ2I9uymlLWS@nongnu.org
X-Gm-Message-State: AOJu0YyuG/CnqljLViu1g/zsQdJtY9cpdtz2X9/a7cpxEIMKavrFpCyj
 HLJcRbYEhtCVM2Wjo6um993wFB/UWgtMctMRbgUY8R8iFyzdJqDHDeHUv8UVg5Z/0uh+xwzKi1Z
 F0Iv99+M4VJqvVbp45T86pyayameYiTsVkT33Wfu4i/OzLK0CmgOg7/Ka
X-Gm-Gg: ASbGnctahSSozPx4VYZBytUDSs3nUC4aebezqnDLny6mTNxvyPgleHMJSfb74Jqw4LX
 /rycDGXxJT6iaT13RepfyNjHfxU8jrIfEZ1eqyWNQ/CiUmUpj3uSIAbH43XsC60Aw6bxyLZQcrM
 IKWmqiujd0LieIAFm/kCqb8JgHDBoJLadCK9BrHzs09rO1KgpYng94csCPwdcLGJ+QultLfWR16
 IWA7ywu2sWZfrzn815IYt6MKMpRixJA9/sTBA1Wxc8Rgm84OdUCiPa0CvUM2mEhEiiWB6krRJzJ
 QDpJzH8xVsg2/zfCmKMrGmtmzGqVJxF50gTo3Q==
X-Received: by 2002:ad4:5c88:0:b0:868:6d1e:c039 with SMTP id
 6a1803df08f44-879dc77b921mr50121286d6.7.1759506020940; 
 Fri, 03 Oct 2025 08:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3qcuEfJ0ZW+y+J5Qxi03WO7HpZTHJdx8Sr+8A3A9MIzs+jrxjPx0E3uredC3hiyU3ThZcwQ==
X-Received: by 2002:ad4:5c88:0:b0:868:6d1e:c039 with SMTP id
 6a1803df08f44-879dc77b921mr50120706d6.7.1759506020433; 
 Fri, 03 Oct 2025 08:40:20 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 19/45] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
Date: Fri,  3 Oct 2025 11:39:22 -0400
Message-ID: <20251003153948.1304776-20-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_handle_recv_bitmap() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-19-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b80da04b47..2e8776768f 100644
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
2.50.1


