Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82E3C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrIVH-0008VS-G6; Tue, 04 Aug 2026 13:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIV4-0008Tb-NA
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIV1-0000g2-U2
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:21 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47de008b020so79866f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785862818; x=1786467618; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yQK6PHDh5QKXrHb70XqWY9/HU72OmNMd2B31QgcOomc=;
 b=Gx2q9U1+h1tpNwnPLtCZOEXi3Txy2CjrEIdFESPng3Wehbqa4OdUM1ixrPSuV1aEqw
 MjKT8nn+4G+6TwL5evSMvtjbP8L6IeglNT/n37GON8gi7InGCvEDdk4JLJGnQr4cpzWw
 1Y9A4IqSduQ4zxMa17LlXoInR7/YoCUkFfqjhJSg+TlF/tKMg4oQNpsJqO93nTvxCTEM
 t+mHbFZuX869KK3T+x/GN/oSKCX4DnPEea9hT00B7jb97E3iRwHj7PDQzCzYFNuc2J83
 JJkgI7B9sVXmK7mXymKyF1JGVal3AmWIqGDLul0c2kjiEIGPZ/H3h2fY3fdwq+yQ7RPk
 FBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785862818; x=1786467618;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yQK6PHDh5QKXrHb70XqWY9/HU72OmNMd2B31QgcOomc=;
 b=Y9al/dpq47e/dULXG9JS/PkjyJ+cBWQRgnJRlRRPFcE6W21V8+o6qAGBu6rqo852R1
 ExdCThXI4CrmkCyFjLpnBY3xiI/FtLfYKkbw7L6QkKpaIGE42uwCyW1J6vdxrRVEEdoL
 /PwP4bTfa1m6qnkHj6a6j8LfrmP8HmmMNO50ES98lCc3F+xeQ2+PkVRcL+djwOQX5vEs
 VatSbp+97EK96zwWN7xQaZRspcOTL7r8Vfq3KUVHdjWI+1btD9B6iOooBoVKDhtWj8Up
 A75TZTquudxD4Dh3Nge9R4QBXF8I5dhou3IZkKpd/s/uBpxiebhteP3W54ZWEHtLkFdQ
 q4lw==
X-Gm-Message-State: AOJu0YyQakkSMl55nr2jHmVrwzxixBMCSczRcL4R6g9ryJFI4TDsxEeY
 jB0qFEDPcI5lFw7YFLmTmDHKz3Hl+WN/2kGjmntf+x+3OrVQpjq0oOeZzIksZmufoGV1mn/OJYP
 R6Un3
X-Gm-Gg: AR+sD12yKBUIwa6LPODO/qnz9cHhmeQGxKEOCFbjuWVk7NPGCaDBRc13TrSJy40Mml/
 pTKIU0f1zSsxzurdDfCTT5v7jrDGks+k59bOLPFbaHaDVra/09v+Q66xC8jIE5C8jO+fx+UXoOo
 MuZ4s2gtM02n78MDMR4x85Sfqh3fnLAQiBgLqM7lp17jT+Z6ryIcqbHX9pLlTtoyuPUO5jM7WAf
 r5VGptEMNEzgrsHV80su5dnk/I3q96fmH+ErbYlqs2OqaVCQ6emsrFuMS/k2NAvFJ9zwcS/v6Qj
 NGRWZWuzhBzLFOg+CL5QAM86aeAET5UpDcR/wBEpManaZwDX59SfbdBHTpdldxHuffBho/qZvGt
 OHNTIWczE97j+FKRY+IQzKZlQJmSSjrLJ9SmSEpsL4uCglV/Z32X7ovH0KywOaNXP16ySHlPBFR
 C0jmHgUAkCQmD90tLqvmkJbi0+S+SXwdz2hL+LXYnGGiqlYw==
X-Received: by 2002:a5d:584d:0:b0:47f:8b0f:7172 with SMTP id
 ffacd0b85a97d-47fe81a16f0mr12710409f8f.6.1785862818188; 
 Tue, 04 Aug 2026 10:00:18 -0700 (PDT)
Received: from athena ([213.133.28.44]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23ec3asm1234116f8f.31.2026.08.04.10.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 10:00:17 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 0/7] IDE patches
Date: Tue,  4 Aug 2026 19:00:07 +0200
Message-ID: <20260804170015.3128363-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=den@openvz.org; helo=mail-wr1-x436.google.com
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

The following changes since commit e1705a25aff35635c360bbaba4c2731d019a422a:

  Update version for v11.1.0-rc2 release (2026-07-29 06:16:08 -0400)

are available in the Git repository at:

  https://gitlab.com/dlunev/qemu tags/pull-ide-2026-08-04

for you to fetch changes up to 9a249de6ae86124b436b5e839e285aeb333ea8c0:

  tests/qtest/ahci: regression test for ATAPI read vs. drain (2026-08-04 18:40:34 +0200)

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

Changes since v1:
- MAINTAINERS patch dropped
- spare blank line no longer added and removed within the series

NOTE: 'hw/ide: Don't divide by zero if guest specifies 0 sectors requires'
is not ready for me, skipped from this submission.

Signed-off-by: Denis V. Lunev <den@openvz.org>
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


