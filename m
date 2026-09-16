Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECC2C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pgI-0001oN-E9; Wed, 16 Sep 2026 09:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pg0-0001l5-7o
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pfy-0003ty-OX
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789565269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yPgw4Lk6W+a+T2fW0nuEVY1Q9j1d9TfrmANgfQ9OFwQ=;
 b=MUCVAsZUkfY/PUQEb5FbXw+bh3gcS8Vn6rZnSn1xB0x8Yr9umlVjNXuRtgcKhbBi3CA5d1
 8J35VPsjZcEn7jnggEwHAVV6L3jfHf7kSdDHNPjTgPzOu9Xim599yCRQ/hG4lQ45d3Ot1X
 pcma63A9LJ94iGtY6lvDvW6w4mgEn/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-K9mBZwKHNLGe1QPCd9_YMQ-1; Wed, 16 Sep 2026 09:27:47 -0400
X-MC-Unique: K9mBZwKHNLGe1QPCd9_YMQ-1
X-Mimecast-MFC-AGG-ID: K9mBZwKHNLGe1QPCd9_YMQ_1789565266
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49ccfad90f1so32756005e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789565266; x=1790170066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yPgw4Lk6W+a+T2fW0nuEVY1Q9j1d9TfrmANgfQ9OFwQ=;
 b=ZA6ksj5qqnV511TTwagqSbO7zmYbd7fQee17/5TkoehvyI+u7RCp4tq+9Otd2ZyyqN
 1JAAgJuAwzjt+5dnMlfxwMOOKR8y8QQbN7k5WxjfsIAxVj3ccXMTteVFaTUWrzQawsxn
 1dQk/+h9Jq8YrcnYaV3nzs765NsWjt/Sgsa7PcckNSyw8V028lymNd1CbeYel+NXX+Mw
 MhvQIthD09TkOb7lgLhQRluG/5BM9KF1CwmW08cq4E/ukXs178jkmJqQN1C4qdaVCClE
 /UU8pNDlpDSKDi1Fq4x80T4//7FwipOAa9Gway0ZIU/Vkxgnd7aQWIr33bFcjNcgMfsO
 1v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789565266; x=1790170066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yPgw4Lk6W+a+T2fW0nuEVY1Q9j1d9TfrmANgfQ9OFwQ=;
 b=F48zDIk4gH3H1c6P3aTbDuf83BxzU0xPQgv12tm2nrkkPqWf4S7Fct0mFDCaW0qoEj
 LAc/11BIzp/eHnNoCyL3FqAHgenZwBuvFvZq5HXEXBzz7ElLnj19Z4RGuhfXE/nk0YLm
 H1TTJ+q979cjFIgIq/b4c2ECYWAjDJax9J4h6+fhV6ptS6aZ3TbRiHj2DoVGxz3Abj7O
 a2KIS+iC16y4DccYeq0ksosXhnuWnDFVGuZaPhkisBxyFvz5jCbp1PCnWHtsiIn3kysP
 bIQSYvT+i2Qc5sdYgVxTD1qxIdpDHRHJwkiL2gX9QPPRCrioaUgr1LBK6w9S2MQukreq
 +ThQ==
X-Gm-Message-State: AFuF++nO93Mpda6fzEyuG08ve1Eouprm+yow6UYmH08fcmwAhrEsxx5R
 Xh9smXPESKc+ANDB1nOHhsQe1bxO0rpElkrzCSkXUeMfHPt7tPP7P/r8hYlN/MVB/dO2fmfzvPR
 MZaaS07cq2QfYpOsFoPIKD/GJgnqYpirUN0wBLNnNa9Ku3/38fa0b/jglbrhl8Ry15f7P24BZdB
 DWlSbJZNi5Q7PvV6md+0jZDF07WgXBj2QhZF5eFV3J
X-Gm-Gg: AYBFou0SwK+9kU7dhqGknG1kt1EFArZuCGIGtnW2oh8QHCBCsJ3G0mCCw/m/uq/qg5A
 yl9JuuD3l2dIhXasXt4lSH1kHsJT3mI+ZYWAWvbsoSW4U/wgsLLEjwxQhfOzv7lGIAc0cbGPGwL
 Mxrywn0fpYRs58GLPClMhQpL5NSNN5AAoxZ2mpMzg6Lfs+x5mONvkGVQ3HGxMdteEy7JOFHyJga
 L19L4fLgg+V5s9FPsrEMWQAoX9wMeFs5hsZaS7grP5THVRQZf7kJugics6h2tZlje9Ltl+6kRic
 qUKC9wvDC3mj+Pmola4wyXoGXvkGsBOQ5Xqwz6FtCFvnj1d/gy+pGxED0gIei1Hg9RcukWPdc3D
 BcjslQeUynR55u9QdSSzUrLTaokkL8VzZwcVKA/qB9Yz5nEVwvYMVUZSlhpHP6OjD0wZN5I2LKW
 INjTOE
X-Received: by 2002:a05:600c:4e8c:b0:49e:7cc2:e6c2 with SMTP id
 5b1f17b1804b1-49eb73309edmr30697725e9.27.1789565266369; 
 Wed, 16 Sep 2026 06:27:46 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8c:b0:49e:7cc2:e6c2 with SMTP id
 5b1f17b1804b1-49eb73309edmr30697265e9.27.1789565265831; 
 Wed, 16 Sep 2026 06:27:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83da071asm97825875e9.8.2026.09.16.06.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:27:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org,
	qemu-block@nongnu.org
Subject: [PATCH 1/2] nbd: comment on locking for requests[].coroutine
Date: Wed, 16 Sep 2026 15:27:39 +0200
Message-ID: <20260916132740.872244-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916132740.872244-1-pbonzini@redhat.com>
References: <20260916132740.872244-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Explain why it is safe to read it outside the lock.  Basically, if
the protocol is followed correctly, the reply header will not
appear until after the request has been sent out in its entirety;
long after requests[].coroutine has been set and s->request_lock
has been released in nbd_co_send_request.  And
requests[].coroutine will also not become NULL until after
the reply has been read, and that requires nbd_receive_replies
to finish.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index e5e16722ba2..85842e7cdfb 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -141,6 +141,11 @@ static NBDClientRequest *nbd_request_by_cookie(BDRVNBDState *s, uint64_t cookie,
 {
     uint64_t ind = COOKIE_TO_INDEX(cookie);
 
+    /*
+     * Once requests[].coroutine is set, it will not be cleared until its
+     * reply is read completely; so it is okay to read it as long as a
+     * request is in progress or receive_mutex is taken.
+     */
     if (ind >= MAX_NBD_REQUESTS || !s->requests[ind].coroutine) {
         error_setg(errp, "unexpected cookie value");
         return NULL;
@@ -154,6 +159,12 @@ static bool coroutine_fn nbd_recv_coroutine_wake_one(NBDClientRequest *req)
 {
     if (req->receiving) {
         req->receiving = false;
+
+        /*
+         * Once requests[].coroutine is set, it will not be cleared until its
+         * reply is read completely; so it is okay to read it within
+         * receive_mutex.
+         */
         aio_co_wake(req->coroutine);
         return true;
     }
-- 
2.55.0


