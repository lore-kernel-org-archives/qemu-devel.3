Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAF6E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfw-0004V7-7a; Wed, 18 Feb 2026 08:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfs-0004Tc-ES
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:33:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfq-0006H4-Q0
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/8FdOawT4l+d49GakUVhtVVYAdyZ+VALEhrmRAkR5g=;
 b=KlftOX/Mg3eZ1lr2wiC15qIE7vhfsAu22IarvdmDrcWW7jgnOI9yR+NUp/5FJCRjYLDpwy
 upV9Bf/sOnoFsTJqgrFmvxzhfXzGsKtN7FR28hQRXSy+gTjxYt6UrsT97PiqkNROpfs0IH
 wBKEJndXk3GsE1zv0eySedgwkSG6aUo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-cpq-_mlFNryWRWGqx9VqlQ-1; Wed, 18 Feb 2026 08:27:10 -0500
X-MC-Unique: cpq-_mlFNryWRWGqx9VqlQ-1
X-Mimecast-MFC-AGG-ID: cpq-_mlFNryWRWGqx9VqlQ_1771421229
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43766514653so3635683f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421229; x=1772026029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/8FdOawT4l+d49GakUVhtVVYAdyZ+VALEhrmRAkR5g=;
 b=Jlvj8D/HU6fggWyW3Ci2S191UD4qRJhGqLkOmm99BcZqUnWLBXqc5Ai9y+tu1JRSI0
 rb7HLdUR+ZpGd6NmdkXXphhLRr9xzlfoWubc2Ken16az8UMsLYYgfS2qAmWJ4jOip4tg
 jyTQjKugD+0GdI3dj3X8j3XFQ+97WO1Hp1NEvFUqp+PW8mrGoWAGb2/6BBEsmmvkuzXW
 rKazaPzbc/Qp3rEH1rU2GQfZAuAFQTXjmDDSgErEJ5pzWoefs6wJAEJidKdefYWp+5nX
 g/bbRs1ZCQ6AL8Ky1HKaO64cuOesBaDpewbr/SwYaovdB9WgsvQXSSQhl6xaz5v/3gQ9
 f8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421229; x=1772026029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H/8FdOawT4l+d49GakUVhtVVYAdyZ+VALEhrmRAkR5g=;
 b=UsTiAa50d/hmN0OzO4vOD0y0zwL+i19W3lzBCU+AvhbGAE1c85HBIk5ktMG91cep2t
 8yXut+fDQaWLYOM2V1i8pMIXi8UPZ02pd75QbjfRR9KBE7WS1li0eibp0B3WFkOjSj3o
 zFClojoNIQDHbR5Ibn6wnd+mnYX5aYD/gFxtvSqvs6C+kcmbZ3FBKaytvhfZgZK02fpC
 bSTdYI0WuJtJcbqzt2suGT6LYy09a7f4ItrQSLhfSbdxWyC+l53zbZ2LiObSjKV2eRP9
 ywTtfuUkEaXG22WXziKU7NTQFUuOeLlcNvq4IxTLtgU/5Mk2MQ7Wkx5h9/561BDFWy3J
 cNRA==
X-Gm-Message-State: AOJu0Yw3X6a9juO/jABM820AJpGUd6b2DUVpLXtV+gJnRPbLOuHojcyY
 kL7IPIAvxSxS+4Gs8infZg8Ug6Oqv62Q1/p/GSpIGRtbKgklqrFgUDZI3rU0SLyWsLTBZPBsm9k
 0fwoh3x62NNpf0HVmNANBgd+l+Ur6M4/0H3Bv410IKx62+kaBywgBK0F8
X-Gm-Gg: AZuq6aJXrs/DWqdzoq9veKBoQoh9R6BR9ZK2CAe/Kfo1DIr4eLzj//jdvQXJmEQOPxZ
 rZzw8oruWA0JAkL1d1BT/aKX9tyQ+ufne0Rslluw5vDvurWWyrDWViegpkLufiMEx2E5hAfzd+f
 ir8/lrRntBTmuAyDIK1yWzdcoFOySahoaKakyrWmuQlF13/KreAN/UT05HHcq9G3zooKfeh4gRr
 aj2dNaKHXL9XAVz38mgYmFklB+t/1H3MVUCRTfb7c4fjiKSlkLAbXYrLV9NWLXCFYSHDtaoNGgQ
 ujdOejmHK0ZtYkglqWPnN3k0jioY7fG25YS/85lvq4ihrbq3fmDPY+Q2ziTgb3tIfjXaLDRBqfb
 ALl6jeBMa3ZCdgAEMmze4DXZDw7A4xglwf93S6KMbCTJITPwPjEVsImfpkratuI3YkRdlEnQglV
 70AgJR
X-Received: by 2002:a05:6000:4383:b0:437:6aca:d1c3 with SMTP id
 ffacd0b85a97d-43958e0df1fmr3181491f8f.18.1771421228876; 
 Wed, 18 Feb 2026 05:27:08 -0800 (PST)
X-Received: by 2002:a05:6000:4383:b0:437:6aca:d1c3 with SMTP id
 ffacd0b85a97d-43958e0df1fmr3181443f8f.18.1771421228328; 
 Wed, 18 Feb 2026 05:27:08 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6b563sm41211339f8f.12.2026.02.18.05.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:07 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 10/24] fuse: Introduce fuse_{inc,dec}_in_flight()
Date: Wed, 18 Feb 2026 14:26:19 +0100
Message-ID: <20260218132633.29748-11-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is how vduse-blk.c does it, and it does seem better to have
dedicated functions for it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 5953407f20..fc75a5e74d 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -78,6 +78,25 @@ static void read_from_fuse_export(void *opaque);
 static bool is_regular_file(const char *path, Error **errp);
 
 
+static void fuse_inc_in_flight(FuseExport *exp)
+{
+    if (qatomic_fetch_inc(&exp->in_flight) == 0) {
+        /* Prevent export from being deleted */
+        blk_exp_ref(&exp->common);
+    }
+}
+
+static void fuse_dec_in_flight(FuseExport *exp)
+{
+    if (qatomic_fetch_dec(&exp->in_flight) == 1) {
+        /* Wake AIO_WAIT_WHILE() */
+        aio_wait_kick();
+
+        /* Now the export can be deleted */
+        blk_exp_unref(&exp->common);
+    }
+}
+
 static void fuse_attach_handlers(FuseExport *exp)
 {
     aio_set_fd_handler(exp->common.ctx,
@@ -303,9 +322,7 @@ static void read_from_fuse_export(void *opaque)
     FuseExport *exp = opaque;
     int ret;
 
-    blk_exp_ref(&exp->common);
-
-    qatomic_inc(&exp->in_flight);
+    fuse_inc_in_flight(exp);
 
     do {
         ret = fuse_session_receive_buf(exp->fuse_session, &exp->fuse_buf);
@@ -323,11 +340,7 @@ static void read_from_fuse_export(void *opaque)
     fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
 
 out:
-    if (qatomic_fetch_dec(&exp->in_flight) == 1) {
-        aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
-    }
-
-    blk_exp_unref(&exp->common);
+    fuse_dec_in_flight(exp);
 }
 
 static void fuse_export_shutdown(BlockExport *blk_exp)
-- 
2.53.0


