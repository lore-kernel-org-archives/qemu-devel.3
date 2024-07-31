Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8EFC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZARG-0004SM-1X; Wed, 31 Jul 2024 10:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARE-0004Qz-I3
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:24 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARB-0002do-Pq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:24 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0468so90117981fa.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722436579; x=1723041379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WJFK5vyGGdcL3oMdoUv5FkVPSRek6mnMGxS1HmBeMPU=;
 b=YRECnmuMwu3WIwSAO3kbncYFifNhmgdSfdfFJlZxDI+6gHeJyfEqs7A2CdbKLuah32
 ut0MOgsp6ZmuDkybtZP+OZb+ZqDNflEm+0mtssOJMw2bgyi2h+r7O7M0Wcy+mzoe7HIl
 4YUIkQm9Ka0I82r4gP0LnPVBB2WAufGbrD+hekm/iyzSgcsBvQlI/ev2NWivtNuf2lTi
 /EgEXp59eKW9rD73CFn6C/hBCDTtAlK9YplTJYQGlBp1Fn0x+MZZEuKXeEEoFlPa/VE/
 OIhShZMeC/nPfJPKgJIT9hZZ2lXzP6zv28e5UrErtqdzGOddfQwK9vyGdsVJn0MZr8su
 tMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436579; x=1723041379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WJFK5vyGGdcL3oMdoUv5FkVPSRek6mnMGxS1HmBeMPU=;
 b=FOVr+MiWQFD2BLU7OgAjtQKZ9qYEqi9RCOmXVXGCkq+S99zn32TQHLFvUnY/O0dUjz
 dj2ejPhLX0lmm79Vt5saEYkFp3mvLoYYoY9szfB64VOqFIrpmYBTEFgI29uq31Q5fO+j
 i5i9PBBvU3zjagGqWrsa4Sm18aJIhBo1XPz8amw82XbbeKzyqvrwh8kLHNz7v2RMzY2M
 8zzbDuCRZ8xt1FfKqOZkiO1+MPQAJeLLyLXl339eRcXIoSVfkuiFzSiSYdoBJuKrDsen
 bSXd58M4VyVdnxFyI3KqkG+uoOVy55tUKXFVjgmlV8VsfqjtdpZ6QfePA8VS8qu3avJB
 RjLw==
X-Gm-Message-State: AOJu0Yxog2F94A7QoacWx+Nfyi5Q6v0SSsN+2qa4H3L7a3eLiNCO2jIm
 BnXasv6Flfauv64bArfs2v+Nt64HN/VHaQjW+VUQaPSo8BdiyvyEeoA8JCST7zjijpyIdpQQ9pk
 G
X-Google-Smtp-Source: AGHT+IGB7mMK33xZehqT8II59fUfIb5rhksh3a9J3lEFpghCharsuCFQO5Z5Q8S0Zt3oKZiJ47wgZA==
X-Received: by 2002:a2e:9350:0:b0:2f0:2760:407c with SMTP id
 38308e7fff4ca-2f12ee42005mr97876241fa.30.1722436578936; 
 Wed, 31 Jul 2024 07:36:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a86dsm23976025e9.1.2024.07.31.07.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:36:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 0/7] block: Miscellaneous minor Coverity fixes
Date: Wed, 31 Jul 2024 15:36:10 +0100
Message-Id: <20240731143617.3391947-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset is a collection of fixes for minor Coverity reported
issues. In all cases, there isn't a user-visible problem, but
the Coverity issue pointed up somewhere where we could clean
up the code or make it a bit more obvious to a human reader
what the intent was.

Only lightly tested (with "make check" and "make check-avocado").

thanks
-- PMM

Peter Maydell (7):
  block/vdi.c: Avoid potential overflow when calculating size of write
  block/gluster: Use g_autofree for string in qemu_gluster_parse_json()
  hw/block/pflash_cfi01: Don't decrement pfl->counter below 0
  hw/ide/atapi: Be explicit that assigning to s->lcyl truncates
  hw/block/fdc-isa: Assert that isa_fdc_get_drive_max_chs() found
    something
  hw/ide/pci.c: Remove dead code from bmdma_prepare_buf()
  block/ssh.c: Don't double-check that characters are hex digits

 block/gluster.c         |  6 +-----
 block/ssh.c             | 10 ++++++----
 block/vdi.c             |  2 +-
 hw/block/fdc-isa.c      |  2 ++
 hw/block/pflash_cfi01.c |  1 +
 hw/ide/atapi.c          |  2 +-
 hw/ide/pci.c            |  4 ----
 7 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.34.1


