Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AE4C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAUW-0000xu-4t; Wed, 26 Aug 2026 06:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzAUR-0000x3-8D
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzAUO-0002wp-04
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787738651;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yA81iAgWN+lZLxuNDfTXoR2CGhanHz154Xrqq+MkBZU=;
 b=bRRAi2djJ9LsMMfaLmwslh1CO/8xEij+GFJ2DP4b/qe3H3ELIgNNtNbbYqw7PS0uvO80d8
 hoI4UFVn2HXBaiSGLKqj+DW6Cq4rySoKYfNHHgtTpKMJF9Pi2iXSj76gIXWdzAUO4tj8st
 7x4UTRGHS7fWeiCxR3Mbo/ALOnBgHno=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-hzOFc47gMD27ZIlhwAbX6w-1; Wed,
 26 Aug 2026 06:04:07 -0400
X-MC-Unique: hzOFc47gMD27ZIlhwAbX6w-1
X-Mimecast-MFC-AGG-ID: hzOFc47gMD27ZIlhwAbX6w_1787738641
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10553190FFB4; Wed, 26 Aug 2026 10:04:00 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58E0440E; Wed, 26 Aug 2026 10:03:43 +0000 (UTC)
Date: Wed, 26 Aug 2026 11:03:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v4 36/49] monitor: tighten monitor_printf*()
Message-ID: <ao65_XCKmkpm9s2F@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-36-af60857c2fbe@redhat.com>
 <ao6pyiBkHZJz_9JR@redhat.com>
 <CAMxuvaz+85Pw=sZG2jXL5jJ_2=kkR5_P69-AZ6bzhVbGTA+5Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaz+85Pw=sZG2jXL5jJ_2=kkR5_P69-AZ6bzhVbGTA+5Xg@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 26, 2026 at 01:41:55PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Aug 26, 2026 at 12:54 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Aug 25, 2026 at 11:09:43PM +0400, Marc-André Lureau wrote:
> > > Rename monitor_printf->monitor_hmp_printf, monitor_vprintf->
> > > monitor_hmp_vprintf, and monitor_printc->monitor_hmp_printc, changing
> > > the first parameter from Monitor * to MonitorHMP * to enforce type
> > > safety. The implementation is also simplified: monitor_hmp_vprintf now
> > > directly calls g_strdup_vprintf + monitor_puts, removing the virtual
> > > dispatch via moncls->vprintf.
> > >
> > > The dev_print() callbacks are temporarily using the MONITOR_HMP(mon)
> > > cast, they are fixed in the following commits.
> > >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  audio/audio-hmp-cmds.c                  |   6 +-
> > >  backends/cryptodev-hmp-cmds.c           |   9 +-
> > >  block/monitor/block-hmp-cmds.c          | 170 +++++++++---------
> > >  chardev/char-hmp-cmds.c                 |  12 +-
> > >  disas/disas-mon.c                       |  10 +-
> > >  docs/devel/style.rst                    |   2 +-
> > >  docs/devel/writing-monitor-commands.rst |   8 +-
> > >  dump/dump-hmp-cmds.c                    |   5 +-
> > >  hw/char/virtio-serial-bus.c             |  10 +-
> > >  hw/core/machine-hmp-cmds.c              | 213 +++++++++++-----------
> > >  hw/core/sysbus.c                        |   5 +-
> > >  hw/hexagon/hexagon_tlb.c                |  44 ++---
> > >  hw/i386/kvm/xen-stubs.c                 |   6 +-
> > >  hw/i386/kvm/xen_evtchn.c                |  21 +--
> > >  hw/i386/sgx-hmp-stub.c                  |   3 +-
> > >  hw/i386/sgx.c                           |  29 ++-
> > >  hw/misc/auxbus.c                        |   9 +-
> > >  hw/misc/mos6522-stub.c                  |   3 +-
> > >  hw/net/rocker/rocker-hmp-cmds.c         | 146 ++++++++--------
> > >  hw/pci/pci-hmp-cmds.c                   | 114 ++++++------
> > >  hw/pci/pci-stub.c                       |   3 +-
> > >  hw/s390x/s390-skeys.c                   |   9 +-
> > >  hw/s390x/s390-stattrib.c                |  20 +--
> > >  hw/uefi/ovmf-log.c                      |   5 +-
> > >  hw/usb/bus.c                            |  11 +-
> > >  hw/usb/host-libusb.c                    |  21 ++-
> > >  hw/virtio/virtio-hmp-cmds.c             | 297 ++++++++++++++++---------------
> > >  hw/xen/xen-bus.c                        |   5 +-
> > >  include/disas/disas.h                   |   4 +-
> > >  include/monitor/hmp.h                   |  12 +-
> > >  migration/dirtyrate.c                   |  46 +++--
> > >  migration/migration-hmp-cmds.c          | 301 ++++++++++++++++----------------
> > >  monitor/hmp-cmds.c                      | 141 +++++++--------
> > >  monitor/hmp.c                           | 143 +++++++--------
> > >  monitor/monitor-internal.h              |   6 -
> > >  monitor/monitor.c                       |  33 ++--
> > >  net/net-hmp-cmds.c                      |  31 ++--
> > >  net/slirp.c                             |  31 ++--
> > >  qom/qom-hmp-cmds.c                      |  27 ++-
> > >  replay/replay-debugging.c               |   5 +-
> > >  stats/stats-hmp-cmds.c                  |  57 +++---
> > >  stubs/hmp-cmd-info_sev.c                |   3 +-
> > >  stubs/monitor-core.c                    |   2 +-
> > >  system/dirtylimit-hmp-cmds.c            |  10 +-
> > >  system/qdev-monitor.c                   |  19 +-
> > >  system/runstate-hmp-cmds.c              |  16 +-
> > >  system/tpm-hmp-cmds.c                   |  29 ++-
> > >  target/i386/cpu-apic.c                  |   3 +-
> > >  target/i386/monitor.c                   | 152 ++++++++--------
> > >  target/i386/sev.c                       |  35 ++--
> > >  target/m68k/monitor.c                   |   3 +-
> > >  target/ppc/monitor.c                    |   3 +-
> > >  target/riscv/monitor.c                  |  55 +++---
> > >  target/sh4/monitor.c                    |  29 ++-
> > >  target/sparc/monitor.c                  |   3 +-
> > >  target/xtensa/monitor.c                 |   3 +-
> > >  tests/unit/test-util-sockets.c          |   2 +-
> > >  tools/qemu-vnc/clipboard.c              |   4 +-
> > >  tools/qemu-vnc/stubs.c                  |   2 +-
> > >  trace/trace-hmp-cmds.c                  |  12 +-
> > >  ui/ui-hmp-cmds.c                        | 115 ++++++------
> > >  util/error-report.c                     |   2 +-
> > >  util/qemu-print.c                       |  11 +-
> > >  63 files changed, 1219 insertions(+), 1327 deletions(-)
> >
> >
> >
> >
> > > diff --git a/util/qemu-print.c b/util/qemu-print.c
> > > index 5d4143d425a1..5938f2b6c338 100644
> > > --- a/util/qemu-print.c
> > > +++ b/util/qemu-print.c
> > > @@ -13,6 +13,7 @@
> > >  #include "qemu/osdep.h"
> > >  #include "monitor/monitor.h"
> > >  #include "monitor/hmp.h"
> > > +#include "qom/object.h"
> > >  #include "qemu/qemu-print.h"
> > >
> > >  /*
> > > @@ -23,8 +24,13 @@
> > >  int qemu_vprintf(const char *fmt, va_list ap)
> > >  {
> > >      Monitor *cur_mon = monitor_cur();
> > > +
> > > +    /* for all monitors: QMP & HMP */
> > >      if (cur_mon) {
> > > -        return monitor_vprintf(cur_mon, fmt, ap);
> > > +        /* don't use monitor_cur_hmp(), to avoid a second lookup */
> > > +        MonitorHMP *hmp = (MonitorHMP *)
> > > +            object_dynamic_cast(OBJECT(cur_mon), TYPE_MONITOR_HMP);
> > > +        return monitor_hmp_vprintf(hmp, fmt, ap);
> >
> > This isn't the same semantics AFAICT.
> >
> > Original code, if monitor_cur() == QMP, we call monitor_vprintf()
> > which will return -1.
> >
> > New code, if monitor_cur() == QMP, we will get a NULL back from
> > object_dynamic_cast which we then pass into monitor_hmp_vprintf
> > which will then crash on monitor_puts() IIUC.
> 
> monitor_hmp_vprintf() has an early return, if given NULL monitor, it returns -1.

Hmm, I feel like we should be dealing with NULL in this method, as it
is surprising to be calling a monitor_hmp_XXX method in scenario where
QMP is a (theoretical) possibility.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


