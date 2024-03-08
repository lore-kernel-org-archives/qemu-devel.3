Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC63C54E5C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 09:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riWAd-0004qi-Dz; Fri, 08 Mar 2024 04:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1riWAZ-0004qB-5F
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 04:05:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1riWAV-00027Y-Sl
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 04:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709888730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HhcyiBJsql37fzfCbhFxbwAqAYuumhdE1wWfFnxYqPo=;
 b=PxeIFy4wid7krpCqgy8wZGqUoeyvOhpDG356H8nGKr6d0yT7Xg7PVsVEuZJ1IfwUMjrYpi
 efsryxvlwLN8GYaQyfNIYsMMNpu2UQNwiR2ZUSm9MziF2RgHn4qx4kBrFN1oeELTaRtwL6
 /v1E1Jh9/23VdU0rm2E6DDaGqzAwFH0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-wx1X7r5QPHirPuy7UokM1A-1; Fri,
 08 Mar 2024 04:05:28 -0500
X-MC-Unique: wx1X7r5QPHirPuy7UokM1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65FD53815F6A;
 Fri,  8 Mar 2024 09:05:28 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2EB540C6CC7;
 Fri,  8 Mar 2024 09:05:26 +0000 (UTC)
Date: Fri, 8 Mar 2024 10:05:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] linux-aio: add IO_CMD_FDSYNC command support
Message-ID: <ZerU1a6U8Xx0_R6s@redhat.com>
References: <20240307114744.1135711-1-ppandit@redhat.com>
 <ZenGQZE4hlOR6J4V@redhat.com>
 <CAE8KmOzQVFrK3kh6M3-TAm_=hsGB7KP+wjN8synRotd68A_O-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOzQVFrK3kh6M3-TAm_=hsGB7KP+wjN8synRotd68A_O-Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 07.03.2024 um 18:19 hat Prasad Pandit geschrieben:
> Hi,
> 
> On Thu, 7 Mar 2024 at 19:21, Kevin Wolf <kwolf@redhat.com> wrote:
> > Kernel support for this is "relatively" new, added in 2018. Should we
> > fall back to the thread pool if we receive -EINVAL?
> 
> laio_co_submit
>   laio_do_submit
>     ioq_submit
>       io_submit
> 
> * When an aio operation is not supported by the kernel, io_submit()
> call would return '-EINVAL', indicating that the specified (_FDSYNC)
> operation is invalid for the file descriptor. ie. an error (-EINVAL)
> needs to reach the 'laio_co_submit' routine above, to make its caller
> fall back on the thread-pool functionality as default.

Hm... This might make it more challenging because then not only one
specific request fails, but the whole submission batch. Do we know if it
can include unrelated requests?

> * Strangely the 'ioq_submit' routine above ignores the return value
> from io_submit and returns void. I think we need to change that to be
> able to fall back on the thread-pool functionality. I'll try to see if
> such a change works as expected. Please let me know if there's another
> way to fix this.

It passes the return value to the request:

    if (ret < 0) {
        /* Fail the first request, retry the rest */
        aiocb = QSIMPLEQ_FIRST(&s->io_q.pending);
        QSIMPLEQ_REMOVE_HEAD(&s->io_q.pending, next);
        s->io_q.in_queue--;
        aiocb->ret = ret;
        qemu_laio_process_completion(aiocb);
        continue;
    }

laio_co_submit() then fetches it from laiocb.ret and returns it to its
caller (in this case, your new code).

Kevin


