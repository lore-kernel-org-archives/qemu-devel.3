Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFF1C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 09:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7UWU-0004A2-9g; Fri, 18 Sep 2026 05:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7UWS-00049u-Gh
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 05:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7UWQ-0008Sq-IL
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 05:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789722280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VY8Wv6pO6J2vAPa4HAjbP6zE8TfDRO0pmZfg1snFmrs=;
 b=AEzVoMCjm0tKmtcpnGGsTI4hXgCWEOMv5wGrSIvenzC1rOlMvbiNbo7nZq2gnhsQn1ODIv
 kHIgAfU0OuJza3X+CCaTNoG8iGmKcH8m9aWsQAqTi/C+pkvS6hVaBd4HbKb+m3iMgU559b
 5F43T6rdycbvB+Y0SdDu07K8VNIh2Jo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-C3EQTJt7OcOhM_zJQELDHw-1; Fri,
 18 Sep 2026 05:04:36 -0400
X-MC-Unique: C3EQTJt7OcOhM_zJQELDHw-1
X-Mimecast-MFC-AGG-ID: C3EQTJt7OcOhM_zJQELDHw_1789722275
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94748195605E; Fri, 18 Sep 2026 09:04:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD5E61800446; Fri, 18 Sep 2026 09:04:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A28C621E6A04; Fri, 18 Sep 2026 11:04:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com,
 richard.henderson@linaro.org,  mst@redhat.com,  mtosatti@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/8] qom/object.c: introduce
 object_class_property_add_alias()
In-Reply-To: <8d9f755c-a82a-4b22-8a9c-ff75bdc23da2@nutanix.com> (Mark
 Cave-Ayland's message of "Fri, 18 Sep 2026 09:38:21 +0100")
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
 <20260902144207.2553037-3-mark.caveayland@nutanix.com>
 <CAMxuvaxoQXZz3AhM9wnRuM7hRn8LD4hMT0ONaV-vRtz5Jy0big@mail.gmail.com>
 <8d9f755c-a82a-4b22-8a9c-ff75bdc23da2@nutanix.com>
Date: Fri, 18 Sep 2026 11:04:31 +0200
Message-ID: <875x03nd5s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> On 17/09/2026 09:52, Marc-Andr=C3=A9 Lureau wrote:
>
>> Hi
>> On Wed, Sep 2, 2026 at 6:42=E2=80=AFPM Mark Cave-Ayland
>> <mark.caveayland@nutanix.com> wrote:
>>>
>>> This is eventually intended to be a replacement for object_property_add=
_alias()
>>> which uses an object property instead of a class property.
>>>
>>> With the advent of class properties, it is possible that QOM may attemp=
t to
>>> set or retrieve the value of an unset alias property. Update the existi=
ng
>>> property_get_alias() and property_set_alias() functions to use the null=
 visitor
>>> if the alias target has not been set, and property_resolve_alias() to r=
eturn
>>> NULL for the same case.
>>>
>>> This ensures that unset class alias properties accessed e.g. via the mo=
nitor do
>>> not cause QEMU to crash.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>> ---
>>>   include/qom/object.h |  25 +++++++++++
>>>   qom/object.c         | 100 +++++++++++++++++++++++++++++++++++++------
>>>   2 files changed, 113 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/qom/object.h b/include/qom/object.h
>>> index e24f0a2b2d..96c76975ef 100644
>>> --- a/include/qom/object.h
>>> +++ b/include/qom/object.h
>>> @@ -2263,6 +2263,11 @@ ObjectProperty *object_class_static_property_add=
_uint64_ptr(ObjectClass *klass,
>>>                                             const uint64_t *v,
>>>                                             ObjectPropertyFlags flags);
>>>
>>> +typedef enum {
>>> +    /* private */
>>> +    OBJ_PROP_ALIAS_CLASS =3D 0x1,
>>> +} ObjectPropertyAliasFlags;
>>> +
>>>   /**
>>>    * object_property_add_alias:
>>>    * @obj: the object to add a property to
>>> @@ -2283,6 +2288,26 @@ ObjectProperty *object_class_static_property_add=
_uint64_ptr(ObjectClass *klass,
>>>   ObjectProperty *object_property_add_alias(Object *obj, const char *na=
me,
>>>                                  Object *target_obj, const char *target=
_name);
>>>
>>> +/**
>>> + * object_class_property_add_alias:
>>> + * @klass: the object class to add a property to
>>> + * @name: the name of the property
>>> + * @offset: the offset from the object instance where the object alias=
 is
>>> + *   stored
>>> + * @target_type: QOM type we expect the alias to resolve to
>>> + * @target_name: the name of the property on the forwarded object
>>> + *
>>> + * Add an alias for a property on an object.  This function will add a=
 property
>>> + * of the same type as the forwarded property.
>>> + *
>>> + * Returns: The newly added property on success, or %NULL on failure.
>> actually, it assert() on error and never returns NULL.
>
> I was able to reproduce this by attempting to add a class alias property =
with the same name again, and then started to look at other related functio=
ns do to understand what the behaviour should be. There seems to be a numbe=
r of existing issues here:
>
> - object_property_try_add() returns NULL in the case a property cannot
>   be created (which seems to be only when an attempt to make add a
>   property that already exists). However since object_property_add()
>   always passes &error_abort, then QEMU terminates immediately without
>   returning the NULL.

Convention: when we have a pair of functions FOO_try_BAR() and
FOO_BAR(), the former can fail and the latter cannot.  The latter is
useful when failure would be a programming error.

When FOO_try_BAR() sets an Error on failure, FOO_BAR() is a thin wrapper
that passes &error_abort.

We pass &error_abort when failure would be a programming error.  It's
more concise than "call then assert it didn't fail".  Concise is good.

The wrapper makes calls that cannot fail even more concise.  Worth
having only when there are plenty of callers that profit from that.
Someone decided this is the case for object_property_try_add() /
object_property_add().

> - object_class_property_add() will currently assert() if an attempt is
>   made to add a duplicate property: it is fairly trivial to update it to
>   return the same error that object_property_add() does, however it is
>   interesting to note that the kernel-doc states that
>   error_setg(&error_abort, ...) should NOT be used. However in this case
>   it appears to return a genuinely helpful message which I think is
>   worth keeping.

The only difference between object_class_property_add() and
object_property_add() should be where the property is recorded (class
vs. object).  In particular, they should treat failure the same way.

This may make object_class_property_try_add() necessary.

> - There are several places in qom/object.c that do not check the
> return value of object_property_add() / object_class_property_add()
> such as object_add_link_prop(), object_property_add_alias() which
> could potentially dereference a NULL pointer.

object_property_add() is specified not to fail, i.e. not to return null.
It's a programming error if it does.  Letting the program crash on
programming errors by dereferencing a null pointer is just fine.  We can
dress up the crash with assert(obj), but I wouldn't bother.

Use object_property_add() when failure is a programming error.  Use
object_property_try_add() and handle the error when it's not.

> It feels like the assumption is actually that these functions will &error=
_abort rather than returning NULL as indicated by the kernel-doc. Any thoug=
hts on what we should do here? Ideally we want the same behaviour between t=
he object_property*() and object_class_property*() functions to aid the tra=
nsition.

Hope this helps!

[...]


