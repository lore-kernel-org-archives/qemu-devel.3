Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7097CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wewta-0005Lb-Lc; Wed, 01 Jul 2026 11:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wewtO-0005Es-VO
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 11:30:31 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wewtM-0003ox-6f
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 11:30:25 -0400
Received: from example.com (unknown [167.220.208.73])
 by linux.microsoft.com (Postfix) with ESMTPSA id DD0BC20B7166;
 Wed,  1 Jul 2026 08:30:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD0BC20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1782919820;
 bh=HWPrvAn7EFe4ZnZmgq/RGK7Brh0+CpGD2KIlAvcJrEU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xoj8ppFISXUIsK62XSbTpm0YiH5nq/muNly1+6Q9Mf7/wLXJj/xzu0IVI+qTBdqBd
 /7154wseo4VJ6BFJlJ5n0Jncsok0wgMDj4rm1LkAt4osunknuYuXwRCbI7JRmksysv
 SSjAUTDFCrolwI9tVDWC5ebJ+8aDUMHBARXYmqB0=
Date: Wed, 1 Jul 2026 17:30:16 +0200
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
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
Message-ID: <akUyiNahX3LnFPhn@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
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

On Fri, Jun 26, 2026 at 09:27:20AM +0200, Paolo Bonzini wrote:
> Il ven 17 apr 2026, 12:57 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
> scritto:
> 
> > +#ifdef CONFIG_MSHV
> 
> + VMSTATE_BUFFER(hv_lapic_state, APICCommonState),
> 
> +#endif
> 
> 
> This breaks migration across releases for everyone else, and also across
> builds that have different --enable-mshv. Compile-time defines are almost
> always wrong in VMState definitions.
> 
>      DeviceState *vapic;
> >      hwaddr vapic_paddr; /* note: persistence via kvmvapic */
> >      uint32_t extended_log_dest;
> > +
> > +#ifdef CONFIG_MSHV
> > +    uint8_t hv_lapic_state[sizeof(struct
> > hv_local_interrupt_controller_state)];
> > +#endif
> >
> 
> No, this is called common for a reason. You need to implement a subclass
> and handle migration in there.
> 

makes sense. I think I found a way to put the additional fields into a
subclass. the apic_id is semantic, so we cannot use the auto-wiring
dc->vmds state, but APIC_COMMON is doing the same. I'll send a revised patch
soon.

thanks,

magnus

