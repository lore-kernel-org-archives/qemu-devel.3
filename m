Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E739E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 21:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5Td-0008Cz-A3; Sun, 12 Jan 2025 16:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX5Tb-0008Co-84
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:26:31 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX5TY-0000vf-M3
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:26:30 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso646550366b.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736717186; x=1737321986;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d4NNepVux6n51/JRjYIzyWJMKeAsOsGXn2hlR+N3b1A=;
 b=soPDn1ayuQB1qgT0oGLqQ/tlEv8iYDDTvQE8JcvOz+yGeSYNgGgWh8n1EuPfgMnbNf
 6m5u3XGA9vqrzXDSXgqXDF8Yczti8xVqYaRr0EpPZn2ld9mDW6/o3Hs17eE3eXATkyCq
 md++SjyKONB3pFoGofOeNxAvOYrbOmoHxbo2UjVoeGBAGXRdnSE0zGA4UrJhI+CC0l9v
 JsTU4VJ/BVqvpz7xYM14wcLz1+hcJRaCcw/9FZjStak2sdzeiPq3izbNT7qEvDxANdyd
 ShUZYruspn2HxsE3Mf7A9+XTQ7RcPoABGY+FioOqluRb6Dr3MWhQNcYBFvdK1B0P8h2u
 qoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736717186; x=1737321986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4NNepVux6n51/JRjYIzyWJMKeAsOsGXn2hlR+N3b1A=;
 b=YUBZSiLXJrXMnJnyt9BltiU6uC79WHzPB/isX9M5LycJps2zpkpt5327maZe5JaRVF
 WzvmZoVZ40/DydVRkSxLQEAX1S6gqgEU55vJkrpY7ZLSJqEyrV8wwFCLflWXFe9CuS5F
 pcLDBcp+gv3bHZ8ozpAIu7WHWQBtArPNKxUVUq9vZCwsReaTrm8tYM4X62BurRELqwrV
 y5kOb6uhK0QsOrTNhe5jvk0uQeyYE4L6UJKh30III19qAvgIazVycjdMGUZlbJ39YsoT
 H7xFvtLrCKmWvqCLKNOTZAJdj4fRqtgLZJJPxl+/UGE/ACIpuEGyBo3VGPsroYSXZVpV
 QNyw==
X-Gm-Message-State: AOJu0Yw09n71nIJV+YeT9PGUgcLdbxKQN5JkC5Jyuxx56SCIaupOKgqb
 BGOThO0RRju2U0IW6vEr4r9CPOo1jegK1PO6TmWBPQF+05CXZqx0D1CBNyxSlOJlBQ2H4bs/7AS
 Rlw==
X-Gm-Gg: ASbGncuDVl/OZqSHiJz+Z2w4ShWwEhzUl3F3KzrydHjwOwWxCJy0wslAogOv3P70B7v
 SHjagGL4yxdsyn8bbcTpdtLgyH1guS39qV/QNEhLxKU9YD6qjoSF9TROEYp5zQFn87uLeQlSx48
 YcHo/vipPCWgZHTOQkGEfymAAAxU+Cvsu3t5x6Cw5u93zMfB4etnoOWhu8HKiAhzumBJFH/KptU
 XOvJ3TF9BnKVS3s/CT9BEsQUkhJIpeGz+VwvZ6Bs8HPCgrNaHUxLCHm3cgx/qRPHK9vBKKQU2um
 /gVDBn+Hl30CrOWiM4W3tgU3aW0JaJ4V
X-Google-Smtp-Source: AGHT+IH74f7li2Sp7g9Yu5piX7mGEQUvlQ1vF8csMssjNaizZrv6KmHGIL88u9YkYifJ50p4BvchSg==
X-Received: by 2002:a17:907:36c8:b0:aa6:9fad:3c1d with SMTP id
 a640c23a62f3a-ab2abc6f5b9mr1928399466b.39.1736717186256; 
 Sun, 12 Jan 2025 13:26:26 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c8ccc1b5sm416470166b.0.2025.01.12.13.26.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:26:25 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: phil@philjordan.eu, pbonzini@redhat.com, philmd@linaro.org,
 akihiko.odaki@daynix.com, dwmw2@infradead.org
Subject: [PATCH] system/runstate: Fix regression,
 clarify BQL status of exit notifiers
Date: Sun, 12 Jan 2025 22:26:09 +0100
Message-Id: <20250112212609.17996-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::632;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x632.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

By changing the way the main QEMU event loop is invoked, I inadvertently
changed the BQL status of exit notifiers: some of them implicitly
assumed they would be called with the BQL held; the BQL is however
not held during the exit(status) call in qemu_default_main().

Instead of attempting to ensuring we always call exit() from the BQL -
including any transitive calls - this change adds a BQL lock guard to
qemu_run_exit_notifiers, ensuring the BQL will always be held in the
exit notifiers.

Additionally, the BQL promise is now documented at the
qemu_{add,remove}_exit_notifier() declarations.

Fixes: f5ab12caba4f ("ui & main loop: Redesign of system-specific main
thread event handling")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2771
Reported-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 include/system/system.h | 1 +
 system/runstate.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/system/system.h b/include/system/system.h
index 5364ad4f27..0cbb43ec30 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -15,6 +15,7 @@ extern bool qemu_uuid_set;
 
 const char *qemu_get_vm_name(void);
 
+/* Exit notifiers will run with BQL held. */
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
 
diff --git a/system/runstate.c b/system/runstate.c
index 3a8fe866bc..272801d307 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -850,6 +850,7 @@ void qemu_remove_exit_notifier(Notifier *notify)
 
 static void qemu_run_exit_notifiers(void)
 {
+    BQL_LOCK_GUARD();
     notifier_list_notify(&exit_notifiers, NULL);
 }
 
-- 
2.39.5 (Apple Git-154)


