Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC6DCA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEe7-0003Ws-Cl; Mon, 12 Oct 2026 07:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEdw-0003SU-48
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEdu-0002Ll-Bw
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so18343195e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791806192; x=1792410992; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Db8kX/ZEk2mJULI24xKoMiCcaFqHTqsMQFyoHrvdHmI=;
 b=Y/neiobNB7JU7+9dVU5mA60SMnQ6p0+vnPgQft/NvcB93WQhLNoqlMns8UjVLPhTdz
 q88T5oLhM23+g9bOJUsEBZR0lUlKtb0W6fQQoXXBf6lOm1+MJm7nD+4kLn52WoGFmdCQ
 RVib4uaDKE4P7LApsvw9A2mtodhW+fZvw82kzieGd/LetmRX9nx8BUXOaqS9BtGCZiIQ
 FrMXAV2Kv/owPj6q3PFltgVMnode0VdJpVwrMrDCSTfMhfJGooAecn4pySiZObyxCqeI
 AhxDfoszGQbCgKwVv/1qB/T4VGUAu1Iukv7/KGmuRarbLHbzCzc8p92g8xQr2UJL2H7U
 TXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806192; x=1792410992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Db8kX/ZEk2mJULI24xKoMiCcaFqHTqsMQFyoHrvdHmI=;
 b=UrpbOs8pSZ4/bdcMVjB3wj3xzXZGhkAg6p2IUh6ig7ioqDebW7ahgoenzeLv3btt4/
 sh6uW2uO6lDee7PAtemsYbeAEmp+wZ41JoyN5hz9Tc7zCbn1f65x2sFS/cpNvBm42TJz
 HAQSeYeSrqHXqvFHPQyfBm3YaaIy6nVg4qILBe5x4IvnLQyofvtjmqcZErHAORGxZn11
 Gzb+h9oO5nFJGV7Lh398YeegZ8onj504POS3EQHbctVi8UM1eJq161A6gxh5ATtnEsWg
 QvUpdvezedg0ld90hLKnALVgzIOqw6nCcztA7EQ2/qPh0eQaTCx2qf8O1z4H9cXK+xBd
 c+AQ==
X-Gm-Message-State: AFq9FYLXCv1uUEltv1oP5H8ESO9k3Vl/mSAaiuSRoGQ3TUC6MCGFUe+A
 VaebObV2W+zzMk6FvJyRMWmHJwkyE41pDD1lEiut/Yc8xBPagipGUzVG
X-Gm-Gg: AYBFou2nOobCLK5R+1xfJP5cFJZBqPhV3Q5zgEfXmE1q5BXUmkzulvEh9mQt+NvG6O3
 6K9VeixQZcIOyxZePeqQnrSyRZwVMLzjpTS1cwAdxXzwNE7L7VAR9+htVPKPEpTD1NPa0Tp/5Gl
 3qw8HNQj5vtFNA4GX80fEPpWw7CBgidjs9DjPwn2Q+gbm5LR//dswtPYncypg6Kt1Hug/1EbBEF
 vVSzcpGgwpWrfoQUJmLAc8CWDnDUhxLhkG/xRgMEKpL7Prs0YGjL2w67n5tjH9QTuW/7dnJQZJa
 MaddssvOvfPoJxwVd/JWFFr/1Q2V9PIl4IwMs9GKzv5hKJZ+uoBQklRdw2+KhKbb+IWxjacwjep
 6tZbXwbSMawiJcNs90SFtreHdMh8KmtOSBU14eaY6xiGeJQbvS8y7olzVNxZiXSjLZxUQ+i9V52
 P079wyjGyrJr10cqoPDObYJ4NX5Oa5058YTgDGdBOGj6U2B/E2Wz/iGMeb48QUVzYb7LSfW6GV7
 RSxxjk7rIrS8IOknvDfYjIGbABsh7Ew955caxM=
X-Received: by 2002:a05:600c:a11c:b0:4a1:97c6:d2e8 with SMTP id
 5b1f17b1804b1-4a197c6d902mr74227125e9.32.1791806191720; 
 Mon, 12 Oct 2026 04:56:31 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ae25easm19782063f8f.59.2026.10.12.04.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:56:31 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 13:55:52 +0200
Subject: [PATCH v9 01/12] chardev: add cols, rows fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v9-1-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
In-Reply-To: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791806189; l=2201;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=ISuMkVQZLr6aTSdzOIY+Zeiyr6PJh/I1vLVNp++Psys=;
 b=FejPP4ervRjnfO63UxGGZKyqzir2DuAYACT8bZlqhUXkmIYhAgt/yE47j9eUxEOLZa3CJGvP3
 Aw2JMg8o51+CJfc9gZ4jfaki1hPF6jeaxQmehgyUFbajkPKQ1Gsm+aW
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 chardev/char-fe.c         | 13 +++++++++++++
 include/chardev/char-fe.h | 10 ++++++++++
 include/chardev/char.h    |  1 +
 3 files changed, 24 insertions(+)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index a44f267373..c61c91f779 100644
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
index a82894e1d5..e4a3801e7d 100644
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
index 7377d8e60a..6394ec2ffe 100644
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
2.56.0


