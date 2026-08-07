Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C8EC5AC9E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD0a-0007nw-TU; Fri, 07 Aug 2026 01:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wsD0Z-0007nY-JF
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:20:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wsD0W-0000PU-Ny
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:20:38 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6775KGON002853
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 7 Aug 2026 14:20:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0e3HKSb8VrWp7X+Ih/wP7B8IUWgYFBh7sWAHdxBnOK8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1786080023; v=1;
 b=S9PzHGdY+Dc5XTyHNKYT68It3A8oZxaKoyrRZtFEeKGywto4DRnv2B8/QVC7vf1r
 FmD/YmFNsCZDk3DKeGjf6zhNPQP90c9NqheBJggN1uymJMvwCu0qKIJ7meU938op
 b8QD2R9G++JsNwzKIt/K0KfdQesgkgzZ1tO8yjERw7X8G0LY7kJBoPoQBjqY3ZB/
 KDp/RAwO8z4Fqr1W5fgSFJ8h1hza5D8+yKKpzjlzBC83dU8shp9H0EVMws2FcI0j
 zP6HY01W2xbHmKJ/uE4USZU0/XvH/4UFeoqBkZeboFmoR7YfEpFJJG+ytQr4AdlG
 8R8uMrY0Q5E6i9XI3kXvoQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/3] virtio-gpu: Handle empty and failed udmabuf mappings
Date: Fri, 07 Aug 2026 14:20:03 +0900
Message-Id: <20260807-dmabuf-v1-0-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwMz3ZTcxKTSNF0LSxPTZMskEyMDAxMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0At0woTmoAAAA=
X-Change-ID: 20260806-dmabuf-8945c9b42004
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=u1wAoiJl7nMsgo6DTg/yfxlx/XqeLpfAVAjiqVVdcgs=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1ZptuCUXQz8G7PNz39hXGQ1KWXLw+OPP8pxxBzov3d+S
 f20OWUaHaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABOZ08jwT83k0u2bLBfmlTy9
 Ns3r48Z9tqsPlR1MUb84bbN6usj83DsM/0x+rU6OFNS6Wbq9f6f1xNruaHvrBc6JkyJ/3jQ6zFK
 /jB0A
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

Virtio blob resources may be created without backing and may also have a
zero size. These valid cases currently reach UDMABUF_CREATE_LIST or
mmap() with empty inputs, producing EINVAL warnings even though no host
mapping is required.

Skip udmabuf setup for deferred backing and avoid mmap() for an empty
blob. Also make udmabuf initialization report construction or mapping
failures. Blob creation and attach-backing commands then reject the
operation and unwind their mappings, while incoming migration fails
before publishing an incomplete resource.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (3):
      hw/display/virtio-gpu: Avoid creating empty udmabuf
      hw/display/virtio-gpu: Avoid mmap() for empty blob
      hw/display/virtio-gpu: Propagate udmabuf errors

 include/hw/virtio/virtio-gpu.h        |   2 +-
 hw/display/virtio-gpu-udmabuf-stubs.c |   3 +-
 hw/display/virtio-gpu-udmabuf.c       |  10 ++--
 hw/display/virtio-gpu.c               | 108 +++++++++++++++++++---------------
 4 files changed, 70 insertions(+), 53 deletions(-)
---
base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
change-id: 20260806-dmabuf-8945c9b42004

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


