Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4B9C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgj0c-0002MF-QF; Mon, 06 Jul 2026 09:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wgj0X-0002LA-L9
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:05:09 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wgj0V-0002Ue-Tm
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:05:09 -0400
Received: from example.com (unknown [167.220.208.42])
 by linux.microsoft.com (Postfix) with ESMTPSA id D353F20B716B;
 Mon,  6 Jul 2026 06:04:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D353F20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783343102;
 bh=42ZU0Iw+ebDa0/X5YhAcUnBEM087OQr1GBPIsBa3FnA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nZ9OJYHR63/bEOzubXphlQMJ7E1M4wExiXdSbfdHvzASazJByZiZh792Q+8afv4z8
 DdfFlS9aaPFEOH4tHQP6l1IYG0EUAMIMpvsiOCz855WIkcbXFONjUx4JPRkLfXyxLY
 0F/HyOZdF6HEJXz4mkwRo6IICRFtyJMhKYNbVTAQ=
Date: Mon, 6 Jul 2026 15:05:00 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 26/34] accel/mshv: introduce SaveVMHandler
Message-ID: <akun/POlVcGDKoxK@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-27-magnuskulke@linux.microsoft.com>
 <CABgObfbS988oSPNOV4qLMcT1CPLAyu-NigwYPgZSgZq1ZY7fxA@mail.gmail.com>
 <akfvt0nTdVKZFOmJ@example.com>
 <CABgObfagW4TRZ5YcB-8SHizsjd2BafrcvTnu2fAkyV3_4_GT2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfagW4TRZ5YcB-8SHizsjd2BafrcvTnu2fAkyV3_4_GT2A@mail.gmail.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 03, 2026 at 07:50:43PM +0200, Paolo Bonzini wrote:
> There are different "schools of thought" for that. Freezing introduces an
> incorrect timing on the destination, not freezing introduces a jump.
> 
> If you choose to freeze that's fine, QEMU does the same for KVM even though
> KVM has alternative ioctls that allow not freezing.
> 
> But currently it's the wrong
> > place. I'll find some more fitting place to perform this ceremony.
> >
> 
> KVM uses a device for that, see kvnclock.c.

Makes sense, kvmclock looks like a good template. I'll use a similar object.

> 
> Curiously the time-frozen source was obscuring another potentially more
> > serious bug. The mshv vcpu dispatch loop currently does not honor a
> > cpu->exit_request
> 
> 
> Was that related to the other patch that was touching the vcpu thread loop?
> 

yup, we need the same here, I'll address it as part of a migration-pt2
series. we only need to check for cpu->exit_request and break the loop
if set.

best,

magnus

