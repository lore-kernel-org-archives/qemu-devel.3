Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39DCC5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUlu-0001D2-E4; Mon, 24 Aug 2026 09:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUls-0001Bx-Qb
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUlm-0005xU-SZ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787578281;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XsWBXPS/V2WZm3P1W2Es0QTI78TJXsGrW3XAaRNazE=;
 b=iXP52OvpG2uATdFjCGB/7Kjm/Z6rJ3D+rJjOHyfexRjCzN66ctvcxJmKjghV413oDgw1dr
 I02aqjmYhXu8Sb+lxlpe4yUNbxNAI0X6fUtwOT2wLlfUQFN93uJGV2qVuJT4cWMpLaAV79
 UCyhAUN7pGuk7yG9pxKVDRQmg+F211I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-dWc6ihGGPXO-XUSR3P0thw-1; Mon,
 24 Aug 2026 09:31:18 -0400
X-MC-Unique: dWc6ihGGPXO-XUSR3P0thw-1
X-Mimecast-MFC-AGG-ID: dWc6ihGGPXO-XUSR3P0thw_1787578269
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C3DF195FD03; Mon, 24 Aug 2026 13:31:08 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26F5C18005BB; Mon, 24 Aug 2026 13:30:53 +0000 (UTC)
Date: Mon, 24 Aug 2026 14:30:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
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
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 31/49] monitor: change HMPCommand cmd to take MonitorHMP
Message-ID: <aoxHi-PfII_4Dh5-@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-31-e53fc35bc550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-31-e53fc35bc550@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Aug 16, 2026 at 11:12:58PM +0400, Marc-André Lureau wrote:
> HMP commands are specific to the HMP monitor, so make the cmd function
> pointer in HMPCommand take MonitorHMP * instead of Monitor *. This
> strengthens type safety and makes the HMP-specific nature of these
> handlers explicit.
> 
> Handler functions are renamed to take MonitorHMP *hmp, with a local
> Monitor *mon = MONITOR(hmp) added where the body needs the base type.
> Following patches will drop it, since most functions are HMP specific.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  audio/audio-hmp-cmds.c          |   8 +-
>  backends/cryptodev-hmp-cmds.c   |   3 +-
>  block/monitor/block-hmp-cmds.c  |  78 +++++++----
>  chardev/char-hmp-cmds.c         |  21 ++-
>  dump/dump-hmp-cmds.c            |   6 +-
>  hw/core/machine-hmp-cmds.c      |  49 ++++---
>  hw/i386/kvm/xen-stubs.c         |   6 +-
>  hw/i386/kvm/xen_evtchn.c        |   6 +-
>  hw/i386/sgx-hmp-stub.c          |   3 +-
>  hw/i386/sgx.c                   |   3 +-
>  hw/misc/mos6522-stub.c          |   3 +-
>  hw/misc/mos6522.c               |   3 +-
>  hw/net/rocker/rocker-hmp-cmds.c |  12 +-
>  hw/pci/pci-hmp-cmds.c           |   6 +-
>  hw/pci/pci-stub.c               |   5 +-
>  hw/s390x/s390-skeys.c           |   5 +-
>  hw/s390x/s390-stattrib.c        |   6 +-
>  hw/uefi/ovmf-log.c              |   3 +-
>  hw/usb/host-libusb.c            |   3 +-
>  hw/virtio/virtio-hmp-cmds.c     |  15 +-
>  include/block/block-hmp-cmds.h  |  55 ++++----
>  include/hw/usb/usb.h            |   3 +-
>  include/monitor/hmp.h           | 294 ++++++++++++++++++++--------------------
>  include/monitor/qdev.h          |   5 +-
>  include/net/net.h               |   5 +-
>  include/net/slirp.h             |   8 +-
>  migration/dirtyrate.c           |   6 +-
>  migration/migration-hmp-cmds.c  |  48 ++++---
>  monitor/hmp-cmds.c              |  96 ++++++++-----
>  monitor/hmp.c                   |  17 ++-
>  monitor/monitor-internal.h      |   2 +-
>  net/net-hmp-cmds.c              |  14 +-
>  net/slirp.c                     |   9 +-
>  qom/qom-hmp-cmds.c              |  18 ++-
>  replay/replay-debugging.c       |   9 +-
>  replay/stubs-system.c           |   8 +-
>  stats/stats-hmp-cmds.c          |   3 +-
>  stubs/hmp-cmd-info_sev.c        |   3 +-
>  system/dirtylimit-hmp-cmds.c    |   9 +-
>  system/qdev-monitor.c           |  11 +-
>  system/runstate-hmp-cmds.c      |   9 +-
>  system/tpm-hmp-cmds.c           |   3 +-
>  target/i386/cpu-apic.c          |   3 +-
>  target/i386/monitor.c           |   9 +-
>  target/i386/sev.c               |   3 +-
>  target/m68k/monitor.c           |   3 +-
>  target/ppc/monitor.c            |   3 +-
>  target/riscv/monitor.c          |   3 +-
>  target/sh4/monitor.c            |   3 +-
>  target/sparc/monitor.c          |   3 +-
>  target/xtensa/monitor.c         |   3 +-
>  trace/trace-hmp-cmds.c          |   8 +-
>  ui/ui-hmp-cmds.c                |  31 +++--
>  53 files changed, 561 insertions(+), 390 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


