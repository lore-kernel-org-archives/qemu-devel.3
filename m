Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC1FCCF9EB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmeh-0008HA-G9; Tue, 28 Oct 2025 12:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmee-0008Fw-NM
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeY-0003lN-A6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKOwvkHLUYnigJBYnl941OtlXmHokaK+jt9YcTIOSMc=;
 b=Tkp631uHSFoGMU8BW7dLVd44ZPtsCrnzBWlHBnazfGQCL5oARgBQL7lA8jRfYp0I9N2Mos
 jC98IaSwU/yueHIjUO8G1Rhhg9ovv1I2pQ/ploZzpvzapREu332EtDzDAltGLy3d6kmKhq
 85eypMUBN+r/XvqZurN7+T4LxbUAjvQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-XsAn8cpDNkSjJtsD5VeHsw-1; Tue, 28 Oct 2025 12:34:29 -0400
X-MC-Unique: XsAn8cpDNkSjJtsD5VeHsw-1
X-Mimecast-MFC-AGG-ID: XsAn8cpDNkSjJtsD5VeHsw_1761669269
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42705afbf19so36172f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669268; x=1762274068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKOwvkHLUYnigJBYnl941OtlXmHokaK+jt9YcTIOSMc=;
 b=pAvAM5Sf29+MirsWpKrPCyZPbXjmaQdP68r6wQ7ClkFmeOduUddiRh/veY/xe2PjmS
 velAYZ93sN/cMiUsYn+1m40hWiktQvR4kod7l9ZG4MfFYP0XWnf3Ke0gIxWx5xz/75xe
 V9NbhvBfgR4Gl0uP/CRDY2AfmjNNmoXPpG4WvKwNj4QcXI8E2I8NLgTtmggX1tHSWAyP
 0AhcEtHKMwuQFmhR2/z5OvmlOZZ0v0mWH9BdG39SNU63UqsCRq5vVoV6hSxOV4Wcb/2a
 2ne62nerc6j4KEAVRA/B2Cvo4Xl25NyE3abbOKISNk2PcLomVlHcJKV2ZGYUvfzy/Uyn
 Rk0w==
X-Gm-Message-State: AOJu0Yxs/EHYGjVYUJIUgYnsyJaoKJnFFjusrd6549hDLcJ0x6gAkxnp
 ldo198JoyR8GToIkF3WbPtyWspvRPng9Mri0OAb6Ipy6Ry65Z6qGnTga0ute96YzjsILPDidkkE
 ANCv1zDxB2fe6aM6RaZ9CrhObA6Doj8ggAeHpTv4vM0gP+Yz3YyVF9HTU
X-Gm-Gg: ASbGncs2dQwpEGUha7AwPk/E6v9RmKhj8GEd0/ein7PJTc5AD2+YKMxebYpYKTWvzSe
 Fw71D35A+m08R9W4Z3BOzqTOuB1eigvird/MmE4AQ5Z3ebUs0OOBhWFO4BDTyFqbBvafhPnPJ5S
 RbvMC+wHig6/UE6AxvsHZt/3lPXZRGRn8WKd8rBWfwNO1ER/dPn4iexP5xcLpQZzZERbGHdjy1T
 4HfHgwpDtyVpl8EgKiBCzU7hSHP5vSkLPw35+b7aXQvMVMbkhEke3XhqCwmaCcwBZuBy/0xe1BQ
 6RKH6o5Oc9oKrDk1yi+vUovnnnVbAA2Ih95fpDngSK64bn1eHefBwTtjwM7nWl3sastmuzhxREh
 ZOxIo58fl7tFzES3sQDSIif/yGKb7SXf+DT6y5RUFDs4qZ0ij45BjM9P5rw==
X-Received: by 2002:a05:6000:2c09:b0:428:3bf5:b3a3 with SMTP id
 ffacd0b85a97d-429a81a8479mr2893533f8f.1.1761669268443; 
 Tue, 28 Oct 2025 09:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBFbDG+5hwsnNdhEaoQ2eKmk3Nahb0xzwUB5LQN6en183Vbl+UhHk/vqF+CUXOe+rByFgYfg==
X-Received: by 2002:a05:6000:2c09:b0:428:3bf5:b3a3 with SMTP id
 ffacd0b85a97d-429a81a8479mr2893509f8f.1.1761669267989; 
 Tue, 28 Oct 2025 09:34:27 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5773sm23040414f8f.27.2025.10.28.09.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:26 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH 13/16] block: Note in which AioContext AIO CBs are called
Date: Tue, 28 Oct 2025 17:33:39 +0100
Message-ID: <20251028163343.116249-14-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This doesn’t seem to be specified anywhere, but is something we probably
want to be clear.  I believe it is reasonable to implicitly assume that
callbacks are run in the current thread (unless explicitly noted
otherwise), so codify that assumption.

Some implementations don’t actually fulfill this contract yet.  The next
patches should rectify that.

Note: I don’t know of any user-visible bugs produced by not running AIO
callbacks in the original context.  AIO functionality is generally
mapped to coroutines through the use of bdrv_co_io_em_complete(), which
can run in any AioContext, and will always wake the yielding coroutine
in its original context.  The only benefit here is that running
bdrv_co_io_em_complete() in the original context will make that
aio_co_wake() most likely a simpler qemu_coroutine_enter() instead of
scheduling the wakeup through AioContext.co_schedule_bh.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/block/block_int-common.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 034c0634c8..a584f20aea 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -508,7 +508,12 @@ struct BlockDriver {
         BlockDriverState *bs, BlockdevAmendOptions *opts, bool force,
         Error **errp);
 
-    /* aio */
+    /*
+     * AIO
+     * The given completion callback will be run in the same AioContext as the
+     * one in which the AIO function was called.
+     */
+
     BlockAIOCB * GRAPH_RDLOCK_PTR (*bdrv_aio_preadv)(BlockDriverState *bs,
         int64_t offset, int64_t bytes, QEMUIOVector *qiov,
         BdrvRequestFlags flags, BlockCompletionFunc *cb, void *opaque);
-- 
2.51.0


