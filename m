Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204E3CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM0B-0008Gy-BZ; Wed, 24 Jun 2026 07:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM01-0007pe-KD
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzy-0007hr-Hd
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nm/1DQsW+H85OBSHK9zHCoP/yd4z4ZE5ORDkXPseNS8=;
 b=XinoLDEVjx7Kzy4nx6FnwoD/feO6LmjHrIKkKyoTdTmdMLiCXBi6/3HO4fOIjfa8WqBxmm
 yRMob9sSZDEFkrvBr6w2s6iycF2QgNYA6b9BSlsqytKesIkpnFPslO4mjncYvMlAqogJCA
 YqYiBl/HwjBy9NmJXAZ3W7mZRy6XbH4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-ElsGdnPnOrmrr7-_dpNGfQ-1; Wed,
 24 Jun 2026 07:42:28 -0400
X-MC-Unique: ElsGdnPnOrmrr7-_dpNGfQ-1
X-Mimecast-MFC-AGG-ID: ElsGdnPnOrmrr7-_dpNGfQ_1782301347
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC97B195604F
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:42:27 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 528F236924; Wed, 24 Jun 2026 11:42:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:32 +0400
Subject: [GIT PULL 10/35] ui/qmp: keep a reference of console across yield
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-10-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=U2XesYW1uYhneH7r0f1rZL10mXZYOhZlenYF8jtFDcA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JnrqEXaQ6TvxlOXhXFZKOgZiXe7CQTGmEq6
 U02oclnnu+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZwAKCRDa6OEJdZac
 5a60D/0UAx2YOBZDqg8SizUFbfbfVvy9iZtXx2SkWsv1YSixpwo6TCEWhZ44/YvCIKqHSIA1zcW
 SzUTtPO1AkqGNTUR+/cu9TdsqJu6myzuAIbSLPFLkp51KqeKQmpxxtU76dyRYy1rkFDo53tHKv2
 og7m6fnsBoJz1abJVZOwwiDZ3j5bqvEmJcGO5LyTgXVKpgjkSn/4YRbqat9+T6hd6MptQ1YmN9J
 S0QPw4J0M+HSbTLRYkmTvj15L5AKTdHa7BbBIaa9Cee3EFhC2PphJkAbmaSEhkJ8UE/Bonyieuf
 ieULLxHKmUjY4SILKXbTqBO4NjeONcS4sbwv4nhcPlAPwtiFT0QP9wbQKMFtcxRiT0TITxkNMef
 I+HFa0zvuY2eLb0l4CGFNsaGNWy2iTd7UH/Vw8bfpcnDK5hZAToqo4KqvafMJog2E3EO0fixh5P
 5K0F1I+RPjazqZc6KVHzsV7YXoEkod1mmb6dG2Nd1rAuIWBtgyZWTAqlyA4UsV/g9y/Ye6IcI3F
 6CLjKEf2lSMSGmxIfFXYD5Xsh8Ky92ytPoyk/0E2SHJD5uWG7GxbbxrlmxWMLv59u6wUQdb7Yea
 lkbZx5sFjqhjdcVcAYY8dHrIlbrg1aHN5fPVJs7IbRkkzzE57T+R4yrAgxf9xbqColggoGvjuG4
 Ia9PUEe3AFDdJBw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While the coroutine is waiting, the console could be finalized. Keep a
reference to prevent this.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-10-4656aec3398d@redhat.com>
---
 ui/ui-qmp-cmds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index 1173c82cf7f..753cc2bf522 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -348,6 +348,7 @@ qmp_screendump(const char *filename, const char *device,
         }
     }
 
+    object_ref(con);
     qemu_console_co_wait_update(con);
 
     /*
@@ -358,9 +359,11 @@ qmp_screendump(const char *filename, const char *device,
     surface = qemu_console_surface(con);
     if (!surface) {
         error_setg(errp, "no surface");
+        object_unref(con);
         return;
     }
     image = pixman_image_ref(surface->image);
+    object_unref(con);
 
     fd = qemu_create(filename, O_WRONLY | O_TRUNC | O_BINARY, 0666, errp);
     if (fd == -1) {

-- 
2.54.0


