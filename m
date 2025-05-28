Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28455C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 06:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKAGO-0000Gb-5H; Wed, 28 May 2025 02:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKAGK-0000GT-Mu
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKAGG-0003tu-6W
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748413653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VXtSg9WBFgp4qV4aCgF7346HieNMOOTUPk14uioSezc=;
 b=auadEuWL6W/wKrUoWaSjvzZl+insndhTnFdiWt7pr5dl9NElL+lWGkJIryHEkV3Psx1KFn
 RrbHx03lERq/iYHyReBk9YzQLjWHN4WWCblcF/4cFK6aVSvVnkf1iCgkgPOo08aAaKzZWK
 bd54RswI+064GEB0vjMzDE4F2mEAh04=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-9kT_fB2yOCea59fCb5lPJA-1; Wed,
 28 May 2025 02:27:29 -0400
X-MC-Unique: 9kT_fB2yOCea59fCb5lPJA-1
X-Mimecast-MFC-AGG-ID: 9kT_fB2yOCea59fCb5lPJA_1748413649
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CA1A1955DB3; Wed, 28 May 2025 06:27:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F108E1956095; Wed, 28 May 2025 06:27:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 636B021E6768; Wed, 28 May 2025 08:27:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juraj Marcin <jmarcin@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 Alexey Perevalov <a.perevalov@samsung.com>
Subject: Re: [PATCH 02/11] migration/hmp: Fix postcopy-blocktime per-vCPU
 results
In-Reply-To: <20250527215850.1271072-3-peterx@redhat.com> (Peter Xu's message
 of "Tue, 27 May 2025 17:58:41 -0400")
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-3-peterx@redhat.com>
Date: Wed, 28 May 2025 08:27:25 +0200
Message-ID: <878qmhjlma.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> Unfortunately, it was never correctly shown..
>
> This is only found when I started to look into making the blocktime feature
> more useful (so as to avoid using bpftrace, even though I'm not sure which
> one will be harder to use..).
>
> So the old dump would look like this:
>
>   Postcopy vCPU Blocktime: 0-1,4,10,21,33,46,48,59
>
> Even though there're actually 40 vcpus, and the string will merge same
> elements and also sort them.
>
> To fix it, simply loop over the uint32List manually.  Now it looks like:
>
>   Postcopy vCPU Blocktime (ms):
>    [15, 0, 0, 43, 29, 34, 36, 29, 37, 41,
>     33, 37, 45, 52, 50, 38, 40, 37, 40, 49,
>     40, 35, 35, 35, 81, 19, 18, 19, 18, 30,
>     22, 3, 0, 0, 0, 0, 0, 0, 0, 0]
>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Alexey Perevalov <a.perevalov@samsung.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-hmp-cmds.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 367ff6037f..3cf890b887 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -208,15 +208,20 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>      }
>  
>      if (info->has_postcopy_vcpu_blocktime) {
> -        Visitor *v;
> -        char *str;
> -        v = string_output_visitor_new(false, &str);
> -        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime,
> -                              &error_abort);
> -        visit_complete(v, &str);
> -        monitor_printf(mon, "Postcopy vCPU Blocktime: %s\n", str);
> -        g_free(str);
> -        visit_free(v);
> +        uint32List *item = info->postcopy_vcpu_blocktime;
> +        int count = 0;
> +
> +        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
> +
> +        while (item) {
> +            monitor_printf(mon, "%"PRIu32", ", item->value);
> +            item = item->next;
> +            /* Each line 10 vcpu results, newline if there's more */

The list can be arbitrarily long?

> +            if ((++count % 10 == 0) && item) {
> +                monitor_printf(mon, "\n  ");
> +            }
> +        }
> +        monitor_printf(mon, "\b\b]\n");

Uh, backspace?

I usually do something like

    sep = "";
    for (...) {
        printf("%s...", sep, ...);
        sep = ", "
    }

To add line breaks, I'd use something like

        sep = ... ? ", " : ",\n";

>      }
>  
>  out:

The less the string visitors are used, the happier I am.


