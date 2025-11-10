Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178AACCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU9w-0008U5-GQ; Mon, 10 Nov 2025 10:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9R-0007Y4-CF
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9P-00013s-QR
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2pGuJH4CZyEZq/sM/g3air/DGds7dY2gM0JmiMpLcY=;
 b=EhPnQI9U8NZefKEflshANL0mG8JbCYjYXplUfiWL4hlbE6qC1EqAiEhyPi8Dg5NuwHLw96
 EzDMtxCHZK4eSgL4rnH+ZdR3l79ioFftQ2mQccBdAY8HHJx7FaE34C6eYc19jiFXxvd2cj
 lNwY9/s8WlF5b8gxMVVOPMkQkOL+rEg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-dowbb93hNDqQuDtYqNzvKQ-1; Mon, 10 Nov 2025 10:49:49 -0500
X-MC-Unique: dowbb93hNDqQuDtYqNzvKQ-1
X-Mimecast-MFC-AGG-ID: dowbb93hNDqQuDtYqNzvKQ_1762789788
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4777885a071so8636635e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789788; x=1763394588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2pGuJH4CZyEZq/sM/g3air/DGds7dY2gM0JmiMpLcY=;
 b=nuHDg7mPu+6Ujhzsr1WipqJWSjsgiOb4GSHb6LcgYCd5fHG0pasfdNSoOGmpPuBDT7
 +ReGVtfdn81bDEFBvPCe5OSKrTkF727B3pIa3PJSMODxJ6JkVMdTDffxA+hqFCjDc/d3
 KWingD3MF9JlrZ4Dbl15VcqU8ggg2TlKwIf5ov/PWleKNucDZF6jHv/2Aa5fJ8MA2cRg
 6gsspeAzmgg5ASGUC0ze9RbEybhhKA22aY81k/IcdLDY2vYdu8UZ9tLlmmkC/63tEMJI
 98RiM+6FmC+4PibNmf3YFBX5Qlgu8pvomDfyGuA6PsM0Zeu6Fz1E7JA95vM99471HxMT
 n4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789788; x=1763394588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J2pGuJH4CZyEZq/sM/g3air/DGds7dY2gM0JmiMpLcY=;
 b=WRiCzdf5HspEvoQfa6KxZ2kgTPt0jXP8HfeXJ/wQbOpPfc4+zNdvS/5x+qCeCk5kLT
 /EFSOkFHtdaT4BrHr0rboL4RKuUkQugC3Qf+IQ/WzsVRQ+AVvfxc8XJehTpGkRX0SxFB
 cfLdT8pC11ob+95MZ0R031vzNaePrMnhyxkE3Z9Xmxf68Vv9LHGAJtPC7i5SKXxBQ1Zy
 UEKbNxwkzYgSFbdkCNz0pOxOTLpCBM6DcNByuL1EgaYAZENIMcfp0zdVr+kmGcDUB75x
 2dKaWmMBrnxqX3xqsmbD8xIDt24W0Z1/m71KVcYly1AvXwi8TUKIxqXYqQDAonT+TaPA
 SR4A==
X-Gm-Message-State: AOJu0Ywr1QXP9ywBTgRFgDkwYGKGCZisTUQ0zCKkWBTOtSZIegHxZNkX
 4zQbUsBQncjjaMuD2teTnUsERMX8JV4W0yLAEVQr3N1NDNyxXcTUolc2kQaR9s6UAmqFzMUiIVR
 495oCW2J4SMQg7dfYCnd6GTw9BWr9Qhyy5k6aSlnB6Vl0ccdXvKL4pKI4
X-Gm-Gg: ASbGncsNOLcUytSXQrWJR5lvbsqkGzfpoifu+J5mYyLBL3rnZH9ZBnXoiy6XB/98x3V
 vOj8Y5i8qbm5kzwq4lV18hpsKEmWkjm8tfX37FHj/cVgAKBifTdRO5+TCL9/6LTP7NBgffr73TP
 jY7XtSt4xy07HOHx522CJGlST4gTayG+WAVz2AaFv7eDlKw3WwOtncVKmQVl47ZKWHhMFwCEo0i
 zwxfWI1wB2tN8Iv/51SCXlv0eByFWQw41dze4dT28ck3WO5r7VgP8WWXKlCh1RdDwaID8b9Nl5x
 0e7uTQN2Q13cD2hlKMXMbBmJBcWqOVVno6dXuWit7Gm9BFH+G5V4FtjI3fMR61zRPWSi9kJPXTJ
 q/oHAwm+YdhdbwhEjIEi1jZ8KK9H+tHUj0Wszg715YB2iOWqctyKFmQSUmQ==
X-Received: by 2002:a05:600c:450c:b0:477:55ce:f3c3 with SMTP id
 5b1f17b1804b1-4777322d960mr71633955e9.5.1762789788496; 
 Mon, 10 Nov 2025 07:49:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6DGILhuAdQ4Zz6x4jacr5qtFaYvDlrVMmNcmBd35VQG0DI9hsmJrF1Kdug8/S2E5jHQcgMw==
X-Received: by 2002:a05:600c:450c:b0:477:55ce:f3c3 with SMTP id
 5b1f17b1804b1-4777322d960mr71633645e9.5.1762789788101; 
 Mon, 10 Nov 2025 07:49:48 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4777d9447eesm54863295e9.16.2025.11.10.07.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:46 -0800 (PST)
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
Subject: [PATCH v2 15/19] =?UTF-8?q?blkreplay:=20Run=20BH=20in=20coroutine?=
 =?UTF-8?q?=E2=80=99s=20AioContext?=
Date: Mon, 10 Nov 2025 16:48:50 +0100
Message-ID: <20251110154854.151484-16-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
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

While it does not matter in which AioContext we run aio_co_wake() to
continue an exactly-once-yielding coroutine, making this commit not
strictly necessary, there is also no reason why the BH should run in any
context but the request’s AioContext.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/blkreplay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index 16d8b12dd9..8a6845425e 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -63,9 +63,10 @@ static void block_request_create(uint64_t reqid, BlockDriverState *bs,
                                  Coroutine *co)
 {
     Request *req = g_new(Request, 1);
+    AioContext *ctx = qemu_coroutine_get_aio_context(co);
     *req = (Request) {
         .co = co,
-        .bh = aio_bh_new(bdrv_get_aio_context(bs), blkreplay_bh_cb, req),
+        .bh = aio_bh_new(ctx, blkreplay_bh_cb, req),
     };
     replay_block_event(req->bh, reqid);
 }
-- 
2.51.1


