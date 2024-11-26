Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A501CD5A6DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 04:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFnQq-0007pN-J7; Mon, 25 Nov 2024 23:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tFnQo-0007ow-TE
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:44:10 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tFnQl-0006KA-EL
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:44:10 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e382589e8fdso5166449276.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 20:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1732596246; x=1733201046; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTIN97+V1Uz//gZZwqqFlAJhYf2AT1EpCeg0Ib2yDnU=;
 b=gM0LfEsP2n7hPwr366L+xXsMCFja6FSI3ZU9mzgBNaSn+vL97JetGT28BKvtMrTEAp
 MD9X4gxMC6M4+BhAzqeni6dMktI+cA858TI3ym1ALxzq/Wj7G6JMWcfnUIF6sPvtG9UF
 z8yibd5xgcPf6JIav/4W8X3kVDQNUTgkv2Ld8XNNlcq5hg16gEZu18UYh9q3KbPFzMHn
 v1wy803E19SkhkqU6JX1V2gMSAQnOZSeHOs2zTzvWJuRVBoTHpzMnbymlez7yrH6NLsv
 eHmvNXaFyB/fE1jkxuMLrc6hmmgfsiBx80G2EPlpbGHX7FBj7UXv6nte/GOiBYA4nyed
 3M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732596246; x=1733201046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KTIN97+V1Uz//gZZwqqFlAJhYf2AT1EpCeg0Ib2yDnU=;
 b=SfGIijONwKLRESt4Vu8rRufZcGMDFG3R2BfLZIXBqtRMThAFzCjN7fD66/prknQKYv
 TK+PB1jeU9dlV21yPiDUFYAi0ELxsgv94rhaUFQER7RV9KnjNdox8CTsgWvjXe9TjzH6
 9pudAUpuiN3vDyz5bJN4jPJfQvYkYZl0a2XXOU9VoXB6/KkkWIUNp+w7IbWFiFEHvurb
 ebT1CCo6Q6Jxy6DkTpYkaZThj3QVh3ENu4QIj/adNCGNkzSNAWnsneoU+PqC8vkg7n2s
 r1HTP+0QTe1MlZ84+AGu0tBWb3wecnzfaOwr4wB6Hcm30CxrZu8BKYVdIEa4AIZQ3BdU
 tCQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtMxkrVJYPI03+yNsH4mQO8meX60bWDK8tI/a9vbvnO0cL69j5h7VRoT3jATA+cK00N2PNfK9FbBDb@nongnu.org
X-Gm-Message-State: AOJu0Yz0N9Fw6qDaq/krk94kEsv5oLYd9IhXpq+oe7Y9dVw5d7g8bgp3
 IXTO9C1jT6RBZ3N5Hi2hu5YM1vNMJt2BJorIQZQxDhFGh52m4Vxr2UagWciftetbZkv+LEzljjN
 /hW2ERuta5p8T34KQd1GPiJmwGle7Z08B+PUHhQ==
X-Gm-Gg: ASbGncvun8/w2LUxUwi0pv7flmt0InKCFv8Br67IkbbxKCMnvU2w57MmoYSgCMXRIHo
 j461jrnganMTUxwIe22GYNxl/j7F6NDicv2ueEv5+D9oXHPPx0I20gp7xwtoSoNQ=
X-Google-Smtp-Source: AGHT+IEknowhA+MEPAYgoGesXbLk8D5N7w3Znem0fz7m5ugNw3xPA8GQqG8ieE/tc1E1WAkArxMOWLVKHdyXvoXDh3c=
X-Received: by 2002:a05:6902:2701:b0:e38:c0bc:811f with SMTP id
 3f1490d57ef6-e38f8b5ff11mr10797630276.31.1732596246155; Mon, 25 Nov 2024
 20:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
 <87h682syfv.fsf@suse.de>
In-Reply-To: <87h682syfv.fsf@suse.de>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Mon, 25 Nov 2024 20:43:55 -0800
Message-ID: <CAHObMVZFZ3Jg0dTk--XV2i-tMuOFwa0Lk3B9Hp3PGe6e1TK5rg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 00/12] Use Intel DSA accelerator to
 offload zero page checking in multifd live migration.
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 Shivam Kumar <shivam.kumar1@nutanix.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb30.google.com
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

On Tue, Nov 19, 2024 at 1:31=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Yichen Wang <yichen.wang@bytedance.com> writes:
>
> > v7
> > * Rebase on top of f0a5a31c33a8109061c2493e475c8a2f4d022432;
> > * Fix a bug that will crash QEMU when DSA initialization failed;
> > * Use a more generalized accel-path to support other accelerators;
> > * Remove multifd-packet-size in the parameter list;
> >
> > v6
> > * Rebase on top of 838fc0a8769d7cc6edfe50451ba4e3368395f5c1;
> > * Refactor code to have clean history on all commits;
> > * Add comments on DSA specific defines about how the value is picked;
> > * Address all comments from v5 reviews about api defines, questions, et=
c.;
> >
> > v5
> > * Rebase on top of 39a032cea23e522268519d89bb738974bc43b6f6.
> > * Rename struct definitions with typedef and CamelCase names;
> > * Add build and runtime checks about DSA accelerator;
> > * Address all comments from v4 reviews about typos, licenses, comments,
> > error reporting, etc.
> >
> > v4
> > * Rebase on top of 85b597413d4370cb168f711192eaef2eb70535ac.
> > * A separate "multifd zero page checking" patchset was split from this
> > patchset's v3 and got merged into master. v4 re-applied the rest of all
> > commits on top of that patchset, re-factored and re-tested.
> > https://lore.kernel.org/all/20240311180015.3359271-1-hao.xiang@linux.de=
v/
> > * There are some feedback from v3 I likely overlooked.
> >
> > v3
> > * Rebase on top of 7425b6277f12e82952cede1f531bfc689bf77fb1.
> > * Fix error/warning from checkpatch.pl
> > * Fix use-after-free bug when multifd-dsa-accel option is not set.
> > * Handle error from dsa_init and correctly propogate the error.
> > * Remove unnecessary call to dsa_stop.
> > * Detect availability of DSA feature at compile time.
> > * Implement a generic batch_task structure and a DSA specific one dsa_b=
atch_task.
> > * Remove all exit() calls and propagate errors correctly.
> > * Use bytes instead of page count to configure multifd-packet-size opti=
on.
> >
> > v2
> > * Rebase on top of 3e01f1147a16ca566694b97eafc941d62fa1e8d8.
> > * Leave Juan's changes in their original form instead of squashing them=
.
> > * Add a new commit to refactor the multifd_send_thread function to prep=
are for introducing the DSA offload functionality.
> > * Use page count to configure multifd-packet-size option.
> > * Don't use the FLAKY flag in DSA tests.
> > * Test if DSA integration test is setup correctly and skip the test if
> > * not.
> > * Fixed broken link in the previous patch cover.
> >
> > * Background:
> >
> > I posted an RFC about DSA offloading in QEMU:
> > https://patchew.org/QEMU/20230529182001.2232069-1-hao.xiang@bytedance.c=
om/
> >
> > This patchset implements the DSA offloading on zero page checking in
> > multifd live migration code path.
> >
> > * Overview:
> >
> > Intel Data Streaming Accelerator(DSA) is introduced in Intel's 4th gene=
ration
> > Xeon server, aka Sapphire Rapids.
> > https://cdrdv2-public.intel.com/671116/341204-intel-data-streaming-acce=
lerator-spec.pdf
> > https://www.intel.com/content/www/us/en/content-details/759709/intel-da=
ta-streaming-accelerator-user-guide.html
> > One of the things DSA can do is to offload memory comparison workload f=
rom
> > CPU to DSA accelerator hardware. This patchset implements a solution to=
 offload
> > QEMU's zero page checking from CPU to DSA accelerator hardware. We gain
> > two benefits from this change:
> > 1. Reduces CPU usage in multifd live migration workflow across all use
> > cases.
> > 2. Reduces migration total time in some use cases.
> >
> > * Design:
> >
> > These are the logical steps to perform DSA offloading:
> > 1. Configure DSA accelerators and create user space openable DSA work
> > queues via the idxd driver.
> > 2. Map DSA's work queue into a user space address space.
> > 3. Fill an in-memory task descriptor to describe the memory operation.
> > 4. Use dedicated CPU instruction _enqcmd to queue a task descriptor to
> > the work queue.
> > 5. Pull the task descriptor's completion status field until the task
> > completes.
> > 6. Check return status.
> >
> > The memory operation is now totally done by the accelerator hardware bu=
t
> > the new workflow introduces overheads. The overhead is the extra cost C=
PU
> > prepares and submits the task descriptors and the extra cost CPU pulls =
for
> > completion. The design is around minimizing these two overheads.
> >
> > 1. In order to reduce the overhead on task preparation and submission,
> > we use batch descriptors. A batch descriptor will contain N individual
> > zero page checking tasks where the default N is 128 (default packet siz=
e
> > / page size) and we can increase N by setting the packet size via a new
> > migration option.
> > 2. The multifd sender threads prepares and submits batch tasks to DSA
> > hardware and it waits on a synchronization object for task completion.
> > Whenever a DSA task is submitted, the task structure is added to a
> > thread safe queue. It's safe to have multiple multifd sender threads to
> > submit tasks concurrently.
> > 3. Multiple DSA hardware devices can be used. During multifd initializa=
tion,
> > every sender thread will be assigned a DSA device to work with. We
> > use a round-robin scheme to evenly distribute the work across all used
> > DSA devices.
> > 4. Use a dedicated thread dsa_completion to perform busy pulling for al=
l
> > DSA task completions. The thread keeps dequeuing DSA tasks from the
> > thread safe queue. The thread blocks when there is no outstanding DSA
> > task. When pulling for completion of a DSA task, the thread uses CPU
> > instruction _mm_pause between the iterations of a busy loop to save som=
e
> > CPU power as well as optimizing core resources for the other hypercore.
> > 5. DSA accelerator can encounter errors. The most popular error is a
> > page fault. We have tested using devices to handle page faults but
> > performance is bad. Right now, if DSA hits a page fault, we fallback to
> > use CPU to complete the rest of the work. The CPU fallback is done in
> > the multifd sender thread.
> > 6. Added a new migration option multifd-dsa-accel to set the DSA device
> > path. If set, the multifd workflow will leverage the DSA devices for
> > offloading.
> > 7. Added a new migration option multifd-normal-page-ratio to make
> > multifd live migration easier to test. Setting a normal page ratio will
> > make live migration recognize a zero page as a normal page and send
> > the entire payload over the network. If we want to send a large network
> > payload and analyze throughput, this option is useful.
> > 8. Added a new migration option multifd-packet-size. This can increase
> > the number of pages being zero page checked and sent over the network.
> > The extra synchronization between the sender threads and the dsa
> > completion thread is an overhead. Using a large packet size can reduce
> > that overhead.
> >
> > * Performance:
> >
> > We use two Intel 4th generation Xeon servers for testing.
> >
> > Architecture:        x86_64
> > CPU(s):              192
> > Thread(s) per core:  2
> > Core(s) per socket:  48
> > Socket(s):           2
> > NUMA node(s):        2
> > Vendor ID:           GenuineIntel
> > CPU family:          6
> > Model:               143
> > Model name:          Intel(R) Xeon(R) Platinum 8457C
> > Stepping:            8
> > CPU MHz:             2538.624
> > CPU max MHz:         3800.0000
> > CPU min MHz:         800.0000
> >
> > We perform multifd live migration with below setup:
> > 1. VM has 100GB memory.
> > 2. Use the new migration option multifd-set-normal-page-ratio to contro=
l the total
> > size of the payload sent over the network.
> > 3. Use 8 multifd channels.
> > 4. Use tcp for live migration.
> > 4. Use CPU to perform zero page checking as the baseline.
> > 5. Use one DSA device to offload zero page checking to compare with the=
 baseline.
> > 6. Use "perf sched record" and "perf sched timehist" to analyze CPU usa=
ge.
> >
> > A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
> >
> >       CPU usage
> >
> >       |---------------|---------------|---------------|---------------|
> >       |               |comm           |runtime(msec)  |totaltime(msec)|
> >       |---------------|---------------|---------------|---------------|
> >       |Baseline       |live_migration |5657.58        |               |
> >       |               |multifdsend_0  |3931.563       |               |
> >       |               |multifdsend_1  |4405.273       |               |
> >       |               |multifdsend_2  |3941.968       |               |
> >       |               |multifdsend_3  |5032.975       |               |
> >       |               |multifdsend_4  |4533.865       |               |
> >       |               |multifdsend_5  |4530.461       |               |
> >       |               |multifdsend_6  |5171.916       |               |
> >       |               |multifdsend_7  |4722.769       |41922          |
> >       |---------------|---------------|---------------|---------------|
> >       |DSA            |live_migration |6129.168       |               |
> >       |               |multifdsend_0  |2954.717       |               |
> >       |               |multifdsend_1  |2766.359       |               |
> >       |               |multifdsend_2  |2853.519       |               |
> >       |               |multifdsend_3  |2740.717       |               |
> >       |               |multifdsend_4  |2824.169       |               |
> >       |               |multifdsend_5  |2966.908       |               |
> >       |               |multifdsend_6  |2611.137       |               |
> >       |               |multifdsend_7  |3114.732       |               |
> >       |               |dsa_completion |3612.564       |32568          |
> >       |---------------|---------------|---------------|---------------|
> >
> > Baseline total runtime is calculated by adding up all multifdsend_X
> > and live_migration threads runtime. DSA offloading total runtime is
> > calculated by adding up all multifdsend_X, live_migration and
> > dsa_completion threads runtime. 41922 msec VS 32568 msec runtime and
> > that is 23% total CPU usage savings.
> >
> >       Latency
> >       |---------------|---------------|---------------|---------------|=
---------------|---------------|
> >       |               |total time     |down time      |throughput     |=
transferred-ram|total-ram      |
> >       |---------------|---------------|---------------|---------------|=
---------------|---------------|
> >       |Baseline       |10343 ms       |161 ms         |41007.00 mbps  |=
51583797 kb    |102400520 kb   |
> >       |---------------|---------------|---------------|---------------|=
-------------------------------|
> >       |DSA offload    |9535 ms        |135 ms         |46554.40 mbps  |=
53947545 kb    |102400520 kb   |
> >       |---------------|---------------|---------------|---------------|=
---------------|---------------|
> >
> > Total time is 8% faster and down time is 16% faster.
> >
> > B) Scenario 2: 100% (100GB) zero pages on an 100GB vm.
> >
> >       CPU usage
> >       |---------------|---------------|---------------|---------------|
> >       |               |comm           |runtime(msec)  |totaltime(msec)|
> >       |---------------|---------------|---------------|---------------|
> >       |Baseline       |live_migration |4860.718       |               |
> >       |               |multifdsend_0  |748.875        |               |
> >       |               |multifdsend_1  |898.498        |               |
> >       |               |multifdsend_2  |787.456        |               |
> >       |               |multifdsend_3  |764.537        |               |
> >       |               |multifdsend_4  |785.687        |               |
> >       |               |multifdsend_5  |756.941        |               |
> >       |               |multifdsend_6  |774.084        |               |
> >       |               |multifdsend_7  |782.900        |11154          |
> >       |---------------|---------------|-------------------------------|
> >       |DSA offloading |live_migration |3846.976       |               |
> >       |               |multifdsend_0  |191.880        |               |
> >       |               |multifdsend_1  |166.331        |               |
> >       |               |multifdsend_2  |168.528        |               |
> >       |               |multifdsend_3  |197.831        |               |
> >       |               |multifdsend_4  |169.580        |               |
> >       |               |multifdsend_5  |167.984        |               |
> >       |               |multifdsend_6  |198.042        |               |
> >       |               |multifdsend_7  |170.624        |               |
> >       |               |dsa_completion |3428.669       |8700           |
> >       |---------------|---------------|---------------|---------------|
> >
> > Baseline total runtime is 11154 msec and DSA offloading total runtime i=
s
> > 8700 msec. That is 22% CPU savings.
> >
> >       Latency
> >       |----------------------------------------------------------------=
----------------------------|
> >       |               |total time     |down time      |throughput     |=
transferred-ram|total-ram   |
> >       |---------------|---------------|---------------|---------------|=
---------------|------------|
> >       |Baseline       |4867 ms        |20 ms          |1.51 mbps      |=
565 kb         |102400520 kb|
> >       |---------------|---------------|---------------|---------------|=
----------------------------|
> >       |DSA offload    |3888 ms        |18 ms          |1.89 mbps      |=
565 kb         |102400520 kb|
> >       |---------------|---------------|---------------|---------------|=
---------------|------------|
> >
> > Total time 20% faster and down time 10% faster.
> >
> > * Testing:
> >
> > 1. Added unit tests for cover the added code path in dsa.c
> > 2. Added integration tests to cover multifd live migration using DSA
> > offloading.
> >
> > Hao Xiang (10):
> >   meson: Introduce new instruction set enqcmd to the build system.
> >   util/dsa: Implement DSA device start and stop logic.
> >   util/dsa: Implement DSA task enqueue and dequeue.
> >   util/dsa: Implement DSA task asynchronous completion thread model.
> >   util/dsa: Implement zero page checking in DSA task.
> >   util/dsa: Implement DSA task asynchronous submission and wait for
> >     completion.
> >   migration/multifd: Add new migration option for multifd DSA
> >     offloading.
> >   migration/multifd: Enable DSA offloading in multifd sender path.
> >   util/dsa: Add unit test coverage for Intel DSA task submission and
> >     completion.
> >   migration/multifd: Add integration tests for multifd with Intel DSA
> >     offloading.
> >
> > Yichen Wang (1):
> >   util/dsa: Add idxd into linux header copy list.
> >
> > Yuan Liu (1):
> >   migration/doc: Add DSA zero page detection doc
> >
> >  .../migration/dsa-zero-page-detection.rst     |  290 +++++
> >  docs/devel/migration/features.rst             |    1 +
> >  hmp-commands.hx                               |    2 +-
> >  include/qemu/dsa.h                            |  188 +++
> >  meson.build                                   |   14 +
> >  meson_options.txt                             |    2 +
> >  migration/migration-hmp-cmds.c                |   19 +-
> >  migration/multifd-zero-page.c                 |  129 +-
> >  migration/multifd.c                           |   29 +-
> >  migration/multifd.h                           |    5 +
> >  migration/options.c                           |   30 +
> >  migration/options.h                           |    1 +
> >  qapi/migration.json                           |   32 +-
> >  scripts/meson-buildoptions.sh                 |    3 +
> >  scripts/update-linux-headers.sh               |    2 +-
> >  tests/qtest/migration-test.c                  |   80 +-
> >  tests/unit/meson.build                        |    6 +
> >  tests/unit/test-dsa.c                         |  503 ++++++++
> >  util/dsa.c                                    | 1112 +++++++++++++++++
> >  util/meson.build                              |    3 +
> >  20 files changed, 2427 insertions(+), 24 deletions(-)
> >  create mode 100644 docs/devel/migration/dsa-zero-page-detection.rst
> >  create mode 100644 include/qemu/dsa.h
> >  create mode 100644 tests/unit/test-dsa.c
> >  create mode 100644 util/dsa.c
>
> Hi, take a look at make check, there are some tests failing.
>
> Summary of Failures:
>
>  16/474 qemu:qtest+qtest-x86_64 / qtest-x86_64/test-hmp                  =
   ERROR            0.86s   killed by signal 6 SIGABRT
>  18/474 qemu:qtest+qtest-ppc64 / qtest-ppc64/test-hmp                    =
   ERROR            0.93s   killed by signal 6 SIGABRT
>  20/474 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp                =
   ERROR            1.30s   killed by signal 6 SIGABRT
>  21/474 qemu:qtest+qtest-s390x / qtest-s390x/test-hmp                    =
   ERROR            0.76s   killed by signal 6 SIGABRT
>  22/474 qemu:qtest+qtest-riscv64 / qtest-riscv64/test-hmp                =
   ERROR            0.60s   killed by signal 6 SIGABRT
>
> Looks like a double-free due to glib autofree. Here's one sample:
>
> #0  __GI_abort () at abort.c:49
> #1  0x00007ffff5899c87 in __libc_message (action=3Ddo_abort, fmt=3D0x7fff=
f59c3138 "%s\n") at ../sysdeps/posix/libc_fatal.c:155
> #2  0x00007ffff58a1d2a in malloc_printerr (str=3D0x7ffff59c0e0e "free(): =
invalid pointer") at malloc.c:5347
> #3  0x00007ffff58a37d4 in _int_free (av=3D<optimized out>, p=3D<optimized=
 out>, have_lock=3D0) at malloc.c:4173
> #4  0x00007ffff78c5639 in g_free (mem=3D0x5555561200f1 <qemu_mutex_unlock=
_impl+96>) at ../glib/gmem.c:199
> #5  0x0000555555bdd527 in g_autoptr_cleanup_generic_gfree (p=3D0x7fffffff=
d568) at /usr/include/glib-2.0/glib/glib-autocleanups.h:28
> #6  0x0000555555bdfabc in hmp_migrate_set_parameter (mon=3D0x7fffffffd6f0=
, qdict=3D0x555558554560) at ../migration/migration-hmp-cmds.c:577
> #7  0x0000555555c1a231 in handle_hmp_command_exec (mon=3D0x7fffffffd6f0, =
cmd=3D0x5555571e7450 <hmp_cmds+4560>, qdict=3D0x555558554560) at ../monitor=
/hmp.c:1106
> #8  0x0000555555c1a470 in handle_hmp_command (mon=3D0x7fffffffd6f0, cmdli=
ne=3D0x5555577ec2f6 "xbzrle-cache-size 64k") at ../monitor/hmp.c:1158
> #9  0x0000555555c1c40e in qmp_human_monitor_command (command_line=3D0x555=
5577ec2e0 "migrate_set_parameter xbzrle-cache-size 64k", has_cpu_index=3Dfa=
lse, cpu_index=3D0, errp=3D0x7fffffffd800)
>     at ../monitor/qmp-cmds.c:181
> #10 0x00005555560c7eb6 in qmp_marshal_human_monitor_command (args=3D0x7ff=
fe000ac00, ret=3D0x7ffff4d25da8, errp=3D0x7ffff4d25da0) at qapi/qapi-comman=
ds-misc.c:347
> #11 0x000055555610e7a4 in do_qmp_dispatch_bh (opaque=3D0x7ffff4d25e40) at=
 ../qapi/qmp-dispatch.c:128
> #12 0x000055555613a1b9 in aio_bh_call (bh=3D0x7fffe0004050) at ../util/as=
ync.c:172
> #13 0x000055555613a2d5 in aio_bh_poll (ctx=3D0x5555573df400) at ../util/a=
sync.c:219
> #14 0x000055555611b8cd in aio_dispatch (ctx=3D0x5555573df400) at ../util/=
aio-posix.c:424
> #15 0x000055555613a712 in aio_ctx_dispatch (source=3D0x5555573df400, call=
back=3D0x0, user_data=3D0x0) at ../util/async.c:361
> #16 0x00007ffff78bf82b in g_main_dispatch (context=3D0x5555573e3440) at .=
./glib/gmain.c:3381
> #17 g_main_context_dispatch (context=3D0x5555573e3440) at ../glib/gmain.c=
:4099
> #18 0x000055555613bdae in glib_pollfds_poll () at ../util/main-loop.c:287
> #19 0x000055555613be28 in os_host_main_loop_wait (timeout=3D0) at ../util=
/main-loop.c:310
> #20 0x000055555613bf2d in main_loop_wait (nonblocking=3D0) at ../util/mai=
n-loop.c:589
> #21 0x0000555555bb455c in qemu_main_loop () at ../system/runstate.c:835
> #22 0x00005555560594d1 in qemu_default_main () at ../system/main.c:37
> #23 0x000055555605950c in main (argc=3D18, argv=3D0x7fffffffdc18) at ../s=
ystem/main.c:48

Fixed. Interesting that our marco of g_auto(GStrv) won't work in
switch-case statements. I switched back to original char
**/g_strfreev() to get it working.

