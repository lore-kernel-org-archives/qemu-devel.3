Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40614CCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEADL-0006vl-Mc; Wed, 29 Oct 2025 13:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEADK-0006pY-7Z
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEADA-0004ct-R3
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761759826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FC0pqOWjajrJZ/xYjC7DW4Vke/D0sHHKJifMVdVu3QI=;
 b=XQlQLKHY9I7tYliaHM1vTywllXZQ0j2pHX+817n5Ax/ffLYaGBAAjHaMA+basu3P1BEi4/
 zm6z6MTlli48XZDMF9VJucVlQdcGYGgt14TOCzfygq3ICyemM0z12DrZZId6SelD7/Je3s
 zNofkPZem76ojCaEkRg5EFp2iW0B2jY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-dZDj-0VTMum0oLulf3BSbA-1; Wed,
 29 Oct 2025 13:43:42 -0400
X-MC-Unique: dZDj-0VTMum0oLulf3BSbA-1
X-Mimecast-MFC-AGG-ID: dZDj-0VTMum0oLulf3BSbA_1761759821
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59AC5195399A; Wed, 29 Oct 2025 17:43:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.204])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03B4730001A2; Wed, 29 Oct 2025 17:43:36 +0000 (UTC)
Date: Wed, 29 Oct 2025 18:43:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH 08/16] nvme: Fix coroutine waking
Message-ID: <aQJSRicrD7NET-az@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-9-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028163343.116249-9-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
> nvme wakes the request coroutine via qemu_coroutine_enter() from a BH
> scheduled in the BDS AioContext.  This may not be the same context as
> the one in which the request originally ran, which would be wrong:
> - It could mean we enter the coroutine before it yields,
> - We would move the coroutine in to a different context.
> 
> (Can be reproduced with multiqueue by adding a usleep(100000) before the
> `while (data.ret == -EINPROGRESS)` loop.)
> 
> To fix that, schedule nvme_rw_cb_bh() in the coroutine AioContext.
> (Just like in the preceding iscsi and nfs patches, we could drop the
> trivial nvme_rw_cb_bh() and just use aio_co_wake() directly, but don’t
> do that to keep replay_bh_schedule_oneshot_event().)
> 
> With this, we can remove NVMeCoData.ctx.
> 
> Note the check of data->co == NULL to bypass the BH/yield combination in
> case nvme_rw_cb() is called from nvme_submit_command(): We probably want
> to keep this fast path for performance reasons, but we have to be quite
> careful about it:
> - We cannot overload .ret for this, but have to use a dedicated
>   .skip_yield field.  Otherwise, if nvme_rw_cb() runs in a different
>   thread than the coroutine, it may see .ret set and skip the yield,
>   while nvme_rw_cb() will still schedule a BH for waking.   Therefore,
>   the signal to skip the yield can only be set in nvme_rw_cb() if waking
>   too is skipped, which is independent from communicating the return
>   value.
> - We can only skip the yield if nvme_rw_cb() actually runs in the
>   request coroutine.  Otherwise (specifically if they run in different
>   AioContexts), the order between this function’s execution and the
>   coroutine yielding (or not yielding) is not reliable.
> - There is no point to yielding in a loop; there are no spurious wakes,
>   so once we yield, we will only be re-entered once the command is done.
>   Replace `while` by `if`.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

As suggested in an earlier patch, I prefer to keep setting -EINPROGRESS,
even if we don't check for it elsewhere, for better debugability.

Kevin


