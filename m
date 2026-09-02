Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E0EC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1eAw-0006b6-1k; Wed, 02 Sep 2026 02:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1eAu-0006aI-Nb
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1eAs-0002yh-7y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788329416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WHrVL/Cz94sEOkrFantle+w+RpwepPArA3RjPc4IfjY=;
 b=K8aXxt5PpiKJmmalClcbSWYNQP7vZJTefaEgamP4/ipqfDx3rgyHli4BHm0Mt8Edaobz0D
 3oRqadFYzxQB6eESk9bADj/OIyR0R4XcmFq7rMmJcOqg8nS/cICY+p9I4UKD7WQUeGzqs9
 /yEkuJu1PcYFVlU+Po2D9TtE4Q3tDlo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-Xc-knNokN-6UuTWhc9yCEQ-1; Wed, 02 Sept 2026 02:10:15 -0400
X-MC-Unique: Xc-knNokN-6UuTWhc9yCEQ-1
X-Mimecast-MFC-AGG-ID: Xc-knNokN-6UuTWhc9yCEQ_1788329414
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so6004295e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 23:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788329414; x=1788934214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WHrVL/Cz94sEOkrFantle+w+RpwepPArA3RjPc4IfjY=;
 b=qgLPf/uyQSDdkHUa7EOkeuVVUvkC8AouVLAVgHzb0G689pHIEm8UMIMYWSwHG/DtgX
 kz9P7saKhV09BGc5WcqTDq/UjMsOo2DahGb+oWkpn/a7/Q++ja3LXn07rhehQ+WsgFLY
 Sdmgi2g/0iLzMqp0EFURDE84q+nqCOgAd7Y47emk8/6forhyBs/bQzbJDPpPYrrZoAM5
 dOWMMA2WvwPa062aSq3V1zjiucUQxf3RJgAbIfazg/Lj6A01peXhHiADO3wdlBMTnx4H
 KhaQpZT2WB2x1BDjavAaDCLt7ml1fI46rpeLf75jQJVP8f4NwtTvHY7m2wnDoanNWSmx
 hJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788329414; x=1788934214;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WHrVL/Cz94sEOkrFantle+w+RpwepPArA3RjPc4IfjY=;
 b=Ibsn3L2PHIwbWDG3kbmd9ZeaLEpExQ4fOMeXRe5gHzuAspvB8QcXnKKToIFiTckljT
 LxOeF+jdm69SFIZlXGY35q0EaL4jueAZIjWFT0+EUxIs9Dk9OExWgEw/6vCB4oJs0j+H
 b2wzva9u0O9+MVKIy5lTyS0Pk6V0jSUuIGgcyZFMhnmEH/S/sTi8+QTD4mhh5U7gElbS
 9c5ozs+jDUexEsis6QyE+xFTgNlk5ZwKoWFPSMC1cq+vCQ02M8s+Wouf1trMl2w9Cee+
 8eaU8gdxWfc+Wj2pmT/3DajZHmd+qP9JUesIVDfRwevMcDOanBU3lzni3iWbaLCWhIVT
 Ng6g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3KA8vkPpZ3DmL6ZXqLd+sHUaUq3UujXhUuNJiMBBTDNJ7M5OxfjKl2I2Lsy9C8kW42TgAcLr3c/9a@nongnu.org
X-Gm-Message-State: AFuF++neVYXFinSVsp+aYN6/066px2G4Ex3XTnNtngckxnrjsZHM04XE
 3lw1nYrZi/PRXv2X0jQi2VzgRoRw8msKIfogZoWZwy7r5TdAMQWVnFkfLRvh/DA1+YAoB9kIx4O
 /ml3QeaXwJNZH65W0M0pD1+urww5UYpdStLG53O6uS64UmgfcmcfYajXF
X-Gm-Gg: AR+sD10B4VrsheSpnzYlVPC3AEgTC5EHdtgQJijw573Lg4CwfT05qRiVKdy/5r9rnVg
 TUr9W2sTb6fEV5Jz2bFm5+IXiD4Pkn/MQAZgt7gjhrdZ76a2NjtailNk1hqGcjdMJupklZ1YyVP
 O8OPZ28GdVNdWCUQUPdWX3uqsZeKT8DjSoJiX67qgtKrsfO94KeNZuT6mEBD1I70FMLs8ZGKxxS
 5+FYV6XKHxlmsHkpcAclmf1o/G7PBy9kZNnEbzecnBU64Niz0x/TUvtBQYi9xZH2yGOE3Ig+v6O
 CIHbMN+/SXaEJP+0BtT2aJct7ARSdGAIwRGLVAvPWeCvcaE/jYWtpPOWcof+mvWsyVONnrkKn6W
 rLmZ5eFntHoG5c7S5WFCcIrBZa4s9PLJMpwIEf3U=
X-Received: by 2002:a05:600c:5306:b0:49c:c9ac:a4f3 with SMTP id
 5b1f17b1804b1-49ce5810b6amr45265995e9.1.1788329414082; 
 Tue, 01 Sep 2026 23:10:14 -0700 (PDT)
X-Received: by 2002:a05:600c:5306:b0:49c:c9ac:a4f3 with SMTP id
 5b1f17b1804b1-49ce5810b6amr45265075e9.1.1788329413570; 
 Tue, 01 Sep 2026 23:10:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4?
 ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce465161esm41522705e9.7.2026.09.01.23.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 23:10:12 -0700 (PDT)
Message-ID: <421acb62-dd31-4c95-800b-234c1803510e@redhat.com>
Date: Wed, 2 Sep 2026 08:10:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] hw/usb: Add ASPEED USB Device Controller (UDC)
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260902021542.3194812-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260902021542.3194812-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 9/2/26 04:15, Jamin Lin wrote:
> This series adds a QEMU model for the ASPEED USB Device Controller (UDC),
> driven by the Linux "aspeed_udc" gadget driver.
> 
> It is the first step of a larger plan to model USB device-side support on
> ASPEED BMC/BIC SoCs, which has three goals:
> 
> 1. Model the ASPEED UDC (AST2600 / AST1030). The AST2600 also has USB host
>     (EHCI) controllers, so this series targets the AST2600 UDC: its gadget can
>     be attached to the SoC's own EHCI bus, letting the guest enumerate its own
>     gadget and exercise the UDC end-to-end.  [this series]
> 
> 2. AST1030 UDC. The AST1030 has no USB host controller, so testing its UDC
>     needs a second QEMU instance. The plan is to redirect the UDC gadget out
>     of the guest using libusbredir and attach it to another QEMU that runs a
>     USB host (a VMM, or an AST2600 / AST2700 guest).  [on-going]
>     
> 3. ASPEED vHub, as a longer-term goal towards BMC KVM / Virtual Media support
>     in QEMU.  [future]
> 
> This series implements goal 1 only.
> 
> Design
> ------
> The UDC is modelled as two QOM objects, because a single object cannot be
> both a SysBusDevice and a USBDevice:
> 
>    - "aspeed.udc": the sysbus device (MMIO register map, IRQ and DMA engine)
>      that the guest gadget driver programs.
> 
>    - "aspeed.udc-gadget": a user-creatable USB device presented on a USB host
>      controller's bus. It links back to its controller through the "udc"
>      property.
> 
> The SoC creates the controller; the gadget is added on the command line, e.g.
> 
>    -device aspeed.udc-gadget,udc=/machine/soc/udc
>       
> Test result:
> -----------
> The default ASPEED SDK prebuilt image does not enable the UDC driver, so
> build a kernel with CONFIG_USB_ASPEED_UDC=y first.
> 
> Start QEMU with the gadget attached to the on-SoC EHCI:
> 
>    qemu-system-arm -machine ast2600-evb -drive file=<image>,if=mtd,format=raw \
>        -device aspeed.udc-gadget,udc=/machine/soc/udc -nographic
> 
> In the guest, bring up a mass-storage gadget and verify enumeration and I/O:
> 
> 1. Before: only the host controllers are present
> root@ast2600-default:~# lsusb
> unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4a22b-dirty ehci_hcd EHCI Host Controller
> Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4a22b-dirty uhci_hcd Generic UHCI Host Controller
> 
> 2. Enable the gadget
> root@ast2600-default:~# ./usb-storage.sh
> Using UDC: 1e6a2000.usb
> [  598.582205] Mass Storage Function, version: 2009/09/11
> [  598.582635] LUN: removable file: (no medium)
> USB Mass Storage gadget is enabled.
> Backing file: /home/root/jamin
> root@ast2600-default:~# [  598.876395] usb 1-1: new high-speed USB device number 2 using ehci-platform
> [  599.070035] usb 1-1: New USB device found, idVendor=1d6b, idProduct=0104, bcdDevice= 1.00
> [  599.070821] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [  599.071448] usb 1-1: Product: ASPEED USB Storage
> [  599.072687] usb 1-1: Manufacturer: ASPEED
> [  599.073384] usb 1-1: SerialNumber: 1234567890
> [  599.103625] usb-storage 1-1:1.0: USB Mass Storage device detected
> [  599.136326] scsi host0: usb-storage 1-1:1.0
> [  600.230921] scsi 0:0:0:0: Direct-Access     Linux    File-Stor Gadget 0618 PQ: 0 ANSI: 2
> [  600.243758] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [  600.263452] sd 0:0:0:0: Power-on or device reset occurred
> [  600.289381] sd 0:0:0:0: [sda] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> [  600.297896] sd 0:0:0:0: [sda] Write Protect is off
> [  600.306379] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [  600.424608]  sda:
> [  600.425526] sd 0:0:0:0: [sda] Attached SCSI removable disk
> 
> 3. After: the gadget enumerates on the EHCI bus
> root@ast2600-default:~# lsusb
> unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4a22b-dirty ehci_hcd EHCI Host Controller
> Bus 001 Device 002: ID 1d6b:0104 ASPEED ASPEED USB Storage
> Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4a22b-dirty uhci_hcd Generic UHCI Host Controller
> 
> 4. Mount and verify data
> root@ast2600-default:~# mount /dev/sda /mnt/
> root@ast2600-default:~# sha256sum /mnt/testfile
> 3308890a1289f6a327c014537523e8ebd0833301af3d25a7c5893dc7050d2c70  /mnt/testfile
> root@ast2600-default:~# umount /mnt
> 
> 5. Stop the gadget -> clean disconnect
> root@ast2600-default:~# ./usb-storage.sh stop
> Stopping USB gadget...
> [  669.866439] usb 1-1: USB disconnect, device number 2
> Stopped.
> root@ast2600-default:~# [  669.968156] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [  669.969307] sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: hostbyte=0x01 driverbyte=DRIVER_OK
> 
> root@ast2600-default:~# lsusb
> unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4a22b-dirty ehci_hcd EHCI Host Controller
> Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4a22b-dirty uhci_hcd Generic UHCI Host Controller
> 
> 
> The contents of this scripts
> ---------------------------
> root@ast2600-default:~# cat  usb-storage.sh
> #!/bin/sh
> set -e
> 
> G=/sys/kernel/config/usb_gadget/g1
> IMG=/home/root/jamin
> SIZE_MB=64
> 
> mount_configfs()
> {
>      mountpoint -q /sys/kernel/config || mount -t configfs none /sys/kernel/config
> }
> 
> get_udc()
> {
>      ls /sys/class/udc | head -n 1
> }
> 
> stop_gadget()
> {
>      if [ ! -d "$G" ]; then
>          return
>      fi
> 
>      echo "Stopping USB gadget..."
> 
>      # Unbind UDC first
>      if [ -f "$G/UDC" ]; then
>          echo "" > "$G/UDC" 2>/dev/null || true
>      fi
> 
>      # Clear backing file to release image
>      if [ -f "$G/functions/mass_storage.0/lun.0/file" ]; then
>          echo "" > "$G/functions/mass_storage.0/lun.0/file" 2>/dev/null || true
>      fi
> 
>      # Remove function link from config
>      rm -f "$G/configs/c.1/mass_storage.0" 2>/dev/null || true
> 
>      echo "Stopped."
> }
> 
> start_gadget()
> {
>      mount_configfs
> 
>      UDC="$(get_udc)"
>      if [ -z "$UDC" ]; then
>          echo "ERROR: No UDC found in /sys/class/udc"
>          exit 1
>      fi
> 
>      stop_gadget
> 
>      echo "Using UDC: $UDC"
> 
>      modprobe libcomposite 2>/dev/null || true
> 
>      mkdir -p "$G"
>      cd "$G"
> 
>      echo 0x1d6b > idVendor
>      echo 0x0104 > idProduct
>      echo 0x0200 > bcdUSB
>      echo 0x0100 > bcdDevice
> 
>      mkdir -p strings/0x409
>      echo "1234567890" > strings/0x409/serialnumber
>      echo "ASPEED" > strings/0x409/manufacturer
>      echo "ASPEED USB Storage" > strings/0x409/product
> 
>      mkdir -p configs/c.1/strings/0x409
>      echo "Mass Storage" > configs/c.1/strings/0x409/configuration
>      echo 120 > configs/c.1/MaxPower
> 
>      if [ ! -f "$IMG" ]; then
>          echo "Creating backing image: $IMG"
>          dd if=/dev/zero of="$IMG" bs=1M count="$SIZE_MB"
>          mkfs.vfat "$IMG"
>      fi
> 
>      mkdir -p functions/mass_storage.0
> 
>      # Make sure old LUN is detached before changing attributes
>      echo "" > functions/mass_storage.0/lun.0/file 2>/dev/null || true
> 
>      echo 0 > functions/mass_storage.0/stall
>      echo 0 > functions/mass_storage.0/lun.0/cdrom
>      echo 0 > functions/mass_storage.0/lun.0/ro
>      echo 1 > functions/mass_storage.0/lun.0/removable
>      echo "$IMG" > functions/mass_storage.0/lun.0/file
> 
>      ln -sf functions/mass_storage.0 configs/c.1/mass_storage.0
> 
>      echo "$UDC" > UDC
> 
>      echo "USB Mass Storage gadget is enabled."
>      echo "Backing file: $IMG"
> }
> 
> case "$1" in
>      start|"")
>          start_gadget
>          ;;
>      stop)
>          stop_gadget
>          ;;
>      restart)
>          stop_gadget
>          sleep 1
>          start_gadget
>          ;;
>      *)
>          echo "Usage: $0 {start|stop|restart}"
>          exit 1
>          ;;
> esac
> 
> 
> v1:
>    1. Add ASPEED UDC device controller
>    2. Add ASPEED UDC gadget USB device
> 
> v2:
>    1. Replace dynamic memory allocation with fixed-size arrays.
>    2. Use an OR gate to route the interrupt signals from the UDC and EHCI2.
>    3. Split the "Add ASPEED UDC gadget USB device" patch into two patches:
>      a. Add ASPEED UDC gadget USB device
>        Implement EP0 control transfers.
>      b. Add programmable endpoint DMA transfers
>        Implement DMA transfers for programmable endpoints.
>    4. Remove unused macros.
>    
> v3:
>    1. Remove unused macros.
>    2. Bind the gadget to the controller via a QOM link property
>     ("usbgadget", weak) instead of writing the back-pointer directly
> 
> v4:
>    1. Move the "select USB" dependency to the appropriate patch.
> 
> v5:
>    1. Dynamically allocate the buffer in aspeed_udc_ep_xfer_out() to reduce stack usage.
> 
> Jamin Lin (4):
>    hw/usb/aspeed-udc: Add ASPEED UDC device controller
>    hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device
>    hw/usb/aspeed-udc: Add programmable endpoint DMA transfers
>    hw/arm/aspeed_ast2600: Wire up the UDC
> 
>   include/hw/arm/aspeed_soc.h |    4 +
>   include/hw/usb/aspeed-udc.h |   85 +++
>   hw/arm/aspeed_ast2600.c     |   37 +-
>   hw/usb/aspeed-udc.c         | 1058 +++++++++++++++++++++++++++++++++++
>   hw/arm/Kconfig              |    1 +
>   hw/usb/Kconfig              |    4 +
>   hw/usb/meson.build          |    1 +
>   hw/usb/trace-events         |   16 +
>   8 files changed, 1203 insertions(+), 3 deletions(-)
>   create mode 100644 include/hw/usb/aspeed-udc.h
>   create mode 100644 hw/usb/aspeed-udc.c
> 

Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


