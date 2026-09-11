Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AFDC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4wXp-0001QO-6M; Fri, 11 Sep 2026 04:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4wXB-000187-9v
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4wX9-0000oG-A4
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789114973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zAIwR/TSKhUqESX3EPgOTKht0iesnaJFo2iw3HyWUcs=;
 b=Jryc7zw3Nr10RyqwzyeVGv9hIyc6Xe+j4pQkwZCjeHZCU8QZU+tIgfHvRWYueRqLsbxDWv
 c1xSdhTkR+b4h49c4kQ/4g0/FdFT6eyRzA2TFWh/gaTqQHSzc3E67w/YKpgD6vs4HnxQwV
 LLf9ZnwQndcn4TjoDyKkwqHcz9W7YUE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-at-eQe4XN72YRX15KNzciA-1; Fri,
 11 Sep 2026 04:22:52 -0400
X-MC-Unique: at-eQe4XN72YRX15KNzciA-1
X-Mimecast-MFC-AGG-ID: at-eQe4XN72YRX15KNzciA_1789114971
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22FC21955BDD; Fri, 11 Sep 2026 08:22:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD4EA1956087; Fri, 11 Sep 2026 08:22:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D40B21E6A04; Fri, 11 Sep 2026 10:22:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  "Dr . David Alan
 Gilbert" <dave@treblig.org>,  Laurent Vivier <lvivier@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 13/18] migration: Use keyval input visitor in HMP set
 command
In-Reply-To: <87h5jwu59t.fsf@suse.de> (Fabiano Rosas's message of "Thu, 10 Sep
 2026 19:10:22 -0300")
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-14-farosas@suse.de>
 <87qzj1e563.fsf@pond.sub.org> <87qzj1tcpl.fsf@suse.de>
 <87h5jwu59t.fsf@suse.de>
Date: Fri, 11 Sep 2026 10:22:48 +0200
Message-ID: <87y0d89oyv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Fabiano Rosas <farosas@suse.de> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:

[...]

>>> I think a hmp_report_error(MonitorHMP *hmp, const char *fmt, ...) would
>>> be nice to have.
>>>
>>
>> I'll look into it.
>>
>
> I see that hmp_handle_error() takes an hmp argument that's unused and

Unused since commit 193227f9e5 (error: Use error_report_err() instead of
monitor_printf(), 2015-12-18).

I doubt it's worth removing.

> also that callers often do the redundant:
>
>    if (err) {
>       hmp_handle_error(err);
>    }

Would be nice to clean this up.

> But aside from those I don't see other improvements to be made, many
> callsites of hmp_handle_error() re-use the Error for other calls,
> e.g. block/monitor/block-hmp-cmds.c:
>
>     Error *err = NULL;
>     ...
>     if (!qdict_get_try_str(qdict, "node-name")) {
>         qobject_unref(qdict);
>         error_setg(&err, "'node-name' needs to be specified");
>         goto out;
>     }
>
>     BlockDriverState *bs = bds_tree_init(qdict, &err);
>     if (!bs) {
>         goto out;
>     }
>
>     bdrv_set_monitor_owned(bs);
>  out:
>     qemu_opts_del(opts);
>     hmp_handle_error(err);
>
> So having another helper I think would just create confusion as
> error_setg() is already a standard way of creating an error.

We have both error_report() and error_report_err(), and it doesn't lead
to confusion as far as I can tell.

Whether doing the same for HMP error reporting would be an improvement
is not obvious.  Let's move on.

[...]


