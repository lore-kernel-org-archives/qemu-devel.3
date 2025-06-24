Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AC7C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 19:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU9by-0003gu-Ta; Tue, 24 Jun 2025 15:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uU9bw-0003gi-L5
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 15:47:16 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uU9bt-0007Lg-Hj
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 15:47:15 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b31d8dd18cbso1178037a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750794431; x=1751399231; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dw2zabTft8ytTA3fL3MTQkbMY1IDA9wKLtkhoptW+GQ=;
 b=b0KplBoOZC0iKAy6hHyQT60bYsxDet/ZNoMVjUr7VZ8YTU8xWwkPgBhJTBIW39+pjI
 R0PP6QJZwouOq3ItTVuC0/mZJZgPr+ktfvrrJnsWGSr1GBkk9esTtfnrFiO5c3MdnnAn
 bk0pbbglvgkfaZ/0Q288tloSG6bfhAAneXokd8yvJeIJVfz1Dm9e2va5hA3JuWK7mT/h
 TlN5bRKaLjvkvTbiwE0WoAIQC4Ew8mLnYxXQ6V//32EA9RAC3LXgbtAsuuIp1L5VNxpr
 Aadbfw3cUR6/C80V0kScArxutt018M6PMZ/19xUJ7c2YJeuJxEfxbFtPgYZVbtQzT6Pz
 7jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750794431; x=1751399231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dw2zabTft8ytTA3fL3MTQkbMY1IDA9wKLtkhoptW+GQ=;
 b=oil6Sgzm9VxZLTqnNq7DPyS9EceaU2yPyNFaNn2bfUEagTye2l2AR6mkZAw9mzZa6q
 lN5CQ2K1m3Ocs5OhYBSqbmJKPCYDOcimXmJJ8SRQz9k+z8OiGdQzwP1dhpbaxmRk6nWQ
 W+HiO++c21bzveYXM90rpbCRdINJ/sH7/3TuSpnngKJSx4lV4lYzCRCNZXX7t2BQaQkC
 3w85BJzgsRRVXMxtMbDZQeqwT9alTlExibG0mcTGoe5rDcEK2pehyg5++M9dscbQkZiC
 P0WNin0AmOTVldlsyS/S6hycJvJpCXDm0kQKSbuUw8fymqIl3A2qmmGTQkNdfA0I2CM3
 rgug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUTm2CWdZ1IJPAiFrv4p8WKzzP/eJ9KdWMI1Snk864S6uFf0hU4cuSbqoRoflLAN8liHyIz6Xh9wYU@nongnu.org
X-Gm-Message-State: AOJu0YylLECgiM61ndi7SXXgJGDswe+ySZFTAO5O7zNWIl+HX6a1kgeS
 QbHXMEVsTSB8+6jWiAsvuIv1Z2e4iV8DH66yxHEmerqxORK5qNJcOdKG
X-Gm-Gg: ASbGncuE3cLbQrTlPh9m1nhUvPGSG0Qm3XTE1XTejjVGd4Lm5jPA74eDAPxJjxdQFkD
 9N6giV92oVJ2JcJs4shRQgbKArsvapUVN3Cw+FUAR8mmppQ6NfeCYy1mKc6QP+ckYLHtBraO9n/
 hpSKjNAH18XXYuldK1jS9By+24t93Ty1ff3MxaPuKi1uyGeUHXERCShGRf8BHv63kMN3VI5fwoE
 KHj1cYHwY2ADOvvE837E6GGPEjNnK6bTVNzKBh6hE7kM7iLclBjpDgVviz8g6G9YZxvQlwPhwte
 u/WYhePoRvd14Gbw7QObXN4hW3149bcjv1PjlvmLSEz75z6PcVG/HbQOkHs+O3UEuLfbUOm/+cO
 8kUtfesl+9Idw
X-Google-Smtp-Source: AGHT+IF7lYDRhARnDMYq24nnc73O+0EocNdrE7faxKdesAbTGA4vUFqH6FYOc4ysMz9ocH9337WTmA==
X-Received: by 2002:a17:90b:1b06:b0:313:d6ce:6c6e with SMTP id
 98e67ed59e1d1-315f25e394dmr187770a91.8.1750794431475; 
 Tue, 24 Jun 2025 12:47:11 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a318733sm13598691a91.38.2025.06.24.12.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 12:47:11 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 24 Jun 2025 19:47:09 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Klaus Jensen <k.jensen@samsung.com>, cminyard@mvista.com,
 Fan Ni <fan.ni@samsung.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, mst@redhat.com, linuxarm@huawei.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH qemu 0/5] hw/cxl/mctp/i2c/usb: MCTP for OoB control
 of CXL devices.
Message-ID: <aFsAvZqMCocyUcQ9@deb-101020-bm01.eng.stellus.in>
References: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=anisa.su887@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 09, 2025 at 05:33:28PM +0100, Jonathan Cameron wrote:
> This posting is primarily about sharing the USB device emulation to get some
> early feedback.
> 
> RFC reasons:
> - Known 'inaccuracies' in emulation (not obeying MTU in the to host direction for
>   example)./
> - Not sure what to do wrt to Klaus' I2C MCTP support given that has been stalled
>   for some time. For now only the headers are really shared between the
>   two implementations.
> - This is more of an FYI / request for testing than a formal suggestion that this
>   might be ready for upstream.
> 
> Why add a CXL FM-API over MCTP over USB device?
> - Can be emulated on pretty much any host system as USB is discoverable and
>   expandable. If you want a giggle, see the hacks on i386/pc and arm/virt on
>   we've been using until now given only I2C controller that works is the aspeed
>   one. e.g. https://gitlab.com/jic23/qemu/-/commit/134c2e3952b
> - Being able to talk to both the fabric management out of band interfaces
>   and the in band devices on the same host makes testing much simpler.
> 
> Background:
> 
> Back in 2022 I posted some support for controlling the CXL fabric via the
> spec defined out of band interfaces (CXL Fabric Management API - FM-API)
> over MCTP on I2C
> 
> https://lore.kernel.org/qemu-devel/20220520170128.4436-1-Jonathan.Cameron@huawei.com/
> I reworked that on top of the NVME-MI work from Klauss.
> 
> To that end I hacked the aspeed-i2c controller onto both i386/pc and arm/virt
> and posted kernel patches to enabled ACPI support for that device (more or less).
> It worked and has been useful in the meantime, but adding that i2c controller
> to those boards was obviously not going to be upstreamable - and to build
> reliable tests against it I don't want to carry this out of tree for ever.
> I messed around with a PCI hosted aspeed controller and might come back to
> that at some point.
> 
> In the meantime, DMTF published a transport binding for MCTP over USB
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
> 
> Kernel support duly followed early this year: drivers/net/mctp/mctp-usb.c
> https://codeconstruct.com.au/docs/mctp-over-usb/
> 
> Given the ease of adding a suitable USB controller on a PCI bus, emulating a
> suitable endpoint provides what I think is an upstreamable solution.
> 
> To use this:
>  -device usb-ehci,id=ehci
>  -device usb-cxl-mctp,bus=ehci.0,id=fred,target=us0
> 
> where target is either a CXL switch upstream port, or a type 3 device.
> 
> Then install the mctp userspace tools in your guest and configure it with
> 
>   mctp addr add 8 dev mctpusb0
>   mctp link set mctpusb0 net 11
>   mctp link set mctpusb0 up
> 
>   systemctl start mctpd.service
>   busctl call au.com.codeconstruct.MCTP1 /au/com/codeconstruct/mctp1/interfaces/mctpusb0 au.com.codeconstruct.MCTP.BusOwner1 SetupEndpoint ay 0
> 
> I've been testing the CXL commands with
> 
> https://gitlab.com/jic23/cxl-fmapi-tests
> (mostly because I still had them in my image from the i2c work)
> but libcxlmi is probably a better bet
> 
I tested this patchset using libcxlmi with the following configuration:
- kernel version: https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-04-13
- QEMU: upstream ToT with MCTP USB CXL and FMAPI DCD support:
  - MCTP USB CXL (https://lore.kernel.org/linux-cxl/20250609163334.922346-1-Jonathan.Cameron@huawei.com/T/#m21b9e0dfc689cb1890bb4d961710c23379e04902)
	- note: I modified the condition on line hw/usb/dev-mctp.c:509 to allow
	  the FMAPI DCD Management command set (0x56) to be processed
  - FMAPI DCD Management patches (https://lore.kernel.org/linux-cxl/20250605234227.970187-1-anisa.su887@gmail.com/)

- Topology (1 DCD attached to downstream port of CXL Switch)
	'-device usb-ehci,id=ehci \
     -object memory-backend-file,id=cxl-mem1,mem-path=/tmp/t3_cxl1.raw,size=4G \
     -object memory-backend-file,id=cxl-lsa1,mem-path=/tmp/t3_lsa1.raw,size=1M \
     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
     -device cxl-type3,bus=swport0,volatile-dc-memdev=cxl-mem1,id=cxl-dcd0,lsa=cxl-lsa1,num-dc-regions=2,sn=99 \
     -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=us0 \
     -device usb-cxl-mctp,bus=ehci.0,id=usb1,target=cxl-dcd0\
     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k'

After creating the VM with the above topology, to configure the 2 MCTP EPs
(mctpusb0 and mctpusb1):

	mctp link set mctpusb0 up
	mctp addr add 50 dev mctpusb0
	mctp link set mctpusb0 net 11

	mctp link set mctpusb1 up
	mctp addr add 51 dev mctpusb1
	mctp link set mctpusb0 net 12

	systemctl stop mctpd.service
	systemctl start mctpd.service
	busctl call au.com.codeconstruct.MCTP1 /au/com/codeconstruct/mctp1/interfaces/mctpusb0 au.com.codeconstruct.MCTP.BusOwner1 SetupEndpoint ay 0
	busctl call au.com.codeconstruct.MCTP1 /au/com/codeconstruct/mctp1/interfaces/mctpusb1 au.com.codeconstruct.MCTP.BusOwner1 SetupEndpoint ay 0


To test this patchset, I used this program from libcxlmi:
https://github.com/computexpresslink/libcxlmi/blob/main/examples/cxl-mctp.c

To summarize, this program scans the D-bus for MCTP endpoints or takes the NID:EID
of the endpoint you want to open as arguments, then sends a variety of commands
(identify, supported logs, etc.) through the endpoint(s) and prints the results,
which I verified. Both methods of opening endpoints are successful and shows
the expected output.

To ensure this works end-to-end with an FM workflow I also tested with
this program, which allows users to interactively send the FMAPI Add/Release
commands from the command line:
https://github.com/computexpresslink/libcxlmi/blob/main/examples/fmapi-mctp.c

First I created a DC Region using this ndctl command:
cxl create-region -m mem0 -d decoder0.0 -s 1G -t dynamic_ram_a

Then I ran the program to add an extent of 512MB and was able to successfully
create a DAX Device using the following commands:

daxctl create-device -r region0
daxctl reconfigure-device dax0.1 -m system-ram

The output of 'lsmem' shows 512M added:
RANGE                                  SIZE  STATE REMOVABLE   BLOCK
0x0000000000000000-0x000000007fffffff    2G online       yes    0-15
0x0000000100000000-0x000000027fffffff    6G online       yes   32-79
0x0000001290000000-0x00000012afffffff  512M online       yes 594-597

> https://github.com/computexpresslink/libcxlmi
> 
> I'll post a tree with this on at gitlab.com/jic23/qemu shortly
> (cxl-<latest date>).
> 
> Jonathan Cameron (3):
>   hw/cxl/i2c_mctp_cxl: Initial device emulation
>   docs: cxl: Add example commandline for MCTP CXL CCIs
>   usb/mctp/cxl: CXL FMAPI interface via MCTP over usb.
> 
> Klaus Jensen (2):
>   hw/i2c: add smbus pec utility function
>   hw/i2c: add mctp core
> 
>  MAINTAINERS                               |   7 +
>  docs/system/devices/cxl.rst               |  27 +
>  include/hw/cxl/cxl_device.h               |   8 +
>  include/hw/i2c/mctp.h                     | 125 +++++
>  include/hw/i2c/smbus_master.h             |   2 +
>  include/hw/pci-bridge/cxl_upstream_port.h |   1 +
>  include/hw/usb.h                          |   1 +
>  include/net/mctp.h                        | 100 ++++
>  hw/cxl/cxl-mailbox-utils.c                |  49 ++
>  hw/cxl/i2c_mctp_cxl.c                     | 289 ++++++++++
>  hw/i2c/mctp.c                             | 414 ++++++++++++++
>  hw/i2c/smbus_master.c                     |  26 +
>  hw/usb/dev-mctp.c                         | 639 ++++++++++++++++++++++
>  hw/arm/Kconfig                            |   1 +
>  hw/cxl/Kconfig                            |   4 +
>  hw/cxl/meson.build                        |   4 +
>  hw/i2c/Kconfig                            |   4 +
>  hw/i2c/meson.build                        |   1 +
>  hw/i2c/trace-events                       |  14 +
>  hw/usb/Kconfig                            |   5 +
>  hw/usb/meson.build                        |   1 +
>  21 files changed, 1722 insertions(+)
>  create mode 100644 include/hw/i2c/mctp.h
>  create mode 100644 include/net/mctp.h
>  create mode 100644 hw/cxl/i2c_mctp_cxl.c
>  create mode 100644 hw/i2c/mctp.c
>  create mode 100644 hw/usb/dev-mctp.c
> 
> -- 
> 2.48.1
> 

