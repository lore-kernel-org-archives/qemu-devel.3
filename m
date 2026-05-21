Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EA7CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ22U-0005H2-6U; Thu, 21 May 2026 07:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ22J-000582-1r
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ22H-00045L-MC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779364676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5cC5Lra/XS1ca25R2emCsvoivsZouoKYXejYAM6KjIo=;
 b=DJDeFzde3I4yi+N536Vpc57P4IJ4xd26QB5jpB0PiMzfUFQgf7kiKf61NplaByGAyH0wFg
 pfCBD05nOpOnWgkDviGPDzEn13K3SswI7aFNM7mTEnBUOq2FJNQl1NtlmAQOkn+1zxeJ9y
 WkVoJhUY0zWB6V9nLgoESgUnng1f+gE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-KQTmiEc6OzKOKAcC25t3_w-1; Thu,
 21 May 2026 07:57:53 -0400
X-MC-Unique: KQTmiEc6OzKOKAcC25t3_w-1
X-Mimecast-MFC-AGG-ID: KQTmiEc6OzKOKAcC25t3_w_1779364672
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 218091956094; Thu, 21 May 2026 11:57:52 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 995091681; Thu, 21 May 2026 11:57:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 05/38] ui/vnc: fix OOB write in VNC stats array
Date: Thu, 21 May 2026 15:56:42 +0400
Message-ID: <20260521115717.1701482-6-marcandre.lureau@redhat.com>
In-Reply-To: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
References: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


