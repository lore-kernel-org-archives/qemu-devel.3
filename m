Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3386EC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woH4Q-0006Jx-Qb; Mon, 27 Jul 2026 04:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woH4G-0006J8-0I
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woH4D-0006jq-Ii
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785142325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGmPWZb+BE6aa3oUZZXhdk8ZQlf6vpMUZMjM2NnD8uc=;
 b=bwqPa7+XjsOtUT8Q3D0OikAAT2Wd40PiDgpcpVFEA9tePK4FfRJkuCY6ggOvXyInWQabbv
 LpMygh3xlLqhDtW9PoRnIbedUHjxXk6EM6hf3tAYMfC+pZohER8ZR+Ze2KEwzHgTU3JamI
 8sK5MjxNRTSciGMOYY6jN3ndOlmPNak=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-C69BCP4qPqGqVjY28h2uDg-1; Mon, 27 Jul 2026 04:52:03 -0400
X-MC-Unique: C69BCP4qPqGqVjY28h2uDg-1
X-Mimecast-MFC-AGG-ID: C69BCP4qPqGqVjY28h2uDg_1785142322
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f753a0aa0so1503734f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785142322; x=1785747122; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EGmPWZb+BE6aa3oUZZXhdk8ZQlf6vpMUZMjM2NnD8uc=;
 b=C7DH8TGgOoNluhcHXlWwkmwBwVD1GIoXeT5DX6xtAQvdpQF1vnx/FHOSJ52SSMD+ZN
 BQ/umEpQT4oAzJ+o1fglID8X6jPzfP1FLntvb+va1TtIsWh1wSUgG+68rdGzrFSeDQ2E
 032rf7DBkRJbMXL32+cQbRmf0CwrYfBARxDa6c+XJwYWP9rhyJdfSZBfR7ng4h+rF4bS
 6jBhEJh4m4HezQe8OayA16jAtqNkVbM7E2qE6ISnyMdsj9mDrrQgiJR8PvrEZ4zZ28kM
 BzzvENR4vYUJJIh97Hj92F9Sd3kTFC7C+1pOxbfH43DyfKdPHzmhU0k12E3IE6ho9b+S
 7lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785142322; x=1785747122;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EGmPWZb+BE6aa3oUZZXhdk8ZQlf6vpMUZMjM2NnD8uc=;
 b=bSgEnEO1XxYACy+KueFrG5WHc7rB0DaKMi3WSvKdRYxPB3Y0s0cFnnsJkUmttWvbZ4
 z09AxvIbEjeWeof+m9G7bcLEvOq/64I4SLNuVU71TrA4d98GhmVXbn1erImWipmZRqrY
 rICkTvGWVlzcISjvJlxvofjsZboskBzRE0fLmtT4+x3c8iY3/VfJWxP4k9cYqaLTROtN
 +wGrluPV8uUYAYdCeRsbJOmhkh6umD7NG2Tgv6Oc6uTqHJltNvE7HxHO9blgPUuIgMtz
 13Th09/tlEolPnLhEbSejES1fACAJITDPhpawGboC4c+a4YczCjppB5MwIgpvakKsXra
 6lCA==
X-Gm-Message-State: AOJu0Yy2JqlzQDFX7ffsHhYY7dBjDPYS1PZmqxyV/3d4sCBEvbMxG4Hl
 iIJnFbObnlds1Fg+r7tjS0rORoPn6+GxTE1GcYeXA4ac5SI6VFSe2H0iZSJ3D3w654829DEA5oF
 0JuB4yzGShZooda/hK4vST1OVJZX9re7uqzTKE/+d4TgD9+90TAyBwgwX
X-Gm-Gg: AR+sD12OI0HZuSHHDLaaezoD+k0Z2hIj8qEYhHP2akQdIBJyPUGlpcGtXJ4m4svrS85
 d8Pn3yTlBvOiZLQAwJToeutVe/IhL/hePiMUjyKNpFmT6WKENS/05VYWFRe77bzCCcN9QFqhA97
 w8aj9FDINdOfoD746g9cLmipCcuIebyNVJ2UIMt21UXaCe87fbREJ5H+KzA8YPwz9OBkHkjKJNe
 JO7uc6zqfN8ULFHJn6kZ7nkVPWVd65cKm8bM+s7poQ5sHG/b0g5E6QOg+2nLTte3E63g6b7RW/k
 gdbYAT5ePGGZHziFa/ubPgaq90TYEI6pwah8MDiuRSmyKoWA2rdONkrBLjN2/Gtb3D1qSzEKqzR
 dBq2TteFU1rYYkfR60GPUKw==
X-Received: by 2002:a05:6000:1883:b0:47f:9447:62bf with SMTP id
 ffacd0b85a97d-47f9fc8665bmr9304575f8f.2.1785142322460; 
 Mon, 27 Jul 2026 01:52:02 -0700 (PDT)
X-Received: by 2002:a05:6000:1883:b0:47f:9447:62bf with SMTP id
 ffacd0b85a97d-47f9fc8665bmr9304504f8f.2.1785142321791; 
 Mon, 27 Jul 2026 01:52:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6e9a2sm49073219f8f.35.2026.07.27.01.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 01:52:01 -0700 (PDT)
Date: Mon, 27 Jul 2026 04:51:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: Re: [PATCH v2 00/12] Fixes for 11.1
Message-ID: <20260727045129-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260726164912-mutt-send-email-mst@kernel.org>
 <CAJ+F1CKGxeSiRR6YWvYNUHYhO9kgfASUTPsA9HC4QBDhm_TZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKGxeSiRR6YWvYNUHYhO9kgfASUTPsA9HC4QBDhm_TZQw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 27, 2026 at 01:08:28AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Jul 27, 2026 at 12:50 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 27, 2026 at 12:43:59AM +0400, Marc-André Lureau wrote:
> > > Hi
> > >
> > > Here are some assorted patches worth considering for the 11.1 freeze
> > > bug-fix period.
> >
> > why are these in a single patchset? who is expected to merge it?
> 
> Given that they are kind of general coding fixes, I think I can send a
> PR once the patch are reviewed.

I have no problem with that just pls mention this down the road
when it's ready.

> >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > > Changes in v2, after Akihiko comments:
> > > - split the "Fix many -Werror=maybe-uninitialized" patch
> > > - qdev-monitor: add drain_rcu parameter to avoid deadlock from virtio-net
> > > - rewrite WITH_QEMU_LOCK_GUARD/WITH_RCU_READ_LOCK_GUARD macros to suppress
> > >   GCC false-positive warnings (new patch)
> > > - block/blkio: use QEMU_LOCK_GUARD instead of WITH_QEMU_LOCK_GUARD in
> > >   getlength() to avoid false-positive (new patch)
> > > - hw/cxl: split invalid-free fix into its own patch
> > > - hw/i3c: fix default return value of d2_i3c_send() (new patch)
> > > - hw/ppc: fix dangling machine->fdt reference after spapr fdt updates (new patch)
> > > - Link to v1: https://lore.kernel.org/qemu-devel/20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com
> > >
> > > ---
> > > Marc-André Lureau (12):
> > >       hw/display/virtio-gpu-rutabaga: zero-init capset info response
> > >       block/blkio: fix error return value on getlength()
> > >       block/blkio: fix compiler false-positive warning
> > >       include/qemu: adjust LOCK_GUARD macros to avoid potential warning
> > >       hw/cxl: fix invalid free on early return
> > >       hw/i3c: fix default return value of d2_i3c_send()
> > >       Fix some -Werror=maybe-uninitialized
> > >       hw/hexagon: fix machine->fdt leak in qom-test
> > >       hw/ppc: fix dangling fdt reference
> > >       hw/core/machine: free machine->fdt in machine_finalize()
> > >       migration/multifd: fix Error leak in multifd_recv_terminate_threads()
> > >       qdev-monitor: drain RCU callbacks in qdev_device_add_from_qdict
> > >
> > >  include/monitor/qdev.h           |  3 ++-
> > >  include/qemu/lockable.h          | 19 +++++++++++-------
> > >  include/qemu/rcu.h               | 17 ++++++++++------
> > >  block/blkio.c                    |  7 +++----
> > >  hw/audio/intel-hda.c             |  2 +-
> > >  hw/core/machine.c                |  1 +
> > >  hw/cxl/cxl-host.c                |  2 +-
> > >  hw/display/virtio-gpu-rutabaga.c |  2 ++
> > >  hw/hexagon/virt.c                |  9 +--------
> > >  hw/i3c/dw-i3c.c                  |  2 +-
> > >  hw/net/virtio-net.c              |  2 +-
> > >  hw/ppc/spapr.c                   |  1 +
> > >  hw/ppc/spapr_hcall.c             |  1 +
> > >  migration/multifd.c              |  1 +
> > >  system/qdev-monitor.c            | 42 +++++++++++++++-------------------------
> > >  target/i386/cpu.c                |  3 ++-
> > >  target/i386/emulate/x86_mmu.c    |  4 ++--
> > >  17 files changed, 59 insertions(+), 59 deletions(-)
> > > ---
> > > base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
> > > change-id: 20260725-fix2-6e51d231794b
> > >
> > > Best regards,
> > > --
> > > Marc-André Lureau <marcandre.lureau@redhat.com>
> >
> >


