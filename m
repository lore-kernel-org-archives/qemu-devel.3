Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF70CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmem-0008Hp-EL; Tue, 28 Oct 2025 12:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeh-0008H9-5O
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeZ-0003l5-Eq
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYlDCqfePfKFAXzhes0Ls7/2EJ45+SPgejhrNbx5E00=;
 b=btL1gO72d5ENCuI7ZcHKXF/7E9tR43z6n39fxVlc3m9gNrAAwJvrU6ro6gq41LK5M7HpsU
 kgDG8QU2eyWQ5A16x0Sa7135/4g0ZReUysBQZrU/25P6lGJYLSrKpFM43fE2hmsHHUx9HZ
 q3vVXmtOUeUzq11ZRJtCnfOS9jYwZOM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-0k-JpHIjNQuukrkB0fo3WA-1; Tue, 28 Oct 2025 12:34:27 -0400
X-MC-Unique: 0k-JpHIjNQuukrkB0fo3WA-1
X-Mimecast-MFC-AGG-ID: 0k-JpHIjNQuukrkB0fo3WA_1761669266
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475db4369b1so27077715e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669266; x=1762274066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oYlDCqfePfKFAXzhes0Ls7/2EJ45+SPgejhrNbx5E00=;
 b=dsJF+7SctdnuIp8P6SrJkWywMA6TFQaynBXjEYO10Wm9VhC1jNNMK+Xf8YFObf5hoH
 mkryhtHPu+SG2sgNfnTq9cNPAVBjxHfjHLeZmxpPbEiqrctbDJjFa4/oRdiAbQAsOOU8
 1tw0mTmUDpHrMGBfS6deIGX5O34tVIq957iUHQDgZybRqz9P4eUEgHuTobugIr3nFLAv
 r8V9Ia+LKjxJgGXY0cguva2rJ6HE257nZpTyklf8dH0SjhBuqShdKNXXBiKATxAtjOKO
 Fq5sYSw4AZSNjpDiRu0Ve0q2s88Ou3/oV1xr+WlghmM5Yqig/LrNh9JhamsqVw/SIlvF
 vuyw==
X-Gm-Message-State: AOJu0YwcJkxgPWExq1robxt6vxSoYG4441jfKYO7JCBbYAgWya3CJWAA
 A4QHi94oFvTjAo8UaMUF23PLQGhjQO38iS6BK4FSbV31MprLIvYNO/yh3DRQP+ZyrOTel92wT9B
 oY0P2Q51XYjv6aSESnx9aHdaYxOfv0ZpmxQbKDBnBQ5TXjI8QsjFmQNW0
X-Gm-Gg: ASbGncuPkBGhHuJRavfV7PHy5HclAf/YiCon1BIhnozPjBiFUIMOy8RF62Yi/WJJ7Zw
 rmbO6Czem+/3xv51vJLlryfbOsRd3velulp9FXsr2kaBWdhxBeRt5ILrz+jQY2sIzj/+rT7I8ob
 7swK3DkdOMBeJ9iNh4LV6kIBc1OTr0+VlsdqfmXo0gnp4hHrgFDDP9+5bPcfgmBSZnRgxWrKt3j
 6pNosTC08L8ynonfWlDzJ2NG2s501649sHwSwzNlek4CB/DbN+ElxJftfrUyTRqRzra7KNKvlwE
 E5404ndwK+ce4Yck+Y+RiH4ASSXil+ooefHuukKh6XqY84PkISpCOTTZcswHQO3Uxi1bU25mVoB
 0TK4iwvGnIcfCF1B18T+XhldXCFci+TP+D3r0/oFnjT1CYvIPyzP2lFKx/Q==
X-Received: by 2002:a05:600c:3510:b0:475:da13:257c with SMTP id
 5b1f17b1804b1-4771e1f13c5mr663065e9.27.1761669265646; 
 Tue, 28 Oct 2025 09:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhkIvbcR4QbAFi8hx1inKcbX9Ru+1SQW4EkZSduZY4GHBpz6oA7dyde1zZtZnCBkQ/cMYa+g==
X-Received: by 2002:a05:600c:3510:b0:475:da13:257c with SMTP id
 5b1f17b1804b1-4771e1f13c5mr662855e9.27.1761669265191; 
 Tue, 28 Oct 2025 09:34:25 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771843eabfsm23992195e9.2.2025.10.28.09.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:23 -0700 (PDT)
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
Subject: [PATCH 12/16] =?UTF-8?q?blkreplay:=20Run=20BH=20in=20coroutine?=
 =?UTF-8?q?=E2=80=99s=20AioContext?=
Date: Tue, 28 Oct 2025 17:33:38 +0100
Message-ID: <20251028163343.116249-13-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
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
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
2.51.0


