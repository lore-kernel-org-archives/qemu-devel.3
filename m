Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81995C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tSk-0007Ln-2w; Fri, 11 Sep 2026 01:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4tSX-0007LJ-IM; Fri, 11 Sep 2026 01:05:58 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4tST-0003Fo-RD; Fri, 11 Sep 2026 01:05:57 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68B4xiQP001380
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 11 Sep 2026 13:59:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2dmIj5zDei57a+b9Z6b5kEqdDT2UlK8aZ7vL73B0VdQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1789102784; v=1;
 b=qinhNnMCmOcTzioZKQzTfd4JK4zXAYMcjJ7KLK0eE4qUNvs1CCVYIyDTZkn4PmlP
 8+1W+/D60i6RxdIbYv+1twz0i0uJGAgCv+lOadWkA7KhWQUWGuqFtBtHyBEDE+Nh
 hQ98VizioKf3DZKCEHDIzPngSNd2RHHR5JrkISFu7PEAVvJmKWMGugyhiAzaDTvG
 m73Ar7+5NHVz1y3f84jM60/ibnHr4ClvbFNRDu3+wcRH9c7Jh71xCInldLjBXTOp
 WeR++i8kY8lwKmI3S4sh1vXA11gJvrpoLl5LwolrkfdaOCAL6FJdVBA1WOfHPCZR
 KVrAkAIEOypDxeHASa9D8A==
Message-ID: <910f5170-0f30-4ae9-b047-373434f1d41e@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 11 Sep 2026 13:59:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v3 0/9] virtio-gpu: Do not wait for the main thread during
 reset
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 David Hildenbrand <david@kernel.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
 <CAAfnVBm7vcBE7ZfsxDyiDPq2+uGOzN-1PN+gQ9Y-TwuXbm72KA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAAfnVBm7vcBE7ZfsxDyiDPq2+uGOzN-1PN+gQ9Y-TwuXbm72KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/09/11 7:43, Gurchetan Singh wrote:
> 
> 
> 
> 
> On Mon, Sep 7, 2026 at 11:13 PM Akihiko Odaki <odaki@rsg.ci.i.u- 
> tokyo.ac.jp <mailto:odaki@rsg.ci.i.u-tokyo.ac.jp>> wrote:
> 
>     Compatibility note: This series makes virtio-gpu-rutabaga-device
>     incompatible with virtio-mmio-bus, as there is no straightforward way to
>     fix reset for this combination. I believe nobody uses it, but please let
>     me know if anyone relies on it.
> 
>     Gurchetan, please confirm if this impacts the use case behind your
>     original virtio-gpu-rutabaga contribution.
> 
> 
> Yes, deleting the MMIO is fine, but I curious what aspect of the API 
> makes it difficult say in comparison to virglrenderer/gfxstream?  They 
> all use guest memory blobs occasionally.  Or is the thread model?

Thanks for confirmation.

It's true that virglrenderer also uses guest memory blobs, and we apply 
the same thread model for virglrenderer and Rutabaga.

The difference is that Rutabaga has a feature that clearly requires 
waiting for proper reset completion: cross-domain. QEMU invokes both 
APIs from the main-loop thread, but cross-domain also has a worker that 
writes responses directly into guest backing. Stopping QEMU's command 
processing does not stop that worker. We therefore need to tear down the 
old Rutabaga instance and join its worker before reporting reset 
completion. Rutabaga requires that teardown to run on the thread that 
initialized it.

The reset timing implemented for virglrenderer looks like as follows:
1. The driver requests reset.
2. The device synchronously notifies reset completion, though actual
    reset is still pending. It makes the device compatible with
    virtio-mmio-bus, which requires synchronous reset completion.
3. The device asynchronously completes actual reset.

The assumption here is that the device may read blobs after notifying 
reset completion to the driver but may not write. Perhaps reading blobs 
after notifying reset completion may cause displaying garbage, but it's 
much better than deadlocks and potential use-after-free we currently have.

cross-domain breaks this assumption. With cross-domain, the following 
may happen:
1. The driver requests reset.
2. The device synchronously notifies reset completion.
3. The driver reuses the blob memory for something else.
4. The device writes to the blob memory, corrupting its content.
5. The device asynchronously completes actual reset.

So we cannot let the device synchronously notify reset completion with 
Rutabaga to make it compatible with virtio-mmio-bus.

Regards,
Akihiko Odaki

> 
> 
>     =======================================================================
> 
>     This series fixes a deadlock I previously observed with the test in [1].
>     It also fixes a command-ordering race exposed by the same BQL handoff,
>     along with command and fence lifetime and accounting issues found while
>     auditing device and virtqueue reset. Reset now drains command and fence
>     queues without dropping the BQL, while resource destruction and surface
>     replacement are deferred to the next control or cursor BH. Scanout state
>     needed for migration is cleared synchronously before that deferred
>     cleanup. The remaining patches detach popped queue elements before
>     freeing commands, track suspension independently of fencing, balance
>     inflight accounting, handle control-queue reset for the non-renderer
>     backend, and stop advertising queue reset for virtio-gpu-gl,
>     virtio-gpu-rutabaga, and vhost-user-gpu, whose current backend
>     interfaces cannot quiesce a single queue.
> 
>     Finally, the virtio core changes split reset initiation from completion
>     so device reset handlers can choose when reset is complete. An error
>     during reset leaves the device broken and prevents its status from being
>     cleared. Rutabaga's same-thread API requires whole-device reset to
>     finish in the main-loop GPU BH, where the old backend is torn down and
>     reinitialized before completion is reported.
> 
> 
>     Note on the deadlock: I can no longer reproduce the issue reliably with
>     the test in [1], so I used Codex, a coding agent, to write a more
>     reliable local test case, shown below. I applied to Codex for Open
>     Source to get access. The test case is not intended for merge: current
>     policy prohibits that, and it is probably not worth carrying anyway
>     because race-condition tests are inherently fragile. The remaining
>     patches were written by me.
> 
>     [1] https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-
>     alex.bennee@linaro.org/ <https://lore.kernel.org/qemu-
>     devel/20251014111234.3190346-9-alex.bennee@linaro.org/>
> 
>     Below is the Codex-written test case:
> 
>     diff --git a/tests/functional/aarch64/test_gpu_blob.py b/tests/
>     functional/aarch64/test_gpu_blob.py
>     index a913d3b29c84..52627b4541f9 100755
>     --- a/tests/functional/aarch64/test_gpu_blob.py
>     +++ b/tests/functional/aarch64/test_gpu_blob.py
>     @@ -13,7 +13,9 @@
>       #
>       # SPDX-License-Identifier: GPL-2.0-or-later
> 
>     -from qemu.machine.machine import VMLaunchFailure
>     +import subprocess
>     +
>     +from qemu.machine.machine import AbnormalShutdown, VMLaunchFailure
> 
>       from qemu_test import Asset
>       from qemu_test import wait_for_console_pattern
>     @@ -25,8 +27,7 @@ class Aarch64VirtBlobTest(LinuxKernelTest):
>                              'download?path=%2Fblob-
>     test&files=qemu-880.bin',
>                             
>     '2f6ab85d0b156c94fcedd2c4c821c5cbd52925a2de107f8e2d569ea2e34e42eb')
> 
>     -    def test_virtio_gpu_blob(self):
>     -
>     +    def launch_blob_test(self):
>               self.set_machine('virt')
>               self.require_accelerator("tcg")
> 
>     @@ -65,9 +66,27 @@ def test_virtio_gpu_blob(self):
>     self.log.info <http://self.log.info>("unhandled launch failure: %s",
>     excp.output)
>                       raise excp
> 
>     +    def test_virtio_gpu_blob(self):
>     +        self.launch_blob_test()
>     +
>               self.wait_for_console_pattern('[INFO] virtio-gpu test
>     finished')
>               # the test should cleanly exit
> 
>     +    def test_virtio_gpu_blob_shutdown_race(self):
>     +        self.launch_blob_test()
>     +
>     +        self.wait_for_console_pattern('[INFO] unmapping blob object
>     resource')
>     +
>     +        try:
>     +            self.vm.shutdown(timeout=10)
>     +        except AbnormalShutdown as excp:
>     +            if isinstance(excp.__cause__, subprocess.TimeoutExpired):
>     +                raise AssertionError(
>     +                    "QEMU failed to exit while virtio-gpu reset was
>     racing "
>     +                    "with shutdown") from excp
>     + self.log.info <http://self.log.info>("QEMU exited before the
>     shutdown request completed: %s",
>     +                          excp)
>     +
> 
>       if __name__ == '__main__':
>           LinuxKernelTest.main()
> 
>     Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp
>     <mailto:odaki@rsg.ci.i.u-tokyo.ac.jp>>
>     ---
>     Changes in v3:
>     - Rebased.
>     - Dropped the patch "virtio-gpu: Run reset cleanup in the same BH" and
>        reworked reset cleanup to preserve control and cursor queue ordering
>        and migration-visible state without dropping the BQL.
>     - Detached popped virtqueue elements before freeing reset commands.
>     - Added fixes for fenced blob unmapping and inflight counter accounting.
>     - Added control-queue reset handling for the non-renderer backend.
>     - Disabled queue reset for virtio-gpu-gl, virtio-gpu-rutabaga, and
>        vhost-user-gpu, whose current backend interfaces cannot quiesce a
>        single queue.
>     - Split virtio reset initiation from completion, moved completion into
>        device reset handlers, and preserved errors raised during reset.
>     - Added Rutabaga teardown and reinitialization in the main-loop GPU BH
>        before reporting whole-device reset completion.
>     - Link to v2: https://lore.kernel.org/qemu-devel/20260424-gpu-
>     v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp <https://lore.kernel.org/
>     qemu-devel/20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
> 
>     Changes in v2:
>     - Added the patch "virtio-gpu: Run reset cleanup in the same BH".
>     - My assumption about the ordering was incorrect, so I changed the patch
>        to follow the approach used by virtio-gpu-gl.
>     - Link to v1: https://lore.kernel.org/qemu-devel/20251029-gpu-v1-1-
>     e3e3c7eebc9e@rsg.ci.i.u-tokyo.ac.jp <https://lore.kernel.org/qemu-
>     devel/20251029-gpu-v1-1-e3e3c7eebc9e@rsg.ci.i.u-tokyo.ac.jp>
> 
>     ---
>     Akihiko Odaki (9):
>            virtio: Introduce virtio_complete_reset()
>            virtio: Move the virtio_complete_reset() call
>            virtio: Preserve an error during reset
>            hw/display/virtio-gpu-rutabaga: Reset Rutabaga
>            virtio-gpu: Do not wait for the main thread during reset
>            hw/display/virtio-gpu: Fix fenced blob unmapping
>            hw/display/virtio-gpu: Balance inflight counter changes
>            hw/display/virtio-gpu: Reject queue_reset when unsupported
>            hw/display/virtio-gpu: Handle virtqueue reset
> 
>       include/hw/virtio/virtio-gpu.h   |   7 +-
>       include/hw/virtio/virtio.h       |   1 +
>       hw/9pfs/virtio-9p-device.c       |   1 +
>       hw/audio/virtio-snd.c            |   2 +
>       hw/block/vhost-user-blk.c        |   1 +
>       hw/block/virtio-blk.c            |   1 +
>       hw/char/virtio-serial-bus.c      |   1 +
>       hw/display/vhost-user-gpu.c      |  10 ++-
>       hw/display/virtio-gpu-base.c     |   2 +
>       hw/display/virtio-gpu-gl.c       |  12 +++
>       hw/display/virtio-gpu-rutabaga.c |  29 +++++++
>       hw/display/virtio-gpu-virgl.c    |  25 +++---
>       hw/display/virtio-gpu.c          | 174 ++++++++++++++++++++++++
>     +--------------
>       hw/input/virtio-input.c          |   2 +
>       hw/net/virtio-net.c              |   1 +
>       hw/scsi/vhost-user-scsi.c        |   1 +
>       hw/scsi/virtio-scsi.c            |   2 +
>       hw/virtio/virtio-balloon.c       |   1 +
>       hw/virtio/virtio-crypto.c        |   2 +
>       hw/virtio/virtio.c               |  25 ++++--
>       system/qdev-monitor.c            |   2 -
>       21 files changed, 210 insertions(+), 92 deletions(-)
>     ---
>     base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
>     change-id: 20251029-gpu-c3f45747f7ba
> 
>     Best regards,
>     -- 
>     Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp
>     <mailto:odaki@rsg.ci.i.u-tokyo.ac.jp>>
> 


