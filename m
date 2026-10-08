Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF23CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 12:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnFr-0004OE-JN; Thu, 08 Oct 2026 08:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xEnFo-0004O2-PK
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xEnFm-0005z4-Ia
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791462581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5JD+kT7CzsBKz12h+OWBsvmcbUsrO0LPRIuChMQSbLY=;
 b=IAxk8CanLOmFHrUXKDljguHu1yrc2uleVK3EzD2P9MBpt+FH2bJ/I0LOhJOK50zZMnh5s9
 3R/hdr3IS7UseAYrCq5ezyUnS7ckJItTPyt5FWqD1yEFkMHmSM31Bo++ZUMahynTcTfEFG
 ExtcS3/mFkhkP5LWi4ZQCWU8WrGKkj4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-MUqFn4IQO_GYYtP9_G2e4w-1; Thu, 08 Oct 2026 08:29:40 -0400
X-MC-Unique: MUqFn4IQO_GYYtP9_G2e4w-1
X-Mimecast-MFC-AGG-ID: MUqFn4IQO_GYYtP9_G2e4w_1791462579
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a168a8209fso6425125e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791462579; x=1792067379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5JD+kT7CzsBKz12h+OWBsvmcbUsrO0LPRIuChMQSbLY=;
 b=QaBanA2UI8zRgjZNUczx38zE1XpUpgRVdyKCjKn38ZtbFMoFRBOuQ0L0qaQ11a+wRu
 fGxzNrkPfb0W50Yoa2kJ7xEo8Fgr7ZJePsvwUFqKmT49f13sEPwRS3Ror7Ubs6nYY47z
 cFCzQyP2IFtCbdkOaatE1iYDNyr/gi8Wia/vhyoVYhfA1BynyoNdE2fCKIdoh1O887sg
 DYX7P707mvvHV9ZR+XQdJOFbsevhyIARwXsKiAqZm8m/bXG5KpAKpt96rIdEUOfeezMk
 Q6101ACTdD06uJn1qUIPlQFJzkyNJEBGWHMf8w/htQeW8wytPUOIv37gWHkXn33sSLaN
 7ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791462579; x=1792067379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5JD+kT7CzsBKz12h+OWBsvmcbUsrO0LPRIuChMQSbLY=;
 b=bsyxk162NlyCWHHMCbZkA/ioOcjVUzDboo3+ImWrSkmelmsK24lnoQSkU9THbOOcg1
 StbcRcZaF3Bla2bf9s7tuWXqFY0PZR4IutjMUOBaL2HHrxEko4bwu6xy0R1RxCOFowqd
 BUdrALxlJfUrfsrJ+WC1THfXTLA8Va4PS8HnDIDR0KWgk2ZqkdU4TfFs4gnDAKta2Yxc
 efGPnMmSjKOgyHihGByhQAQk/sPapd9XPPpHV/YVlJFrvV/kd5dAoGk2URaxDtWfZ35H
 Vbpl06M7VvKgzLOyW+HoCmTjk+N1NdH2RD05guJxjH/gqMdbDgO3Y+ItJF+M9M4ZuUrR
 qtyQ==
X-Gm-Message-State: AFuF++lnqKBt7WRHg41OuGrrSt1bKVvIYPhCgo7LGCtJcsSe8vlANk/Z
 Y0ADdyoWqz4R/YQCzu3wAMNBVG8QCIdGEK+Zm3nbUs8+SUn12UIjE5tFSnFiROGK6QESJYpjfJe
 KP4tuQdjy+Ddq7PGyg47oZ/QCWSIRlyNqVSurqikXqArCNRYjc8Dxxy0e2PAPd7yvnkxkXqclTZ
 C8XnOEl30iwlpDgr09wWhstzgMqlsZ+y2AnK8Ik94kQQ==
X-Gm-Gg: AYBFou3ZqhhdkhWUixOxfkRN4cB5L1RKhrkVGiDuzOfA+b46an32binHVD4Fj0J2RwI
 opCW36HK8/oJldlIIB2++11Von8A7kUn4gXWXQuM1HH+Sdesxz44l8nsWpVXblGurwU1HHzXgzr
 XpfUIav1RJndVlbzUauMtxLd8vcWH+EKPhC/3vCBfDRI2E+4ucNoSCRwnP4Mb4NiS30mhjSnsWi
 vwCGG815CVOcSdyPpOPXwRCfnDXg4azO5MaWoDc2Rh0uJCaLnlDJahFoQ7s631Zj9gGvSbB5h+7
 trI1/4FJWZoQLmNMUOMBOxiXh8pHXMGDf6kVmVX7LXYMT51BUGCSXQ6+aufAe7S8UGLYIgpA
X-Received: by 2002:a05:600c:4fd4:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a1851ac4c7mr42075605e9.5.1791462578713; 
 Thu, 08 Oct 2026 05:29:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4fd4:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a1851ac4c7mr42075105e9.5.1791462578265; 
 Thu, 08 Oct 2026 05:29:38 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a185d914fdsm102082055e9.7.2026.10.08.05.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:29:37 -0700 (PDT)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2] hw/usb/dev-mtp: Fix assert crash on short CMD_SEND_OBJECT
Date: Thu,  8 Oct 2026 14:29:36 +0200
Message-ID: <20261008122936.45081-1-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In usb_mtp_get_data() there is a guest-triggerable assertion that fires
when a guest declares a large object size in CMD_SEND_OBJECT_INFO but
sends fewer bytes in the subsequent CMD_SEND_OBJECT. The assertion
compares the declared size against the actual bytes received.

If the guest sends CMD_SEND_OBJECT_INFO with size=1000 and then
CMD_SEND_OBJECT with only 50 bytes (short, non-64-byte-aligned
final USB packet) the assertion fires, killing QEMU.

To prevent that is sufficient to remove the assertion, because the case
is handled by usb_mtp_write_data() which returns RES_INCOMPLETE_TRANSFER.

Fixes: 3e096650a64d ("dev-mtp: Add support for > 4GB file transfers")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3993
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
V2:
 - Add Fixes tag.
 - Correct and improve commit message readability.

hw/usb/dev-mtp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1d8cfd32dc..406793fc03 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1813,9 +1813,6 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         d->offset += dlen;
         d->data_offset += dlen;
         if ((p->iov.size % 64) || !p->iov.size) {
-            assert((s->dataset.size == 0xFFFFFFFF) ||
-                   (s->dataset.size == d->offset));
-
             if (d->length == MTP_WRITE_BUF_SZ) {
                 d->write_status = WRITE_END;
             } else {
-- 
2.56.0


