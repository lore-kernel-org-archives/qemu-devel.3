Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC7FC36001
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 03:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvTFB-000344-2R; Thu, 20 Mar 2025 23:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tvTEz-0002uo-CF
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:40:14 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tvTEw-0007zR-58
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:40:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2243803b776so7205ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 20:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1742528408; x=1743133208;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1hCtd9dYunSUjFNV0cjKUZjR/xU72XhqBS5IQVPKFA=;
 b=Fl/eYsvF71/vcJRCbfJmcJBMjUeJ1MgFV90xSOdUtSGvVv88FXtH6/qDphnDUUwgyo
 e0HtlSVy4RRFePD3nof7GXSVWHluQMWJV3H//exDEI181VdCHtFOEjIQHT+/bKQSZ6R1
 Z6Ouyph4gTlNAkV27B2jZrwMjALCWLeLIM6B15RDJjxCAZixFHaoceSLaCXz4E3HSBYO
 S/or4DUn5aQ9ENotU1jKKfgm9xqQAiYxiirazkdiNh1Y2WeOKQrwg3dshlT0PCMmziR6
 3a5+fhkRmfsxcOf3CdkBb4Wk5uIR9BgX3WAN2dU5RsVStT8jN25IuY/xjLSsiWQ8IAAN
 QfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742528408; x=1743133208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n1hCtd9dYunSUjFNV0cjKUZjR/xU72XhqBS5IQVPKFA=;
 b=qkhpKcCZ0tgPm6LlkHCJ0o7PbHjTBPlJOMUia8mNAb5jwKzFrQyqnQVcsdmy+0TVeb
 VKEmQuPPpjZyGv/3ioOw8sZyPkV/94ZBgD1T0fq5y6+EZbWbFfBV28NOb5Sl7pY71l0h
 sOyC78kCQf486Ij9s1uJ5d9Or27pAFsA2WZPALfLV5DKShK3vQSWPRGKVIx2wfcHVYPs
 xlRdxP30FhCxuFKX/fi4CRYp2yJP3DKFy7fTupVUitAgLI7SX4BJb1XyBInMuxBrDMId
 /r0Hau40ivun1VeYU/kB+Llnnc2yOebRY22ESEBMnV1yOG6fLU1o94OXeAW54KHUuL1j
 gtsw==
X-Gm-Message-State: AOJu0YzzGmdoAUCo7u+Jxox+6P09vayhGhyB7Mj+r5j93LRzckkLOkOP
 XfjWgXYLWrAOaeMFGE0GGMVBCj4UePcQxINzevACIjiqjaA+phd9tHG5839qLZWXYUKGzmDmF+6
 OjiyjE7+d
X-Gm-Gg: ASbGncvUGua/usken5myItIFIZSA9rryko1NQDC/zb86Y7sJTcJ6mpZ8LdlO6cD04JA
 llR0r+tjuq0/cRFK/WePPJGEB3PpiC9RXwO9NKjQuezu+8ZwzWT+zJBVsu99ijedwg9TYXAnakM
 acM+d5iKsHlkWIh8tp9d69OhHSFX++wFn4ITaa4I9OM/Ht4CdZZg3naD7XXO08VPVoBYFlMJaI2
 T4nZ9g+NNHwPj++cPiK1DqqZ+9dTb8sqvoG9MowC9sBQHs/EzLk2i34YOFoKf+egPD5AyadZKaF
 PH5N0i8/9ni5BDAml3/cmXDMLVAgDKWnxrxh9V7vxYqR7vb4G/bK0mFhy9B66sSoeg==
X-Google-Smtp-Source: AGHT+IFd/u6L10FCROZawOIVPLR6+iJiVVLG8HGp7aNxQ2g/y+SvD/LyhCYWUcNELXIWhBZcYbbfow==
X-Received: by 2002:a17:902:d4c5:b0:216:644f:bc0e with SMTP id
 d9443c01a7336-22780d83716mr30101705ad.24.1742528408057; 
 Thu, 20 Mar 2025 20:40:08 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.85.74.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811b8075sm6079725ad.128.2025.03.20.20.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 20:40:07 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, dengpc12@chinatelecom.cn
Subject: [RFC 1/3] vdagent: Wrap vdagent_register_to_qemu_clipboard function
Date: Fri, 21 Mar 2025 11:38:11 +0800
Message-Id: <3a43d9d9816bc883e4e5a5b4999d6a7f03433a5e.1742527956.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1742527956.git.yong.huang@smartx.com>
References: <cover.1742527956.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

For direct use in the upcoming commit, wrap the vdagent
registry logic as vdagent_register_to_qemu_clipboard.

Meanwhile, add a trace event for vdagent_recv_caps.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 ui/trace-events |  1 +
 ui/vdagent.c    | 23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/ui/trace-events b/ui/trace-events
index 3da0d5e280..427a8383cb 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -140,6 +140,7 @@ vdagent_send(const char *name) "msg %s"
 vdagent_send_empty_clipboard(void) ""
 vdagent_recv_chunk(uint32_t size) "size %d"
 vdagent_recv_msg(const char *name, uint32_t size) "msg %s, size %d"
+vdagent_recv_caps(uint32_t caps) "received caps %u"
 vdagent_peer_cap(const char *name) "cap %s"
 vdagent_cb_grab_selection(const char *name) "selection %s"
 vdagent_cb_grab_discard(const char *name, int cur, int recv) "selection %s, cur:%d recv:%d"
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 724eff972f..7a1cf674d0 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -694,6 +694,18 @@ static void vdagent_chr_open(Chardev *chr,
     *be_opened = true;
 }
 
+static void vdagent_register_to_qemu_clipboard(VDAgentChardev *vd)
+{
+    if (vd->cbpeer.notifier.notify == NULL) {
+        qemu_clipboard_reset_serial();
+
+        vd->cbpeer.name = "vdagent";
+        vd->cbpeer.notifier.notify = vdagent_clipboard_notify;
+        vd->cbpeer.request = vdagent_clipboard_request;
+        qemu_clipboard_peer_register(&vd->cbpeer);
+    }
+}
+
 static void vdagent_chr_recv_caps(VDAgentChardev *vd, VDAgentMessage *msg)
 {
     VDAgentAnnounceCapabilities *caps = (void *)msg->data;
@@ -711,6 +723,8 @@ static void vdagent_chr_recv_caps(VDAgentChardev *vd, VDAgentMessage *msg)
     }
 
     vd->caps = caps->caps[0];
+    trace_vdagent_recv_caps(vd->caps);
+
     if (caps->request) {
         vdagent_send_caps(vd, false);
     }
@@ -720,13 +734,8 @@ static void vdagent_chr_recv_caps(VDAgentChardev *vd, VDAgentMessage *msg)
 
     memset(vd->last_serial, 0, sizeof(vd->last_serial));
 
-    if (have_clipboard(vd) && vd->cbpeer.notifier.notify == NULL) {
-        qemu_clipboard_reset_serial();
-
-        vd->cbpeer.name = "vdagent";
-        vd->cbpeer.notifier.notify = vdagent_clipboard_notify;
-        vd->cbpeer.request = vdagent_clipboard_request;
-        qemu_clipboard_peer_register(&vd->cbpeer);
+    if (have_clipboard(vd)) {
+        vdagent_register_to_qemu_clipboard(vd);
     }
 }
 
-- 
2.27.0


