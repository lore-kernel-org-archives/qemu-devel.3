Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31598C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 08:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWXBh-0003i6-6R; Wed, 24 Jul 2024 04:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWXBe-0003gc-Cc
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWXBc-0000sI-87
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721809042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3I+ctKoo5ur6J+tMJVyFK68iS7qDvmMRrmrebHJQSk=;
 b=ZXyJujFC8k35F2wHsLXTay9/mzsmBr97iefWKRtc2a1o2IRp/l+P/7RFXuk8OmYj/IVyIM
 0MOqckKPXu2Ultep2K/pZcKMEYJBp58+nugEaK7xZiID+XxUkoVW9rKwo8zJzn9CSis7Dv
 cub2KeDO0oOq89aalpWF0+if66nxjfY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-YRKPoi06PxaeO1TcgPZjsg-1; Wed,
 24 Jul 2024 04:17:16 -0400
X-MC-Unique: YRKPoi06PxaeO1TcgPZjsg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCAA51955D44; Wed, 24 Jul 2024 08:17:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67FFF1955D42; Wed, 24 Jul 2024 08:17:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2848021E668F; Wed, 24 Jul 2024 10:17:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Michael
 Roth <michael.roth@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/5] qapi: allow for g_autoptr(Error) usage
In-Reply-To: <Zp-qxpESCmSLNAmg@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 23 Jul 2024 14:06:14 +0100")
References: <20240722131611.2820041-1-berrange@redhat.com>
 <20240722131611.2820041-2-berrange@redhat.com>
 <87jzhcuypr.fsf@pond.sub.org> <Zp-qxpESCmSLNAmg@redhat.com>
Date: Wed, 24 Jul 2024 10:17:13 +0200
Message-ID: <87frrzqk52.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jul 23, 2024 at 01:36:32PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > While common error propagation practice does not require manually
>> > free'ing of local 'Error' objects, there are some cases where this
>> > is needed. One example is where the 'Error' object is only used
>> > for providing info to a trace event probe. Supporting g_autoptr
>> > avoids the need to manually call 'error_free'.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  include/qapi/error.h | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/include/qapi/error.h b/include/qapi/error.h
>> > index 71f8fb2c50..6e429809d8 100644
>> > --- a/include/qapi/error.h
>> > +++ b/include/qapi/error.h
>> > @@ -437,6 +437,8 @@ Error *error_copy(const Error *err);
>> >   */
>> >  void error_free(Error *err);
>> >=20=20
>> > +G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free);
>> > +
>> >  /*
>> >   * Convenience function to assert that *@errp is set, then silently f=
ree it.
>> >   */
>>=20
>> The Error interface is designed for a certain way of using it: an Error
>> object flows from the spot detecting the error to a spot handling it.
>> Failure to handle the error is a memory leak.  Our tooling can help with
>> tracking these down.
>>=20
>> The interface tries to make the intended use easy: functions that report
>> an error consume the Error object.  Explicit error_free() should only
>> needed when you handle an error in some other way.
>>=20
>> When such an explicit error_free() is needed on all paths to return,
>> then replacing it with auto-freeing is nice.  But what if it isn't?
>>=20
>> Say we add a new error path and use error_report_err(err) there.  This
>> has always been just fine.  No more: if @err is auto-freed, this is a
>> double-free.  We have to also add err =3D NULL.  Feels like a trap for
>> developers to me.
>>=20
>> Your use of auto-freeing is in the next patch.  It's this pattern:
>>=20
>>     g_autoptr(Error) err =3D NULL;
>>=20
>>     if (!frobnicate(args, &err)) {
>>         trace_frobnicate_err(..., error_get_pretty(err));
>>     }
>>=20
>> You want to report the error to a trace point.  That's perfectly
>> legitimate.  The problem is that this kind of error reporting function
>> does not free, unlike the ones provided by qapi/error.h.
>>=20
>> We could extend tracing to accept Error values, so that
>>=20
>>         trace_frobnicate_err(..., err);
>>=20
>> does free.  Doesn't seem worthwhile unless we find quite a few more uses
>> for it.
>
> That is awkward because the trace calls expand to nothing at all
> when tracing is disabled, so we can't rely on them to free any
> args.

True.

Another idea:

    g_autofree char *errmsg =3D error_to_pretty(err);
    trace_frobnicate_err(..., errmsg);

where error_to_pretty() frees the error except for err->msg, which it
returns.

>> If we conclude we want to provide auto-free as an option, we at least
>> need to point out the trap in a comment.  A bit of a pain to write, and
>> whether people will read, understand, and remember it is uncertain.
>>=20
>> My gut feeling right now: stick to the design, and free manually.  If
>> you think my gut is wrong, tell me.
>
> I'll drop this since there's only one place benefitting right now.

Sensible.  Thanks!


