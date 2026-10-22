Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475CB606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fr0Gq8f3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqAW-00040R-KX; Thu, 22 Oct 2026 06:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqAU-0003zX-SE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqAT-0007pi-3d
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=upinaihgQEorXOt8lf32xXgKwhjgCT4vLcN/gUWyPAE=;
 b=fr0Gq8f3n+k9Z/XfUT1Jab0+6pebU+T2zXKykpk4vA9IsebB9CSP55NtRIaYKIMEmjBFPS
 5kov0IrSwYZUPmZm0DuikrVr6WrFUXxGPIPkSjyQ0VhPR20u8uX0QRAipu/VA88kFiOIaV
 ykh8RD+bFENEDqhW/Gy9UTc9873uVTI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-GDw7BSoCMdm1ZSdoPXyhcw-1; Thu,
 22 Oct 2026 10:36:51 +0000
X-MC-Unique: GDw7BSoCMdm1ZSdoPXyhcw-1
X-Mimecast-MFC-AGG-ID: GDw7BSoCMdm1ZSdoPXyhcw_1792665411
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECD71195606B; Thu, 22 Oct 2026 10:36:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 725DD30000E7; Thu, 22 Oct 2026 10:36:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Tommaso Califano <tcalifano@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 10/11] hw/usb/dev-mtp: Fix heap OOB read in
 usb_mtp_write_metadata()
Date: Thu, 22 Oct 2026 12:36:21 +0200
Message-ID: <20261022103622.1151089-11-thuth@redhat.com>
In-Reply-To: <20261022103622.1151089-1-thuth@redhat.com>
References: <20261022103622.1151089-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tommaso Califano <tcalifano@redhat.com>

usb_mtp_write_metadata() computed the number of filename characters as

  filename_chars = dlen - offsetof(ObjectInfo, filename)

where dlen is the amount of data copied by the last USB packet of the
transfer, not the size of the ObjectInfo dataset. If the final packet has
fewer than 53 bytes, filename_chars underflows to SIZE_MAX, causing
utf16_to_str() to read far beyond the heap buffer, leaking QEMU host
process memory.

Use d->length instead: it is the size of the buffer holding the dataset,
and usb_mtp_write_metadata() is only reached once all d->length bytes
have been received.

d->length is guest-controlled, so reject datasets too small to hold the
fixed part of ObjectInfo before dereferencing it. The check is "<="
rather than "<" because a dataset of exactly offsetof(ObjectInfo,filename)
bytes would yield an empty filename.

Fixes: 90c1a74271ce ("usb-mtp: Limit filename to object information size")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3992
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20261007143738.58509-1-tcalifano@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/dev-mtp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 9048cddaaba..8507e516ab1 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1696,7 +1696,7 @@ close:
     s->write_pending = false;
 }
 
-static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
+static void usb_mtp_write_metadata(MTPState *s)
 {
     MTPData *d = s->data_out;
     ObjectInfo *dataset = (ObjectInfo *)d->data;
@@ -1704,7 +1704,15 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
     MTPObject *o;
     MTPObject *p = usb_mtp_object_lookup(s, s->dataset.parent_handle);
     uint32_t next_handle = s->next_handle;
-    size_t filename_chars = dlen - offsetof(ObjectInfo, filename);
+    size_t filename_chars;
+
+    if (d->length <= offsetof(ObjectInfo, filename)) {
+        usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
+                             0, 0, 0, 0);
+        return;
+    }
+
+    filename_chars = d->length - offsetof(ObjectInfo, filename);
 
     /*
      * filename is utf-16. We're intentionally doing
@@ -1801,7 +1809,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         if (d->data_offset == d->length) {
             /* The operation might have already failed */
             if (!s->result) {
-                usb_mtp_write_metadata(s, dlen);
+                usb_mtp_write_metadata(s);
             }
             usb_mtp_data_free(s->data_out);
             s->data_out = NULL;
-- 
2.56.0


