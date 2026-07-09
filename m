Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA21C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whuJh-0007yH-3W; Thu, 09 Jul 2026 15:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1whuJe-0007xf-WC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:21:47 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1whuJd-0000Je-2j
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:21:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 683C0600C3;
 Thu,  9 Jul 2026 19:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DC70C2BCB7;
 Thu,  9 Jul 2026 19:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783624903;
 bh=7fLZ2sAA938WMFeMYQpLEfSXXsyNIVRkUXhS+kpqv2U=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=IgC096sss8GGQuOzJecAtAOangAPIsU0tjVx2tCro+u6MduHyzOWO12F47BkJz0hq
 +X1JvmJJK8GPXXkMui6Btf5biVJ7vm0BIRj6Ef9DXeAIwALCO2IpXGbsACifn6ZGKl
 5QNGQY9dWQemYMaJFIopWw9OwWxBJv5IgGXxy4O7rTg0DNXJkoNkEAxuYo+rpomyl1
 wDyb+MI8YLm3jhAd8GAxyS2XRpAi1tAqVLJQb98TMDIRpnjQ0SjjVmdAo39HE2p2Ta
 T0bWh2hpKS9+9Uf3t7eilO7f9KaalNUtDTxYYQS2QHGO/FWn4H02RE0sNFyuGSbLHU
 +rzcBidrlOuSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC1CC43458;
 Thu,  9 Jul 2026 19:21:43 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] pvscsi: fix endianness issues
Date: Fri, 10 Jul 2026 03:21:38 +0800
Message-Id: <20260710-pvscsi-endianness-v3-0-27fe1c4d1f6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAML0T2oC/33NTQ6CMBCG4auQrq1py19h5T2MC9oOMIkU0jGNh
 nB3CxtdGJfvl8wzKyMICMTabGUBIhLOPkV+ypgdOz8AR5eaKaEqUYmSL5EsIQfvsPMeiLgVLte
 N06ougKW7JUCPz8O83lKPSI85vI4XUe7rPy1KLrkRpi9qZURfNpdh6vB+tvPEdi2qj1BL8UtQS
 bClVFBZrYvGfAvbtr0BUvBDjfQAAAA=
X-Change-ID: 20260605-pvscsi-endianness-c0d389d8274e
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Arvind Kumar <arvindkumar@vmware.com>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=7fLZ2sAA938WMFeMYQpLEfSXXsyNIVRkUXhS+kpqv2U=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqT/TEEgj3Z12khUW0lb7ZUjX2PxpIDuRNR605H
 WRSFhenxEuJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCak/0xAAKCRCwMePKe/7Z
 bjySD/0QgQazFzhDj+b308/RfW7n/inCHQYPzKSfTT+iGdqtk4T9+cfQ1gUzBWGo+ZmbS8vThuN
 e8Tl+fztqDq/cXg4Tct8fpUOsx+eLWAGxQUy04UimOObx7efc8+HqE41vTQHey0qSi4LaINy03y
 s3bjf0h1pS/iFyeQTJkNfUi6ZDuxmpaEjGXelsnJxyvhXDjdU92PVaY507AAv59Tr+Fx6Ru/IZB
 qI7MJeolnzs7oBTyQCWdFYaZ7sf0kzdAL7qp2A30uWt2ftsObQG8MuSGSaY2DuB4XG9ilPmPlQr
 U8VGLBT14DlJX8IIRMU/Fpx87XpFO3f4fw1yKisg86XpZNZbiVNCXDL76Xnz2aD0xA169Z252SU
 yBhJdGmOAOF51fYwI8vdhTYqroE6zSL4FOBT064icyCEOToFiC+xpNNlC1yv9UCgPbcosoP/XNH
 EpN7SvWciQWby3uxBULQLP5GkK4sTCAxld95dO6sIo1d6YT8mg4tbo1a6V12X9jeQUzl4T20kuq
 FQ+mrx0VEZrDa2Qs218NY1jpfdZD1DiFUIs8/AvlJ7Z3kqPt/Fo3tA4wWhACOqWGuk7CZOmsA4o
 wRAhF4+XkUx31Ngw+Ik3Bxuq8iQN6bK9B9HoL0wf6cWDFp4a8H7d+LQQGRAd4IwAXktI01is++P
 JU3ZDGzcm6eNGgQ==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
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
Reply-To: shankerwangmiao@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch series fixes the endianness issues in the pvscsi device
emulation and clarfies the endianness of pvscsi data structures.

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
Changes in v3:
- Remove the unnecessary struct keyword for the structs that have
  been already typedef-ed.
- Add a comment in vmw_pvscsi.h to explain the endianness of pvscsi
  data structures.
- Link to v2: https://lore.kernel.org/qemu-devel/20260710-pvscsi-endianness-v2-1-c512e6c8849b@gmail.com

Changes in v2:
- Assume pvscsi is little-endian instead of native-endian, and thus
  replace tswap*() with le*_to_cpu() and cpu_to_le*() to convert the
  endianness of pvscsi data structures to/from CPU endianness.
- Link to v1: https://lore.kernel.org/qemu-devel/20260605-pvscsi-endianness-v1-1-b0bf472b0f59@gmail.com

---
Miao Wang (2):
      pvscsi: translate data endianness
      pvscsi: add a comment to explain the endianness

 hw/scsi/vmw_pvscsi.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/scsi/vmw_pvscsi.h | 14 +++++++++++++
 2 files changed, 70 insertions(+), 1 deletion(-)
---
base-commit: 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc
change-id: 20260605-pvscsi-endianness-c0d389d8274e

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>



