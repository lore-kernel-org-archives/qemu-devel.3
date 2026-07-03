Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BD7C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgej-0000uY-Qz; Fri, 03 Jul 2026 12:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wfgei-0000uN-DH
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:22:20 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wfgeh-0008HG-07
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=IMGZdWhR8EY97gkSF6hTgm3744EkzFLriNpqKs9IakE=; b=nQL8+EN61ZSiiNUHDMO+lWY7PT
 s1Y9PFRCSQiPCNsiRMki6H03LKPf8sWmLI22sxoulRjz+K2hl3ONSVtaYbPD5JHy+YaUiamPtpt9F
 GTVHunHWYQHnbcjErjstJ4LZh6zIP5pXha9sR++PAbw0lmNMS2sTwdB1xLhqQ5tD3hibtQcO9atR4
 b81YisIWqt9UhsS12wM0yT/l0Y3YZMpJ9qAfUv42knyyG1F9GC5vkllfnG8LpPKqBCZRLZuKCUd2O
 fz5NQfHz+4pR6T6leZnsJeIG2TKmUgJyejX0WBiNvT2vEY+DN5Ec1AVSm0pnpTi4giO+k6DVZN/bo
 ni3vIoO28HpOcKQUZsRVA46X735xCeIP2LxKCgdvEPu8BC0zExnYFjKwS5qoMNPd2QtwVrzEaVQTJ
 e4R4ZJQVcy3rlSTBW4djwsRVUhLzRrTnsjr/1NQsDH8kHufHuDZSJqJWl0qc/Je7Owtv/V5h/dVgf
 ofZ/7wOC2jemTRNXh2F1UkrIWvuOm5Rirqy+4afxxKyCr1PcZndtBf4NXDjnD+8BcBleKpxLRsUEK
 M2mWbKBDszspaIdVM7ewBCoRLEzFioy7G6NLj4mzjls919cZ92LXcwEpr5Pwy38FqKJmMgbplm4XX
 gVjHs7NY6oW1tVgSpX+YsoUyISofaJsYnIHZPbKnI=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] hw/9pfs: Check for error return from local_fid_fd()
Date: Fri, 03 Jul 2026 18:22:13 +0200
Message-ID: <2193677.KlZ2vcFHjT@weasel>
In-Reply-To: <20260703132528.4035684-1-peter.maydell@linaro.org>
References: <20260703132528.4035684-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Friday, 3 July 2026 15:25:28 CEST Peter Maydell wrote:
> The local_fid_fd() function can fail (returning -1 if dirfd() fails);
> check for this explicitly rather than relying on something later on
> failing because it was passed a -1 file descriptor.
> 
> This was flagged up by Coverity: CID 1660923, 1660924, 1660925
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/9pfs/9p-local.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index ee592b62f8..8f27c562b5 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -788,6 +788,9 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
>  {
>      int err, fd = local_fid_fd(fid_type, fs);
> 
> +    if (fd < 0) {
> +        return fd;
> +    }

Officially only -1 is an invalid file descriptor, and if you look at this file 
we therefore check file descriptors exactly against -1 for that reason.

For the Linux kernel the entire negative range is invalid for file 
descriptors, but keep in mind that 9pfs in QEMU also supports FreeBSD and 
macOS hosts and we have Windows host patches lurking around where things are 
not for certain, at least not for me. So I would not break that assumption.

You might also consider adding error_report_once() in local_fid_fd() as this 
would be an unexpected case, even though gracefully handled already.

/Christian




