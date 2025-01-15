Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5405FC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 16:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6aY-0007rG-08; Wed, 15 Jan 2025 11:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tY6aS-0007q6-Vb; Wed, 15 Jan 2025 11:49:49 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tY6aR-0003Dh-92; Wed, 15 Jan 2025 11:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date;
 bh=giFZVBXvBz5ocUI8W7ZNYz1JX4g1+Rv5di62MVhfyX0=; b=YNYy+BDsm6/M7B/b0tosWcIXKC
 WK7Btz8FRB1hHViajVZHZPyqAFTJEtuiOtLQUlQsZKgKtjh3kYm4T+dVaIKBoW7l9BF/F/aoTp+SY
 9KoQ5g0mtUCo1n8wA6+r+xPqpfYbLGYC5dnF4yvkKFtC0wF35YTO2O4tdA7EymioQ4LY=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tY6aJ-00666Q-2D;
 Wed, 15 Jan 2025 16:49:39 +0000
Received: from [2a01:e0a:1da:8420:b77:bd5:6e45:7633] (helo=l14)
 by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tY6aJ-006iXJ-2B;
 Wed, 15 Jan 2025 16:49:39 +0000
Date: Wed, 15 Jan 2025 17:49:37 +0100
From: Anthony PERARD <anthony@xenproject.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 7/7] hw/xen: Fix errp handling in xen_console
Message-ID: <Z4fnIQ8YbTP_i0U9@l14>
References: <20250115163542.291424-1-dwmw2@infradead.org>
 <20250115163542.291424-8-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115163542.291424-8-dwmw2@infradead.org>
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

On Wed, Jan 15, 2025 at 04:27:25PM +0000, David Woodhouse wrote:
> diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> index e61902461b..9e7f6da343 100644
> --- a/hw/char/xen_console.c
> +++ b/hw/char/xen_console.c
> @@ -581,19 +581,27 @@ static void xen_console_device_create(XenBackendInstance *backend,
>                         output);
>              goto fail;
>          }
> -    } else if (number) {
> -        cd = serial_hd(number);
> -        if (!cd) {
> -            error_prepend(errp, "console: No serial device #%ld found: ",
> -                          number);
> -            goto fail;
> -        }
> +    } else if (errno != ENOENT) {
> +        error_prepend(errp, "console: No valid chardev found: ");
> +        goto fail;
>      } else {
> -        /* No 'output' node on primary console: use null. */
> -        cd = qemu_chr_new(label, "null", NULL);
> -        if (!cd) {
> -            error_setg(errp, "console: failed to create null device");
> -            goto fail;
> +        if (errp) {

I don't think you need this check, with ERRP_GUARD() macro `errp` is
never NULL.

> +            error_free(*errp);

After this, I think you still need
    *errp = NULL;

> +        }
> +        if (number) {
> +            cd = serial_hd(number);
> +            if (!cd) {
> +                error_setg(errp, "console: No serial device #%ld found: ",

That error message doesn't need the ": " at the end anymore.

With those fixed: Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>

Cheers,

-- 
Anthony PERARD

