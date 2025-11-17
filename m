Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B423CCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL0tk-0003kJ-Pr; Mon, 17 Nov 2025 10:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vL0tL-0003ee-HH
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:11:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vL0tI-0000Ya-U4
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763392299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6KE6goOCYTbHnJiN5uMAGkLo5bLYgUp6jGT0oftmDo=;
 b=h/i1FYlxDDr8LQmowkj6OupuzHjnRDaraXMeuZWBkVr0XDourn4p2kU1TnnreJgXVpJIP+
 ODBZ8UZ688ilkNahvuyvCBA6mJzmcEdKEhY75IfiCB5ztIBS+fsi+FqbeED6RH/kBlklLB
 amfwNFQp5vspfKETEzgUu2HxQP63IoQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-JxSgCmfXP3uEeaq-QFgsLw-1; Mon,
 17 Nov 2025 10:11:36 -0500
X-MC-Unique: JxSgCmfXP3uEeaq-QFgsLw-1
X-Mimecast-MFC-AGG-ID: JxSgCmfXP3uEeaq-QFgsLw_1763392294
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86B2318D95D1; Mon, 17 Nov 2025 15:11:34 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.115])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 083D7180049F; Mon, 17 Nov 2025 15:11:29 +0000 (UTC)
Date: Mon, 17 Nov 2025 16:11:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH v2 00/19] block: Some multi-threading fixes
Message-ID: <aRs7H3gM9daWdHtT@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 10.11.2025 um 16:48 hat Hanna Czenczek geschrieben:
> Hi,
> 
> See the v1 cover letter for a general overview:
> 
> https://lists.nongnu.org/archive/html/qemu-block/2025-10/msg00501.html
> 
> Changes in v2:
> - Kept `.ret = EINPGORESS`-style initializations where they already had
>   been (curl, nvme)
> - Dropped trivial BH waking code (i.e. which can be directly replaced by
>   aio_co_wake()) in iscsi, nfs, nvme
> - curl: Yield in curl_do_preadv() (former curl_setup_preadv()) and
>   curl_find_buf() instead of returning whether curl_co_preadv() has to
>   yield or not
> - nvme: Added a patch that annotates some functions (primarily BHs and
>   CBs) with which AioContext they (must) run in
> - qcow2 cache-cleaning timer: Run the timer as a coroutine instead of in
>   a timer CB; use a CoQueue to await it exiting instead of polling
>   (well, we still need to poll in case we don’t run in a coroutine, but
>   that’s standard procedure, I believe)
>   - The need to initialize the CoQueue showed that there is a code path
>     in qcow2 that doesn’t initialize its CoMutex.  Added a patch to do
>     that.
>   - Also added a patch to have the timer use realtime instead of virtual
>     time.

I'll still wait for your answer on patch 12 before applying (and
possibly making that last change), but you can already have:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


