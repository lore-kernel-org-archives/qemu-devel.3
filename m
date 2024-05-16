Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE215C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7bh0-0005gs-2Y; Thu, 16 May 2024 10:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=85909aada=nsaenz@amazon.es>)
 id 1s7bgs-0005dd-P7
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:02:39 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=85909aada=nsaenz@amazon.es>)
 id 1s7bgq-0005pG-Cv
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1715868157; x=1747404157;
 h=mime-version:content-transfer-encoding:date:message-id:
 cc:from:to:references:in-reply-to:subject;
 bh=PII+OyY3HRsFOpjW5l++XBk5W4fZ/zADl3BCmJlUORM=;
 b=QgSnYuvOiewSv1aRYKUg5cyngrp3zmH92tcx2WvUZyimkSVBgd+h+fMn
 g0Hh/k+Z5es6geSkh1XLk+b/RwK2JnSjlGnyaAkWolSUGkhaUCPIM/hBO
 6BBfzk3YzSQmnxyHOyn2BNcAlFVTWzedpf2VhpBLalcgUv8mkVTCssZC2 U=;
X-IronPort-AV: E=Sophos;i="6.08,164,1712620800"; d="scan'208";a="419475431"
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-9102.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 14:02:24 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:61258]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.38.98:2525]
 with esmtp (Farcaster)
 id 669cf238-0252-433a-b5ae-10131f992275; Thu, 16 May 2024 14:02:23 +0000 (UTC)
X-Farcaster-Flow-ID: 669cf238-0252-433a-b5ae-10131f992275
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 14:02:23 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 16 May
 2024 14:02:12 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 May 2024 14:02:09 +0000
Message-ID: <D1B4HKJAJG21.2DH9F3E1Q6J9L@amazon.com>
CC: Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
 Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Vitaly
 Kuznetsov" <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, "Rick P
 Edgecombe" <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>,
 Angelina Vu <angelinavu@linux.microsoft.com>, Anna Trikalinou
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
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
X-Mailer: aerc 0.17.0-129-gd582ac682cdf-dirty
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net> <ZjTuqV-AxQQRWwUW@google.com>
 <20240506.ohwe7eewu0oB@digikod.net> <ZjmFPZd5q_hEBdBz@google.com>
 <20240507.ieghomae0UoC@digikod.net> <ZjpTxt-Bxia3bRwB@google.com>
 <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com> <20240514.mai3Ahdoo2qu@digikod.net>
In-Reply-To: <20240514.mai3Ahdoo2qu@digikod.net>
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
Received-SPF: pass client-ip=207.171.184.29;
 envelope-from=prvs=85909aada=nsaenz@amazon.es; helo=smtp-fw-9102.amazon.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
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

On Tue May 14, 2024 at 12:23 PM UTC, Micka=C3=ABl Sala=C3=BCn wrote:
> > Development happens
> > https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-next
> > branch, but I'd advice against looking into it until we add some order
> > to the rework. Regardless, feel free to get in touch.
>
> Thanks for the update.
>
> Could we schedule a PUCK meeting to synchronize and help each other?
> What about June 12?

Sounds great! June 12th works for me.

Nicolas

