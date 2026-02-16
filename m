Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C8DE7BD8B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrw4W-0001yD-32; Mon, 16 Feb 2026 05:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw4N-0001u3-N5
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:43:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw4J-000127-Pj
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771238586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Zx9tUgPYauS3ey3x8MRhHhI+AI2QGIcLzfbiUv0MoU=;
 b=CXkeknYi0j2vNpYgc4Tzd89yfIZZphcjMZyDtBFAys6/1xrv81YlWttKmen1g5Di12jqg5
 PEDr/XwDDm6IMoG6XtHT2DOygyO5d7qRvH0Djk5E1iPKcQ/BAOI0JwDajTReSywTMMVEeG
 ZDrHExh8DaQyEpJVDmgSEf/FYeT8F34=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-hLxrww1dPpCDhixFsHlgnQ-1; Mon,
 16 Feb 2026 05:43:02 -0500
X-MC-Unique: hLxrww1dPpCDhixFsHlgnQ-1
X-Mimecast-MFC-AGG-ID: hLxrww1dPpCDhixFsHlgnQ_1771238580
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9E0D1955BD0; Mon, 16 Feb 2026 10:43:00 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB9F91955D85; Mon, 16 Feb 2026 10:42:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 11:42:20 +0100
Subject: [PATCH 08/85] audio: list backends as modules
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-8-edcb25699381@redhat.com>
References: <20260216-audio-v1-0-edcb25699381@redhat.com>
In-Reply-To: <20260216-audio-v1-0-edcb25699381@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8RNCjDZJyS99FQfKQHwCUPWQBTeZ+z6QEmMkBqjgbCg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvST8Ua8TkQ/9OVYDkjiUn3SI6u3SfF+ww04l
 a6IMH3q+oeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL0kwAKCRDa6OEJdZac
 5fB3EACBIfhi7WcuEFSEabF03hPjxT9hzCFMXGnvtXoNles2IBMV6mCKXtD1famasrUGiK3+ioG
 Olnhr4IlAgW/hxrGM9rT5M8thSurtE0lsMThp2Ub9cw+nrXI+L4ehyvTXpQxfvbCnUqVHh0XsJ9
 8aYLLuyGX/1FlbksJn2iNlA5Kbxlv27Ji3PG4DTrIdsByPdLEykmYSUWhb6QkD7BBOBynvKjR9L
 RXkcRmzsb1By/D7Fy7gOTgQTErQC48xf9IBpztVYf4n5TSxEiz75M6557/3mu27ob6VhfuKcKdK
 czpW/1oXFRj9eCCSfhTw8gaouFI3hiHT28WjCMgsHPSCeSPF2o1mHF7xBoDrxzt2EBsVzG/fJrm
 6+ziH2HWik8ImPmlWCuIXJbYOxyGt3pJxvliHJKkwV7IdCv8GlOpIxWDeiCbRIq6kIf89pykTCf
 0+sogYaqY7B7KCoCWYoq+K9AKlFfJlyHfzkANC3ptDrqG/+OfkX+PwxoTkdTdohxYxU7crCVEvb
 QinKp6mDTYd66iW9HHN++oCmFVd8IgGo+cZwQaDWVzbhSqkdi3Yc2e604X7Gek9ZT5DobQWTsxs
 b0Pbdmd0OG0wWVa1f7McB4mTihYvMXzv9PHD5CTnqL3PdG64CAd5OXInPVoOlQtVkgw3hD8YuYG
 i/DfB3bOjs/0blw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Windows doesn't support modules, atm, but we can treat it as a regular
audio unit regardless.

MacOs does support module, so this is fine.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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


