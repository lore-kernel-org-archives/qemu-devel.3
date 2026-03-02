Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFCCE9B37F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 13:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3Mf-0005l9-Rx; Mon, 02 Mar 2026 08:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vx3Md-0005hb-UL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:31:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vx3Mc-00070U-Cs
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772458269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uPhfCaHv6CHzKOjPkqk+tdV6bugz5au2t9vUldgffyw=;
 b=D4VcxOqcz7pvY5FBmu0EmIF7epffoCuF3iQto+21WcTRfcXZnGWK9pF1v7PsXBM5ijMGJw
 jagZ7RdxnVbpE/F+vFmuDYmXiG0hpiy4okQYpJc05kQvDqT0x6315egKas4YcXGL2NujtT
 PL/VM3oWoMFOAxN/tmUyCefnGRvl3as=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-mMrxDZ9HO-WE6XEsJCATMw-1; Mon, 02 Mar 2026 08:31:07 -0500
X-MC-Unique: mMrxDZ9HO-WE6XEsJCATMw-1
X-Mimecast-MFC-AGG-ID: mMrxDZ9HO-WE6XEsJCATMw_1772458266
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837907ec88so51786665e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 05:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772458266; x=1773063066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uPhfCaHv6CHzKOjPkqk+tdV6bugz5au2t9vUldgffyw=;
 b=RABhfJkY6X60HA6hBXZQ441ZFmZNS7M+abFKRl6HBwo+MV51v+LY4rY+d5/ILQlR/P
 7fchoL0EPpjUtZ2jiUxPr+38prUuZinN3KXI5sIUN3LpgIUSHzwLj+N5xfl3gkqGcHgR
 m0H3lY1AH8gDnMgRqJxzg5IrAQTy0ZCsX85nnkpPaToHWt0rrNdc67dBpNWlE6FQiS9c
 Uz8v798jzk3FJ3mgyjr6XPK/1OqoHqSKdYagkZkzRvAFN8IrWh5tB78glyg15ocsTPbg
 E91CpzCEyEWbhlJaz4PmXoWtmv+TBXpEJjOCOGJH5irLpvT36OPQgRy/JZe5fgwgv79r
 o+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772458266; x=1773063066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPhfCaHv6CHzKOjPkqk+tdV6bugz5au2t9vUldgffyw=;
 b=RkYBRYnF6NS+EIMKXLNlLaNqI9R/joQCL99RuQhV1a8jY3PbJaeiavcohOx0cyLOWS
 JfsnEdEshOOkp2/ope9Zxnvq+GIc4/cFiRbfSSabwliS5KhnUNgpgjj8VnzXmNQqxh+L
 bE/f3H/XWRAxey1ZNjAwF2IjVQeFCIimEvo8coZdHbW6+rmk7Ortj8cCvgdpUJxeq7MD
 gwr91EjebLQ+quGxgeUvdQptW7zmDOEwP2KCKLx6s/0mmlhAB5Bno9IFbt2B0dl/wS2Z
 qwJnHQ6MdrKTRk1RQMr5D5moEJGqAWfbSqy5zjPWa/aSuvYHnq1O+6RwvIGcDFRpSrw+
 MWdA==
X-Gm-Message-State: AOJu0Yxh4l3E16fuViwGWuzYDg9Vj2xyMCw37i/PuPYYs3wNz3jq4Kjv
 K+/oaDSUuBkq2asEC7OstWbmLGfyPpTDIhRYhbjI3q6RsvxiVahU69VWiWNbglg7VrWbSX8Q5+i
 zkA4rxUljASaYWz2H3swQan4O5ipKwm1ZcSTd2Og6dhXBbUlViEdjlCmIXvdgX9xh/NLsyzhXdv
 RJHkUDyhyn948Oyr/QRcob53zX5vYZBuOZFeR7bv+L
X-Gm-Gg: ATEYQzzkPeWOVrsqPXCWjekL4JKsHRuK352PuHq1dmIswyk4/R9AbnBF+VW/8pDln5X
 BBUt1oXShNVy0Qth9IjKKvzwby9LGaikZ40SkuLK8od2Qzxjkz3retvUSQG0hc0WgIiniRKaZTT
 9lI9qcJigJ8dqLKVxzP4HWHAQujZmD+9TBGoe5jgzqxwNFa8PsVoavM9Se4q1m3c1vmG46OGc4S
 3jCwogKsP5LvPUau0AvBcBt2BuwmGEoc62zimI0zwrO6chzyeyKKivwPXkUgnIJ58izPedxOR9Z
 tpjZo8wRNShQ3XvB2zBe12m5GYDo/zFK3vipsUCJnZjdXPayLPSIYIau4dCRRXY5ZPB5gICJYIF
 Q6H7RxSGbKYCTlzcJCFCDv8sCzZ9wrtuq7hvI2LRh0pPEHkRAcT3Tt2humRJ3QYSuqcPVM6ImV/
 qj5pMj/pPGbwJSM6veyJkQh45+RKA=
X-Received: by 2002:a05:600c:6994:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-483c9c0b88amr209276975e9.22.1772458265956; 
 Mon, 02 Mar 2026 05:31:05 -0800 (PST)
X-Received: by 2002:a05:600c:6994:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-483c9c0b88amr209276485e9.22.1772458265464; 
 Mon, 02 Mar 2026 05:31:05 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750701sm430596035e9.11.2026.03.02.05.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 05:31:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	Siteshwar Vashisht <svashisht@redhat.com>
Subject: [PATCH] qemu-coroutine-lock: fix has_waiters()
Date: Mon,  2 Mar 2026 14:31:03 +0100
Message-ID: <20260302133103.583821-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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


