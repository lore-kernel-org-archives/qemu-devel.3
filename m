Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F12EC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 16:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJaXw-0001mc-BM; Mon, 26 May 2025 12:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1uJaXl-0001lp-Pg
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:19:18 -0400
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1uJaXi-0007Oe-Qy
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=TOX79ZSmgRULME2Nk+t8dw5ev91nIx7AxNQiiFtsGbI=; b=yq8Ra8XR+FLBIw4lnHakNx4rqr
 ccdqJqBawJiZ5pL2iuGinOI6+RGKft2Jk/X2JmoExCCsv39a1hNmeXxNT3B43Sn61usPWjtF6cfHW
 GyzzvqofNsZG2Ofw5bOzpw3ApY/w95APDqYmjC7YYyy1eSm3BlRJ8hcTOf0d7KQUoDb8=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1uJaXd-003R7Z-0N;
 Mon, 26 May 2025 16:19:09 +0000
Received: from [2a01:e0a:1da:8420:b77:bd5:6e45:7633] (helo=l14)
 by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1uJaXd-00EFKx-0X;
 Mon, 26 May 2025 16:19:08 +0000
Date: Mon, 26 May 2025 18:19:06 +0200
From: Anthony PERARD <anthony@xenproject.org>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: dwmw@amazon.co.uk, roger.pau@citrix.com, xen-devel@lists.xenproject.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/xen: Fix trace_xs_node_read() params
Message-ID: <aDSUesF-KUYnIoxM@l14>
References: <20250523160134.218997-1-liam.merwick@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523160134.218997-1-liam.merwick@oracle.com>
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 23, 2025 at 04:01:34PM +0000, Liam Merwick wrote:
> When the '--enable-trace-backends=syslog' build option is configured,
> the following compilation error is encountered.
> 
> In file included from /usr/include/sys/syslog.h:207,
>                  from /usr/include/syslog.h:1,
>                  from ./trace/trace-hw_xen.h:224,
>                  from ../hw/xen/trace.h:1,
>                  from ../hw/xen/xen-bus-helper.c:13:
> In function ‘syslog’,
>     inlined from ‘_nocheck__trace_xs_node_read’ at ../hw/xen/trace-events:41:9,
>     inlined from ‘trace_xs_node_read’ at trace/trace-hw_xen.h:903:9,
>     inlined from ‘xs_node_read’ at ../hw/xen/xen-bus-helper.c:154:5:
> /usr/include/bits/syslog.h:45:3: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
>    45 |   __syslog_chk (__pri, __USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add a check that 'value' is not null before passing it to trace_xs_node_read().
> 
> Fixes: e6cdeee95990 ("hw/xen: Add xs_node_read() helper function")
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>

Acked-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 
Anthony PERARD

