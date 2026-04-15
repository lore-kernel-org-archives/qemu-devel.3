Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8BFF43832
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD290-0005JE-SH; Wed, 15 Apr 2026 11:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wD28u-0005Ic-3c
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 11:27:05 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wD28s-00011T-8m
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 11:27:03 -0400
Received: from example.com (unknown [167.220.208.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 3A18F20B7128;
 Wed, 15 Apr 2026 08:26:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A18F20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776266820;
 bh=IcVUSe+PHB+dOBsbjhy3MfWW1lwb+qwPY6z3thsaDiM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UXCywp6gpkFXhXDhiYhon8zh3rDWM6YO3ilENOtwKO8SuoKTQTfZMzvKgHFWpa0DL
 yQLve/+yd3GbfVIZKxl6gutGeykY3eZnqiz9CjKCe0qzYH3z/aRo/v0sPEgDnRekuV
 dWcP5TCthlwclp7+8N1DvNbzAhGCWyshwkRI1KC4=
Date: Wed, 15 Apr 2026 17:26:56 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Wei Liu <wei.liu@kernel.org>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 8/9] target/i386/mshv: filter out CET bits in cpuid
Message-ID: <ad+uQBS8YMxU1e3G@example.com>
References: <20260414155433.483186-1-magnuskulke@linux.microsoft.com>
 <20260414155433.483186-9-magnuskulke@linux.microsoft.com>
 <32594f82-0268-4844-830a-4147bd1598f6@redhat.com>
 <ad+eOA8gz26GBgzD@example.com>
 <CC49AF2B-9E21-47BF-BC92-531F77606D14@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CC49AF2B-9E21-47BF-BC92-531F77606D14@unpredictable.fr>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 15, 2026 at 04:30:10PM +0200, Mohamed Mediouni wrote:
> Is CPUID performance such a problem?
> 
> What I have from WHPX on this - where for now CPUID vmexits are used 
> instead of this fancy interface* - although that might change in the future:
> 
> Those have been seen to vary dynamically for a vCPU:
> 
> CPUID[1:EDX].APIC
> CPUID_7_0_EDX_CET_IBT
> CPUID_7_0_ECX_CET_SHSTK
> CPUID_7_0_ECX_OSPKE
> CPUID_EXT_OSXSAVE
> The whole 0xD leave
> 
> I used the default result to override with the Hyper-V stock response for those bits,
> although masking as provided by the new interface would work too.
> 
> * not using it yet because Windows 10 Hyper-V didn’t have it, and the perf impact for CPUIDs
>  didn’t sound like an actual problem so trapped as much leaves as it could make sense
> 

Hey Mohamed. yeah, it's arguable.

I would prefer not to introduce a VM exit. You are probably right that
it doesn't matter much, however I can imagine that there are workloads
that perform feature detection in a hot path (e.g. right before some
AVX computation) and trapping it to the vmm would impact perf for those.

But yeah, if it turns out that the static responses and the mask do not
work, we have to consider this.

best,

magnus

