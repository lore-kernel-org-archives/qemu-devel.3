Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3510310AB827
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rtg-00046f-7m; Thu, 26 Mar 2026 17:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rte-00046H-K2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtd-00035E-3A
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erx+743xHQZ4m+Ex6FitH4YpobL1zwjNzywosqKc3PM=;
 b=EhrwonwbIv6kHn/oUI+vPPJJTl5fB8vPlEpk7XsoS2UbCQ+UBhPGbPSVVJYH7atyzl7nPI
 QMTVia6rTR9tAnKHgpJ4q56pP9cAEoEXNK7/O7ZYB38OmJ5xbdJ33lnOATsppS8mcd8rVe
 pyW5pr3JS14nlNfeDF38UZmlUKwgliA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-ZQXLhpZzPtGgt_zmGGRwYA-1; Thu, 26 Mar 2026 17:05:38 -0400
X-MC-Unique: ZQXLhpZzPtGgt_zmGGRwYA-1
X-Mimecast-MFC-AGG-ID: ZQXLhpZzPtGgt_zmGGRwYA_1774559138
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd77e5e187so394853385a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559138; x=1775163938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erx+743xHQZ4m+Ex6FitH4YpobL1zwjNzywosqKc3PM=;
 b=sXwO0MWQKYPooa0ztTsQNMoLa3d6JodeNuI+Wtq1tVd6YuUrmYLQ5nTmQd5p6oaJCx
 BLK0swO0XAOeLfnbmc3wGK/q25Zs8rI0ksggnFAhwbsNBggBUVl2eEtZqaEcYyUIWJnC
 vojfine+4yIVA1NZcCI/ZPofu+VgqjagdD43RrW8HF8o06StztfhIc2lpwu1Ao7P9BPC
 Np6PkS6a7rS97NjFCboo7O2FfrKmSOy9mASfcjXK23oh5G/4oEYZ1rjsDt03soNDvz/E
 KbMbvZe3oGQpcP4ZckCVoD0OKh0F/QJ7I1RMZavGFfYEO1mZI18ax4YXtaTPp+nbRS7H
 1ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559138; x=1775163938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=erx+743xHQZ4m+Ex6FitH4YpobL1zwjNzywosqKc3PM=;
 b=j7ZISRzRE1Im+mrNMZjuBKZQnRZqMxMTI/rduQFgQI3cSCip39EH9sGq0PrRcr6/Sl
 ylMjDwRz8YiGeVXcizprbktgUlDU2SrqOQffr8nTGyLGv5UwWmtNYXFtp4YXxHcc1pX+
 UBlFrRRKKCkfs8nXejfrd+9SFy5wOG0jVLfcabnQUOCFxtSI8o/C0mpiLABDFuYrErD8
 mASqpk0FWt6fJAJo4UbdLiN3oiO+k+WkyEQ1ffp04TcWNOhooDYroEFGr6T9+Jb+MOu5
 dTZYmQDshc004Gpaz18Sviy+VhcKvleuZToLCnHxNFgtt4hmuoUjQzi+BizxWBe3XdR7
 Rxqw==
X-Gm-Message-State: AOJu0YwVbFyTW4ecmMsbikQkqyvb+FQA1MElymZ+PKxl/XEZQTz54H7E
 B1thCf645bdZFcc4l+q/Sm1lKQEp0vWF+qNk/2c7wAM/hkq0RfbnndYYi1CJKGT2juQtsvjvDJY
 pBWUkXZNqLzzTo+KAbf32aGRoxA5pm1YpJW9N0IGqbvSgefK4PmGXOzLV2bxiC4Kn60uMT+cWWC
 FFZ2firdeUpCjM5viQlFY8UVKMjhfanLc/HVnazQ==
X-Gm-Gg: ATEYQzwF9OgFNZQzUNZfI8+SSvaCqz1fLBU5IJ278DHlPc8Pi4HHRSOdDZfJZyyh9vt
 IgI4YAADZUaiPb9vOc+vIJxn3GSNvmfpIliBdK7D1EsUxN7lkbLOiPmxEiJ7jMCiR7xbNi4mInZ
 pAn2Pgw3GKS69R8kS3zVD6dhrTGqB9aZeC8tPNK3RcmQEEkHC1JJ5Rca/TLMoFnfjzO/N+fR8Ul
 u6kyhXghV/fviIFYoAlBDuutilTM8NXjsaQd76PADPpAgFcCFQ525wdzOUHBi71rXqZfO+qt/iU
 3W1n4kcsry5I7Fr5mOj3DGxh+616GXb0ZNiE9zfk5dCEivcOFsMuNMucsN7oVq5nGJp4DyFz0lM
 aicdAQVnfxSg=
X-Received: by 2002:a05:620a:c4a:b0:8ca:123e:819c with SMTP id
 af79cd13be357-8d00100420cmr1207553585a.35.1774559137584; 
 Thu, 26 Mar 2026 14:05:37 -0700 (PDT)
X-Received: by 2002:a05:620a:c4a:b0:8ca:123e:819c with SMTP id
 af79cd13be357-8d00100420cmr1207547985a.35.1774559136993; 
 Thu, 26 Mar 2026 14:05:36 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH RFC v2 01/11] vmstate: Pass in struct itself for
 VMSTATE_ARRAY_OF_POINTER
Date: Thu, 26 Mar 2026 17:05:22 -0400
Message-ID: <20260326210532.379027-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326210532.379027-1-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
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

Passing in a pointer almost never helps.  Convert it to pass in struct for
further refactoring on VMS_ARRAY_OF_POINTER.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 include/migration/vmstate.h | 6 +++---
 tests/unit/test-vmstate.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index d4a39aa794..8992fba57d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -547,9 +547,9 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_version),                                        \
     .num        = (_num),                                            \
     .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
+    .size       = sizeof(_type *),                                   \
     .flags      = VMS_ARRAY|VMS_ARRAY_OF_POINTER,                    \
-    .offset     = vmstate_offset_array(_state, _field, _type, _num), \
+    .offset     = vmstate_offset_array(_state, _field, _type*, _num), \
 }
 
 #define VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n, _v, _vmsd, _type) { \
@@ -1093,7 +1093,7 @@ extern const VMStateInfo vmstate_info_qlist;
     VMSTATE_TIMER_PTR_V(_f, _s, 0)
 
 #define VMSTATE_TIMER_PTR_ARRAY(_f, _s, _n)                              \
-    VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTimer *)
+    VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTimer)
 
 #define VMSTATE_TIMER_TEST(_f, _s, _test)                             \
     VMSTATE_SINGLE_TEST(_f, _s, _test, 0, vmstate_info_timer, QEMUTimer)
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index cadbab3c5e..6a42cc1a4e 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -668,7 +668,7 @@ const VMStateDescription vmsd_arpp = {
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_ARRAY_OF_POINTER(ar, TestArrayOfPtrToInt,
-                AR_SIZE, 0, vmstate_info_int32, int32_t*),
+                AR_SIZE, 0, vmstate_info_int32, int32_t),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.50.1


