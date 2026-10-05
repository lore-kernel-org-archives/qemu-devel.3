Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B292CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeY7-0001xI-5V; Mon, 05 Oct 2026 04:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDeXv-0001ry-Hv
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDeXs-0002Z9-EV
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791190773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XO6662fArytnf0UbPyAWayF9uTRC1G1kvO09pzDNcUw=;
 b=ediAmQS1K0Z7ppoeu4fzZuieMf7H8eRdSQdJbBTVCsD50R862NbdtR9W79OOu2szbR2d5P
 WlLTMkIWqlOeE5ZIeYpqUBzsC0+m/OCTCKOHAQfI2PzbhQ/dK95coKM7izcsVyhiHJlvjX
 G8ihWpMtg09L9ktvjq0bOEOKxhoWMCo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-aYfJR1YAPi6zE3j4qBjrUg-1; Mon,
 05 Oct 2026 04:59:29 -0400
X-MC-Unique: aYfJR1YAPi6zE3j4qBjrUg-1
X-Mimecast-MFC-AGG-ID: aYfJR1YAPi6zE3j4qBjrUg_1791190767
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D589C180AA95; Mon,  5 Oct 2026 08:59:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D35F1180034F; Mon,  5 Oct 2026 08:59:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/8] hw/usb: Add a usbredir server transport
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: clg@kaod.org, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
Date: Mon, 05 Oct 2026 12:59:18 +0400
Message-Id: <179119075841.699310.9979340018093349312.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5466;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lW7QCorsugeVDfGNMsGutWA3fJWQSeeGO3ObWvaNMR0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqw2bpJ12coDYQ3UBQLHVfwiR9yR2KP3uEkgsYE
 E7o9hdM4zWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasNm6QAKCRDa6OEJdZac
 5UunEAC0Jf6mblT+omXg4A2y5HY3lCgL7XiI4OKfzXD+j1Obe2B+mGGctho7nWjxxZvExXUqsm/
 RlXyFjmOmWPc/4fPDP32AkQWyyC2t9QnQidHf4/4zp9Z5K9oN4M4y2gtMQdNxvazOfXvPIkNQAs
 /Kb9mDcfymjULxCMTpq/yTHvuvbIqVfSqeSPlGVw87XYlO7hEJfEwUpUbdKy4e1L++XnOGOCX/u
 ezpmSxNXbiiww/oWAaPvgsPSLa7AaNcE5Jx12rxgwEweviyhve1rh53FGNOijlK7jCaEI3wAAI8
 BdGYZXWpkFG3AUEe3dpMbXAGjQacs5XXmWnfBrUtrkkVsVK+CXfdTfHjB86Hm87EIe+oQCUIefN
 Ahnaaf4pO7Irl/g1XZo263Mpy4dj9p7dTivFBU0q1+odNrnGVNWb3qvBLab/crmf7cqHxbiU7Sq
 tYwHi6e8/F7ZgeA9LU97JzaZTBDA7+NZy2mfhwzeQIGIMLmRH5Y3dXVPB84Vs3B5uRar025IUT1
 T04heysvdkvw2JPjfduJ95qIsdosQ2uKiI90wpMW88Qn4IaaGFb5t3zx4lf7hWIgVQzj7vXpW9x
 H8xbDMEYh0NOxezfuVhBOj+sXvIjg6QpGS1MMTDA509AQ+IcgHGDwqrSegtFPv1PjGT8js76PIm
 QxyTjdkb7RQ4qxQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi

> This series adds a usbredir server transport to redirect a USB device
> emulated in one QEMU instance to a USB host controller emulated in
> another one over the usbredir protocol.
> 
> The v1 series included both the usbredir server transport and the ASPEED
> AST1030 USB Device Controller (UDC) support. Following review feedback,
> this series contains only the usbredir server transport. The ASPEED
> AST1030 UDC support will be sent separately.
> 
> This work is part of a larger plan to model USB device-side support on
> ASPEED BMC/BIC SoCs, which has three goals:
> 
> 1. Model the ASPEED UDC (AST2600 / AST1030). The AST2600 also has USB host
>    (EHCI) controllers, so that work targets the AST2600 UDC: its gadget can
>    be attached to the SoC's own EHCI bus, letting the guest enumerate its
>    own gadget and exercise the UDC end-to-end.  [Done]
>    https://lore.kernel.org/qemu-devel/20260902021542.3194812-1-jamin_lin@aspeedtech.com/
> 
> 2. AST1030 UDC. The AST1030 has no USB host controller, so testing its UDC
>    needs a second QEMU instance. The UDC gadget is redirected out of the
>    guest with libusbredir and attached to another QEMU that runs a USB host
>    (a VMM, or an AST2600 / AST2700 guest).  [this series]
> 
> 3. ASPEED vHub, as a longer-term goal towards BMC KVM / Virtual Media
>    support in QEMU.  [future]
> 
> This series implements goal 2.
> 
> The transport
> =============
> 
> usb-redir-server exports a locally emulated USB device to a remote USB
> host over the usbredir protocol, so a device emulated in one QEMU instance
> can be enumerated by a host controller emulated in another one.
> 
> The left column is a request going to the device. The right column is the
> answer coming back. The middle hop carries usbredir messages over a
> socket. The top and bottom hops carry USBPackets inside QEMU.
> 
>     remote QEMU: guest driver -> EHCI/XHCI
>              |                     ^
>    USBPacket |                     | USBPacket
>              v                     |
>     "usb-redir" (the client)
>              |                     ^
>     usbredir |   chardev socket    | usbredir
>              v                     |
>     usb-redir-server (the server, this series)
>              |                     ^
>    USBPacket |                     | USBPacket
>              v                     |
>     any USBDevice, "-device <dev>,bus=<id>.0"
> 
> "usb-redir" (hw/usb/redirect.c) is the client:
>   - it takes a USBPacket from the remote guest and writes it to the socket
>     as a usbredir message
>   - it reads the answer from the socket and completes the USBPacket
> 
> usb-redir-server is the server. It does the same thing, but backwards:
>   - it reads a usbredir message from the socket and runs it as a USBPacket
>     on the bus below
>   - it takes the result of that USBPacket and writes it back to the same
>     socket as a usbredir message, for the client to read
> 
> A USB device has to sit on a USB bus, and in QEMU a USB bus is always made
> by a host controller. So usb-redir-server makes one and acts as the host

That's a bit awkward, but makes sense. However I am not sure it sure it should
also require a machine and sit on the sysbus. We may also want to build a
specialized binary that doesn't cary any of the machine code etc and is
target-free. something like "qemu-usb", not necessarily with this series though

Patch 4 already works around firmware initialization.. I don't whether this
is acceptable.. Perhaps we can accept it for now, but I'd mark the device
"experimental" at this point.

> controller on this side. It models no real chip: its cable is the chardev
> socket. The real host is in the other QEMU.
> 
> usbredir carries one device, not a bus. A hub cannot be exported: the
> protocol has no device address field. To export several devices, run one
> usb-redir-server per device, each with its own chardev.
> 
> Testing
> =======
> A plain usb-storage device was used to test the transport. The storage
> device is attached to usb-redir-server and exported over a Unix socket:
> 
> $ qemu-system-aarch64 ...
> -chardev socket,id=usbredir0,path=/tmp/usbredir0.sock,server=on,wait=off
> -device usb-redir-server,id=usbredir0,chardev=usbredir0
> -drive id=usbdisk,if=none,file=image0.ext4,format=raw
> -device usb-storage,bus=usbredir0.0,id=mystorage,drive=usbdisk
> 
> The exported device can then be attached to EHCI bus 3 of an AST2700
> guest using the existing usb-redir client:
> 
>     -chardev socket,id=storage,path=/tmp/usbredir0.sock,reconnect-ms=1000 \
>     -device usb-redir,chardev=storage,bus=usb-bus.3
> 
> The AST2700 Linux guest enumerates the redirected USB storage device:
> 
> root@ast2700-default:~# lsusb
> unable to initialize usb spec
> Bus 001 Device 001: ID 1d6b:0001 Linux 6.18.36-v00.08.03-gaf2f426c5786 uhci_hcd Generic UHCI Host Controller
> Bus 002 Device 001: ID 1d6b:0002 Linux 6.18.36-v00.08.03-gaf2f426c5786 ehci_hcd EHCI Host Controller
> Bus 002 Device 002: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
> 
> This also demonstrates that usb-redir-server is not specific to the
> ASPEED UDC. Any USBDevice can be attached to its USB bus and exported
> to a host controller in another QEMU instance.

something I have long wished for, pretty nice

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


