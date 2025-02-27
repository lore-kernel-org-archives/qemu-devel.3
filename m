Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A0EC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXxa-00064F-Io; Thu, 27 Feb 2025 02:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnXxW-00062e-CA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnXxU-0006lv-F7
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740639922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GgxCkE0RR65y9piky2YsPjHOf4mCzDxN9N90SKQsRWU=;
 b=WpvLnQqW1V5R14nprJWPBw0HL4F2SYp6L6iycnqF0O4v6Obb5bPqongQYf3pE/kwUwZQ/n
 zcX5q3fcNXSt2qxzHpI/zcEXyf+fpWQmGwWenm+X89goIl51MLn/t5ngbb5iCf7SfRMv0X
 /+uWii/yBH8dVtpaMnS7eEeFAdQ/hKs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-5NHBvtyfOC-d8d1xrxKZxA-1; Thu,
 27 Feb 2025 02:05:17 -0500
X-MC-Unique: 5NHBvtyfOC-d8d1xrxKZxA-1
X-Mimecast-MFC-AGG-ID: 5NHBvtyfOC-d8d1xrxKZxA_1740639916
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A0F619039C2; Thu, 27 Feb 2025 07:05:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ED4E1944D02; Thu, 27 Feb 2025 07:05:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AAC4821E6741; Thu, 27 Feb 2025 08:05:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Thomas
 Huth <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 03/10] qapi: delete un-needed python static analysis
 configs
In-Reply-To: <CAFn=p-aPSKn1iL3evY4YKyqUnntQZ+y9Tmh_Bq8-YxwMtWQx-w@mail.gmail.com>
 (John Snow's message of "Wed, 26 Feb 2025 10:05:54 -0500")
References: <20250224033741.222749-1-jsnow@redhat.com>
 <20250224033741.222749-4-jsnow@redhat.com>
 <87bjup5fnl.fsf@pond.sub.org>
 <CAFn=p-aPSKn1iL3evY4YKyqUnntQZ+y9Tmh_Bq8-YxwMtWQx-w@mail.gmail.com>
Date: Thu, 27 Feb 2025 08:05:10 +0100
Message-ID: <875xkvvpeh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

John Snow <jsnow@redhat.com> writes:

> On Wed, Feb 26, 2025 at 2:28=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > The pylint config is being left in place because the settings differ
>> > enough from the python/ directory settings that we need a chit-chat on
>> > how to merge them O:-)
>> >
>> > Everything else can go.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>

[...]

>> > diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
>> > deleted file mode 100644
>> > index 8109470a031..00000000000
>> > --- a/scripts/qapi/mypy.ini
>> > +++ /dev/null
>> > @@ -1,4 +0,0 @@
>> > -[mypy]
>> > -strict =3D True
>> > -disallow_untyped_calls =3D False
>> > -python_version =3D 3.8
>>
>> python/setup.cfg has:
>>
>>    [mypy]
>>    strict =3D True
>>    python_version =3D 3.8
>>    warn_unused_configs =3D True
>>    namespace_packages =3D True
>>    warn_unused_ignores =3D False
>>
>> Can you briefly explain the differences?
>>
>
> warn_unused_configs: Catches config values that aren't actually recognized
> or used. Was helpful once upon a time when re-arranging the Python
> directory to behave like a package to ensure that the conf files were
> working correctly.

Could this be culled now?

Hmm, according to mypy(1), strict implies warn-unused-configs.

The question does not block this patch.

> namespace_packages: Needed for the python/ directory structure (nested
> packages under a namespace, "qemu"). Doesn't impact scripts/qapi at all.
> Read up on PEP420 if you are curious. Details in commit message, see below
> if you're still curious.

mypy(1) makes me suspect this is the default.  If that's true across the
versions we care for, this could be culled.

Also does not block this patch.

> warn_unused_ignores: Needed once upon a time for cross-version mypy suppo=
rt
> where some versions would warn in some cases and others would not. Adding
> an ignore would effectively just invert which versions complained. Probab=
ly
> still needed, but it's hard to measure.

Harmless enough.

> python_version: Changes mypy behavior regardless of the invoking python
> interpreter to check the file as if it were to be executed by Python 3.8.=
 I
> actually want to remove this value from setup.cfg but haven't yet. I
> removed it from the python-qemu-qmp repo and never added it for qapi.
> Removing it is actually probably correct as it will catch errors specific
> to various python versions we support, but there are some nits to iron out
> in my neck of the woods. This is a case where scripts/qapi/ is stricter
> than python/ :)
> (Not reasonable to solve for this series.)

Also present in the deleted file, so no change.

> lack of disallow_untyped_calls =3D False: I think this might be a remnant
> from when we gradually typed qapi; it's evidently no longer needed since
> qapi still checks fine without this affordance. The default under strict =
is
> True.

Fair enough.

> e941c844e444 (John Snow                   2021-05-27 17:17:05 -0400  79)
> [mypy]
> e941c844e444 (John Snow                   2021-05-27 17:17:05 -0400  80)
> strict =3D True
> ca056f4499c2 (Paolo Bonzini               2023-05-03 12:48:02 +0200  81)
> python_version =3D 3.8
> e941c844e444 (John Snow                   2021-05-27 17:17:05 -0400  82)
> warn_unused_configs =3D True
> 0542a4c95767 (John Snow                   2021-05-27 17:17:06 -0400  83)
> namespace_packages =3D True
> e7874a50ff3f (John Snow                   2022-05-25 20:09:13 -0400  84)
> warn_unused_ignores =3D False
>
>
>>
>> python/setup.cfg additionally has a bunch of ignore_missing_imports that
>> don't apply here, as far as I can tell.
>>
>
> Right, that's all stuff for fuse and the interactive qmp shell that use
> untyped dependencies.

Good.

Let's mention the differences in the commit message.  Here's my try:

    Since the previous commit, python/setup.cfg applies to scripts/qapi/
    as well.  Configuration files in scripts/qapi/ override
    python/setup.cfg.

    scripts/qapi/.flake8 and scripts/qapi/.isort.cfg actually match
    python/setup.cfg exactly, and can go.

    The differences between scripts/qapi/mypy.ini and python/setup.cfg
    are harmless: [list the differences, explain why they're harmless as
    long as you can keep it brief, and if not, fall back to "trust me"].
    So scripts/qapi/mypy.ini can go, too.

    The pylint config is being left in place because the settings differ
    enough from the python/ directory settings that we need a chit-chat on
    how to merge them O:-)

With something like that
Reviewed-by: Markus Armbruster <armbru@redhat.com>


