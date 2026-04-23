Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A01BFAD41B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 06:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFo0l-0001Ex-GK; Thu, 23 Apr 2026 02:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFo0j-0001Ek-P2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 02:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFo0i-00049N-7Z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 02:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776927483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJNnvaygK6/1iNq3XJTWTwRrWPrzmDBLERpACPSvdOw=;
 b=D1M3zFbLpo9OZLUtjnO+RxviGsFs8M9qkjHH/hz1kEwd68JeuVWG+Y3Ed8bap8Gl5aXrK0
 1QJJ8HNF3s44+iR7DgT5wF4MQ3zuH/BeQZpIY12EwauQUkwegEiGs2cgkvnirRV6rJiuOg
 qEwQR+W2IDkgV9Nfg4nMDOUV6QJHhdo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-YUc6ZG6UPjC1BsD6n3ceTw-1; Thu,
 23 Apr 2026 02:58:01 -0400
X-MC-Unique: YUc6ZG6UPjC1BsD6n3ceTw-1
X-Mimecast-MFC-AGG-ID: YUc6ZG6UPjC1BsD6n3ceTw_1776927480
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B51B21800464
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:58:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 741FE180047F
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:58:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF78921E6A28; Thu, 23 Apr 2026 08:57:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests: add test for json-streamer.c error recovery
In-Reply-To: <CABgObfYRLUs96voXsxmSp-2fQD_UV6Yq3reaSYMbrf9gDp+DRA@mail.gmail.com>
 (Paolo Bonzini's message of "Tue, 21 Apr 2026 23:39:14 +0100")
References: <20260331095950.512326-1-pbonzini@redhat.com>
 <871pg87dr7.fsf@pond.sub.org>
 <CABgObfYRLUs96voXsxmSp-2fQD_UV6Yq3reaSYMbrf9gDp+DRA@mail.gmail.com>
Date: Thu, 23 Apr 2026 08:57:57 +0200
Message-ID: <87bjfarwne.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Tue, Apr 21, 2026 at 12:29=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
>> > +static void parse_emit(void *opaque, QObject *json, Error *err)
>> > +{
>> > +    ParseResult *r =3D opaque;
>> > +
>>
>> Recommend
>>
>>        assert(!json !=3D !err);
>
> Makes sense.
>
>> > +static void test_simple(void)
>> > +{
>> > +    check_result("false", 0, QTYPE_QBOOL);
>> > +}
>>
>> This one isn't about error recovery.  It's arguably redundant with
>> check-qjson.c's keyword_literal().
>
> Or the other way round. :)  They test different APIs which makes both
> of them worthwhile.

See discussion at the end.

>> > +
>> > +static void test_extra_closing_braces(void)
>> > +{
>> > +    check_result("}}false", 2, QTYPE_QBOOL);
>> > +}
>>
>> Overlap with check-qjson.c's multiple_values().
>
> Overlapping input but completely different test, because this checks
> for success (after error) whereas multiple_values() checks for an
> error condition.  This also shows the difference between the two test
> files and APIs.
>
>> > +
>> > +static void test_bad_dict(void)
>> > +{
>> > +    check_result("{ 'abc' }false", 1, QTYPE_QBOOL);
>> > +}
>>
>> Interesting: just one error, because error recovery eats false.
>
> Why would it eat false here? The error is recovered after "{ 'abc' }"
> and then "false" is parsed successfully. One error and one successful
> value, as indicated by the arguments to check_result().

I got confused %-}

>> > +
>> > +static void test_lexer_recovery(void)
>> > +{
>> > +    check_result("\f{}", 1, QTYPE_QDICT);
>> > +    check_result("\f[]", 1, QTYPE_QLIST);
>> > +    check_result("\f:false", 2, QTYPE_QBOOL);
>> > +    check_result("\f,false", 2, QTYPE_QBOOL);
>> > +
>> > +    /*
>> > +     * alphabetic characters do not start a new parsing, this is slig=
htly weird
>> > +     * but it keeps the lexer simple and works well for QMP (where va=
lid input
>> > +     * is a sequence of dictionaries)
>> > +     */
>>
>> Please wrap comment lines a bit earlier for legibility:
>
> 79 characters are Just Fine.  While I appreciate careful reviews, and
> I will apply your suggested edit, this is perhaps a bit too much?

I asked nicely, because I do have real trouble reading long lines.  It's
not the right margin, it's the width of the text not counting
indentation.

Peace?

>> > +    /* same as test_lexer_recovery */
>> > +    check_result_error("{[{\ffalse", 1);
>>
>> Really?
>
> Same comment about alphabetic characters not starting a new parsing after=
 \f.
>
>> check-json-parser.c and check-qjson.c both test the JSON parser.
>>
>> check-json-parser.c tests at the json-parser.h level, and focuses on
>> error recovery.
>
> That's what I focused on _for now_, because that's where the push
> parser changes are more tricky, but it doesn't have to be that way.
>
>> check-qjson.c tests one level up at the qjson.h level, where error
>> recovery is not testable.
>>
>> Perhaps the JSON parser tests should all be in one place.  This is not a
>> demand :)
>
> Objection, your honor - different APIs, different test files. :)

Separate APIs, yes, but one wraps around the other in a straightforward
manner.

I don't mind having a separate tests for both levels.

Ideally, the test at the lower level would be complete, and the test at
the upper level focused on what's added there.

As is, much functionality is only covered at the upper level.  Some is
covered at both.

I wanted to point that out.  I could've expressed myself more clearly,
though.  Whether and when to clean up this tangle is up for debate!


