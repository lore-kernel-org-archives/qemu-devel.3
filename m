Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FE8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weubO-000427-K0; Wed, 01 Jul 2026 09:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weubM-00041r-W6
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weubL-0002wt-AZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782911018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUTdL2j7vm3/QhpLlr70daZucDuR76Seyns+8N6uVEc=;
 b=VAhA7io05y4haHgz1/oduaxP9pVG2ZGH/0DzltvUFyDLY5fnLqJJLgPNGoAQHF7Gi+tjgQ
 vuSt3MlYbf8FYUQkVoDxuOWxVHeGqoy+xD0HdfFbHc4s5OyRYBLtLVZYL1a2tAENIbkHOZ
 BCj/qb9ZyDYftrtKEY8H1j4BKPNPoxA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-Wd4InJA_M-WhZplUhGVAKA-1; Wed,
 01 Jul 2026 09:03:35 -0400
X-MC-Unique: Wd4InJA_M-WhZplUhGVAKA-1
X-Mimecast-MFC-AGG-ID: Wd4InJA_M-WhZplUhGVAKA_1782911014
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33F711954234; Wed,  1 Jul 2026 13:03:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 088031955D53; Wed,  1 Jul 2026 13:03:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C1DF21E6920; Wed, 01 Jul 2026 15:03:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 devel@lists.libvirt.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Peter Krempa
 <pkrempa@redhat.com>
Subject: Re: [PATCH v5 01/35] qom: replace 'can_be_deleted' with
 'prepare_delete'
In-Reply-To: <akOJbvaI7lvoW6Xw@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 30 Jun 2026 10:16:30 +0100")
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-2-berrange@redhat.com>
 <87qzlopjlp.fsf@pond.sub.org> <akOJbvaI7lvoW6Xw@redhat.com>
Date: Wed, 01 Jul 2026 15:03:30 +0200
Message-ID: <8733y26evx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

> On Tue, Jun 30, 2026 at 09:34:26AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > While most objects can perform all their cleanup in the finalizer
>> > method, there can be interactions with other resources / subsystems
>> > / threads which require that some cleanup be performed on an user
>> > creatable object before unparenting it and entering finalization.
>> >
>> > The current 'can_be_deleted' method runs in the deletion path and
>> > is intended to be used to block deletion. While it could be used
>> > to perform cleanup tasks, its name suggests it should be free of
>> > side-effects.
>> >
>> > Generalize this by renaming it to 'prepare_delete', explicitly
>> > allowing for cleanup to be provided. Existing users of 'can_be_deleted'
>> > are re-written, which provides them with more detailed/tailored error
>> > messages.
>> >
>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > Tested-by: Peter Krempa <pkrempa@redhat.com>
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>=20
>> [...]
>>=20
>> > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
>> > index 7080f85f95..6faa0b2fd9 100644
>> > --- a/qom/object_interfaces.c
>> > +++ b/qom/object_interfaces.c
>> > @@ -32,16 +32,15 @@ bool user_creatable_complete(UserCreatable *uc, Er=
ror **errp)
>> >      return !*errp;
>> >  }
>> >=20=20
>> > -bool user_creatable_can_be_deleted(UserCreatable *uc)
>> > +bool user_creatable_prepare_delete(UserCreatable *uc, Error **errp)
>> >  {
>> > -
>> >      UserCreatableClass *ucc =3D USER_CREATABLE_GET_CLASS(uc);
>> > +    ERRP_GUARD();
>> >=20=20
>> > -    if (ucc->can_be_deleted) {
>> > -        return ucc->can_be_deleted(uc);
>> > -    } else {
>> > -        return true;
>> > +    if (ucc->prepare_delete) {
>> > +        ucc->prepare_delete(uc, errp);
>> >      }
>> > +    return !*errp;
>> >  }
>>=20
>> Simpler:
>>=20
>>        if (ucc->prepare_delete) {
>>            return ucc->prepare_delete(uc, errp);
>>        }
>>=20
>>        return true;
>
> ok
>
>>=20
>> >=20=20
>> >  void user_creatable_add_qapi(ObjectOptions *options, Error **errp)
>> > @@ -253,8 +252,7 @@ bool user_creatable_del(const char *id, Error **er=
rp)
>> >          return false;
>> >      }
>> >=20=20
>> > -    if (!user_creatable_can_be_deleted(USER_CREATABLE(obj))) {
>> > -        error_setg(errp, "object '%s' is in use, can not be deleted",=
 id);
>> > +    if (!user_creatable_prepare_delete(USER_CREATABLE(obj), errp)) {
>>=20
>> This changes error messages.
>>=20
>> The old ones mention @id.
>>=20
>> The new ones don't:
>>=20
>>         error_setg(errp, "Cryptodev backend is still in use");
>>         error_setg(errp, "Host memory backend is still mapped");
>>         error_setg(errp, "IOMMUFD backend still has %d users", be->users=
);
>>         error_setg(errp, "Throttle group still has multiple references");
>>     error_setg(errp, "Deleting can bus devices is not supported");

Spel it CAN, please.

>>     error_setg(errp, "Deleting main loop is not supported");
>>=20
>> Visible in the diff to tests/qemu-iotests/245 below.
>>=20
>> Because this runs within object-del, and @id is the argument provided by
>> the user there, the error message is still sufficiently clear, I guess.
>>=20
>> If this ever gets used where the object isn't obvious to the user from
>> context, the error messages become sub-par.  Observation, not a demand.
>>=20
>> Please cover this change in the commit message.
>
> Oh yes, I remember being slightly annoyed at the need to do
> this - I was surprised to realize that an Object does not
> actually know its own 'id'. The 'id' only exists as the
> name of the property in the parent.
>
> We could add an  object_get_id() API which traveres obj->parent
> and then iterates over child properties. Annoyingly O(n) time
> for that, but perhaps not a big enough problem to worry about ?
> At least for error reporting we're probably ok with that time
> complexity even if there are 1000 objects registered as children.

Could you use object_get_canonical_path_component()?

[...]


