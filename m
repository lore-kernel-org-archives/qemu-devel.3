Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4B4D116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 10:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOvdo-0001J3-E3; Fri, 28 Nov 2025 05:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vOvdl-0001II-9k
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 05:23:49 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vOvdj-0005vR-CB
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 05:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=v4lmNbL/oRiZTCSX5ADZDmiidcTX1Nr8tjZ7lLH2PSo=; b=D8X+OznoG3vJr93OYQYWtBABL2
 AnG9A91YaKVdVqruLVqXqfr1/25G+/7cKUy4QnSpNlTv5QozJ6lmQfuY4itOjoW55MZvd8vXOex31
 Jst94IWIHn5JGleWl7M7LR0c1B5o856YOT4v8ruU4FTc0DFbfzhWxQwSRO07LjBq1gZPgCR4USnyc
 mBjIrM09C84d/BAWWsiGydYv/w6PV0CooiveUzBOzOK0H6UBhjjscRPSbU4xVWjDvqRcwMAykJmfe
 WrGlw3IQUynoLkXZ6lnMWmZSWa/3V65DJZeOz+YvdyxC20XqyQN5gMwGiHx8qp4JBic5GdxEq1mEA
 RD9UuR9YxiQ3Kn+rPGxH/WIoWKDn8diFkAxknsZ16Gq1dcogaYdL/nZPgWsROSBygB7cGi1JEfLxT
 fq858tmgjUg39Fcdal/+gSd0beJfWDmDpE53Sbh5+Fkp0kFmzRgRB0GsYk6jeGV1C5Wi7/5Z97weA
 yGgFvM9ymGFbEHwelHPoL8lyiwrlO+feqfyyucUGhc4xOJ+K6z3E24iPmFQZHTwnpdiutIeFeRfO9
 yxH9/3uyMaJL2EAbwcG4eSP4hBPO16doOz6Qqy1bLJm5Blerb/ya8npyq9+x3wndnPyxahFPQw9OJ
 tmosQiT6nSb0lbx+q8sM2t8ETZsaP6XITrVaX1xlE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Greg Kurz <groug@kaod.org>, Andrey Erokhin <language.lawyer@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] 9pfs: local: read native symlinks when
 security-model=mapped
Date: Fri, 28 Nov 2025 11:23:42 +0100
Message-ID: <2808056.mvXUDI8C0e@weasel>
In-Reply-To: <3c35955d-a57e-4203-81c5-395146e23f83@gmail.com>
References: <3c35955d-a57e-4203-81c5-395146e23f83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Saturday, 22 November 2025 21:19:09 CET Andrey Erokhin wrote:
> Directories attached using virtfs with security-model=mapped
> may contain native symlinks
> 
> This can happen e.g. when booting from a rootfs directory tree
> (usually with a writable overlay set up on the host side)
> 
> Currently, when security-model=mapped[-xattr|-file],
> QEMU assumes that host-side "symlinks" are in the mapped format,
> i.e. are regular files storing the linked path,
> so it tries to open with O_NOFOLLOW
> and fails with ELOOP on native symlinks
> 
> This patch introduces a fallback for such cases:
> reuse security-model=[none|passthrough] else if branch logic
> where readlink will be called for the path basename
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/173
> 
> Signed-off-by: Andrey Erokhin <language.lawyer@gmail.com>
> ---
>  hw/9pfs/9p-local.c | 4 ++++
>  1 file changed, 4 insertions(+)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



