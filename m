Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7B6CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM0A-00087v-Bg; Wed, 24 Jun 2026 07:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzw-0007pE-3p
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzt-0007g5-LO
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2smrojAx1RvUhqG1ZWT81uzIAxkwAuZYAeo0lV4SJ8=;
 b=eYbXIant+zXIvZ3Zfk3jpoifLFW1GC443GY0RFXkA5Bv3olmDmkctHyJxQnwOAwjh0+WgN
 lsJIJHVsc57BGtVRn6y8mIHdf/zUnp2MRH5KNXTVGuBzlcHPdUmn6s/GlGmCGxQrZKRxxf
 0T0qyAGoO6iL2A56NnUSQPujBkB0VII=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-nKOjbaO9OwW9KZcItI7TNw-1; Wed,
 24 Jun 2026 07:42:23 -0400
X-MC-Unique: nKOjbaO9OwW9KZcItI7TNw-1
X-Mimecast-MFC-AGG-ID: nKOjbaO9OwW9KZcItI7TNw_1782301342
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D5C91800675
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:42:22 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D162180058F; Wed, 24 Jun 2026 11:42:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:31 +0400
Subject: [GIT PULL 09/35] ui/dbus: remove mouse handler on dispose
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-9-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=889;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tf/GwfRlyVIbAtoL67IvBgK+QJwN8oMS4UmojIw4ED0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JnN6oSQ0os7qHANXZJdH9PwdypimyS+AL0V
 yhvs2w1VJuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZwAKCRDa6OEJdZac
 5c7AD/kBgX8ia+XxX2Q68PZK9hvIsiU+XYhIAicjPOcMRaZF+sZTMaDeSfv266wGz1+ANpfsF1U
 Xpb1BhJznBvsMN0muFMp9lEi4wizWlR5ZBLUzEznzSC9sx289kGOivgzOFX0lJcet0X+VwVXpzJ
 BlP7RyihCwxA4R7jnp3sTHsEurOfJevBKY8mQuV6E9+qM67wiLv+Cy4wWH9/JD6XZXQbBrlTVwY
 cNMnkLhI9GTbyogjWd+mQW+KNRvlCN2aWJqDRSSICCsC3+VFTk18PHJK7ljIAABYNC+n2xMn5YS
 5bgWy86MIzm/9DXo63SRJpx0c3JYUf8xkf9wqkV7XQ5zJVfzkRaFv31HTDXb155BrERfdPrAnmK
 78Xp9Uj2o9bO02JsRJ2NVTQUI95SVXYv4lhCv2iJd5IseQYzSP93FD/bJYFGv+nq0K18F5axT+1
 t97tAoxfLGAuIUVQYCaJttsx4YW5wvnVlQ8++mwu592rzNbnQ7LiD0iHe8K9gfZNiFx07F1zlXt
 2fr+0u3HnFZnUgca1gM85Ob1Wb2AChIWx0PYmXIHfYFEB0cSNm0GE+IOpyIifWYZ8K0HPpsWgX7
 EaYtXhR5c2b0x/+fuQOgPmZeFYGCYRurUAve8OAekxwuVHPCypsQCp4XZIdpZOvbfhNixzMHQVP
 zQYJ2Xu+Ls4z+gg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Fixes: 142ca628a7 ("ui: add a D-Bus display backend")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-9-4656aec3398d@redhat.com>
---
 ui/dbus-console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 9e154da1eca..bdbc208cf01 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -154,6 +154,7 @@ dbus_display_console_dispose(GObject *object)
 
     qemu_input_led_notifier_remove(&ddc->led_notifier);
     qemu_console_unregister_listener(&ddc->dcl);
+    qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
     g_clear_object(&ddc->iface_touch);
     g_clear_object(&ddc->iface_mouse);
     g_clear_object(&ddc->iface_kbd);

-- 
2.54.0


