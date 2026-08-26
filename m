Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5CAC61DC7
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzA9D-0004Ko-4j; Wed, 26 Aug 2026 05:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzA9B-0004IA-6R
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzA98-000415-By
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787737333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSRhiRnZLNoz4j1O+xumJH2wghFBy7JpPCbRlPFYp/4=;
 b=cEWxI+3pCwkEFU9T0XH2GfIMzsXyt7AfEBGtIgOhJOpnprNsC/0nThCGmz4jpFlkSw3x6o
 vR8CfHbLrhIoG0K33gwjtry9VNkTqU5HVusUY8T78WC/vpzf4kz8Dz9pKHSp9mteQwr22k
 Rq88jO7igBw+kmDPpESRzqBoKnJimKw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-u79sj8PlNzi0oaPrZVThbw-1; Wed, 26 Aug 2026 05:42:09 -0400
X-MC-Unique: u79sj8PlNzi0oaPrZVThbw-1
X-Mimecast-MFC-AGG-ID: u79sj8PlNzi0oaPrZVThbw_1787737328
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1c2f1acebso1018208a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 02:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787737328; cv=none;
 d=google.com; s=arc-20260327;
 b=tDdVi55DUMVBRYxNEwpKjy+xKBLvVZSWjl/0ugHyDhbTUUwXoNMsZCwb9YhQIEcdx2
 8q2vrYaFz3HrO1gmN3w+CbgINCaauLy1+8so/2lzP5B/rOwUR+plcdFCQzZkMWGj6G/b
 ilyB9mSCDmb9Ry++ww2TuKCMbByfFqoVpPqYJcNiD93u4ojBr7KNy3hihcZRHre2B/8J
 hBM00NCT9Uz5hF1tLZvvj4lt3U3pE0uNl9h4Ytn/lxSjNb8Ize25J7AsQcpx3x9MlQJ/
 7/8Wc3VPhFol4yDlQ1StUqn9y2QH6fVVviIgQYcJkmMYZjQMYvjVyRYBEOGi3ikKYz67
 onIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cSRhiRnZLNoz4j1O+xumJH2wghFBy7JpPCbRlPFYp/4=;
 fh=8Wo7/+QCM+mmxGBCH8dn+sX4s+CZ4s5NapnPAl8coEY=;
 b=kLUTzg5fdQqytO95So1266eTS/DPfj9AKBCaIcn9EA/cTJFKolfClPuMHgqnyC+iE8
 dyaFS05WmRBYNGMLVld6bvIQ58mtBkdbAX9Ssii8scuOJxsOl4g4iS2ksQvBNT+qAEc7
 RQ7b3m5DnncVcbK74BJRz2Q9xgxDp9AFr4WQ4iJ5ON4HJMUcISItwrCdrFLq8lT1fXLw
 eqsCMHZ/HtGa5RM+TBqQnTjhBXSmyLggk16fn2XLMLq00s8QAVbQRZRHYuVYacS2wOSo
 RkXPvsAvt0FjJopWWzmheEmct+p8AgxgsOdXaJzorVsl21IOGAjbPncZwrZswxjzHcQO
 vh4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787737328; x=1788342128; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cSRhiRnZLNoz4j1O+xumJH2wghFBy7JpPCbRlPFYp/4=;
 b=IfPBQUbdBdgqUqOZh97XvB7TLVPJtSsOhuc17PA3I4PygMQXvpoiBzX2xDOwpwLaND
 h5XpYDPwLwaDjZuMt+8DPuYwZEMSmQsuVav7PIQUP4PxFZKHTaw1e6qS71pJXIF3v0Wi
 cKMVDl5MFfP7FOpj8MMt5yVQEntvsQaJ2ORcuoAvdkwkxMhjSmEIo7G6Lk4FE76Updey
 Spu2YPCshBGkDTYQ9BlM3bHzTJxRk1AD6AENhD25glHHaPpZS/HrNVykvzZcvzgOrZ9+
 aY1z3X2sZQKoH3KYi2YWfMFn7DEi+1PzyPKoXNkLfZh3W6Y6XtD/GfqpMIMOcrkblibC
 69XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787737328; x=1788342128;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cSRhiRnZLNoz4j1O+xumJH2wghFBy7JpPCbRlPFYp/4=;
 b=Oz1G26mzY0ic8AaedGKJ5cFB193Pt8kqf5B7fsTSDdrB5WjcBLXOfGgjAIDd2PcgZl
 Q0IbGh9UYoaOC0sfi2xJvP+V5p1TKB6beBS8UTsMm8rBvMOiMT8xyJgvQ4xcDr07DoHo
 V2ki2D4WlxqQRhs4Q/SrIMG1VXScF7ubEOwN7fAOEDp0BmFT2VA6ZeV4OR4MMgZzHdq8
 r6V0HXKyur8+h2xyH1LHcfAcuHDGKwNDzS+fRGxSJFz8Xg3nyGP0598w3mvJgTnlQ3uT
 vvOQL4ii00d3zrS/J0Xm2rb+jqVe2QU33l37NsOWvNkMBH6gjeDmX64nAoINLOdRSCzd
 Gcbw==
X-Gm-Message-State: AFuF++mJShO8vBaF52YMSS58SzH7yI+5jXpqLgU3EW5WcLxxq7nBH+kH
 QN/vMY1UgeKyQezIX5q7J9otK6QjjAEZOLCUIfiwXu7s1Kw5223HmBP15NE76cBgXt5a4Q9XD4M
 MDhXnygsH/JZ+SgdVUg1ATQe0f+ZNfCuazMNXI3aVTY7bqHM0srYoK+Vj9wkWtkyO3EBzM6Y1Kf
 tiCnT6UbkiNx5NUr7xgSrbXMbNoEbojUA=
X-Gm-Gg: AR+sD10XWCun3gAM5cYID4fmu90vSSga7IHnVz69iRCcJwzZfYsIjK4lqt7smaEK6Aw
 9E2o9r6GcgcKy7IOvnO+JNVbZrKLaNS+VTnxMGoQIxx5tv5lDSmB77SNehkCiBSzE8MzIb+ZWbB
 JRT0/vdv1LTVu09g06mbK8RqQJZgVn1Ht4dcFsJMJzAnD3Lb61go451NrkiwMBFI2Hq3jNdfL5d
 uRpg7i5iBUMk4x7nR2KWb83wb9h0AD+nK2JFMAfmw0B6kk3/rt5AxK36hTMyHGxo+POywVffvZd
 uQ==
X-Received: by 2002:a05:6a20:2584:b0:3cc:8344:1213 with SMTP id
 adf61e73a8af0-3cf83531791mr9386584637.8.1787737328117; 
 Wed, 26 Aug 2026 02:42:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:2584:b0:3cc:8344:1213 with SMTP id
 adf61e73a8af0-3cf83531791mr9386473637.8.1787737327525; Wed, 26 Aug 2026
 02:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-36-af60857c2fbe@redhat.com>
 <ao6pyiBkHZJz_9JR@redhat.com>
In-Reply-To: <ao6pyiBkHZJz_9JR@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 13:41:55 +0400
X-Gm-Features: AcwNN1UW47qL6Xcco1r65R6n9lM9Iv0EQgjkA8oE2IKKhKY4fAQjALpMF87caYU
Message-ID: <CAMxuvaz+85Pw=sZG2jXL5jJ_2=kkR5_P69-AZ6bzhVbGTA+5Xg@mail.gmail.com>
Subject: Re: [PATCH v4 36/49] monitor: tighten monitor_printf*()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, zhenwei pi <zhenwei.pi@linux.dev>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>, Richard Henderson <richard.henderson@linaro.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 kvm@vger.kernel.org, 
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

On Wed, Aug 26, 2026 at 12:54=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Tue, Aug 25, 2026 at 11:09:43PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Rename monitor_printf->monitor_hmp_printf, monitor_vprintf->
> > monitor_hmp_vprintf, and monitor_printc->monitor_hmp_printc, changing
> > the first parameter from Monitor * to MonitorHMP * to enforce type
> > safety. The implementation is also simplified: monitor_hmp_vprintf now
> > directly calls g_strdup_vprintf + monitor_puts, removing the virtual
> > dispatch via moncls->vprintf.
> >
> > The dev_print() callbacks are temporarily using the MONITOR_HMP(mon)
> > cast, they are fixed in the following commits.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  audio/audio-hmp-cmds.c                  |   6 +-
> >  backends/cryptodev-hmp-cmds.c           |   9 +-
> >  block/monitor/block-hmp-cmds.c          | 170 +++++++++---------
> >  chardev/char-hmp-cmds.c                 |  12 +-
> >  disas/disas-mon.c                       |  10 +-
> >  docs/devel/style.rst                    |   2 +-
> >  docs/devel/writing-monitor-commands.rst |   8 +-
> >  dump/dump-hmp-cmds.c                    |   5 +-
> >  hw/char/virtio-serial-bus.c             |  10 +-
> >  hw/core/machine-hmp-cmds.c              | 213 +++++++++++-----------
> >  hw/core/sysbus.c                        |   5 +-
> >  hw/hexagon/hexagon_tlb.c                |  44 ++---
> >  hw/i386/kvm/xen-stubs.c                 |   6 +-
> >  hw/i386/kvm/xen_evtchn.c                |  21 +--
> >  hw/i386/sgx-hmp-stub.c                  |   3 +-
> >  hw/i386/sgx.c                           |  29 ++-
> >  hw/misc/auxbus.c                        |   9 +-
> >  hw/misc/mos6522-stub.c                  |   3 +-
> >  hw/net/rocker/rocker-hmp-cmds.c         | 146 ++++++++--------
> >  hw/pci/pci-hmp-cmds.c                   | 114 ++++++------
> >  hw/pci/pci-stub.c                       |   3 +-
> >  hw/s390x/s390-skeys.c                   |   9 +-
> >  hw/s390x/s390-stattrib.c                |  20 +--
> >  hw/uefi/ovmf-log.c                      |   5 +-
> >  hw/usb/bus.c                            |  11 +-
> >  hw/usb/host-libusb.c                    |  21 ++-
> >  hw/virtio/virtio-hmp-cmds.c             | 297 ++++++++++++++++--------=
-------
> >  hw/xen/xen-bus.c                        |   5 +-
> >  include/disas/disas.h                   |   4 +-
> >  include/monitor/hmp.h                   |  12 +-
> >  migration/dirtyrate.c                   |  46 +++--
> >  migration/migration-hmp-cmds.c          | 301 ++++++++++++++++--------=
--------
> >  monitor/hmp-cmds.c                      | 141 +++++++--------
> >  monitor/hmp.c                           | 143 +++++++--------
> >  monitor/monitor-internal.h              |   6 -
> >  monitor/monitor.c                       |  33 ++--
> >  net/net-hmp-cmds.c                      |  31 ++--
> >  net/slirp.c                             |  31 ++--
> >  qom/qom-hmp-cmds.c                      |  27 ++-
> >  replay/replay-debugging.c               |   5 +-
> >  stats/stats-hmp-cmds.c                  |  57 +++---
> >  stubs/hmp-cmd-info_sev.c                |   3 +-
> >  stubs/monitor-core.c                    |   2 +-
> >  system/dirtylimit-hmp-cmds.c            |  10 +-
> >  system/qdev-monitor.c                   |  19 +-
> >  system/runstate-hmp-cmds.c              |  16 +-
> >  system/tpm-hmp-cmds.c                   |  29 ++-
> >  target/i386/cpu-apic.c                  |   3 +-
> >  target/i386/monitor.c                   | 152 ++++++++--------
> >  target/i386/sev.c                       |  35 ++--
> >  target/m68k/monitor.c                   |   3 +-
> >  target/ppc/monitor.c                    |   3 +-
> >  target/riscv/monitor.c                  |  55 +++---
> >  target/sh4/monitor.c                    |  29 ++-
> >  target/sparc/monitor.c                  |   3 +-
> >  target/xtensa/monitor.c                 |   3 +-
> >  tests/unit/test-util-sockets.c          |   2 +-
> >  tools/qemu-vnc/clipboard.c              |   4 +-
> >  tools/qemu-vnc/stubs.c                  |   2 +-
> >  trace/trace-hmp-cmds.c                  |  12 +-
> >  ui/ui-hmp-cmds.c                        | 115 ++++++------
> >  util/error-report.c                     |   2 +-
> >  util/qemu-print.c                       |  11 +-
> >  63 files changed, 1219 insertions(+), 1327 deletions(-)
>
>
>
>
> > diff --git a/util/qemu-print.c b/util/qemu-print.c
> > index 5d4143d425a1..5938f2b6c338 100644
> > --- a/util/qemu-print.c
> > +++ b/util/qemu-print.c
> > @@ -13,6 +13,7 @@
> >  #include "qemu/osdep.h"
> >  #include "monitor/monitor.h"
> >  #include "monitor/hmp.h"
> > +#include "qom/object.h"
> >  #include "qemu/qemu-print.h"
> >
> >  /*
> > @@ -23,8 +24,13 @@
> >  int qemu_vprintf(const char *fmt, va_list ap)
> >  {
> >      Monitor *cur_mon =3D monitor_cur();
> > +
> > +    /* for all monitors: QMP & HMP */
> >      if (cur_mon) {
> > -        return monitor_vprintf(cur_mon, fmt, ap);
> > +        /* don't use monitor_cur_hmp(), to avoid a second lookup */
> > +        MonitorHMP *hmp =3D (MonitorHMP *)
> > +            object_dynamic_cast(OBJECT(cur_mon), TYPE_MONITOR_HMP);
> > +        return monitor_hmp_vprintf(hmp, fmt, ap);
>
> This isn't the same semantics AFAICT.
>
> Original code, if monitor_cur() =3D=3D QMP, we call monitor_vprintf()
> which will return -1.
>
> New code, if monitor_cur() =3D=3D QMP, we will get a NULL back from
> object_dynamic_cast which we then pass into monitor_hmp_vprintf
> which will then crash on monitor_puts() IIUC.

monitor_hmp_vprintf() has an early return, if given NULL monitor, it return=
s -1.

>
> >      }
> >      return vprintf(fmt, ap);
> >  }
> > @@ -55,7 +61,8 @@ int qemu_printf(const char *fmt, ...)
> >  int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
> >  {
> >      if (!stream) {
> > -        return monitor_vprintf(monitor_cur(), fmt, ap);
> > +        MonitorHMP *hmp =3D monitor_cur_hmp();
> > +        return monitor_hmp_vprintf(hmp, fmt, ap);
>
> Same, this should crash on QMP now IIUC.
>
> >      }
> >      return vfprintf(stream, fmt, ap);
> >  }
> >
> > --
> > 2.55.0.543.g5ebe2ebe4ea8
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


