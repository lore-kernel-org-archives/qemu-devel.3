Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8E3C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 07:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXbzK-0004IH-2n; Wed, 07 Feb 2024 02:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXbzA-0004HW-63
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 02:04:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXbz8-0000o1-RX
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 02:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707289481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZHZyIRQUKWb/AUCDgSuBY1Pt7166CMJ+tHeNoSYCG0=;
 b=LCdzOu5OqUENFk+vguRMTFFyVyi2dLMCVbQdacjsVx1zftkoe9gWvPFFRV2dgfera2VY+C
 CehAWrQ0nAp3OQGlBFJPuU6CWMR1Payc+DwsIS6uyEygmGBnXf7NfNn6LVhVC0pLgX/txZ
 S51D/OWIUwCXkCsXp9NmmWcZvCpvvb8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-UognUprrOn6wSid2w_752g-1; Wed,
 07 Feb 2024 02:04:37 -0500
X-MC-Unique: UognUprrOn6wSid2w_752g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C5E129ABA23;
 Wed,  7 Feb 2024 07:04:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56A58C1D36C;
 Wed,  7 Feb 2024 07:04:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4EFFA21E66D0; Wed,  7 Feb 2024 08:04:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] monitor: use aio_co_reschedule_self()
In-Reply-To: <20240205172659.476970-6-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Mon, 5 Feb 2024 12:26:59 -0500")
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-6-stefanha@redhat.com>
Date: Wed, 07 Feb 2024 08:04:36 +0100
Message-ID: <87v870n4aj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> The aio_co_reschedule_self() API is designed to avoid the race
> condition between scheduling the coroutine in another AioContext and
> yielding.
>
> The QMP dispatch code uses the open-coded version that appears
> susceptible to the race condition at first glance:
>
>   aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
>   qemu_coroutine_yield();
>
> The code is actually safe because the iohandler and qemu_aio_context
> AioContext run under the Big QEMU Lock. Nevertheless, set a good example
> and use aio_co_reschedule_self() so it's obvious that there is no race.
>
> Suggested-by: Hanna Reitz <hreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Markus Armbruster <armbru@redhat.com>

Feel free to merge this together with the remainder of the series.


