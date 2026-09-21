Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4423EC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8e5H-0000yQ-1R; Mon, 21 Sep 2026 09:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x8e53-0000xv-5N
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x8e50-0001QR-MR
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93bofiWW3a3Bgz80SHLX42OCo0tVUi9RRJlVlMxvMsU=;
 b=PPnQWD90PM2ziMF+++YA0HQg6YADvJ7HohjgYl/rUJYuI4UQ/BqNURLhdog7wXBcNOv0Mt
 4oz8jT7IdiwLJYhukIPV48F2unDeesct7A47bJyrMSz7KrmCJcqf62VLoGlvgctx9urE4j
 Hc3Sf9N1ipStTcZbh1yZRo1pBJwYRAg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-ZdF3Bb9NPlalnhPfSlQEMw-1; Mon,
 21 Sep 2026 09:29:02 -0400
X-MC-Unique: ZdF3Bb9NPlalnhPfSlQEMw-1
X-Mimecast-MFC-AGG-ID: ZdF3Bb9NPlalnhPfSlQEMw_1789997341
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61FDE19540C2; Mon, 21 Sep 2026 13:29:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A684B1956089; Mon, 21 Sep 2026 13:29:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 17FC621E6A04; Mon, 21 Sep 2026 15:28:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  pbonzini@redhat.com,
 richard.henderson@linaro.org,  mst@redhat.com,  mtosatti@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/8] qom/object.c: introduce
 object_class_property_add_alias()
In-Reply-To: <arDzqatu3M17Nth8@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 21 Sep 2026 10:06:49 +0100")
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
 <20260902144207.2553037-3-mark.caveayland@nutanix.com>
 <CAMxuvaxoQXZz3AhM9wnRuM7hRn8LD4hMT0ONaV-vRtz5Jy0big@mail.gmail.com>
 <8d9f755c-a82a-4b22-8a9c-ff75bdc23da2@nutanix.com>
 <875x03nd5s.fsf@pond.sub.org> <arDzqatu3M17Nth8@redhat.com>
Date: Mon, 21 Sep 2026 15:28:58 +0200
Message-ID: <87v77yivhh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Sep 18, 2026 at 11:04:31AM +0200, Markus Armbruster wrote:
>> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
>>=20
>> > On 17/09/2026 09:52, Marc-Andr=C3=A9 Lureau wrote:
>> >
>> >> Hi
>> >> On Wed, Sep 2, 2026 at 6:42=E2=80=AFPM Mark Cave-Ayland
>> >> <mark.caveayland@nutanix.com> wrote:
>> >>>
>> >>> This is eventually intended to be a replacement for object_property_=
add_alias()
>> >>> which uses an object property instead of a class property.
>> >>>
>> >>> With the advent of class properties, it is possible that QOM may att=
empt to
>> >>> set or retrieve the value of an unset alias property. Update the exi=
sting
>> >>> property_get_alias() and property_set_alias() functions to use the n=
ull visitor
>> >>> if the alias target has not been set, and property_resolve_alias() t=
o return
>> >>> NULL for the same case.
>> >>>
>> >>> This ensures that unset class alias properties accessed e.g. via the=
 monitor do
>> >>> not cause QEMU to crash.
>> >>>
>> >>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> >>> ---
>> >>>   include/qom/object.h |  25 +++++++++++
>> >>>   qom/object.c         | 100 +++++++++++++++++++++++++++++++++++++--=
----
>> >>>   2 files changed, 113 insertions(+), 12 deletions(-)
>> >>>
>> >>> diff --git a/include/qom/object.h b/include/qom/object.h
>> >>> index e24f0a2b2d..96c76975ef 100644
>> >>> --- a/include/qom/object.h
>> >>> +++ b/include/qom/object.h
>> >>> @@ -2263,6 +2263,11 @@ ObjectProperty *object_class_static_property_=
add_uint64_ptr(ObjectClass *klass,
>> >>>                                             const uint64_t *v,
>> >>>                                             ObjectPropertyFlags flag=
s);
>> >>>
>> >>> +typedef enum {
>> >>> +    /* private */
>> >>> +    OBJ_PROP_ALIAS_CLASS =3D 0x1,
>> >>> +} ObjectPropertyAliasFlags;
>> >>> +
>> >>>   /**
>> >>>    * object_property_add_alias:
>> >>>    * @obj: the object to add a property to
>> >>> @@ -2283,6 +2288,26 @@ ObjectProperty *object_class_static_property_=
add_uint64_ptr(ObjectClass *klass,
>> >>>   ObjectProperty *object_property_add_alias(Object *obj, const char =
*name,
>> >>>                                  Object *target_obj, const char *tar=
get_name);
>> >>>
>> >>> +/**
>> >>> + * object_class_property_add_alias:
>> >>> + * @klass: the object class to add a property to
>> >>> + * @name: the name of the property
>> >>> + * @offset: the offset from the object instance where the object al=
ias is
>> >>> + *   stored
>> >>> + * @target_type: QOM type we expect the alias to resolve to
>> >>> + * @target_name: the name of the property on the forwarded object
>> >>> + *
>> >>> + * Add an alias for a property on an object.  This function will ad=
d a property
>> >>> + * of the same type as the forwarded property.
>> >>> + *
>> >>> + * Returns: The newly added property on success, or %NULL on failur=
e.
>> >> actually, it assert() on error and never returns NULL.
>> >
>> > I was able to reproduce this by attempting to add a class alias proper=
ty with the same name again, and then started to look at other related func=
tions do to understand what the behaviour should be. There seems to be a nu=
mber of existing issues here:
>> >
>> > - object_property_try_add() returns NULL in the case a property cannot
>> >   be created (which seems to be only when an attempt to make add a
>> >   property that already exists). However since object_property_add()
>> >   always passes &error_abort, then QEMU terminates immediately without
>> >   returning the NULL.
>>=20
>> Convention: when we have a pair of functions FOO_try_BAR() and
>> FOO_BAR(), the former can fail and the latter cannot.  The latter is
>> useful when failure would be a programming error.
>>=20
>> When FOO_try_BAR() sets an Error on failure, FOO_BAR() is a thin wrapper
>> that passes &error_abort.
>>=20
>> We pass &error_abort when failure would be a programming error.  It's
>> more concise than "call then assert it didn't fail".  Concise is good.
>>=20
>> The wrapper makes calls that cannot fail even more concise.  Worth
>> having only when there are plenty of callers that profit from that.
>> Someone decided this is the case for object_property_try_add() /
>> object_property_add().
>>=20
>> > - object_class_property_add() will currently assert() if an attempt is
>> >   made to add a duplicate property: it is fairly trivial to update it =
to
>> >   return the same error that object_property_add() does, however it is
>> >   interesting to note that the kernel-doc states that
>> >   error_setg(&error_abort, ...) should NOT be used. However in this ca=
se
>> >   it appears to return a genuinely helpful message which I think is
>> >   worth keeping.
>>=20
>> The only difference between object_class_property_add() and
>> object_property_add() should be where the property is recorded (class
>> vs. object).  In particular, they should treat failure the same way.
>>=20
>> This may make object_class_property_try_add() necessary.
>
> IMHO such a method should not exist. A class must have a well-defined
> set of properties that is invariant. Any scenario where a
> object_class_property_try_add() method could fail would be 100%
> repeatable and at the same time a significant programmer error.
>
>
> When we had properties against objects 'try_add' was passable, as
> we're dynamically adding props and different instances  can have
> different props, even when the same time. This is all a terrible
> idea, and ideally object_property_try_add would not exist either
> but it is probably more trouble than its worth right now to attempt
> removing object_property_try_add. Just don't mirror it into class
> properties.

Good points.  Work into object.h comments?


