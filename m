Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F1F1093163
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 01:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3P6c-0005tR-0g; Thu, 19 Mar 2026 21:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w3P6Y-0005sx-Vd
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 21:56:51 -0400
Received: from out-178.mta1.migadu.com ([95.215.58.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w3P6W-0000Nn-QC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 21:56:50 -0400
Message-ID: <ec871f3f-58f2-4165-a673-b0a45f87b89e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1773971803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AmvR/M3JI8dcsRutv6D6h9NwaJ2teAlvSiCFrM2lkk0=;
 b=dl8brKpC6x8ezz93/6sSalv7Hpqvq6hBSdQqnGwcNlWrBo3SEbaf7xFslOyjL5uNy97Pfw
 3xF/llFBjTvAjRtEFTzGEJDmEroKE5arHWzlfvLGGtH8DPlXfZFwbWUvnie0IQOx08JXii
 eNmxsUDtarsTxZM0/qxXXLgdOxnL0X0=
Date: Fri, 20 Mar 2026 09:56:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] target/arm: Don't skip access flag fault for AccessType_AT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
References: <20260317122517.47627-1-zenghui.yu@linux.dev>
 <CAFEAcA9bGVuWXAPA0=EaAWXhSigm_yf5OYfnYoTjaQ8x1qXKYg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <CAFEAcA9bGVuWXAPA0=EaAWXhSigm_yf5OYfnYoTjaQ8x1qXKYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.178; envelope-from=zenghui.yu@linux.dev;
 helo=out-178.mta1.migadu.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Peter,

On 3/20/26 1:17 AM, Peter Maydell wrote:
> On Tue, 17 Mar 2026 at 12:25, Zenghui Yu <zenghui.yu@linux.dev> wrote:
> >
> > As per the pseudo code from DDI0487 M.a.a (on J1-16021) AArch64.S1Walk():
> >
> >   // Check descriptor AF bit
> >   elsif (descriptor<10> == '0' && walkparams.ha == '0' &&
> >           (!accdesc.acctype IN {AccessType_DC, AccessType_IC} ||
> >            boolean IMPLEMENTATION_DEFINED "Generate access flag fault on IC/DC operations")) then
> >       fault.statuscode = Fault_AccessFlag;
> >
> > an access flag fault should be generated for AccessType_AT, if the AF bit
> > is 0 and !param.ha.
> 
> Did you find this by code inspection, or because it caused
> a guest to go wrong?

This was noticed when I was fixing the AT selftest on KVM side [*].

[*] https://lore.kernel.org/r/d58819b9-c745-4551-8ea4-e15af3fe63be@linux.dev

Thanks,
Zenghui

