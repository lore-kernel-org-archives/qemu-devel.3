Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146DCC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pZb-0003oe-0E; Thu, 10 Sep 2026 20:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1x4ncE-0003rB-Q9
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 18:53:34 -0400
Received: from mail-qk2-x10.google.com ([2607:f8b0:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1x4nc6-0002m0-4B
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 18:51:31 -0400
Received: by mail-qk2-x10.google.com with SMTP id
 d75a77b69052e-5308fc4b67cso3977531cf.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789080625; x=1789685425; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Znd/ObcqxA2V7s0eObfItQggq6CzgHlDhwjBt6oDre4=;
 b=U+xXam33JQGZEwqpBoG7r8y213PQGFy+ZkG4V6nQRmBSY+TLBG6UVtvMRSpRuIoaXq
 z/RUvY/AFdqKZIQHI1lzeLu95CCEpsMiRdEDtaIg1hLoe14aWaCGYDLsqcPJwRO3LY01
 pbV23WKkriDCzpCqDsMuJQsdHArXRsjXktV2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789080625; x=1789685425;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Znd/ObcqxA2V7s0eObfItQggq6CzgHlDhwjBt6oDre4=;
 b=DcvtNF5FJF3VDYzswIw4XO1IiF8TdW8z87xnrY3ked0bLu8OzqNtXySqJxee8AgqF+
 rdhWsPjULaZLWXGkTuFKJ8ENoYZBDsnD6TzWczdV9O2Z1rHWgxahEgFR2uAUudGYfYAm
 HcifJYNKSmrYej9gMpAkgjVKiwM4mhyfAYFfT5cBsrnU2QjtGe042OGuXWpy6nkjtNtx
 Y6MLiaV6bttw+ps1DDUXXS5EKxB15sLMtGV7gwmevjkQ8GLYdaeusYc1XVGAnEhCOJhg
 FqAAIOTI/IzXzZCHB7nfWxtEnDSVWa1KlbmY2mnk+YWQINHQP6Wr46pdyHYK9tv7Fx4f
 K/9g==
X-Gm-Message-State: AFuF++kQ9Y6b3qHOos7Hth1Ku9gGT8gZAaqTAL6hUiWzS6bdTnI/AlIU
 sTSnyb5WXl+Rp6Ey6pkTz8zhmBM4HHq72H2si5s9cHtXvo0vnCfiWWpPIcLo4aRJm948G0xJ1yT
 cQq8=
X-Gm-Gg: AYBFou0JlwbfMMeUF0IOuzNlEQ5Ld0++5PpkeEQ00amYARYl340PSx8SnYNy0rMMp7W
 qk1bLukLifmSyIA8AMyplWbH7BADOJ+vz3UkijQAb8yjpL8F1Q7CzQhJkgZD7xHPkPo65Sqvy8Z
 w4qM8Fhxtu7l+hICamO1hjnpBj9dDcGqeVIKCFuK1bbx9BRYaeJjuMtKyOngCl1VK2hdDFrUq+7
 3zk33woejGS/x20j9G38wJ/yUXmallofOvduwLy8cgcjhY/866HuzrpuDljcNxb8xXmTOJglNsL
 oYNAJkMtZZsqbo9f3vZWw0o4i6RhfaASsUjt6bdPsCHAjgz3LcUnEX+eSpRgk9a9QoFtMa6Iupe
 Y00RtGyMoDZeHlNbNjQiZdofhgezf+8eUZTbF6P7zyS0Bj/JqoLG4eEgsIMbteXUY3L13+zOAiU
 G+jBGajNQ2gY8vBKcP7x93JKE+6t5d5vB/5RHyyXXFx1PVWojs78ZrQbLLQRMGa1KDbJWCT/jTl
 xxU5dMLt/cEAu887cridWaDB7iNQK/5eatB9KB/zzv7TKA=
X-Received: by 2002:ac8:5d56:0:b0:530:743f:d51 with SMTP id
 d75a77b69052e-530c852abf2mr26853161cf.10.1789080624782; 
 Thu, 10 Sep 2026 15:50:24 -0700 (PDT)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com.
 [74.125.230.204]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530ca3098easm5164191cf.3.2026.09.10.15.50.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 15:50:24 -0700 (PDT)
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-5307425f44bso48391cf.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:50:23 -0700 (PDT)
X-Received: by 2002:a05:622a:343:b0:52b:4ec6:52ba with SMTP id
 d75a77b69052e-530c958404amr6652291cf.6.1789080204522; Thu, 10 Sep 2026
 15:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 10 Sep 2026 15:43:12 -0700
X-Gmail-Original-Message-ID: <CAAfnVBm7vcBE7ZfsxDyiDPq2+uGOzN-1PN+gQ9Y-TwuXbm72KA@mail.gmail.com>
X-Gm-Features: AcwNN1WpqnJ1QwIAQlbw2EBVkydPe4_FJ7Hn5pAdsINCRFMfjo2XD5XfUVozh3U
Message-ID: <CAAfnVBm7vcBE7ZfsxDyiDPq2+uGOzN-1PN+gQ9Y-TwuXbm72KA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] virtio-gpu: Do not wait for the main thread during
 reset
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 David Hildenbrand <david@kernel.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000011e1f3065b28b2db"
Received-SPF: pass client-ip=2607:f8b0:4864:34::10;
 envelope-from=gurchetansingh@chromium.org; helo=mail-qk2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000011e1f3065b28b2db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 11:13=E2=80=AFPM Akihiko Odaki <odaki@rsg.ci.i.u-tok=
yo.ac.jp>
wrote:

> Compatibility note: This series makes virtio-gpu-rutabaga-device
> incompatible with virtio-mmio-bus, as there is no straightforward way to
> fix reset for this combination. I believe nobody uses it, but please let
> me know if anyone relies on it.
>
> Gurchetan, please confirm if this impacts the use case behind your
> original virtio-gpu-rutabaga contribution.
>

Yes, deleting the MMIO is fine, but I curious what aspect of the API makes
it difficult say in comparison to virglrenderer/gfxstream?  They all use
guest memory blobs occasionally.  Or is the thread model?


> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This series fixes a deadlock I previously observed with the test in [1].
> It also fixes a command-ordering race exposed by the same BQL handoff,
> along with command and fence lifetime and accounting issues found while
> auditing device and virtqueue reset. Reset now drains command and fence
> queues without dropping the BQL, while resource destruction and surface
> replacement are deferred to the next control or cursor BH. Scanout state
> needed for migration is cleared synchronously before that deferred
> cleanup. The remaining patches detach popped queue elements before
> freeing commands, track suspension independently of fencing, balance
> inflight accounting, handle control-queue reset for the non-renderer
> backend, and stop advertising queue reset for virtio-gpu-gl,
> virtio-gpu-rutabaga, and vhost-user-gpu, whose current backend
> interfaces cannot quiesce a single queue.
>
> Finally, the virtio core changes split reset initiation from completion
> so device reset handlers can choose when reset is complete. An error
> during reset leaves the device broken and prevents its status from being
> cleared. Rutabaga's same-thread API requires whole-device reset to
> finish in the main-loop GPU BH, where the old backend is torn down and
> reinitialized before completion is reported.


> Note on the deadlock: I can no longer reproduce the issue reliably with
> the test in [1], so I used Codex, a coding agent, to write a more
> reliable local test case, shown below. I applied to Codex for Open
> Source to get access. The test case is not intended for merge: current
> policy prohibits that, and it is probably not worth carrying anyway
> because race-condition tests are inherently fragile. The remaining
> patches were written by me.
>
> [1]
> https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.bennee@l=
inaro.org/
>
> Below is the Codex-written test case:
>
> diff --git a/tests/functional/aarch64/test_gpu_blob.py
> b/tests/functional/aarch64/test_gpu_blob.py
> index a913d3b29c84..52627b4541f9 100755
> --- a/tests/functional/aarch64/test_gpu_blob.py
> +++ b/tests/functional/aarch64/test_gpu_blob.py
> @@ -13,7 +13,9 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>
> -from qemu.machine.machine import VMLaunchFailure
> +import subprocess
> +
> +from qemu.machine.machine import AbnormalShutdown, VMLaunchFailure
>
>  from qemu_test import Asset
>  from qemu_test import wait_for_console_pattern
> @@ -25,8 +27,7 @@ class Aarch64VirtBlobTest(LinuxKernelTest):
>                         'download?path=3D%2Fblob-test&files=3Dqemu-880.bi=
n',
>
> '2f6ab85d0b156c94fcedd2c4c821c5cbd52925a2de107f8e2d569ea2e34e42eb')
>
> -    def test_virtio_gpu_blob(self):
> -
> +    def launch_blob_test(self):
>          self.set_machine('virt')
>          self.require_accelerator("tcg")
>
> @@ -65,9 +66,27 @@ def test_virtio_gpu_blob(self):
>                  self.log.info("unhandled launch failure: %s",
> excp.output)
>                  raise excp
>
> +    def test_virtio_gpu_blob(self):
> +        self.launch_blob_test()
> +
>          self.wait_for_console_pattern('[INFO] virtio-gpu test finished')
>          # the test should cleanly exit
>
> +    def test_virtio_gpu_blob_shutdown_race(self):
> +        self.launch_blob_test()
> +
> +        self.wait_for_console_pattern('[INFO] unmapping blob object
> resource')
> +
> +        try:
> +            self.vm.shutdown(timeout=3D10)
> +        except AbnormalShutdown as excp:
> +            if isinstance(excp.__cause__, subprocess.TimeoutExpired):
> +                raise AssertionError(
> +                    "QEMU failed to exit while virtio-gpu reset was
> racing "
> +                    "with shutdown") from excp
> +            self.log.info("QEMU exited before the shutdown request
> completed: %s",
> +                          excp)
> +
>
>  if __name__ =3D=3D '__main__':
>      LinuxKernelTest.main()
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Changes in v3:
> - Rebased.
> - Dropped the patch "virtio-gpu: Run reset cleanup in the same BH" and
>   reworked reset cleanup to preserve control and cursor queue ordering
>   and migration-visible state without dropping the BQL.
> - Detached popped virtqueue elements before freeing reset commands.
> - Added fixes for fenced blob unmapping and inflight counter accounting.
> - Added control-queue reset handling for the non-renderer backend.
> - Disabled queue reset for virtio-gpu-gl, virtio-gpu-rutabaga, and
>   vhost-user-gpu, whose current backend interfaces cannot quiesce a
>   single queue.
> - Split virtio reset initiation from completion, moved completion into
>   device reset handlers, and preserved errors raised during reset.
> - Added Rutabaga teardown and reinitialization in the main-loop GPU BH
>   before reporting whole-device reset completion.
> - Link to v2:
> https://lore.kernel.org/qemu-devel/20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.=
i.u-tokyo.ac.jp
>
> Changes in v2:
> - Added the patch "virtio-gpu: Run reset cleanup in the same BH".
> - My assumption about the ordering was incorrect, so I changed the patch
>   to follow the approach used by virtio-gpu-gl.
> - Link to v1:
> https://lore.kernel.org/qemu-devel/20251029-gpu-v1-1-e3e3c7eebc9e@rsg.ci.=
i.u-tokyo.ac.jp
>
> ---
> Akihiko Odaki (9):
>       virtio: Introduce virtio_complete_reset()
>       virtio: Move the virtio_complete_reset() call
>       virtio: Preserve an error during reset
>       hw/display/virtio-gpu-rutabaga: Reset Rutabaga
>       virtio-gpu: Do not wait for the main thread during reset
>       hw/display/virtio-gpu: Fix fenced blob unmapping
>       hw/display/virtio-gpu: Balance inflight counter changes
>       hw/display/virtio-gpu: Reject queue_reset when unsupported
>       hw/display/virtio-gpu: Handle virtqueue reset
>
>  include/hw/virtio/virtio-gpu.h   |   7 +-
>  include/hw/virtio/virtio.h       |   1 +
>  hw/9pfs/virtio-9p-device.c       |   1 +
>  hw/audio/virtio-snd.c            |   2 +
>  hw/block/vhost-user-blk.c        |   1 +
>  hw/block/virtio-blk.c            |   1 +
>  hw/char/virtio-serial-bus.c      |   1 +
>  hw/display/vhost-user-gpu.c      |  10 ++-
>  hw/display/virtio-gpu-base.c     |   2 +
>  hw/display/virtio-gpu-gl.c       |  12 +++
>  hw/display/virtio-gpu-rutabaga.c |  29 +++++++
>  hw/display/virtio-gpu-virgl.c    |  25 +++---
>  hw/display/virtio-gpu.c          | 174
> +++++++++++++++++++++++++--------------
>  hw/input/virtio-input.c          |   2 +
>  hw/net/virtio-net.c              |   1 +
>  hw/scsi/vhost-user-scsi.c        |   1 +
>  hw/scsi/virtio-scsi.c            |   2 +
>  hw/virtio/virtio-balloon.c       |   1 +
>  hw/virtio/virtio-crypto.c        |   2 +
>  hw/virtio/virtio.c               |  25 ++++--
>  system/qdev-monitor.c            |   2 -
>  21 files changed, 210 insertions(+), 92 deletions(-)
> ---
> base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
> change-id: 20251029-gpu-c3f45747f7ba
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>

--00000000000011e1f3065b28b2db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div dir=3D"ltr"><div dir=3D"lt=
r"><br></div><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 7, 2026 at 11:13=E2=80=AFPM A=
kihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.ac.jp" target=3D"=
_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Compatibility note: This series makes v=
irtio-gpu-rutabaga-device<br>
incompatible with virtio-mmio-bus, as there is no straightforward way to<br=
>
fix reset for this combination. I believe nobody uses it, but please let<br=
>
me know if anyone relies on it.<br>
<br>
Gurchetan, please confirm if this impacts the use case behind your<br>
original virtio-gpu-rutabaga contribution.<br></blockquote><div><br></div><=
div>Yes, deleting the MMIO is fine, but I curious what aspect of the API ma=
kes it difficult say in comparison to virglrenderer/gfxstream?=C2=A0 They a=
ll use guest memory blobs occasionally.=C2=A0 Or is the thread model?</div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
This series fixes a deadlock I previously observed with the test in [1].<br=
>
It also fixes a command-ordering race exposed by the same BQL handoff,<br>
along with command and fence lifetime and accounting issues found while<br>
auditing device and virtqueue reset. Reset now drains command and fence<br>
queues without dropping the BQL, while resource destruction and surface<br>
replacement are deferred to the next control or cursor BH. Scanout state<br=
>
needed for migration is cleared synchronously before that deferred<br>
cleanup. The remaining patches detach popped queue elements before<br>
freeing commands, track suspension independently of fencing, balance<br>
inflight accounting, handle control-queue reset for the non-renderer<br>
backend, and stop advertising queue reset for virtio-gpu-gl,<br>
virtio-gpu-rutabaga, and vhost-user-gpu, whose current backend<br>
interfaces cannot quiesce a single queue.<br>
<br>
Finally, the virtio core changes split reset initiation from completion<br>
so device reset handlers can choose when reset is complete. An error<br>
during reset leaves the device broken and prevents its status from being<br=
>
cleared. Rutabaga&#39;s same-thread API requires whole-device reset to<br>
finish in the main-loop GPU BH, where the old backend is torn down and<br>
reinitialized before completion is reported.<span style=3D"background-color=
:transparent">=C2=A0</span></blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
Note on the deadlock: I can no longer reproduce the issue reliably with<br>
the test in [1], so I used Codex, a coding agent, to write a more<br>
reliable local test case, shown below. I applied to Codex for Open<br>
Source to get access. The test case is not intended for merge: current<br>
policy prohibits that, and it is probably not worth carrying anyway<br>
because race-condition tests are inherently fragile. The remaining<br>
patches were written by me.<br>
<br>
[1] <a href=3D"https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-=
alex.bennee@linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.=
kernel.org/qemu-devel/20251014111234.3190346-9-alex.bennee@linaro.org/</a><=
br>
<br>
Below is the Codex-written test case:<br>
<br>
diff --git a/tests/functional/aarch64/test_gpu_blob.py b/tests/functional/a=
arch64/test_gpu_blob.py<br>
index a913d3b29c84..52627b4541f9 100755<br>
--- a/tests/functional/aarch64/test_gpu_blob.py<br>
+++ b/tests/functional/aarch64/test_gpu_blob.py<br>
@@ -13,7 +13,9 @@<br>
=C2=A0#<br>
=C2=A0# SPDX-License-Identifier: GPL-2.0-or-later<br>
<br>
-from qemu.machine.machine import VMLaunchFailure<br>
+import subprocess<br>
+<br>
+from qemu.machine.machine import AbnormalShutdown, VMLaunchFailure<br>
<br>
=C2=A0from qemu_test import Asset<br>
=C2=A0from qemu_test import wait_for_console_pattern<br>
@@ -25,8 +27,7 @@ class Aarch64VirtBlobTest(LinuxKernelTest):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;download?path=3D%2Fblob-test&amp;files=3Dqemu-880.bin&#39;,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;2f6ab85d0b156c94fcedd2c4c821c5cbd52925a2de107f8e2d569ea2e34=
e42eb&#39;)<br>
<br>
-=C2=A0 =C2=A0 def test_virtio_gpu_blob(self):<br>
-<br>
+=C2=A0 =C2=A0 def launch_blob_test(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.set_machine(&#39;virt&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.require_accelerator(&quot;tcg&quot;)=
<br>
<br>
@@ -65,9 +66,27 @@ def test_virtio_gpu_blob(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"ht=
tp://self.log.info" rel=3D"noreferrer" target=3D"_blank">self.log.info</a>(=
&quot;unhandled launch failure: %s&quot;, excp.output)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise excp<br=
>
<br>
+=C2=A0 =C2=A0 def test_virtio_gpu_blob(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.launch_blob_test()<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_for_console_pattern(&#39;[INFO]=
 virtio-gpu test finished&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# the test should cleanly exit<br>
<br>
+=C2=A0 =C2=A0 def test_virtio_gpu_blob_shutdown_race(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.launch_blob_test()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(&#39;[INFO] unma=
pping blob object resource&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.shutdown(timeout=3D10)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except AbnormalShutdown as excp:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(excp.__cause__, su=
bprocess.TimeoutExpired):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise AssertionErr=
or(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;QEMU failed to exit while virtio-gpu reset was racing &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;with shutdown&quot;) from excp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.log.info"=
 rel=3D"noreferrer" target=3D"_blank">self.log.info</a>(&quot;QEMU exited b=
efore the shutdown request completed: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 excp)<br>
+<br>
<br>
=C2=A0if __name__ =3D=3D &#39;__main__&#39;:<br>
=C2=A0 =C2=A0 =C2=A0LinuxKernelTest.main()<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.a=
c.jp" target=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
---<br>
Changes in v3:<br>
- Rebased.<br>
- Dropped the patch &quot;virtio-gpu: Run reset cleanup in the same BH&quot=
; and<br>
=C2=A0 reworked reset cleanup to preserve control and cursor queue ordering=
<br>
=C2=A0 and migration-visible state without dropping the BQL.<br>
- Detached popped virtqueue elements before freeing reset commands.<br>
- Added fixes for fenced blob unmapping and inflight counter accounting.<br=
>
- Added control-queue reset handling for the non-renderer backend.<br>
- Disabled queue reset for virtio-gpu-gl, virtio-gpu-rutabaga, and<br>
=C2=A0 vhost-user-gpu, whose current backend interfaces cannot quiesce a<br=
>
=C2=A0 single queue.<br>
- Split virtio reset initiation from completion, moved completion into<br>
=C2=A0 device reset handlers, and preserved errors raised during reset.<br>
- Added Rutabaga teardown and reinitialization in the main-loop GPU BH<br>
=C2=A0 before reporting whole-device reset completion.<br>
- Link to v2: <a href=3D"https://lore.kernel.org/qemu-devel/20260424-gpu-v2=
-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp" rel=3D"noreferrer" target=3D"_blank=
">https://lore.kernel.org/qemu-devel/20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.=
i.u-tokyo.ac.jp</a><br>
<br>
Changes in v2:<br>
- Added the patch &quot;virtio-gpu: Run reset cleanup in the same BH&quot;.=
<br>
- My assumption about the ordering was incorrect, so I changed the patch<br=
>
=C2=A0 to follow the approach used by virtio-gpu-gl.<br>
- Link to v1: <a href=3D"https://lore.kernel.org/qemu-devel/20251029-gpu-v1=
-1-e3e3c7eebc9e@rsg.ci.i.u-tokyo.ac.jp" rel=3D"noreferrer" target=3D"_blank=
">https://lore.kernel.org/qemu-devel/20251029-gpu-v1-1-e3e3c7eebc9e@rsg.ci.=
i.u-tokyo.ac.jp</a><br>
<br>
---<br>
Akihiko Odaki (9):<br>
=C2=A0 =C2=A0 =C2=A0 virtio: Introduce virtio_complete_reset()<br>
=C2=A0 =C2=A0 =C2=A0 virtio: Move the virtio_complete_reset() call<br>
=C2=A0 =C2=A0 =C2=A0 virtio: Preserve an error during reset<br>
=C2=A0 =C2=A0 =C2=A0 hw/display/virtio-gpu-rutabaga: Reset Rutabaga<br>
=C2=A0 =C2=A0 =C2=A0 virtio-gpu: Do not wait for the main thread during res=
et<br>
=C2=A0 =C2=A0 =C2=A0 hw/display/virtio-gpu: Fix fenced blob unmapping<br>
=C2=A0 =C2=A0 =C2=A0 hw/display/virtio-gpu: Balance inflight counter change=
s<br>
=C2=A0 =C2=A0 =C2=A0 hw/display/virtio-gpu: Reject queue_reset when unsuppo=
rted<br>
=C2=A0 =C2=A0 =C2=A0 hw/display/virtio-gpu: Handle virtqueue reset<br>
<br>
=C2=A0include/hw/virtio/virtio-gpu.h=C2=A0 =C2=A0|=C2=A0 =C2=A07 +-<br>
=C2=A0include/hw/virtio/virtio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 =
+<br>
=C2=A0hw/9pfs/virtio-9p-device.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 =
+<br>
=C2=A0hw/audio/virtio-snd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +<br>
=C2=A0hw/block/vhost-user-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 =
+<br>
=C2=A0hw/block/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A01 +<br>
=C2=A0hw/char/virtio-serial-bus.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/display/vhost-user-gpu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 ++-<br>
=C2=A0hw/display/virtio-gpu-base.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0hw/display/virtio-gpu-gl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +++<b=
r>
=C2=A0hw/display/virtio-gpu-rutabaga.c |=C2=A0 29 +++++++<br>
=C2=A0hw/display/virtio-gpu-virgl.c=C2=A0 =C2=A0 |=C2=A0 25 +++---<br>
=C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 174 +++++=
++++++++++++++++++++--------------<br>
=C2=A0hw/input/virtio-input.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +<br>
=C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 +<br>
=C2=A0hw/scsi/vhost-user-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 =
+<br>
=C2=A0hw/scsi/virtio-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +<br>
=C2=A0hw/virtio/virtio-balloon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 =
+<br>
=C2=A0hw/virtio/virtio-crypto.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 =
+<br>
=C2=A0hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 25 ++++--<br>
=C2=A0system/qdev-monitor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 -<br>
=C2=A021 files changed, 210 insertions(+), 92 deletions(-)<br>
---<br>
base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475<br>
change-id: 20251029-gpu-c3f45747f7ba<br>
<br>
Best regards,<br>
--=C2=A0 <br>
Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.ac.jp" target=3D=
"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
<br>
</blockquote></div>
</div>
</div>

--00000000000011e1f3065b28b2db--

