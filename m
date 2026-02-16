Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C513EE7BD98
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfh-0000cq-Ix; Mon, 16 Feb 2026 06:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwds-0001N8-TO
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdp-0000BI-OU
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q2Crx2KgUAwnEy87HWgsOaaYoitWHO1zrWYwI/ei/8M=;
 b=OXOHJnjjJkouigVeVSMmB/KDcktr+UlqnJsSeRsosY6QBn8OqbMbEkE1/lGNR7joKoVAWu
 +RrVboPQIBE+Vj6pX42k86w4Y6OFrUo8QobwZaSDJ9XX0fdhj4A5+uXL4DwnpsIQsey33x
 G2xfRLyHlfx0lF3a0+bEfnda54rIoe0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-wztx3Tz4MEavFk7S-CErQA-1; Mon,
 16 Feb 2026 06:19:41 -0500
X-MC-Unique: wztx3Tz4MEavFk7S-CErQA-1
X-Mimecast-MFC-AGG-ID: wztx3Tz4MEavFk7S-CErQA_1771240779
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16E381955E85; Mon, 16 Feb 2026 11:19:39 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6575619560A2; Mon, 16 Feb 2026 11:19:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:16:14 +0100
Subject: [PATCH 85/85] audio: fix leak of audio capture name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-85-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+/qbPnbuV5WIbcdJiURpXcBqN7bHW5OURadsQ5xtxzU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxSgPLkGa2xJzc0EI+p2+p70rKTHKwdzl9HW
 TN5LHqVN3eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UgAKCRDa6OEJdZac
 5YLJD/9t6KHsCgWVm7cqSlatVlLUB3q/e7xGytm+ZZPCXOSrSf5fY+hj415LUG8bsG8xV2cosX8
 MEOTmRQnC6RHVCryAjG2n+ifi4PdniHgmO50U0/nKI/BW7tayodXxc7JlgmNXo9FPauSVgfAxcv
 KU32aKMDj7AjTNkaqbn8dXcbXnGkDH7U4OTmggvftG6mmj6rs0Kh9WqGKOpyVvZ/omFuL7Q8NRH
 B6oZUV8insD2WL9/F0ugHLIRr5uUsIHSuWBpLZ/kK/XP9EFFdeRcYzOP8UgBrLJU1DMH18LDrce
 ijdhV1tFRpHeSdu/XwZKUJYCNUc9iizK39RZcq4ykBXpRzLTsL8t826gxcIjbmcZpDaok1Hzyl4
 nNHlft2DfNGV9/+WsmeLY9mXkhi7XYMf8+FiCuJ3EmKuUJ8lLaWgzonQfUXZOaQeq2YCm4fIu6x
 qP02bwcGLkqPo0swNGHQ8AYH97wtGpPk9PEqjdlULY8Izf0p2yq595t3DON0Z6os2qm5dG4KVjm
 Uh4Lz+SAy7EHHau1GRIadVhOu4cYW2AQq7j3SlfJg/hAYRvLIHtFLc2LH0rxZm5Zj9Bs6Ga1jBQ
 qalQdfPISV5jfYiMnJhi2gkmjMFn8GK/02PyexJvJKig4oLtdONRQKppztA6cD8DmiKs8hkdPhF
 QZnN6LPWQ89Qm3g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio-mixeng-be.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index a6d5812fc65..37040450511 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -227,6 +227,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
         CaptureVoiceOut *cap = sc->cap;
         int was_active = sw->active;
 
+        g_clear_pointer(&sw->name, g_free);
         if (sw->rate) {
             st_rate_stop (sw->rate);
             sw->rate = NULL;
@@ -1618,6 +1619,7 @@ static void audio_mixeng_backend_del_capture(
                     SWVoiceCap *sc = (SWVoiceCap *) sw;
 
                     trace_audio_capture_free_sw(sw->name);
+                    g_clear_pointer(&sw->name, g_free);
                     sw1 = sw->entries.le_next;
                     if (sw->rate) {
                         st_rate_stop (sw->rate);

-- 
2.53.0


