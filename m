Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B894C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1io-00042l-SL; Thu, 11 Jul 2024 17:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1in-0003xI-9f
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:01 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1if-0005Xv-M4
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:01 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-708b273b437so520246a34.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720734769; x=1721339569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mxH2A24Ym3kg+GFcndvj6BhJts5bI5dxxgMILelUHgw=;
 b=JBWYoU1RZuNFSb6C88pqt0Qz3GTIUpvhc+vRdf5AF+t4InvvViXRAK47DJbNQfOkdC
 lIaaYwMcl+a2Xu4HrBafX5cXf/wWX8xAgiTC14xI2Tkfdovry4NO5vaTwWHuTBIxMLT/
 M8FS6j6GiEKcF9IGKFZbpKabPTqs2Ic/gmRuEwiUTXU+QTig4CPV/DDNl7hAMkkhuBX9
 OtiVZUdI32mpc9pujtO3e3lC04lhm2yiieOA6Xd7/bDC8CODE2588R3mBSpTWkLnOau7
 NhQOEnNgoQY0PLiLOWxvD76R66twIW0UCx7Sn7PXpKoPlAjdRTB67spRZKa8ysYaZUVp
 4YbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720734769; x=1721339569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mxH2A24Ym3kg+GFcndvj6BhJts5bI5dxxgMILelUHgw=;
 b=iQrOoAzcPhfmQ1GSPh7Hc/h7sGYAD70f63tbZREBIcMViYsF1ZQYggJyDU2+65nsPF
 bAJ/YoUleovXOk8XNY/U0tIzTEkjjt8giqkLxH5hq83onNyyaDYGzk7ZmMUMlojQUGJ6
 HknBTXDgqC+dt5/80ZsTARYbd2WMdFp0JrciuL68ssJLGWm+Q0YbiJcuONlcA+EgeNy4
 Q/uFPIa8PJ39TCdtDEng4WI9lax1WSzilDMOZ5eF0+Iu9Ouc/SbYPpbjgGyCS6ZzTk1M
 9/kvgiv2k1P7GyOzKfXECSJ/uCt+VXHBqW5aAWfQj2Z1TH8Tnqc24DBJ0mBfj+rzyuDO
 PY0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmzdQ4NNKZfprIOOthDeXTj0bqW0Pr3Xdg1l9jM9OyPQla+/Tn1kz6YZ8E/WOdO0PdSDzBxmfjuxEd1kDw1uo72dCN3GY=
X-Gm-Message-State: AOJu0Yy2EzBTLYYa1qFpkurGP2hflUn3qhm4ZZJ2dhO83SZVg3DoJ2pg
 H/vi4lYb6ASOFlG3E390ydwR8OgWjw6cOSBkXCxl8pMEOwIyfm4wj5OUI2vgMoA=
X-Google-Smtp-Source: AGHT+IHuozkurOEl94ZmRV+/bYfbgfEmJFwOTQyPKVYvoWa1IpzLA7x9XqhwgVP8izX9DjcXMMV4Mg==
X-Received: by 2002:a05:6830:349e:b0:708:b26f:e898 with SMTP id
 46e09a7af769-708b26fea45mr2770612a34.27.1720734769053; 
 Thu, 11 Jul 2024 14:52:49 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7044ac2876dsm713125a34.2.2024.07.11.14.52.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 14:52:48 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload zero page
 checking in multifd live migration.
Date: Thu, 11 Jul 2024 14:52:35 -0700
Message-Id: <20240711215244.19237-1-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=yichen.wang@bytedance.com; helo=mail-ot1-x336.google.com
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

v5
* Rebase on top of 39a032cea23e522268519d89bb738974bc43b6f6.
* Rename struct definitions with typedef and CamelCase names;
* Add build and runtime checks about DSA accelerator;
* Address all comments from v4 reviews about typos, licenses, comments,
error reporting, etc.

v4
* Rebase on top of 85b597413d4370cb168f711192eaef2eb70535ac.
* A separate "multifd zero page checking" patchset was split from this
patchset's v3 and got merged into master. v4 re-applied the rest of all
commits on top of that patchset, re-factored and re-tested.
https://lore.kernel.org/all/20240311180015.3359271-1-hao.xiang@linux.dev/
* There are some feedback from v3 I likely overlooked.
 
v3
* Rebase on top of 7425b6277f12e82952cede1f531bfc689bf77fb1.
* Fix error/warning from checkpatch.pl
* Fix use-after-free bug when multifd-dsa-accel option is not set.
* Handle error from dsa_init and correctly propogate the error.
* Remove unnecessary call to dsa_stop.
* Detect availability of DSA feature at compile time.
* Implement a generic batch_task structure and a DSA specific one dsa_batch_task.
* Remove all exit() calls and propagate errors correctly.
* Use bytes instead of page count to configure multifd-packet-size option.

v2
* Rebase on top of 3e01f1147a16ca566694b97eafc941d62fa1e8d8.
* Leave Juan's changes in their original form instead of squashing them.
* Add a new commit to refactor the multifd_send_thread function to prepare for introducing the DSA offload functionality.
* Use page count to configure multifd-packet-size option.
* Don't use the FLAKY flag in DSA tests.
* Test if DSA integration test is setup correctly and skip the test if
* not.
* Fixed broken link in the previous patch cover.

* Background:

I posted an RFC about DSA offloading in QEMU:
https://patchew.org/QEMU/20230529182001.2232069-1-hao.xiang@bytedance.com/

This patchset implements the DSA offloading on zero page checking in
multifd live migration code path.

* Overview:

Intel Data Streaming Accelerator(DSA) is introduced in Intel's 4th generation
Xeon server, aka Sapphire Rapids.
https://cdrdv2-public.intel.com/671116/341204-intel-data-streaming-accelerator-spec.pdf
https://www.intel.com/content/www/us/en/content-details/759709/intel-data-streaming-accelerator-user-guide.html
One of the things DSA can do is to offload memory comparison workload from
CPU to DSA accelerator hardware. This patchset implements a solution to offload
QEMU's zero page checking from CPU to DSA accelerator hardware. We gain
two benefits from this change:
1. Reduces CPU usage in multifd live migration workflow across all use
cases.
2. Reduces migration total time in some use cases. 

* Design:

These are the logical steps to perform DSA offloading:
1. Configure DSA accelerators and create user space openable DSA work
queues via the idxd driver.
2. Map DSA's work queue into a user space address space.
3. Fill an in-memory task descriptor to describe the memory operation.
4. Use dedicated CPU instruction _enqcmd to queue a task descriptor to
the work queue.
5. Pull the task descriptor's completion status field until the task
completes.
6. Check return status.

The memory operation is now totally done by the accelerator hardware but
the new workflow introduces overheads. The overhead is the extra cost CPU
prepares and submits the task descriptors and the extra cost CPU pulls for
completion. The design is around minimizing these two overheads.

1. In order to reduce the overhead on task preparation and submission,
we use batch descriptors. A batch descriptor will contain N individual
zero page checking tasks where the default N is 128 (default packet size
/ page size) and we can increase N by setting the packet size via a new
migration option.
2. The multifd sender threads prepares and submits batch tasks to DSA
hardware and it waits on a synchronization object for task completion.
Whenever a DSA task is submitted, the task structure is added to a
thread safe queue. It's safe to have multiple multifd sender threads to
submit tasks concurrently.
3. Multiple DSA hardware devices can be used. During multifd initialization,
every sender thread will be assigned a DSA device to work with. We
use a round-robin scheme to evenly distribute the work across all used
DSA devices.
4. Use a dedicated thread dsa_completion to perform busy pulling for all
DSA task completions. The thread keeps dequeuing DSA tasks from the
thread safe queue. The thread blocks when there is no outstanding DSA
task. When pulling for completion of a DSA task, the thread uses CPU
instruction _mm_pause between the iterations of a busy loop to save some
CPU power as well as optimizing core resources for the other hypercore.
5. DSA accelerator can encounter errors. The most popular error is a
page fault. We have tested using devices to handle page faults but
performance is bad. Right now, if DSA hits a page fault, we fallback to
use CPU to complete the rest of the work. The CPU fallback is done in
the multifd sender thread.
6. Added a new migration option multifd-dsa-accel to set the DSA device
path. If set, the multifd workflow will leverage the DSA devices for
offloading.
7. Added a new migration option multifd-normal-page-ratio to make
multifd live migration easier to test. Setting a normal page ratio will
make live migration recognize a zero page as a normal page and send
the entire payload over the network. If we want to send a large network
payload and analyze throughput, this option is useful.
8. Added a new migration option multifd-packet-size. This can increase
the number of pages being zero page checked and sent over the network.
The extra synchronization between the sender threads and the dsa
completion thread is an overhead. Using a large packet size can reduce
that overhead.

* Performance:

We use two Intel 4th generation Xeon servers for testing.

Architecture:        x86_64
CPU(s):              192
Thread(s) per core:  2
Core(s) per socket:  48
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               143
Model name:          Intel(R) Xeon(R) Platinum 8457C
Stepping:            8
CPU MHz:             2538.624
CPU max MHz:         3800.0000
CPU min MHz:         800.0000

We perform multifd live migration with below setup:
1. VM has 100GB memory. 
2. Use the new migration option multifd-set-normal-page-ratio to control the total
size of the payload sent over the network.
3. Use 8 multifd channels.
4. Use tcp for live migration.
4. Use CPU to perform zero page checking as the baseline.
5. Use one DSA device to offload zero page checking to compare with the baseline.
6. Use "perf sched record" and "perf sched timehist" to analyze CPU usage.

A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.

	CPU usage

	|---------------|---------------|---------------|---------------|
	|		|comm		|runtime(msec)	|totaltime(msec)|
	|---------------|---------------|---------------|---------------|
	|Baseline	|live_migration	|5657.58	|		|
	|		|multifdsend_0	|3931.563	|		|
	|		|multifdsend_1	|4405.273	|		|
	|		|multifdsend_2	|3941.968	|		|
	|		|multifdsend_3	|5032.975	|		|
	|		|multifdsend_4	|4533.865	|		|
	|		|multifdsend_5	|4530.461	|		|
	|		|multifdsend_6	|5171.916	|		|
	|		|multifdsend_7	|4722.769	|41922		|
	|---------------|---------------|---------------|---------------|
	|DSA		|live_migration	|6129.168	|		|
	|		|multifdsend_0	|2954.717	|		|
	|		|multifdsend_1	|2766.359	|		|
	|		|multifdsend_2	|2853.519	|		|
	|		|multifdsend_3	|2740.717	|		|
	|		|multifdsend_4	|2824.169	|		|
	|		|multifdsend_5	|2966.908	|		|
	|		|multifdsend_6	|2611.137	|		|
	|		|multifdsend_7	|3114.732	|		|
	|		|dsa_completion	|3612.564	|32568		|
	|---------------|---------------|---------------|---------------|

Baseline total runtime is calculated by adding up all multifdsend_X
and live_migration threads runtime. DSA offloading total runtime is
calculated by adding up all multifdsend_X, live_migration and
dsa_completion threads runtime. 41922 msec VS 32568 msec runtime and
that is 23% total CPU usage savings.

	Latency
	|---------------|---------------|---------------|---------------|---------------|---------------|
	|		|total time	|down time	|throughput	|transferred-ram|total-ram	|
	|---------------|---------------|---------------|---------------|---------------|---------------|	
	|Baseline	|10343 ms	|161 ms		|41007.00 mbps	|51583797 kb	|102400520 kb	|
	|---------------|---------------|---------------|---------------|-------------------------------|
	|DSA offload	|9535 ms	|135 ms		|46554.40 mbps	|53947545 kb	|102400520 kb	|	
	|---------------|---------------|---------------|---------------|---------------|---------------|

Total time is 8% faster and down time is 16% faster.

B) Scenario 2: 100% (100GB) zero pages on an 100GB vm.

	CPU usage
	|---------------|---------------|---------------|---------------|
	|		|comm		|runtime(msec)	|totaltime(msec)|
	|---------------|---------------|---------------|---------------|
	|Baseline	|live_migration	|4860.718	|		|
	|	 	|multifdsend_0	|748.875	|		|
	|		|multifdsend_1	|898.498	|		|
	|		|multifdsend_2	|787.456	|		|
	|		|multifdsend_3	|764.537	|		|
	|		|multifdsend_4	|785.687	|		|
	|		|multifdsend_5	|756.941	|		|
	|		|multifdsend_6	|774.084	|		|
	|		|multifdsend_7	|782.900	|11154		|
	|---------------|---------------|-------------------------------|
	|DSA offloading	|live_migration	|3846.976	|		|
	|		|multifdsend_0	|191.880	|		|
	|		|multifdsend_1	|166.331	|		|
	|		|multifdsend_2	|168.528	|		|
	|		|multifdsend_3	|197.831	|		|
	|		|multifdsend_4	|169.580	|		|
	|		|multifdsend_5	|167.984	|		|
	|		|multifdsend_6	|198.042	|		|
	|		|multifdsend_7	|170.624	|		|
	|		|dsa_completion	|3428.669	|8700		|
	|---------------|---------------|---------------|---------------|

Baseline total runtime is 11154 msec and DSA offloading total runtime is
8700 msec. That is 22% CPU savings.

	Latency
	|--------------------------------------------------------------------------------------------|
	|		|total time	|down time	|throughput	|transferred-ram|total-ram   |
	|---------------|---------------|---------------|---------------|---------------|------------|	
	|Baseline	|4867 ms	|20 ms		|1.51 mbps	|565 kb		|102400520 kb|
	|---------------|---------------|---------------|---------------|----------------------------|
	|DSA offload	|3888 ms	|18 ms		|1.89 mbps	|565 kb		|102400520 kb|	
	|---------------|---------------|---------------|---------------|---------------|------------|

Total time 20% faster and down time 10% faster.

* Testing:

1. Added unit tests for cover the added code path in dsa.c
2. Added integration tests to cover multifd live migration using DSA
offloading.

Hao Xiang (12):
  meson: Introduce new instruction set enqcmd to the build system.
  util/dsa: Implement DSA device start and stop logic.
  util/dsa: Implement DSA task enqueue and dequeue.
  util/dsa: Implement DSA task asynchronous completion thread model.
  util/dsa: Implement zero page checking in DSA task.
  util/dsa: Implement DSA task asynchronous submission and wait for
    completion.
  migration/multifd: Add new migration option for multifd DSA
    offloading.
  migration/multifd: Prepare to introduce DSA acceleration on the
    multifd path.
  migration/multifd: Enable DSA offloading in multifd sender path.
  migration/multifd: Add migration option set packet size.
  util/dsa: Add unit test coverage for Intel DSA task submission and
    completion.
  migration/multifd: Add integration tests for multifd with Intel DSA
    offloading.

Yichen Wang (1):
  util/dsa: Add idxd into linux header copy list.

 include/qemu/dsa.h              |  176 +++++
 meson.build                     |   14 +
 meson_options.txt               |    2 +
 migration/migration-hmp-cmds.c  |   22 +-
 migration/migration.c           |    2 +-
 migration/multifd-zero-page.c   |  100 ++-
 migration/multifd-zlib.c        |    6 +-
 migration/multifd-zstd.c        |    6 +-
 migration/multifd.c             |   53 +-
 migration/multifd.h             |    8 +-
 migration/options.c             |   85 +++
 migration/options.h             |    2 +
 qapi/migration.json             |   49 +-
 scripts/meson-buildoptions.sh   |    3 +
 scripts/update-linux-headers.sh |    2 +-
 tests/qtest/migration-test.c    |   80 ++-
 tests/unit/meson.build          |    6 +
 tests/unit/test-dsa.c           |  503 ++++++++++++++
 util/dsa.c                      | 1082 +++++++++++++++++++++++++++++++
 util/meson.build                |    3 +
 20 files changed, 2177 insertions(+), 27 deletions(-)
 create mode 100644 include/qemu/dsa.h
 create mode 100644 tests/unit/test-dsa.c
 create mode 100644 util/dsa.c

-- 
Yichen Wang


