Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF908CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNpx-0008IU-6f; Sat, 30 Aug 2025 11:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usBg2-0003aN-9Z; Fri, 29 Aug 2025 22:50:50 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usBg0-00087C-Mv; Fri, 29 Aug 2025 22:50:50 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4b310f0449bso7765311cf.2; 
 Fri, 29 Aug 2025 19:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756522246; x=1757127046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3+TUw3/3rmqzrYqGgZiZwshcuIuBXwsuRoaOnbztOkM=;
 b=G396s8bh6cCzaTKE+XC9FOOvhnNTyGUE3dJRKP3mXcS0lRMRo4M5sPFopOLyV/fD5v
 3AKkVOlYaWD0meO2QF+0TmZaYDjc4bsL7IgQo1VWVXNrmi+Z38tZD+D3IggnLcqDf/9v
 aY+nPwfSsHuteoiytAwmhfGQnWt5vbdit9/AlKuOGe/h2yiqPJm+/6i/8BdP2DxYRkmv
 0NpggTao8pXQsLIvy3E1fJ9punneL2tF9zN3ljWTv3yZuIcZn44IxOXzn9/zNtb4Dyz2
 m3yPUPjkf9uEoAiLR09Fn29Q4LsA1z1Qb0j/HfkJ5ngObWPUKpXj7NHvodOHHQIoVRsY
 /FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756522246; x=1757127046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+TUw3/3rmqzrYqGgZiZwshcuIuBXwsuRoaOnbztOkM=;
 b=nlStibDaLNU50M9OmRTDGoKEUCdlB+jLWklRShs1EJ8obiyz2MEbDAeAwQg5vSNV86
 Sv32HuSFB+thOS1HE3xtBPPLz/vL2c0PhQUPmFPczYpdy74SwZG7D0WznyZL1/ai14f4
 Uazq1k3JaTmBGR8F/fKVjWaFo1d+yYD4ZmvbHOzXfTu0z3Jnnf6jVmPSeQi1g/4ibQkJ
 1vZE6u2mwOSPWNHnpg2u89SNhwfnOyY/3au4IF//URJPJehilbba3KPkjYX46mXCb/Bq
 C1ux+F9zF1fUMzuoJkUr/nOTadJ1rpnuKSGd7JurAGL3Ya0zqEIYxDz8PlZRzbp78w4e
 V6FQ==
X-Gm-Message-State: AOJu0YxA/hNQL0gylpcgtzPbUg/La1Tw5zKsKR7Dm4MEC+PTzZFpC+nY
 V9ytWP5B848U+YAWvsedwaSQm/jjUPnhwebiqocX5EztKTBho4kYYmJfG/erjA==
X-Gm-Gg: ASbGncu8lN7LX/F9UWCsjmN4CfflAmV5uC0LK/Eg2ZQ6XpqW1MrqdeNMdKc6ICfXxVf
 3jkfoVFyYOXpaJGozJFJXmAxvORg5AVp2W6xStxqWiDHA2TUJ8wbV45YLmiAnyHqrHtm3eQVM6C
 TmNgvIxQxQmfZVnkgyIM8Aeio6wdeS423RIbvM8a0r2+NDpvcJjxvJBFF0A9yUblt2MBjzDePmi
 toAwb/BPR+jlV8FnwmZzdy67G04KxV0fqJZzENhcqWWPCjl1WcPSGC2dIYPXrtml7BH5vjs81Sl
 5VxuDz9HG+5b5/mUzwc9C19wGLjyj3iX3pJ2r0q9JMM52MwPaGpHoefc8qTRH1ehIgOdEoHYXTJ
 RfFICEE2u4Li+N1ZTTt0wjZ/Cq5K9OKem9N93w77EuKxxbjj6gr9d0CWn/addhw80wImCWeEXY0
 rOSxW/4L9s77daMCr1
X-Google-Smtp-Source: AGHT+IGnpF1Ni3bTZ7tt42mc+aGO6jjRDk6xSJKI3kOtmVQUFaPVcd49aNSJ60zFP1a5Oua2txvkGA==
X-Received: by 2002:a05:622a:3d3:b0:4b0:d8b9:22f3 with SMTP id
 d75a77b69052e-4b31da18b0cmr11156851cf.53.1756522246401; 
 Fri, 29 Aug 2025 19:50:46 -0700 (PDT)
Received: from localhost.localdomain
 (wn-campus-nat-129-97-124-90.dynamic.uwaterloo.ca. [129.97.124.90])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc0eacf1b4sm299457085a.21.2025.08.29.19.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 19:50:46 -0700 (PDT)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com,
 fam@euphon.net, hibriansong@gmail.com, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 0/4] export/fuse: Add FUSE-over-io_uring for Storage Exports
Date: Fri, 29 Aug 2025 22:50:21 -0400
Message-ID: <20250830025025.3610-1-hibriansong@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=hibriansong@gmail.com; helo=mail-qt1-x831.google.com
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

Hi all,

This is a GSoC project. More details are available here:
https://wiki.qemu.org/Google_Summer_of_Code_2025#FUSE-over-io_uring_exports

This patch series includes:
- Add a round-robin mechanism to distribute the kernel-required Ring
Queues to FUSE Queues
- Support multiple in-flight requests (multiple ring entries)
- Add tests for FUSE-over-io_uring

More detail in the v2 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2025-08/msg00140.html

And in the v1 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2025-07/msg00280.html


Brian Song (4):
  export/fuse: add opt to enable FUSE-over-io_uring
  export/fuse: process FUSE-over-io_uring requests
  export/fuse: Safe termination for FUSE-uring
  iotests: add tests for FUSE-over-io_uring

 block/export/fuse.c                  | 838 +++++++++++++++++++++------
 docs/tools/qemu-storage-daemon.rst   |  11 +-
 qapi/block-export.json               |   5 +-
 storage-daemon/qemu-storage-daemon.c |   1 +
 tests/qemu-iotests/check             |   2 +
 tests/qemu-iotests/common.rc         |  45 +-
 util/fdmon-io_uring.c                |   5 +-
 7 files changed, 717 insertions(+), 190 deletions(-)

-- 
2.45.2


