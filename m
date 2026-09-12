Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5327EC88E56
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 05:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5GLL-0004Kd-0T; Sat, 12 Sep 2026 01:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5GLI-0004JS-Cb
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:32:00 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5GLE-0003Sg-Dm
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:32:00 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68C5VLEu094585
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 12 Sep 2026 14:31:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zYHDmuPtsXarMfBqnCm9NmrWlcO/mbQnGld8+vdOrTU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789191086; v=1;
 b=T19AsEKd2XH2Nm8/UyMuMU7zlV8cqQwDmKCi34LWzaUsMHxrB2fnX2PQx9B9P6i5
 HDFTON/LXvSMLTYf7VEF8WUQUWlmoW/+m87CUIi7aHyMr8mgmIJ2+RaSs3m/H3a4
 zrKs8AJoG6WoV37qLfPBjGiQu5/ys9hrgOY1/cdMkRNgQANhH/NyOi/UlVgoDoYs
 38Qz4VHH1bzpdY5h7BRSRYCjRZ1545+ZFMNxjJESr+H48lo3H4JFQcjKcRhXyY/B
 TMyEhAL7I3xDeT/LBU5Y4SOIhvC88KmSrfEyCGBphpt5fTZefBj/fTPpYR1u5bm6
 g3K0+KAAKAVh5w3qvJBiQQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/2] migration: Extend blockers to CPR and Xen device-state
 saves
Date: Sat, 12 Sep 2026 14:31:13 +0900
Message-Id: <20260912-xen-v1-0-ebd6a2aa519f@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2ND3YrUPN2kNPMUA2OTxKRkS0sloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0AwMgJ02cAAAA=
X-Change-ID: 20260731-xen-bf7d034abc99
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=0qk9/rLXIj04EQb5BjVtGBNE113pTxGBSB7uGDOdjx0=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9aSx8vy0zq0N92d5Pz4WL+G3qS2T78PTVT3uq7Ypd5uU
 d1qZRrVUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMJHYGEaGqdYBHNH+k47eO/rn
 /+cnl6SOWLE/NX4RZv8i5dfD1NwTGQz//c2DHxwoMmR6KLzOyPjVwfUq/H5Xlx3+at14bnnouzJ
 2XgA=
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

Migration blockers do not currently cover every device-state save
path. The TPM CRB blocker only covers normal migration even though CPR
cannot preserve unsupported chunk state. xen-save-devices-state also
operates outside the MigMode machinery and ignores blockers entirely.

Make the TPM CRB blocker apply to every migration class and add a
Xen-specific class that xen-save-devices-state checks. Keep
vhost-scsi's same-host CPR exemption while extending its default blocker
to Xen device-state saves.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (2):
      hw/tpm: Block CPR with unsupported CRB chunk migration
      migration: Implement Xen migration blocker

 include/migration/blocker.h | 10 ++++++-
 include/qemu/accel.h        |  2 +-
 migration/migration.h       |  2 ++
 accel/accel-system.c        | 25 +++++++++++++-----
 hw/scsi/vhost-scsi.c        |  5 +++-
 hw/tpm/tpm_crb.c            |  2 +-
 migration/migration.c       | 63 ++++++++++++++++++++++++++++++++++++++-------
 migration/savevm.c          |  4 +++
 system/vl.c                 |  9 ++++---
 9 files changed, 100 insertions(+), 22 deletions(-)
---
base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
change-id: 20260731-xen-bf7d034abc99

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


