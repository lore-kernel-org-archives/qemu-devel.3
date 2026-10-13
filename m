Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA257CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcTg-0001Fu-0Q; Tue, 13 Oct 2026 09:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTe-0001Fm-OO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTd-0004eM-B0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/94Nf4ceNLOjF4lRuv9bAHw4VGnd4kzGvse9dZPGRs=;
 b=eXiJ+q/uz20HukFn9m5ZaxsBIRLPCOJg/bFIg5ldkQ/9Vcu/IThvCLgiyR+qPkjNrOcvWv
 A7mgQF23l23QJr9dzpYLZ6DWw3IZ5iDG+gfMUnrqVlTyOHpd8gUU+pPMEcY0l7CL5JntQf
 017A0RzrWzSRTQESKb1EPAXIY3SBJ5w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-EM_J2clZMPiYrKCKJOwTvA-1; Tue,
 13 Oct 2026 13:23:29 +0000
X-MC-Unique: EM_J2clZMPiYrKCKJOwTvA-1
X-Mimecast-MFC-AGG-ID: EM_J2clZMPiYrKCKJOwTvA_1791897808
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 122321828AB4; Tue, 13 Oct 2026 13:23:28 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46D77180058D; Tue, 13 Oct 2026 13:23:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:22:59 +0400
Subject: [GIT PULL 02/40] chardev: add cols, rows fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-2-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2362;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yevMcdpgu+Wt7S65lPA/cOP/Wrt+5BO7Jg7EbFH9wV0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDCSTQ4eRKGOZ9XF2odRzrJvlSjxj8WOp712
 99hjTeALtCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5esXEACJWVo9YHufyVwix7tS3SbGCDpgjjDC42lbKBaAgRpBljgxG3fYtoM7X8r2zPxv+05Lbn1
 iQVlUnPX1totNrACQcM30AAk1CfWlXvc6a7WxT7/le3HThredUyDaCGKgcYdrBHwdFDYE3WDlri
 UJeiHwL93HUjlB8LVZpqOrurWS/rO3HODfLCDUOzBWNO8akQf42j6HbMwMb7LJbkfP1NsM+NEX4
 1YenDW9u4dXACplfOSMD53vukq8vBxxz5+PU2lC0SsHkBlpSzHgzgGK2q6qlq94NJ8J1ISW7NJk
 9ttIA+Iep5ll5IPX0YNM6yjXJ1+J0gf7PESeXBuC8Pe6744bOlUirYgpIs2UaXumn9fwcqvOuKW
 M5lwTbbpj1wtHD6zI5BuGvIRO7QOMjcx3mTzj3P94z+aOfD2as+NfJvygnT5N/A8eQ850ipfrsg
 ongzht+SBSMJOfe8Sr/CLhB+2SdcLcaGMnsCfsyuBrw7Da1vx2K6a7YZ6O5a4T1aX/KBj792bqX
 BPcxrMg6hZ2PxPbkZe0JpouHIYYyNdY00ZfpyVVZTzLSjZKAIxAfcTtR9tE9oempuy20mCwl2yK
 t+pKKLUP2gOwBIdNcyPc/GbyAmaVBEmjcPQFF6EQPDhjCAuQbnHGncG42yzucYEpxCmb5JhVlku
 DUrOMHq7tWBlXHQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

These fields should be interpreted as the size of the terminal connected
to a given chardev.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[Filip: CharBackend -> CharFrontend]
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261012-console-resize-v10-1-2c3b10d829b3@gmail.com>
---
 chardev/char-fe.c         | 13 +++++++++++++
 include/chardev/char-fe.h | 10 ++++++++++
 include/chardev/char.h    |  1 +
 3 files changed, 24 insertions(+)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index a44f2673731c..c61c91f77933 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -329,6 +329,19 @@ void qemu_chr_fe_set_echo(CharFrontend *c, bool echo)
     }
 }
 
+void qemu_chr_fe_get_winsize(CharFrontend *c, uint16_t *cols, uint16_t *rows)
+{
+    Chardev *chr = c->chr;
+
+    if (chr) {
+        *cols = chr->cols;
+        *rows = chr->rows;
+    } else {
+        *cols = 0;
+        *rows = 0;
+    }
+}
+
 void qemu_chr_fe_set_open(CharFrontend *c, bool is_open)
 {
     Chardev *chr = c->chr;
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index a82894e1d511..e4a3801e7dfd 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -168,6 +168,16 @@ int qemu_chr_fe_wait_connected(CharFrontend *c, Error **errp);
  */
 void qemu_chr_fe_set_echo(CharFrontend *c, bool echo);
 
+/**
+ * qemu_chr_fe_get_winsize:
+ * @cols: the address for storing columns
+ * @rows: the address for storing rows
+ *
+ * Get the size of the terminal connected to the chardev backend.
+ * Returns *cols = *rows = 0, if no associated Chardev.
+ */
+void qemu_chr_fe_get_winsize(CharFrontend *c, uint16_t *cols, uint16_t *rows);
+
 /**
  * qemu_chr_fe_set_open:
  * @c: a CharFrontend
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 7377d8e60a08..6394ec2ffeeb 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -66,6 +66,7 @@ struct Chardev {
     bool logtimestamp;
     bool log_line_start;
     int be_open;
+    uint16_t cols, rows;
     /* used to coordinate the chardev-change special-case: */
     bool handover_yank_instance;
     GSource *gsource;

-- 
2.56.0.116.g6de20f6092dc


