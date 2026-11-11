Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53480606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=fZIUaP/R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRECm-0007Qg-7F; Wed, 11 Nov 2026 14:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xRECk-0007QK-Iy
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 14:41:58 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xRECi-0007QJ-P9
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 14:41:58 -0500
Received: from example.com (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 9806F20B7166;
 Wed, 11 Nov 2026 11:41:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9806F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794426111;
 bh=26YS7wN8w2VoYIiOiYOdroCgAbMcLRg+s5MqFXpd7q0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fZIUaP/R1lO/GrcJRO0w0ryvLgwUZowalRlDLvFYDv+o/sDu3BHxIvlCvdlNfcROo
 exsha8LY+UGNl8A5Gsw4Lw5gFMJD0My0DYDGTKBJxC6gO1sikNlQyYm5130oA05zk9
 raRcAoV249q/LOq2usLlYMhrnt57vibiqSUXuiyI=
Date: Wed, 11 Nov 2026 20:41:51 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: Re: [PATCH] target/i386/mshv: add MshvPutState for vcpu writes
Message-ID: <avTE/ynd4hd+9CHt@example.com>
References: <20261109123949.724711-1-magnuskulke@linux.microsoft.com>
 <20261109203421.GB3536171@liuwe-devbox-debian-v2.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109203421.GB3536171@liuwe-devbox-debian-v2.local>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 12:34:21PM -0800, Wei Liu wrote:
> On Mon, Nov 09, 2026 at 01:39:49PM +0100, Magnus Kulke wrote:
> > Currently QEMU marks a vcpu state as dirty also on merely inspectional
> > reads, e.g. via "info registers", which triggers a writeback to the
> > hypervisor. For MSRs that cause a side-effect when written to this is
> > undesired.
> > 
> > We introduce an MshvPutState flag into the writeback logic to differentiate
> > "runtime" from "full" and "reset" writebacks that should occur e.g. after
> > a migration or startup.
> > 
> > Discrete side-effectful MSRs are excluded in runtime writebacks. So far
> > we only mark one MSR as not runtime-safe, but probably more will be
> > added eventually.
> > 
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> 
> Reviewed-by: Wei Liu <wei.liu@kernel.org>

queued in pull-20261111

