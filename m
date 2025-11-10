Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB96CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU9z-0000L2-59; Mon, 10 Nov 2025 10:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9V-0007d8-8I
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9T-00014j-9Z
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4urNL7p8q32yW3vnjExo0mWUQgRDxHTQkHCJr50ZGAA=;
 b=hbLY6B/rjXsF4nz3BILXYUbkOfnroekpkrh/LqsU3mc7tqnDfIaiAiL6A/xoBfK/Ao9szL
 GyIFUOFCAY45nqwYh741dUyEaW770DFdslm+N9rrRQ3vCcb0ribH9NfrGHaDyKMtClJMdp
 Uyn/sW743LL79rOQvIuZwbHCQec+ZWg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-2Q3KUAzaMoqB4KSRwEHlCw-1; Mon, 10 Nov 2025 10:49:52 -0500
X-MC-Unique: 2Q3KUAzaMoqB4KSRwEHlCw-1
X-Mimecast-MFC-AGG-ID: 2Q3KUAzaMoqB4KSRwEHlCw_1762789791
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b3086a055so1419188f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789791; x=1763394591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4urNL7p8q32yW3vnjExo0mWUQgRDxHTQkHCJr50ZGAA=;
 b=O16+4Vh3+aDs0xlpeUEFSUXveMM7FBn6HVX/HFICxG8nRH6P0UNlM8APkHCtiEEf0I
 kzVH4z62ttwPAQ6HHocrJxd7NNv8fqRkb3DCXIp/viBKZnS/DIrgyIVvCnCwDifxwcfG
 t9DP/uHlLbJDV3FO50i7/SqETIozVaQY+JVlGk72nm/bqJXygjx3TM/ZePqjSUuXt4tZ
 aeOUl/NZ8arH1N1xe1TqubJv/XZ7gx0WvmyMRet9oD7hhyTTVoU5NTNq5o37HROIHlPJ
 SiRV95qs1qQ57okmc0ISrczMqrjT8BikBP+VITTvtQKKHmw5HqVstGfv8+6FT1WSU38P
 SDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789791; x=1763394591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4urNL7p8q32yW3vnjExo0mWUQgRDxHTQkHCJr50ZGAA=;
 b=J6pK0DxRb2TpBskwutAc0EGIeIIFaiRkFOQ8XVcoZqHsXW4xAnY8jnhl/ohxO0HSFy
 Qm+1aQBoWqJMh/yct0L2ZrogsVpx8iyjZEG0cnYHExw2EbEQEDzRmGPQpB/hColZPqxx
 HpXbpJikp+pNj7CLBXPOP/m09fGiOMTTv1ASA7a4NydJ0ujJtim3IFs1bbxLBgIt0u3a
 e2BlvqR/jTmQCxifYyGCWP3TLiTWwOSOn44uCs9v+T00qm3+gE/CtzUW16BM0Hqibggo
 U8zu5R70wEiNe6Xrag7sNnqrVUp6QA6I52ovcLt0scQ/oUSelR2BpLbFeIsuCHhmbo9C
 lx3A==
X-Gm-Message-State: AOJu0Ywit0GUNqeTJvLud8CixRmXi2yPf/wuncRoNr9vCm31Xkk7I9ui
 y3zgghoH9TzY9nz2bDxnR6xBfBJ53YzkTh0xxmgzr+ZhKS9+Viul4JP3Gv59yl4urXXblPCR2bh
 oevw9itwAG5oXxvMesa87OtZdnRDKJ4cUtGVXfNGw+bD4/DjPExQ5Z+0K
X-Gm-Gg: ASbGncsNwtoh/6Ke8pFerIWZX1kg/ExvmPB3h7kFgXdTUP47VQdSPF5qPvoDaneP810
 tLxsSmgl4RXG9Ay1FiY8aLmrhMTW229RrC4KtEHj0z6yJ6HnoDXBAzCyGC2yT9hBJCAzaUuV4yx
 09e7aJjK1GarfYqLtwW0arJid5PVZGj6VN7/jpKggjmvbGcuniHkXgxeHgpnpjIqCvVm9BzfG+9
 qW3Mx02uMUVlzqigosYnx2WUBmmfWLu1PDga06ZueNow5sw0RMHydX2mHlgeC6Nw+4lKqR1uTan
 P0BSXa7s0Xas/FSbxE4wRn8EjsbrNgD+FiN0u01r51FDF+u4OROGVl67aNEufLpmDdms1cpoTH3
 Qpbpnu3IVXUaI00U+4rOPGbhwkPFwsSwzmRaVgM5XwvxLMuEX3SQxva3TeQ==
X-Received: by 2002:a05:6000:22c5:b0:42b:3220:9412 with SMTP id
 ffacd0b85a97d-42b32209687mr5078006f8f.28.1762789791050; 
 Mon, 10 Nov 2025 07:49:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVynldXxCXJYEZMwyF3pQ5OuWWw0uHHjUE6doVcbTYH01/4I8RNEPeyDayhMghq38ADBVlNg==
X-Received: by 2002:a05:6000:22c5:b0:42b:3220:9412 with SMTP id
 ffacd0b85a97d-42b32209687mr5077986f8f.28.1762789790634; 
 Mon, 10 Nov 2025 07:49:50 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac67921c3sm23228671f8f.40.2025.11.10.07.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:49 -0800 (PST)
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
Subject: [PATCH v2 16/19] block: Note in which AioContext AIO CBs are called
Date: Mon, 10 Nov 2025 16:48:51 +0100
Message-ID: <20251110154854.151484-17-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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
index f2a4e863fc..cb0143ea77 100644
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
2.51.1


