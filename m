Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16395F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHOJ-0002WG-Iy; Fri, 10 Apr 2026 15:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOH-0002W5-OD
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOF-0000aY-08
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3GkcxD4jjJ8nW0/TsJHVunvewBQEbuA/3E1+0rTj0s=;
 b=IB3cFRUjFfaa+/PTNJNuQ9D373elqEss+QCCcaMQaNb+RdokuTZsaINdZkKlbjsGwGo4QF
 0Vufw/+vNg7E365YgBMxMhwaOrPVPYAzOHq0LKBkUsHFgch+8u21SbCH1HWk1c1sWE7yD5
 ub8NqwWsu7CKsCZVVJvfNHtNCNj/q6I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-WK3u5ZdFMvaE_ilWR5MWNQ-1; Fri,
 10 Apr 2026 15:19:36 -0400
X-MC-Unique: WK3u5ZdFMvaE_ilWR5MWNQ-1
X-Mimecast-MFC-AGG-ID: WK3u5ZdFMvaE_ilWR5MWNQ_1775848776
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E480D1956088
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:19:35 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9390C3000C1D; Fri, 10 Apr 2026 19:19:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:29 +0400
Subject: [PATCH v2 07/67] ui/vnc-jobs: drop redundant (and needless)
 qemu_thread_get_self()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-7-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=782;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bQo4AiXo3/Djihjv7WfqxpSjZnrdrffDBbBND0Ml97s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0TeL/vhE41+B8CeyrvPwmdri9VE8xsk3+Cc
 JsgGC7Td1eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNEwAKCRDa6OEJdZac
 5QDDD/4+H8psQ0Y1o+to+oP+ReXjYXe5x2IV8m/z2UCQUCnTPkVLke4FVcn37GwPPxhmG3qYbOZ
 Er5MsqETPD85wCkcPzsHX9hssB9GJlKm2ve52ayEvOv6Zq9oeRFlH6xs4Z97RZmPQrVrd4UsrHF
 4xPF8kP3Gtz0VWPRZYY4gOiPtvQs9lVbW9MTXCHCiQuri+H+V7eayQHYDc04SZmc9oAyfXEhPkZ
 OPJFOeyuWrVflZgkJ04Ar8msT11pIaZev9ZHX/SHsIP8qS2vsXiT4KpXWDKoYkFyRAAlW3/i1LE
 2S4MIyiQiVFKqCYrV4wFC6NjDMCZAylI8LEGbskyUHqHl74BtXcHWrkwd6wuE65vPI0cOeJhDaQ
 cSbwYMAiaBY1S3Rs8wEV4Fgz5D8R/aVH7OoOgjEU2iY1RyFfXUP6/+eeLdcB/IX43XJSkxWQJbP
 3RsDtgDID1Q+aiMbkOhoMN1CEILeTlmukvJUSY6K/Aly0+3em9YiF6U81/WV522dGxBx9PV7Oc2
 +lYqK9CT2WYDvvaNvT2+yZ25fG+A1s0RHacoLQzpWsap8ysfW/MLmJguxm4a+jNN4CO2UzYJPn9
 A8ehEfqJ/hkQAYaA3kURFXQlDF2jcn9roGJERyGV0PSOzomCOhw8gRgJq6ymFbPLossJg/rpzDr
 4dKmv9nwm6wh5+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

The call is unnecessary, since "thread" is already set at creation time.
Furthermore, the "thread" field is mostly useless as the thread is
created DETACHED and isn't used for anything but perhaps debugging.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 9c17d684c9e..5b17ef54091 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -354,8 +354,6 @@ static void *vnc_worker_thread(void *arg)
 {
     VncJobQueue *queue = arg;
 
-    qemu_thread_get_self(&queue->thread);
-
     while (!vnc_worker_thread_loop(queue)) ;
     g_assert_not_reached();
     return NULL;

-- 
2.53.0


