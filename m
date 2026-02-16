Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCDEE7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwch-0006rr-0D; Mon, 16 Feb 2026 06:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwal-0005Hv-PV
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwah-0007SD-RO
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PiNp7Bs6o58noepSb4ZJhulxFQccOR3mrQTA7FuQtxU=;
 b=G21GSbAUcFDl6iOiLUJclM8ukwWdWQk9H7uY70dIG1s6U+Egi1Gr28QlRKyC/gJiQ88K/6
 /YLatecIoO3PVef4MqTCL/M97QaeN0IB/VEjDeZJlE3bNl8msDicclLmRZuvQDb419a06J
 kYEZhATc0i74hjwk1F5816W4gDoU2Mk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-oy1fdGjvOtqU4u2GX6kfGA-1; Mon,
 16 Feb 2026 06:16:27 -0500
X-MC-Unique: oy1fdGjvOtqU4u2GX6kfGA-1
X-Mimecast-MFC-AGG-ID: oy1fdGjvOtqU4u2GX6kfGA_1771240586
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA4DE1956094; Mon, 16 Feb 2026 11:16:25 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BB8D1800464; Mon, 16 Feb 2026 11:16:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:06 +0100
Subject: [PATCH 17/85] util: add some extra stubs for qemu modules
 initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-17-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0p2rFVhBpMNMUs9tMxnvfxcuRtuYlOuGuoE7FxD6FmI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxOsm+4rwYJX7KYrAbNHOW4N3InH5fom7+BX
 eFgmummRU6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5QEgD/9wts+kf9cQB0JcrXewmZmcdhJGqAwHKP6qiMmshyK2fQ1Dp6Kl1IXCH7r3cZ6IQJluCq+
 GoZADxmeKVBsYSENAbKtn8eyamOm6W56xtXkS5YBYmVZWk0VlsWhqrMrnZQ2P9JEjjp2qZDPIqD
 JkyVF2HdYfxzjWmO41rSM9seLWdvUdB/weDz8DdH1KbPSAM62NxYMXDegTkDEmxU6ykuE1Pb+ml
 eDgaXI5ygJLxmPk56GVvR/LEqSAShWK6sZe7HMfZKDrzRslq9eOtSiGPnWE8J9GHLZ1Vx0amPpd
 bTgzokFBsyFM4l1owuJAU34If3uvYlvXC/NeRpvm1W/UIZ9sgj9BIraRx6rty6rgJqfevokbxYt
 kN1SLaziNHPW9HB7W/iyzxhgt6dG9xPBwW6EGVwlTzqoagT/lffaDj9lUW+h0DkEt9J7VU02v2R
 ar4vK0IBqPfzl9OnYIPODyHb+G0I3gieEBbCW5TCZlSY+qo6WWLOWUYqJHarS5xGcLAC9UzHJJ2
 erNduJcoW3Qa8AZ2iCq7+We6jn4y7OZVf7539ONqATZaUsZk3WLXV4ZbPCZQiWVQmaO9l1wj/Qw
 uldMmisPUy0WWqsjGe4k+zbai4AT+90rYV/Du4A5xjVVVud0azCaPVbCs3M/2+Z05YuAScSFwoD
 Y+/okbSk7FfQpGw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Avoid extra ifdef-ery when optionally supporting modules, as done in
audio-test (and vl.c).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c   | 2 --
 util/module.c | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index aa9a1550417..3e341142a0c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2889,10 +2889,8 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
-#ifdef CONFIG_MODULES
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
-#endif
 
     qemu_init_subsystems();
 
diff --git a/util/module.c b/util/module.c
index 1aa2079d013..09dc43f51eb 100644
--- a/util/module.c
+++ b/util/module.c
@@ -396,6 +396,9 @@ void qemu_load_module_for_opts(const char *group)
 
 #else
 
+const QemuModinfo qemu_modinfo[] = {};
+
+void module_init_info(const QemuModinfo *info) {}
 void module_allow_arch(const char *arch) {}
 void qemu_load_module_for_opts(const char *group) {}
 int module_load(const char *prefix, const char *name, Error **errp) { return 2; }

-- 
2.53.0


