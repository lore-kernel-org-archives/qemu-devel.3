Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03E5CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcTm-0001Gf-GB; Tue, 13 Oct 2026 09:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTk-0001GU-L9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTj-0004ed-6q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdk9TwNLZxLQ1JjhJVlVCAyTA9uEuGd+dged7Hmdyag=;
 b=gVd1XeEGG8emNfLxYl1yJrPS8682oe0QlYUQTL5GqBdO4IVSeihVGcdHfS8kjlic6K1mut
 LgmOwfT/xfSIAb2xQQ7yMxLJ6SFUBlOKVAi0VxksS8ngbiFI4Va7kM/lkBl3rTKxZ3Xvew
 V3idhPQOoAP83JpOb+luZZI0DDOfdM8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-Cpxt_9J3Pb-K8uoKie1Nzg-1; Tue,
 13 Oct 2026 13:23:37 +0000
X-MC-Unique: Cpxt_9J3Pb-K8uoKie1Nzg-1
X-Mimecast-MFC-AGG-ID: Cpxt_9J3Pb-K8uoKie1Nzg_1791897816
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 322C9180AEBD; Tue, 13 Oct 2026 13:23:36 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AF3F30001B9; Tue, 13 Oct 2026 13:23:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:01 +0400
Subject: [GIT PULL 04/40] chardev: add qemu_chr_resize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-4-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HdLSSAxOvJDA2WpXZ0VQLZ7r26EirwFb2bicK+wgzQk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDCHsuukgoxtyv36CB0mxqFioBBByNjfpmz+
 CvlaBfrmFeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5alHD/9n6OPBOvwGMfqQ+j24eV0e8Nh321k0oHk45lXq1xcR/24NBXJqvacx27nG6sma0QRKMPu
 7iYt1ZDEP2Nf7OhrhHotU8Cpbm90UEAfYn2t8jVysu+dxWChBDWqzaMAGTqKH+Dq8s5C/NOBN/L
 KyVIkn4+Bn1z7MtBI+gi49TipvW5mcUuNaMCSwZVNyAb3lXCFDfEcvjakTcd92X/dFwjgRSXpI4
 HCPdisuYH5J74d6BCSCgqTbzrCC8bi8a8uhFVASxxUil+CmWi+otuRHcAIkHT+3ZE/VA48/tZR4
 oPszub/xrsIqTxDkiKQWLXDGPw4YtA0hDyuNr09pozuBUjkzfGUIBR5D6rugj0OaCW31R/OIDQm
 Kua6A5IsSFEAjNGmCMM6oWbU/aKFO3FJGCaBQ7YMFcY7an0v0KoSAtE3p/bC6iyYBXOGItUx4t0
 DHH8Y3FXCITWZKOygnC6HvR0s83vC/D5gLOrNtFWNZGmG4NsU5rCWmp+pQQhRUPdWK8B/jg91/B
 EUaE0Lk7de9sl2zZjFyhV7JFnH6u4z5nHL/O3QkF3L9HVC5l+KlfhaCcJjND93fmJrc/Wx32arb
 QtcNxBmF/IwzWwkxall3EMe4OtfYZWosVDyCEBPJQGFx6nak9VkmIG+d9rqSOQSn/GjnKXIL+sL
 zU+fpvkDInk2pJQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Szymon Lukasz <noh4hss@gmail.com>

This function should be called whenever we learn about a new size of
the terminal connected to a chardev.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Dominique Martinet <dominique.martinet@codewreck.org>
Tested-by: Dominique Martinet <dominique.martinet@codewreck.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261012-console-resize-v10-3-2c3b10d829b3@gmail.com>
---
 chardev/char.c         | 11 +++++++++++
 include/chardev/char.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 40d2180ce74b..8c8386e5b51b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -386,6 +386,17 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp)
     return 0;
 }
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows)
+{
+    if (cols != chr->cols || rows != chr->rows) {
+        chr->cols = cols;
+        chr->rows = rows;
+        if (chr->be_open) {
+            qemu_chr_be_event(chr, CHR_EVENT_RESIZE);
+        }
+    }
+}
+
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
                                 bool permit_mux_mon)
 {
diff --git a/include/chardev/char.h b/include/chardev/char.h
index ee9f24038bd0..2616c19cc095 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -235,6 +235,8 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows);
+
 #define TYPE_CHARDEV "chardev"
 OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 

-- 
2.56.0.116.g6de20f6092dc


