Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C49CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZK-0002DQ-KI; Wed, 20 May 2026 17:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZI-0002Af-Qn
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZH-0007dM-97
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJRk+Dydw6RvbbRSFjM9fx7PdW6TdEoaaUZ1DDM86ao=;
 b=WObJti7aRMw8gaVQvaq/j3mcCel17+5qmmgdA4XLnK4E7fy6ccsAhpaXYckrRDWYE0sAZ7
 dDwxKb81zGc4KB0AKTAXnnlxsN0ztSbi+uDX6ujC2OrSV9B0iwXuq7YM4fcoGeWetQOCou
 vYHXIrLTxXAeiChS9XN8H2SOWiTFcDw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-lFDraUtXMfSeLKfycWnjNQ-1; Wed, 20 May 2026 17:35:03 -0400
X-MC-Unique: lFDraUtXMfSeLKfycWnjNQ-1
X-Mimecast-MFC-AGG-ID: lFDraUtXMfSeLKfycWnjNQ_1779312903
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8c9e99fcd15so168239146d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312903; x=1779917703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJRk+Dydw6RvbbRSFjM9fx7PdW6TdEoaaUZ1DDM86ao=;
 b=X0nKnB+bqvCeNoE1uYPXIy/WuOFY29oUzdzpTFJRdIEfdtJl+uhecySVV4/DzZAJlV
 lje0qmvmQjQrXvmwn5esYGsVEybluykErIgMQBppoNWkLTqRM5SM9XT+82zHXwmGgJvI
 /KcFbCQV2VnHeRFlmZnd31Y+9gwtKfD3ZVjxhpLInOMV67M6e1ktM1/yKBSqZ1JxXPY3
 a0NvzPFcrHZLAlvadJ8KSPuJYz/n3bVp9nqScgawCcU+nyPN3Jd+tlINNL0vi/0RRnq9
 x6xHjMdnPpZ48z/yj7V0ticui1XYutueObX+rNqL/w6UbEgk4R6u8LY1iJYNJ5SyiE/Q
 MiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312903; x=1779917703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DJRk+Dydw6RvbbRSFjM9fx7PdW6TdEoaaUZ1DDM86ao=;
 b=NQ0Vc2FvGpwpv4BHDnWkmYXXeMwFFkPhvRQi13WKUR11PAjcmUeKPNejeZT3MFZ2Xq
 IEGZBYbSUBA0at/LTHhQQmfEQmXoHMx1w2s2T21dg0CI8dN1ljvDTriGpKtkgtzmb8D+
 NREKa2iQxzYMgOso6sCndm0NBr46SMJiyYn6CCUkq/cezHtczDmRxaMdrHDmHm/2zxUo
 9K55hxgf6lBseN71I7TOfnOlV8aoHvn4F/zPTMKFnIDD9MWZODeO3PoSTnNc1OqbsiKo
 XDU8HJCCMRceyFXBYPJVcv9rPId8gqaLQry5PNtio0rktfXq/+ZngaSQfrIE+LTKYnnM
 raiQ==
X-Gm-Message-State: AOJu0YxheVlEgqg8WBClwmciFkFatlmicn5bXzLjCLyF5QQ3SHuOcGIL
 lCACevP3nHRw5PzgEmMPQo2uy+LTUyXoFG+MFFRl+dHwbM9qnfm1CHKXtIGA6kjAX8Tn63E719e
 /zMU7hby1Z2euuih4wAT4U2eXfDOa5fhbEz/sX2VsziD7YNNMS6FNxIKqGSNWaVAyhG0OYq9GOk
 hCPyp/f3lR1GY/neORzncMFlWKUCTQ9HY6u/8o/Q==
X-Gm-Gg: Acq92OHe0B6bNOLwedkkpKDNAyZJfSfVLLgKNqQVIsRyfniF85sN6np7DKRdCRniMsw
 ntAT580LXCep4p8Q37+2Fnmo/opFFuFiLYs9BkeorPkpudq90Iq5fut5txmyTyVALQfrr7uOcaw
 euLgRILIX/kLgZeH5SVcUq/+onSGKFcmjp1IHAjoKb39FXgAXDqUkkledX0efdqDRioA7/5M+Ud
 b1igC2auY7LuBIIJ4MbBpwKMlpGCWKWnIqbN1ctqlUuIQGZ8GjhHsa1qexNqKyLkQHuFDnmq5aL
 aJBwT9aL66wRD0gxV6PMMTcVB0cBDhvIbpTcxS1zosBEqHqFA2vlDfTR3buZVHN08hhuU+UrWhA
 6izW64qNhY/pdpLxeJciHkR6sPz2mZSmx/69PZYzCbFVbxuKWActJbkM=
X-Received: by 2002:a05:6214:1314:b0:8cb:e63e:2a4c with SMTP id
 6a1803df08f44-8cc6e30ab47mr4579316d6.12.1779312903019; 
 Wed, 20 May 2026 14:35:03 -0700 (PDT)
X-Received: by 2002:a05:6214:1314:b0:8cb:e63e:2a4c with SMTP id
 6a1803df08f44-8cc6e30ab47mr4578526d6.12.1779312902220; 
 Wed, 20 May 2026 14:35:02 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:35:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Bin Guo <guobin@linux.alibaba.com>
Subject: [PULL 25/29] migration/multifd: fix off-by-one in recv channel ID
 validation
Date: Wed, 20 May 2026 17:33:53 -0400
Message-ID: <20260520213357.40646-26-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bin Guo <guobin@linux.alibaba.com>

multifd_recv_initial_packet() validates the channel ID received from
the source against the configured number of channels. The current
check uses '>' which allows msg.id == N to pass through. This ID is
then used to index multifd_recv_state->params[msg.id], which was
allocated with g_new0(MultiFDRecvParams, N) -- an out-of-bounds
access.

A malicious or buggy source could send id == N and cause heap
corruption on the destination.

Fix by changing '>' to '>='. Also fix the error message to say
"exceeds channel count" for accuracy.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260518110112.21395-6-guobin@linux.alibaba.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 035cb70f7b..b3eef875cc 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -210,9 +210,9 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
         return -1;
     }
 
-    if (msg.id > migrate_multifd_channels()) {
-        error_setg(errp, "multifd: received channel id %u is greater than "
-                   "number of channels %u", msg.id, migrate_multifd_channels());
+    if (msg.id >= migrate_multifd_channels()) {
+        error_setg(errp, "multifd: received channel id %u exceeds "
+                   "channel count %u", msg.id, migrate_multifd_channels());
         return -1;
     }
 
-- 
2.53.0


