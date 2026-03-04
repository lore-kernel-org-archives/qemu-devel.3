Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EFDEB7EC9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 11:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjxO-00050K-UZ; Wed, 04 Mar 2026 05:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vxjxE-0004x3-Lz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:59:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vxjxC-0004Mj-CC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772621984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iivn8XOjwJxpF6oqnYAmAsA73+7/qREzatlgGFWUfd8=;
 b=QTxuS/8jIyX7IF+XvGCZNSCqT7aEJb58a/kJ9lsth95jrjc9eyDPAxw/94nWfE31O5qIl1
 8g+yo2uIF6cIuBOUM0+KBqzoMSyQv3QbTwtvIPTM5lAYuN0cL7fQcXECTA2TEckuOmVPaT
 u3Rv3mgT/vmD6ksCxyxOIKN29DXxCoo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-FLPBVoq7PraE55nOnEpeNA-1; Wed,
 04 Mar 2026 05:59:41 -0500
X-MC-Unique: FLPBVoq7PraE55nOnEpeNA-1
X-Mimecast-MFC-AGG-ID: FLPBVoq7PraE55nOnEpeNA_1772621980
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0AEE1800589; Wed,  4 Mar 2026 10:59:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.201])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 285D81800759; Wed,  4 Mar 2026 10:59:36 +0000 (UTC)
Date: Wed, 4 Mar 2026 11:59:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: hreitz@redhat.com, xeor@yandex-team.ru, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] block: Never drop BLOCK_IO_ERROR with action=stop for
 rate limiting
Message-ID: <aagQlnN7ejiPSD_V@redhat.com>
References: <20260212212738.141780-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212212738.141780-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 12.02.2026 um 22:27 hat Kevin Wolf geschrieben:
> Commit 2155d2dd introduced rate limiting for BLOCK_IO_ERROR to emit an
> event only once a second. This makes sense for cases in which the guest
> keeps running and can submit more requests that would possibly also fail
> because there is a problem with the backend.
> 
> However, if the error policy is configured so that the VM is stopped on
> errors, this is both unnecessary because stopping the VM means that the
> guest can't issue more requests and in fact harmful because stopping the
> VM is an important state change that management tools need to keep track
> of even if it happens more than once in a given second. If an event is
> dropped, the management tool would see a VM randomly going to paused
> state without an associated error, so it has a hard time deciding how to
> handle the situation.
> 
> This patch disables rate limiting for action=stop by essentially
> considering all BLOCK_IO_ERRORs with action=stop different errors. If
> the error is reported to the guest or ignored, the rate limiting stays
> in place.
> 
> Fixes: 2155d2dd7f73 ('block-backend: per-device throttling of BLOCK_IO_ERROR reports')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 1273eb72605..93bd2b93e65 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -525,6 +525,18 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>                         qdict_get_str(evb->data, "node-name"));
>      }
>  
> +    /*
> +     * If the VM is stopped after an I/O error, this is important information
> +     * for the management tool to keep track of the state of QEMU and we can't
> +     * merge any events. At the same time, stopping the VM means that the guest
> +     * can't send additional requests and the number of events is already
> +     * limited, so we can do without rate limiting.
> +     */
> +    if (eva->event == QAPI_EVENT_BLOCK_IO_ERROR &&
> +        !strcmp(qdict_get_str(eva->data, "action"), "stop")) {
> +        return FALSE;
> +    }
> +

It turns out that this approach is completely wrong. The harmless part
is that the hash table is filled up with many events that don't actually
need throttling. The worse part is that events aren't even considered
equal to themselves, which means that the hash table can't find them to
remove them, which in turn causes use after free crashes.

I'll post a v2 that avoids the whole rate limiting code path for I/O
errors that don't need the throttling.

Kevin


