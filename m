Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6AAC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylbv-0005IE-Su; Tue, 25 Aug 2026 03:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wylbt-0005GA-3n
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:30:17 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wylbq-00026n-GI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:30:16 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67P7TsR3057787
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 25 Aug 2026 16:30:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7ehll0uII3PoQur0H3XcbfTzgWtKaWzL62DmJK/KTzE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1787643003; v=1;
 b=pa9kpVtT+JUzBTT0nRivp1NvlPjhL8LnaemgRy73Vpwy35fXz0BYDvSCYaxDnm21
 P7TcbpyqSoDO5cQrwdNd5t/O+8xt27I7KTJcWl9RuCZE+RmAnjZd6sPyxBXJl3VE
 wZS29f4CFIw73Cgw7NP+n18Jjoh4Mc51vQ98itxk53ERUz8Uwt/5klvmciHNLc6m
 p5NarpYA2J1Lg1Hl52TbOLW76Unl8jgI7fK6L3iN9gd/uwHXIJAgwgqHN5Im+Hgb
 EbVXtPxP5+e8DAQ0n6DCpHU3NwF+IVfHGpKqB1Tl+cpayYyP4MIbQgwtFhlcVA2c
 yprLu6C0SsRR76KsbxrdoQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 0/5] virtio-gpu: Fix resource backing and host mapping
 handling
Date: Tue, 25 Aug 2026 16:28:46 +0900
Message-Id: <20260825-dmabuf-v2-0-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNywqDMBQFf0XuuglJTK266n8UF3mp11IjiUpF/
 PeqxeXAnDkrRBfQRSiTFYKbMaLvdxC3BEyr+sYRtDuDYCJjOcuI/Sg91SQv5N0UWgrGJOzyEFy
 N3zP0qv4cJ905Mx7rw2gxjj4s59PMD++KPq7ozAkjVkjN05Rbk6tniA01SJFOZPTvxVNlaDdAt
 W3bD9LWjE+7AAAA
X-Change-ID: 20260806-dmabuf-8945c9b42004
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2120;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=Fr+mRZJKsHTJnTSKYYp6B031A1CwLZlehcHDEH99k8M=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1avS+kDq8vJtvd696+Pl1yjUBeVwivs/O10stHh7DCuS
 wrCOc86SlkYxLgYZMUUWVKKdnNrRNd+KkyIb4GZw8oEMoSBi1MAJhLqxsgwcU281pXIt6ox9y/d
 t3gbv3bFauk/VjP70zf/m85zUuSVLSPDlymvOhv0HQxP+4uf5du+atelGVyRLKt7Co7qnyuf41P
 FAAA=
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

Virtio-gpu resources have independent guest backing and host
representations. Blob resources may be created without guest backing or
with zero size, but the current udmabuf path still attempts an empty
ioctl or mmap operation. Mapping failures can also leave an incompletely
initialized resource.

The generic resource lookup further conflates these states. Commands
using it have different requirements: a transfer needs a backed 2D
resource, SET_SCANOUT needs a 2D image, SET_SCANOUT_BLOB needs a backed
blob, and DETACH_BACKING only needs the resource to exist. UPDATE_CURSOR
can likewise attempt to copy pixels from an unbacked blob.

Skip empty udmabuf and mmap operations, propagate mapping failures, and
validate cursor and command resources against the state each command
requires. Creation, attachment, and migration now reject incomplete
mappings instead of publishing unusable resources.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- Added patches to validate cursor and per-command resource state.
- Added Reviewed-by tags from Marc-André Lureau.
- Fixed continuation indentation in patch 1.
- Added Fixes tags to all patches.
- Reworded the commit message in patch 2.
- Link to v1: https://lore.kernel.org/qemu-devel/20260807-dmabuf-v1-0-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (5):
      hw/display/virtio-gpu: Avoid creating empty udmabuf
      hw/display/virtio-gpu: Avoid mmap() for empty blob
      hw/display/virtio-gpu: Propagate udmabuf errors
      hw/display/virtio-gpu: Check cursor data presence
      hw/display/virtio-gpu: Validate resource per command

 include/hw/virtio/virtio-gpu.h        |   2 +-
 hw/display/virtio-gpu-udmabuf-stubs.c |   3 +-
 hw/display/virtio-gpu-udmabuf.c       |  10 +-
 hw/display/virtio-gpu.c               | 178 +++++++++++++++++++++-------------
 4 files changed, 117 insertions(+), 76 deletions(-)
---
base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
change-id: 20260806-dmabuf-8945c9b42004

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


