Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE20EC71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 14:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRtjI-0005JN-LT; Wed, 18 Jun 2025 10:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRtjF-0005Il-Lb
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 10:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRtjA-0003Ge-SF
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 10:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750256720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Uu3Hv3gRjvZsH8KV0tCkElui3DCDdwBo7EjBdAtZMA=;
 b=hQhUTZJm+j2RJOPsECZQ5IGxNlQBa+C1JYskFPTVrqDUyTk82U0bSEr1ynMzs6ttiEFy5J
 kUADKES1gRaRP1LAPa/ODyaxd/ZReQXtVdia8kn2+hUAcxNraeRsDaK1d5LaNl4wZTDfRO
 BFpdlXaOu9Dm1/9QOxJStVUdE+JL5C0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-pFe7oIyANYaLO8-uup1HEw-1; Wed,
 18 Jun 2025 10:25:19 -0400
X-MC-Unique: pFe7oIyANYaLO8-uup1HEw-1
X-Mimecast-MFC-AGG-ID: pFe7oIyANYaLO8-uup1HEw_1750256718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14FFD180028A; Wed, 18 Jun 2025 14:25:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 457F619560A3; Wed, 18 Jun 2025 14:25:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC87C21E6A27; Wed, 18 Jun 2025 16:25:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,  qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com,  qemu-rust@nongnu.org,  mkletzan@redhat.com
Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
In-Reply-To: <CABgObfa+w3pcYhFnO6ETxSfoNiNU=+_8WcW6dE8dkUrbt6darw@mail.gmail.com>
 (Paolo Bonzini's message of "Thu, 12 Jun 2025 12:24:44 +0200")
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <aEk6vdosWZgyQGXD@intel.com>
 <CABgObfaK8h3GE4GWbPrn22JshYcCFdXsxWHWuAPVC4pRb7GZ0A@mail.gmail.com>
 <CABgObfa+w3pcYhFnO6ETxSfoNiNU=+_8WcW6dE8dkUrbt6darw@mail.gmail.com>
Date: Wed, 18 Jun 2025 16:25:14 +0200
Message-ID: <877c19nn3p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

I don't know enough about Rust/serde to give advice.  I do know how to
make a fool of myself by asking dumb questions.

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Wed, Jun 11, 2025 at 10:57=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
>> Yes. If using serde the implementation of the traits is very small,
>> and basically the same for all types. If not using serde, it would
>> need some (or most) of the infrastructure in Marc-Andr=C3=A9's original
>> series.
>
> Looking more at it, the Rust->QObject and QObject->Rust parts *can* be
> done with serde (following the model of serde_json's Value
> (de)serializer) but the Rust<->C part has a problem.
>
> To recap, Rust->C is the serialization and corresponds to output
> visitors. C->Rust is the deserialization and corresponds to input
> visitors.
>
> For serialization, serde has a push model where the generated code
> looks like this:
>
>       let mut state =3D
>           Serializer::serialize_struct(serializer, "S", 2);
>       SerializeStruct::serialize_field(&mut state, "a", &self.a)?;
>       SerializeStruct::serialize_field(&mut state, "b", &self.b)?;
>       SerializeStruct::end(state)
>
> whereas QAPI has a pull model where visit_type_* drives the process
> and requests the fields one by one.
>
> For deserialization, serde has a pull model where the generated code
> asks for the field names one by one:
>
>     fn visit_map<__A>(self, mut __map: __A)
>         while let Some(key) =3D
>             MapAccess::next_key::<__Field>(&mut __map)? {
>                 match __key { ... }
>         }
>     }
>
> whereas QAPI has a push model where visit_type_* again drives the
> process and sends fields one by one.
>
> For commands this is not a problem because the real underlying
> transformation is QObject->QObject and the intermediate steps (to and
> from QObject) can use serde.

Are you talking about commands implemented in Rust?

The existing data flow is roughly like this (I'm simplifying):

1. Parse JSON text into request QObject, pass to QMP core

2. Extract command name string and argument QDict

3. Look up generated command marshaller / unmarshaller, pass argument
   QDict to it

4. Unmarshall argument QDict with the QObject input visitor and
   generated visit_type_ARG()

5. Pass the C arguments to the handwritten command handler, receive the
   C return value

6. Marshall the return value into a QObject with the QObject output
   visitor and generated visit_type_RET(), return it to QMP core

7. Insert it into a response QObject

8. Unparse response QObject into JSON text

How would a Serde flow look like?

> However, QOM property getters/setters (especially, but not
> exclusively, for properties with compound types) remain a problem
> since these use callbacks with a Visitor* argument.

object_property_set() takes the new property value wrapped in an input
visitor.  The property setter extracts it using visit_type_FOOs() with
this input visitor as it sees fit.  Ideally, it uses exactly
visit_type_PROPTYPE().

object_property_get() takes an output visitor to be wrapped it around
the property value.  The property getter inserts it using
visit_type_FOOs() with this output visitor as it sees fit.  Ideally, it
uses exactly visit_type_PROPTYPE().

We sometimes use a QObject input / output visitor, and sometimes a
string input / output visitor.  The latter come with restrictions, and
are evolutionary dead ends.

The QObject visitors wrap a QObject, the string visitors wrap a string
(d'oh).

>                                                     I see three
> possibilities:
>
> 1) everything is done through an intermediate QObject step (e.g. for a
> setter: Visitor->QObject with an input visitor, and QObject->Rust with
> serde deserialization).
>     + easy, Rust only sees serde
>     + QMP commands use a single conversion step
>     - inefficient
>
> 2) everything is done through an intermediate C step (e.g. for a
> setter: Visitor->C with a visit_type_* function, and C->Rust with
> generated code that does not need to use serde). There is still a
> double conversion step, but it's more efficient than option 1
>     + one framework (visitor)
>     - double conversion for the QMP commands
>     - lots of generated code
>
> 3) generating a Rust visit_type_* implementation as well, either in
> qapi-gen (3a) or through a procedural macro (3b). This should not be
> hard to write but it would remove a lot of the advantages from using
> serde.
>     + efficient
>     + preserves single conversion for QMP commands
>     - two frameworks

I'm afraid this is too terse for ignorant me.

> I am leaning towards option 1, i.e. keep using serde but only cover
> conversions to and from QObject. The reason is that one future usecase
> for Rust in QEMU is the UEFI variable store; that one also has some
> Rust<->JSON conversions and could be served by either QObject or
> serde_json. Either way, it'd be nice for the UEFI variable store to
> remain within the Rust serde ecosystem and allow sharing code between
> QEMU and Coconut SVSM. But I'm not so sure...
>
> Paolo


