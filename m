Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CA8C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuwZ-0002Tz-MA; Wed, 19 Mar 2025 11:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuuwT-0002SE-Fk
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuuwP-0007zc-06
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742396561;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=038ivSDMMEc0w+/oUjQqUJ5o5StTirMIcJWEwt7XGaw=;
 b=StJijdim/QdxAxQ+2QonipW4LOJwZs5cQZuSC+Hb3r5esg9yDe0YSxA1Ghq/76T+W3j52Y
 0St9QPlK16lgTbmlj6qvb32l+5JGG+SwfTU3vNpe8Q12+5edE1FSJBEQAR4StDq7/a3nEw
 nOWBzfB0cFTBJh7g/lCWlk/0GywK9uE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-p9HPN8hWOVKxpFyUDY5x1g-1; Wed,
 19 Mar 2025 11:02:38 -0400
X-MC-Unique: p9HPN8hWOVKxpFyUDY5x1g-1
X-Mimecast-MFC-AGG-ID: p9HPN8hWOVKxpFyUDY5x1g_1742396557
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9916519560B7; Wed, 19 Mar 2025 15:02:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECB9F1800268; Wed, 19 Mar 2025 15:02:34 +0000 (UTC)
Date: Wed, 19 Mar 2025 15:02:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 1/2] qga-win: implement a 'guest-get-load' command
Message-ID: <Z9rchyQO5vNcrfmN@redhat.com>
References: <20250314113847.109460-1-kkostiuk@redhat.com>
 <20250314113847.109460-2-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314113847.109460-2-kkostiuk@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 14, 2025 at 01:38:46PM +0200, Konstantin Kostiuk wrote:
> Windows has no native equivalent API, but it would be possible to
> simulate it as illustrated here (BSD-3-Clause):
> 
>   https://github.com/giampaolo/psutil/pull/1485
> 
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/commands-win32.c   | 140 +++++++++++++++++++++++++++++++++++++++++
>  qga/guest-agent-core.h |  10 +++
>  qga/main.c             |  39 ++++++++++++
>  qga/meson.build        |   2 +-
>  qga/qapi-schema.json   |   4 +-
>  5 files changed, 192 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> +GuestLoadAverage *qmp_guest_get_load(Error **errp)
> +{
> +    if (ga_get_load_avg_pdh_query(ga_state) == NULL) {
> +        /* set initial values */
> +        load_avg_1m = 0;
> +        load_avg_5m = 0;
> +        load_avg_15m = 0;
> +
> +        if (init_load_avg_counter(errp) == false) {
> +            return NULL;
> +        }
> +    }

Nice idea. So we avoid running the load average logic
until such time as a mgmt app actually asks for it.

The load avg won't be very accurate initially, but
assuming any interested mgmt app will ask for this
repeatedly over the entire life of the VM, this looks
like a good mitigation.

Perhaps worth a commenting explaining why we're doing
this.


> +
> +    GuestLoadAverage *ret = NULL;
> +
> +    ret = g_new0(GuestLoadAverage, 1);
> +    ret->load1m = load_avg_1m;
> +    ret->load5m = load_avg_5m;
> +    ret->load15m = load_avg_15m;
> +    return ret;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


