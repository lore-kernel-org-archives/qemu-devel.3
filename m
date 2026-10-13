Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5618ACA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcUv-0002Xn-EK; Tue, 13 Oct 2026 09:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUq-0002Mw-Mv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUp-0004l2-Ai
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5tZt2GKPFxcvJcqH7pbVZWVa6OrcAcgZ+nFbcOuK5s=;
 b=iKY6xnGnIga5PIMb0ZiAgNceVR16ZDO7o8QYBRlaMC6dwcVKeYFXk3tMCR/l984083vr6E
 M10feIDSPYe1OzxRcBU9hYvzj3MGJJgMebDhmrw12OqL08shjpXVxG05Bvfy8qUF6tC8mu
 +Dm2zyoqvMzv5q8PLL+Gqw9fPoJAu5s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-PWiu6hSrNTqFrzwJ9PvldA-1; Tue,
 13 Oct 2026 13:24:45 +0000
X-MC-Unique: PWiu6hSrNTqFrzwJ9PvldA-1
X-Mimecast-MFC-AGG-ID: PWiu6hSrNTqFrzwJ9PvldA_1791897883
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7029A1801339; Tue, 13 Oct 2026 13:24:43 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7ACF11800446; Tue, 13 Oct 2026 13:24:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:19 +0400
Subject: [GIT PULL 22/40] audio/paaudio: avoid pidfile path truncation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-22-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ke1CB+LepFRjcu3taLa9/9AW99V1bxXDH2iGD/NUxb4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDDYsJKj5TP8xaHT9bRWkW1lcrLGiBHrZYe1
 gts1imt3HiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwwAKCRDa6OEJdZac
 5cE8D/95ngwa1HqDzNf9PCEkumhh+sO/W3jv1FjhfvGLsxGspapTm8vu9mNwL9sMr7D+Bz7AU0b
 bj/JfJZr26jXKS7+gfGUXndgpCXCFkMy5xPmcoZ2uGFbEp9NYiRkp8RBkDYZhNaCwCBh60pIzmE
 ONm3A7JFqpMnExs229UISQ9oUXVR2WWVlv3+wKpsaw02Mn6RlO7Ds2c0tb6r6jBqmant8hF2aeO
 Rnyaewvz7T38gHrTUnr1RYV9ZV4El9/UmZBGpBrAuAOIWSWAvtNY1EvJ2cKGu7MNQ1Ic7kBRiOC
 Au/zkwlyVoiqzZWXODvAYg+SCZwRJSh0GdwSDk/NhJg5YdmmBwLa2sTdfzlpWtobjraN1chD12t
 Z9XjvcxZuU6jZn0P7EmfxOGBwFaXLojq3mm4zVbE5deGzIFTRSHUUdJjpU44zZ1fYvuQX/d/HsQ
 FL4trWCdyfTqAiND5lw0tjHA76WWZPCbjokjMMHbm6P6fRXkPY0enumPU9P23FP6pfE9blu4mDZ
 r1G0QBoIR27icq4pKoZ5mbC5lZJAfcOGIMXv/twDqd11+vKvtxvNTtkAyUS/BDXUaywTAk1Eoeh
 cxbKzjQL1jhZBnfGQCjX3alWm/o9ws/MdQ7CDfyK0eBh78xul8VCCb22qoa8yQUGKVTgn2Gm8kU
 5AiXIsYggNNKx0A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

The pidfile path is built with snprintf() into a 64-byte stack buffer,
which can silently truncate when XDG_RUNTIME_DIR is long. Use
g_strdup_printf() with g_autofree instead.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: d175505bd68d ("audio: check for pulseaudio daemon pidfile")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-5-ccbef537cbeb@redhat.com>
---
 audio/paaudio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 9d0a622fc5e6..358595c0460e 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -819,7 +819,7 @@ audio_pa_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
     }
 
     if (!popts->server) {
-        char pidfile[64];
+        g_autofree char *pidfile = NULL;
         char *runtime;
         struct stat st;
 
@@ -828,7 +828,7 @@ audio_pa_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
             error_setg(errp, "XDG_RUNTIME_DIR not set");
             return false;
         }
-        snprintf(pidfile, sizeof(pidfile), "%s/pulse/pid", runtime);
+        pidfile = g_strdup_printf("%s/pulse/pid", runtime);
         if (stat(pidfile, &st) != 0) {
             error_setg_errno(errp, errno, "could not stat pidfile %s", pidfile);
             return false;

-- 
2.56.0.116.g6de20f6092dc


