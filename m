Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36ACC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6rCF-0008N3-2l; Tue, 14 May 2024 08:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1s6rCB-0008Mc-To
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:23:51 -0400
Received: from smtp-bc08.mail.infomaniak.ch ([45.157.188.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1s6rC8-0005pM-DP
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:23:50 -0400
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VdwWP64pbzTXk;
 Tue, 14 May 2024 14:23:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
 s=20191114; t=1715689425;
 bh=I0eZWdP4Q+KPu4Hx3s3mpwHuoQ0UvkeO9/nafOAr82w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HUYIhJQSGxJF3jwUizanlmonUX7sygOvcV8noUaAFzN0V3a3iKwuGB8/GEum6Clxq
 EcKo1qBH3Un5VS8jWoGkoTi3TiKlCjIcaIL1kB+8poVzqExKvp5IQ2ywDDPeKqlugY
 OVZlyAPCKt5gtA5k6143lcqKUer3NgtqPGvwYp+A=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VdwWN5tzlzF2L; Tue, 14 May 2024 14:23:44 +0200 (CEST)
Date: Tue, 14 May 2024 14:23:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Sean Christopherson <seanjc@google.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 Wanpeng Li <wanpengli@tencent.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
 Alexander Graf <graf@amazon.com>, Angelina Vu <angelinavu@linux.microsoft.com>,
 Anna Trikalinou <atrikalinou@microsoft.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, 
 Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
 James Morris <jamorris@linux.microsoft.com>,
 John Andersen <john.s.andersen@intel.com>, 
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>, 
 Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
 =?utf-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>, 
 Thara Gopinath <tgopinath@microsoft.com>, Trilok Soni <quic_tsoni@quicinc.com>,
 Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
 Yu Zhang <yu.c.zhang@linux.intel.com>,
 =?utf-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>, 
 dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
 linux-hardening@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, 
 x86@kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
Message-ID: <20240514.mai3Ahdoo2qu@digikod.net>
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com> <20240507.ieghomae0UoC@digikod.net>
 <ZjpTxt-Bxia3bRwB@google.com>
 <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com>
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=45.157.188.8; envelope-from=mic@digikod.net;
 helo=smtp-bc08.mail.infomaniak.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 10, 2024 at 10:07:00AM +0000, Nicolas Saenz Julienne wrote:
> On Tue May 7, 2024 at 4:16 PM UTC, Sean Christopherson wrote:
> > > If yes, that would indeed require a *lot* of work for something we're not
> > > sure will be accepted later on.
> >
> > Yes and no.  The AWS folks are pursuing VSM support in KVM+QEMU, and SVSM support
> > is trending toward the paired VM+vCPU model.  IMO, it's entirely feasible to
> > design KVM support such that much of the development load can be shared between
> > the projects.  And having 2+ use cases for a feature (set) makes it _much_ more
> > likely that the feature(s) will be accepted.
> 
> Since Sean mentioned our VSM efforts, a small update. We were able to
> validate the concept of one KVM VM per VTL as discussed in LPC. Right
> now only for single CPU guests, but are in the late stages of bringing
> up MP support. The resulting KVM code is small, and most will be
> uncontroversial (I hope). If other obligations allow it, we plan on
> having something suitable for review in the coming months.

Looks good!

> 
> Our implementation aims to implement all the VSM spec necessary to run
> with Microsoft Credential Guard. But note that some aspects necessary
> for HVCI are not covered, especially the ones that depend on MBEC
> support, or some categories of secure intercepts.

We already implemented support for MBEC, so that should not be an issue.
We just need to find the best interface to configure it.

> 
> Development happens
> https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-next
> branch, but I'd advice against looking into it until we add some order
> to the rework. Regardless, feel free to get in touch.

Thanks for the update.

Could we schedule a PUCK meeting to synchronize and help each other?
What about June 12?

