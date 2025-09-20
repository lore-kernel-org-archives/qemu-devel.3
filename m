Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D30CAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07Hj-00050K-9V; Sat, 20 Sep 2025 19:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HW-0004do-N2
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HR-0006fH-6T
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45dd505a1dfso22258965e9.2
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411970; x=1759016770; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hCZ+nixf7PQMIujJyTtBUQksmbTN5+upPT7hjXIuKP8=;
 b=W3Zz387b6mAGhiRpw83Qx9tUFtHpnzcoEkiFsmx7PrdF45ssgTF8AoXTBIxmg8Ovjp
 WRXbRqnxeGAXJRUnXmxjfqnW+8P21SIhU9+fNOHtizuqzXjixK94DLfPoDaj+u9w3Mkk
 p+wCa0Lg/b/DerEYexe/Ec0h/rnmN6MEzmP7ysGnJrrQteDKI2ss1GGROlMl0GpLNyhr
 m6s2nzZICdXlRS/M+SwSrsgF34/Wv3S2h8+E+M/8tJ47FZMHVA+wq4zlOWvc6cwuOA57
 IrpURxLbZf+md0GPE0vs27U4v/L8laTFlqqd8dvpnCs3AL7fGvGO/aC5KNKzqDEVqdtF
 vbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411970; x=1759016770;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCZ+nixf7PQMIujJyTtBUQksmbTN5+upPT7hjXIuKP8=;
 b=AlMDyv4TGZCQ2n9WmoR1ryUrgT1j6jcY4JAZgk00MizJktrGdjOfk3AtcLsBXM2wjL
 cQ55bRZNKhkA3Oh4i+jAJigihhYfGdDi+un3eG64CwHGlgzM8tx52Ba3/idwxXttm8eW
 c0bnKks699mtlCN/x4h/k0vc1v0cROgHab8yNsuVpMQYsTdajzOV2AJpAF9h8wH/4ujE
 g+zj925Rbrjk0aptJHOZTog7UXG9ZtMz1d7pl13ExUrae9GlPRbOEzt5JxCLNyHuCNu5
 E4AIem8ie0By0D7G9IYD7ferVvtmpWvqY5nEvnd43omlrTddyolJ51ujw7leebqd0gC5
 istw==
X-Gm-Message-State: AOJu0Yz6Vf+n1oUnHkVYLB1hg/dz49n4FDX+2uvem0FEqHvlOIjRhuFW
 Vq2Bb8XLoTR0sbj72l7U1Al9tZzLugjYRxNN/9WaJ1DdCFlG1LSr3ECu
X-Gm-Gg: ASbGnctgCpytX5gbI0uQcioUxmE653ayFP9dmuZo7f+w9a3WyIqtgBC55MHOLGvsBqU
 cNY2aX7lFuNI03Nt7Prh9eJCpjmiAQ2IXu3Acy0apL3CzzY5b6aHE+R6xHT0Pc50FKhBzJIn11s
 Uv/8Aw7ZPOheNhmB5UQ69GvEmftIbpm/0zxuJPsj4oI6X48x2kfqXuSNnB1StoZQyPbmcUXjiGP
 hiicLzanG5bVm1CiKzdMywqfECuOhDsMdtT0MriMS+welTNlqJpSPoksVJMLkwjpYu0d+Ap7ESB
 pTQiTHVfMx5vuBkrSMwa/zw+fnietI+7LJNZXaAHC/QiPpW2Nm9lZoZhgOcr9aOpQqVk+/hM4KO
 zyQm7V8A5YVuGB/lfr5DCcb0NmbX0oX+qmLCcdMNEavz5TsgCcPHx
X-Google-Smtp-Source: AGHT+IEIpql2bd7ISmaXlFnyqD3uiUDNc8MbDGRJ1Ez4noloZrktcOIKphl23X13L3x9QD0f1rlSYQ==
X-Received: by 2002:a05:600c:630d:b0:45d:d9ab:b86d with SMTP id
 5b1f17b1804b1-467f2cc87c4mr80479565e9.31.1758411970269; 
 Sat, 20 Sep 2025 16:46:10 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3ee1385adebsm11802399f8f.42.2025.09.20.16.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:09 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sun, 21 Sep 2025 01:45:34 +0200
Subject: [PATCH RFC v5 04/12] char-mux: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-console-resize-v5-4-89e3c6727060@gmail.com>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
In-Reply-To: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=1676;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=uAneZtIXQKXb3wxUGy0F4B+wt6eZP9NrISsiWqyMWe8=;
 b=/HsXc7iFgRxcpHZ3zj/aiBFtQOOYql5Cx+oMNAKUIf64tiYhfYd8JZxfAjfl316dF41fwKt6u
 X+v7kRquDhyCcIKalztfZsjbjlb9Z2ln7oGLLTpM+lsprW0mt7NYton
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x336.google.com
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
List-Id: <qemu-devel.nongnu.org>
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

The terminal size of a mux chardev should be the same as the real
chardev, so listen for CHR_EVENT_RESIZE to be up to date.

We forward CHR_EVENT_RESIZE only to the focused frontend. This means
frontends should update their view of the terminal size on
receiving CHR_EVENT_MUX_IN.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-mux.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 6b36290e2c49f579580d2abb5aa552806f019d4a..4d3d05b82f13e002c766142f9d9c24977b8b9bd2 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -264,9 +264,24 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
     }
 }
 
+static void mux_update_winsize(Chardev *chr)
+{
+    MuxChardev *d = MUX_CHARDEV(chr);
+    uint16_t cols, rows;
+
+    qemu_chr_fe_get_winsize(&d->chr, &cols, &rows);
+    qemu_chr_resize(chr, cols, rows);
+}
+
 static void mux_chr_event(void *opaque, QEMUChrEvent event)
 {
-    mux_chr_send_all_event(CHARDEV(opaque), event);
+    Chardev *chr = CHARDEV(opaque);
+
+    if (event == CHR_EVENT_RESIZE) {
+        mux_update_winsize(chr);
+    } else {
+        mux_chr_send_all_event(chr, event);
+    }
 }
 
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
@@ -382,6 +397,7 @@ static void qemu_chr_open_mux(Chardev *chr,
      */
     *be_opened = muxes_opened;
     qemu_chr_fe_init(&d->chr, drv, errp);
+    mux_update_winsize(chr);
 }
 
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,

-- 
2.51.0


