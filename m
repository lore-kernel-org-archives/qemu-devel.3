Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C5BCAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07Hn-00051h-D5; Sat, 20 Sep 2025 19:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07Hd-0004zT-9P
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07Hb-0006h0-IM
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45f2b062b86so20163585e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411979; x=1759016779; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cmuAqUfviCGDVtMUO3Hf/bBLqX3OlMJ+/HoQ4xxcj5U=;
 b=HQpivj94UyP+g3hDac/5FKAcOSX9Xyne1NbhOyiegEPyYJUtFBzijvlDrBu/1fcayI
 7Uv4mH8H6/Sf9PAXUarYSrDtc2+JxEXE4O92sEQ+OCrM5GS8CCEYmWYoOiVqdJV7o4ug
 rPhc2yrDgVYZWYNZo/3l1APQlLnKWgyqN28TVDNSpdPP26qr8jrzTS7lB9wE1m4EZ3xs
 nZxyAVwBLi7Kw/BUyHzrOY+6K/7uAF1vzajm6BBy3/2P4Qv03j/Gdd3gZREAMQk8gROU
 Wrr7WzkXM50A8aX0rkDSzJhoJvmIiPCoLz9Y6pLkcZqAsvleolVwNB+7NDfoPSDu9S8w
 oTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411979; x=1759016779;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmuAqUfviCGDVtMUO3Hf/bBLqX3OlMJ+/HoQ4xxcj5U=;
 b=W2EUGzIQhqMlqpsILx+dBECNpQ5NfV3NGLzAUrsQgyKntppzXLZuWXhTBz9lAcZRJc
 EdEzmmTwzAVyTiKMKhngiIh0FQ8kHlmN8ydqLM+/w3kOVdB6ylD9d5TYBtL/TRGr714j
 W3ZtA+dHML1uoMU4aRLjTDWMYedKdLUH6iXa2OdlZ3i+Dob087IPif4cAQI8B8gX+JPJ
 RtRz4Wmc649JcY9gUx+/bb6TcLNQJ9Vv3ME1DyECjt6UPICnU4RweAjgMyj0lVn+Bpi/
 aGPjmJW70CZ8GHDt+YscRKXuAZ2SjR2brGtLkrUVzScfM/QAVlMni3tksj9tf6Di3cla
 HmdQ==
X-Gm-Message-State: AOJu0Yz5UoNTwDeqSFv/yhro5Iz7vwgZQIxMR+tP9kiD1oFCy1OPOYqj
 v1InjT7quYuvjKGqUPK+R8GiUiKPLuYSA9Qoyj6CdJq+AZDU6IEDlCxa
X-Gm-Gg: ASbGnctCL6MLm9uD9e/WdDy3OXzXnUfHmkp0MfCYcqJAvCeUXrPYIlsuhdczvRKudn1
 Ic9Wq2UEBh9DSUIwbVtWjYGq8OAMOmKRjK5C+21BMQUxI21Hj+aqQAN8IgXgMXdfXLfHvL1PCCt
 UwkfDvcKOP1AhN3uZRMN6lJfv9uEKNr6eVYxZuP2WFhutMu9seFWU3bYTJuFtVzZGY7OrL1NKbM
 0sjyDqAdOs7LA632Yh5XEViDemNaV/GcHSeS9x+buZW8uTxkIi8NY5W2PSKPd/51wPjL5d1DAGp
 zPVx5h8Y1XDy+iBR21rGZ9NKXOYRTLPdTQk7H1qcTZuV77UfMEyHCku8j5efYGlnXRL/YdEDmkN
 tAlxMlqE/645gF5VYqeF2bR7IjreAu2w7t4hOOh5If6oa+uZnJ60B
X-Google-Smtp-Source: AGHT+IGSYa8cKhXmXd9SIwUWqvm1OVVDnmHKZmomTQcV/jFAH5QPQS0V/VzP+KAnmnkkp+qjsijdag==
X-Received: by 2002:a05:600c:6305:b0:45f:29e4:92fc with SMTP id
 5b1f17b1804b1-467f205a3f2mr73507515e9.20.1758411979230; 
 Sat, 20 Sep 2025 16:46:19 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45f3211e8c7sm105425045e9.3.2025.09.20.16.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:18 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sun, 21 Sep 2025 01:45:41 +0200
Subject: [PATCH RFC v5 11/12] ui/console-vc: forward text console size to
 vc chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-console-resize-v5-11-89e3c6727060@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=989;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=zrGZ+VnQUGMTadVXf4F7llWgq/aUdT9O8UHj671Hmbg=;
 b=RjyGvtHLjfDkwCK91LMorIAaal0uAbmVYueERE9jsW9e4O7tA4wWAu5HWajqn1hn+yyBeeT7C
 U0unkAN1gDAAvh+MOv03cVE4BEzcjLEUibVD1yI/PqkTuFIhQtz1LuV
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

Update the vc chardev size when the size of a text console is recomputed.

NOTE: It seems wrong that the dpy_text_resize callback is not called
      when the size is recomputed. I believe this is a bug, although it
      doesn't matter much because the only user of the callback is
      ui/ncurses and it only uses the size of fixed consoles.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 ui/console-vc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 830842064d6982ee4e7882e50e5c3ef9b1e18f59..a3a90440d52754b02961e29063dda91c9f4097f2 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -414,6 +414,9 @@ static void text_console_resize(QemuTextConsole *t)
     }
     g_free(t->cells);
     t->cells = cells;
+
+    /* XXX Shouldn't qemu_text_console_update_size() also be called here? */
+    qemu_chr_resize(t->chr, t->width, t->height);
 }
 
 static void vc_put_lf(VCChardev *vc)

-- 
2.51.0


