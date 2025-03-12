Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA6DC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 05:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsETc-0002lv-QQ; Wed, 12 Mar 2025 01:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsETZ-0002lZ-Lr
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:17:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsETW-00070G-Fv
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:17:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2239c066347so112117905ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 22:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741756668; x=1742361468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZX8FEmRa7Qu0tcEaLyEWb5VCfQ5dn8Q+d4uoExxBDw=;
 b=BCUHrI0rarooym6Mx7+vT6ImOAVhSlUgmBw0GEYtoiqnDhkopSU2Aup24l9n9hN0Hh
 jD74LfSYj+9MGvS8usqZge3ent66whgAdB0bpU74nSv0eVGaXg6iMAVLAymCiwqcRyB8
 PlDeYzjPLh70pfHiN8g/6LOvtrnyd5ieNOJmasUc6FuUb0nFkP84NPIa9s+6OfJj4YJF
 F0PO8Y0qZ/pW3z2iwcRjDhwdRWn7L1sf7PyHuew+9hZHWqH5vHNQwa7AlQTt0SOgd3OR
 fFU0yZWshDt2S/+0u/PY7mcxoID1lf8iLpjVMPsEj6dap5Pf2u1VfO43CzxBLF/BPccu
 Ep6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741756668; x=1742361468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZZX8FEmRa7Qu0tcEaLyEWb5VCfQ5dn8Q+d4uoExxBDw=;
 b=tTOLasAPGHby1vCEHWSOP8Wyxydl0ruB0oV8Wa0qB8GkhnypCpVEYlx1s030HfunDq
 m0ZvML2c+wjz4IA6WqfEBcDBHHNhSYcApTscXilHfZ3gSQ19hTnprpCp6SDG46wjtsw8
 VfjEsr/ZfBzcRqKtVkumYVipwfhwsSgeWkwo+NWcPjVvVr0E9vif/56easzkZrol/Tgj
 C1RkOvTdrirNCh6CJ2XOkBwqTKmsLU48ixsikYPBoD1OlkugKDmRzWrcoo/HgSgyxJiZ
 DEfx/qtU6xS35GgIzkiFLyNnA9ciSC/rMvKB38mgvNA56p4nDKuesyFpr4XxcZirySZc
 Pj7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLGD/Wd7xl89KT4kW9a01A+knMVNBV+CLRFOJZH/Pab0FrDcEi0Xefb9h7nsGg9PxCwhDMTjA2zyGD@nongnu.org
X-Gm-Message-State: AOJu0Yz2Nz5NA8RJk+4CFfNmyswcrUs8d3rsaDFutfHWdk3xIRAzAVbz
 9/UoxuKj+Xe1++MopiJiDaauC3SqZK33aoQqFOHHex0BoQl7ZJum
X-Gm-Gg: ASbGncsBdHPEj6blGcm3mpYhyYqZeZk76p0UP9bx8hzuiV3iByZs/4ptJFQOF0Ohyow
 KuVkKj8y/ZfkzELO5IgRjg2nfl0UmuJYfJE2cAdnHGgg6lJZybY7B1bDqGomZLc+Xaq2lzWURzz
 w4y4hf6gu/f64heguFWAdE//Z8mcBbupYpUnhHnBmOLfROytV/S6/cc/deyCP2YwucpF4r5fFsj
 cltM3AWcXcSaNbWPYWBHRteskptPMeeGmCtNb6mum5oVMlYQ5I2rfNmx3LNvTptHhHiHl76K9LV
 LAEH+xj+o/NKVkt/YsQ7dzUi2zjbqnDfdkcz97c8uXVI4NpudXs=
X-Google-Smtp-Source: AGHT+IHUOlN1VULEVUzskTtievLUs7wjuIyE2Wl84pUN4QOSlVaDWWW+3s/NhkUcmWN7HG1H2PJaIQ==
X-Received: by 2002:a17:902:f547:b0:224:d72:920d with SMTP id
 d9443c01a7336-22428c056a5mr284499205ad.37.1741756667434; 
 Tue, 11 Mar 2025 22:17:47 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a925ddsm107557475ad.203.2025.03.11.22.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 22:17:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/3] tests/functional/asset: improve partial-download handling
Date: Wed, 12 Mar 2025 15:17:35 +1000
Message-ID: <20250312051739.938441-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Continuing discussion from 
https://lore.kernel.org/qemu-devel/20250311131327.903329-1-npiggin@gmail.com/

I added a basic short-download detection, cleaned up download retry
failure, and added an AssetError class that can help us be a bit
smarter about what to do with failures. That's extended to treating
short downloads similarly to non-404 HTTP errors in that it won't
fail the precache step, just skip the asset.

I still think that no asset errors should cache precache to fail
including 404 and hash mismatch, but that they should be punted to
the individual test cases that use those assets. IMO they should cause
test failure rather than test skip, so it's more obvious. But that can
be topic for later discussion. For now, this basically does the right
thing with the NetBSD archive short download problem and treats it the
way we would treat a 503 (which it essentially is), and that gets us
past the CI failures in functional-system-debian and
functional-system-fedora that are hitting upstream testing now.

Thanks,
Nick

Nicholas Piggin (3):
  tests/functional/asset: Fail assert fetch when retries are exceeded
  tests/functional/asset: Verify downloaded size
  tests/functional/asset: Add AssetError exception class

 tests/functional/qemu_test/asset.py | 60 +++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 15 deletions(-)

-- 
2.47.1


