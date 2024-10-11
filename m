Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99805D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4B-0000sO-1n; Fri, 11 Oct 2024 13:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1szJ45-0000hD-Am
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1szIZ1-0006Zz-39
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 12:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728664338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=omYXCqV93HCvH1u9HzwRdz1JzwFnIHjBOfnEw6OyjlY=;
 b=cuKfIOeE4xLd9XMIJf2+lZA3TE+WTUZqHWkL1lOP5/G9YEEmI7O6Ldro01J7wN7EoytiPR
 y6fM8r2FfoYLQu1ykWF1DlMggA7vThTTXsevPyEXfUSIpo5gz4pIp2VfvXln6mjCdrAZeG
 y7WLL1hWB8ZBex2q3J3M6MntUaaBQi8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-TbPZaHATNfehDrg2leQK_A-1; Fri, 11 Oct 2024 12:32:15 -0400
X-MC-Unique: TbPZaHATNfehDrg2leQK_A-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a3a6afd01eso17830365ab.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 09:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728664334; x=1729269134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omYXCqV93HCvH1u9HzwRdz1JzwFnIHjBOfnEw6OyjlY=;
 b=H17e2AtN+5kJfdEo7uPbJ0Q4Kzz3R2Zuruc2dNF+5fR8RSMRHZB8u6zWCnIbZtT81A
 9l5qILTMBVyh1K31e38Toime9Sxv/1tdzgHje8ewKl1HLLj0NP81f2YEJyMC+z5XlCMK
 47jhAob020IRo6O99mK0t2hPiBzYV91si7WWp5rPc6XG0TrmWJvizkyzDgWtMQF2hpKz
 zOc+BTsPhv2gD7uQ3U47aWd3rEZ6VNQfzGkeSHjVvghSel2b9fpHp7b/CR2xP+Gpp/he
 kJpvoUceMjJR4uwiNgDurOCJbjpmyIK/wpljNFWgFLbrJsfH1Tvty0v9/rkv8TobNXj9
 tDCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGfq7eW9ZJscLnvFnehl33uyf1DJEKLHYWb/XV7yJF4SLSY+awblr2OALDkVWgE/PGvrvv9b1uAdpe@nongnu.org
X-Gm-Message-State: AOJu0YyI/ZBU+8G75OQJaO/gvSJmEHrfbs1CtYLlmqqMXeNZR3wHMXek
 6QLiqTQyWSCBSVjIEa4EG1kfd5kcqVcfun25ojWvUBv6ZWkQcGUjWdc8cMG6zzR26wRdY5nJFTN
 ybcJH9PBr3E0EbKSza5Qf/4MOzoVtWmh1bDqTxoso8pX0qPDViFgW
X-Received: by 2002:a05:6e02:2146:b0:3a0:9244:191d with SMTP id
 e9e14a558f8ab-3a3b5fb0529mr23363685ab.16.1728664334242; 
 Fri, 11 Oct 2024 09:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV1dKDQsQgCJ9DYjBNUsfT8apS74lxWQFAefypmsXpyFGLvmFyKWGNZY4hM1WEa24ErPtd4g==
X-Received: by 2002:a05:6e02:2146:b0:3a0:9244:191d with SMTP id
 e9e14a558f8ab-3a3b5fb0529mr23363355ab.16.1728664333634; 
 Fri, 11 Oct 2024 09:32:13 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a3afde8d86sm7751725ab.78.2024.10.11.09.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 09:32:12 -0700 (PDT)
Date: Fri, 11 Oct 2024 12:32:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v6 00/12] Use Intel DSA accelerator to offload zero page
 checking in multifd live migration.
Message-ID: <ZwlTCgqjbFbJduyI@x1n>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009234610.27039-1-yichen.wang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 09, 2024 at 04:45:58PM -0700, Yichen Wang wrote:
> v6
> * Rebase on top of 838fc0a8769d7cc6edfe50451ba4e3368395f5c1;
> * Refactor code to have clean history on all commits;
> * Add comments on DSA specific defines about how the value is picked;
> * Address all comments from v5 reviews about api defines, questions, etc.;
> 
> v5
> * Rebase on top of 39a032cea23e522268519d89bb738974bc43b6f6.
> * Rename struct definitions with typedef and CamelCase names;
> * Add build and runtime checks about DSA accelerator;
> * Address all comments from v4 reviews about typos, licenses, comments,
> error reporting, etc.
> 
> v4
> * Rebase on top of 85b597413d4370cb168f711192eaef2eb70535ac.
> * A separate "multifd zero page checking" patchset was split from this
> patchset's v3 and got merged into master. v4 re-applied the rest of all
> commits on top of that patchset, re-factored and re-tested.
> https://lore.kernel.org/all/20240311180015.3359271-1-hao.xiang@linux.dev/
> * There are some feedback from v3 I likely overlooked.
> 
> v3
> * Rebase on top of 7425b6277f12e82952cede1f531bfc689bf77fb1.
> * Fix error/warning from checkpatch.pl
> * Fix use-after-free bug when multifd-dsa-accel option is not set.
> * Handle error from dsa_init and correctly propogate the error.
> * Remove unnecessary call to dsa_stop.
> * Detect availability of DSA feature at compile time.
> * Implement a generic batch_task structure and a DSA specific one dsa_batch_task.
> * Remove all exit() calls and propagate errors correctly.
> * Use bytes instead of page count to configure multifd-packet-size option.
> 
> v2
> * Rebase on top of 3e01f1147a16ca566694b97eafc941d62fa1e8d8.
> * Leave Juan's changes in their original form instead of squashing them.
> * Add a new commit to refactor the multifd_send_thread function to prepare for introducing the DSA offload functionality.
> * Use page count to configure multifd-packet-size option.
> * Don't use the FLAKY flag in DSA tests.
> * Test if DSA integration test is setup correctly and skip the test if
> * not.
> * Fixed broken link in the previous patch cover.
> 
> * Background:
> 
> I posted an RFC about DSA offloading in QEMU:
> https://patchew.org/QEMU/20230529182001.2232069-1-hao.xiang@bytedance.com/
> 
> This patchset implements the DSA offloading on zero page checking in
> multifd live migration code path.
> 
> * Overview:
> 
> Intel Data Streaming Accelerator(DSA) is introduced in Intel's 4th generation
> Xeon server, aka Sapphire Rapids.
> https://cdrdv2-public.intel.com/671116/341204-intel-data-streaming-accelerator-spec.pdf
> https://www.intel.com/content/www/us/en/content-details/759709/intel-data-streaming-accelerator-user-guide.html
> One of the things DSA can do is to offload memory comparison workload from
> CPU to DSA accelerator hardware. This patchset implements a solution to offload
> QEMU's zero page checking from CPU to DSA accelerator hardware. We gain
> two benefits from this change:
> 1. Reduces CPU usage in multifd live migration workflow across all use
> cases.
> 2. Reduces migration total time in some use cases. 
> 
> * Design:
> 
> These are the logical steps to perform DSA offloading:
> 1. Configure DSA accelerators and create user space openable DSA work
> queues via the idxd driver.
> 2. Map DSA's work queue into a user space address space.
> 3. Fill an in-memory task descriptor to describe the memory operation.
> 4. Use dedicated CPU instruction _enqcmd to queue a task descriptor to
> the work queue.
> 5. Pull the task descriptor's completion status field until the task
> completes.
> 6. Check return status.
> 
> The memory operation is now totally done by the accelerator hardware but
> the new workflow introduces overheads. The overhead is the extra cost CPU
> prepares and submits the task descriptors and the extra cost CPU pulls for
> completion. The design is around minimizing these two overheads.
> 
> 1. In order to reduce the overhead on task preparation and submission,
> we use batch descriptors. A batch descriptor will contain N individual
> zero page checking tasks where the default N is 128 (default packet size
> / page size) and we can increase N by setting the packet size via a new
> migration option.
> 2. The multifd sender threads prepares and submits batch tasks to DSA
> hardware and it waits on a synchronization object for task completion.
> Whenever a DSA task is submitted, the task structure is added to a
> thread safe queue. It's safe to have multiple multifd sender threads to
> submit tasks concurrently.
> 3. Multiple DSA hardware devices can be used. During multifd initialization,
> every sender thread will be assigned a DSA device to work with. We
> use a round-robin scheme to evenly distribute the work across all used
> DSA devices.
> 4. Use a dedicated thread dsa_completion to perform busy pulling for all
> DSA task completions. The thread keeps dequeuing DSA tasks from the
> thread safe queue. The thread blocks when there is no outstanding DSA
> task. When pulling for completion of a DSA task, the thread uses CPU
> instruction _mm_pause between the iterations of a busy loop to save some
> CPU power as well as optimizing core resources for the other hypercore.
> 5. DSA accelerator can encounter errors. The most popular error is a
> page fault. We have tested using devices to handle page faults but
> performance is bad. Right now, if DSA hits a page fault, we fallback to
> use CPU to complete the rest of the work. The CPU fallback is done in
> the multifd sender thread.
> 6. Added a new migration option multifd-dsa-accel to set the DSA device
> path. If set, the multifd workflow will leverage the DSA devices for
> offloading.
> 7. Added a new migration option multifd-normal-page-ratio to make
> multifd live migration easier to test. Setting a normal page ratio will
> make live migration recognize a zero page as a normal page and send
> the entire payload over the network. If we want to send a large network
> payload and analyze throughput, this option is useful.
> 8. Added a new migration option multifd-packet-size. This can increase
> the number of pages being zero page checked and sent over the network.
> The extra synchronization between the sender threads and the dsa
> completion thread is an overhead. Using a large packet size can reduce
> that overhead.
> 
> * Performance:
> 
> We use two Intel 4th generation Xeon servers for testing.
> 
> Architecture:        x86_64
> CPU(s):              192
> Thread(s) per core:  2
> Core(s) per socket:  48
> Socket(s):           2
> NUMA node(s):        2
> Vendor ID:           GenuineIntel
> CPU family:          6
> Model:               143
> Model name:          Intel(R) Xeon(R) Platinum 8457C
> Stepping:            8
> CPU MHz:             2538.624
> CPU max MHz:         3800.0000
> CPU min MHz:         800.0000
> 
> We perform multifd live migration with below setup:
> 1. VM has 100GB memory. 
> 2. Use the new migration option multifd-set-normal-page-ratio to control the total
> size of the payload sent over the network.

I didn't find this option.  Is it removed?

> 3. Use 8 multifd channels.
> 4. Use tcp for live migration.
> 4. Use CPU to perform zero page checking as the baseline.
> 5. Use one DSA device to offload zero page checking to compare with the baseline.
> 6. Use "perf sched record" and "perf sched timehist" to analyze CPU usage.
> 
> A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
> 
> 	CPU usage
> 
> 	|---------------|---------------|---------------|---------------|
> 	|		|comm		|runtime(msec)	|totaltime(msec)|
> 	|---------------|---------------|---------------|---------------|
> 	|Baseline	|live_migration	|5657.58	|		|
> 	|		|multifdsend_0	|3931.563	|		|
> 	|		|multifdsend_1	|4405.273	|		|
> 	|		|multifdsend_2	|3941.968	|		|
> 	|		|multifdsend_3	|5032.975	|		|
> 	|		|multifdsend_4	|4533.865	|		|
> 	|		|multifdsend_5	|4530.461	|		|
> 	|		|multifdsend_6	|5171.916	|		|
> 	|		|multifdsend_7	|4722.769	|41922		|
> 	|---------------|---------------|---------------|---------------|
> 	|DSA		|live_migration	|6129.168	|		|
> 	|		|multifdsend_0	|2954.717	|		|
> 	|		|multifdsend_1	|2766.359	|		|
> 	|		|multifdsend_2	|2853.519	|		|
> 	|		|multifdsend_3	|2740.717	|		|
> 	|		|multifdsend_4	|2824.169	|		|
> 	|		|multifdsend_5	|2966.908	|		|
> 	|		|multifdsend_6	|2611.137	|		|
> 	|		|multifdsend_7	|3114.732	|		|
> 	|		|dsa_completion	|3612.564	|32568		|
> 	|---------------|---------------|---------------|---------------|
> 
> Baseline total runtime is calculated by adding up all multifdsend_X
> and live_migration threads runtime. DSA offloading total runtime is
> calculated by adding up all multifdsend_X, live_migration and
> dsa_completion threads runtime. 41922 msec VS 32568 msec runtime and
> that is 23% total CPU usage savings.
> 
> 	Latency
> 	|---------------|---------------|---------------|---------------|---------------|---------------|
> 	|		|total time	|down time	|throughput	|transferred-ram|total-ram	|
> 	|---------------|---------------|---------------|---------------|---------------|---------------|	
> 	|Baseline	|10343 ms	|161 ms		|41007.00 mbps	|51583797 kb	|102400520 kb	|
> 	|---------------|---------------|---------------|---------------|-------------------------------|
> 	|DSA offload	|9535 ms	|135 ms		|46554.40 mbps	|53947545 kb	|102400520 kb	|	
> 	|---------------|---------------|---------------|---------------|---------------|---------------|
> 
> Total time is 8% faster and down time is 16% faster.

Is this average test results out of many, or one test?

I wonder how the total time and downtime stablizes even across runs.

> 
> B) Scenario 2: 100% (100GB) zero pages on an 100GB vm.
> 
> 	CPU usage
> 	|---------------|---------------|---------------|---------------|
> 	|		|comm		|runtime(msec)	|totaltime(msec)|
> 	|---------------|---------------|---------------|---------------|
> 	|Baseline	|live_migration	|4860.718	|		|
> 	|	 	|multifdsend_0	|748.875	|		|
> 	|		|multifdsend_1	|898.498	|		|
> 	|		|multifdsend_2	|787.456	|		|
> 	|		|multifdsend_3	|764.537	|		|
> 	|		|multifdsend_4	|785.687	|		|
> 	|		|multifdsend_5	|756.941	|		|
> 	|		|multifdsend_6	|774.084	|		|
> 	|		|multifdsend_7	|782.900	|11154		|
> 	|---------------|---------------|-------------------------------|
> 	|DSA offloading	|live_migration	|3846.976	|		|
> 	|		|multifdsend_0	|191.880	|		|
> 	|		|multifdsend_1	|166.331	|		|
> 	|		|multifdsend_2	|168.528	|		|
> 	|		|multifdsend_3	|197.831	|		|
> 	|		|multifdsend_4	|169.580	|		|
> 	|		|multifdsend_5	|167.984	|		|
> 	|		|multifdsend_6	|198.042	|		|
> 	|		|multifdsend_7	|170.624	|		|
> 	|		|dsa_completion	|3428.669	|8700		|
> 	|---------------|---------------|---------------|---------------|
> 
> Baseline total runtime is 11154 msec and DSA offloading total runtime is
> 8700 msec. That is 22% CPU savings.
> 
> 	Latency
> 	|--------------------------------------------------------------------------------------------|
> 	|		|total time	|down time	|throughput	|transferred-ram|total-ram   |
> 	|---------------|---------------|---------------|---------------|---------------|------------|	
> 	|Baseline	|4867 ms	|20 ms		|1.51 mbps	|565 kb		|102400520 kb|
> 	|---------------|---------------|---------------|---------------|----------------------------|
> 	|DSA offload	|3888 ms	|18 ms		|1.89 mbps	|565 kb		|102400520 kb|	
> 	|---------------|---------------|---------------|---------------|---------------|------------|
> 
> Total time 20% faster and down time 10% faster.
> 
> * Testing:
> 
> 1. Added unit tests for cover the added code path in dsa.c
> 2. Added integration tests to cover multifd live migration using DSA
> offloading.
> 
> 
> Hao Xiang (11):
>   meson: Introduce new instruction set enqcmd to the build system.
>   util/dsa: Implement DSA device start and stop logic.
>   util/dsa: Implement DSA task enqueue and dequeue.
>   util/dsa: Implement DSA task asynchronous completion thread model.
>   util/dsa: Implement zero page checking in DSA task.
>   util/dsa: Implement DSA task asynchronous submission and wait for
>     completion.
>   migration/multifd: Add new migration option for multifd DSA
>     offloading.
>   migration/multifd: Enable DSA offloading in multifd sender path.
>   migration/multifd: Add migration option set packet size.
>   util/dsa: Add unit test coverage for Intel DSA task submission and
>     completion.
>   migration/multifd: Add integration tests for multifd with Intel DSA
>     offloading.
> 
> Yichen Wang (1):
>   util/dsa: Add idxd into linux header copy list.
> 
>  hmp-commands.hx                 |    2 +-
>  include/qemu/dsa.h              |  189 ++++++
>  meson.build                     |   14 +
>  meson_options.txt               |    2 +
>  migration/migration-hmp-cmds.c  |   26 +-
>  migration/multifd-zero-page.c   |  133 +++-
>  migration/multifd-zlib.c        |    6 +-
>  migration/multifd-zstd.c        |    6 +-
>  migration/multifd.c             |   19 +-
>  migration/multifd.h             |    5 +
>  migration/options.c             |   69 ++
>  migration/options.h             |    2 +
>  qapi/migration.json             |   49 +-
>  scripts/meson-buildoptions.sh   |    3 +
>  scripts/update-linux-headers.sh |    2 +-
>  tests/qtest/migration-test.c    |   80 ++-
>  tests/unit/meson.build          |    6 +
>  tests/unit/test-dsa.c           |  503 ++++++++++++++
>  util/dsa.c                      | 1114 +++++++++++++++++++++++++++++++
>  util/meson.build                |    3 +
>  20 files changed, 2204 insertions(+), 29 deletions(-)
>  create mode 100644 include/qemu/dsa.h
>  create mode 100644 tests/unit/test-dsa.c
>  create mode 100644 util/dsa.c

The doc update is still missing under docs/, we may need that for a final
merge.

Are you using this in production?  How it performs in real life?  What is
the major issue to solve for you?  Is it "zero detect eats cpu too much",
or "migration too slow", or "we're doing experiment with the new hardwares,
and see how it goes if we apply it on top of migrations"?

There're a lot of new code added for dsa just for this optimization on zero
page detection.  We'd better understand the major benefits, and also
whether that's applicable to other part of qemu or migration-only.  I
actually wonder if we're going to support enqcmd whether migration is the
best starting point (rather than other places where we emulate tons of
devices, and maybe some backends can speedup IOs with enqcmd in some
form?).. but it's more of a pure question.

Thanks,

-- 
Peter Xu


