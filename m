Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9973C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 14:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfghT-0005FD-Iw; Wed, 05 Feb 2025 09:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1tfghR-0005F3-Sq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:48:21 -0500
Received: from out-177.mta0.migadu.com ([2001:41d0:1004:224b::b1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1tfghO-0006vQ-Ds
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:48:21 -0500
Message-ID: <1080d4d7-81d0-4497-bef9-22191a4b999e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1738766888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GihMlY52E+tqDtb6LBuVtlIjkxOQON6Oh7+f0QSJ3Pw=;
 b=kP1rKkkXr8nGIaYn4J+fedd8GACJSCJFvgDMssOB0NOiwMS22cCLkJpsKbFI58PhYRBl/S
 ifTss1Q7wnzoFgOIpb22i6QOioyIRyQPW2WJdkCQgrU2eWOtIic3jvmvEIYK8gQbZyInXm
 X0lg0qPyUn9nZIug7heoJUMOBeCSD2c=
Date: Wed, 5 Feb 2025 22:47:48 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 02/11] arm/hvf: Initialise GICv3 state just before first
 vCPU run
To: phil@philjordan.eu
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
References: <20241209203629.74436-1-phil@philjordan.eu>
 <20241209203629.74436-3-phil@philjordan.eu>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20241209203629.74436-3-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b1;
 envelope-from=zenghui.yu@linux.dev; helo=out-177.mta0.migadu.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2024/12/10 04:36, phil@philjordan.eu wrote:
> From: Phil Dennis-Jordan <phil@philjordan.eu>
> 
> Initialising the vCPU PFR0_EL1 system register with the GIC flag in
> hvf_arch_init_vcpu() does not actually work because the GIC state is
> not yet available at that time.
> 
> If we set this flag just before running each vCPU for the first time,
> the GIC will definitely be fully initialised at that point.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>  target/arm/hvf/hvf.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Tested-by: Zenghui Yu <zenghui.yu@linux.dev>

Thanks!

