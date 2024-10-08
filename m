Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0068ACEFC30
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 16:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syDMg-0003A9-Ee; Tue, 08 Oct 2024 12:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDMf-00039T-E8
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:47:13 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDMd-00038G-DC
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:47:12 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37cdb42b29dso3722184f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 09:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728406030; x=1729010830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vdRYGW17y26IZqpkdaRpENrRF5Capsx8b2g2YlQVI9U=;
 b=DjHtd2l/VeE4QJROzVvFoLJCBdgEwYsCEUW3SC8KVckSriEyYmQLGYvQr4dYT97NCZ
 Pi7uk5qMmnQnx4VI9BoD1mSw7NpbTj+I95qjeIVBD8t8KkRoY7PYFZx7TDGzNP4SLWh/
 Prlbud94Hzqzda0w+LUMkk6Uos2MVpwHWNnmeuAXkKXOS7TGGkYGZgtaeUATvO8sp/dE
 3piqiE/lvFTIZaZf1lyp1MsQAwe2c8OPn8vw7MiDcrM1E9rkn355LFJvw/PBo72bWF/6
 8hhrRH4J57XBnQBZ3EcS2NS2ddP+ZVATQDJ9gB4o8D/s9lg1Y4Hbcp+EJvdVQbs1EVRF
 FBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728406030; x=1729010830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vdRYGW17y26IZqpkdaRpENrRF5Capsx8b2g2YlQVI9U=;
 b=CcsAkpxmoouLcNjLCZK3hz3ydnBTKvWU5bShq3uHLv0Bqh+FfJ4HO5fYmafYChS9AO
 X2WVR95496ZjxypwFw2JVr6GHlAXsjcnaCjqDNw1C5RhuVhCcsbLfwLHeO5bYX1xoUL/
 cojPCl+nJZocGiX6ppvWORuU8RbRXaGScB0Br8l2ml3tDMCF2S41jr8IBxnDoncjBSlQ
 CGlmHSUYIT0Fv3069gb4SuVkkVh65N9EsHCOYOqxEFuZNrS3l1jqfxBUUigegWLiHtJi
 OkLUt2n6kBnHKUAoZ+RKvTNVBb7+ppQt5BRYQ+uxbl4r4lfovJKpeWkfZyjq/U5nVHgt
 XFhw==
X-Gm-Message-State: AOJu0YyJ2u6MIhlWBZ4rZE3iy1WuPDr2rafPGvPZ1Q5rnKoYtIbbYkiG
 2fRBgUZbN8tGuidezgQamIjbbciv+pKY3bgeqhhkF00GeCLVknRR85NI8zJ8hnt6H53lbbsnZ3v
 l
X-Google-Smtp-Source: AGHT+IEOcm6KwqOldUsw0YWkqBjzonBaC6HHIraTRwgHEbSc50gkbYfRdsmkFQfvVM/u9dnBUOKhiw==
X-Received: by 2002:a05:6000:1acc:b0:37c:d179:2f73 with SMTP id
 ffacd0b85a97d-37d0e6f8efamr11998761f8f.13.1728406029738; 
 Tue, 08 Oct 2024 09:47:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d32ea1d98sm1490936f8f.68.2024.10.08.09.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 09:47:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v2 0/4] block: Miscellaneous minor Coverity fixes
Date: Tue,  8 Oct 2024 17:47:04 +0100
Message-Id: <20241008164708.2966400-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

This patchset is the remaining stragglers from my
first set of "minor Coverity fixes" patches posted a
couple of months back:
https://patchew.org/QEMU/20240731143617.3391947-1-peter.maydell@linaro.org/
Of that series, patches 3, 4, 5 and 6 are upstream now.

In this v2 series:
 * patch 1 (old patch 2) has had a long line wrapped;
   already reviewed
 * patch 2 (old patch 7) now has hex2decimal() return "UINT_MAX"
   instead of "-1"; already reviewed
 * patch 3 is new, and fixes an error in an iotests reference
   output file that's been lurking around for a few years now
 * patch 4 (replacement for old patch 1) takes Kevin Wolf's
   suggestion to make vdi SECTOR_SIZE a 64-bit constant so we
   don't have to carefully cast it every time we want to use
   it in a multiplication

Patches 3 and 4 need review; patch 4 passes "./check -vdi"
except that 297 (the python-linter) fails for unrelated reasons.

thanks
-- PMM

Peter Maydell (4):
  block/gluster: Use g_autofree for string in qemu_gluster_parse_json()
  block/ssh.c: Don't double-check that characters are hex digits
  tests/qemu-iotests/211.out: Update to expect MapEntry 'compressed'
    field
  block/vdi.c: Make SECTOR_SIZE constant 64-bits

 block/gluster.c            |  7 ++-----
 block/ssh.c                | 12 +++++++-----
 block/vdi.c                |  4 ++--
 tests/qemu-iotests/211.out |  6 +++---
 4 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.34.1


