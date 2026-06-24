Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0334CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1O-0004Jz-Hv; Wed, 24 Jun 2026 07:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0x-0003Yg-6r
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0v-000883-TF
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKq1u3IK8E4v/gdero8qdkjriMcWlHKY69DFqubwGyQ=;
 b=MOiPsggNLYOcT20Kx+/PmjKFpo6Mg9vmoC8onqGYb/eXbhKszZKv1xI+ZUXfb57F9Bsmjv
 QQttTjpVWzEkKECgKUZxhKTHbBYiPLW1K0T7H96fUTF9oDrXbMiX/AR3lEdlUjLMoTXDVR
 3ddrJTZ6FE4OcVxNBiRZHd0ZEkeZST0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-KTGZ1b7-PxeDJMKc4Raq-Q-1; Wed,
 24 Jun 2026 07:43:28 -0400
X-MC-Unique: KTGZ1b7-PxeDJMKc4Raq-Q-1
X-Mimecast-MFC-AGG-ID: KTGZ1b7-PxeDJMKc4Raq-Q_1782301407
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AE831956080
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:43:27 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D74F036921; Wed, 24 Jun 2026 11:43:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:43 +0400
Subject: [GIT PULL 21/35] ui/dbus: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-21-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1049;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2aKIg62VA8XX87mRx2I8fmrL2TNHuzM0RF458V5cBNY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8Jocg85HtX782As1kAky0hPBF/6JwVLaC613
 S6nE+facBaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaAAKCRDa6OEJdZac
 5cvvD/42bgMGeUaFeYu6D6+1vnW7ceYSavUgloCxqd+7As5H7rV7xms/Uvj8urXkIf03Cs+WZMX
 gcI1ocEZKP9++pbZl3FCgPnt7/xkK2bFLayn3DDV9H2z57Go3NX1zcyurmMTvHbKKJJga+5FsUq
 LqMkhzxLioQiFaofVVneJBoamI6WYP05UUKU7KsaRl72kCqACjXgbYzI/nSCNbalrQ/NeGwCPVW
 VfAX6wHFtPw4O56GVkYaTM6a7IZlxLfXCFxwmuukI/ToUD3VLjYum3hQth1tZ2ZwdQEYBorYJuq
 6OSAI7/UST0NwzE6eBo8DdGCv7Q4ct5Zv6PUPERUSEmJbgGZ9sxYUZZeRntKUY+m3wGV4pg6zNq
 gocYf+vVihKuVscxN73wUaR37A52XI5skP1jjMTMeWYnF6m3FCTYJPTJq4S/Q4qjHpJbc+yDyaZ
 rdWtt6uSkEBCYJEZ3r8RTCZ2UqPgSOtaeb3eCk7rw8DQZG61a1S+LuMXa6+pYqQZr2Xtmg70vbQ
 Sgurn6AfmtX4QqpREsNChkYj3p7Qe08hMtdMlF/jRvA+5228jeOIrnCGp87QbDvDJt+ZI63ENTg
 qp+s0yq3K4PzGuCbxTj6dOkuaWwFgAGNd+bBWOULUB6w8jSd7JySmu/MtJRVi6OpixtX7kSeW2y
 5mA7F/nthuwiBwg==
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

Add dbus_cleanup() to unparent the D-Bus display object, ensuring
proper teardown before user_creatable_cleanup() runs.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-21-4656aec3398d@redhat.com>
---
 ui/dbus.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ui/dbus.c b/ui/dbus.c
index e02a94df2f3..b23cb44c535 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -615,10 +615,23 @@ static const TypeInfo dbus_display_info = {
     }
 };
 
+static void
+dbus_cleanup(void)
+{
+    Object *o;
+
+    o = object_resolve_path_component(object_get_objects_root(),
+                                      "dbus-display");
+    if (o) {
+        object_unparent(o);
+    }
+}
+
 static QemuDisplay qemu_display_dbus = {
     .type       = DISPLAY_TYPE_DBUS,
     .early_init = early_dbus_init,
     .init       = dbus_init,
+    .cleanup    = dbus_cleanup,
     .vc         = "vc",
 };
 

-- 
2.54.0


