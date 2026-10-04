Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A693CA5FF1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJNo-0004Sr-Tj; Sun, 04 Oct 2026 06:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNn-0004SZ-8B
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNl-0002sd-SY
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHoFZD5sIRnnYHNS3nLKcngblmCGu+szFra9x1cDUcg=;
 b=GpbUflS4mi1uoRdrbAl7VQUYaTC6ZSwvyokY6foTPKY6yISZ0d77SdxzEtfKuteK5vXam5
 iCWlNHY7ZPJUjxLkwkUzom+BAgWVAhp2aeLYoGnTOdMmsnIYDzAhoKvWpAlT74nyb8tKV7
 x9FkzxXM1eUn+HlNvWZ+X8ise1IG/tE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-8WUUtjGDPmqji9U7dVLqOg-1; Sun,
 04 Oct 2026 06:23:46 -0400
X-MC-Unique: 8WUUtjGDPmqji9U7dVLqOg-1
X-Mimecast-MFC-AGG-ID: 8WUUtjGDPmqji9U7dVLqOg_1791109425
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24A9C180065F; Sun,  4 Oct 2026 10:23:45 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 069A230000E5; Sun,  4 Oct 2026 10:23:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:16 +0400
Subject: [PATCH 02/63] audio/dbusaudio: fix off-by-one in volume channel
 assertion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-2-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SzXXC520H6Tb8kfp43F6a4I/09lRl3IpG6whnafboCI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikhFAq1Sl2EUmdFiLwe6tPbz+VNxFK3pTu7p
 Ets82NqcsSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIQAKCRDa6OEJdZac
 5d8uD/975CHOuimKg6ahPdbHVlGg8pALVQ6/gd/YgJ8xbCuBkz0+NRAs/KfydMzzyTkVJO0hyve
 KS9CgvIF7qtdzchkGWpPmnO25iW+wJBkLKslP31RKUgx+Yca3mouo7sWUgDdj1vneaPYRRY3Co7
 jUYngD+i+Ed/ptMH/VwZjScGQlN9UmKnTB/9XdHF9Z7A+DPc2sT1rEWO9D0pBd5A9XE50C6B3bC
 cy0FTFH2K+EOTyDHAdwRdcWFm+qKgS8ofHjqeCKRU1mDxNzFDiR3uWUAQfeW3sITPcbctzVkC3h
 dOVIZqql2U1BEcUhHat5qqdzTLTLvvt/4PFMZna4uDjnf0EY0ADHVzPvJj2Z8rK1aZqZFVXbDbH
 pMG98duokZZdVVAMopiWQTM9RoUXX44OvCPwT/GozndXdMlytZbl5aZejo5d1FadpuV2e/rpS43
 kwuoNiWy/vtHmHXT7CkjzGVjAnAuIBGJero44RnpSwsCQvdW4rcr7W9IVHx9rjZHpH/LB0K96EM
 c0phPtvJ64nAwhDlKLpve0pL/+VxYYV3leSwn8QlfhLIOx4gVLXDfv/kMakZS87Y4SZec5c8a7j
 9sJTdLs9q5g+XSG4GkXpl1XZHogRzyx3y5Jocv3zHFY6iggv/eLRzMCFjUTXV1dZ7gifRfhvQuO
 mL6LaR4ni8jA9PQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The assertion vol->channels < sizeof(vol->vol) rejects the valid case
where channels exactly equals the array size. Use <= instead.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 739362d4205c ("audio: add "dbus" audio backend")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/dbusaudio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index e9bdf6adb5bd..7d762fe873cf 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -242,7 +242,7 @@ dbus_volume_out_listener(HWVoiceOut *hw,
         return;
     }
 
-    assert(vol->channels < sizeof(vol->vol));
+    assert(vol->channels <= sizeof(vol->vol));
     bytes = g_bytes_new(vol->vol, vol->channels);
     v_vol = g_variant_new_from_bytes(G_VARIANT_TYPE("ay"), bytes, TRUE);
     qemu_dbus_display1_audio_out_listener_call_set_volume(
@@ -332,7 +332,7 @@ dbus_volume_in_listener(HWVoiceIn *hw,
         return;
     }
 
-    assert(vol->channels < sizeof(vol->vol));
+    assert(vol->channels <= sizeof(vol->vol));
     bytes = g_bytes_new(vol->vol, vol->channels);
     v_vol = g_variant_new_from_bytes(G_VARIANT_TYPE("ay"), bytes, TRUE);
     qemu_dbus_display1_audio_in_listener_call_set_volume(

-- 
2.56.0.rc0.29.g47ce80527c56


