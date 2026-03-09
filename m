Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98D5FCA166
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzee7-0002eb-1G; Mon, 09 Mar 2026 13:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzee0-0002cU-Mg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzedy-00025X-PN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773078230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPhfCaHv6CHzKOjPkqk+tdV6bugz5au2t9vUldgffyw=;
 b=fyicTwox9YbVeG19vLNzkThQVpMs+ydxoNy1wM6IW87EBEZn8hM2iQX8yqMrHIXM1b1fxa
 dP9DX4TZr7nUOVNhtQghGh0iKeJEx1QOECfXSUcN0lWH4qzl+i1HKja3yn7ofRyGcjzptg
 j7owPicUe9h1WUsoePOitg3ebF2ke40=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-O_mq9y7dODuo4ZUJqhCiKA-1; Mon, 09 Mar 2026 13:43:49 -0400
X-MC-Unique: O_mq9y7dODuo4ZUJqhCiKA-1
X-Mimecast-MFC-AGG-ID: O_mq9y7dODuo4ZUJqhCiKA_1773078228
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439ab866bc1so10594368f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773078227; x=1773683027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPhfCaHv6CHzKOjPkqk+tdV6bugz5au2t9vUldgffyw=;
 b=QXIrlhzIG97gLix2w40sqzNy1KQwWkvr4ctkJmYXmi4pmWYUtffj7f1UIGDRee9CiU
 deAsbS4lHUWXJ31sJhgP942LB7S7Edu4VvgVly4fzLkfd4jkC9BUeMzbqyEbSlOBPLyF
 /KcVRDRpObZ+U3yuQLLdSP2QXhgcAieO7gHD4gHIwz7ZPgoa0/8xLE6bG0j9FrUGztvf
 ZLAszHgQt90BOUXFFTuqpkdIraKwk0UfHpGeRWKH425DodWI4l28jtIA8dxcP3KIBjzs
 zEkrlndT+NpUQr/qkgrCR4QLvK/yFf+SmJzFvi0oZYPinYfWjXYyewEaQbG89dzr7tue
 RXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078227; x=1773683027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uPhfCaHv6CHzKOjPkqk+tdV6bugz5au2t9vUldgffyw=;
 b=wdZqlIfpNztqDs004gE9CLkrGGHLbl+WF8HAXUya7ooTBOYZFqKhVzhAsAsSIlm0MX
 axMUNpmzyab/BkEkggT3EbE2JUd9c9cTsH9ABgbqNQEGgIqiLJULGafnFScFNooSAcxy
 yMxQp9Ysb5CQdUL9/E6MieLjjeRSZ2otm/KQYFyJ7hXtew1TSTtWimfIRuD6NlzH2c/e
 59wPHWxP1G57xPTC/xWA2cu8sGmKklyuv+5dtzR212XlZNqmWqkUMYk2JShiXA8L2+sh
 wGR3Mrz+/SGxYSiD9DmjFk6GavcrIWtK7MqHIQAEcQm63fVxFe6r21pzjUA+nRX6/eNb
 lLiA==
X-Gm-Message-State: AOJu0Yx9B261MSLBL17dtgC8VGa5PvVNp9Coex8Iwk/K7saXF85OIxBF
 kzfbR4p27k21udhH+s8Qu2p89MXuEJOouQjb+c5eecdr+ebfcAbq0ATX4v7VTlcwkTvyl+zc6Z3
 VYBafLy9j0gudpZd03MmmWmGUm6ktnhHslPrw2QQTdSnJGtei5vVtDQ3IW6Mhg1jgMPagSjuMeq
 ive0NhxdNwgd+lhAn3rwTSIMjs0acv95ErEFiFOfzQ
X-Gm-Gg: ATEYQzzBy/69t2zMwwDowKtk18Xw8DPM/XxD3caCGLIx2aIEGnLpnEgTHyUqZSmAd7d
 7V6FCCqgzRa7+AlFefpPya5RNo3RSqUTk7+nHurYbO0YnjOiUrpNOuNGkB+vnDL3s0sW21vXis4
 QH4T9hNKOhj9CMvaisxi0w3/6dcYSLtjchw9EOJx8B+YZZu7gB7w24nZFXEUkGgYn6w3LWUhsst
 hrXXprDP1BJ4W971iV15mgBNRerwu34kXlfCKH9z54nNcHc9ZZz1aa9H0mTnAHGR5Acw7NEYfiq
 YD9VmK6bY92MjRxCn/0tkcjA60ED0k+Zo2CifB+JgBczrM4Xr1W5G/B86MSSvpBzRidKVqCSWTj
 lVmSloeKzuypxsLBW7hQrt3q4Fi0Zgz6K3z6kQvBwzSDTLia89T8L5N5xg8ujOrirABhnQxqwCL
 c+XE2LoTxLejG87IVQ6zd5U4Vhq9U=
X-Received: by 2002:a05:6000:2481:b0:439:bdd7:4259 with SMTP id
 ffacd0b85a97d-439da88210cmr22069710f8f.38.1773078227039; 
 Mon, 09 Mar 2026 10:43:47 -0700 (PDT)
X-Received: by 2002:a05:6000:2481:b0:439:bdd7:4259 with SMTP id
 ffacd0b85a97d-439da88210cmr22069663f8f.38.1773078226408; 
 Mon, 09 Mar 2026 10:43:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9d8sm29414879f8f.21.2026.03.09.10.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:43:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Siteshwar Vashisht <svashisht@redhat.com>
Subject: [PULL 02/10] qemu-coroutine-lock: fix has_waiters()
Date: Mon,  9 Mar 2026 18:43:32 +0100
Message-ID: <20260309174340.52174-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174340.52174-1-pbonzini@redhat.com>
References: <20260309174340.52174-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

has_waiters() is testing a reversed condition.  The logic is that
has_waiters() must return true if a qemu_co_mutex_lock_slowpath()
happened:

  qemu_co_mutex_unlock            qemu_co_mutex_lock_slowpath
  -------------------------       -------------------------------
  set handoff                     push to from_push
  memory barrier                  memory barrier
  check has_waiters()             check handoff

which requires it to return true if from_push (or to_pop from a previous
call) are *not* empty.

This was unlikely to cause trouble because it can only happen when the
same CoMutex is used across multiple threads, but it is nevertheless
completely wrong.  The bug would show up as either a NULL-pointer
dereference inside qemu_co_mutex_lock_slowpath(), or a missed wait in
qemu_co_mutex_unlock().

Reported-by: Siteshwar Vashisht <svashisht@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-coroutine-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index fac91582b5f..c82ee754beb 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -173,7 +173,7 @@ static CoWaitRecord *pop_waiter(CoMutex *mutex)
 
 static bool has_waiters(CoMutex *mutex)
 {
-    return QSLIST_EMPTY(&mutex->to_pop) || QSLIST_EMPTY(&mutex->from_push);
+    return !QSLIST_EMPTY(&mutex->to_pop) || !QSLIST_EMPTY(&mutex->from_push);
 }
 
 void qemu_co_mutex_init(CoMutex *mutex)
-- 
2.53.0


