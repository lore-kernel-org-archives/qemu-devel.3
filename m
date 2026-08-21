Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4A0C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPUD-0004nJ-Vt; Fri, 21 Aug 2026 09:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wxPUC-0004mr-HK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wxPUA-0001Th-M1
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787319640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9v4zU1RSXWVxzWJd/KXMbaohTjvT47waQmSyY0D7Fs=;
 b=YbBBeSr8jjoxoUytQDiak9zHW6RcTqrj3i0vGOkowwi4HU/N4vEs6VO5IKxXgEqdaacd6F
 FznhQbqXjRA5gTI5JdHuHkZm1uBevRDWLhG38JLgoGSoA0A8YGGYjM1/tDdEGhUelW2BVe
 JW9ySNpV7KRX814pXLYcuW4XL8ZS18Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-VxNX31mCMkutS1sQrvt3VQ-1; Fri,
 21 Aug 2026 09:40:39 -0400
X-MC-Unique: VxNX31mCMkutS1sQrvt3VQ-1
X-Mimecast-MFC-AGG-ID: VxNX31mCMkutS1sQrvt3VQ_1787319637
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF28A1955BDD; Fri, 21 Aug 2026 13:40:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBC891956056; Fri, 21 Aug 2026 13:40:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8923E21E6920; Fri, 21 Aug 2026 15:40:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 01/53] qapi: add QAPITypeInfo struct definition
In-Reply-To: <CAMxuvax5Bnz7fK9DE+jWBfYg2ZX=YYA4W-j9gzU4gJmRTQVToQ@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 13 Aug 2026
 10:55:45 +0400")
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-1-cc9396b9c18c@redhat.com>
 <87mrv78jwb.fsf@pond.sub.org>
 <CAMxuvax5Bnz7fK9DE+jWBfYg2ZX=YYA4W-j9gzU4gJmRTQVToQ@mail.gmail.com>
Date: Fri, 21 Aug 2026 15:40:33 +0200
Message-ID: <87ecfrzj5a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> giHi
>
> On Fri, Jul 31, 2026 at 3:43=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Introduce a minimal struct that pairs a QAPI type's internal name with
>> > its "masked" introspection name. Generated constants of this type will
>> > let QOM property registration carry a reliable reference to the QAPI
>> > schema and possibly other associated data.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  include/qapi/qapi-type-info.h | 32 ++++++++++++++++++++++++++++++++
>> >  1 file changed, 32 insertions(+)
>> >
>> > diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-in=
fo.h
>> > new file mode 100644
>> > index 00000000000..a7a470af731
>> > --- /dev/null
>> > +++ b/include/qapi/qapi-type-info.h

[...]

>> > + */
>> > +typedef struct QAPITypeInfo {
>> > +    const char *name;
>> > +    const char *schema_name;
>> > +    const QEnumLookup *lookup;
>> > +    const struct QAPITypeInfo *list;
>> > +} QAPITypeInfo;
>> > +
>> > +#endif /* QAPI_TYPE_INFO_H */
>>
>> This is somewhat related to SchemaInfo, which is also meta-data about
>> QAPI types (and also commands and events).
>>
>> SchemaInfo only has the masked name[*].  It has a reference from array
>> type to element type instead of the other way round.  Everything else in
>> QAPITypeInfo is also in SchemaInfo, I believe.
>>
>> So far, QEMU uses SchemaInfo only around qmp_query_qmp_schema().
>> qmp_query_qmp_schema() a SchemaInfoList on the fly from something else,
>> and the QMP core (it's only caller) then converts it via QObject to a
>> string reply.
>>
>> Now I need to digress into history a bit.
>>
>> The value of query-qmp-schema is fixed at compile time.  My initial
>> version simply generated the fixed reply as string.  Efficient, because
>> it doesn't build a (bulky!) QObject reply.  Also a bit hacky.
>>
>> This got in the way of QAPI 'if' conditionals, so commit 7d0f982b
>> switched to a pointer-less variation of the QObject that can be
>> generated as data more easily: QLitObject[].  query-qmp-schema converts
>> this to QObject every time it runs.  The QLitObject[] would be awkward
>> to use for anything else.
>>
>> End of digression.
>>
>> I wonder whether it could make sense to have a single repository of QAPI
>> type meta data, usable both for query-qmp-schema and for your QOM work.
>> Something QOM could use about as easily as QAPITypeInfo, and
>> query-qmp-schema could convert to its reply.
>>
>> At this time, this is an idea phrased as a question.  Is it a good idea?
>> I'm not sure.  Even if it is, I'm not sure it should be implemented
>> right away.  I'm just sharing the idea.
>
> I am not sure what you mean by "a single repository of QAPI type
> metadata". Whatever it is, I don't think it is required for this
> series. If you mean that we could generate one big structure holding
> all QAPI metadata, that sounds challenging and it's not clear to me
> what the benefit would be, beside a bit of memory saving.

The information in QAPITypeInfo is a strict subset of the information
returned by query-qmp-schema.  This makes QAPITypeInfo redundant from a
pure information point of view.

However, the information returned by query-qmp-schema is encoded in a
way that makes it unwieldy for anything else: it's a big QLitObject.
All you can do with it is convert it to a big QObject.  And all we do
with that is convert to a big JSON string we send to the QMP client.  We
could extract a QAPITypeInfo from the big QObject on the fly, but it
would be rather cumbersome.

The QLitObject data structure is an implementation choice.  We changed
our choice in the past, we could change it again.  The question / idea I
wanted to share: could we choose a single data structure that supports
both QAPI/QMP introspection (query-qmp-schema) and QAPI/QOM
introspection (what your series adds)?

I don't think it would be all that difficult, just a good chunk of work.
A bit of a yak-shave perhaps.

Again, I'm just throwing out an idea.  If you'd like to run with it, go
ahead.  If not, that's perfectly fine, too.

>> [*] The QAPI generator has an option to make it have only the unmasked
>> names.  Occasionally convenient when messing around.


