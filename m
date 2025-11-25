Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1E6D0EE14
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 19:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNyJg-0002v7-0n; Tue, 25 Nov 2025 14:03:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNyJe-0002sm-Cv
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNyJb-0006yJ-As
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764097381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWnyHATjJsphW/0iYKwSv64tZark0wKKl/qXRN9veNw=;
 b=LHnUI0c+w3KWS30AJfcJC97ae34G92SnLW/BLIm5R73jsmnA/2NzevQcSBX0/aPDq0MP0T
 lP0jkO55Z4jOF+XqXWVnxPv0iD+uKU0rffqEl7i6qgBVp5tCz5X2OiM49vQNFKt147mWrG
 ov0B+epbUEWZJ/INNrTFXFODAne+q5E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-XOhloA8SN7aR-LkksWsnJg-1; Tue,
 25 Nov 2025 14:02:59 -0500
X-MC-Unique: XOhloA8SN7aR-LkksWsnJg-1
X-Mimecast-MFC-AGG-ID: XOhloA8SN7aR-LkksWsnJg_1764097379
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAA9E1800342; Tue, 25 Nov 2025 19:02:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D9531800451; Tue, 25 Nov 2025 19:02:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F229D21E6A27; Tue, 25 Nov 2025 20:02:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, farosas@suse.de,  peter.maydell@linaro.org
Subject: Re: g_autoptr(Error)
In-Reply-To: <aSXWKcjoIBK4LW59@x1.local> (Peter Xu's message of "Tue, 25 Nov
 2025 11:15:37 -0500")
References: <20251125070554.2256181-1-armbru@redhat.com>
 <871plmk1bc.fsf@pond.sub.org> <aSWSLMi6ZhTCS_p2@redhat.com>
 <87jyzexrly.fsf@pond.sub.org> <aSXWKcjoIBK4LW59@x1.local>
Date: Tue, 25 Nov 2025 20:02:55 +0100
Message-ID: <87cy56gckg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Nov 25, 2025 at 12:46:01PM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Tue, Nov 25, 2025 at 08:40:07AM +0100, Markus Armbruster wrote:
>> >> g_autoptr(T) is quite useful when the object's extent matches the
>> >> function's.
>> >>=20
>> >> This isn't the case for an Error object the function propagates to its
>> >> caller.  It is the case for an Error object the function reports or
>> >> handles itself.  However, the functions to report Error also free it.
>
> I'd confess I didn't pay enough attention on how the error API was design=
ed
> deliberately to always free the Error objects before almost whenever
> possible.  But I see now, thanks for the write up.

You're welcome!

>> >>=20
>> >> Thus, g_autoptr(Error) is rarely applicable.  We have just three
>> >> instances out of >1100 local Error variables, all in migration code.
>> >>=20
>> >> Two want to move the error to the MigrationState for later handling /
>> >> reporting.  Since migrate_set_error() doesn't move, but stores a copy,
>> >> the original needs to be freed, and g_autoptr() is correct there.  We
>> >> have 17 more that instead manually free with error_free() or
>> >> error_report_err() right after migrate_set_error().
>> >>=20
>> >> We recently discussed storing a copy vs. move the original:
>> >>=20
>> >>     From: Peter Xu <peterx@redhat.com>
>> >>     Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
>> >>     Date: Mon, 17 Nov 2025 11:03:37 -0500
>> >>     Message-ID: <aRtHWbWcTh3OF2wY@x1.local>
>> >>=20
>> >> The two g_autoptr() gave me pause when I investigated this topic, sim=
ply
>> >> because they deviate from the common pattern migrate_set_error(s, err)
>> >> followed by error_free() or error_report_err().
>> >>=20
>> >> The third one became wrong when I cleaned up the reporting (missed in
>> >> the cleanup patch, fixed in the patch I'm replying to).  I suspect my
>> >> mistake escaped review for the same reason I made it: g_autoptr(Error)
>> >> is unusual and not visible in the patch hunk.
>> >>=20
>> >> Would you like me to replace the two correct uses of g_autoptr(Error)=
 by
>> >> more common usage?
>
> Works for me.
>
> Now I also think it should be good migrate_set_error() follow QEMU's Error
> API design if we decide to stick with it freeing errors in such APIs.
>
> Said that, I wonder if you think we could still consider passing Error**
> into migrate_set_error(), though, which will be a merged solution of
> current Error API and what Marc-Andre proposed on resetting pointers to
> avoid any possible UAF, which I would still slightly prefer personally.
>
> If we rework migrate_set_error() to take ownership first, then we can
> naturally drop the two use cases, and remove the cleanup function.
>
> Markus, please also let me know if you want me to do it.

I think the first step should replace the two g_autoptr() by
error_free(), then delete g_autoptr() support.

A possible second step is to replace migrate_set_error() by a function
that takes ownership.  "Replace" because I think migrate_set_error()
would be a bad name for such a function.  What's a better name?  Naming
is hard...  migrate_error_propagate_to_state()?  Because there's
similarity:

    error_propagate(errp, err);

stores @err in @errp, or else frees it, and

    migrate_error_propagate_to_state(s, err)

stores @err in @s, or else frees it.

We could also forgo encapsulation and simply use

    error_propagate(&s->error, err);

Matter of taste, which means migration maintainers decide.

I can do just the first step, or both.  Up to you.

[...]


