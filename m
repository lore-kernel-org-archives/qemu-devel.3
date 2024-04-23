Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E09C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 17:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzK5k-0000hF-A4; Tue, 23 Apr 2024 13:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stern+66302a62@netrider.rowland.org>)
 id 1rzK5h-0000gP-Sx
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:38:01 -0400
Received: from netrider.rowland.org ([192.131.102.5])
 by eggs.gnu.org with smtp (Exim 4.90_1)
 (envelope-from <stern+66302a62@netrider.rowland.org>)
 id 1rzK5g-0004M6-7V
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:38:01 -0400
Received: (qmail 422058 invoked by uid 1000); 23 Apr 2024 13:30:28 -0400
Date: Tue, 23 Apr 2024 13:30:28 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: Problems (timeouts) when testing usb-ohci with qemu
Message-ID: <10f44ba3-51a4-42a6-85c7-f8068b56fee1@rowland.harvard.edu>
References: <4664cf39-5dfe-4557-959d-149640ca36e1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4664cf39-5dfe-4557-959d-149640ca36e1@roeck-us.net>
Received-SPF: pass client-ip=192.131.102.5;
 envelope-from=stern+66302a62@netrider.rowland.org; helo=netrider.rowland.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Apr 23, 2024 at 10:04:17AM -0700, Guenter Roeck wrote:
> Hi,
> 
> when testing usb-ohci

What is usb-ohci?  Do you mean ohci-hcd?

>  with qemu's pci-ohci emulation, I keep getting
> random usb interface timeouts. Sometimes the usb_hub_wq times out.
...

> Sometimes there is an i/o scheduling timeout such as
...

> This is not a new problem; I have seen it forever. Recently I spent some
> time trying to understand the problem and found that the linux driver does
> not always handle all ohci interupts.

Please be more specific: _Which_ interrupts aren't being handled?  That 
is, which flags remain set in the intrstatus register when the handler 
returns?

>  Since the interrupt is shared and
> thus level triggered, that means that interrupts are still pending when
> ohci_irq() exits. The interrupt core in Linux does not re-enter the
> interrupt handler, presumably because it is marked as shared interrupt
> and returns that the interrupt has been handled.

Isn't that behavior mistaken?  A level-triggered IRQ that remains set when 
it is re-enabled (when the various shared handlers return) should cause 
another interrupt to occur right away.

Edged-triggered interrupts would be a different story, of course.

> I found two possible fixes for the problem. One essentially mirrors the
> code from ehci_irq(), the other adds a (bad) kludge into qemu. Both "fix"
> or work around the problem.
> 
> Question is: What is actually wrong ? Something in the generic interrupt
> handling code in Linux, something in the Linux usb-ohci driver, or
> something in qemu ? Any idea how a proper fix might look like ?

To answer these questions we need more information.

Alan Stern

