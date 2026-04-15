Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7495AF43821
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 14:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD14m-0005N7-SK; Wed, 15 Apr 2026 10:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wD14j-0005Mp-24
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:18:41 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wD14h-0002kd-Ah
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:18:40 -0400
Received: from example.com (unknown [167.220.208.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1C06C20B7128;
 Wed, 15 Apr 2026 07:18:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C06C20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776262717;
 bh=aeXExjPuQZAoaKZYihPFonqFHCGN0d7/OAudhEO8eHg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dvX3wzmT0MAFrSG3NjPC0ULo/o5XOTlPTDyg3gh51Mxr3IO3GZX3EI0LxMOvb6Lsl
 rZoRBJTbVpII8kv1Jvk9awk3nB7uHK+z5FSFQuTrpPbFvxMUC012jEa4jVkCWTlplu
 Rd6oV0DSG1vIZ328ED4qMcWyct0D8tdgtaRLYHK0=
Date: Wed, 15 Apr 2026 16:18:32 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 8/9] target/i386/mshv: filter out CET bits in cpuid
Message-ID: <ad+eOA8gz26GBgzD@example.com>
References: <20260414155433.483186-1-magnuskulke@linux.microsoft.com>
 <20260414155433.483186-9-magnuskulke@linux.microsoft.com>
 <32594f82-0268-4844-830a-4147bd1598f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32594f82-0268-4844-830a-4147bd1598f6@redhat.com>
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

On Tue, Apr 14, 2026 at 06:10:19PM +0200, Paolo Bonzini wrote:
> I don't understand this, but it seems to be a Linux bug.  Don't *all* xsave
> features cause changes to CPUID[0xD,1].EBX?

oh, you're right, thx. the CPUID[0xD,1].EBX responses (also CPUID[0xD,0])
returned wrong responses in all cases the introduction of CET in QEMU
probably just triggered some overflow, but it was broken before.

We cannot statically register size responses for xsave features that a
guest can dynamically enable/disable.

I was planning to implement a dynamic handler for the xsave size
responses anyway, but maybe there's an easier way: We can provide an ebx
mask = 0 in the payload when we register the cpuid responses at the
hypervisor. If we do that for CPUID[0xD,{0,1}], the hypervisor should
return the answer based on the guest state (XCR0,XSS).

I'll test this approach and probably post a new revision with one of
those options.

