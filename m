Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D6BCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJO2-0004Ux-RS; Sun, 04 Oct 2026 06:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJO1-0004Uf-1D
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNx-0002tN-HF
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0ZLfI4YNNP0U4FobgpiahknubsEL9QVwMgO6IZ8KfY=;
 b=dAy8rtLfcw8G+zqMksPdNfXfAnWgTcJpGNrGbNt2c/zfgNugvFj0tQvU7GKXZkOVc2jSZp
 cd+/6WIBvevZf9EnmlAYrtZPBzqVQiX39yaWeZRcwC7Tx+pEgqbV7GQsoCtLc+DfoptR0J
 kA/zi/xGIdBgKFoDdCpnFBzF4bd/eGk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-fUCIXNbPO9GkjBjdEucpOw-1; Sun,
 04 Oct 2026 06:23:56 -0400
X-MC-Unique: fUCIXNbPO9GkjBjdEucpOw-1
X-Mimecast-MFC-AGG-ID: fUCIXNbPO9GkjBjdEucpOw_1791109435
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CA371800361; Sun,  4 Oct 2026 10:23:55 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B939D1800345; Sun,  4 Oct 2026 10:23:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:19 +0400
Subject: [PATCH 05/63] audio/paaudio: avoid pidfile path truncation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-5-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dS4CCTSDsdqCuuSPgOh0jEFhhDhJ4XTQroMjOLDrBoM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikhjLD/lmCGEyxe4uCuYsGQHfhc3+czUmLuu
 DX1kUeBzNmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIQAKCRDa6OEJdZac
 5XVDD/9Krzr1oj72uDx1o1352YIBeZRe2mLAbzt096RnyiplYL6ihdH1XMI221c40ZfDuRy7aeF
 Zhq83Hve3v+kDvVpD5qe5sTfCBG6DBQlQaJON2ErzuuDk5UywlfusGWYLRnKhNoOB0HORpqSaM2
 fwmzIZm/lUaWOSVxUWa4IEJoGd4qQQUt5YJYpS6/n+6wW7fz/nMAboPMbrPTWg8dwBuL58QYwMJ
 XqHMNlq/f6+brv2F4MImaJmSaMvqWZjscucl2OvbDnuwS/AYrwXIiJqf+2PPWmfUGfPBsDpiQ5n
 vqvIlqvdOOWFzYzQR5xA7Emc1O6JabfvJ73082RQTdI5/IiXo1fqKERB5T39RQU1oGmcpHAJWWs
 0TaaJzIdGjpamrfrGOjeyMqtC1bPjcWgJiMfQOshK+28ZJpXMxO2NSoC+wjzn64O6ohP6mTucbm
 XIHYfQg/BWURGKhOqHRW683JSDaBuvPZm+TXwLhPqp3Ay89KQA8bx5lFPZpApL478eQKUzby+I1
 tUL/MEs72bcguYFgk2PfDLTqiI5VlCU8L/KgFviHaPnRk8T32RHa2WYs+MVJkZmjhWjoNpcQQbl
 saKbGDpAMlA2gbYC0TLf4BdIJzntDPAWiaZI04LCIyHWQlmm/sCBkd4EqFPQE+UcUI+JVO/dWSV
 GD0SYd9nTPjwTUg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The pidfile path is built with snprintf() into a 64-byte stack buffer,
which can silently truncate when XDG_RUNTIME_DIR is long. Use
g_strdup_printf() with g_autofree instead.

Reported-by: Pavee Hui <phui@google.com>
Fixes: d175505bd68d ("audio: check for pulseaudio daemon pidfile")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/paaudio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 9d0a622fc5e6..358595c0460e 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -819,7 +819,7 @@ audio_pa_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
     }
 
     if (!popts->server) {
-        char pidfile[64];
+        g_autofree char *pidfile = NULL;
         char *runtime;
         struct stat st;
 
@@ -828,7 +828,7 @@ audio_pa_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
             error_setg(errp, "XDG_RUNTIME_DIR not set");
             return false;
         }
-        snprintf(pidfile, sizeof(pidfile), "%s/pulse/pid", runtime);
+        pidfile = g_strdup_printf("%s/pulse/pid", runtime);
         if (stat(pidfile, &st) != 0) {
             error_setg_errno(errp, errno, "could not stat pidfile %s", pidfile);
             return false;

-- 
2.56.0.rc0.29.g47ce80527c56


