Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE2EFCC055
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZfh-0008Cl-8a; Fri, 06 Mar 2026 13:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyZfe-0008CH-HM
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:13:06 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyZfc-0001la-TC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:13:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C717160018;
 Fri,  6 Mar 2026 18:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8B5C4CEF7;
 Fri,  6 Mar 2026 18:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772820781;
 bh=Mvk2kGNNqqvtkiA/Kdf0LySyoCuauQ9ez0oKD5EyOKs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Gho6iTPfR+NcTSg/vBbeHqvgC0uh/snfivKZhPy1eHxxZxsPJjNNY7P9z2mEmEyjJ
 yz+2WvsBVEJ885b7LHXfrgs1v6w02HLECF374BFmAaU+bzd81QoiwAFSPQuzV3qSWJ
 Ss96OAwwsfsf4pOf6YigxU3CUWJPFCyrzBSoooMGKnTF+Cs40ce8tTyLn0PMGlXOKR
 HnrdxiVaO/n0PzK2Xsvuhu4ep/0+j0e8SFbnU/eJha1U6ojXYZZr+57uj4FDlmwSa6
 wTmxoE8hagaes6lZj+aZdU0h+TTT/qfEA1aCIKdyjdjrTb0aRI6gpS3PQa3b+SInHS
 VWIC/BtT7N3Pw==
Date: Fri, 6 Mar 2026 19:12:57 +0100
From: Helge Deller <deller@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: Re: [PULL 2/6] hw/hppa: Wire up Diva GSP card
Message-ID: <aasZKZ1FQY5ytrb2@p100>
References: <20250207210540.24594-1-deller@kernel.org>
 <20250207210540.24594-3-deller@kernel.org>
 <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Peter Maydell <peter.maydell@linaro.org>:
> On Fri, 7 Feb 2025 at 21:08, <deller@kernel.org> wrote:
> >
> > From: Helge Deller <deller@gmx.de>
> >
> > Until now we used a standard serial-pci device to emulate a HP serial
> > console.  This worked nicely with 32-bit Linux and 32-bit HP-UX, but
> > 64-bit HP-UX crashes with it and expects either a Diva GSP card, or a real
> > 64-bit capable PCI graphic card (which we don't have yet).
> > In order to continue with 64-bit HP-UX, switch over to the recently
> > added Diva GSP card emulation.
> >
> > Signed-off-by: Helge Deller <deller@gmx.de>
> 
> Hi; I've been looking at memory leaks reported by the clang
> address-sanitizer, and it flags one up introduced by this change
> from last year:
> 
> 
> > @@ -383,26 +383,17 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
> 
> > +    /* BMC board: HP Diva GSP */
> > +    dev = qdev_new("diva-gsp");
> 
> Here we create a new diva-gsp device...
> 
> > +    if (!object_property_get_bool(OBJECT(dev), "disable", NULL)) {
> 
> ...but then after looking at the "disable" property on it we
> do nothing else with it, and instead...
> 
> > +        pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
> 
> ...create a second instance of it via pci_new_multifunction().
> So now there are two copies of this device, one half-initialized
> and leaked, and the second one which we actually use.
 
Nice catch!

> What is the intention here? The value of the "disable" property
> on the device is presumably just going to be its default "false"
> value all the time, so can we drop that check entirely and
> create the device via pci_new_multifunction() unconditionally?

Yes.

Background: During development of the various machines it was
easier for me to just disable/enable the Diva card from the command
line via the "disable" property.
Commit 16786eb7bf86 ("hw/hppa: Add BMC on 64-bit machines only") now
simply disables diva on B160L, and for the C3700, although it never
had Diva boards, we will use Diva until we get SuperIO implemented.

The patch below should address this.
Maybe you can review?

Thanks!
Helge


From: Helge Deller <deller@gmx.de>
Subject: [PATCH] hw/hppa: Avoid leaking a diva-gsp device

Create a Diva-gsp unconditionally on all 64-bit PCI machines.
The A400 usually comes with a Diva card. The C3700 has a built-in
SUPERIO chip, which we haven't implemented yet, so running with an
emulated Diva is the best we can do for now.

Signed-off-by: Helge Deller <deller@gmx.de>
Noticed-by: Peter Maydell <peter.maydell@linaro.org>

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index f55e84529f..50ace81528 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -380,18 +380,15 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     if (pci_bus && hppa_is_pa20(&cpu[0]->env)) {
         /* BMC board: HP Diva GSP PCI card */
-        dev = qdev_new("diva-gsp");
-        if (dev && !object_property_get_bool(OBJECT(dev), "disable", NULL)) {
-            pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
-            if (!lasi_dev) {
-                /* bind default keyboard/serial to Diva card */
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
-            }
-            pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
+        pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
+        if (!lasi_dev) {
+            /* bind default keyboard/serial to Diva card */
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
         }
+        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
     }
 
     /* create USB OHCI controller for USB keyboard & mouse on Astro machines */

