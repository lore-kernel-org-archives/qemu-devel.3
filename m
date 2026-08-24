Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB10C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyawG-0000GZ-L7; Mon, 24 Aug 2026 16:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawF-0000G2-DI
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:35 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawD-0004Y6-ED
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:34 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c2074710751so719115466b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787601991; x=1788206791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2IF4AhQdIxhmiPhNCA+Ag/JbiutgCbP7ow1QdY3dmbw=;
 b=rBpGUM1oFY0xThmtJ5xNefSH12eBET229u0cqbtJ8GNM/4vbvlkBuMz11A/+6RAjNg
 uztikSoghz1xKMRF8BpsXzW3JaWzVu/13SM3S/7Iw7Xelb1xA1BnRzvf6+tdgZyaDSr6
 SnRPLYeCuUd4IgM2AZgdOTbz+obOglRZMeqOWMogiibdWBKo5BB2LbBPgwrTDdyrRHMX
 4devGSf3KquetlIUnNSviLJCjmasYUrvAWRVX9MljE3scwg/6iXUFotPoZ8uZ8zN0KiJ
 JccaDMNVK5DCYvxVrnu7At4CdVyP1Qwu9z3XS1nBYT10GjwEN+B6bgzuiOYOYBYeVT7c
 YqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601991; x=1788206791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2IF4AhQdIxhmiPhNCA+Ag/JbiutgCbP7ow1QdY3dmbw=;
 b=eY0g7nWPZzN99DrZ7sLoG3nidmWOaRgDxyyatKNP5lf78J6tUOxozyENJTn9DU7uUp
 UfOu4CT26mAXKgBPIvQXquvRdBvWkYgM2/JEZHZoEl2BCP8/44haNgv+q8OUodL/z1df
 PUvBNlquTNbDFu1xci7/mVdwu+NqPVJgEhwDlQQiwRYhtf/iXAOa/izwBOWWNXDvpEqs
 U6iWpP1S41Rj//8fR2uAG7saPRvaqN2kesiiRdmQkh9f3cFoKhSJMkvNXUZr/YgdFONB
 pHBwwl/ncc+RRevtr2JbzP0fyowmwJPwYAuUKySfIZ5LM3IHB/iEKZF2oje9wpAvSRZt
 Ou6g==
X-Gm-Message-State: AFuF++lTNturQKwOfa0hMJVwKiffiSq6pCO6m7JdUpTMGZPnsoye7/VU
 PveiO1YeUHzqZGbN88dBg7jJxyTLQ1RwWV934tIBIbJB3DQ/EhXojflefPikOwSZnoSYPWBKGyK
 g7LPn
X-Gm-Gg: AR+sD10IKXXdDHjiCEL19HkMxfQxjGPuD4C7/TMW/3/i/pYz5uvUhS3D6PEvBPty3bG
 Sy0PNu5Bp8CpuEyRDOvBysIeF6+BW9i4ViXRMQkOVjrqgCrTcWs6PKcJARzJ890qe2Xp3CLd3q5
 Bd2eja4UYB7o8tbbZzPOIUX3M3UxCxDxxXYnBNV3hjhRw1EImyhY5CAO13HVJNPZZaPtBl+4+/9
 pf/C7y+oYSzWQqDx3WFGpvXX0Zg2fEJwrS2RadW0r+rzafqZF8XhYP7xA4mlsLHSDzSBBpJFCp0
 DghuJHH/xfJ/15VgdnMjuyCvpcWobCoGf23P75sfGYbwMbkuP8Y5WMAYdUlE6y80pucW0lV1qn7
 VQCuEUflQhf85xo7Hcbmbo63SJVefhJs0vxCacMPF3o9fVSvY6jjR4ae0Kf3+25cIktln9QjOnG
 SAwdOe1EboNCop5ntnhSne4wyxP2NY9gF0+yOZ1yfI8qkMbLdlN6g/nG1tzjvkvnd17TPV
X-Received: by 2002:a17:907:1c27:b0:c21:382e:9a38 with SMTP id
 a640c23a62f3a-c2491c2a110mr2264004166b.2.1787601991480; 
 Mon, 24 Aug 2026 13:06:31 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e0228f1sm6152245a12.10.2026.08.24.13.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 13:06:30 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/7] tests/qtest: fix the disk tests on a host with a small
 /tmp
Date: Mon, 24 Aug 2026 22:06:20 +0200
Message-ID: <20260824200627.2180635-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=den@openvz.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

John reported ide-test dying at startup in the NetBSD VM:

  ERROR:../src/tests/qtest/ide-test.c:1260:main: assertion failed:
  (ret == 0)

The hypothesys is that the ftruncate() of a 64 MiB scratch image. NetBSD
mounts /tmp as a tmpfs sized at 25% of RAM and charges a file its full
length themoment it is extended, so a sparse image is not free there and
the call returns ENOSPC. The assert dates to 2013, nothing regressed.

The series is designed to do two things:
* reduce the amount of space needed switching to QCOW2
* tolerate the failure skipping the test if there is not enough space

Patches 1-4 skip instead of aborting, the way hd-geo-test has since
a0d6d7454a. Patches 5-7 build the images with qemu-img where only the
virtual size matters: peak scratch space goes from 129 MiB to 1.6 MiB
for ide-test and from 4126 MiB to 1.5 MiB for hd-geo-test.

Hope this should help. John, can you give a try to this in the test?
I do not have NetBSD handy and will start with this tomorrow if you
will share guest config.

Cc: John Snow <jsnow@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>

Denis V. Lunev (7):
  tests/qtest/libqos: let mkqcow2() report failure
  tests/qtest/ide-test: skip when the scratch files cannot be created
  tests/qtest/ahci-test: skip when the scratch files cannot be created
  tests/qtest/hd-geo-test: skip when the scratch file cannot be created
  tests/qtest/libqtest: create images with a byte-precise size
  tests/qtest/ide-test: build the shared disks with qemu-img
  tests/qtest/hd-geo-test: build the test images with qemu-img

 tests/qtest/ahci-test.c        |  48 ++++++++---
 tests/qtest/hd-geo-test.c      | 145 ++++++++++++++++++++++-----------
 tests/qtest/ide-test.c         |  96 +++++++++++++++++-----
 tests/qtest/libqos/libqos.c    |   4 +-
 tests/qtest/libqos/libqos.h    |   2 +-
 tests/qtest/libqtest.c         |   9 +-
 tests/qtest/libqtest.h         |  12 +++
 tests/qtest/virtio-scsi-test.c |   5 +-
 8 files changed, 237 insertions(+), 84 deletions(-)

-- 
2.53.0


