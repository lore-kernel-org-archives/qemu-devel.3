Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66D2C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6ki-0005Pu-4G; Fri, 26 Jun 2026 09:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wd6kh-0005Pl-Bj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:37:51 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wd6kf-0007af-Qw
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:37:51 -0400
Received: from example.com (unknown [167.220.208.70])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4690720B7169;
 Fri, 26 Jun 2026 06:37:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4690720B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1782481061;
 bh=5XW7153AjlPKkYtZNaeOQDjxAAYp2scX56Fba5biufo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E0mplN5cXZzhaCDGg8+nwdCGYJdya1MwgrbEz4ubfNjAjkTU19DfCi3SAvDrZ8YZ2
 9ugVyy9FMkLz1IlixMm1S3b4rKchn8gK5ITN4HyTvrTI26PAclNHKIzmeROGcRiwht
 n1xrpO2YDATgOh3WnLF98W2ZM9ONqRic1f8KFdLk=
Date: Fri, 26 Jun 2026 15:37:41 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH v6 6/9] target/i386: query mshv accel for supported cpuids
Message-ID: <aj6ApQooh1CPff1T@example.com>
References: <20260416121116.527927-1-magnuskulke@linux.microsoft.com>
 <20260416121116.527927-7-magnuskulke@linux.microsoft.com>
 <db21ca7e-de25-46f3-b1a3-b199d35a7bcb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db21ca7e-de25-46f3-b1a3-b199d35a7bcb@redhat.com>
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

On Thu, Jun 25, 2026 at 05:16:44PM +0200, Paolo Bonzini wrote:
> On 4/16/26 14:11, Magnus Kulke wrote:
> > We implement mshv_get_supported_cpuid() and invoke it in
> > x86_cpu_get_supported_feature_word() retrieve the cpu features that the
> > host is supporting. Initially we mask the virtualization capabilitities
> > potentially we might need to mask more in the future.
> 
> Hopefully not - the difference between what the host and the guest support
> is not something that QEMU can know.
> 
> Apart from that, there's nothing that stands out so I'm applying the series.
> 
> Paolo

I think that is something that we will probably have to refine more.
Intuitively I would also say that the VMM shouldn't be concerned much about
host capabilities, however -cpu host has some interesting implications for a
VMM that is driving msft hypervisor. I understand some features (CET I think?)
would have an impact the instruction emulator. For KVM that would be in the
kernel, but for MSHV (and HVF, WHPX I think) that's userland.

We're still discussing with the hypervisor and kernel team what the proper
approach is, how we can reconcile cpuids with the flags that we pass at
partition creation and how much awareness should exist in the VMM. I can
imagine that we'll take a conservative approach and end up enumerating
the features that we support in QEMU (and extend them in future releases
if required).

thx,

magnus

