Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4888DCD5BB5
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3tA-0007Dd-Iz; Thu, 21 May 2026 09:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3t3-00071Y-Hx
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3t0-0000kv-DG
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5cC5Lra/XS1ca25R2emCsvoivsZouoKYXejYAM6KjIo=;
 b=AALiCW8lI17R/Ishb4QsZ/ZYmAVcw3nrEam2M95eRAtZO/nDKQUPXqogsK/7JZ22Bi1buo
 vNK/x4VEeAMBPA44vgJbm15g9176chfnPuM3u2YwUV6mE/v8Z54mNw3YP/c0R4toiVDaY5
 Yphkuj3JVGT/KbhsupOc5OvDVIMcLvA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-h7YwFr9OPwSFvKd_F60ElA-1; Thu,
 21 May 2026 09:56:28 -0400
X-MC-Unique: h7YwFr9OPwSFvKd_F60ElA-1
X-Mimecast-MFC-AGG-ID: h7YwFr9OPwSFvKd_F60ElA_1779371787
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95FDA18002F3; Thu, 21 May 2026 13:56:27 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 656A5300019F; Thu, 21 May 2026 13:56:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 05/38] ui/vnc: fix OOB write in VNC stats array
Date: Thu, 21 May 2026 17:55:16 +0400
Message-ID: <20260521135551.1752945-6-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The VncSurface struct maintains update statistics in an array:

    VncRectStat stats[VNC_STAT_ROWS][VNC_STAT_COLS];

where the dimensions are defined as:

  #define VNC_STAT_RECT  64
  #define VNC_STAT_COLS (VNC_MAX_WIDTH / VNC_STAT_RECT)
  #define VNC_STAT_ROWS (VNC_MAX_HEIGHT / VNC_STAT_RECT)

If VNC_MAX_WIDTH / VNC_MAX_HEIGHT are not an exact multiple of
VNC_STAT_REC, the COLS/ROWS will be undersized by 1.

Unfortunately:

  #define VNC_MAX_HEIGHT 2160

is not a multiple of 64, so there is potential for OOB reads and
writes in the 'stats' array, if the guest surface is over 2112
pixels in height. An array overflow occurs when vnc_update_stats()
records new statistics, either scribbling over data later in the
VncDisplay struct that 'stats' is embedded in, or performing an
OOB write on the allocated struct memory.

Fixes: CVE-2026-48002
Reported-by: boy juju <agx1657748706@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260521103353.1645561-3-berrange@redhat.com>
---
 ui/vnc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 0750bf5f72f..c8d87cd5301 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -85,8 +85,8 @@ typedef void VncSendHextileTile(VncState *vs,
 #define VNC_DIRTY_BPL(x) (sizeof((x)->dirty) / VNC_MAX_HEIGHT * BITS_PER_BYTE)
 
 #define VNC_STAT_RECT  64
-#define VNC_STAT_COLS (VNC_MAX_WIDTH / VNC_STAT_RECT)
-#define VNC_STAT_ROWS (VNC_MAX_HEIGHT / VNC_STAT_RECT)
+#define VNC_STAT_COLS DIV_ROUND_UP(VNC_MAX_WIDTH, VNC_STAT_RECT)
+#define VNC_STAT_ROWS DIV_ROUND_UP(VNC_MAX_HEIGHT, VNC_STAT_RECT)
 
 #define VNC_AUTH_CHALLENGE_SIZE 16
 
-- 
2.54.0


