Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBF4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s01Jz-00068e-Te; Thu, 25 Apr 2024 11:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s01Je-0005s2-JB
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:47:19 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s01Jc-0006Ia-Cr
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1714060035;
 bh=qbE6uyalBRo9zLtYMhk2ZUOpAlXnd9MsceRpgqKOlwc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kwNILZWHlbgm/D4M135N3WgYD1EZoBo29HNFSvy1M1fQPfpPnbdJmhCozpIpAZZ8r
 VKTf8DbXK29L8Wm07Z8jtjAi7kuTFh4RPfZF1xXuea31GkjSD1NE1AioUghok3pruV
 J9HC4Fm9lzoIjz3ZbpSfKPz1QGhyb98t5qR8LxB81cTbW7pJm8wBRidWaQQJAkF63L
 fW2r3u06t7gNl1MkyP3Pg5lwTFude/kO6WVQOz3zCY3yaIMxBbtltPNqLg3PMd0sG5
 eQnbmze/3ajEt4MHkOLa0/TCPw63zs32BVbKBn7SsZoAA7kDMAWQowOopk12JfwJ5G
 j01o17Obd2Kdw==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2BA91378215C;
 Thu, 25 Apr 2024 15:47:13 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: [PATCH v9 11/11] migration/virtio: Add virtio-gpu section
Date: Thu, 25 Apr 2024 18:45:39 +0300
Message-ID: <20240425154539.2680550-12-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425154539.2680550-1-dmitry.osipenko@collabora.com>
References: <20240425154539.2680550-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Document virtio-gpu migration specifics.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 docs/devel/migration/virtio.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/devel/migration/virtio.rst b/docs/devel/migration/virtio.rst
index 611a18b82151..67f5fcfed196 100644
--- a/docs/devel/migration/virtio.rst
+++ b/docs/devel/migration/virtio.rst
@@ -113,3 +113,10 @@ virtio_load() returned (like e.g. code depending on features).
 Any extension of the state being migrated should be done in subsections
 added to the core for compatibility reasons. If transport or device specific
 state is added, core needs to invoke a callback from the new subsection.
+
+VirtIO-GPU migration
+====================
+VirtIO-GPU doesn't adhere to a common virtio migration scheme. It doesn't
+support save/loading of virtio device state, instead it uses generic device
+migration management on top of the virtio core to save/load GPU state.
+Migration of virgl and rutabaga states not supported.
-- 
2.44.0


