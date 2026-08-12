Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC86C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAfy-0006BD-OA; Wed, 12 Aug 2026 11:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAfi-0005oL-4R
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAfd-0006yp-R6
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786547707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H7yhEEjAMuovIAMo08Sg3nLu2vPRokWt7lrMTX8kb9k=;
 b=V2kIaW6gvejcc2c0fI6ctqTbslz/m3r3CzXAaWZdnnmtPHHJrEJ/Y/VTiPyIpeR7JGDP4s
 aF0lD68ur+xB8WFMP5b4EzzClyWMapxQgSAMQxjwrbYOnSFPg9ixAS2QdH6tsvJpEOxG1+
 5YYkXl8rEy/U9vxaygE5lofSDaVqHtk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-KpTVoG6COAKLREaufUa1ZA-1; Wed, 12 Aug 2026 11:15:05 -0400
X-MC-Unique: KpTVoG6COAKLREaufUa1ZA-1
X-Mimecast-MFC-AGG-ID: KpTVoG6COAKLREaufUa1ZA_1786547705
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52827090cc5so13560381cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786547705; x=1787152505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H7yhEEjAMuovIAMo08Sg3nLu2vPRokWt7lrMTX8kb9k=;
 b=asluoATEkhjz2GDI+/AF2c8w7LIoVsNqah/VqSkl8LgIY64Lw+wpmYKybJ7rIJXiUo
 i6uktw4N8OIALNBHU9hz80zD4kMBCF0iPvovju4K7IvGI3e+ULNCew1K2x4YqiyTDcJJ
 Wai/Gy69RQ9/GpOuK7dVlQD+oJ8bY4lpXcTuWKD04KdDpT7rvySfWsGGMct9nDY9W7QV
 ZN4FQDfnsW0P5KGwvzWR8bQ2wSFiZn5eIT7mAIkZNb7Rs3IaZV9bKuBMVnSN51ARh2HY
 aMNezRdQhKlHSdSax0m45JiUQT6JuRmG5SZz05G111cCQEoWmM6bV9z8oavN9FjQ3cRb
 NNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547705; x=1787152505;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H7yhEEjAMuovIAMo08Sg3nLu2vPRokWt7lrMTX8kb9k=;
 b=slwi+jkydlhA54l+7UuSDoyVG/lLcv31VLigSOPDvuhGDxmUsaB6vgzXb583zMNcSd
 MsYhXfvHLDTP2DSVEmExMhr5CslD3c6rXEjGwtmh3xLY1yRMlXubNeQUXzTmspP29NYX
 Mtc7wXW4b0PbvtE/qEvkCKBItyalOT+RXKpPSeWvcoGxBwDc+FAv3f4QP9R+94YRDV+W
 pMvVdHgQOSMdY9OL734Xxla1+KmyU3CR2VbODj14e9p/vY2qfgvCTTG7gjy7p3F1a7gx
 VxRJkKLn93BKqqyQtJuYNe8I0SK73uO0hy8qICkwD2tfdBq2mFDRudvYPH5aZqd1XbNO
 4aLg==
X-Gm-Message-State: AOJu0YynJigutKxPT00vxxsulX+s5ck/nBo8XWW2Q+CvvrnIdZqcZObJ
 iL8WRiuh8xL1AmNy2y8y16XCbHxdFCS7xvYX4v/eRDbc+TetDjWCkGp0iYK+A65dHbuZ4A9AlmR
 B9ZQdUGHJD50KKZnvS9ME/U4ah3hMhlaS7ksQ5RMmwYunFVLEYUhzAQqGzZYd43W9+bxpCqDXof
 lnwnIisX0tEIUTxAHDUHF+/z3U4TL19lWxN+bmkA==
X-Gm-Gg: AR+sD11PvCY6Syag9goOEGtIHTVLg/wj3LGAl1q8pfaGg+hXUqlAxzCEJTKMm+ti+ME
 sk05wUBjoyEa1kVtm6F+eVMfsK6RxtxCRZRQ9ysOtRZbTYdY9lfpZvahwuiK+T2k1pwcPLk9drK
 WzlNWrSQbcK/kGxaIlKgXD6WH2SS4Tjo+m943+odfeKsw4GthMOGnseUShxz3fgHhYJG37vQGNC
 61JLqcPL1pgpOUeOsatznp4nGWTWbk6wVMNpju6XvUdb8XsWiISEY65NEYxgKmLtebjV0Rdz51h
 d4xbTVyBrgiWUKGHs8VMho3exW5NhWGvEbiOURJOSBLujHzL8An0e0LW82uyPqPAuA==
X-Received: by 2002:a05:622a:1a8b:b0:51c:1ea:e290 with SMTP id
 d75a77b69052e-52d659f15c8mr42886311cf.17.1786547704565; 
 Wed, 12 Aug 2026 08:15:04 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8b:b0:51c:1ea:e290 with SMTP id
 d75a77b69052e-52d659f15c8mr42885501cf.17.1786547703915; 
 Wed, 12 Aug 2026 08:15:03 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d948d6sm19552841cf.15.2026.08.12.08.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:14:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 00/10] Next patches
Date: Wed, 12 Aug 2026 11:14:33 -0400
Message-ID: <20260812151444.2611689-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 84f07211cc5b4fc6a371559bf8a5de4fb068e648:

  Update version for v11.1.0 release (2026-08-11 10:04:46 -0400)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/next-pull-request

for you to fetch changes up to 2375e9b1239eb6ad794eaae29245b94f429c87c5:

  migration: Fix rare hang of migration_channel_read_peek() (2026-08-12 10:42:09 -0400)

----------------------------------------------------------------
migration/mem pull for 11.2

next 11.2:
- Dongli's patch to add cpr-transfer support for HMP
- Fabiano's doc update for migration on security issues
- Gavin's fix for MMIO access support for memory APIs, reverting ram_device ops
- Sam's migration test build fix for !ASN1
- Peter's a few migration hardening fixes

----------------------------------------------------------------

Dongli Zhang (1):
  migration/cpr: Add HMP support for cpr-transfer

Fabiano Rosas (1):
  docs: Add security considerations for migration

Gavin Shan (3):
  system/memory: Use memmove() for directly accessible regions
  system/memory: Use qemu_ram_move() for directly accessible regions
  system/memory: Make ram device region directly accessible

Peter Xu (4):
  migration/multifd: Validate next_packet_size in zlib/zstd recv
  migration/multifd: Replace assert() with error_setg() in recv paths
  migration/ram: Check for RAMBlock size mismatch when parsing
  migration: Fix rare hang of migration_channel_read_peek()

Sam Heney (1):
  tests/qtest/migration: Only build tls_no_hostname test with TASN1

 docs/system/security.rst          | 22 +++++++++++---
 include/system/memory.h           | 46 ++++++++++++++++++++++-------
 hw/remote/vfio-user-obj.c         |  4 +--
 migration/channel.c               | 11 +++++--
 migration/migration-hmp-cmds.c    | 18 ++++++++++++
 migration/multifd-qatzip.c        |  5 +++-
 migration/multifd-qpl.c           | 24 +++++++++++++---
 migration/multifd-uadk.c          | 24 +++++++++++++---
 migration/multifd-zlib.c          | 11 ++++++-
 migration/multifd-zstd.c          | 11 ++++++-
 migration/ram.c                   | 11 +++++--
 system/memory.c                   | 41 +-------------------------
 system/physmem.c                  | 48 +++++++++++++++++++++++++++++--
 tests/qtest/migration/tls-tests.c |  4 ++-
 hmp-commands.hx                   | 12 +++++---
 system/trace-events               |  2 --
 16 files changed, 214 insertions(+), 80 deletions(-)

-- 
2.54.0


