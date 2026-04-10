Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30208F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHNk-0002Fc-ON; Fri, 10 Apr 2026 15:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHNh-0002F6-6C
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHNf-0000MH-8L
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqVh+K5e166hk6+S8o/H6szWIs9EscmRRjA+WfGEXig=;
 b=bj96/u2Jkrx4pWzA01G8jiySRRuLQKt9b6Xvi2rLWp2CzczXPSFVShPGdNYzqc3F/jqJNp
 etjW9wXpOeI8c+B8USh2dJHi2K/a1kVQD1I6hvfk0UPuPF1OKVwich/CHdNpJIWNid+aU/
 ZRk89cnDHrFeggxtFxgEJwAOJ6VrEcg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-pKFKan5wMAWulIJ47d6mMQ-1; Fri,
 10 Apr 2026 15:19:01 -0400
X-MC-Unique: pKFKan5wMAWulIJ47d6mMQ-1
X-Mimecast-MFC-AGG-ID: pKFKan5wMAWulIJ47d6mMQ_1775848740
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4E9F1955F18
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:18:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 954DE19560AB; Fri, 10 Apr 2026 19:18:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:23 +0400
Subject: [PATCH v2 01/67] ui/vnc-jobs: remove needless buffer_reset()
 before end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-1-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=648;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZrOdbjC8BpC69HbB0gl9efwBluKy20HH5buM0Y3OGcE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0Te2cJ9s4E1FtFZXFNd+IKclT9cwi41xuAf
 oZs8fTK8S6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNEwAKCRDa6OEJdZac
 5azQEACiz97E1D/Yh0xWV+q9cfMEvqEPe4mdKr+KwvPRHz5cBnRodB7GWVMsXbIQ3XpEetzDSMt
 /qMq2fq+zkZRMftD7umpbgmD2jz6WgnBlXVWEd7Lv7vsJBlTv65YGReaF18thwfMxefPkV7gsNS
 JYnM0MsnvUNScVL2e/WySJW2bJdhU8+vOtuEsYEnCwSAfJNF2m0R6sBIvHyIT1gqEkrmqSoRsHi
 PfFU/QBzev8tWqWXcuHnPg1DS+KfIGWJ4zHqHRlK//ddd+uaKBMCPgsRwCggmhAeJLi3u+JlxIX
 jbuR4O3OFRMH6B7rmFNyakHYxKLKqfOnNykFgTz7C8HWVb/kUzG7wRjJO0qUZc86BkltyWovcE0
 V9cIEPY7ifbt2ZqhHiAwGJTfjevbkh1IKzYUKVM/vzeuXqUZ37LBUeElm3d4IVx4V5q+BGJxi+P
 jnRKqLEZWWSlSBwyerKI1lmWTwVBmUonnO2tyUdOhsYJtqYE5E/Xa88aTeAzF6f9McehgPWUTkF
 uSDDXNOv25qYVxf8zLYj30EKScvMA9H/1U6RwikcFHT5FJ5R4D+uBB79eGf4XLYDQiIlfAukHK9
 cLLZz5gAxOkapZ+Og7uVhkyytVTocyMx0eEBa/DOJW4bwbRSoX6zw3aXq7KYlw3OU1NpdN1vN1y
 yzB51BCNx7gFCog==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

vnc_async_encoding_end() does buffer_free() next.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index ec90ae6d5fc..a6ab733faa1 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -326,7 +326,6 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
 
         qemu_bh_schedule(job->vs->bh);
     }  else {
-        buffer_reset(&vs.output);
         /* Copy persistent encoding data */
         vnc_async_encoding_end(job->vs, &vs);
     }

-- 
2.53.0


