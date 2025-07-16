Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662A8C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 04:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubtPU-0006fg-Qh; Wed, 16 Jul 2025 00:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kostikbel@gmail.com>)
 id 1ubtPP-0006dR-TR
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 00:06:19 -0400
Received: from kib.kiev.ua ([2001:470:d5e7:1::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kostikbel@gmail.com>)
 id 1ubtPI-00052V-UB
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 00:06:18 -0400
Received: from tom.home (kib@localhost [127.0.0.1] (may be forged))
 by kib.kiev.ua (8.18.1/8.18.1) with ESMTP id 56G4559f075934;
 Wed, 16 Jul 2025 07:05:08 +0300 (EEST)
 (envelope-from kostikbel@gmail.com)
DKIM-Filter: OpenDKIM Filter v2.10.3 kib.kiev.ua 56G4559f075934
Received: (from kostik@localhost)
 by tom.home (8.18.1/8.18.1/Submit) id 56G454nL075933;
 Wed, 16 Jul 2025 07:05:04 +0300 (EEST)
 (envelope-from kostikbel@gmail.com)
X-Authentication-Warning: tom.home: kostik set sender to kostikbel@gmail.com
 using -f
Date: Wed, 16 Jul 2025 07:05:04 +0300
From: Konstantin Belousov <kostikbel@gmail.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Konstantin Belousov <kib@kib.kiev.ua>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Le Tan <tamlokveer@gmail.com>,
 "jhb@freebsd.org" <jhb@freebsd.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
Message-ID: <aHck8KHvEJqrRJ2s@kib.kiev.ua>
References: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
 <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
 <4FE9A8E3-5BA5-46D3-A1FA-EA1B7C85C058@infradead.org>
 <aHV0-wDJImAjRPPp@kib.kiev.ua>
 <afe3881b-1193-4d89-b0d0-6c316e54684f@eviden.com>
 <7cf6b91c1e1ea8b50d116f738215bcb55732b214.camel@infradead.org>
 <d84bdcab-3d2e-4731-a9aa-b8094fbaf7e8@eviden.com>
 <1d00dc9f-7647-4aa5-9ca5-987a06ce4292@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d00dc9f-7647-4aa5-9ca5-987a06ce4292@intel.com>
Received-SPF: softfail client-ip=2001:470:d5e7:1::1;
 envelope-from=kostikbel@gmail.com; helo=kib.kiev.ua
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FROM=0.001, MAY_BE_FORGED=0.001,
 NML_ADSP_CUSTOM_MED=0.9, SPF_HELO_PASS=-0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

On Wed, Jul 16, 2025 at 12:01:44PM +0800, Yi Liu wrote:
> On 2025/7/15 20:27, CLEMENT MATHIEU--DRIF wrote:
> > 
> > 
> > On 15/07/2025 10:27 am, David Woodhouse wrote:
> > > On Tue, 2025-07-15 at 06:11 +0000, CLEMENT MATHIEU--DRIF wrote:
> > > > 
> > > > 
> > > > On 14/07/2025 11:22 pm, Konstantin Belousov wrote:
> > > > > 
> > > > > On Mon, Jul 14, 2025 at 05:41:22PM +0100, David Woodhouse wrote:
> > > > > > On 14 July 2025 15:28:09 GMT+01:00, Yi Liu <yi.l.liu@intel.com>
> > > > > > wrote:
> > > > > > > Hi David,
> > > > > > > 
> > > > > > > On 2025/7/14 16:00, David Woodhouse wrote:
> > > > > > > > From: David Woodhouse <dwmw@amazon.co.uk>
> > > > > > > > 
> > > 
> > > > > > > I think this "if branch" can be moved just after the inv_desc non-zero
> > > > > > > reserved bit checking. Hence you don't need a ret at all. :)
> > > > > > 
> > > > > > We want to return false if the memory write fails, and the
> > > > > > interrupt has to happen afterwards.
> > > > 
> > > > Per spec: "Hardware behavior is undefined if the Status Address
> > > > specified is not an address route-able to memory"
> > > > 
> > > > Do we want to trigger the interrupt even when the DMA fails?
> > > 
> > > Yes, we do. That's a quality of implementation issue. Just because the
> > > behaviour is 'undefined' and theoretically gives us permission to do
> > > whatever we like to the guest, we should still be as sensible as
> > > possible.
> > 
> 
> Personally, I'm fine with generating the interrupt even the status write
> failed. But to avoid potential conflict, I've also raised this question to
> the VT-d spec owner. Haven't got a clear answer yet. To further understand
> this, may I ask some dumb questions here. Why FreeBSD set both SW and IF
> flag. What is the usage model here. Would software consider that all the QI
> descriptors prior to this specific wait descriptor has succeeded when
> either the interrupt got invoked or the expected status is written back?

FreeBSD queues invalidations, each invalidation has the gen number. To
know that some invalidation finished, FreeBSD waits for the interrupt,
we do not scan the invalidation sequence word otherwise. There might be
further generations of the invalidation descriptors in flight when we
get the interrupt, which means that we need to know which generation is
finished.

