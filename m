Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B000D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ21l-0003Ih-Pv; Mon, 01 Dec 2025 06:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21g-0003DE-1Y
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21b-0006ed-Tc
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgXIFNbzNbMEISNKwvTVpu1p++Wmxf2WWlB2/7fqY9M=;
 b=DxQ7sil9uzEtaI+cIUON3K8tfs81VmHhmUBJyv/Gh3SlORQDBDErSlZQEgP3dJXgVeJqeX
 cqNokwzI7lLMjbeKp+INDVQvbkVNt1m+FgkCEVWb2keSaWJxZAZVxf14bKy4AqvmtjsEVz
 9ELoRE8wz5Rp0ZOecaRfrbpbBtFNC7w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-8tLoAzrVPzuaH25-8RooCw-1; Mon,
 01 Dec 2025 06:24:55 -0500
X-MC-Unique: 8tLoAzrVPzuaH25-8RooCw-1
X-Mimecast-MFC-AGG-ID: 8tLoAzrVPzuaH25-8RooCw_1764588294
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48EC6180048E; Mon,  1 Dec 2025 11:24:54 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF5C130001A4; Mon,  1 Dec 2025 11:24:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 15/24] audio: make create_pdos() private
Date: Mon,  1 Dec 2025 15:22:56 +0400
Message-ID: <20251201112309.4163921-16-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Clean up.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h | 1 -
 audio/audio.c     | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 3bf1cf6a99..d2d54b924e 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -313,7 +313,6 @@ static inline size_t audio_ring_posb(size_t pos, size_t dist, size_t len)
 #define ldebug(fmt, ...) (void)0
 #endif
 
-void audio_create_pdos(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
 
diff --git a/audio/audio.c b/audio/audio.c
index 138d7b502a..7e5fb4ff8a 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1990,7 +1990,7 @@ void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol)
     }
 }
 
-void audio_create_pdos(Audiodev *dev)
+static void audio_create_pdos(Audiodev *dev)
 {
     switch (dev->driver) {
 #define CASE(DRIVER, driver, pdo_name)                              \
-- 
2.51.1


