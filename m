Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D2ACD11DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPdo-0006B9-1X; Wed, 27 Mar 2024 05:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdY-00067O-KI
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:08 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdS-0007c0-5d
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:00 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6ddf26eba3cso4242872a34.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711531912; x=1712136712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RIoONm3cWARLBBjdU/0Y9ZUwaJZsKiUr6q1WLSaubHc=;
 b=Ssuv/nRCSub2LsjGkWWC3x/5NnqTecpwZV2cxBxHemMtqF+zuCWlBSqJ2cqZeXndio
 lPc4el1Np7Hu70hg0HNjSj4aCO+qEl459bAUodluaE3rEL6wiaLjY9hEpcQNQZ+YNd71
 Sgv9MDYq9AMi7tK1lXIo0ZQmPo4OdVwUNYIcCLS1mLEN8e87YOjd+WzjFeri7EYveXfK
 VV52Ces8XZlwqTdVylR0nuAPB1U8MnLfdXLJqqsNCiDH4YcmZeIKvZxCvp2z6IHF8kB/
 BooTXkn5ZquHfied5C4mwJ5i6MFKMETZickr5flQhSvzS/3qsLs8B3mlHQ4zGUWhHjoI
 vrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531912; x=1712136712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RIoONm3cWARLBBjdU/0Y9ZUwaJZsKiUr6q1WLSaubHc=;
 b=e1jEcgdng20wRO3S5UWubSyB5OQhNiiw3mbxcFJJ1Nh40GVSocyUMCCDmvVka10vMH
 jboA7kTxu4iMP8zrOBYJpsFMov9hedt3cnogoX1/3T59tVL1dlTa1RiQ0UVBjLEIpRR1
 NhpJusQ8j4e89RZrmak9O0lVhNsS3dJOsLMscblR0PbNJCn9hXiHNDWQLudOwfqKyH+P
 DCDe2MwnGGCF8Ci/3BLPRaF7kbKG7n8J6SkLvE+mu9dYN06N62AF7AHGySaoiq6j96FS
 z2bVvYvb+rnwbe5mAC6xsR8O9n239+ecBTBrLzSrJi4jgQo846xrJhXamI8+ZeD0siLD
 VMXA==
X-Gm-Message-State: AOJu0Yzhn8sgozpCBcR6PwQfpTGxI8SeEDNJbWcpzQKHN3Eh/uinrXLN
 aem5xmU0rhRua1QdO8/yIfPlpcLw1dKQ33y3eRJo/k3myyoRHj0R2GXsw1lofMbi5+xsgOgBo2N
 h
X-Google-Smtp-Source: AGHT+IFa3hOBZVn8AZjUnsjiOi14i3WQK1JFeBRDDrYqnkJjU1bx5lO/OxttB1R+IUbEZ9NAi3FRPA==
X-Received: by 2002:a05:6870:d214:b0:220:8c16:fe1b with SMTP id
 g20-20020a056870d21400b002208c16fe1bmr4604124oac.40.1711531910618; 
 Wed, 27 Mar 2024 02:31:50 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 fm23-20020a056a002f9700b006e6b41511fdsm7628760pfb.94.2024.03.27.02.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 02:31:50 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v2 0/7] qtest/virtio-9p-test.c: fix slow tests
Date: Wed, 27 Mar 2024 06:31:37 -0300
Message-ID: <20240327093144.781701-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x330.google.com
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

Hi,

In this new version I added a handful of patches to make it easier to
review, as suggested by Greg in v1.

Thomas, the changes made aren't negligible so I didn't add your
Tested-by. You're more than welcome to give this version a try :)

The first 2 patches are needed to ease the burden of individual test
changes. It was really annoying to deal with changing the dir name every
time a test was being removed. Parametrizing the dir name (and anything
that has the dir in it) makes it trivial to change the dir name when
needed.

I kept the slow revert patch (7) because this series is passing the Gitlab
CI with it:

https://gitlab.com/danielhb/qemu/-/pipelines/1228813691

I'll leave to the 9p maintainers to decide whether we should go ahead with
it or not. 

Changes from v1:
- patches 1 and 2 from v1: dropped
- patches 1 and 2 (new):
  - parametrize 'new_dir' name
- patches 3, 4, 5, 6 (new):
  - individual test consolidation
- v1 link: https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06146.html

Daniel Henrique Barboza (7):
  qtest/virtio-9p-test.c: add '_path' in path vars
  qtest/virtio-9p-test.c: parametrize 'dir' name in local tests
  qtest/virtio-9p-test.c: consolidate create dir tests
  qtest/virtio-9p-test.c: consolidate create file tests
  qtest/virtio-9p-test.c: consolidate create symlink tests
  qtest/virtio-9p-test.c: consolidate hardlink tests
  qtest/virtio-9p-test.c: remove g_test_slow() gate

 tests/qtest/virtio-9p-test.c | 228 +++++++++++++++--------------------
 1 file changed, 96 insertions(+), 132 deletions(-)

-- 
2.44.0


