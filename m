Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A7FD72347
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjBwJ-0002rd-28; Fri, 23 Jan 2026 02:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBwH-0002rP-Qd
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBwG-00027r-BU
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1uXf7o8itEYYPgg9KG9SP2/y20FPGHTrzAVVFKORGU=;
 b=JXefmCjNJFDnIjQkT5SZf31WAtNP+d3VYHdHBtLYNoDT42Ynoh5Yy92Ye/hUmO/JH+x547
 o6UIaPatdq0C740DBJ1VQ/FFV3AMkYAMKXYja0s0606pm6XN8/Za5qYHlQOZzaUeBkycjy
 yuSSpJ95nHeYs5T5X4pewmyW+yFXdOo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-Hgftu5SZMgiE3vqMXGh-Hg-1; Fri,
 23 Jan 2026 02:50:34 -0500
X-MC-Unique: Hgftu5SZMgiE3vqMXGh-Hg-1
X-Mimecast-MFC-AGG-ID: Hgftu5SZMgiE3vqMXGh-Hg_1769154634
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 122051944F2F; Fri, 23 Jan 2026 07:50:34 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DD77180049F; Fri, 23 Jan 2026 07:50:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 07/37] audio: list backends as modules
Date: Fri, 23 Jan 2026 11:49:10 +0400
Message-ID: <20260123074945.2563196-8-marcandre.lureau@redhat.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Windows doesn't support modules, atm, but we can treat it as a regular
audio unit regardless.

MacOs does support module, so this is fine.

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
2.52.0


