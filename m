Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F3CC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 17:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIA0l-0007WX-BQ; Thu, 22 May 2025 13:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uIA0H-0007VO-SQ
 for qemu-devel@nongnu.org; Thu, 22 May 2025 13:46:50 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uIA0G-00008w-2W
 for qemu-devel@nongnu.org; Thu, 22 May 2025 13:46:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A835B434C0;
 Thu, 22 May 2025 17:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7F2C4CEE4;
 Thu, 22 May 2025 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747935998;
 bh=urMf0wqaPqPDf/yCgAmxOkSKOKVHJHbLC+AdQvCe/TM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UqZyoTfKVk1tz1mV8OnO5khJihTxp39vew95fh4d2wqgadRAHB/jT7XvIqQB9sGGi
 vKpiN0d6UZl3irtdm1yo7GCZxDvL3YQE6f8S4p/6vZJaPoUt+POTzQHXLM7LEYQZ5Q
 3f0ridKcKi8Iax3uhLFeRZf1TklGfwuNuoYmGPoIHHLsnZBJwCXgPK3oM3i2DNbqcr
 B0vs+3nmfMx3BAafpvJwLdVdvzGWsgKPXjjF21oe1eStWTFBEhPTSN0ueMDhNEdmB6
 HOlT+TW+8Ietk7LDsHGZrEHTQOefXGcBLXTSPLmTZQyadXdZ4f855yqFz08dK1Qe/T
 9EJuO+/FJjkIg==
Date: Thu, 22 May 2025 17:46:37 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, magnuskulke@microsoft.com,
 qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 08/25] accel/mshv: Initialize VM partition
Message-ID: <aC9i_UAe_6MvNyx_@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-9-magnuskulke@linux.microsoft.com>
 <aCzS2h9UfGe-FZDW@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <aC9F+LITGPcwQoLl@example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC9F+LITGPcwQoLl@example.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=wei.liu@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 22, 2025 at 05:42:48PM +0200, Magnus Kulke wrote:
> On Tue, May 20, 2025 at 07:07:06PM +0000, Wei Liu wrote:
> > On Tue, May 20, 2025 at 01:30:01PM +0200, Magnus Kulke wrote:
> > > +static void mshv_reset(void *param)
> > > +{
> > > +    warn_report("mshv reset");
> > 
> > What's missing for this hook?
> > 
> 
> Ah, I suppose this was inspired by the KVM accel. The hook is called for
> cleanups that should occur on a reset. At the moment we don't have state
> that we want cleanup during reset afaik. So we can remove it here.

Right, please leave it out if it is not needed. We can add that hook
once we have something to clean up.

Thanks,
Wei.

