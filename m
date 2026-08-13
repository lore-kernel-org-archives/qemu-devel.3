Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68C8C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuauc-0008JE-LY; Thu, 13 Aug 2026 15:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuaub-0008Ib-8A
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuauY-0002ug-Rx
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4815bce4652so122310f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786648576; x=1787253376; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zscT3QsVxNKqqvpDRIggkucdIR3um2B4Nn05erwJFPM=;
 b=MxZe1uflELM7oL0ICI+zTKvTpfgPwZ3G8Iaz1c0v1JTIsGH14S4v7lVJpxI3snUVfX
 D1rH9ThEHbm5eA5z/fvghRSwJnPFeHNDSnbQEx2kjd1HRKSYMp3AjiTydlFGh4KTNi35
 oCf9aK29tHeAGvyxL7hKn65/bEAWn+1QnZUMdhMaafOYW/TzBDGlywnSlJMjhdy+KdpY
 7Qfy3AP4qZ90LT/Gt5Siqov3j2WtG3dhQzoB8T5JQBrYUBAI1ipngcPEMHuBLT0Dk4TG
 ApjP2TyN9F1V810jALk/xUq/F5Usd6suTpkASIw/8NWeCKeNsdJ0eWjQwmH+2HIIBUHm
 cm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786648576; x=1787253376;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zscT3QsVxNKqqvpDRIggkucdIR3um2B4Nn05erwJFPM=;
 b=XupuRbSPGZe7fYamoghndsgRPcreSr+ZTI0jxaRiqnUdV621f+jMG1V/2F0TZLWb/T
 HMMdWj2/MK11rF0R4KNZcY4YrVREJptIX+lrgwHCY887Z8Cha7G3brGhi134h7ofgCXr
 UN8UV9oyzJ0UsXeY4jH90gDEada8o4AvuMY9HcH3DQ5rgD+bb00yQGfdag/mgYwf+N0a
 uj5gD0MSbrVg5nG3fwG4xVrHxbGn1K79E9G1KFkC0pyuHQoZpUTYsu0t8IqxAMI8omD1
 Hxd0MrFZMP5uBKi72+gx38Cnfs1+WWqUdKIQkhY5uDKsRHiKLxzB6y73TW2wsW0wK+Co
 vzfw==
X-Gm-Message-State: AOJu0Yyij5yipouUq5IYPKhwq26LjOAJHxJrIAVxsNzXDTVvf4xZKCnI
 aMBKt//zgT/zXVAjYdSaWpfXeBusDnmc1coqlIgxkLk3fqA9m9patfw532XbF2Nq4EDfYyGjs6E
 kyea2
X-Gm-Gg: AR+sD11noBL09j8ndFycBWc6lWD8qfs6xbzP+S982/uTWTw7W7Sa09yhdqvPsdv6KEK
 kzFcf9hW3pE3q7Sf9qs2aQwvxEoGB9837OOdwVoBWi7JckgX5lIcenu0PZj2it/CyN+nVTwv/2W
 X62H1NQ5pI/GkWlik/TvWkgB0o8/dH7X8ICKhkhgQz0VjiUkD6LdpNQvTfQCsNtzmEmOXdjejis
 Y9EL9AEjndqmgnOgtpa8C6cjVxGTYVQ0vUqE/Fad6hIymSOK12MVDWh2+IAZuun7L0K7uiAAzSu
 mppMEoh3oNJJ9f3PGM8ihhE3F3lVX+4p6gqIX/cZTZDELt3QIBiDbgiIRz4+Kdkm7U9hP2ik48Q
 hGTdxpvxVoNkSRSYzUjuBUR1wtHGCvFOz+kxckhKVCJCoAUKZr69C3Zq/9KSIGp852Eg4AKaz9G
 Vc2YAb9sTeF2By51tGQONlg1k2KoPnh6j4Py1dUg9zHR5Xt4fhmpGgs7kZ
X-Received: by 2002:a05:6000:98d:b0:47f:d072:87d7 with SMTP id
 ffacd0b85a97d-4816073a090mr841723f8f.9.1786648576356; 
 Thu, 13 Aug 2026 12:16:16 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:859:6d78:3324:fe2c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1f90sm1312493f8f.18.2026.08.13.12.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:16:15 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 philmd@oss.qualcomm.com, den@openvz.org
Subject: [PULL v3 0/7] IDE patches
Date: Thu, 13 Aug 2026 21:16:05 +0200
Message-ID: <20260813191613.2323728-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=den@openvz.org; helo=mail-wr1-x42c.google.com
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

The following changes since commit 539bc315538afe036a4b99088659aa82e3b489f2:

  Merge tag 'pull-loongarch-20260813' of https://github.com/bibo-mao/qemu into staging (2026-08-13 07:16:25 -0700)

are available in the Git repository at:

  https://gitlab.com/dlunev/qemu tags/pull-ide-2026-08-13

for you to fetch changes up to be1ee6a8f6e3b7192d57e900497b81a048f8d193:

  tests/qtest/ahci: regression test for ATAPI read vs. drain (2026-08-13 20:59:49 +0200)

----------------------------------------------------------------
IDE patches

- fix a main-loop deadlock when an ATAPI PIO read spanning several
  sectors is in flight while a drain starts: the nested sector fetch
  was issued synchronously from inside the completion of the first
  read and queued behind the drain, which then never finished
- read the whole ATAPI elementary transfer in one asynchronous
  request instead, removing cd_read_sector_sync()
- extend the IDE/AHCI qtest coverage of ATAPI CD reads: parametrized
  read helper, multi-sector DMA, raw 2352-byte READ CD on both
  delivery paths, and a regression test for the deadlock above

Changes since v2:
- resend: the v2 tag was never pushed, so the tree advertised in that
  pull request could not be fetched
- rebased onto current master, no code changes

Changes since v1:
- MAINTAINERS patch dropped
- spare blank line no longer added and removed within the series

NOTE: 'hw/ide: Don't divide by zero if guest specifies 0 sectors requires'
is not ready for me, skipped from this submission.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Richard Henderson <richard.henderson@linaro.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

----------------------------------------------------------------
Denis V. Lunev (7):
      tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
      tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
      tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
      tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
      tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
      hw/ide/atapi: read the whole elementary transfer asynchronously
      tests/qtest/ahci: regression test for ATAPI read vs. drain

 hw/ide/atapi.c            | 180 +++++++++++++++-----------------
 tests/qtest/ahci-test.c   | 134 ++++++++++++++++++++++++
 tests/qtest/ide-test.c    | 211 ++++++++++++++++++++++++--------------
 tests/qtest/libqos/ahci.c |   5 +
 tests/qtest/libqos/ahci.h |   2 +
 5 files changed, 360 insertions(+), 172 deletions(-)

-- 
2.53.0


