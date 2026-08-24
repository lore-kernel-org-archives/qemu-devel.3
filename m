Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7380CC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWXx-0005a4-Lc; Mon, 24 Aug 2026 11:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWXu-0005Os-PQ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:10 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWXr-0007BJ-Ui
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:10 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a20319d030so5447646a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585106; x=1788189906; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pbxWYcsvgblTzeogtzkOWcZE1+KyDnULKMrmEfQ7zSc=;
 b=yAwF86AXLc6WIaRlzujC3G7/KpowoSaeOAhBn5d6BgVbNOyGtez3aXwi3Nm7TC+xj4
 tk3LIdAyPZj73Hc08KfUdETicyExiR1BuP1KBib8bqVxA2/ZIHJA2TmvliuaE5xoPJju
 IypioCt8vLVYsvbTQXqbJBafPUiQGB5a63VX0Dh5cwAuQF7xDotBMYbRPNKpcQg2PInh
 6kvufxW3H/4RZs/weZKD7NvprcghJrehsVSBrvRvSYiBAoUx6zEePu2gnvC7CpZlMwLR
 J1hoHUVKS3v4Rm6HpllABWDfpKnITm4A2CsZFVqQqHNRHbj/Z2uIw+5rkTAxtS4tdyM4
 eyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585106; x=1788189906;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pbxWYcsvgblTzeogtzkOWcZE1+KyDnULKMrmEfQ7zSc=;
 b=sEVZ5A8e1BKPpSyf+GHQgsU3MtHzQSUIsp3tCdk6NK1dieUGZMG5/rIobx+vlv9qYP
 PddeyjQHzc8OBxgwOzWOPIQWml9EEh8zIbsuB6vno0u4R1MZRaZSJt3uNIBc1aiUAqJw
 U83CZzWk+mcMmAeK19w/2yTDLY31AYI7NIXGj0dH4sqc4/NM4NkTvmyZx1LXdEQvGwvj
 xG6nmZMLzI5aE2tf40Y+e1iFWtWOdpdGiZ81gC+TJVtVqJ+dc3X+kAP53+QKZhOkgwkz
 ZDtrUZT2FVLgDlXpzTYe3s0HO12idKlNggplz9rn9zYEVorXblTKI4lwkqXJnDg62qAy
 +T4Q==
X-Gm-Message-State: AFuF++mDHoPB7zmsuW6GWJAyGfOWqFPpYpaQHwfEzdcAVUU+/7pPjc+4
 nbIWe6qPDwj0vRKm2g8oWTARCnW9wAzTqT5JyfXQ753oJBmjIVZMHf1oVANUSVT1mRs=
X-Gm-Gg: AR+sD10roFzPDB/bcGC0pYxAZVGMpvH81rUiZ4coIfaOMyUIDpboGupy0/3G+M4941S
 rYC6c5TI0Hh5BhMWmkwYArXq2iLpTL5KJ/yT6G95D6izmDnwoC67foRyZ4jbIVM84rtRZcfV2ZO
 EDTwaIFZkSPUGbCjrHBmW6sbbVkfIjB9OihcXvB5i5Ja+nC9kJmsl2qtpal/LjFgKaVPEVw/1fy
 bnM6P460VkPcQ9vAPS69ry1h9hGIEqnIrh+MwLU9SYNKA2e2qD0xhNwzAGJzhv0A5qoLfi00Q1r
 0QZ6z0Z73UrwKD1RNZjftrhNPvplJvpKrAkBnFFUR+ZPra+i3za9chy5AVXzkCqsiCmsEpyQOl3
 WCrX2Z6Bs8rKf+Qd27xLTOPn+BVjN9LnU5Z2DmoxVdUFO8J+7kVM47izRaoKOj9YAoOke2Jw6Ce
 qoxKKe4QqYgOqaPcq+gx3msZfaJGij1qnaIC5GlrrMi/tJPQPXL7wz1oR7xDGj
X-Received: by 2002:a05:6402:24c8:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a42f172088mr22922012a12.5.1787585106021; 
 Mon, 24 Aug 2026 08:25:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e00108asm13698150a12.2.2026.08.24.08.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:25:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 58B825F7F5;
 Mon, 24 Aug 2026 16:25:02 +0100 (BST)
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 0/8] various fixes for 11.2 (gitlab, tests, char-fe,
 fdc, mailmap, deprecations) pre-PR
Date: Mon, 24 Aug 2026 16:24:47 +0100
Message-Id: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD9ijGoC/3WNQQ6CQAxFr2K6toZWIoMr72FYwFigxjCmg0RDu
 LsDrl2+5P33Z4hiKhHOuxlMJo0ahgS834Hv66ET1Fti4IxPmaMSW31LxDYYEiFjW7oizxvHnhj
 S6GmyGWlzrX4cX81d/LhWVqPXOAb7bI8Trd7f+ESYYVOUjjx7fyzo8tChtnAI1kG1LMsX8ASzo
 r8AAAA=
X-Change-ID: 20260819-fixes-for-11-2-f98744b82c12
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, Thomas Huth <thuth@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473;
 i=alex.bennee@linaro.org; h=from:subject:message-id;
 bh=YWLx7CtssMhsgQfoBOs1HU5QvB7IKjJN8urBi8lcFgU=;
 b=owEBbQGS/pANAwAKAfvQ2wlanipEAcsmYgBqjGJN155EE9Znh3CcEgY4XqBLyysi5roj8BRzP
 W4t5zzEniaJATMEAAEKAB0WIQRmha6Z51FnvK/I3zX70NsJWp4qRAUCaoxiTQAKCRD70NsJWp4q
 RDg1B/9hNd03Ktdb1k4mBY64l4ztjT7VTtP5N63LiKhy9CkOKJzKKrnYg4dv8EU3zlk+dt6P0Gn
 BbgiZUk4cZz6Y5+AiC8tk5hTm8HTTlhrntDUXIgUCVqvhyHBh92wfLBRGh6IDJji0bHBYIhS0z6
 EtBhBa8kOqeh2cNeYW6ecR0pfV1RXdZCV7a87iFtkIllDcGRoDAPqG6hMS0YoF/E45oBGghS3Em
 rvUWRYi0PiH6f7tsSKKQinatk0qzCvU/+m3vV0Fh5gjCYwdUO7YKNELwoBvpSTZX+GfijLibRN2
 eVQ0/9Y0qG3VUntXi8WFJlXZQzcedFeUeojOA6/PnFgQbSeJ
X-Developer-Key: i=alex.bennee@linaro.org; a=openpgp;
 fpr=6685AE99E75167BCAFC8DF35FBD0DB095A9E2A44
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a rather random selection of fixes that didn't quite make it
to 11.1 although we have some qemu-stable material in here.

The CFLAGS tweak allow another target to be built and tested on MacOS.
There are also riscv64 compilers which could be enabled via brew but I
don't have time to look at those. The CFLAGS changes are also subsumed
into Pierrick's check-tcg meson updates which might hit first.

The char-fe clean-up removes a code smell of device models reaching
into qemu_chr_fe_get_driver which is poor practice.

The fdc fix resolves one of the many security reports for those that
still care about floppy controllers in VMs.

In my brief excursion into our confidential bugs I did look at fixing
virtio-crypto but found it needs some serious love. Therefor I'm
taking the other option of deprecating the module.

Finally I'm experimenting with using b4's patch series handling so
forgive any finger trouble on this series.

I'll roll the PR on Wednesday.

Alex.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
Changes in v2:
- added mailmap patch
- added fcd test case at review request (AI-used-for trailer)
- tweaked virtio-crypto deprecation and commit message
- Link to v1: https://lore.kernel.org/qemu-devel/20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org

To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Amit Shah <amit@kernel.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
Cc: devel@lists.libvirt.org

---
Alex Bennée (7):
      gitlab: use .base_meson_job_template for macOS jobs
      tests/arm: add explicit CFLAGS for system build
      gitlab: add arm-softmmu tests to the macOS build
      char-fe: implement qemu_chr_fe_backend_name
      hw/block: validate the fdc sector position fits within bounds
      tests/qtest: add test case for fdc sector overflow
      docs: deprecate virtio-crypto

Denis V. Lunev (1):
      mailmap: map the last From-munged author back to a real identity

 docs/about/deprecated.rst             |  18 +++
 hw/block/fdc-internal.h               |   1 +
 include/chardev/char-fe.h             |  13 +-
 backends/cryptodev-vhost-user.c       |   8 +-
 backends/rng-egd.c                    |   8 +-
 backends/vhost-user.c                 |   8 +-
 hw/block/fdc.c                        |  30 ++++-
 hw/char/imx_serial.c                  |   4 +-
 tests/qtest/fdc-test.c                | 246 +++++++++++++++++++++++++++++++++-
 .gitlab-ci.d/macos.yml                |   7 +-
 .mailmap                              |   1 +
 tests/tcg/arm/Makefile.softmmu-target |   2 +-
 12 files changed, 307 insertions(+), 39 deletions(-)
---
base-commit: 3375621e78660838b862d411c43f90e905d0b985
change-id: 20260819-fixes-for-11-2-f98744b82c12

Best regards,
--  
Alex Bennée <alex.bennee@linaro.org>


