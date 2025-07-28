Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A06C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 16:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugQX0-0003IK-Ca; Mon, 28 Jul 2025 12:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugQWx-0003Hh-Qv
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 12:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugQWu-0006BW-0a
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 12:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753719405;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AURksFX0F17lPOWzmDpHjiRKbH+5saGARonbzyTPzBI=;
 b=TFLL2k0cTFPYfBxzoPaDTbp+aWPTiU5c3vEuQASO3tS84G682vk0P4XrMjBJuty6SukkR8
 Ow4zi5IHBcAo80Je9OyiHtdpaOvSRRLBXIZ7gD7hKR051JFiX9htNiOb9N3JIGtPmWS5z7
 463u7Vi0zKQ78Sv9PweLJrvAegtxKcc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-HPtZP_bcOWCeFO7xyVGJow-1; Mon,
 28 Jul 2025 12:16:43 -0400
X-MC-Unique: HPtZP_bcOWCeFO7xyVGJow-1
X-Mimecast-MFC-AGG-ID: HPtZP_bcOWCeFO7xyVGJow_1753719402
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 858681800115; Mon, 28 Jul 2025 16:16:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66F8930001B1; Mon, 28 Jul 2025 16:16:41 +0000 (UTC)
Date: Mon, 28 Jul 2025 17:16:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] pc-bios/meson: split blobs by available targets
Message-ID: <aIeiZu57THJpFv6R@redhat.com>
References: <20250619111632.1076331-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250619111632.1076331-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 19, 2025 at 12:16:32PM +0100, Alex Bennée wrote:
> While building some kvm-unit-tests inside a buildroot environment I
> noticed the QEMU installer installs all blobs regardless of the
> enabled targets. Buildroot images typically try and keep filesystem
> and thin as possible we probably should skip blobs that will never be
> used.
> 
> We could also go further and refer to enabled devices to further
> filter out things like option roms.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  pc-bios/meson.build | 202 ++++++++++++++++++++++++++++----------------
>  1 file changed, 129 insertions(+), 73 deletions(-)
> 
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index 3c41620044..cb0b59fbce 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -1,19 +1,36 @@
>  roms = []
>  if unpack_edk2_blobs
> -  fds = [
> -    'edk2-aarch64-code.fd',
> -    'edk2-arm-code.fd',
> -    'edk2-arm-vars.fd',
> -    'edk2-riscv-code.fd',
> -    'edk2-riscv-vars.fd',
> -    'edk2-i386-code.fd',
> -    'edk2-i386-secure-code.fd',
> -    'edk2-i386-vars.fd',
> -    'edk2-x86_64-code.fd',
> -    'edk2-x86_64-secure-code.fd',
> -    'edk2-loongarch64-code.fd',
> -    'edk2-loongarch64-vars.fd',
> -  ]
> +
> +  fds = []
> +  if 'aarch64-softmmu' in target_dirs
> +    fds += [ 'edk2-aarch64-code.fd' ]
> +  endif
> +
> +  if 'arm-softmmu' in target_dirs or 'aarch64-softmmu' in target_dirs
> +    fds += [ 'edk2-arm-code.fd',
> +             'edk2-arm-vars.fd' ]
> +  endif
> +
> +  if 'riscv64-softmmu' in target_dirs
> +    fds += [ 'edk2-riscv-code.fd',
> +             'edk2-riscv-vars.fd' ]
> +  endif

Given the repeated code pattern, how about making it a bit
more metadata driven. eg something approx like

  fdmap = {
    'edk2-aarch64-code.fd': ["aarch64"],
    'edk2-arm-code.fd': ["aarch64", "arm],
    'edk2-arm-vars.fd',: ["aarch64", "arm"],
    'edk2-riscv-code.fd': ["riscv64"],
    'edk2-riscv-vars.fd': ["riscv64"],
    ....
  }

  fds = []

  foreach fd, targets: fdmap
    want = false
    foreach target: targets
      if target + "-softmmu" in target_dirs
        want = true
      endif
    endforeach
    if want
      fds += fd
    endif
  endforeach
  

> +  if 'i386-softmmu' in target_dirs
> +    fds += [ 'edk2-i386-code.fd',
> +             'edk2-i386-secure-code.fd',
> +             'edk2-i386-vars.fd' ]
> +  endif

I guess technically these could be used together with the x86_64
target too, as you've done with arm 32-bit edk ?

> +
> +  if 'x86_64-softmmu' in target_dirs
> +    fds += [ 'edk2-x86_64-code.fd',
> +             'edk2-x86_64-secure-code.fd' ]
> +  endif
> +
> +  if 'loongarch64' in target_dirs
> +    fds += [ 'edk2-loongarch64-code.fd',
> +             'edk2-loongarch64-vars.fd' ]
> +  endif
>  
>    foreach f : fds
>      roms += custom_target(f,
> @@ -27,65 +44,104 @@ if unpack_edk2_blobs
>    endforeach
>  endif
>  
> -blobs = [
> -  'ast27x0_bootrom.bin',
> -  'bios.bin',
> -  'bios-256k.bin',
> -  'bios-microvm.bin',
> -  'qboot.rom',
> -  'vgabios.bin',
> -  'vgabios-cirrus.bin',
> -  'vgabios-stdvga.bin',
> -  'vgabios-vmware.bin',
> -  'vgabios-qxl.bin',
> -  'vgabios-virtio.bin',
> -  'vgabios-ramfb.bin',
> -  'vgabios-bochs-display.bin',
> -  'vgabios-ati.bin',
> -  'openbios-sparc32',
> -  'openbios-sparc64',
> -  'openbios-ppc',
> -  'QEMU,tcx.bin',
> -  'QEMU,cgthree.bin',
> -  'pxe-e1000.rom',
> -  'pxe-eepro100.rom',
> -  'pxe-ne2k_pci.rom',
> -  'pxe-pcnet.rom',
> -  'pxe-rtl8139.rom',
> -  'pxe-virtio.rom',
> -  'efi-e1000.rom',
> -  'efi-eepro100.rom',
> -  'efi-ne2k_pci.rom',
> -  'efi-pcnet.rom',
> -  'efi-rtl8139.rom',
> -  'efi-virtio.rom',
> -  'efi-e1000e.rom',
> -  'efi-vmxnet3.rom',
> -  'qemu-nsis.bmp',
> -  'multiboot.bin',
> -  'multiboot_dma.bin',
> -  'linuxboot.bin',
> -  'linuxboot_dma.bin',
> -  'kvmvapic.bin',
> -  'pvh.bin',
> -  's390-ccw.img',
> -  'slof.bin',
> -  'skiboot.lid',
> -  'pnv-pnor.bin',
> -  'palcode-clipper',
> -  'u-boot.e500',
> -  'u-boot-sam460-20100605.bin',
> -  'qemu_vga.ndrv',
> -  'edk2-licenses.txt',
> -  'hppa-firmware.img',
> -  'hppa-firmware64.img',
> -  'opensbi-riscv32-generic-fw_dynamic.bin',
> -  'opensbi-riscv64-generic-fw_dynamic.bin',
> -  'npcm7xx_bootrom.bin',
> -  'npcm8xx_bootrom.bin',
> -  'vof.bin',
> -  'vof-nvram.bin',
> -]
> +blobs = []
> +
> +if 'aarch64-softmmu' in target_dirs
> +  blobs += [ 'ast27x0_bootrom.bin',
> +             'npcm7xx_bootrom.bin',
> +             'npcm8xx_bootrom.bin' ]
> +endif
> +
> +# Most x86 blobs start in real mode anyway, need to check which blobs
> +# are x86_64 only. Also we could limit the option roms based on the
> +# build config.
> +if 'x86_64-softmmu' in target_dirs or 'i386-softmmu' in target_dirs
> +  blobs += [ 'bios.bin',
> +             'bios-256k.bin',
> +             'bios-microvm.bin',
> +             'qboot.rom',
> +             'vgabios.bin',
> +             'vgabios-cirrus.bin',
> +             'vgabios-stdvga.bin',
> +             'vgabios-vmware.bin',
> +             'vgabios-qxl.bin',
> +             'vgabios-virtio.bin',
> +             'vgabios-ramfb.bin',
> +             'vgabios-bochs-display.bin',
> +             'vgabios-ati.bin',
> +             'pxe-e1000.rom',
> +             'pxe-eepro100.rom',
> +             'pxe-ne2k_pci.rom',
> +             'pxe-pcnet.rom',
> +             'pxe-rtl8139.rom',
> +             'pxe-virtio.rom',
> +             'efi-e1000.rom',
> +             'efi-eepro100.rom',
> +             'efi-ne2k_pci.rom',
> +             'efi-pcnet.rom',
> +             'efi-rtl8139.rom',
> +             'efi-virtio.rom',
> +             'efi-e1000e.rom',
> +             'efi-vmxnet3.rom',
> +             'multiboot.bin',
> +             'multiboot_dma.bin',
> +             'linuxboot.bin',
> +             'linuxboot_dma.bin',
> +             'kvmvapic.bin',
> +             'pvh.bin' ]
> +endif
> +
> +if 'sparc32-softmmu' in target_dirs
> +  blobs += [ 'openbios-sparc32',
> +             'QEMU,tcx.bin',
> +             'QEMU,cgthree.bin' ]
> +endif
> +
> +if 'sparc64-softmmu' in target_dirs
> +  blobs += [ 'openbios-sparc64' ]
> +endif
> +
> +if 'ppc64-softmmu' in target_dirs
> +  blobs += [ 'openbios-ppc',
> +             'slof.bin',
> +             'skiboot.lid',
> +             'pnv-pnor.bin',
> +             'u-boot.e500',
> +             'u-boot-sam460-20100605.bin',
> +             'vof.bin',
> +             'vof-nvram.bin' ]
> +endif
> +
> +if 'ppc32-softmmu' in target_dirs
> +  blobs += [ 'qemu_vga.ndrv' ]
> +endif
> +
> +if host_os == 'windows'
> +  blobs += [ 'qemu-nsis.bmp' ]
> +endif
> +
> +if 's390x-softmmu' in target_dirs
> +  blobs += [ 's390-ccw.img' ]
> +endif
> +
> +if 'alpha-softmmu' in target_dirs
> +  blobs += [ 'palcode-clipper' ]
> +endif
> +
> +if 'hppa-softmmu' in target_dirs
> +  blobs += [ 'hppa-firmware.img',
> +             'hppa-firmware64.img' ]
> +endif
> +
> +if 'riscv32-softmmu' in target_dirs
> +  blobs += [ 'opensbi-riscv32-generic-fw_dynamic.bin' ]
> +endif
> +
> +if 'riscv64-softmmu' in target_dirs
> +  blobs += [ 'opensbi-riscv64-generic-fw_dynamic.bin' ]
> +endif
> +
> +blobs += [ 'edk2-licenses.txt' ]
>  
>  if get_option('install_blobs')
>    install_data(blobs, install_dir: qemu_datadir, install_mode: 'rw-r--r--')
> -- 
> 2.47.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


