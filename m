Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F0CD3942C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ISp-0003Hp-QC; Thu, 02 Apr 2026 09:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1w8Eal-00015I-5H
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:44:03 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1w8Eaj-0005JX-AM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:43:58 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so635015b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775123035; x=1775727835; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BznF7Y8ZxRfPEVNL2SUZucrOIty1wnYGc5QgdmiOyC8=;
 b=cXpSCX6AJjFCuIp/rIzJU2I5US3IuITrMtWUVTMJN7OriDC/mcsdWTZjc9e8dIBcrJ
 Q8Va16RoxrLd5pHAKtznNbBHAfDcksa4SB7E8UtKEs7E0JYL+vAFNS29GxLqEriN928d
 +F+8L0uLI3/9zkOphwjfW0e1Zm/md5M9WIlWe5yDOqzF5/ywWTtNdfp7jlWbnI0faKyU
 xUgL1OT4jcovjGnM7ucE12hvyWvnSxeN5st2CGjYNYXC8J8J0pBMUumQ9pam1OsmLE4U
 uYUDjKrTM4O3rV0tWrh5ANljbovUp7X4PiADdRrDrZ324QiEdLWAqiDzVo8i9FWhQKo/
 ETZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775123035; x=1775727835;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BznF7Y8ZxRfPEVNL2SUZucrOIty1wnYGc5QgdmiOyC8=;
 b=OIchN9ALdULPghKs9fhdtJW0d2EVOEl9IojOPl4y3DOe7PuGCLQ7fD9riBE9+CvjJU
 YOvAK9UPjPlCwjO8dedcpLxImF9i64B9v8bgSvh6b5O0fot/K4N6D67ocP9qEv4k3f+5
 g7Gn79zYcepFGdbNGbDrmEv6m6Rjms4cXBC/JODvM3YX8jecA0dphAGFMcucshSjuAny
 PRhrFAllKQ7Guqezwx3FTvucpJE6PacCSzKdPt+JRlo6xF5MPsMOsfEUxU44NnuFREIV
 pX3DxM45lRPEljM5sl6toZPIv0rEunthMEUfjtT9v3jRIueED1MJv6fkV9KytoLlfoTY
 OkJQ==
X-Gm-Message-State: AOJu0YxosGpWpfhQFtrFoFVWAsAts8tXhR/jSNzVE6Go1WC5QDjDYHvv
 9rwEd1/qCTt0YONtc381Q3KwZlq82J3ytgeVtysvMT4C9b1oWJ/FIONl
X-Gm-Gg: ATEYQzzKU6igOZspInPTzngovnxXB4Yah9y1SKieBP7XvwJhsVi0S06sEcBzVTG2MMs
 Uw7zas7lB0pi1SQllTTp2deR5CT4z26Ca8aIxMQsTsJmwCkblYic6UKyMKz/4dHbHTmHxwJxu9+
 y4STFr/7oH8Mz+EXPHcIBHYWdCcQlmC2/a2LczPrfoNMivCm+n6aRxGbyO83M/d9solm0uYQOpa
 PC/NxqQvEca2HRNljvqMNVRc3FA5FYvxKAnLq7DZI+kWMZykhhkKHoNANMXrMUjeTgn0wADta9J
 L452/D37LHAQnDsm38+RWR9pDIK1vYtV3r1mul/ySXTySrkj6UxVijJComKF5D/iFZjtMc7a/SJ
 Tc5swl8jzQYVOy5bhG6CPeVJe0tIZo81HsZIjitXyK6V1traMJhanZglUmJOxnHfHeIj/hQETU5
 1rGyfstxZwL47MjifOcZZPQsJwn9Cphg==
X-Received: by 2002:a05:6a00:1d86:b0:82a:6d9d:3f85 with SMTP id
 d2e1a72fcca58-82ce8ac8b53mr6888157b3a.48.1775123035319; 
 Thu, 02 Apr 2026 02:43:55 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c6ad8asm2668477b3a.40.2026.04.02.02.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 02:43:54 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Subject: [PATCH 0/5] hw/ufs: Add Write Booster Support on UFS
Date: Thu, 02 Apr 2026 18:43:44 +0900
Message-Id: <20260402-write_booster-v1-0-e4fed1df6c7e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFE6zmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwMj3fKizJLU+KT8/OKS1CJd4yQDU1MD40TzRENjJaCegqLUtMwKsHn
 RsbW1AI2gZuBfAAAA
X-Change-ID: 20260402-write_booster-3b05503a7a13
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775123032; l=1345;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=RGbpjRPyr9rfjTTocUDiAGG1uTzGZpqKjL1LfxFB+vY=;
 b=8vGHx4nIWcZGMu+yU/ridMgqwaeZhr/XvUEpsjLaTJOgdvB7yJmMKzCb9I0cXQBcy7grI35T5
 4l4mJl24XhDBzW/1um2vLB/yv9NdAwVcD6koJTvhKNYcF9BheMRZ8oJ
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=ldc.jml@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 02 Apr 2026 09:51:37 -0400
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

Currently, the QEMU-UFS emulation is implemented based on the JEDEC UFS
4.0 Specification and does not support the operation related to UFS Extended
Features which is defined with latest UFS Specifications.

This series modifies the UFS core implementation to align with the JEDEC
UFS 4.1 Specification[1], and adds a Write Booster UFS Extended Feature
supportability.

Tested: x86-64 KVM, upstream QEMU with Debian GNU/Linux 10

[1]
https://jedec.org/standards-documents/focus/flash/universal-flash-storage-ufs

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
---
Changelog:
v1:
- Rebased to v11.0.0-rc2

---
Jaemyung Lee (5):
      hw/ufs: Apply UFS 4.1 Specification
      hw/ufs: Modify flag handling operation
      hw/ufs: Add idle operation
      hw/ufs: Add UFS Write Booster Support
      tests/qtest: Add UFS Write Booster QTest

 hw/ufs/lu.c            |  85 ++++++++
 hw/ufs/ufs.c           | 576 +++++++++++++++++++++++++++++++++++++++++++++----
 hw/ufs/ufs.h           |  41 ++++
 include/block/ufs.h    | 110 +++++++++-
 tests/qtest/ufs-test.c | 176 +++++++++++++++
 5 files changed, 944 insertions(+), 44 deletions(-)
---
base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82
change-id: 20260402-write_booster-3b05503a7a13

Best regards,
-- 
Jaemyung Lee <jaemyung.lee@samsung.com>


