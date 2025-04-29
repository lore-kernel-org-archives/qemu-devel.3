Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B587BC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jBx-0004H4-BM; Tue, 29 Apr 2025 07:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9jBr-0004Ej-2s
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 07:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9jBo-0007zx-GU
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 07:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745926311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B1N1p42SyL8JbL8vKt4j2f5sE0g0OTUyXh1OVmfHiRM=;
 b=a915sm3qtwRpSnXjfIFZXnCj/zq21AZdMR1m8J8VAbPifax7PXBMY1RNGj4qFRJWu4zIq6
 1KYr9ja85e0ZJ429i36QYeP/T7Cojb2jnaM9d7Rrlga8uhCLZUKqwWYBfJRzKR8c/Cf2Cu
 E3DSdxXZ9fRHukXwbCxsp0hAw8/Nu1Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-61681zL4PAGtp6eaq7IqtQ-1; Tue,
 29 Apr 2025 07:31:49 -0400
X-MC-Unique: 61681zL4PAGtp6eaq7IqtQ-1
X-Mimecast-MFC-AGG-ID: 61681zL4PAGtp6eaq7IqtQ_1745926308
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05218180087B; Tue, 29 Apr 2025 11:31:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 149C4195608D; Tue, 29 Apr 2025 11:31:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B1E3321E6768; Tue, 29 Apr 2025 13:31:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Eric Blake <eblake@redhat.com>,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>
Subject: Re: [PATCH v2 1/4] nbd: Add multi-conn option
In-Reply-To: <20250429111958.GI1450@redhat.com> (Richard W. M. Jones's message
 of "Tue, 29 Apr 2025 12:19:58 +0100")
References: <20250428185246.492388-6-eblake@redhat.com>
 <20250428185246.492388-7-eblake@redhat.com>
 <877c33qzzn.fsf@pond.sub.org> <20250429091422.GG1450@redhat.com>
 <87wmb3jkoh.fsf@pond.sub.org> <20250429111958.GI1450@redhat.com>
Date: Tue, 29 Apr 2025 13:31:44 +0200
Message-ID: <87o6wfnqzj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

"Richard W.M. Jones" <rjones@redhat.com> writes:

> On Tue, Apr 29, 2025 at 01:01:34PM +0200, Markus Armbruster wrote:
>> "Richard W.M. Jones" <rjones@redhat.com> writes:
>> 
>> > On Tue, Apr 29, 2025 at 07:49:00AM +0200, Markus Armbruster wrote:
>> >> Eric Blake <eblake@redhat.com> writes:
>> >> 
>> >> > From: "Richard W.M. Jones" <rjones@redhat.com>
>> >> >
>> >> > Add multi-conn option to the NBD client.  This commit just adds the
>> >> > option, it is not functional.
>> >> >
>> >> > Setting this to a value > 1 permits multiple connections to the NBD
>> >> > server; a typical value might be 4.  The default is 1, meaning only a
>> >> > single connection is made.  If the NBD server does not advertise that
>> >> > it is safe for multi-conn then this setting is forced to 1.
>> >> >
>> >> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
>> >> > [eblake: also expose it through QMP]
>> >> > Signed-off-by: Eric Blake <eblake@redhat.com>
>> >> > ---
>> >> >  qapi/block-core.json |  8 +++++++-
>> >> >  block/nbd.c          | 24 ++++++++++++++++++++++++
>> >> >  2 files changed, 31 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> >> > index 7f70ec6d3cb..5c10824f35b 100644
>> >> > --- a/qapi/block-core.json
>> >> > +++ b/qapi/block-core.json
>> >> > @@ -4545,6 +4545,11 @@
>> >> >  #     until successful or until @open-timeout seconds have elapsed.
>> >> >  #     Default 0 (Since 7.0)
>> >> >  #
>> >> > +# @multi-conn: Request the number of parallel client connections to make
>> >> > +#     to the server, up to 16.  If the server does not advertise support
>> >> > +#     for multiple connections, or if this value is 0 or 1, all traffic
>> >> > +#     is sent through a single connection.  Default 1 (Since 10.1)
>> >> > +#
>> >> 
>> >> So we silently ignore @multi-conn when its value is (nonsensical) zero,
>> >> and when the server doesn't let us honor the value.  Hmm.  Silently
>> >> ignoring the user's wishes can result in confusion.  Should we reject
>> >> instead?
>> >
>> > We could certainly reject 0.  It's also possible to reject the case
>> > where multi-conn is not supported by the server, but is requested by
>> > the client, but I feel that's a bit user-unfriendly.  After all,
>> > multi-conn isn't essential for it to work, it's needed if you want
>> > best performance.  (Maybe issue a warning in the code - below - where
>> > we set multi-conn back to 1?  I don't know what qemu thinks about
>> > warnings.)
>> 
>> QMP doesn't support warnings, so they go to stderr instead, where they
>> may or may not be seen.
>> 
>> When I instruct a program to do X, I prefer it to do exactly X, and fail
>> when that's not possible.  Correcting X behind my back may be friendly,
>> until the day I spent quality time figuring out WTF is going on.
>> 
>> Perhaps this one is a matter of documentation.  As is, @multi-conn feels
>> like "set the number of connections" to me, until I read the fine print,
>> which contradicts it.  We could perhaps phrase it as a limit instead:
>> enable multiple connections and simultaneously limit their number.
>
> It is tricky.  In nbdcopy we've preferred to go with "you suggest some
> numbers and we'll pick something that works":
>
> https://gitlab.com/nbdkit/libnbd/-/blob/master/copy/main.c?ref_type=heads#L446-L493
>
> but also we do provide a way for you to find out what was selected:
>
> https://gitlab.com/nbdkit/libnbd/-/blob/master/copy/main.c?ref_type=heads#L521
>
> (I'm not claiming this is the best approach or suitable for everyone.)
>
> In the context of qemu that might suggest having separate
> multi_conn_requested and multi_conn fields, where the latter can be
> queried over QMP to find out what is actually going on.  Could even
> add multi_conn_max to allow MAX_MULTI_CONN constant to be read out.

You decide what to do with my feedback :)

[...]


