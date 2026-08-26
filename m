Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C89C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDFE-0006RS-Cd; Wed, 26 Aug 2026 09:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzDFC-0006RJ-UY
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzDFA-00089H-NQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787749238;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AUHZYFdLPFwyPgYUi3NOCI9ekXAW2UkZfq/9uZy4N10=;
 b=Kp1DdQ80Xyznnp+eprE0fNbfJfetRTnKJxoMwFHkHmzb0wcI5umOXdXvJupNA1bUqcqqzN
 HAxaSjJM4sYVooMQyOsRCv+btuZRSisUAeZt2RF7iO+idatErCjx7G4EU4zR7YwubDT/SE
 1Ti+W1Xp1r7ksrxcbCx2/dlMr9SkByY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-iCq5OVxhP42KJLXq8UF4qA-1; Wed,
 26 Aug 2026 09:00:34 -0400
X-MC-Unique: iCq5OVxhP42KJLXq8UF4qA-1
X-Mimecast-MFC-AGG-ID: iCq5OVxhP42KJLXq8UF4qA_1787749226
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F9E01953957; Wed, 26 Aug 2026 13:00:25 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63B8B1955F06; Wed, 26 Aug 2026 13:00:14 +0000 (UTC)
Date: Wed, 26 Aug 2026 14:00:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 12/12] meson: link ARM and RISC-V into qemu-system
Message-ID: <ao7jWx-zfmB9AUEb@redhat.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <20260823150731.896-13-luoyonggang@gmail.com>
 <b9f0853b-adda-457d-94e1-add9bb2a2548@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9f0853b-adda-457d-94e1-add9bb2a2548@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Mon, Aug 24, 2026 at 09:20:38AM -0700, Pierrick Bouvier wrote:
> On 8/23/2026 8:07 AM, Yonggang Luo wrote:
> > - Build qemu-system (and qemu-systemw on Windows) from aarch64
> >   common/system objects plus RISC-V arch objects taken from the
> >   existing riscv64 lib.
> > - Pull 32-bit TargetInfo and 32-only boards from the arm/riscv32
> >   libs so hw/arm and target/riscv are not compiled twice.
> > - Skip linking qemu-system-{arm,aarch64,riscv32,riscv64} and the
> >   Windows *w variants; symlink those names to qemu-system so
> >   argv[0] still selects TargetInfo.
> > 
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  meson.build | 156 +++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 147 insertions(+), 9 deletions(-)

I think this approach of taking common/system from aarch64
and adding in riscv specific objects only works by luck.

That's not obvious from your patch, but Pierrick's counterproposal
below will expose it with a little  tweak....


> From 6261b0c255e1a8f0df2b41928b8dfb365d0fa488 Mon Sep 17 00:00:00 2001
> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Date: Tue, 14 Apr 2026 10:56:15 -0700
> Subject: [PATCH] meson: build single binary
> 
> This is not built by default.
> Build with: ninja -C build qemu-system
> 
> All available *-softmmu targets are aggregated, ./configure
> --target-list can be used to restrict which targets are included.
> 
> In case user has targets that are not supported, we emit an error
> message when build qemu-system target. This way, it's not necessary to
> have a custom configure flag, and qemu-system can live next to existing
> binaries without complexifying the workflow more than it is already.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  meson.build | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 553df3e7f053..4a31a520d9eb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4264,6 +4264,9 @@ if host_os == 'darwin'
>  endif
>  
>  traceable = []
> +single_binary_libs = []
> +single_binary_deps = []
> +single_binary_crates = []
>  emulators = {}
>  foreach target : target_dirs
>    config_target = config_target_mak[target]
> @@ -4419,6 +4422,10 @@ foreach target : target_dirs
>                   build_by_default: false)
>  
>    if target.endswith('-softmmu')
> +    single_binary_libs += lib
> +    single_binary_deps += arch_deps
> +    single_binary_deps += target_stubs
> +    single_binary_crates += main_rs
>      execs = [{
>        'name': 'qemu-system-' + target_name,
>        'win_subsystem': 'console',
> @@ -4500,6 +4507,47 @@ foreach target : target_dirs
>    endforeach
>  endforeach
>  
> +single_binary_objects = []
> +foreach lib: single_binary_libs
> +  single_binary_objects += lib.extract_all_objects(recursive: true)
> +endforeach
> +
> +single_binary_link_args = emulator_link_args
> +single_binary_link_args += enable_modules ? ['@block.syms', '@qemu.syms'] : []
> +
> +supported_targets = [
> +  'aarch64-softmmu',
> +  'arm-softmmu',
> +]

Adding in riscv64-softmmu to this list and building with
configure --target-list=aarch64-softmmu,riscv64-softmmu
will fail with this meson approach.

Specifically we'll hit duplicate symbols to to taking
different KConfig branches, resulting in building in
both the real impl and the stubs:

  /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge_stubs.c.o: in function `pxb_cxl_hook_up_registers':
/home/berrange/src/virt/qemu/build-alt/../hw/pci-bridge/pci_expander_bridge_stubs.c:14: multiple definition of `pxb_cxl_hook_up_registers'; libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o:/home/berrange/src/virt/qemu/build-alt/../hw/pci-bridge/pci_expander_bridge.c:214: first defined here

The problem is that aarch64 enables CONFIG_PXB and
riscv64 does not.

Yonggang's patch only worked by luck since it preferred
to the common system objects from aarch64 and thus kept
the real PXB impl. If Yonggang had instead used common
system objects from riscv64, the qemu-system would have
lost the PXB impl and got a stub.

This is unfixable if both targets have some Kconfigs
that the other target does not.

So to be able to build qemu-system, we can't simply
pull in the union of objects from each architecture
qemu-system-$TARGET binary. 

Instead we need to setup a new Kconfig specifically
for qemu-system, which is the combination of all
Kconfigs from each target. Then derive a new list
of objects from that.  This shouldn't involve building
any more .o files, just means we build an accurate
list of what .o files we need.

> +unsupported_targets = []
> +foreach target : target_dirs
> +  if target.endswith('-softmmu') and target not in supported_targets
> +    unsupported_targets += target
> +  endif
> +endforeach
> +
> +if unsupported_targets.length() == 0
> +  executable('qemu-system',
> +             sources: [single_binary_crates, files('system/main.c')],
> +             dependencies: single_binary_deps,
> +             objects: single_binary_objects,
> +             link_depends: [block_syms, qemu_syms],
> +             link_args: single_binary_link_args,
> +             build_by_default: false)
> +else
> +  error_str = f'''qemu-system only support targets:
> +@supported_targets@

With the Kconfig union problem solved, IMHO we should unconditionally
always build the 'qemu-system' binary. If there are targets that
do not yet support the single bniary concept that's fine, just ignore
them. qemu-system-$TARGET will still be built for everything, and
qemu-system only needs to include what's currently possible.


> +
> +unsupported targets:
> +@unsupported_targets@
> +
> +use ./configure --target-list= to choose list of targets'''
> +  t = custom_target(command: ['sh', '-c', 'echo "' + error_str + '" && exit 1'],
> +                    output: 'none',
> +                    build_by_default: false)
> +  alias_target('qemu-system', t)
> +endif
> +
>  # Other build targets
>  
>  if get_option('plugins')


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


