Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C64CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJPB-0006lu-EO; Sun, 04 Oct 2026 06:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJP2-00068D-D4
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOy-0002ym-6w
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CR8NhbR3u3BcyIUwpwnhufRwrK2xONxoj6tfVZn2KaM=;
 b=Xn0wozgCrk7tbbDx9Vq3+gq2TaC5CjE5+pdpeG8vJYtAdOhWxpaB1QsF7MFVHDOO+UA9k0
 liKm87DBkuCeia0PwQbYUC3sWCkquZpt4XQEZ5AyHFipUTOGfEWXhQeWbJGmM7A9gWB1ZA
 YKJcI0vansJnPb8L1nXCIB0+SgDZmg0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-ARV_pR9RMxC_FUWBjJfgzw-1; Sun,
 04 Oct 2026 06:25:00 -0400
X-MC-Unique: ARV_pR9RMxC_FUWBjJfgzw-1
X-Mimecast-MFC-AGG-ID: ARV_pR9RMxC_FUWBjJfgzw_1791109500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBE78195DE62; Sun,  4 Oct 2026 10:24:59 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F6BA180034F; Sun,  4 Oct 2026 10:24:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:37 +0400
Subject: [PATCH 23/63] chardev/char: fix use-after-free on mux creation failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-23-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0EMUPi0Z8glZl7PzT7bWjd4uHGxo7x1bULwfnk8zDPI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikisbMRc4JLMjN0yJ+4BDFPiRh65wSqDLdYq
 vKxwNvriSGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5ePLD/9+8UsJzr88WIUlzZqLEg8VLnFjOPJl4KxodrGn0ey6NQRL7WayNy7ZAWoD3O+WiBnHqXO
 u9ZfYWOmBnSPRDjl45HuScSG9md5Y2z3/k18coMUkijqh8Z8eFqWJN4Zj13amwH0E6kbDl3zZMC
 PJ85sKqiZVmUs5givXRxR9wCetf3x81fgJGKi4JOm1WB3hF6GHWv+xoSL9eiz6UN0cm0O0/NX7P
 hqPQjEOCBkwWfCS95iHuO1N4RXbP4nen97d3oZFP8jwFvsNSqL1GhRxEGRKsSut/G6VaxMP/rvp
 FKK8cAb+/V+lVXA1OhRJ+K3c/EcLsdxWxq+BYpIqwE9xd1vYtp0z2/no5srVI6waW+Yhl4nkU/f
 aQ/F7oyLdlCLQnlzC6SjRM7SRR5Q5l6yIfCMFVH8rR1f/C5wF/Cag3/YHZnk4TER4Q3iZIIc9HV
 z+RXCNu5jlcPJmTuipt4crcNyituzAqt55roDd89B5CZEPSxu6pLKQFWSkN3ynMz9ECA8aFh5a1
 LucLm1ljyColXvtHA1SHpWoqQsuY9PbsnA9h8erkRw3QDh+F4kgCvcs/ciMm6oVCQEDQohFKKe7
 ae1vpxct4VajquYy1EbRy9uuNYW1Xwypb7o7jRnpyJzPPD0HIrrSwFFrCbx2aQA2y08zgKr4py/
 gUiUueUrcMk+Beg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

When mux creation fails, object_unparent() drops the last reference
on the base chardev, but 'base' was left dangling. The 'out' label
then passes it to qemu_chardev_set_replay(), causing a
use-after-free.

Set base to NULL after unparent so the replay path is skipped.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 4c193bb129da ("chardev: set record/replay on the base device of a muxed device")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/chardev/char.c b/chardev/char.c
index 9da0911e503c..7daf87f0363e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -747,6 +747,7 @@ static Chardev *do_qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
         mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, context, errp);
         if (mux == NULL) {
             object_unparent(OBJECT(chr));
+            base = NULL;
             chr = NULL;
             goto out;
         }

-- 
2.56.0.rc0.29.g47ce80527c56


