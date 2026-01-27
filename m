Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0A1D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCv-0006Uu-50; Tue, 27 Jan 2026 13:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBx-0003Jh-Lb
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBv-0000tP-IN
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769540009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oe0nLXfQkKzOiz276L4Cm+lS/ot9mCv+OCQ973ZS3S8=;
 b=H7/fG7v09phRCry3NOfj+H8ognqbweID+DMrs6M08u7JSH3sQGNTzxl0tmYqgFZWr9wWnZ
 lvAJmVchx60nWFXY6CbNZNVNlTaipSdmBratTM921xhsjBXyyuKcCRq+K9/37iPSwdVPHZ
 ojsevQgd0D8QnNyC96GfcHv/NZg6Wac=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-R9tUT50ePhG5prOyqDqVdg-1; Tue, 27 Jan 2026 13:53:26 -0500
X-MC-Unique: R9tUT50ePhG5prOyqDqVdg-1
X-Mimecast-MFC-AGG-ID: R9tUT50ePhG5prOyqDqVdg_1769540006
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88a39993e5fso188568876d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769540006; x=1770144806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oe0nLXfQkKzOiz276L4Cm+lS/ot9mCv+OCQ973ZS3S8=;
 b=qkF8M/r7j7iimdo70UBQzjkTAGTgQxf9k3m8HagArpA15YpJLqG06Q490Da51Ad7E6
 iY7hSjYzGpS5WuWCh/64ZDyazWAVdW3355/ioGWrq8vjQ0TKDo1Cc59EqWMhkRoyQpbO
 ff1JHupF6lRrJ5D9jluDfuoW3tbZBNS2HtpsjQgSIFqnFuuqlpTuAbX8oVGHHfv4PDm6
 6k16MoDkpdafSVu6Wo1gc36UNguoTK56L3fbcdxI7fx4+FEpGHP5EvnG5ki7c8Q4fMl3
 BzTiFYhb2r7rWdXjS/YedWIcP9J72hQmEOptwLXY7uwMhC+guc2cJ3nE2ZJoaxmtVH5n
 Mtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769540006; x=1770144806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oe0nLXfQkKzOiz276L4Cm+lS/ot9mCv+OCQ973ZS3S8=;
 b=VcZYvaltpdMbLZDQPwehHqmG3VLMngxj6PyJeCifN98XZjwPO0YmMGnDeF23PkJh0d
 PUBzoQw+haty0p2zl5vm5oy1ccGD6mXzMnrdHbGKpe2P5VQl2LWlRbb8NtuQB9MrtNQx
 Ljrt7AQsPmfDwrx+k1K7mOWSoDPozJINffyiT1cPopkurqyVnM5jJ/pAsYH95IbJ69a6
 eMwhaXRkui6X6TWgBjLLvl/RHXCGlYlAY+k8fUXg0fEXRjlu2GtUr5DwwClMududKRvJ
 /Y7I5klXepmlvV2Sh7qnDTXl9nnXmZ1hncF1/epVvphNP0E0hOiwrwmYR49vwwLuabDG
 DBMA==
X-Gm-Message-State: AOJu0YzYbDxNRWUFhacCVv2Rl5qkwnOxldOsGugV+98tuLuqoASua5AO
 TGSYXTuwe3HMzQwZxu+6cv/bbS5CJfVRpE0iZJInKPSv4XdCvlR7oaDJzOqxdZW6eSKU5gjzzW8
 1kmUBgBBRkjBILbR6TxPZS3Pcl1jNSfcNPGLiCJt4qe4K9l4CX16Kjz0psXBheTqVBe4+P4k2XW
 QgB6gVcemW0l/CC121dLyYDr8MMwEme1P7VFnUpA==
X-Gm-Gg: AZuq6aLdM/IS8prIRWsyZ7R6IkIXJFGLgUJiD1ewrlPKSjpLz3ppI2Tg2qYhsb+WXEB
 pQ0TRuBrVkog+BTTj8oKUDnHLjChtPYpfWaIOqpoHUJc16Cq6tMcnt1rV1hlroKHdpZzSiRCfav
 +xiG5etigrsYH0kmGnOY4LBgBl3dn8EUjQbmh5a7pNWCbX4TnwUsd635T4rjKj+q+iwGfkLUVFP
 kughz+zth/BwO6x+oj2yu4A9P3nx2wzkQFI0Mgzt87J/6PiYCvykJkEejtwm2pjI3dcKbfl1t1K
 O2CbLb0eHvR3eeqzd742gPelkCuTFhF6PE3pqtxxQpaIEoTv4HPhnlnQ6PUII7EY3FVp1K0R/lB
 H
X-Received: by 2002:ad4:5764:0:b0:888:8096:a09c with SMTP id
 6a1803df08f44-894cc990b51mr43687276d6.62.1769540006006; 
 Tue, 27 Jan 2026 10:53:26 -0800 (PST)
X-Received: by 2002:ad4:5764:0:b0:888:8096:a09c with SMTP id
 6a1803df08f44-894cc990b51mr43686916d6.62.1769540005427; 
 Tue, 27 Jan 2026 10:53:25 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:25 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>
Subject: [PATCH v2 24/24] migration/colo/xen: Use generic helpers in
 qemu_save_device_state()
Date: Tue, 27 Jan 2026 13:52:54 -0500
Message-ID: <20260127185254.3954634-25-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use qemu_savevm_state_non_iterable*() helpers for saving device states,
rather than walking the vmstate handlers on its own.

Non-iterables can be either early_setup devices, or otherwise.

Note that QEMU only has one early_setup device currently, which is
virtio-mem, and I highly doubt if it is used in either COLO or Xen users..
However this step is still better needed to provide full coverage of all
non-iterable vmstates.

When at it, allow it to report errors.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h |  3 +--
 migration/colo.c   |  2 +-
 migration/savevm.c | 30 +++++++++++++++---------------
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 6a589b2990..2ba0881f3b 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -66,8 +66,7 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint64_t *start_list,
                                            uint64_t *length_list);
 void qemu_savevm_send_colo_enable(QEMUFile *f);
-int qemu_save_device_state(QEMUFile *f);
-
+int qemu_save_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
diff --git a/migration/colo.c b/migration/colo.c
index db804b25a9..f7a5bd3619 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -454,7 +454,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     }
 
     /* Note: device state is saved into buffer */
-    ret = qemu_save_device_state(fb);
+    ret = qemu_save_device_state(fb, &local_err);
 
     bql_unlock();
     if (ret < 0) {
diff --git a/migration/savevm.c b/migration/savevm.c
index b29272db3b..3a16c467b2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1887,26 +1887,24 @@ static bool qemu_savevm_se_iterable(SaveStateEntry *se)
     return se->ops && se->ops->save_setup;
 }
 
-int qemu_save_device_state(QEMUFile *f)
+int qemu_save_device_state(QEMUFile *f, Error **errp)
 {
-    Error *local_err = NULL;
-    SaveStateEntry *se;
-
-    cpu_synchronize_all_states();
+    int ret;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        int ret;
+    /* Both COLO and Xen never use vmdesc, hence NULL. */
+    ret = qemu_savevm_state_non_iterable_early(f, NULL, errp);
+    if (ret) {
+        return ret;
+    }
 
-        ret = vmstate_save(f, se, NULL, &local_err);
-        if (ret) {
-            error_report_err(local_err);
-            return ret;
-        }
+    ret = qemu_savevm_state_non_iterable(f, errp);
+    if (ret) {
+        return ret;
     }
 
     qemu_savevm_state_end(f);
 
-    return qemu_file_get_error(f);
+    return 0;
 }
 
 static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
@@ -3346,9 +3344,11 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     f = qemu_file_new_output(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
     qemu_savevm_send_header(f);
-    ret = qemu_save_device_state(f);
+    ret = qemu_save_device_state(f, errp);
     if (ret < 0 || qemu_fclose(f) < 0) {
-        error_setg(errp, "saving Xen device state failed");
+        if (*errp == NULL) {
+            error_setg(errp, "saving Xen device state failed");
+        }
     } else {
         /* libxl calls the QMP command "stop" before calling
          * "xen-save-devices-state" and in case of migration failure, libxl
-- 
2.50.1


