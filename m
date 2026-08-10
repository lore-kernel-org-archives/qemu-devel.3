Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62579C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUrU-0005WZ-2v; Mon, 10 Aug 2026 14:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUrS-0005WJ-MM
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUrR-000745-3W
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786386992;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWl/hqj1z8dudvTSRAE3GSywk31IFV9L+QRET2MFNdw=;
 b=Grx9fub3PN0jDqqqih6VNx9dAwfV35odd3IUBrjR68eXnXZp9QUDKK45Bl9HxsTVzmlDkd
 btqWLWmA8wPIxcfm9ONvhhTtlv5BvixE2jtY7LUd+nScNo6knUaeWsK+wL8g8csi+dYli/
 5w1pcfhQKNE8goInRxvdDhUMJRjKhmU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-QuP_kaBTNT6hyaDHNwMwhQ-1; Mon,
 10 Aug 2026 14:36:29 -0400
X-MC-Unique: QuP_kaBTNT6hyaDHNwMwhQ-1
X-Mimecast-MFC-AGG-ID: QuP_kaBTNT6hyaDHNwMwhQ_1786386988
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6C7C1800658; Mon, 10 Aug 2026 18:36:27 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7729919560AB; Mon, 10 Aug 2026 18:36:26 +0000 (UTC)
Date: Mon, 10 Aug 2026 19:36:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 34/39] Guard HMP command implementations with CONFIG_HMP
Message-ID: <anoaJ28VOtso655d@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-34-8af31bc54c61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626-qemu-no-hmp-v2-34-8af31bc54c61@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 26, 2026 at 01:19:35AM +0400, Marc-André Lureau wrote:
> Add #ifdef CONFIG_HMP around all hmp_* function implementations and
> their HMP-only helpers across subsystems.
> 
> This covers monitor_register_hmp* callers, hmp_info_* handlers, and
> HMP-only helper functions like slirp_lookup.
> 
> To link succesfully, use empty cmds tables in hmp-cmds.c (to be removed
> once meson build-sys is updated with !hmp support later in the series)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  accel/accel-system.c      | 2 ++
>  accel/tcg/monitor.c       | 2 ++
>  hw/i386/kvm/xen-stubs.c   | 2 ++
>  hw/i386/kvm/xen_evtchn.c  | 3 ++-
>  hw/i386/sgx.c             | 2 ++
>  hw/misc/mos6522-stub.c    | 2 ++
>  hw/misc/mos6522.c         | 2 ++
>  hw/pci/pci-stub.c         | 2 ++
>  hw/s390x/s390-skeys.c     | 2 ++
>  hw/s390x/s390-stattrib.c  | 4 ++++
>  hw/uefi/ovmf-log.c        | 2 ++
>  hw/usb/host-libusb.c      | 6 ++++++
>  migration/dirtyrate.c     | 2 ++
>  monitor/hmp-cmds.c        | 5 +++++
>  net/slirp.c               | 7 ++++++-
>  replay/replay-debugging.c | 8 ++++++++
>  replay/stubs-system.c     | 6 ++++++
>  system/dirtylimit.c       | 6 ++++++
>  system/qdev-monitor.c     | 4 ++++
>  target/i386/cpu-apic.c    | 2 ++
>  target/i386/monitor.c     | 3 +++
>  target/i386/sev.c         | 2 ++
>  target/m68k/monitor.c     | 2 ++
>  target/ppc/monitor.c      | 2 ++
>  target/riscv/monitor.c    | 3 +++
>  target/sh4/monitor.c      | 2 ++
>  target/sparc/monitor.c    | 2 ++
>  target/xtensa/monitor.c   | 2 ++
>  28 files changed, 87 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


