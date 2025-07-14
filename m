Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84072C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRwL-00024Q-Ry; Mon, 14 Jul 2025 18:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kib@kib.kiev.ua>) id 1ubQdq-0008E5-NH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 17:23:19 -0400
Received: from kib.kiev.ua ([2001:470:d5e7:1::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kib@kib.kiev.ua>) id 1ubQdn-0007ln-U2
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 17:23:18 -0400
Received: from tom.home (kib@localhost [127.0.0.1] (may be forged))
 by kib.kiev.ua (8.18.1/8.18.1) with ESMTP id 56ELM5fG018818;
 Tue, 15 Jul 2025 00:22:08 +0300 (EEST)
 (envelope-from kib@kib.kiev.ua)
DKIM-Filter: OpenDKIM Filter v2.10.3 kib.kiev.ua 56ELM5fG018818
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=kib.kiev.ua; s=tom;
 t=1752528130; bh=Nulc9H/OLYQ96IdLYjHYoHT8pJqSbBT6ySlGUA4uNZw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DmT0Qe5W3jmTwwaCVEpUi28ImY9B8vDbAPnqFEMvDWQpl41HD48Q8Jtqh8GqRWPA6
 cWAYESEZKku0cE3sImPEuKUL6guVf9Y4afN0k5kAsR+Mfx8VLe2bIXTcZAAnsLH3Ua
 NiTn60n1DFF/L2kgYgGgnmkumVk+Z6JsrV9bD0Zs=
Received: (from kostik@localhost)
 by tom.home (8.18.1/8.18.1/Submit) id 56ELM3Kj018816;
 Tue, 15 Jul 2025 00:22:03 +0300 (EEST)
 (envelope-from kib@kib.kiev.ua)
X-Authentication-Warning: tom.home: kostik set sender to kib@kib.kiev.ua using
 -f
Date: Tue, 15 Jul 2025 00:22:03 +0300
To: David Woodhouse <dwmw2@infradead.org>
Cc: Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Le Tan <tamlokveer@gmail.com>,
 jhb@freebsd.org,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
Message-ID: <aHV0-wDJImAjRPPp@kib.kiev.ua>
References: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
 <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
 <4FE9A8E3-5BA5-46D3-A1FA-EA1B7C85C058@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4FE9A8E3-5BA5-46D3-A1FA-EA1B7C85C058@infradead.org>
Received-SPF: pass client-ip=2001:470:d5e7:1::1; envelope-from=kib@kib.kiev.ua;
 helo=kib.kiev.ua
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 14 Jul 2025 18:46:27 -0400
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
Reply-to:  Konstantin Belousov <kib@kib.kiev.ua>
From:  Konstantin Belousov via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 14, 2025 at 05:41:22PM +0100, David Woodhouse wrote:
> On 14 July 2025 15:28:09 GMT+01:00, Yi Liu <yi.l.liu@intel.com> wrote:
> >Hi David,
> >
> >On 2025/7/14 16:00, David Woodhouse wrote:
> >> From: David Woodhouse <dwmw@amazon.co.uk>
> >> 
> >> FreeBSD does both, and this appears to be perfectly valid. The VT-d
> >> spec even talks about the ordering (the status write should be done
> >> first, unsurprisingly).
> >
> >interesting. Have you tried setting both flags on baremetal and the hw
> >gives you both the status code and an interrupt?
> 
> I see no reason why it shouldn't. The spec (§6.5.2.8) gives no that the IF and SW bits should be mutually exclusive and even talks about ordering:
> 
> Section 6.5.2.11 describes queued invalidation ordering considerations. Hardware completes an 
> invalidation wait command as follows:
> • If a status write is specified in the wait descriptor (SW=1), hardware performs a coherent write of 
> the status data to the status address.
> • If an interrupt is requested in the wait descriptor (IF=1), hardware sets the IWC field in the 
> Invalidation Completion Status Register. An invalidation completion interrupt may be generated as 
> described in the following section
> 

Yes, and the FreeBSD DMAR code uses that, and relies on that, as was
mentioned earlier in the mail thread.

> 
> 
> >I think this "if branch" can be moved just after the inv_desc non-zero
> >reserved bit checking. Hence you don't need a ret at all. :)
> 
> We want to return false if the memory write fails, and the interrupt has to happen afterwards.
> 
> > btw. I'm
> >also asking if VT-d spec allows it or not. So let's wait for a while..
> 
> Ok.
> 
> 

