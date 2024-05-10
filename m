Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6866BC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5N9z-0004le-Vi; Fri, 10 May 2024 06:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8538b48ee=nsaenz@amazon.es>)
 id 1s5N9x-0004kY-4g
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:07:25 -0400
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8538b48ee=nsaenz@amazon.es>)
 id 1s5N9v-0005pA-1Z
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1715335643; x=1746871643;
 h=mime-version:content-transfer-encoding:date:message-id:
 subject:from:to:cc:references:in-reply-to;
 bh=ODj1UcfgLsilkOJ93AaBzpY+nLn2txKitmtJHEr2EDY=;
 b=kc/DavIS/SLMurK4C4dSvcTbcR7NbHvRn1GgwbbYa4130+6fYN1ytcxK
 owG9DXduIcgaQKs4uBIMaOYOWmAwWqGrt7JdCf/0ZdBPKYSpRXv2ZOApp
 GIw/aNUAmxAbGo+DzXc2ARjcXD2ExDeZpbrxZuuACRj6hFNx8FiJkH6Wm 4=;
X-IronPort-AV: E=Sophos;i="6.08,150,1712620800"; d="scan'208";a="88359429"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80009.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 10:07:15 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:54770]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.131:2525]
 with esmtp (Farcaster)
 id 0c298036-b7a6-49e7-b4ba-4e0b449ad4e5; Fri, 10 May 2024 10:07:14 +0000 (UTC)
X-Farcaster-Flow-ID: 0c298036-b7a6-49e7-b4ba-4e0b449ad4e5
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 10:07:13 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 10 May
 2024 10:07:03 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 10 May 2024 10:07:00 +0000
Message-ID: <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Sean Christopherson <seanjc@google.com>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
CC: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kees
 Cook" <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Rick P Edgecombe
 <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, Angelina Vu
 <angelinavu@linux.microsoft.com>, Anna Trikalinou
 <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 "Forrest Yuan Yu" <yuanyu@google.com>, James Gowans <jgowans@amazon.com>,
 James Morris <jamorris@linux.microsoft.com>, John Andersen
 <john.s.andersen@intel.com>, "Madhavan T . Venkataraman"
 <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>,
 =?utf-8?q?Mihai_Don=C8=9Bu?= <mdontu@bitdefender.com>,
 =?utf-8?q?Nicu=C8=99or_C=C3=AE=C8=9Bu?= <nicu.citu@icloud.com>, Thara
 Gopinath <tgopinath@microsoft.com>, "Trilok Soni" <quic_tsoni@quicinc.com>,
 Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, Yu Zhang
 <yu.c.zhang@linux.intel.com>, =?utf-8?q?=C8=98tefan_=C8=98icleru?=
 <ssicleru@bitdefender.com>, <dev@lists.cloudhypervisor.org>,
 <kvm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <virtualization@lists.linux-foundation.org>, <x86@kernel.org>,
 <xen-devel@lists.xenproject.org>
X-Mailer: aerc 0.16.0-127-gec0f4a50cf77
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net> <ZjTuqV-AxQQRWwUW@google.com>
 <20240506.ohwe7eewu0oB@digikod.net> <ZjmFPZd5q_hEBdBz@google.com>
 <20240507.ieghomae0UoC@digikod.net> <ZjpTxt-Bxia3bRwB@google.com>
In-Reply-To: <ZjpTxt-Bxia3bRwB@google.com>
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
Received-SPF: pass client-ip=99.78.197.220;
 envelope-from=prvs=8538b48ee=nsaenz@amazon.es; helo=smtp-fw-80009.amazon.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On Tue May 7, 2024 at 4:16 PM UTC, Sean Christopherson wrote:
> > If yes, that would indeed require a *lot* of work for something we're n=
ot
> > sure will be accepted later on.
>
> Yes and no.  The AWS folks are pursuing VSM support in KVM+QEMU, and SVSM=
 support
> is trending toward the paired VM+vCPU model.  IMO, it's entirely feasible=
 to
> design KVM support such that much of the development load can be shared b=
etween
> the projects.  And having 2+ use cases for a feature (set) makes it _much=
_ more
> likely that the feature(s) will be accepted.

Since Sean mentioned our VSM efforts, a small update. We were able to
validate the concept of one KVM VM per VTL as discussed in LPC. Right
now only for single CPU guests, but are in the late stages of bringing
up MP support. The resulting KVM code is small, and most will be
uncontroversial (I hope). If other obligations allow it, we plan on
having something suitable for review in the coming months.

Our implementation aims to implement all the VSM spec necessary to run
with Microsoft Credential Guard. But note that some aspects necessary
for HVCI are not covered, especially the ones that depend on MBEC
support, or some categories of secure intercepts.

Development happens
https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-next
branch, but I'd advice against looking into it until we add some order
to the rework. Regardless, feel free to get in touch.

Nicolas

