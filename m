Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ADFCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnuN-0004HA-GF; Mon, 05 Oct 2026 14:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetan.singh.foss@gmail.com>)
 id 1xDmkm-0002Ts-0w
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 13:45:32 -0400
Received: from mail-pj2-x29.google.com ([2607:f8b0:4864:39::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetan.singh.foss@gmail.com>)
 id 1xDmkk-0007vW-7t
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 13:45:31 -0400
Received: by mail-pj2-x29.google.com with SMTP id
 d9443c01a7336-2e5c5972d64so1212685ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791222328; x=1791827128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ivl1TnK3JTQ7nFpGECciLmlESbZ3lrC/uPueko9OMSo=;
 b=hwrqn+U16jNhV8Floz8r0mDFkKJ841w9oLcCK0L45trYj5uKxzvsCeUid6A18fl19x
 GwLZ+r87J+vOwqGvsxwdGucnGW3bDWwtxvzuo3558k9ZTvKZyXR6BSbQIQRD0SoWbBuD
 mjpJwRnTIQ78cqeLdModDUgOUYYnIWZm7qgQUvBXwwHrfWS7UJjoO96OlEZaJcEkHMt7
 Y3g4V31vfBQ6xR1ZOQa95GbFSFkv2mtvRQHk72TMpeVl2bZXzYSrfP2dUWi+MNkEB6Hf
 nTOfOMtHUNvvy7wiG4sKV/Xfw3jONqH+SNjuoUt7UVaUK8a3FIA9wxhT4JqhF87Z6bjU
 jzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791222328; x=1791827128;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ivl1TnK3JTQ7nFpGECciLmlESbZ3lrC/uPueko9OMSo=;
 b=0H60zh053Db2NmD+b3MWMK8XQLojFH+C5sLfGeI83QeRys0J7MdbNt4XNIlv9W3N1w
 m/UhloC0BLoEtpIWNrZnxKlQDiS3CfoBHGSnG7oCq26+wExkmgsBVO5ATU86DOKQ0c4+
 SIXqia7bDPx3GcBvD81qsybLO/VqkyjBNk0VdxEtkQimFpzzGKlGigIumnFdVOCxQNfS
 yapA57LV2pBCo4qMJl4WN5wb55yXJGBOiz0UHIL5BlfHCu+b/6tOVb9OQ/24JdeZqtKJ
 0cTBsEl2B9QWdG0x0Wtd6HZnUBadvFsnIURgvr1u9ruVg8au9rGb/57qaKRDFgWWnj/z
 6Xgw==
X-Gm-Message-State: AFq9FYIf71Jg71Ncn47fM4u3IzhKGPoh5AzCpUKWegsSuSGszT/gaFeP
 BN+IlPStYOfXujVKum/b0wor0f8pkJvAp86+uZhbZv6uFhb+4jToqW2Lo8GHS9hCzZ8=
X-Gm-Gg: AYBFou3xF7yI7PwzbNvDxwiwYWnvH2G4YoZkicWhhCUA6TcoKp01yQbdv45lY4mQfQ0
 hsoY6UjO5qGfOr0QKTsYBAQGxu/DAAiqgf9HxcYgjxm65+9yodtM74KzxZr4dy2ikUCD91678+m
 CugpL06C0O2d0k9kbkBMDjvGaCAAT66g/bjXIkn8JOmyGrHr1bss5IlmqMDvhKraY+q9Y6OM+Gt
 f6qyLR0ft57higynjm9nE6WRymSPyAFNuw7D6xQhs6Wm+od2Jd9ldZ2eYT6QhA4Q5UjwWULCD/4
 ovPEFXnCTxOtNNhiqBjPMD+lNAX0/C2KMBBovoDp9cHgWQfyILw3Y5eV0VHZdnAeneWQ/Tjr/L+
 TVpbRzLCxVKqvI38POaW9X/1GUTzWymCOui2pS/8uEwqpm1Ze+LWW7Qw++9erhUOFYscS0D2LKe
 6wbugskmphofAm+6cgVRW4V+Nw6dc7xuqQxZENTRCcnb3oQlzmMjRjGZH6YJveJOqvI2XpNg1Eu
 wXcejsAuTCpRfK6baR1BZ1jXLEMMAOwi6eMhjx58h9laRSxD2lWHZJarvf9wTnPyiPCkHJwv0xy
 hJukq9eE5Q==
X-Received: by 2002:a17:902:ec8c:b0:2dd:ad74:ac7f with SMTP id
 d9443c01a7336-2e49b6808d3mr104720975ad.26.1791222327648; 
 Mon, 05 Oct 2026 10:45:27 -0700 (PDT)
Received: from Skynet.localdomain ([2a00:79e1:2e01:b01:873c:31f4:e7e5:8ecd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5a5ec7bf7sm11244045ad.45.2026.10.05.10.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 10:45:27 -0700 (PDT)
From: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>
Subject: [PATCH] virtio-gpu-rutabaga: make sure ctx_ids match
Date: Mon,  5 Oct 2026 10:45:22 -0700
Message-ID: <20261005174522.8663-1-gurchetan.singh.foss@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::29;
 envelope-from=gurchetan.singh.foss@gmail.com; helo=mail-pj2-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 05 Oct 2026 14:59:19 -0400
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

The ctx_ids need to match as well as the ring ids for
proper signaling.

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Signed-off-by: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
---
 hw/display/virtio-gpu-rutabaga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 3aafa4dc66..edf7b62703 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -902,7 +902,8 @@ virtio_gpu_rutabaga_aio_cb(void *opaque)
         }
 
         if (signaled_ctx_specific &&
-           (cmd->cmd_hdr.ring_idx != fence_data.ring_idx)) {
+           ((cmd->cmd_hdr.ctx_id != fence_data.ctx_id) ||
+           (cmd->cmd_hdr.ring_idx != fence_data.ring_idx))) {
             continue;
         }
 
-- 
2.55.0


