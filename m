Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC768E98E11
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSXK-00049B-NV; Mon, 23 Feb 2026 04:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSXC-00040b-UW
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSXB-0006q0-JZ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpLVOYM8Wde55LfgKpbzEakLLTFw5alf2wV81ekIxNk=;
 b=Paasb4cIWY5S0VrAaZxcHtzi7uD8V118rwcjlMEDmnNlkRxR1h9ythaxbY9y+1U70IOSv7
 SsC4aGEr/i8QPMWsj6yOQEYdjy8nkUsV0ntu7Qr4cG5wXs50kAha9BItjjfCIaelfxbNJJ
 oIHDcXYlBDsDuz/UkDQxHkQDp9B0mDc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-dBelR8UbNbuXPtS7DauhDQ-1; Mon,
 23 Feb 2026 04:47:17 -0500
X-MC-Unique: dBelR8UbNbuXPtS7DauhDQ-1
X-Mimecast-MFC-AGG-ID: dBelR8UbNbuXPtS7DauhDQ_1771840036
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 513ED195608A; Mon, 23 Feb 2026 09:47:16 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F3D81800668; Mon, 23 Feb 2026 09:47:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 08/85] audio: list backends as modules
Date: Mon, 23 Feb 2026 10:45:26 +0100
Message-ID: <20260223094649.2005118-9-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Windows doesn't support modules, atm, but we can treat it as a regular
audio unit regardless.

MacOs does support module, so this is fine.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/audio/meson.build b/audio/meson.build
index b2dca2c6409..23fb66d571f 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -8,12 +8,11 @@ system_ss.add(files(
 # deprecated since v10.2, to be removed
 system_ss.add(files('audio-hmp-cmds.c', 'wavcapture.c'))
 
-system_ss.add(when: coreaudio, if_true: files('coreaudio.m'))
-system_ss.add(when: dsound, if_true: files('dsoundaudio.c', 'audio_win_int.c'))
-
 audio_modules = {}
 foreach m : [
   ['alsa', alsa, files('alsaaudio.c')],
+  ['coreaudio', coreaudio, files('coreaudio.m')],
+  ['dsound', dsound, files('dsoundaudio.c', 'audio_win_int.c')],
   ['oss', oss, files('ossaudio.c')],
   ['pa', pulse, files('paaudio.c')],
   ['sdl', sdl, files('sdlaudio.c')],
-- 
2.53.0


