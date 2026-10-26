Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48046606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=cApENMaL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLCj-0008L8-E1; Mon, 26 Oct 2026 09:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLBt-0007Al-Op; Mon, 26 Oct 2026 09:56:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLBq-0000F2-UU; Mon, 26 Oct 2026 09:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=Fkt/W5PoF4OBMqFA6sEJQedA3sGGKfiDG5RKEokHqec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cApENMaL1bSKqAfytQNcDbWxhb9gKEbG4QChPtuRLBz+KodDM+6hBwn3nxoa2Y1S4
 2/qjws+P72oOZ/MfQLQT+GAMlMFeXukYitjpvQDuNdehemdB0VTRwM1T/U46TgmfTZ
 VOiuBNAATs1//lqz+8z8makSrb+a9M4fom4mxm6koPcMKtgD1+3IUZH3sCNk/R+FXA
 8kxXycmPkxiw/3E4HpLywTY0I74t5VB4IAhWAUvDR6aVIdWqlJ69UX83p7DWwHG715
 /Vo8GEEwjvPI+xLm2PR0q/NiUwrlnTPJGYyPXHptspJSWvab/FPrWOD3WvFw/FoPjJ
 /sGxCHrAmDjgg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DFB651E128C;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DD26044B8D8;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B7C86934A7; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tommaso Califano <tcalifano@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 86/91] hw/usb/dev-mtp: Fix heap OOB read in
 usb_mtp_write_metadata()
Date: Mon, 26 Oct 2026 16:54:29 +0300
Message-ID: <20261026135441.1019505-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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
(cherry picked from commit 6ab4cd2f13debf7682106ff1d9917478814dda10)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 8ebff713085..6bb1fc575e8 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1699,7 +1699,7 @@ close:
     s->write_pending = false;
 }
 
-static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
+static void usb_mtp_write_metadata(MTPState *s)
 {
     MTPData *d = s->data_out;
     ObjectInfo *dataset = (ObjectInfo *)d->data;
@@ -1707,7 +1707,15 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
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
@@ -1804,7 +1812,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         if (d->data_offset == d->length) {
             /* The operation might have already failed */
             if (!s->result) {
-                usb_mtp_write_metadata(s, dlen);
+                usb_mtp_write_metadata(s);
             }
             usb_mtp_data_free(s->data_out);
             s->data_out = NULL;
-- 
2.47.3


