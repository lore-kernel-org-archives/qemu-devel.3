Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B883C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 02:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnUVd-0003Et-3T; Thu, 21 Mar 2024 22:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuanzhuo@linux.alibaba.com>)
 id 1rnUVW-0003Cy-7l
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 22:19:47 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuanzhuo@linux.alibaba.com>)
 id 1rnUVT-0000Qi-BN
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 22:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1711073974; h=Message-ID:Subject:Date:From:To;
 bh=6pvpAnqETsbH20ThPLh6n4JhiO4yxofv2lFAzumWOPM=;
 b=H60mit9owEBaLJaoOFZSGyQVOLbzCW4totc7Dbx7P1K2qU09sSeNFD8U4ypvOsiTiLuSaMKstBjvwvw1e8W/YgZRaZE7O8hODUL7TVwKaBQzq4uv45AiVbp5HWrTLoE/Cv8H8ax8cdNpsgjVTcX3sjveGbZPlPpqCMeqOg/q2S4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0W30SD.o_1711073972; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0W30SD.o_1711073972) by smtp.aliyun-inc.com;
 Fri, 22 Mar 2024 10:19:33 +0800
Message-ID: <1711073849.8330412-2-xuanzhuo@linux.alibaba.com>
Subject: Re: qemu fuzz crash in virtio_net_queue_reset()
Date: Fri, 22 Mar 2024 10:17:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>
Cc: "qemu-devel" <qemu-devel@nongnu.org>, alxndr@bu.edu,
 Paolo Bonzini <pbonzini@redhat.com>, bsd@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 darren.kenny@oracle.com, Qiuhao.Li@outlook.com, si-wei.liu@oracle.com,
 yc-core@yandex-team.ru, Denis Plotnikov <den-plotnikov@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 kangjie.xu@linux.alibaba.com
References: <25d616db-6db5-47ed-afc7-8e285d069d8a@yandex-team.ru>
In-Reply-To: <25d616db-6db5-47ed-afc7-8e285d069d8a@yandex-team.ru>
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=xuanzhuo@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, 20 Mar 2024 00:24:37 +0300, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru> wrote:
> Hi all!
>
>  From fuzzing I've got a fuzz-data, which produces the following crash:
>
> qemu-fuzz-x86_64: ../hw/net/virtio-net.c:134: void flush_or_purge_queued_packets(NetClientState *): Assertion `!virtio_net_get_subqueue(nc)->async_tx.elem' failed.
> ==2172308== ERROR: libFuzzer: deadly signal
>      #0 0x5bd8c748b5a1 in __sanitizer_print_stack_trace (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x26f05a1) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>      #1 0x5bd8c73fde38 in fuzzer::PrintStackTrace() (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2662e38) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>      #2 0x5bd8c73e38b3 in fuzzer::Fuzzer::CrashCallback() (/home/settlements/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x26488b3) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>      #3 0x739eec84251f  (/lib/x86_64-linux-gnu/libc.so.6+0x4251f) (BuildId: c289da5071a3399de893d2af81d6a30c62646e1e)
>      #4 0x739eec8969fb in __pthread_kill_implementation nptl/./nptl/pthread_kill.c:43:17
>      #5 0x739eec8969fb in __pthread_kill_internal nptl/./nptl/pthread_kill.c:78:10
>      #6 0x739eec8969fb in pthread_kill nptl/./nptl/pthread_kill.c:89:10
>      #7 0x739eec842475 in gsignal signal/../sysdeps/posix/raise.c:26:13
>      #8 0x739eec8287f2 in abort stdlib/./stdlib/abort.c:79:7
>      #9 0x739eec82871a in __assert_fail_base assert/./assert/assert.c:92:3
>      #10 0x739eec839e95 in __assert_fail assert/./assert/assert.c:101:3
>      #11 0x5bd8c995d9e2 in flush_or_purge_queued_packets /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/net/virtio-net.c:134:5
>      #12 0x5bd8c9918a5f in virtio_net_queue_reset /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/net/virtio-net.c:563:5
>      #13 0x5bd8c9b724e5 in virtio_queue_reset /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/virtio/virtio.c:2492:9
>      #14 0x5bd8c8bcfb7c in virtio_pci_common_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../hw/virtio/virtio-pci.c:1372:13
>      #15 0x5bd8c9e19cf3 in memory_region_write_accessor /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/memory.c:492:5
>      #16 0x5bd8c9e19631 in access_with_adjusted_size /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/memory.c:554:18
>      #17 0x5bd8c9e17f3c in memory_region_dispatch_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/memory.c:1514:16
>      #18 0x5bd8c9ea3bbe in flatview_write_continue /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/physmem.c:2825:23
>      #19 0x5bd8c9e91aab in flatview_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/physmem.c:2867:12
>      #20 0x5bd8c9e91568 in address_space_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../softmmu/physmem.c:2963:18
>      #21 0x5bd8c74c8a90 in __wrap_qtest_writeq /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/qtest_wrappers.c:187:9
>      #22 0x5bd8c74dc4da in op_write /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/generic_fuzz.c:487:13
>      #23 0x5bd8c74d942e in generic_fuzz /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/generic_fuzz.c:714:17
>      #24 0x5bd8c74c016e in LLVMFuzzerTestOneInput /home/vsementsov/work/src/qemu/yc7-fuzz/build/../tests/qtest/fuzz/fuzz.c:152:5
>      #25 0x5bd8c73e4e43 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2649e43) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>      #26 0x5bd8c73cebbf in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2633bbf) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>      #27 0x5bd8c73d4916 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2639916) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>      #28 0x5bd8c73fe732 in main (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x2663732) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>      #29 0x739eec829d8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>      #30 0x739eec829e3f in __libc_start_main csu/../csu/libc-start.c:392:3
>      #31 0x5bd8c73c9484 in _start (/home/vsementsov/work/src/qemu/yc7-fuzz/build/qemu-fuzz-x86_64+0x262e484) (BuildId: b41827f440fd9feaa98c667dbdcc961abb2799ae)
>
>
>
> How to reproduce:
> ./configure --target-list=x86_64-softmmu --enable-debug --disable-docs --cc=clang --cxx=clang++ --enable-fuzzing --enable-sanitizers --enable-slirp
> make -j20 qemu-fuzz-x86_64
> ./build/qemu-fuzz-x86_64 --fuzz-target=generic-fuzz-virtio-net-pci-slirp ../generic-fuzz-virtio-net-pci-slirp.crash-7707e14adea64d129be88faeb6ca57dab6118ec5
>
>
> This ...crash-7707... file is attached.
>
> git-bisect points to 7dc6be52f4ead25e7da8fb758900bdcb527996f7 "virtio-net: support queue reset" as a first bad commit. That's a commit which introduces virtio_net_queue_reset() function.
>
>
> I'm a newbie in qemu-fuzzing, and don't know virtio-net code, so I've no idea how to debug this thing further. I even don't know, how to get a normal coredump file to open it in gdb, it's not produced from fuzzing process...
>
>
> I tried to search for "async_tx.elem" in git log, and found two commits, fixing similar crashes:
>
>    bc5add1dadcc140fef9af4fe215167e796cd1a58 "vhost-vdpa: fix assert !virtio_net_get_subqueue(nc)->async_tx.elem in virtio_net_reset"


This fixed that by updating the vdpa "receive" callback.

You use the slirp, so should we fix that by updating the "receive"
callback of slirp?

Thanks.


>
> and
>
>    5fe19fb81839ea42b592b409f725349cf3c73551 "net: use peer when purging queue in qemu_flush_or_purge_queue_packets()"
>
> but I failed to get helping idea from them.
>
>
>
> Could someone please help with this?
>
>
> --
> Best regards,
> Vladimir

