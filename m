Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B176BC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfM-0004UV-QO; Wed, 26 Aug 2026 07:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfK-0004Pg-Qq
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:34 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfH-0005io-8R
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:34 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso1327240a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743169; x=1788347969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F31PMa12IiO/re93aMILk1LSzM11AyPxrVTqJ97tIV0=;
 b=BF2CDLC7TZYWRr56AMlvAfFxr4R8QRXwi8G8NwJ2EeyRp0B/gwZJeUTJbve/DsGIG9
 doWGg1uvgLMnUtMMzm87NHrY98n0bAwFsX1cpkDyRPkRkPygUpogM0wYI37ZGnVxV46C
 yz2bTM9sv8Qu0J456moH7NiXp2i81v66byawxIJko+qdSAoG8U7VJZpz103oemt0epp9
 Xf4GGlpmrp3wWaXYaLloih2jyRZ3qBUVDyDS4GjvURzG2BS4r7uiFgn+zx9gXnJkMcpl
 DGfRoIWSHVpiynRs2mjh1Ta+dWUd2n/xjhB7U7ILkek9fmxbbBHRSnvCJKYhFYdo4bBC
 9afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743169; x=1788347969;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F31PMa12IiO/re93aMILk1LSzM11AyPxrVTqJ97tIV0=;
 b=h95YI/fFov/rn1mW46y4tqpgCB4lApx59q2n+mMTAtxTBSGi/vYD08Gn6KfHYZN73E
 PNkOQy6sGMTMLWKLSpXdvaINvymwKawBtigw03JENmvtTVxNSEGUcpVkehChazV0jbM/
 buNDGBl1H8xTfX7IqCmEneIyC5W8XuzniG2FTMlmHixl/ulyXbJ8+L1eC9Z56czwWi9y
 lRkroZfRyXnuhW4fz1sb4mFHhJ/e7Ro3zV+UJBlRAZ+oZmAFO0r0mduy8u1CGtbyjUN3
 zLHq1n3ljek500Jmh89SuMWfXuTTSiRSSRZq1U0at5C6Qdw93f+/X6CA7Pt9+Meia4mY
 RoXg==
X-Gm-Message-State: AFuF++npPCmdrCEtf7RBi5Y9lzYWpHS28XlFcsXg6PleRBKt5G7j4LfV
 eJ9AG9VffWKmcLaL2+Zw3/lTaGLCUz5XBfYjqwvBLBqkBFcjwlnjFZJgkl1tmTi+2iWINI4nGsn
 +6qtB
X-Gm-Gg: AR+sD13GfmTDxZoWHwk+CwXto+MoiQ5Kt+0ftiUDSwpFeeKdNbUqcNaSlJUe4otMFfA
 B+N0JVz+TiICQ4HZMPDp4g00p+AiJO6Vzhy8JMz6lvYjMvkjg92wAoDHKVNbsSbS2/pLjVVWSHs
 +iWdlM1vHP8eHZZoQSeJSQsAenXBLWkozY8Ewmw+0s9i0tdGYwJ5VwiJMNDYDfP1cCm+6yHAEPr
 Sz16WtuRwVpZxi7WtCVUtmlPWISwitUdCWb3Zd2sePg8ncdDhRS4l4ZtjT0o5Pm0ZPvs3wySo45
 lEV6EcWxiBsuV3TWeaSzkxMGCuFnI/TtFq50dfWQIPT8Lun3F539UHWLkLoOBb+thBBQ/XbUBKd
 t6bZnJKiQCaMnUV6X2VYvU0zpAvPuHNnE54xSX/PBHkS5O0/b3CxejbFC4KKzjTl3ylO4z/DKb7
 pxxkVS6KbH3C/38Yy/WzsRtJH21RtuYAOYHAiVv+FQHTGIGw/I
X-Received: by 2002:a05:6402:11c7:b0:6a1:fec6:3307 with SMTP id
 4fb4d7f45d1cf-6a5df5e3eb2mr9205827a12.7.1787743169499; 
 Wed, 26 Aug 2026 04:19:29 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:28 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 XlabAI Team of Tencent Xuanwu Lab <xlabai@tencent.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 18/28] hw/ide: reject an out-of-range PIO transfer window on
 load
Date: Wed, 26 Aug 2026 13:19:05 +0200
Message-ID: <20260826111915.3387926-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=den@openvz.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

ide_drive_pio_post_load() validates end_transfer_fn_idx but takes
cur_io_buffer_offset and cur_io_buffer_len straight from the migration
stream, so data_ptr and data_end can be placed anywhere within +-2GB of
the 131076-byte io_buffer allocation. Both fields are signed 32-bit.

The subsection loader consumes every subsection present in the stream
without consulting needed(), so a crafted stream can inject
ide_drive/pio_state for a drive that was never in a DRQ state. Once
data_end is out of bounds, ide_data_writew() only compares the guest's
pointer against that same bogus data_end, and the resumed guest turns a
repeated outw to the data port into a controlled 16-bit heap write.
end_transfer_fn_idx picks the direction, so the read side of the same
code path leaks host heap instead.

Validate the window against io_buffer_total_len and fail the load. The
subtraction form avoids overflowing the addition.

Reported-by: XlabAI Team of Tencent Xuanwu Lab <xlabai@tencent.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4179
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3738
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 8190549ee8..0dca2b5c52 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2898,6 +2898,12 @@ static int ide_drive_pio_post_load(void *opaque, int version_id)
     if (s->end_transfer_fn_idx >= ARRAY_SIZE(transfer_end_table)) {
         return -EINVAL;
     }
+    if (s->cur_io_buffer_offset < 0 || s->cur_io_buffer_len < 0 ||
+        s->cur_io_buffer_offset > s->io_buffer_total_len ||
+        s->cur_io_buffer_len >
+            s->io_buffer_total_len - s->cur_io_buffer_offset) {
+        return -EINVAL;
+    }
     s->end_transfer_func = transfer_end_table[s->end_transfer_fn_idx];
     s->data_ptr = s->io_buffer + s->cur_io_buffer_offset;
     s->data_end = s->data_ptr + s->cur_io_buffer_len;
-- 
2.53.0


