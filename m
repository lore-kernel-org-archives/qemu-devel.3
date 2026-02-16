Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76575E7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwbr-00062k-TM; Mon, 16 Feb 2026 06:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaS-00054I-Hw
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaI-0007M4-U6
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58QRcSder0RaqQBxAedoRAnN13Ui3FUWfO2I/pFVn1M=;
 b=hV95g5WKHVWcijr8UCHO7CME0AKDJnz+CZB4Uj/xvYauBiXdmrAUaw4VPV36h3e5Xd2DBG
 mEKJzLUwlxd0CJEm9iy5Yb9hrDBLoBRutab1YhlJZdwUC72o7MkrxniZ4pYgzheX8rxwpN
 EQgarafzQvbjqWIOaJP0b32tJcPtaBY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-z6KJDR3nMCudWPFGktoPzA-1; Mon,
 16 Feb 2026 06:16:04 -0500
X-MC-Unique: z6KJDR3nMCudWPFGktoPzA-1
X-Mimecast-MFC-AGG-ID: z6KJDR3nMCudWPFGktoPzA_1771240562
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D5FA1800349; Mon, 16 Feb 2026 11:16:02 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D49B930001B9; Mon, 16 Feb 2026 11:16:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:14:58 +0100
Subject: [PATCH 09/85] build-sys: create a libaudio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-9-e676662e4514@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Hk7/EXh9zm0G5EktVx4Fxa+ZyOM5/pIT6vTnyxaK2F8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxO6qngCi7boRhVlrkB6kH1FyUurZHfm9x8j
 KRTcrGJN1+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5flQD/wNpuizM5bLhXysInhyfoF+cqOdpy9PueN8IwskFnP4s1GcSpYxqJfQ5nQQl+8UJtEgg33
 jAERBlDyLAd8HJ9tqUKGDAIvdxBp72dhI6BIeEBHn/ZnDS2tzit79MnRpJaYmVxS67QpasHk+8v
 ez3Rz82svmoIdqGrcqQAPAhL2robuu23n3jF2FKk/+3Gtm02N/ASPMl2OOIcKA7cwItAnhPR8tj
 HWE9tOIxo1ytzTU8FbAWkYP0CIjKaXZgrxUsayYHRAYQgXdwgWbiAkwOxUNv7UWLrrTjs6jqqjZ
 2jg5pydR7zbB6z6yoFmsCxIQ7qwQKTZT2E9IbJYRJSgtp+r6W5p9IBeVJVK/Zj4y1KFZ8qdvx73
 u4QmnVnSwLunkINZzVc/yIwLwgsmHNEudc84eLOI70b4wdZ3o8UJxVui+YQsNBfRlhk5D4G6jgp
 +VlZsviVNtmLuj28zpUDNm/9LFbECuJv9BHoIFGw9ARWpqddvPiYtsXearaIzw9nrAvudNI+qMo
 t21LQwfHDw5No63rMpJVDUbAO793acxRsKJO431kPWibHmmVNyK+/YxjcJyvxoALBOvBe4YLzDI
 cSFxy+OY+xMp7DRFM9KNyL8CgVfqVCmy+ljf4DRW5QmndoWeTqiR3CzxgPrm8TUJ3j6VU1TlyTN
 ciIkcsznw2BlPNw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

This can help create tests, for example.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 meson.build       | 10 +++++++++-
 audio/meson.build |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 4af32c3e1f2..904605b844f 100644
--- a/meson.build
+++ b/meson.build
@@ -4070,11 +4070,19 @@ libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
 hwcore = declare_dependency(objects: libhwcore.extract_all_objects(recursive: false))
 common_ss.add(hwcore)
 
+audio_ss = audio_ss.apply({})
+libaudio = static_library('qemuaudio', audio_ss.sources() + genh,
+                          dependencies: [audio_ss.dependencies()],
+                          build_by_default: false)
+
+audio = declare_dependency(objects: libaudio.extract_all_objects(recursive: false),
+                           dependencies: [audio_ss.dependencies(), qom])
+
 ###########
 # Targets #
 ###########
 
-system_ss.add(authz, blockdev, chardev, crypto, io, qmp)
+system_ss.add(authz, blockdev, chardev, crypto, io, qmp, audio)
 common_ss.add(qom, qemuutil)
 
 libuser = static_library('user',
diff --git a/audio/meson.build b/audio/meson.build
index 23fb66d571f..a5fec14fb3a 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -1,4 +1,5 @@
-system_ss.add(files(
+audio_ss = ss.source_set()
+audio_ss.add(files(
   'audio.c',
   'mixeng.c',
   'noaudio.c',

-- 
2.53.0


