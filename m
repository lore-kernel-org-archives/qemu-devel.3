Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9E0C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnC7j-0003JH-IG; Wed, 26 Feb 2025 02:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnC7h-0003Iq-DV
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:46:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnC7f-0005en-4r
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740555985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3F5aCWoj1YyGU52x85ap7RfQCZxR+11SaE/PowrYPXo=;
 b=bg0MdUe2M4R7/FpHVqjTo23XL3on7/ieTQkj5mVoHWpAZQeEZcoTYJGsyqNWPJHrygk1Ep
 CBccvpC8q7mLvi/fK4yim5LBmrLbMm9gpazIZnT2eAwHKrQdIhARUZ4gOy+F5x4bYO4/dT
 +IVbShP+gMm2QChdd+rhtxkRKFh1wu0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-mEi8aQs_N0C3LLAG8WgD2w-1; Wed,
 26 Feb 2025 02:46:21 -0500
X-MC-Unique: mEi8aQs_N0C3LLAG8WgD2w-1
X-Mimecast-MFC-AGG-ID: mEi8aQs_N0C3LLAG8WgD2w_1740555980
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6CFF180036F; Wed, 26 Feb 2025 07:46:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4148C180035F; Wed, 26 Feb 2025 07:46:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE26A21E675F; Wed, 26 Feb 2025 08:46:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Victor Toso <victortoso@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2] qapi: pluggable backend code generators
In-Reply-To: <Z726Bod5m07H-euc@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 25 Feb 2025 12:39:34 +0000")
References: <20250224182030.2089959-1-berrange@redhat.com>
 <87msea9pdv.fsf@pond.sub.org> <Z726Bod5m07H-euc@redhat.com>
Date: Wed, 26 Feb 2025 08:46:16 +0100
Message-ID: <871pvl5et3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Feb 25, 2025 at 01:31:56PM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > The 'qapi.backend.QAPIBackend' class defines an API contract for code
>> > generators. The current generator is put into a new class
>> > 'qapi.backend.QAPICBackend' and made to be the default impl.
>> >
>> > A custom generator can be requested using the '-k' arg which takes a
>>=20
>> Missed an instance of -k.  Can fix this myself.
>>=20
>> > fully qualified python class name
>> >
>> >    qapi-gen.py -B the.python.module.QAPIMyBackend
>> >
>> > This allows out of tree code to use the QAPI generator infrastructure
>> > to create new language bindings for QAPI schemas. This has the caveat
>> > that the QAPI generator APIs are not guaranteed stable, so consumers
>> > of this feature may have to update their code to be compatible with
>> > future QEMU releases.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>
>> > -def generate(schema_file: str,
>> > -             output_dir: str,
>> > -             prefix: str,
>> > -             unmask: bool =3D False,
>> > -             builtins: bool =3D False,
>> > -             gen_tracing: bool =3D False) -> None:
>> > -    """
>> > -    Generate C code for the given schema into the target directory.
>> > +def create_backend(path: str) -> QAPIBackend:
>> > +    if path is None:
>> > +        return QAPICBackend()
>> >=20=20
>> > -    :param schema_file: The primary QAPI schema file.
>> > -    :param output_dir: The output directory to store generated code.
>> > -    :param prefix: Optional C-code prefix for symbol names.
>> > -    :param unmask: Expose non-ABI names through introspection?
>> > -    :param builtins: Generate code for built-in types?
>> > +    if "." not in path:
>> > +        print(f"Missing qualified module path in '{path}'", file=3Dsy=
s.stderr)
>> > +        sys.exit(1)
>> >=20=20
>> > -    :raise QAPIError: On failures.
>> > -    """
>> > -    assert invalid_prefix_char(prefix) is None
>> > +    module_path, _, class_name =3D path.rpartition('.')
>>=20
>> I'd like to tweak this to
>>=20
>>        module_path, dot, class_name =3D path.rpartition('.')
>>        if not dot:
>>            print(f"argument of -B must be of the form MODULE.CLASS",
>>                  file=3Dsys.stderr)
>>            sys.exit(1)
>
> Yep, sure thing.
>
>>=20
>> > +    try:
>> > +        mod =3D import_module(module_path)
>> > +    except Exception as ex:
>>=20
>> pylint complains:
>>=20
>>     scripts/qapi/main.py:39:11: W0718: Catching too general exception Ex=
ception (broad-exception-caught)
>>=20
>> I can't see offhand what exception(s) we're supposed to catch here, so
>> let's not worry about this now.
>
> Yeah, I was concerned that by putting specialized exception
> classes here, we would miss some possible scenarios, and IMHO
> the completeness of catching Exception is better than the
> technical purity of pylint's complaint.=20

Cleaner code would require a stronger contract.

We'll be just fine.

>> > +    if not hasattr(mod, class_name):
>> > +        print(f"Module '{module_path}' has no class '{class_name}'", =
file=3Dsys.stderr)
>>=20
>> pycodestyle-3 complains:
>>=20
>>     scripts/qapi/main.py:44:80: E501 line too long (85 > 79 characters)
>>=20
>> Let's break the line after the comma, and also start the error message
>> in lower case for consistency with error messages elsewhere.
>>=20
>> > +        sys.exit(1)
>> > +    klass =3D getattr(mod, class_name)
>>=20
>> Alternatively
>>=20
>>        try:
>>            klass =3D getattr(mod, class_name)
>>        except AttributeError:
>>            print(f"module '{module_path}' has no class '{class_name}'",
>>                  file=3Dsys.stderr)
>>            sys.exit(1)
>>=20
>> Admittedly a matter of taste.  I tend to avoid the
>>=20
>>     if frobnicate would fail:
>>         error out
>>     frobnicate
>>=20
>> pattern when practical.
>
> I guess I tend to avoid using exception catching for such flow
> control, but I don't mind that much either way.

I'm not a fan of using exceptions for mundane failures, but it's how
Python rolls.

>> > -    schema =3D QAPISchema(schema_file)
>> > -    gen_types(schema, output_dir, prefix, builtins)
>> > -    gen_features(schema, output_dir, prefix)
>> > -    gen_visit(schema, output_dir, prefix, builtins)
>> > -    gen_commands(schema, output_dir, prefix, gen_tracing)
>> > -    gen_events(schema, output_dir, prefix)
>> > -    gen_introspect(schema, output_dir, prefix, unmask)
>> > +        return backend
>> > +    except Exception as ex:
>>=20
>> Likewise too general exception.
>>=20
>> I'd like to shrink the try block and reduce the nesting:
>>=20
>>        try:
>>            backend =3D klass()
>>        except Exception as ex:
>>            print(f"Backend '{path}' cannot be instantiated: {ex}", file=
=3Dsys.stderr)
>>            sys.exit(1)
>>=20
>>        if not isinstance(backend, QAPIBackend):
>>            print(f"Backend '{path}' must be an instance of QAPIBackend",=
 file=3Dsys.stderr)
>>            sys.exit(1)
>>=20
>>        return backend
>
> Sure, fine with me.
>
>
>> Good enough.
>>=20
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>=20
>> No need to respin, I can make the tweaks I suggested myself.  Feel free
>> to challenge my suggestions, of course.
>
> Thank you, it is all fine.

Cool, expect it in my next pull request.  Thanks!


