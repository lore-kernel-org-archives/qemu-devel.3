Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27DB10AB82A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rtp-00049j-9i; Thu, 26 Mar 2026 17:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtm-00048X-4I
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtk-00037H-Kl
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+2bKn7od5XGyVQRVijnjbeo3YuBsl9Tu9Y2/7dq7ZE=;
 b=VV2+cRloVC3gjMYTw+OwStDWxGNVjM0FMS0gCcFEy/NfpaKDOFaA0FaXIPvTACfMHfQLBH
 L8dXr5TEX2jdmLcu61A6C9QfiPi8t7Fctm9SnjbAnA40E6/YhYi7FkhdBI8VepTn4qP06T
 E1QEV+3b/IUWweigrCvDnu6engVjCTc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-VcdlYRRYOdeOgc31V-LK1w-1; Thu, 26 Mar 2026 17:05:44 -0400
X-MC-Unique: VcdlYRRYOdeOgc31V-LK1w-1
X-Mimecast-MFC-AGG-ID: VcdlYRRYOdeOgc31V-LK1w_1774559144
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cfc5294894so464496585a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559143; x=1775163943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+2bKn7od5XGyVQRVijnjbeo3YuBsl9Tu9Y2/7dq7ZE=;
 b=sh9mx+v1hi5VzL21gP7Bq6qz+Ahk2NLbX69r61D/xxyQ8TzwTZe+RBTneCehlESfhU
 POEFIteCiXwWDl602m2e/7H/jHYB6Y1SJ6I7HGRbme7q5WJHGZ5U2uM3iNB07bfl/W0o
 xdUvZiTddrtIaSB3D61FwyLAZ0ubWaQjl/VI5dDXZY66sdUdZyhwzM8e/zEibBO5Zaeg
 5z5L6t8pNMBnIstTTECQcUJMFdBkjG0mvbb1xy4/FiZJaAouvRQuI90LqUnoW7rB1TDE
 GOlfUpob+pzHeoC7U6HeLa4cBqfOyG0Z5D9aHVBBplqH/2R9VR7Jh0zMHJWixD1jYfjC
 jcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559143; x=1775163943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V+2bKn7od5XGyVQRVijnjbeo3YuBsl9Tu9Y2/7dq7ZE=;
 b=HgTJkWymrysocXEuThpIPIuJPtbfqtiyAXXhUJnwIudhZqawczxhNYS9QLARgSd4rM
 T+zcG6SR32fh3JmEqaD1wHrnyrLEYy3R6YGIr0OEEewe4ytkR/gxLp0uUZEbZCgZjeHL
 JPcoHiSFLXJUti/aep1sDBC6hDeLASZ/LSvjw34UVah4xRV0LKNFi/Vl9KAVR06g/wL5
 Zhvan6aJtChKhDuta43WF4AvQrYEt7o3Y5C/W144q6PY3QLXqcWaeQmwYGimRKEL86v4
 EkFCRHj+3w3l4Uc689IsSLue2iZT9/5ni3+tg2EI5yLFPJCsHem/GJI8BhJiuCNnRLAh
 3A1Q==
X-Gm-Message-State: AOJu0Yy4v4UUDCv1Ff3onkpuQBFLpvXbUA+VD9JUQU9caN1LcwGhzKul
 UAFh388hyS7x4ln/Pj3dGRv0SL+qXKIdKQgQpfrcztrbOv/YUXk2EAGqCu9U05H191zdtSLfzP6
 hGAq9SloeuGpkqv2dSBAWVFq0SIsqGtakprEHfL4ESc2Qx0JOUeo0w3NieUiqO+KjqL+fHSn0kv
 GIg3XfXxSRi+82+KeL3sigAGHgR3xQiQH2qe399g==
X-Gm-Gg: ATEYQzyOuSva5yUAyyItDjgyBZh/WsSt4Ju/N4ebHFii1zYkXoy1qkrl/ZHyAwRFUyF
 bk3AsHSEvOKCXSgUQtMCm/WalyGmYj2weD7n9dpbjjzvBbam1oJmnm2aP2oOowLUSIJoxGqUzdX
 URSW3gmbCWlEn/DjI0q60x1LWtZTJx4WwK95CDoNPYC5lUZkfGH/vQJsjvmOl+KtjIj4Nf4nZU2
 Yy5371bQXPybl4QMXE1k9DnMTQGvocYp8ta2Yk0InhZdDK4Jr35Isf64xB+xxx4WcUf054JuKyO
 CxY+CXCJ7ntE9np9pU8FEcSWQl5bgUaJOHfgd+rMnuKeA/jN1pm7yWfqGammgRjpjx0iPUntTV3
 csADd+aUHUn8=
X-Received: by 2002:a05:620a:46a5:b0:8cf:d441:c7c3 with SMTP id
 af79cd13be357-8d001012bbbmr1230781885a.39.1774559143525; 
 Thu, 26 Mar 2026 14:05:43 -0700 (PDT)
X-Received: by 2002:a05:620a:46a5:b0:8cf:d441:c7c3 with SMTP id
 af79cd13be357-8d001012bbbmr1230775485a.39.1774559142905; 
 Thu, 26 Mar 2026 14:05:42 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH RFC v2 05/11] vmstate: Rename VMS_NULLPTR_MARKER to
 VMS_MARKER_PTR_NULL
Date: Thu, 26 Mar 2026 17:05:26 -0400
Message-ID: <20260326210532.379027-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326210532.379027-1-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Prepare for a new MARKER for non-NULL pointer.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 include/migration/vmstate.h | 2 +-
 migration/vmstate-types.c   | 4 ++--
 tests/unit/test-vmstate.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index b4bc69486d..092e8f7e9a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -283,7 +283,7 @@ extern const VMStateInfo vmstate_info_uint64;
 extern const VMStateInfo vmstate_info_fd;
 
 /** Put this in the stream when migrating a null pointer.*/
-#define VMS_NULLPTR_MARKER (0x30U) /* '0' */
+#define VMS_MARKER_PTR_NULL          (0x30U)   /* '0' */
 extern const VMStateInfo vmstate_info_nullptr;
 
 extern const VMStateInfo vmstate_info_cpudouble;
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 23f3433696..7622cf8f01 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -363,7 +363,7 @@ static bool load_nullptr(QEMUFile *f, void *pv, size_t size,
                          const VMStateField *field, Error **errp)
 
 {
-    if (qemu_get_byte(f) == VMS_NULLPTR_MARKER) {
+    if (qemu_get_byte(f) == VMS_MARKER_PTR_NULL) {
         return true;
     }
 
@@ -377,7 +377,7 @@ static bool save_nullptr(QEMUFile *f, void *pv, size_t size,
 
 {
     if (pv == NULL) {
-        qemu_put_byte(f, VMS_NULLPTR_MARKER);
+        qemu_put_byte(f, VMS_MARKER_PTR_NULL);
         return true;
     }
 
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 6a42cc1a4e..dae15786aa 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -620,7 +620,7 @@ static void test_arr_ptr_str_no0_load(void)
 
 static uint8_t wire_arr_ptr_0[] = {
     0x00, 0x00, 0x00, 0x00,
-    VMS_NULLPTR_MARKER,
+    VMS_MARKER_PTR_NULL,
     0x00, 0x00, 0x00, 0x02,
     0x00, 0x00, 0x00, 0x03,
     QEMU_VM_EOF
-- 
2.50.1


