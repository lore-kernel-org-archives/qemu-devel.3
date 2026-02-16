Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E16E81A2B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 14:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs03Y-0000Th-Rj; Mon, 16 Feb 2026 09:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1vs03X-0000T2-9k
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 09:58:35 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1vs03V-00078f-LK
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 09:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date;
 bh=kEp5yCAkSItYMvkoIhmqya1saaFVQf+HKzKlaw/jnJA=; b=Q3Vt0CaqqOHQdwTvRxk4PBGXbo
 BVMPVirFsIY2g3/Xrf7yO2TxUhprRKEpJBanZ2OVB3AXnAQ/CwcHoDf7E3/W8Tulxl8QW5LHHrPs4
 HMIPeFxknSd52CAXVbxleSV1Ywl68ehVHZhHqsis1Nj+rLjt5D7FMpSxSW+BPgFFa6CM=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1vs03S-00BwP6-1C;
 Mon, 16 Feb 2026 14:58:30 +0000
Received: from [2a01:cb15:80df:da00:80b5:18da:fdf4:baa] (helo=l14)
 by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1vs03R-00AWgn-1l;
 Mon, 16 Feb 2026 14:58:30 +0000
Date: Mon, 16 Feb 2026 15:58:28 +0100
From: Anthony PERARD <anthony@xenproject.org>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH] xen-hvm: Emit RTC_CHANGE upon TIMEOFFSET ioreq
Message-ID: <aZMwlMwYufj6LCrU@l14>
References: <20260108135406.1879210-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108135406.1879210-1-ross.lagerwall@citrix.com>
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

On Thu, Jan 08, 2026 at 01:54:06PM +0000, Ross Lagerwall wrote:
> When the guest writes to the RTC, the write is intercepted and emulated
> by Xen and the time difference is broadcasted as a TIMEOFFSET ioreq.
> Emit an RTC_CHANGE QMP event when this happens rather than ignoring it
> so that something can make use of the information (e.g. the toolstack
> can persist it between VM starts).
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  hw/xen/xen-hvm-common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> index 59c73dfaeb59..9b539f5c5c56 100644
> --- a/hw/xen/xen-hvm-common.c
> +++ b/hw/xen/xen-hvm-common.c
> @@ -471,6 +472,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
>              cpu_ioreq_move(req);
>              break;
>          case IOREQ_TYPE_TIMEOFFSET:
> +            qapi_event_send_rtc_change((int64_t)req->data, NULL);

Would you be fine to replace `NULL` by `""`? I've notice a TODO in
visit_type_str() at
https://gitlab.com/qemu-project/qemu/-/blob/master/qapi/qapi-visit-core.c#L344
which is one of the function doing something with that parameter.

With that, which I can do on commit: Acked-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 
Anthony PERARD

