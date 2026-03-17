Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756E2FEDA0A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Zgu-0005Oe-LK; Tue, 17 Mar 2026 15:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2Zgt-0005OH-L9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:02:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2Zgs-0005nI-0q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:02:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439c9bdc1eeso6048672f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773774172; x=1774378972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bTvHq5x3X3J/a6AIggEozOSOP9q+sJbqrYJJTTmKIBU=;
 b=R6fSpK9zkyaQ2GbAuTq/Q49P9pyU23+kW/CQjsjAkrsIfO8RpOXJC+bdos4h4uoG+q
 nJNtL8wIqfHhozGMSRxcRIe3sVyMqRBO/YKkgwndX9VKmkK3BVQYoLFwPUxjIkCDuXGN
 k0fuK0Tj6RU4sUTOmX9Qqv/Ufqd7MY9gMB+dliY3r3EHLQ0955lDLuhmHcHpgU/Q2piQ
 30nTBycVt/HCiajMnfhAcUkna5SaHIC8ACDCpZZNbIExU3bAVWq4UFXCHrd4Feyj/W6u
 ab/GOvWxfGncWyQmMFmpYcAMd88J4i1ItMFMOg0v/dFeN5kzjOW6svXcBFtftIwXu1Tf
 3cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774172; x=1774378972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bTvHq5x3X3J/a6AIggEozOSOP9q+sJbqrYJJTTmKIBU=;
 b=joCNKp05ZGijG7FOx/pNSkZw4NTqo2i/3cCKNL+wxIdd/2RQVJpHbfn1+VksdAmef1
 DB39jHIq+5MnV6XMkt6AJbP2ppxd4zWo+b2IPSueZTiIcx4UwBPNuKheEKOzyANZUiKd
 GQqR+6p1X6lRDk7nAKiiDIDg4rdsrv89Yc/Zaqotgm3OdK7/wmZmqvPgJDCHWyKEJdrj
 ac3xpOzIIfukfqYRrzvFtXW5Yd+5EyheEqIJuWvtJ2m03Ig6wtoJ9IEX9ls6cFsn2T87
 UWk3Tjja8Z+L5jKDqT0S+2WzlahG+8rEZFy1v+WcEmXH5RH8xpx2hP1pwSTdGwDEiTPR
 syyw==
X-Gm-Message-State: AOJu0YzkHWrPBNa0KbFgtxzZnThu+LRJ/stsm7vh43AIvaGkx7Jg3wTb
 +0/9ub7xe2XqqAc1UEgNEidpVImvgQRM5Fa88Y2qa7ucR48dSPs741RB4CT5ucLZhs8Y6Pk2VGL
 mjMh/LwQ=
X-Gm-Gg: ATEYQzxy1eMduND6Tx2ayW1cTz2JqlnNiiZ8j1KBXRe55GnIyCEPJ62avYQxKxj+y8+
 3zEdtZ5PIXRJZvOHsyojb9Jt4NRIuncWRqABsxYi2N9P43Vi489nwhDh/7xWONfMNOkwDfaGuSI
 6xoKv4yCMLSIaYBIyMA1T2u7rcv66inXNPVa7y3cOzzJPDmMmqGMYiDBHvuoZ70N6E6X7X6MJxb
 CLB6AYeeDGsYmL+wc3XAhdOYPBeE1X9btTpwzznG9zVPlT5cVfD/sIQ9BWdtGEHl3evnhd9Hkaw
 PVqtWe0C0sq21Ly2JTigWCryJod0tmZBjIOdum6ae9CQN81BWEQvZsoqtnV5JAiRyCJbFeUH00s
 99TAAgHA2uvyDMUfA+y9d2tCQvnz9rGJd5qU1ZiKTKH56HjLLsZkcg5xleo/2ul3Z9qYtA0wCEb
 O+W0I5Runnf+oAYyVhA4Worb1i3ce1/Sbcmf2/uADcMYGoTxkDKifV7OWcpOgpMBwqJ7NtTWtA
X-Received: by 2002:a05:600c:198f:b0:485:5981:1411 with SMTP id
 5b1f17b1804b1-486f4472ee8mr12204445e9.23.1773774171656; 
 Tue, 17 Mar 2026 12:02:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f420d7b5sm19506745e9.2.2026.03.17.12.02.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 12:02:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Single binary patches for 2026-03-17
Date: Tue, 17 Mar 2026 20:02:45 +0100
Message-ID: <20260317190250.70506-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

The following changes since commit 6667668e0cf369e47aa9dd0bae40989896e9ed9f:

  Merge tag 'pr-plugins-20260316' of https://gitlab.com/pbo-linaro/qemu into staging (2026-03-17 10:20:30 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20260317

for you to fetch changes up to eda09ccd3e00648bed8b13df465ef15c3c6a7a5d:

  target/ppc: Replace TARGET_PAGE_BITS -> qemu_target_page_bits() (2026-03-17 19:53:17 +0100)

----------------------------------------------------------------
Few patches related to single binary effort:

- Build some stub files once
- Replace TARGET_PAGE_BITS by qemu_target_page_bits()
----------------------------------------------------------------

Philippe Mathieu-Daudé (5):
  fsdev: Build stubs once
  hw/display: Build stubs once
  hw/misc: Build 'mac_via' as common unit file
  hw/s390x/vfio: Replace TARGET_PAGE_BITS -> qemu_target_page_bits()
  target/ppc: Replace TARGET_PAGE_BITS -> qemu_target_page_bits()

 meson.build                |  2 +-
 hw/display/acpi-vga-stub.c |  1 +
 hw/s390x/s390-pci-vfio.c   |  3 ++-
 target/ppc/mmu-booke.c     |  3 ++-
 target/ppc/mmu-hash64.c    |  3 ++-
 target/ppc/mmu-radix64.c   |  3 ++-
 fsdev/meson.build          |  3 ++-
 hw/display/meson.build     | 19 ++++++++-----------
 hw/misc/meson.build        |  2 +-
 9 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.53.0


