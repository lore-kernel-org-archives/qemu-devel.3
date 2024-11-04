Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019E7D1BDE5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 18:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t82Gq-0005pz-8d; Mon, 04 Nov 2024 13:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1t82Gn-0005pI-AK; Mon, 04 Nov 2024 13:57:45 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1t82Gl-0000vL-Nt; Mon, 04 Nov 2024 13:57:45 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4622EA43306;
 Mon,  4 Nov 2024 18:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E956C4CECE;
 Mon,  4 Nov 2024 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730746657;
 bh=7Gs5F1lfm/wZoRTwePr5MuZYpRPxEOao+m/MVnEbsmw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DzXMVfj9QcU8QBQEbAQ4Ds54GvY8nuDFCcW6HYjuDnpiMOVa0jeTEg2XeRTzx35rO
 PTDIZjvr5FkcsKyKqypSTJ8x4pOG7kIOZscvrb7olxbRIiABlRhBRcK6SUHdgdm2d6
 DiO37Z9BDTmO80NCWB5cNDLcQv6r98DJ8cBRHa9E+o1zzA65CT5qG7wDWZiTkq/+n5
 8msNIGgRZCGeM2rIsx/Pz2BXT8cN9enp0UIk3ojagBC4rx9bHh7gsROHtS/Nmip5mf
 aYlBaP5LEuZMfnXUBAye89nxZgu7BPpT3zv63PjzZY0z+FKdz8kAlIIpsI58g1IVzF
 v5f1uYJZAQl+A==
Date: Mon, 4 Nov 2024 11:57:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Waldemar Kozaczuk <jwkozaczuk@gmail.com>
Subject: Re: [PATCH v2] hw/nvme: fix handling of over-committed queues
Message-ID: <ZykZHvL_PtMMttqX@kbusch-mbp.dhcp.thefacebook.com>
References: <20241029-issue-2388-v2-1-e335658104cf@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-issue-2388-v2-1-e335658104cf@samsung.com>
Received-SPF: pass client-ip=147.75.193.91; envelope-from=kbusch@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Tue, Oct 29, 2024 at 01:15:19PM +0100, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> If a host chooses to use the SQHD "hint" in the CQE to know if there is
> room in the submission queue for additional commands, it may result in a
> situation where there are not enough internal resources (struct
> NvmeRequest) available to process the command. For a lack of a better
> term, the host may "over-commit" the device (i.e., it may have more
> inflight commands than the queue size).
>
> ...

LGTM

Reviewed-by: Keith Busch <kbusch@kernel.org>

