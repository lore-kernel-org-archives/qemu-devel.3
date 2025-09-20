Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08CBCAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07Hh-000500-4v; Sat, 20 Sep 2025 19:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07He-0004zX-0z
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07Hb-0006hA-Ie
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46b7bf21fceso4786155e9.3
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411980; x=1759016780; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l+6U7vuZXoA2jAif1uxe87ybSSQD3PHGgeF0aqX99Qs=;
 b=Jb/2k5o8deS5nf8BN87KsHrMiXZowQ98Z9wajl7sjTOnuQgMuDGaGsk/EVVJFFxsvU
 Ph+eK50p2XzY4chiE4IN/xY3LUKQJyPULSrSWzLqLLII+7x/GXnkTiF6K3+9Hvn//95F
 xlCcyLK/5A/BzfdZU0BQeFBVSHb5m6ibIKaSr63HWiYZvFUpdnSxIBhFzadFdhcaJDgg
 6vNX8mv5f9qsNTQB4Z+vg4RMH63yl/AhOMJ0llueBH+qh8ZT8sauCRsCxTJrLWSOGZ4W
 w2ySD2DCtbIRon/HLACEn+0t05vE7J3m7eu20hv5YSl1Ik/JpVpAoSnpzYaKSyvazqNq
 fxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411980; x=1759016780;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+6U7vuZXoA2jAif1uxe87ybSSQD3PHGgeF0aqX99Qs=;
 b=UCSii9w5PFlTUq7jcvvh99Tfm3IY9MATlm+4C0nhqTm9qEwkT3ITZNjrDT+O1qeTiM
 WXSrZ5sjRAmeCkITaF5kuR7SBlMGBnp2eJRVcwbp96ZhPXEpocn7PtwnNtf8b8pKTaB/
 hWr7HC7403qGPfSc/8bIdcO6O/YwQ4SAeGR/2JOe5UMwBsPXxUWHfA7oDRT/jcW5lgY0
 dHt4cZ+ZQkjxsQFVhsoS6ZUTE0BaksJQcxv6LbIbidASbI8tCztHcInJZzWPNUj5Vb1U
 Rg/psq3n03dmGA1fzco+HPntL8hbksOkKxvbOGSRpCvZGnOx1ZNNJn7hg/A/TrNqQHJx
 RvBw==
X-Gm-Message-State: AOJu0YzLj35rkkCzJ4mJdNfyq2NoQqa33F2svq+UmmlPay32cbpw9WOv
 hXetlB4va/zRZjF3Ke6+vHb3jGQTQqrZmFDYgfLl7QC39SU/vhRQMt9c
X-Gm-Gg: ASbGncvvrFL2v3qKv9rpAK42XCsyAFSmJsdJ8+P9XOp4o0mf8At5rOFiKDYtQCcwq77
 h3ubglO1ZoDdlSMNWjp9iu8NU0KWOTZ7CE0EJXKN+jwB1UTQZ9OWZuXpQoGz0k/iz87MOHRFP+b
 rWwZZEccjwwUEimPxJ66MzqFznRkq6B88XbXHt2/0WvDpHpN8Y7r3DCsHA/ca2I8yHWWqm9fz74
 MlGZBYSsYJTghM9rUg+IMdKl8421Igmj8lnrv8HoDtzKdeTijxBlg6jTKHiJY68hbpIb+Aj1aIe
 IMJqLGf/KOP64y95kWiTNGBN5IkyYRb3QQk3DsODgs/9AuG1vMMW8dLq5gNyxX0HJfxNRnQ44sL
 a+yaa7econePeBUfDeyyXApEG0gcyWSN8VjF+drf4RcP6woA7qwDc
X-Google-Smtp-Source: AGHT+IGcPrcRTjfUt0bpQ7125j3MbMtv2zS3nJc/HrW2LnUXXiXefL03bmP0sDpYocEbB0Foz659gw==
X-Received: by 2002:a05:600c:1f0e:b0:45d:e211:da7d with SMTP id
 5b1f17b1804b1-467f3840538mr59904835e9.35.1758411980357; 
 Sat, 20 Sep 2025 16:46:20 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3ee0fbf53cesm14756947f8f.59.2025.09.20.16.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:19 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sun, 21 Sep 2025 01:45:42 +0200
Subject: [PATCH RFC v5 12/12] ui/gtk: forward gtk console size to vc
 chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-console-resize-v5-12-89e3c6727060@gmail.com>
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
 Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=2083;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=dxDuA1//VqDvH1os8q3NA6tUkxpa0NEBJc+VF1MvYLw=;
 b=Lp2Tht9hYrjoAEySxAR3OJMXr3WT/mfoGacMMEscps/BvMb/NljPryz8VBuKmLpDzn32+Jn4V
 llUX42tmoy8CWHexDfs5lHjMp1W3aKnJnt3Upyanjlm3n43uSCEdHEv
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32e.google.com
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

Query the terminal size from the vte library when creating the console
and every time it might change. Vte doesn't send any signal specifically
for terminal size changes, so instead we register callbacks for
size-allocate and char-size-changed.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 ui/gtk.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index e91d093a49e5d05c10f1dbea5b9b94ff1389b456..ff2709160787f0e2974c83802d932758866f6d44 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2025,6 +2025,27 @@ static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
     return TRUE;
 }
 
+static void gd_vc_vte_update_size(VirtualConsole *vc)
+{
+    uint16_t cols = vte_terminal_get_column_count(VTE_TERMINAL(vc->vte.terminal));
+    uint16_t rows = vte_terminal_get_row_count(VTE_TERMINAL(vc->vte.terminal));
+    qemu_chr_resize(vc->vte.chr, cols, rows);
+}
+
+static void gd_vc_size_allocate(VteTerminal *terminal,
+                                GtkAllocation *allocation, gpointer user_data)
+{
+    VirtualConsole *vc = user_data;
+    gd_vc_vte_update_size(vc);
+}
+
+static void gd_vc_char_size_changed(VteTerminal *terminal, guint width,
+                                    guint height, gpointer user_data)
+{
+    VirtualConsole *vc = user_data;
+    gd_vc_vte_update_size(vc);
+}
+
 static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
                               Chardev *chr, int idx,
                               GSList *group, GtkWidget *view_menu)
@@ -2090,6 +2111,12 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
 
     qemu_chr_be_event(vc->vte.chr, CHR_EVENT_OPENED);
 
+    g_signal_connect(vc->vte.terminal, "size-allocate",
+                     G_CALLBACK(gd_vc_size_allocate), vc);
+    g_signal_connect(vc->vte.terminal, "char-size-changed",
+                     G_CALLBACK(gd_vc_char_size_changed), vc);
+    gd_vc_vte_update_size(vc);
+
     return group;
 }
 

-- 
2.51.0


