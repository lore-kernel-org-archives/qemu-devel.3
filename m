Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D5606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eY1BKjlW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLwLq-0006hK-B8; Wed, 28 Oct 2026 01:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xLwLn-0006h0-85
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:37:27 -0400
Received: from out-50.mta1.migadu.com ([95.215.58.50] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xLwLl-0007M6-01
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:37:27 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=EjCXHaIB9x7i9VrZ/A+NRdS6FLLXN4RPE1um3VbmGAA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793165842; v=1; x=1793770642;
 b=eY1BKjlWOhYFAl+//rBt25bYChcoJrokqM4cHf1ccNsuRgBLAR57jUboaQOI2ONgHZFZh3rg
 UUCG9DM8WbzISr039Fyj+xqQS2pixCvpjxoqIvxXYtZE4lNEDHRm244ChRy2zI5qtR/+gENLk9s
 BEfxBfKD4wjrwAlkRfKHEqBg=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 41bff6790c7fa7c6;
 Wed, 28 Oct 2026 05:37:22 +0000
X-Mizu-Trace-ID: 41bff6790c7fa7c6
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: dongwon.kim@intel.com
Cc: liang1.yang@intel.com, qemu-devel@nongnu.org, thuth@redhat.com,
 marcandre.lureau@redhat.com, junjie.cao@linux.dev
Subject: Re: [PATCH] hw/usb/host-libusb: Avoid assertion on invalid altsetting
Date: Wed, 28 Oct 2026 00:37:17 -0500
Message-ID: <20261028053717.525008-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812092403.37511-1-dongwon.kim@intel.com>
References: <20260812092403.37511-1-dongwon.kim@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.50; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 12 Aug 2026 02:24:03 -0700, dongwon.kim@intel.com wrote:
> Log warning and skip the interface instead of asserting in qemu
> host-libusb when there is invalid altsetting index during fast
> USB device hotplug/unplug.

Hi Dongwon, Liang,

The out-of-range alt does not come from libusb. It is QEMU's own
udev->altsetting[], written by usb_host_set_interface() when the guest
selects an alternate setting and only cleared in
usb_host_claim_interfaces() on SET_CONFIGURATION. usb_host_open() runs
usb_host_ep_update() before either of those, so when a different device
shows up on the same usb-host instance, the values left behind by the
previous device are checked against the new device's descriptors.

Reproduced on master with -device usb-host,hostbus=3,hostport=4 and a
Debian 12 guest on qemu-xhci: an Arkmicro 18ec:3399 UVC camera, guest
selects interface 1 alt 11 through usbfs, camera unplugged, a Jieli
4c4a:4155 UAC device (interface 1 has two alternate settings) plugged
into the same port. QEMU aborts at host-libusb.c:910 while opening the
second device.

Skipping the interface hides the assert but keeps the stale value, and a
stale value that happens to be in range is not caught at all: it picks
the endpoints of the wrong alternate setting. Clearing udev->altsetting[]
in usb_host_open() before usb_host_ep_update(), the way
usb_host_claim_interfaces() does, removes the cause. The guest has not
selected anything on the new device yet, so zero is the right content,
and the array is written again only after
libusb_set_interface_alt_setting() succeeds, so the assert can stay.
udev->ninterfaces and udev->configuration go stale the same way; nothing
in usb-host reads them, but moving the three resets from
usb_host_claim_interfaces() into a helper called from both places keeps
them together. With udev->altsetting[] cleared the sequence above
enumerates the second device, snd-usb-audio and usbhid bind to it and
its own SET_INTERFACE round trips go through.

> +                warn_report("usb-host: ignoring out-of-bounds altsetting=%d "
> +                            "for interface %d (index %d) on %s (bus=%03d, addr=%03d)",
> +                            alt, intf->bInterfaceNumber, i,
> +                            udev->product_desc, s->bus_num, s->addr);

usb_host_open() fills udev->product_desc after usb_host_ep_update(), so
this names the previous device. With the patch rebased onto master the
sequence above prints

  usb-host: ignoring out-of-bounds altsetting=11 for interface 1 (index 1)
  on USB2.0 PC CAMERA (bus=003, addr=014)

for the audio device.

> +    /* Log and skip if configuration is NULL or has no interfaces */
> +    if (!conf || conf->bNumInterfaces == 0) {

libusb_get_active_config_descriptor() sets *config whenever it returns
0, so !conf cannot happen, and bNumInterfaces == 0 already falls through
the loop.

The patch also no longer applies on master: e1b7f5e2a6 ("usb-host:
validate interface number before indexing altsetting") changed the same
loop, and conf is a g_autoptr there since 322894eed3, so the explicit
libusb_free_config_descriptor() in the new early return would be a
double free. A v2 should carry
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3189 and
Cc: qemu-stable@nongnu.org, the assert is reachable from 9.1.0 as
reported there.

Thanks,
Junjie

