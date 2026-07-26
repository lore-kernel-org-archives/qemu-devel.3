Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5AFC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo65W-0002ez-Ex; Sun, 26 Jul 2026 17:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wo65U-0002Xp-P1
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:08:44 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wo65T-00016m-4A
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:08:44 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so2155714a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785100122; cv=none;
 d=google.com; s=arc-20260327;
 b=irYOb4iphkFGZbgPS3If305WsVPBuPuRVABzyPUG2YwoKXz0meZmxhprM+x/+z7Dzg
 EZVKHdWvJZVjmKb6qFJZD6nwdGGcAeWDdbRKVGNQTuSWVgebWHscYcEywQskoZLrzFas
 gizTzuPKSkCj+J6niVwsbRv3KtKorXE8/N8BbeB0IBRt4KjPzF007LuTDdbWeszFVAnx
 InzJwScyq69dz15bYutNy1QLCehPa/g7OLYON+FtTf0Ao34jwNVsBZbJ/cWuSyb8tjlf
 Rgv8+6s8O8NjEIIhCADR/vt5KaWB8cKACpQK/vE3AHs62CmheLY/XRjrjqOTO+M09UMr
 H8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Rp8HAAPCsWVJammpH6MnWmCqSIAb+JYc0EJRNZOl2c=;
 fh=weY2TEjmKIbsVcG7wp3Anr5zAfL0qvgeHuZddlkNhXI=;
 b=f0QdPU2doOpXz/pjT+DcG97nv41UGXMd98P5Azf/tbtWHaLkvagtcOy+TqvmBCZ7Ic
 Uzm7w08lvtPWnHaXI1Ek0eCIZ26OhnpUkTan2iRXWiJyjmQyCJaUB/ehD5aWy9Z8cGjn
 MrW5S4VTTrmcd6Cd3tjdl5vFN0MaKrfje4ybnOuaxnQV1X7/eZlS6x1vzPIxf5tz92/r
 cI2kXBQt/wadzKID36w7OUfOYKYDIQLipztUD2/Uq3w5JZHFZgq1Va+viYwTeHJDbbbW
 iqgyWWeVOdYZcOMMIVh/jlATt8QdW+o+0EY4UzM4Edf7sx7kvAMfE/FDi3lC5b/7orHS
 cF4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785100122; x=1785704922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3Rp8HAAPCsWVJammpH6MnWmCqSIAb+JYc0EJRNZOl2c=;
 b=m/wYaMcKbydbcqmEGlx2JRvFFU+XptuJKiYySFW7ggtYEPlax0Tt5h0/TWOVkIa/sh
 fyDf+thVQSu893XnXbgccW8B0WgWMjHySyMw1ggpdNl6VHdwRDajkJtYq2W0DUQZ7Toc
 jv11FFUfJB47wPL1+c30B8XZw+5j/nUS3P43W1aRXCcaOchymxBUCYk+xWTpwNnCOJvp
 YZ3IGWz/s9C8JACgLbS6K8zL/4mVNwdSJ7lpSwKJ7fs02LnRpnQ2p8covmBhDpVBe3QI
 jLaV/1RQlb24nmKVulw9Yzr7B1ZresHihmg41WCh/fZKxcBtQZMPbFYsgfh7RKQtP6Rc
 7aJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785100122; x=1785704922;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Rp8HAAPCsWVJammpH6MnWmCqSIAb+JYc0EJRNZOl2c=;
 b=XmXPd+snIj2M23dG+I0sv2dSFNGlnBjfSBs/een/ihQ3KKbyq9/T0aiV/PXqIXiQOM
 UGOMaRSG6uc257dgRkOWZUaMVTSmzSRdp2kOKlIO2LnqjQ+cmbyvKz7KtCOr+MlnJAV3
 maJjgGkrosupqXO/OUrf4yfyYIE2i0qq7TE3FkLztIe/qa0tC98l5Jxk4wmNljuIeYUH
 4bxySgYAKz28nvyrIhySfiCgj7aUG2B0hQPwKdzLbi5jfu28JqFS8oPyCaKtbbZ/Vf0B
 tK06zdZJVNVKdO16W43zU41unKDpKS9a3o0PeWXyBC98UK3ncb6B8r0HKWvzAWaRgPWT
 9lxA==
X-Gm-Message-State: AOJu0YxGD1PyKMNrgv+ali7f226XApLBQzioG1rC/XPV0GLYt6oq7oaJ
 Oa2QPWpv6afkpiyZEqjwUvTs2dEczU+pqPehVtfX3yv+oFfBdT8HEQ0/8BgmmVhyppYcYJsq95H
 PJcbLGgHgquza8ltDRjQ3LcS3MYrdURcsWTBAwswVtg==
X-Gm-Gg: AR+sD11fQGxJZRlgtrWAWJpCZ9zlAHzGbjei+7uzp2TFoUwp4aY6Yavr//Drbt28lKA
 e9RK6UOzg4D6Ik98JszxW8wjsd1JBWohvv2Hd/gN9aGbGc/MbSP5OzmQqcOyHG6TqXutjNTl6bl
 MxiMjnf1nGueevMZBxd+chMTU+c++f8jxiErlmLVpvvh+eI+b8OIPCl+WLrjJm+tpiluGQoKjLm
 YzuX28XJ16AR87J9CENBMAg//ViSvIt81YUqsGCfBp32W+rMk63+CaGCl5zMqvWd5rAaiPrAReM
 JP2ImJsrAQpUjJ/43Q==
X-Received: by 2002:a17:90b:2701:b0:38d:e658:5959 with SMTP id
 98e67ed59e1d1-38f293cff43mr5572450a91.5.1785100121685; Sun, 26 Jul 2026
 14:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260726164912-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260726164912-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 01:08:28 +0400
X-Gm-Features: AUfX_mwdOjQjgAriyvr_4G-3RpsS6Vdo9nLW5Pzqi6pYb1OWJfbiy3twwqvDpWM
Message-ID: <CAJ+F1CKGxeSiRR6YWvYNUHYhO9kgfASUTPsA9HC4QBDhm_TZQw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Fixes for 11.1
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Haotian Jiang <jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Mon, Jul 27, 2026 at 12:50=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jul 27, 2026 at 12:43:59AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > Here are some assorted patches worth considering for the 11.1 freeze
> > bug-fix period.
>
> why are these in a single patchset? who is expected to merge it?

Given that they are kind of general coding fixes, I think I can send a
PR once the patch are reviewed.

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > Changes in v2, after Akihiko comments:
> > - split the "Fix many -Werror=3Dmaybe-uninitialized" patch
> > - qdev-monitor: add drain_rcu parameter to avoid deadlock from virtio-n=
et
> > - rewrite WITH_QEMU_LOCK_GUARD/WITH_RCU_READ_LOCK_GUARD macros to suppr=
ess
> >   GCC false-positive warnings (new patch)
> > - block/blkio: use QEMU_LOCK_GUARD instead of WITH_QEMU_LOCK_GUARD in
> >   getlength() to avoid false-positive (new patch)
> > - hw/cxl: split invalid-free fix into its own patch
> > - hw/i3c: fix default return value of d2_i3c_send() (new patch)
> > - hw/ppc: fix dangling machine->fdt reference after spapr fdt updates (=
new patch)
> > - Link to v1: https://lore.kernel.org/qemu-devel/20260725-fix2-v1-0-5c9=
a6ce7b96a@redhat.com
> >
> > ---
> > Marc-Andr=C3=A9 Lureau (12):
> >       hw/display/virtio-gpu-rutabaga: zero-init capset info response
> >       block/blkio: fix error return value on getlength()
> >       block/blkio: fix compiler false-positive warning
> >       include/qemu: adjust LOCK_GUARD macros to avoid potential warning
> >       hw/cxl: fix invalid free on early return
> >       hw/i3c: fix default return value of d2_i3c_send()
> >       Fix some -Werror=3Dmaybe-uninitialized
> >       hw/hexagon: fix machine->fdt leak in qom-test
> >       hw/ppc: fix dangling fdt reference
> >       hw/core/machine: free machine->fdt in machine_finalize()
> >       migration/multifd: fix Error leak in multifd_recv_terminate_threa=
ds()
> >       qdev-monitor: drain RCU callbacks in qdev_device_add_from_qdict
> >
> >  include/monitor/qdev.h           |  3 ++-
> >  include/qemu/lockable.h          | 19 +++++++++++-------
> >  include/qemu/rcu.h               | 17 ++++++++++------
> >  block/blkio.c                    |  7 +++----
> >  hw/audio/intel-hda.c             |  2 +-
> >  hw/core/machine.c                |  1 +
> >  hw/cxl/cxl-host.c                |  2 +-
> >  hw/display/virtio-gpu-rutabaga.c |  2 ++
> >  hw/hexagon/virt.c                |  9 +--------
> >  hw/i3c/dw-i3c.c                  |  2 +-
> >  hw/net/virtio-net.c              |  2 +-
> >  hw/ppc/spapr.c                   |  1 +
> >  hw/ppc/spapr_hcall.c             |  1 +
> >  migration/multifd.c              |  1 +
> >  system/qdev-monitor.c            | 42 +++++++++++++++-----------------=
--------
> >  target/i386/cpu.c                |  3 ++-
> >  target/i386/emulate/x86_mmu.c    |  4 ++--
> >  17 files changed, 59 insertions(+), 59 deletions(-)
> > ---
> > base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
> > change-id: 20260725-fix2-6e51d231794b
> >
> > Best regards,
> > --
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>

