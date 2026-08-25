Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1509C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypL2-0001wK-LM; Tue, 25 Aug 2026 07:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypKx-0001pM-VF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypKv-0005eA-Ob
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oawp+uuqwhnIwrwvrxKAKzVlHKk6YTGFE4uYRTt9AK8=;
 b=TH8ooWvTeR6gv8NolxHxDcisKce4BfUlNhXx9OHNUu0mLKa7hHgxTGCxOLvp00pjb50sBs
 d0BtKkvbO7DpOLnr7QIGlMCHeszTDdNaFyGC9g6DQ7WzYFzKrZAZxaPSqK9rpS2bkH7M8q
 YOqMAuWdZkJIO9trJf5hmFh67fAc1X8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-4OIZuNQ-PqC21NWOqPH9cg-1; Tue,
 25 Aug 2026 07:28:57 -0400
X-MC-Unique: 4OIZuNQ-PqC21NWOqPH9cg-1
X-Mimecast-MFC-AGG-ID: 4OIZuNQ-PqC21NWOqPH9cg_1787657336
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B63E619539A3; Tue, 25 Aug 2026 11:28:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73C6C19539B7; Tue, 25 Aug 2026 11:28:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:20:52 +0400
Subject: [GIT PULL 02/19] migration/multifd: fix Error leak in
 multifd_recv_terminate_threads()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-2-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=820;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+LKimukLDsA97vQJORj8HNh0cTRzyFzAcZxyCRym8nY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrTlgcUFo5mK7wQRr9kMkNuye5tjuWH/HIy7
 HBhJkOICeOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao160wAKCRDa6OEJdZac
 5f1UD/4zeTIFPfpHGRY82STy3NwzXPV3P8o0B/MLZA7UVKYN0O8EBccqtK1SgCRgogmoLCHvoxH
 JzLe37+bXR8lqdk54HqlF776f6Ve3GJwKR5DSom/lDZ5xikJ1DW2u28Wn8zIGW6rvIaA29eERnl
 tHxwZscT/mWKGniia/BkjN7Daqu74Saf17h33xWDA2i6DVGocYjbju/bGS5R97BMKBj+lG9x5FM
 74bfK5zUgLyX328oh5JGUo968xvLQd32HaQ1Brj81/pHuggxWSkxhoL4Qy8RNWXN2ZCfB2Ti/Vq
 gEhooIfY4NpmDOuDxh8fw9h8+dN6qF4bzOx7sIu8DSJopUpRPDTIqvdrEx6bJUprcuePPdoHnTO
 wvQqaC8lA1R/MWfUZMXx1dqMhwsFnvNp9CkthCoUO+3HHucgZ0jwLTfodI6gztlM8nir/K9zkoj
 bMcJkkr6mcvpuhlpTxIBNFu5XkOXt8ks5UuazU476J0IYgWRlmNPG3dT3DKpOp9c4cb14AafmRb
 qtkmdxh7AEyXZTQLtbxpQib4l9MBSPounkVS2MLpN3Z9aVNFUP7ULPEg3YFpOvNmorIJHkBpeEd
 wBvW8rW0tI9GOxKX2KXpA8ERXhMxMz7BvB8kgllR4F+80J2YH3Ti22KbsjMCIlGMwFHTJV1Zfpr
 k2fUjjwflARXhZg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If err != NULL, free it.

Fixes: 11dd7be57524 ("migration/multifd: Remove p->quit from recv side")
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260727-fix2-v2-11-d0c4831ed7ea@redhat.com>
---
 migration/multifd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index dbad525d2a28..503014f76ba5 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1056,6 +1056,7 @@ static void multifd_recv_terminate_threads(Error *err)
     trace_multifd_recv_terminate_threads(err != NULL);
 
     if (qatomic_xchg(&multifd_recv_state->exiting, 1)) {
+        error_free(err);
         return;
     }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


