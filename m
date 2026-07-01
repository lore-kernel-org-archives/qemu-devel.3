Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50054C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weuvH-00009J-EA; Wed, 01 Jul 2026 09:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1weuvG-000099-1w
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:24:14 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1weuvE-0008Jm-IP
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:24:13 -0400
Received: from example.com (unknown [167.220.208.73])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0B3B920B7167;
 Wed,  1 Jul 2026 06:24:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B3B920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1782912249;
 bh=FJXGCuhp48uKfk0TV04CNmWLlVinLUjc+rqhaT8tlv0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xds/Ex/M4niLyyhSeMQKIahq0dkxrk7+kWxdzeoQlnLo4VrkQp+0rHleu6BvLybwC
 f3HdVqxpHwOaoQyV7U/SPU1ywbG7BsKcZ0amGelwlGSPyHArKEN1DfMh+45Ar+7x6H
 huh+HqMZxGpil7LwhNicb7nd8tSHOhU8vv1/Vkhg=
Date: Wed, 1 Jul 2026 15:24:07 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 30/45] target/i386/mshv: migrate MSRs
Message-ID: <akUU94ubeLfMOqm7@example.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
 <20260626101748.1728079-31-pbonzini@redhat.com>
 <CAFEAcA_v4guR1-MchVKoM_tQxW-ECWAvRLLY9MR7qMC0XjOcFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_v4guR1-MchVKoM_tQxW-ECWAvRLLY9MR7qMC0XjOcFA@mail.gmail.com>
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

On Mon, Jun 29, 2026 at 03:37:08PM +0100, Peter Maydell wrote:
> 
> Hi; Coverity complains about use of an uninitialized struct
> field in this commit (CID 1660875):
> 
> > +int mshv_get_msrs(CPUState *cpu)
> > +{
> > +    int ret = 0;
> > +    size_t n_assocs = ARRAY_SIZE(msr_env_map);
> > +    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];
> 
> This array has no initializer, so the elements start out
> with no initialized fields.
> 

yeah, I see why static analysis stumbles over this. mshv_set_msrs()
is doing the same thing, I'll send a patch that initializes both arrays.

thanks,

magnus

