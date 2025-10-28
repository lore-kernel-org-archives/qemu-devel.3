Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ADCCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmfc-0000da-9X; Tue, 28 Oct 2025 12:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmev-0008Tc-Hn
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmed-0003mi-1Y
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IkfdsjarwHSxOpg3pQ0lv1QR6fFd3UpdDIRhxBkgC2g=;
 b=WkIniiy24mwyp2Oo9euf/XV6B6yR5/3qGTAR9a8XBaGdawD3vc+59bIQHqEx+jSO5hyEYu
 hsNbWMrM9liHpv4d+LdWkW72f03g0aXT2oNVtGtEOAzNmITD7lhdMGs2J8OIjuqwrvVR5Z
 xPeDbgw1bxmqe/7HoKWPmPZS1qTEXJg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-zUoj0JiIN12SaqQnJzM1eg-1; Tue, 28 Oct 2025 12:34:35 -0400
X-MC-Unique: zUoj0JiIN12SaqQnJzM1eg-1
X-Mimecast-MFC-AGG-ID: zUoj0JiIN12SaqQnJzM1eg_1761669274
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso47215635e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669274; x=1762274074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IkfdsjarwHSxOpg3pQ0lv1QR6fFd3UpdDIRhxBkgC2g=;
 b=YoG43DVqjmPLxbgmMRPQFDB4DHah+ZOaeJd8XbeKq2+dKtjnuppVYIle19bzZum1sK
 PU18XYvXtlAQwLyP8EmZqB8cjIq2rMpZiTYmuaOcdF/eyjWD9NhDLZvcrzhswehoLrxW
 T2Jt13FJGdcu9dbkc2x2tJ+vpiS90hrKrQ5TH+dhk3uGXd03xEq9Mn80OSYPRgsnUW1H
 zozS/9rqMhm2OdNyGrvNg60vuX80v/EuietfSStcuWu5pRZMj2VQl40osrHd0pFAmfX4
 kVkG1l7a9qTrJ66yyxu58pQ/6WajP/0cysfX640BlOsCoYN9L7VuCuAzK3IlhOO7jXg7
 lIyg==
X-Gm-Message-State: AOJu0Yx5OQcHE+aPN/8jc4qRHNXn3vcK/mm8MxhBBVJ0Bh8sBk4odZIM
 zAozIKDq102moaIXYXz20FTu7PQM+bbMcAMmynOLOvFdb1Upi+nDi5OmXMDGciJ+q7bppXgI8rL
 ObDG62h1IuojUoCvJuAr4ZHdrZhboqPRBCi9ZNxTpsfl/rIpM+AHqUw6s
X-Gm-Gg: ASbGnct0yJuSUW5/HDb7FtG0rhw1zv0iXYBb2KiAUPkn9mGsb0ZoeI4xVEQO1f2/5wd
 4g6u6uQ8wBHT1W8BUJWtYojWmNw+u1mFXYq/aZiuACVusNBeRFNHQJcZ3Z4xdOdHWuqQsiN5kEb
 HFZOsx8ix+tUJNQ6hz7rrlVuW6vdXuuttvBZxwZDA+Wb1hkSUMWL6HaPZtw0kvpSNpUyQlt5q8T
 40IZLa96XlvOHD+pKVTgHax1pdQcVBXcLiKgH20Xyvw3FhkKOTVtz0lT2nvlb0j/7PQr5jO5J0B
 0mYlQURpFqSJxgb/YSYw4vIXsf8kOzARBuxNBYLSrkcj4kvB6P7PYVEk9w8diyKeaYjBFOAR2J1
 BmyG11NPvCV+b2WiWGwcfR8MdQAKDbMOReY/jDnYci1TEY0cdkStiFGvH8A==
X-Received: by 2002:a05:600c:4ec6:b0:475:df91:ddf0 with SMTP id
 5b1f17b1804b1-4771e1f0f49mr760445e9.33.1761669274273; 
 Tue, 28 Oct 2025 09:34:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzuN+T4OqxC5NpkyDonmtKiOglbvQDKTB5SQJ+NZyiBtDg6FfrRmEe9vMwhtNh7NpzfWhpSA==
X-Received: by 2002:a05:600c:4ec6:b0:475:df91:ddf0 with SMTP id
 5b1f17b1804b1-4771e1f0f49mr760165e9.33.1761669273803; 
 Tue, 28 Oct 2025 09:34:33 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3b9994sm11855e9.16.2025.10.28.09.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:32 -0700 (PDT)
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
Subject: [PATCH 15/16] null-aio: Run CB in original AioContext
Date: Tue, 28 Oct 2025 17:33:41 +0100
Message-ID: <20251028163343.116249-16-hreitz@redhat.com>
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
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

AIO callbacks must be called in the originally calling AioContext,
regardless of the BDS’s “main” AioContext.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/null.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/null.c b/block/null.c
index 4e448d593d..253d20ccbb 100644
--- a/block/null.c
+++ b/block/null.c
@@ -173,18 +173,17 @@ static inline BlockAIOCB *null_aio_common(BlockDriverState *bs,
 {
     NullAIOCB *acb;
     BDRVNullState *s = bs->opaque;
+    AioContext *ctx = qemu_get_current_aio_context();
 
     acb = qemu_aio_get(&null_aiocb_info, bs, cb, opaque);
     /* Only emulate latency after vcpu is running. */
     if (s->latency_ns) {
-        aio_timer_init(bdrv_get_aio_context(bs), &acb->timer,
-                       QEMU_CLOCK_REALTIME, SCALE_NS,
+        aio_timer_init(ctx, &acb->timer, QEMU_CLOCK_REALTIME, SCALE_NS,
                        null_timer_cb, acb);
         timer_mod_ns(&acb->timer,
                      qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + s->latency_ns);
     } else {
-        replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
-                                         null_bh_cb, acb);
+        replay_bh_schedule_oneshot_event(ctx, null_bh_cb, acb);
     }
     return &acb->common;
 }
-- 
2.51.0


