Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DA3EB7EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhIm-0008AV-4B; Wed, 04 Mar 2026 03:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxhIk-0008AC-Hb
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:09:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxhIi-0006Jl-Qn
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772611787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9HVX+qXWxd39WKrRnp3gKJXk5cmnNo78UAv2CZGDf0M=;
 b=gSJjy+rtPHMJXW+G/tG6ZOCEqsrRbyK+y1jLlwIZlChsdgxxVawsjv7FQqJXFLfBR7tstI
 WkHWcRDD1RvXsi+mMc/rOhAVzxdr0bDjLJpPTQVNVJJgvyAkI7n9FChNyprLdEA21jtHEg
 W/e+YXBfEUcoKSSeV9uSm9TOLH6f9jc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-_GCIbBA4P5eqRZs0xm8V7A-1; Wed,
 04 Mar 2026 03:09:46 -0500
X-MC-Unique: _GCIbBA4P5eqRZs0xm8V7A-1
X-Mimecast-MFC-AGG-ID: _GCIbBA4P5eqRZs0xm8V7A_1772611785
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABE0D18002CF; Wed,  4 Mar 2026 08:09:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.30])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B3C530001A1; Wed,  4 Mar 2026 08:09:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 70AD421E692F; Wed, 04 Mar 2026 09:09:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 12/16] scripts/qapi: generate high-level Rust bindings
In-Reply-To: <CABgObfYBVbpLfzFiYaCjzTL5zTqynWcUepV=o-AesJJF3jENEQ@mail.gmail.com>
 (Paolo Bonzini's message of "Tue, 3 Mar 2026 16:55:30 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-13-pbonzini@redhat.com>
 <87jyw0khu2.fsf@pond.sub.org>
 <3cd5ac78-1833-4671-a866-60a57f29c3c1@redhat.com>
 <87v7fdm6w6.fsf@pond.sub.org>
 <CABgObfYBVbpLfzFiYaCjzTL5zTqynWcUepV=o-AesJJF3jENEQ@mail.gmail.com>
Date: Wed, 04 Mar 2026 09:09:42 +0100
Message-ID: <87bjh4koc9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Tue, Mar 3, 2026 at 1:31=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> >> You replied "In this case it doesn't really matter: public items (such
>> >> as QAPI enum entries, or struct fields) do not raise the unused warni=
ng
>> >> anyway."
>> >>
>> >> What gives us confidence rs_name() will only be used where it doesn't
>> >> really matter?
>> >
>> > The fact that all QAPI type definitions are (more or less by design) p=
ublic.
>>
>> Any particular reason not to use the same 'q_' prefix as in C?
>
> The other Rust convention is that you usually have enums in CamelCase
> (starting with an uppercase letter). "q_" or "Q_" would also trigger a
> warning, and they would complicate to_camel_case a bit (because the
> prefix would have to be kept including the underscore).

Alright.

One of the QAPI generator's known shortcomings is weak protection
against name clashes in generated code.

The generator was built with cavalier disregard for name clashes.  The
existing naming rules and their enforcement was retrofitted to limit the
damage.

There are two kinds:

* The user's names clashing with the generator's.

  Naming rules help avoid such clashes.

  Example: ['Frob'] makes the generator define a C type FrobList, which
  could clash with a user-defined 'FrobList' if we didn't reject
  user-defined names ending with 'List'.  Test case reserved-type-list.

  But there are gaps.

  Example: a user-defined type QAPIEvent clashes with generated enum
  QAPIEvent.

  The naming rules should reflect the names the generator wants to use.
  When we add new patterns of generated names, we should update the
  rules.  One pattern this series adds is names ending with 'Variant',
  as I pointed out in the review of the generated code I sent yesterday.

* The user's names clashing with themselves.

  Naming rules again help avoid such clashes.

  Example: struct members 'a_b and 'a-b' would both map to C identifier
  a_b if we didn't reject that.  Test case struct-member-name-clash.

  The rejection code checks for clashes among the values of c_name().
  This guards against clashes in generated C.  To also guard against
  clashes in generated Rust, we'd need to check the values of rs_name().
  I'd accept a TODO comment for now.

  Again, there are gaps.

  Example: value 'ni-cator' of enum 'Frob' and value 'cator' of enum
  'FrobNi' both generate C enumeration constant FROB_NI_CATOR.

  The more the generator massages names, the more we risk such clashes.
  The C generator doesn't massage all that much, mostly funny characters
  to '_', and enumeration constants.  The Rust generator needs to
  massage more, because Rust's naming rules differ from C's.  I think we
  should at least document the problem clearly.  Anything else?  Better
  ideas?

See also docs/devel/qapi-code-gen.rst section "Naming rules and reserved
names".

>> >> This maps 'foo-0123-bar' to 'Foo_0123Bar'.  Intentional?  I'd kind of
>> >> expect 'Foo0123Bar'.
>> >
>> > Will fix (it is meant for 0123-45).  New version is:
>> >
>> >    def to_camel_case(value: str) -> str:
>> >        result =3D ''
>> >        for p in re.split(r'[-_]+', value):
>> >            if not p:
>> >                pass
>> >            elif p[0].isalpha() or (result and result[-1].isalpha()):
>> >                result +=3D p[0].upper() + p[1:]
>> >            else:
>> >                result +=3D '_' + p
>> >        return result
>>
>> Maps '0123-45' to '_0123_45'.  Is the leading '_' intentional?
>
> Yes, because otherwise the output is not an identifier; but it doesn't
> matter since the input is actually an identifier already and
> to_camel_case('_0123_45') does give '_0123_45'. In neither case you
> get the invalid identifier '0123_45'.

Shouldn't that be left to rs_name()?

>> I'm fine with not running rustfmt, and I'm fine with running it always
>> (makes it a hard requirement).  Running it sometimes feels like more
>> trouble than it's worth.
>
> Yeah, I will drop it. I changed mcgen to allow removing empty lines in
> the middle of a declaration, like this:
>
> def mcgen(*code: T.Sequence[str], **kwds: object) -> str:
>     '''
>     Generate ``code`` with ``kwds`` interpolated.  Separate
>     positional arguments represent separate segments that could
>     expand to empty strings; empty segments are omitted and no
>     blank lines are introduced at their boundaries.
>     '''
>     last =3D len(code) - 1
>     result =3D []
>     for i, s in enumerate(code):
>         if s.startswith('\n'):
>             s =3D s[1:]
>         if i !=3D last:
>             s =3D s.rstrip()
>         s =3D cgen(s, **kwds)
>         if s:
>             result.append(s)
>     return '\n'.join(result)
>
> For the case of a single argument, the result is equivalent to the
> existing implementation:
>
>         # already checked by current mcgen()
>         if s.startswith('\n'):
>             s =3D s[1:]
>         # skipped for a single argument
>         if i !=3D last:
>             s =3D s.rstrip()
>         s =3D cgen(s, **kwds)
>         if s:
>             result.append(s)
>     # result has zero or a single element, no '\n' added
>     return '\n'.join(result)

I wonder how the generated C would change if we used this there.


