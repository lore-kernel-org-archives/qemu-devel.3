Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC49BC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 18:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNFjf-0003CJ-Sl; Thu, 05 Jun 2025 14:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNFje-0003Bt-Hs
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNFjc-0001c3-55
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749149677;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=N5eDR9+VCINHlQqncZDXkf+x/ypZ9J+RrTGwYQc4lOo=;
 b=gXN32CR1+HVe8ypaF5iDtCZWqVncMiCQkKkmBieDam5r6wulwrJIZTsqZ16YUOiAw1Wge0
 itNTevEPlsfbO7Cvbga92nIeOj/u86auzwxK9cYPkIqKmzYkM0CBjlMUDwgDgPWtD5xIcS
 vFhya1y61/FJum3QuZOTmgH0k6IoQLE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-UQ8xMe96PuKdzWONZAixcQ-1; Thu,
 05 Jun 2025 14:54:36 -0400
X-MC-Unique: UQ8xMe96PuKdzWONZAixcQ-1
X-Mimecast-MFC-AGG-ID: UQ8xMe96PuKdzWONZAixcQ_1749149675
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BBEF18001E3; Thu,  5 Jun 2025 18:54:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.159])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18F411954B33; Thu,  5 Jun 2025 18:54:32 +0000 (UTC)
Date: Thu, 5 Jun 2025 19:54:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: avoid cost of -ftrivial-auto-var-init in hot path
Message-ID: <aEHn5XHU0-N67gWs@redhat.com>
References: <20250604191843.399309-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604191843.399309-1-stefanha@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 04, 2025 at 03:18:43PM -0400, Stefan Hajnoczi wrote:
> Since commit 7ff9ff039380 ("meson: mitigate against use of uninitialize
> stack for exploits") the -ftrivial-auto-var-init=zero compiler option is
> used to zero local variables. While this reduces security risks
> associated with uninitialized stack data, it introduced a measurable
> bottleneck in the virtqueue_split_pop() and virtqueue_packed_pop()
> functions.
> 
> These virtqueue functions are in the hot path. They are called for each
> element (request) that is popped from a VIRTIO device's virtqueue. Using
> __attribute__((uninitialized)) on large stack variables in these
> functions improves fio randread bs=4k iodepth=64 performance from 304k
> to 332k IOPS (+9%).
> 
> This issue was found using perf-top(1). virtqueue_split_pop() was one of
> the top CPU consumers and the "annotate" feature showed that the memory
> zeroing instructions at the beginning of the functions were hot.

I'm concerned we have other issues lurking, so I built qemu
with -Wframe-larger-than=8192 and looked at every source
file location it reported. I've not done performance testing
but I've found a decent number of locations that look like
they are in the I/O path, so likely hot paths. It seems I
was too naive when introducing -ftrivial-auto-var-init=zero
wrt possible perf hits.

The results are as follow, and show some areas we should
likely proactively marked with "QEMU_UNINITIALIZED' even
without checking perf results:


../block/linux-aio.c:342:1: warning: the frame size of 8208 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - ioq_submit - struct iocb *iocbs[MAX_EVENTS];

../contrib/elf2dmp/main.c:636:1: warning: the frame size of 22240 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Misc big data structures
    Not a hot path

../contrib/ivshmem-server/main.c:274:1: warning: the frame size of 8784 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Ivshmem state is stored in main() stack
    Not a hot path

../contrib/vhost-user-gpu/vhost-user-gpu.c:1011:1: warning: the frame size of 16432 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../contrib/vhost-user-gpu/vhost-user-gpu.c:1107:1: warning: the frame size of 16464 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../contrib/vhost-user-gpu/vhost-user-gpu.c:1120:1: warning: the frame size of 16432 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../contrib/vhost-user-gpu/vhost-user-gpu.c:304:1: warning: the frame size of 16432 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../contrib/vhost-user-gpu/vhost-user-gpu.c:351:1: warning: the frame size of 16464 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../contrib/vhost-user-gpu/vhost-user-gpu.c:435:1: warning: the frame size of 16448 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../contrib/vhost-user-gpu/vhost-user-gpu.c:748:1: warning: the frame size of 16512 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../contrib/vhost-user-gpu/vhost-user-gpu.c:857:1: warning: the frame size of 16592 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../contrib/vhost-user-gpu/virgl.c:427:1: warning: the frame size of 16576 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../contrib/vhost-user-gpu/virgl.c:459:1: warning: the frame size of 16480 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../hw/display/vhost-user-gpu.c:168:1: warning: the frame size of 16432 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../hw/display/vhost-user-gpu.c:354:1: warning: the frame size of 17536 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Many methods use the VhostUserGpuMsg struct which has a union where
    VhostUserGpuCursorUpdate has a 16kb data field.

    Varibles are initialized explicitly at declaration avoiding
    auto-init, but only the union branches that are needed. GCC
    may zero initialize unused branches, and possibly also
    union padding bytes.

    Hot paths => probably skip init

../hw/acpi/core.c:312:1: warning: the frame size of 8256 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Has a "char unsigned data[8192];" used for reading data from a file.
    Not a hot path.

../hw/arm/mps2-tz.c:1216:1: warning: the frame size of 12048 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Several large "const PPCInfo" const variables
    Not a hot path

../hw/audio/cs4231a.c:571:1: warning: the frame size of 12320 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - 4k and 8k buffers for converting audio samples

    Hot path, should skip init

../hw/core/qdev-properties-system.c:474:1: warning: the frame size of 8256 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - "NetClientState *peers[MAX_QUEUE_NUM];"  is 8K in size
    Not a hot path


../hw/display/vmware_vga.c:794:1: warning: the frame size of 20624 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Large "struct vmsvga_cursor_definition_s cursor;"
    Hot path

../hw/i386/x86-common.c:1001:1: warning: the frame size of 8400 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - 8k buffer for loading initrd header
    Not a hot path

../hw/net/rtl8139.c:1840:1: warning: the frame size of 8224 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - 8k buffer for transferring data
    Hot path

../hw/net/virtio-net.c:2057:1: warning: the frame size of 32912 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../hw/net/virtio-net.c:2821:1: warning: the frame size of 32864 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Several arrays of VIRTQUEUE_MAX_SIZE (1k)
    Hot path

../hw/net/xgmac.c:264:1: warning: the frame size of 8256 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - 8k buffer for transferring data
    Hot path

../hw/ppc/pnv_occ.c:807:1: warning: the frame size of 12960 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../hw/ppc/pnv_occ.c:922:1: warning: the frame size of 15136 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Large structs
    Hot path

../hw/ppc/spapr_tpm_proxy.c:100:1: warning: the frame size of 8256 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Two 4k buffers for transferring data
    Hot path, though TPMs are low performance devices 

../hw/s390x/ipl.c:552:1: warning: the frame size of 28688 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Large IplParameterBlock struct
    Not hot path

../hw/s390x/s390-pci-inst.c:359:1: warning: the frame size of 8304 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - 8k buffer for transferring data between host/guest
    Unclear if clp_service_call is a hot path ?

../hw/sparc64/sun4u.c:154:1: warning: the frame size of 8208 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../hw/sparc/sun4m.c:171:1: warning: the frame size of 8208 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - 8k buffers for initializing NVRAM
    Not a hot path

../hw/usb/hcd-ohci.c:833:1: warning: the frame size of 8384 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - 8k buffer for transferring data between host/guest
    Hot path

../hw/virtio/vhost-user.c:886:1: warning: the frame size of 21760 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Several arrays of VHOST_USER_MAX_RAM_SLOTS (512)
    Unclear if vhost_user_add_remove_regions is a hot path

../hw/virtio/virtio.c:1827:1: warning: the frame size of 24784 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../hw/virtio/virtio.c:1827:1: warning: the frame size of 24800 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../hw/virtio/virtio.c:1977:1: warning: the frame size of 24816 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Several arrays of VIRTQUEUE_MAX_SIZE (1k)
    Hot path - Stefan's patch fixes


../hw/virtio/virtio.c:2156:1: warning: the frame size of 49184 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../hw/virtio/virtio.c:2193:1: warning: the frame size of 49184 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Struct VirtQueueElementOld containing several arrays of VIRTQUEUE_MAX_SIZE (1k)
    Unclear if qemu_{put,get}_virtqueue_element are a hot path

../net/filter.c:304:1: warning: the frame size of 8224 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../net/net.c:1647:1: warning: the frame size of 8224 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../net/net.c:461:1: warning: the frame size of 8208 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../net/net-hmp-cmds.c:150:1: warning: the frame size of 8208 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../net/net-hmp-cmds.c:170:1: warning: the frame size of 8208 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - More MAX_QUEUE_NUM variables
    Not a hot path

../net/socket.c:191:1: warning: the frame size of 69664 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../net/stream.c:192:1: warning: the frame size of 69664 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - 68k buffers for transferring data
    Hot path

../net/vhost-user.c:276:1: warning: the frame size of 8224 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../net/vhost-user.c:334:1: warning: the frame size of 8304 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - More MAX_QUEUE_NUM variables
    Not a hot path

../scsi/qemu-pr-helper.c:423:1: warning: the frame size of 8208 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../scsi/qemu-pr-helper.c:540:1: warning: the frame size of 8256 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Large "struct prin_resp"
    Not a hot path

../target/arm/helper.c:9028:1: warning: the frame size of 9184 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Many Large ARMCPRegInfo structs
    Unclear if register_cp_regs_for_features is a hot path ?

../target/s390x/ioinst.c:719:1: warning: the frame size of 8272 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - A TARGET_PAGE_SIZE buffer - 4k
    Unclear if ioinst_handle_chsc is a hot path

../target/xtensa/translate.c:1117:1: warning: the frame size of 42608 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Several MAX_INSN_SLOTS arrays
    Unclear if disas_xtensa_insn is a hot path

../tests/qtest/hd-geo-test.c:510:1: warning: the frame size of 8832 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../tests/qtest/ide-test.c:553:1: warning: the frame size of 32832 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../tests/qtest/ivshmem-test.c:379:1: warning: the frame size of 8448 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../tests/qtest/ufs-test.c:680:1: warning: the frame size of 8576 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../tests/unit/test-string-input-visitor.c:464:1: warning: the frame size of 10064 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../tests/unit/test-write-threshold.c:24:1: warning: the frame size of 17168 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../tests/unit/test-write-threshold.c:37:1: warning: the frame size of 17168 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../tests/vhost-user-bridge.c:232:1: warning: the frame size of 16480 bytes is larger than 8192 bytes [-Wframe-larger-than=]
../tests/vhost-user-bridge.c:370:1: warning: the frame size of 16544 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - Tests aren't a hot path

../ui/vnc-jobs.c:336:1: warning: the frame size of 103696 bytes is larger than 8192 bytes [-Wframe-larger-than=]

  - A VncState variable
    Hot path



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


