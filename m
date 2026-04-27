Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A3AFF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRsQ-00022Q-5C; Mon, 27 Apr 2026 15:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRs2-0001aT-SE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRs1-0007vB-3O
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egYIv/p9RXUeDoiMYZq9As3HoDtdRyVZwD6hR7aG2Jo=;
 b=CllAZTpTPVT1oCUmFqnI06r/lJAzEykUA1izlTX9pf/sSXQ7X0nkqAbGBh/NMsmjGOT4Is
 VtZNwEWpVWLQxtD+JTVaATgVj9yBFaK8zcWW9DaIPQA4jJ5PBoH1sxp36cum/PWt+6QgzA
 KlS5ZWUVFNah2ROL5n6Eropt/jXi/os=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-ijAB9nJkNeaqWpZ13AfHCw-1; Mon,
 27 Apr 2026 15:43:50 -0400
X-MC-Unique: ijAB9nJkNeaqWpZ13AfHCw-1
X-Mimecast-MFC-AGG-ID: ijAB9nJkNeaqWpZ13AfHCw_1777319030
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E382A1956089
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:43:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FC811800347; Mon, 27 Apr 2026 19:43:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:13 +0400
Subject: [PATCH 14/41] ui/console: remove console from global list on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-14-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Wp7WR0az9Jyz+mnAyK07uOQyeMTXWYE2QIBV7PHHnZE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUhOPyGzvb2BgMJUMAWRwr83cuFs2T6dHMt
 +33n93FZ/+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5Qe7D/9dBYxhksySVuJ9gtIVqop0gMCze1pLRzlTeAHdFVEl0Xtt8Fe24yynvJy5nV90Lc3uFZT
 RKgn+0b15JXgUJRcZppnlZhQ3YcFiwla8TuR0O0lcwZQmPl968sfTQTGLo5dg8F0vd5cmXpkFEA
 HajIQk5hPrQbGYOz6A5v0Aomse7DKtvq60qjtSensOhxKdHRFKaPKmHqfj+Zl5Yw6YqbUsjZfo8
 IxzIMMv2+8iJhpdk0nLJowobPfa9CvekyMGz//QPH73FcJ4xC1k6sgLnWMarB3vVRWfRXpVbIBt
 JN2F3pAYKWRVTh6AK0ShEvK+/duotjiLlUiHZ3VSQiwy5ci3z7E/t141SqLRQkiXHfmSbGTjm1i
 SvKxfX/6EYWxyYwakcxJllSqaj9oLPUmrPebLQKRSimQ6lpzxSFQ8pkNId9vnHzEfMBxzV4rqcP
 wGwOsuKVnPFY2OfxuEetyQSZEUsbaoBeSWdzsi2FjdO635ZZYyIXCZb/RM17Z2Q0gwARndat47N
 IZSuzG2EukcQDbLKKYCy3IQj/0lnmQR5OBxvNpHlxvMpgCSYYCT25Pj2I2BkHV3Dsd4D8+2IaI8
 j1I4/MFELMZquvPKd5/rGiyA+GDTM4li88ha7lpxfbIVFk9TJCVHqwvVmapZu0jOTaL26JCgRY2
 LWq9c5nZXgVlHBw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This commit removes the QemuConsole from the global "consoles" list when
it is finalized, fixing use-after-free on throw-away objects.

Reproducer: QMP command qom-list-properties with typename
"qemu-text-console", "qemu-fixed-text-console" or
"qemu-graphic-console".

The assertions added ensure that `dcls`, `gl_block`, and the
`dump_queue` are empty before removal, confirming the console is in a
clean state. This is left to handle correctly in a future series for
hot-unplug case.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index a7bd22515b9..fde8f50db21 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -394,10 +394,14 @@ qemu_console_finalize(Object *obj)
 {
     QemuConsole *c = QEMU_CONSOLE(obj);
 
-    /* TODO: check this code path, and unregister from consoles */
+    /* TODO: fix hot-unplug support of consoles */
+    assert(c->dcls == 0);
+    assert(c->gl_block == 0);
+    assert(qemu_co_queue_empty(&c->dump_queue));
     g_clear_pointer(&c->surface, qemu_free_displaysurface);
     g_clear_pointer(&c->gl_unblock_timer, timer_free);
     g_clear_pointer(&c->ui_timer, timer_free);
+    QTAILQ_REMOVE(&consoles, c, next);
 }
 
 static void

-- 
2.53.0


