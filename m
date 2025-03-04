Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02316C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 07:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNB0-000876-4l; Tue, 04 Mar 2025 02:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNAu-00084i-57
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNAs-0003Cj-Mc
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741075124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=Guy+SrAar50GsTDhtN33W1HN2BojiNb1pusQcZQ4+wg=;
 b=IaTc5C5WXeQwNsq1lHdo448WbhnWgj1S8HbnCsICwdDRWZ5aFVZvFZg8tDhxPVSm//rHQf
 Y2PbHMVV5c1HdPZ/k2LJSi5Xw9mstRL+5L2+o0RelXo0bBxHewf+yEQECxoXdeYCF8x599
 IJ+tKC22Jmi9y32KQTkTUJcNopQF5ak=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-STr0ivBiNwGjNEEqUrsQfA-1; Tue,
 04 Mar 2025 02:58:43 -0500
X-MC-Unique: STr0ivBiNwGjNEEqUrsQfA-1
X-Mimecast-MFC-AGG-ID: STr0ivBiNwGjNEEqUrsQfA_1741075122
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9927F180087E; Tue,  4 Mar 2025 07:58:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E9631954B00; Tue,  4 Mar 2025 07:58:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B209121E66C2; Tue, 04 Mar 2025 08:58:39 +0100 (CET)
Resent-To: michael.roth@amd.com, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 04 Mar 2025 08:58:39 +0100
Resent-Message-ID: <87ldtlw7kg.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Victor Toso <victortoso@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2] qapi: pluggable backend code generators
In-Reply-To: <87msea9pdv.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 25 Feb 2025 13:31:56 +0100")
References: <20250224182030.2089959-1-berrange@redhat.com>
 <87msea9pdv.fsf@pond.sub.org>
Date: Tue, 04 Mar 2025 08:18:16 +0100
Message-ID: <874j09z2kn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Markus Armbruster <armbru@redhat.com> writes:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> The 'qapi.backend.QAPIBackend' class defines an API contract for code
>> generators. The current generator is put into a new class
>> 'qapi.backend.QAPICBackend' and made to be the default impl.
>>
>> A custom generator can be requested using the '-k' arg which takes a
>
> Missed an instance of -k.  Can fix this myself.
>
>> fully qualified python class name
>>
>>    qapi-gen.py -B the.python.module.QAPIMyBackend
>>
>> This allows out of tree code to use the QAPI generator infrastructure
>> to create new language bindings for QAPI schemas. This has the caveat
>> that the QAPI generator APIs are not guaranteed stable, so consumers
>> of this feature may have to update their code to be compatible with
>> future QEMU releases.
>>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

>> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
>> index 324081b9fc..8a8b1e0121 100644
>> --- a/scripts/qapi/main.py
>> +++ b/scripts/qapi/main.py

[...]

>> @@ -29,32 +25,37 @@ def invalid_prefix_char(prefix: str) -> Optional[str=
]:
>>      return None
>>=20=20
>>=20=20
>> -def generate(schema_file: str,
>> -             output_dir: str,
>> -             prefix: str,
>> -             unmask: bool =3D False,
>> -             builtins: bool =3D False,
>> -             gen_tracing: bool =3D False) -> None:
>> -    """
>> -    Generate C code for the given schema into the target directory.
>> +def create_backend(path: str) -> QAPIBackend:
>> +    if path is None:
>> +        return QAPICBackend()
>>=20=20
>> -    :param schema_file: The primary QAPI schema file.
>> -    :param output_dir: The output directory to store generated code.
>> -    :param prefix: Optional C-code prefix for symbol names.
>> -    :param unmask: Expose non-ABI names through introspection?
>> -    :param builtins: Generate code for built-in types?
>> +    if "." not in path:
>> +        print(f"Missing qualified module path in '{path}'", file=3Dsys.=
stderr)
>> +        sys.exit(1)
>>=20=20
>> -    :raise QAPIError: On failures.
>> -    """
>> -    assert invalid_prefix_char(prefix) is None
>> +    module_path, _, class_name =3D path.rpartition('.')
>
> I'd like to tweak this to
>
>        module_path, dot, class_name =3D path.rpartition('.')
>        if not dot:
>            print(f"argument of -B must be of the form MODULE.CLASS",
>                  file=3Dsys.stderr)

This bothers flake8:

    scripts/qapi/main.py:34:15: F541 f-string is missing placeholders

I'll make it a plain string instead.

>            sys.exit(1)
>

[...]


