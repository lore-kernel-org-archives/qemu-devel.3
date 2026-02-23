Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E310E98E10
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSXb-0004bk-Sv; Mon, 23 Feb 2026 04:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSXU-0004ZZ-QH
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSXR-0006ra-7r
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkHOFUAfBqSLk9g2fYou7ziGsCwoD/UvRsdVc+GnD88=;
 b=PxNGTerBFU7qdLhl5bJVAThSoCQtqYRBdkq70BynxK3uDU4AcRzbI0scZB9PxHqUclPKTm
 +O6++RkKZGZBnZaeL6s5zxkzQllfx+6BJcF0wTTyFcIaLTwJmLoVuIodzl/Qa/LstINGrt
 Ni1A+sg2E4zkRqtGsH4QsjqTNQjLRvo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-0uzDuWIMPY2Q9uUHximcWg-1; Mon,
 23 Feb 2026 04:47:22 -0500
X-MC-Unique: 0uzDuWIMPY2Q9uUHximcWg-1
X-Mimecast-MFC-AGG-ID: 0uzDuWIMPY2Q9uUHximcWg_1771840039
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C376F19560A1; Mon, 23 Feb 2026 09:47:18 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F6A81955F22; Mon, 23 Feb 2026 09:47:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 09/85] build-sys: create a libaudio
Date: Mon, 23 Feb 2026 10:45:27 +0100
Message-ID: <20260223094649.2005118-10-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

This can help create tests, for example.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


