Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30DBCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 12:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGIH-0007ze-18; Tue, 04 Nov 2025 07:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGGIC-0007yf-QT
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 07:37:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGGIA-00050a-6W
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 07:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762259861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IaUZ8epSM9b5dNxhR3ZLWLtqqe19SuHlfKfo+Mz8eiY=;
 b=dcOeVxNBVsjHRta+we9plfe8RsaSDV2uoZD8VTjGNnbtcMguf0oHdgqNwpjM/GWSy9oPcI
 bHk1YZpOpGowzkhIW7lnL3Rl7Lr+FDyRJB1tal21Hvt2v1K53CdBozbMokjUZR+tHHkwNT
 T2FNRCAFbYEw+hLUvSy9HqXE26/mJak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-KAms6G6NOOmf7SIvNuZ5rQ-1; Tue,
 04 Nov 2025 07:37:40 -0500
X-MC-Unique: KAms6G6NOOmf7SIvNuZ5rQ-1
X-Mimecast-MFC-AGG-ID: KAms6G6NOOmf7SIvNuZ5rQ_1762259859
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEA2D1800245; Tue,  4 Nov 2025 12:37:38 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2064E180045B; Tue,  4 Nov 2025 12:37:36 +0000 (UTC)
Date: Tue, 4 Nov 2025 13:37:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 4/8] qio: Factor out helpers qio_net_listener_[un]watch
Message-ID: <aQnzjtDgSakaTgPi@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-14-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103202849.3687643-14-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Am 03.11.2025 um 21:10 hat Eric Blake geschrieben:
> The code had three similar repetitions of an iteration over one or all
> of nsiocs to set up a GSource, and likewise for teardown.  Since an
> upcoming patch wants to tweak whether GSource or AioContext is used,
> its better to consolidate that into one helper function for fewer
> places to edit later.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  io/net-listener.c | 109 +++++++++++++++++++---------------------------
>  1 file changed, 45 insertions(+), 64 deletions(-)

> @@ -145,15 +174,11 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
>                                             GDestroyNotify notify,
>                                             GMainContext *context)
>  {
> -    size_t i;
> -
>      if (listener->io_func == func && listener->io_data == data) {
>          return;
>      }
> 
> -    if (listener->io_func) {
> -        trace_qio_net_listener_watch_disabled(listener, "set_client_func");
> -    }
> +    qio_net_listener_unwatch(listener, "set_client_func");
>      if (listener->io_notify) {
>          listener->io_notify(listener->io_data);
>      }

This changes the order between the io_notify() call and the unwatch. Is
this intentional? If so, maybe mention it in the commit message and why
it's safe.

Kevin


