Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7307E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVpY4-0005m2-SZ; Thu, 09 Jan 2025 05:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tVpY3-0005lo-31
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:13:55 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tVpY1-0008RG-JX
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=9tmbhfhUfBgbbojY26HWM7Bm8oOBTYN0N1sCjYdDK/o=; b=DxY3FbPQPuQw1c5MViigEAbIP8
 MZ1jDg09m7OpztLiJhAPUD0FpbQY7szXezM3Pbw2Y4kg1hqAY+IjNQKzysuznc0Zb/HUmaQAiT0ht
 StUM8NiNtULQltoN5gU4afQohn4GJNzpW16WsGfDRJmzEkhJ7IKoPHM58AJxiRtrULMM=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tVpXw-00CjsF-08;
 Thu, 09 Jan 2025 10:13:48 +0000
Received: from lfbn-gre-1-248-145.w90-112.abo.wanadoo.fr ([90.112.205.145]
 helo=l14) by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tVpXv-009DaG-37;
 Thu, 09 Jan 2025 10:13:48 +0000
Date: Thu, 9 Jan 2025 11:13:45 +0100
From: Anthony PERARD <anthony@xenproject.org>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/2] xen/console: fix error handling in
 xen_console_device_create()
Message-ID: <Z3-hWRLyMldV4ZZD@l14>
References: <20250107093140.86180-1-roger.pau@citrix.com>
 <20250107093140.86180-2-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107093140.86180-2-roger.pau@citrix.com>
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

On Tue, Jan 07, 2025 at 10:31:39AM +0100, Roger Pau Monne wrote:
> The usage of error_prepend() in some of the error contexts of
> xen_console_device_create() is incorrect, as `errp` hasn't been initialized.
> This leads to the following segmentation fault on error paths resulting from
> xenstore reads:
> 
> Program terminated with signal SIGSEGV, Segmentation fault.
> Address not mapped to object.
>     fmt=0x15c4dfeade42 "failed to read console device type: ", ap=0x15cd0165ab50)
>     at ../qemu-xen-dir-remote/util/error.c:142
> 142         g_string_append(newmsg, (*errp)->msg);
> [...]
> (gdb) bt
>     (errp=0x15cd0165ae10, fmt=0x15c4dfeade42 "failed to read console device type: ", ap=0x15cd0165ab50) at ../qemu-xen-dir-remote/util/error.c:142
>     (errp=0x15cd0165ae10, fmt=0x15c4dfeade42 "failed to read console device type: ")
>     at ../qemu-xen-dir-remote/util/error.c:152
>     (backend=0x43944de00660, opts=0x43944c929000, errp=0x15cd0165ae10)
>     at ../qemu-xen-dir-remote/hw/char/xen_console.c:555
> 
> Replace usages of error_prepend() with error_setg() where appropriate.
> 
> Fixes: 9b7737469080 ('hw/xen: update Xen console to XenDevice model')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
>  hw/char/xen_console.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> index ef0c2912efa1..af706c7ef440 100644
> --- a/hw/char/xen_console.c
> +++ b/hw/char/xen_console.c
> @@ -551,7 +551,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
>      }
>  
>      if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
> -        error_prepend(errp, "failed to read console device type: ");
> +        error_setg(errp, "failed to read console device type: ");

According to error_setg() doc, *errp must be NULL but xs_node_scanf may
set it. Looking at the implementation, error_setg() seems to simply
discard this new error message if *errp is already set.

Currently, when there's an I/O error, we get something like:
    failed to read console device type: failed to read from /xenstore/path: doesn't exist
and when the format scan failed:
    SEGV

With this patch, when there's an I/O error, I think we get something
like:
    failed to read from /xenstore/path: doesn't exist
and when the format scan failed:
    failed to read console device type: 


So I think we'll want to distiguish between IO error from
xs_node_scanf() and format error, first one returns EOF (like vsscanf)
and second one returns a value >= 0 but we expect exactly 1.


>          goto fail;
>      }
>  
> @@ -582,7 +582,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
>      } else if (number) {
>          cd = serial_hd(number);
>          if (!cd) {
> -            error_prepend(errp, "console: No serial device #%ld found: ",
> +            error_setg(errp, "console: No serial device #%ld found: ",
>                            number);

This change looks correct, ableit we could remove ":  " from the end of
the string since they shouldn't be anything after it.


Cheers,

-- 
Anthony PERARD

