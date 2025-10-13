Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF42CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 16:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8LNd-0005Rt-VG; Mon, 13 Oct 2025 12:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8LNb-0005Pe-SU
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8LNY-00057E-EU
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760372791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9KuLJoDiMvlnnKNTBuu0fgbZJ8BujdBUL9VVGTtRchY=;
 b=hOl7qJlSVM5Gs+rIS+N2+YUFQLGG4iTPbvTPiivsy/L0Cnsm8po8WEdy3VDRpw4RN+tTOQ
 GV+IYkH8bS/LrfVTFQh+bSOYWJhodKlckTfwj2URsn+MZ3a/Zg8Frb8cav6vGdfs5YtqIx
 zlWpREU0sXOfKgX2cO81HX5uEOzxboc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-O4UEWjyYPDqDYOkZz-mjQw-1; Mon, 13 Oct 2025 12:26:24 -0400
X-MC-Unique: O4UEWjyYPDqDYOkZz-mjQw-1
X-Mimecast-MFC-AGG-ID: O4UEWjyYPDqDYOkZz-mjQw_1760372784
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ecdc9dbc5fso2984930f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 09:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760372783; x=1760977583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9KuLJoDiMvlnnKNTBuu0fgbZJ8BujdBUL9VVGTtRchY=;
 b=xNAVPT7YPgAq89RvxWuXsSF45nulWr7dK9XeSJIyKeXpdX915jq5Kw25d4zjKz3DrE
 5MkaNAP0+EiutlQi6xmC+DealWbclebU2mT0xKlx+aIpA/l5QNgY2APcOn8OsR64by1v
 BNKjoNayUnWM8EeUR414YRpMBmjhpVRNatHOG2SlS8Vf5dmlxuDcHV4EvCLMaIsuU6Tb
 CAZCQcAUrJLlUkMkCB7VIyVelCKYMIYPx/8d0y0hSgzMjulKAgW8+L3ikJKFzlgDL2tV
 8J3LYN44CTOs2qkMC+KXgH6D2CEuZSfgJZ/Fpx5tQVih46oVSe8b4RSgYohNYuzp2sUW
 llVQ==
X-Gm-Message-State: AOJu0YxMTnFWKQtPAKuQ4pA4EnEaJVg74v/TLTLpz5jsmz8Oys5b3o1U
 7A8L8uHP8ixrpKrcIwf7n/R2OGSM/uR5wpIrnjWaxpOAP4DpDQyLCyIW6PkefeQzIkJR78U/LVV
 E4RjVOrtzvPj8fB3OVkcpSMfl5O3oB0H6Daf9pT2K435nW9WRIElJAm6cMNa5VtzMeSVdJsVWDg
 ZrI8+Hsz6xWXzjlAkRCefQBEalplEszkN/fpe2pvR1
X-Gm-Gg: ASbGnctoZuid1U0J1ilUJxmdu75bUkH9V2VOkyt500QLSUn/x+15Kd8JvEYj1UqkyeO
 HMj2BFSElR9kcTj8JWyGrLQuz4ZvWXAuBllts8qR+RCCZRDOkvZpLaPN10OGNWA2YiHyhanOZS/
 0sBwAdCSSUKaY4f3+5Rijto61o7ekZcop+uonpvmWoMrsKhy+kOSGnYMAlIqUXbO4nHh4MOjmFt
 wfXdjGpd40mCF6Zl5nF7tex3kKP9JkYWZ90q6SsjLZe4KHak0yJkjotY1VpNWKD07I5PQaPc1aL
 HChAFiwIAX+ElG0yoEoHfEplnVDXCWYQBvrwb5lraoHuX8prN6H4X67Zsvct4C5/xofTYWcru+U
 KOMiW7hgvWMFgdQbun4bVadUKnTGHhIlEaLnK078RHGg=
X-Received: by 2002:a05:6000:41d1:b0:403:6f7d:ac5d with SMTP id
 ffacd0b85a97d-4266e7dfaf4mr12192621f8f.34.1760372782808; 
 Mon, 13 Oct 2025 09:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIn5vNuVZ0CPukcmdqUy65P6SXHfg31+sAMl7HbkAmAxfF0SCFDMh2VHDcOvMtTOQ9fDZZsw==
X-Received: by 2002:a05:6000:41d1:b0:403:6f7d:ac5d with SMTP id
 ffacd0b85a97d-4266e7dfaf4mr12192598f8f.34.1760372782313; 
 Mon, 13 Oct 2025 09:26:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf70fsm18439576f8f.27.2025.10.13.09.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 09:26:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH] async: access bottom half flags with qatomic_read
Date: Mon, 13 Oct 2025 18:26:20 +0200
Message-ID: <20251013162620.995747-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Running test-aio-multithread under TSAN reveals data races on bh->flags.
Because bottom halves may be scheduled or canceled asynchronously,
without taking a lock, adjust aio_compute_bh_timeout() and aio_ctx_check()
to use a relaxed read to access the flags.

Use an acquire load to ensure that anything that was written prior to
qemu_bh_schedule() is visible.

Resolves: #2749
Resolves: #851
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/async.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/util/async.c b/util/async.c
index 2719c629ae9..a736d2cd0d0 100644
--- a/util/async.c
+++ b/util/async.c
@@ -256,8 +256,9 @@ static int64_t aio_compute_bh_timeout(BHList *head, int timeout)
     QEMUBH *bh;
 
     QSLIST_FOREACH_RCU(bh, head, next) {
-        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
-            if (bh->flags & BH_IDLE) {
+        int flags = qatomic_load_acquire(&bh->flags);
+        if ((flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
+            if (flags & BH_IDLE) {
                 /* idle bottom halves will be polled at least
                  * every 10ms */
                 timeout = 10000000;
@@ -335,14 +336,16 @@ aio_ctx_check(GSource *source)
     aio_notify_accept(ctx);
 
     QSLIST_FOREACH_RCU(bh, &ctx->bh_list, next) {
-        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
+        int flags = qatomic_load_acquire(&bh->flags);
+        if ((flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
             return true;
         }
     }
 
     QSIMPLEQ_FOREACH(s, &ctx->bh_slice_list, next) {
         QSLIST_FOREACH_RCU(bh, &s->bh_list, next) {
-            if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
+            int flags = qatomic_load_acquire(&bh->flags);
+            if ((flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
                 return true;
             }
         }
-- 
2.51.0


