Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDFEC38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 18:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPngY-0003lD-79; Fri, 05 Jul 2024 14:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPngT-0003fV-Ul
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:29:28 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPngF-0006wf-HS
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:29:25 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b5e4466931so8539026d6.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720204150; x=1720808950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6rRygtm6o/m0r6HXaY5ID5TtA3O7HqCN8g6MPgxbGJY=;
 b=CiJ6HTpJBUrs6YQfnYeaZpjwh/a9SZb7Q/OZ/xYGoIECQ4qcdBmAmfpjVssw3V1Qw8
 GzhE1ycu0/T39DVdxvq8YUm3mwgJwCi8B9DQPVxkTFIQBqwba5pH/83lzan7Hqrob5Mn
 /UZt7J9b+iZmVeupflzu2vpnZyRc/TPGcqXoxeJf5UB0vqr5GisSaDSZpukp4NTpXAjf
 wom8qZctcOIizuXW0o25VXuVpazwXSi26SkyjQkExjm1FnMbmWdHNZa7g/dsACMrd2ZH
 vQB3VwgXSgy8P+Ku5gcvEWvY1CTVeNLYuEHqyibF0jymq71k6NptQoGpUJ8RSKg9vXWf
 HpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720204150; x=1720808950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6rRygtm6o/m0r6HXaY5ID5TtA3O7HqCN8g6MPgxbGJY=;
 b=ci/Fp9KQTpZM/K5LF/IWsaaAk8RQEB0cJYGqnEdDYANT0EI9+WO6nQ/kbmLqmljR3n
 gD83fTs3KZHEZV/z0gKZqgtY4DGRpK/Jm1ZKe4t7cJh3S6ekJbBL32ftYYs7M2hN9YMt
 t8Buo203eu8du7XZ3MOuR6R2KSi7c7mUIYXmejXxBmRNJoQWUbbfgdCLhFPOGcyzkxlg
 VWwVGY97Ag6lmPIudNo8L80hCX5tTsAMouTSqnbMgPCIoPmpcidHd7qrxBbQdnFjrRKt
 1TV5WJPqIWukg8Up71mPUSVXuY8YQOdVuetXsMRnoWf+U1jjhbaoJW5ce9qlVlKtgeWP
 rqLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN1a7yT6IcEAAej6b6kQam/dvPUQOwAblVe1ak3iPIOj2wPd2YEGCeRSnJHvupXjwBykBOl/tIAUd6TOT5gOJnRMM9kHY=
X-Gm-Message-State: AOJu0YwsJvp4ZeSj3rq/tp5vS6I1NrR/F6qWy09gXMznSAPcWQoanWhy
 oqxp4ztWFYFeELXah8lqXCsYsqTFC4uUYGvTMrbTnNtMQXy6xhqo1SWNFdxO0y8=
X-Google-Smtp-Source: AGHT+IFDvUBWGQAcLZEmWhHbR92wBlgR1kPWSCy3R05w/UhgbF9m9hKptcluJudiWsB1njA02gMhig==
X-Received: by 2002:a05:6214:1c4d:b0:6b0:7b34:21c0 with SMTP id
 6a1803df08f44-6b5ecfd88e3mr62881366d6.34.1720204150139; 
 Fri, 05 Jul 2024 11:29:10 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-54-152-246-50.compute-1.amazonaws.com. [54.152.246.50])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b5fb7e316esm4972936d6.30.2024.07.05.11.29.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 11:29:09 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v4 0/4] Implement using Intel QAT to offload ZLIB
Date: Fri,  5 Jul 2024 11:28:57 -0700
Message-Id: <20240705182901.48948-1-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

v4:
- Rebase changes on top of 1a2d52c7fcaeaaf4f2fe8d4d5183dccaeab67768
- Move the IOV initialization to qatzip implementation
- Only use qatzip to compress normal pages

v3:
- Rebase changes on top of master
- Merge two patches per Fabiano Rosas's comment
- Add versions into comments and documentations

v2:
- Rebase changes on top of recent multifd code changes.
- Use QATzip API 'qzMalloc' and 'qzFree' to allocate QAT buffers.
- Remove parameter tuning and use QATzip's defaults for better
  performance.
- Add parameter to enable QAT software fallback.

v1:
https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg03761.html

* Performance

We present updated performance results. For circumstantial reasons, v1
presented performance on a low-bandwidth (1Gbps) network.

Here, we present updated results with a similar setup as before but with
two main differences:

1. Our machines have a ~50Gbps connection, tested using 'iperf3'.
2. We had a bug in our memory allocation causing us to only use ~1/2 of
the VM's RAM. Now we properly allocate and fill nearly all of the VM's
RAM.

Thus, the test setup is as follows:

We perform multifd live migration over TCP using a VM with 64GB memory.
We prepare the machine's memory by powering it on, allocating a large
amount of memory (60GB) as a single buffer, and filling the buffer with
the repeated contents of the Silesia corpus[0]. This is in lieu of a more
realistic memory snapshot, which proved troublesome to acquire.

We analyze CPU usage by averaging the output of 'top' every second
during migration. This is admittedly imprecise, but we feel that it
accurately portrays the different degrees of CPU usage of varying
compression methods.

We present the latency, throughput, and CPU usage results for all of the
compression methods, with varying numbers of multifd threads (4, 8, and
16).

[0] The Silesia corpus can be accessed here:
https://sun.aei.polsl.pl//~sdeor/index.php?page=silesia

** Results

4 multifd threads:

    |---------------|---------------|----------------|---------|---------|
    |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
    |---------------|---------------|----------------|---------|---------|
    |qatzip         | 23.13         | 8749.94        |117.50   |186.49   |
    |---------------|---------------|----------------|---------|---------|
    |zlib           |254.35         |  771.87        |388.20   |144.40   |
    |---------------|---------------|----------------|---------|---------|
    |zstd           | 54.52         | 3442.59        |414.59   |149.77   |
    |---------------|---------------|----------------|---------|---------|
    |none           | 12.45         |43739.60        |159.71   |204.96   |
    |---------------|---------------|----------------|---------|---------|

8 multifd threads:

    |---------------|---------------|----------------|---------|---------|
    |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
    |---------------|---------------|----------------|---------|---------|
    |qatzip         | 16.91         |12306.52        |186.37   |391.84   |
    |---------------|---------------|----------------|---------|---------|
    |zlib           |130.11         | 1508.89        |753.86   |289.35   |
    |---------------|---------------|----------------|---------|---------|
    |zstd           | 27.57         | 6823.23        |786.83   |303.80   |
    |---------------|---------------|----------------|---------|---------|
    |none           | 11.82         |46072.63        |163.74   |238.56   |
    |---------------|---------------|----------------|---------|---------|

16 multifd threads:

    |---------------|---------------|----------------|---------|---------|
    |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
    |---------------|---------------|----------------|---------|---------|
    |qatzip         |18.64          |11044.52        | 573.61  |437.65   |
    |---------------|---------------|----------------|---------|---------|
    |zlib           |66.43          | 2955.79        |1469.68  |567.47   |
    |---------------|---------------|----------------|---------|---------|
    |zstd           |14.17          |13290.66        |1504.08  |615.33   |
    |---------------|---------------|----------------|---------|---------|
    |none           |16.82          |32363.26        | 180.74  |217.17   |
    |---------------|---------------|----------------|---------|---------|

** Observations

- In general, not using compression outperforms using compression in a
  non-network-bound environment.
- 'qatzip' outperforms other compression workers with 4 and 8 workers,
  achieving a ~91% latency reduction over 'zlib' with 4 workers, and a
~58% latency reduction over 'zstd' with 4 workers.
- 'qatzip' maintains comparable performance with 'zstd' at 16 workers,
  showing a ~32% increase in latency. This performance difference
becomes more noticeable with more workers, as CPU compression is highly
parallelizable.
- 'qatzip' compression uses considerably less CPU than other compression
  methods. At 8 workers, 'qatzip' demonstrates a ~75% reduction in
compression CPU usage compared to 'zstd' and 'zlib'.
- 'qatzip' decompression CPU usage is less impressive, and is even
  slightly worse than 'zstd' and 'zlib' CPU usage at 4 and 16 workers.


Bryan Zhang (4):
  meson: Introduce 'qatzip' feature to the build system
  migration: Add migration parameters for QATzip
  migration: Introduce 'qatzip' compression method
  tests/migration: Add integration test for 'qatzip' compression method

 hw/core/qdev-properties-system.c |   6 +-
 meson.build                      |  10 +
 meson_options.txt                |   2 +
 migration/meson.build            |   1 +
 migration/migration-hmp-cmds.c   |   8 +
 migration/multifd-qatzip.c       | 391 +++++++++++++++++++++++++++++++
 migration/multifd.h              |   5 +-
 migration/options.c              |  57 +++++
 migration/options.h              |   2 +
 qapi/migration.json              |  38 +++
 scripts/meson-buildoptions.sh    |   3 +
 tests/qtest/meson.build          |   4 +
 tests/qtest/migration-test.c     |  35 +++
 13 files changed, 559 insertions(+), 3 deletions(-)
 create mode 100644 migration/multifd-qatzip.c

-- 
Yichen Wang


