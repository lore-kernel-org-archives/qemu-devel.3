Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F49FC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6NQU-0005GG-1Q; Tue, 15 Sep 2026 03:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6NQN-0005Fy-He
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6NQJ-0001sR-FU
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789456659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2pJ2FGuAvC/ALt/kbq60NPcLqEm1XtB8OfvKJUuSzE=;
 b=Ijnt1IBJxyJn10IdyJhNS9Lx0tzesWLpbMwdoNprq0CnCYa2ULww4YLV/wNWpjyhvIQEJD
 SSHINevSarUuD1ECfS3ddHdkheRwe38vAFL/Zew3lossWuZ8Owoek/LnXO5X3T/CVT56lt
 ej8/w11WS6N5krPANI1QBzTFZQpfhes=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-RXW0SIuoNZuAitujB_DhyQ-1; Tue,
 15 Sep 2026 03:17:35 -0400
X-MC-Unique: RXW0SIuoNZuAitujB_DhyQ-1
X-Mimecast-MFC-AGG-ID: RXW0SIuoNZuAitujB_DhyQ_1789456654
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EB741801200; Tue, 15 Sep 2026 07:17:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEE16180035F; Tue, 15 Sep 2026 07:17:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C18421E6A04; Tue, 15 Sep 2026 09:17:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 12/14] qom: report & filter on security status in
 qom-list-types
In-Reply-To: <aqhXANB86gps6UYR@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 14 Sep 2026 21:20:16 +0100")
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-13-berrange@redhat.com>
 <7a47ed5e-fc50-4f13-8fac-455c6015d38e@linaro.org>
 <aqhTQ4pad4OOWCcV@redhat.com>
 <0ff70c1c-cf73-46ec-9ae6-e2130bd1eb91@linaro.org>
 <aqhXANB86gps6UYR@redhat.com>
Date: Tue, 15 Sep 2026 09:17:31 +0200
Message-ID: <87wlsnrnjo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Mon, Sep 14, 2026 at 10:12:17AM -1000, Richard Henderson wrote:
>> On 9/14/26 10:04, Daniel P. Berrang=C3=A9 wrote:
>> > On Mon, Sep 14, 2026 at 09:30:56AM -1000, Richard Henderson wrote:
>> > > On 9/10/26 00:36, Daniel P. Berrang=C3=A9 wrote:
>> > > > @@ -161,9 +163,15 @@ static void qom_list_types_tramp(ObjectClass =
*klass, void *opaque)
>> > > >        ObjectTypeInfo *info;
>> > > >        ObjectClass *parent =3D object_class_get_parent(klass);
>> > > > +    if (data->has_secure &&
>> > > > +        data->secure !=3D object_class_is_secure(klass)) {
>> > > > +        return;
>> > > > +    }
>> > > > +
>> > > >        info =3D g_malloc0(sizeof(*info));
>> > > >        info->name =3D g_strdup(object_class_get_name(klass));
>> > > >        info->has_abstract =3D info->abstract =3D object_class_is_a=
bstract(klass);
>> > > > +    info->has_secure =3D info->secure =3D object_class_is_secure(=
klass);
>> > >=20
>> > > Why are you assigning to has_secure here?  I thought that was just f=
or the
>> > > filter test above.
>> >=20
>> > 'data->has_secure/secure' is for the input parameter allowing the
>> > QMP client to say whether the returned device list should be
>> > filtered based on security status, or include everything (the
>> > default).
>> >=20
>> > 'info->has_secure/secure' is for the return value reporting to the
>> > client whether each device was secure/insecure.
>> Still not getting it.  I understand info->secure as an output.
>> I do not understand info->has_secure as an output.
>>=20
>> Unless info->has_secure =3D true as an output indicates info->secure is =
valid?
>> But in that case, why make them identical.
>
> Since 'secure' is declared as an optional field in QAPI, the
> 'info->secure' flag will be ignored when serializing to JSON
> if 'has_secure' is not set to true.

QAPI optional effectively adds another value to the type: "absent".

In particular, an optional bool can have three values: false, true,
absent.

Absent commonly has the same meaning as one of the other values.  We
then say it defaults to that value.  There are exceptions where absent
means something else entirely.

Not how I would've designed optional, but it is what it is.

[...]


