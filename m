Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0A7CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvpL-0002rD-1w; Tue, 23 Jun 2026 03:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpB-0002YB-Dt
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvp8-00086o-3C
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1A9+CKU0AZSLNHR3do0Pygirm8t9vL61hlU5smuwJmg=;
 b=GXtc5YXcZxukKJZxoaLqO9ji8w2xGxQSsIYVlmjTexL/aJCBkYSE4s92QjAoVZo/kSszNa
 Wk0FBRYV8AjZ79BMGB1G7NK4n301O31ktMiJPPx/SljHOR0da7On/aTE0NhEqIVN7oKqjG
 fM0MsI3E4UrcvWdWtffmmdQAY2nnK6I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-eEXCnLe6NxeoYdLck-fNYQ-1; Tue,
 23 Jun 2026 03:45:30 -0400
X-MC-Unique: eEXCnLe6NxeoYdLck-fNYQ-1
X-Mimecast-MFC-AGG-ID: eEXCnLe6NxeoYdLck-fNYQ_1782200728
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBA551955F73; Tue, 23 Jun 2026 07:45:28 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C89BC1800480; Tue, 23 Jun 2026 07:45:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:24 +0400
Subject: [PATCH v4 09/34] ui/dbus: remove mouse handler on dispose
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-9-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=771;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4oL70KcFscssrRE7m/CwYJUFuGDvYgk3CIEeaK3VhYU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjldKfv70UWfv6OtvDjieeR6/1uM2OzFZejrd
 Oa0oTsyg8iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5b5uD/9ERs6ZmgkiNmfqxZG7nJHxD8IeBdzq58RhQP4cds8nvqyRFub/wGH0dSIRZ6LlAByqoBJ
 AeTx+Ehb2asPo4pvBXZMiZh7CUhg+G0Z0Yhwyuhw6m87sH64sfn8TT9iZkJl7Ew/WdSBaFqK8H7
 UTvWPo3Byeaf8ewhrINUgtmf+rWN4qRNo2Yhg9nhNEl5QbKnpZ3cS4FRNHXxUV2LHsQelASrLm/
 RpnPDrM0BVxvAnSPICVkV5y3lVxtzbVXJOSHp1PkFfQXrUXqzWE3ontS53EzbjSeCsQpCvU86rD
 fg6popIwZNZxg/usGmWrIOILc5CNA3rdpg1GrtgjVvPpKwdEll1yKwQPMhl5t8N+el2DAwoMBpM
 n8uTwYtU/uRIYqQJXS+2pi/UsCnEbGVBzuT75m5z3hFj4ghRENbcmMqq9Nzgevuo9T7JjHjFUD8
 11GGKcdX/IGTpFRrm8VGOkuBc3eE1s4hebIuuBvd0ySrOcXpW1QCwtarjs1lizJLwz2JhK43UIC
 10OcigVu1vPegZ8cAIMMsk5obROJ9QFlYEsEylW7xFyrJWcgDWXPGy/QYSdotxxhk7x8+qba0lz
 UUv0Apdnoe5Vdue9MQg/1OswF/nzsHd3DLiBRlm3f0iN/0yC5IAAA4+zVQz0WhsCNjxL61bE7F2
 5OXVLRjGjOQL+jw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Fixes: 142ca628a7 ("ui: add a D-Bus display backend")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


