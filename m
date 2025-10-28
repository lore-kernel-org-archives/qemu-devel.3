Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8830CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmef-0008GJ-Nv; Tue, 28 Oct 2025 12:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeP-00087K-5R
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeL-0003gZ-J8
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8pa3E2fGggwnU3WGnqZTwjKApxvhV+ccDzx1XffCOw=;
 b=Lu7kuXT9MxZiSZ6f13yYKtrJCPyt04KZnMMWHCxi+PUsKzcLzMnj2k+WQzRKFS7VPMMzSg
 JAOgRoTKupGw4R3XxK46rfM8iK8eOm9QSAXZV+QuHWP95Rubjc1hAeZrUggzZAAvdTaK9f
 fviEiJg397cAJkwHq5vIoqCh5GqOzZ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-zKa9_W6fMEGvHcyB_zqA1A-1; Tue, 28 Oct 2025 12:34:17 -0400
X-MC-Unique: zKa9_W6fMEGvHcyB_zqA1A-1
X-Mimecast-MFC-AGG-ID: zKa9_W6fMEGvHcyB_zqA1A_1761669256
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475dd9906e1so19575125e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669256; x=1762274056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8pa3E2fGggwnU3WGnqZTwjKApxvhV+ccDzx1XffCOw=;
 b=M/TcE77xSqiSgCKWZCIMII4uNjmLqUwVR1hAHSbMiuWA/4w205qbCFsK1wtDqgIY+V
 6CCd7Atn5LeBiFAaMp55MvcxaywaSm+Qqjfap5vr8ftzLFMM1tyn/7cVrHnZpA/4KV6C
 3+kp5zJliqo9WrvxwdfzVXMYDZR5ngW57rfM9+DsPEz6FTykQPDehlWvjIgADU2XeSKw
 FmznmTg7+nS/zd/bOb7S+tKbERpb6hSKUTFCXl8ULYxM7tfQjyKndZRRItOUB+/leQDP
 PXwuNKajL+B/BhCXRmcAD3OCZ7IxtDYrvCY/2pee0L7/MeO8V5NVa9Y0WCo+cMqIY1z6
 Aipw==
X-Gm-Message-State: AOJu0YwLvsDoxRoGxM3kTc9ZMiII3igfee/h6tG2cAAkNg0SRPOHfGLw
 JYP2PXEyk+9DLrgQWx1JTMJ0jQ2Lt/VP8tEgeFE5pp7ODKXM22OfdC7VVjOI/+MnA45urP8l2nu
 LtKC3+bkyLelmni6M5uQ8KRvkIFfZcZA6cBLEROujcM7BLbPkmJV/SPaK
X-Gm-Gg: ASbGncszLUp1tJFyAA19GA5TGdzBGEZbAVRT9Ko6oyqvxIQMP6fUCApHsoXo+l2+su6
 siT3lHmEpIMpFBdklHOW99Zr3IZ4yD7zgOvk7HGcnA31H45e7F5q/OnnzSPGuAGmKkskpLGmFFt
 4lXhsQzss1NLY5mFcpk76QpY+YF9bnY3uwR7uJkTUl0YzzypF/n9C5Mu0mtsmyohCdSH1hWriSc
 Uejq974GHzbvlhV8qNsrtJB5Ol1OEXyS6yAAH9Rus79pVkd4xvC3nnv+tAkTOXsnDXUTqX1WkyV
 MLPfaGvP7f/thUeFFJ1uCd4H2Z2rd/IOz5ztVJj2TyhyRsYX+BrsCYB/e8oJa7rMwhmLwONkVCc
 aDWtyyYn9l1nvJcbr4DGy4Ubn5PagqnjsCQd7+1mU2yH1wXIehUnG5jhSXg==
X-Received: by 2002:a05:600c:190d:b0:475:dd9a:f791 with SMTP id
 5b1f17b1804b1-4771e3ab004mr97805e9.28.1761669255806; 
 Tue, 28 Oct 2025 09:34:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBefty/iKIJFguef+AlhNtGh9Ly7/T4sJ8jGnXLfUY8XY3h5Ld7thGmSEX9B4+wBHB+O88ZA==
X-Received: by 2002:a05:600c:190d:b0:475:dd9a:f791 with SMTP id
 5b1f17b1804b1-4771e3ab004mr97265e9.28.1761669255430; 
 Tue, 28 Oct 2025 09:34:15 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df6b9sm22061204f8f.44.2025.10.28.09.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:14 -0700 (PDT)
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
Subject: [PATCH 09/16] block/io: Take reqs_lock for tracked_requests
Date: Tue, 28 Oct 2025 17:33:35 +0100
Message-ID: <20251028163343.116249-10-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
MIME-Version: 1.0
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

bdrv_co_get_self_request() does not take a lock around iterating through
bs->tracked_requests.  With multiqueue, it may thus iterate over a list
that is in the process of being modified, producing an assertion
failure:

../block/file-posix.c:3702: raw_do_pwrite_zeroes: Assertion `req' failed.

[0] abort() at /lib64/libc.so.6
[1] __assert_fail_base.cold() at /lib64/libc.so.6
[2] raw_do_pwrite_zeroes() at ../block/file-posix.c:3702
[3] bdrv_co_do_pwrite_zeroes() at ../block/io.c:1910
[4] bdrv_aligned_pwritev() at ../block/io.c:2109
[5] bdrv_co_do_zero_pwritev() at ../block/io.c:2192
[6] bdrv_co_pwritev_part() at ../block/io.c:2292
[7] bdrv_co_pwritev() at ../block/io.c:2225
[8] handle_alloc_space() at ../block/qcow2.c:2573
[9] qcow2_co_pwritev_task() at ../block/qcow2.c:2625

Fix this by taking reqs_lock.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/io.c b/block/io.c
index 9bd8ba8431..37df1e0253 100644
--- a/block/io.c
+++ b/block/io.c
@@ -721,11 +721,14 @@ BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs)
     Coroutine *self = qemu_coroutine_self();
     IO_CODE();
 
+    qemu_mutex_lock(&bs->reqs_lock);
     QLIST_FOREACH(req, &bs->tracked_requests, list) {
         if (req->co == self) {
+            qemu_mutex_unlock(&bs->reqs_lock);
             return req;
         }
     }
+    qemu_mutex_unlock(&bs->reqs_lock);
 
     return NULL;
 }
-- 
2.51.0


