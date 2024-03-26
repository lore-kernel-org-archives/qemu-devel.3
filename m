Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E77CD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 22:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpFW9-00066i-Vu; Tue, 26 Mar 2024 18:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFW5-00066T-Eb
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:37 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFW2-0007Y5-HI
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:37 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78a01a3012aso420100385a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711493007; x=1712097807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/jMorgrN9FRNNNUViYMEXW7EWhW4lfeYHhxDZZLFfgI=;
 b=ENHBt7IAL9VUH0QgWIuqXqZXcZpj2r6zygyxJNaQn8fLiicqJBdKZTyBs5kaZiT1oN
 PPi7Ny55u2yZt5eBsa7qQQaVX2oHF24e7SVQ2zEvX0xfmSaYNnPsRHGMdAzks4QlCSmi
 ZXJJEE25J5qjGBy8cpUyx2LT+m9HKclQSRpmywW+yYhfImkZFREmpj0eR+9orA/EOgeA
 SZeWeaXgF7G93k8wC9h72DiUHhkuhoBO/NvKYE2/pkuECW2Vb4v+CRf/9DFaZSnZb8y9
 aQ6SkjfEFg3ESHqPWx3LAk90WvpRMSYdrVPPe3biHQj/qVTPA3IRXorcJJcf8s8TcgxM
 tDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711493007; x=1712097807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/jMorgrN9FRNNNUViYMEXW7EWhW4lfeYHhxDZZLFfgI=;
 b=L2d5xMsuY/Yoibmcm5wGxbEzqY8gaiKLs8wEOjIKxnrEyRV9ivfK+loT1/r/tfrRa6
 xQmeI7uWTRTAUdjBXY2P0tYo2bvLrQxSJ9fhNMf3EO74dLd82DQlAIFq9Y9EJBnhHIxI
 tHcvP9xoOk4rVxCbhoRpKsXKU11tlBLj9iWKysgWyi2+e7/3uKzvt/Qq3ay05oQrCv4q
 FS7b+A/ZOyEFr+4UTvlxWn5r0V2+lOwAV9DBTsByMGD9dqTsdn/569NlXBtEtshCN/AF
 x/9jsOh2rAxB6/LNHd4+MKRZabO/gOROipE6BpXYg0HSAAyb0pL6wuJMfQSvirZv+T85
 RMKQ==
X-Gm-Message-State: AOJu0YyyNKQqknjvgB75snhLTqRAz8X2mmVWdusK7s+tneb91MvPM6wT
 YeL7TtBMDIbXm1YtXl4JIarXXljReoI/FG//Ds1mWEPD09Yo5xHQNtL1+PVFhNJiWKgfoi5mziH
 W
X-Google-Smtp-Source: AGHT+IG+b1AHihTh1jmoaDLT0dXGik2wwSVgw5ZQ3hIDdt4I7f4tdw1MtYWtuh8KdvVSYKX1qbuzRA==
X-Received: by 2002:a05:620a:31a2:b0:78a:5d01:dedc with SMTP id
 bi34-20020a05620a31a200b0078a5d01dedcmr5862161qkb.9.1711493006969; 
 Tue, 26 Mar 2024 15:43:26 -0700 (PDT)
Received: from n36-186-108.byted.org. ([147.160.184.146])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a05620a0ecf00b007887d30dbb7sm3397816qkm.60.2024.03.26.15.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 15:43:26 -0700 (PDT)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, yuan1.liu@intel.com,
 berrange@redhat.com, nanhai.zou@intel.com, hao.xiang@linux.dev,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v2 0/5] *** Implement using Intel QAT to offload ZLIB
Date: Tue, 26 Mar 2024 22:42:16 +0000
Message-Id: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qk1-x72c.google.com
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

Bryan Zhang (5):
  meson: Introduce 'qatzip' feature to the build system
  migration: Add migration parameters for QATzip
  migration: Introduce unimplemented 'qatzip' compression method
  migration: Implement 'qatzip' methods using QAT
  tests/migration: Add integration test for 'qatzip' compression method

 hw/core/qdev-properties-system.c |   6 +-
 meson.build                      |  10 +
 meson_options.txt                |   2 +
 migration/meson.build            |   1 +
 migration/migration-hmp-cmds.c   |   8 +
 migration/multifd-qatzip.c       | 382 +++++++++++++++++++++++++++++++
 migration/multifd.h              |   1 +
 migration/options.c              |  57 +++++
 migration/options.h              |   2 +
 qapi/migration.json              |  40 +++-
 scripts/meson-buildoptions.sh    |   3 +
 tests/qtest/meson.build          |   4 +
 tests/qtest/migration-test.c     |  35 +++
 13 files changed, 549 insertions(+), 2 deletions(-)
 create mode 100644 migration/multifd-qatzip.c

-- 
2.30.2


