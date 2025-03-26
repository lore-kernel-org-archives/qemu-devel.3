Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18682C3600D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txL2B-00006Y-7g; Wed, 26 Mar 2025 03:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txL2A-00006L-8G
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txL27-0001mg-LL
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742973517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uwQHziDJY3z9Gf666sFb+zElFtbeincUwyESmH7KZ2Y=;
 b=OwYuDGi3SfPiySUsGSY72LpDyns0thHBQCpdX6ONB7ORLQJRbW9PgPQ/Sagc+LHds0RQCk
 8Efr836ne1DeXZMOPUCzCRyHrvOtEV+KevUihPzeugJ1KaNidhmKL/v1Z+tBw0L1HthQEr
 4c7UgVOBTLrYFREb+jrgLsyUQrlpRaU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-Cfgry2g7M1WSJkhtKV7YbA-1; Wed,
 26 Mar 2025 03:18:31 -0400
X-MC-Unique: Cfgry2g7M1WSJkhtKV7YbA-1
X-Mimecast-MFC-AGG-ID: Cfgry2g7M1WSJkhtKV7YbA_1742973510
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C54F19560AF; Wed, 26 Mar 2025 07:18:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86153180175F; Wed, 26 Mar 2025 07:18:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6B42121E66C5; Wed, 26 Mar 2025 08:18:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Cleber
 Rosa <crosa@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 5/5] qapi: delete un-needed python static analysis configs
In-Reply-To: <CAFn=p-ZMphLO291fDEfSC6M0k6gRerGJb1XzDUdCjYgmS-f7YA@mail.gmail.com>
 (John Snow's message of "Tue, 25 Mar 2025 13:36:36 -0400")
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-6-jsnow@redhat.com>
 <871pulpmbs.fsf@pond.sub.org>
 <CAFn=p-ZMphLO291fDEfSC6M0k6gRerGJb1XzDUdCjYgmS-f7YA@mail.gmail.com>
Date: Wed, 26 Mar 2025 08:18:26 +0100
Message-ID: <87a598dzul.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> On Tue, Mar 25, 2025 at 4:05=E2=80=AFAM Markus Armbruster <armbru@redhat.=
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
>> Also a bunch of [mypy-FOO] sections that don't apply here.
>>
>> You explained the differences in review of a prior iteration.  Recap:
>>
>> } warn_unused_configs: Catches config values that aren't actually recogn=
ized
>> } or used. Was helpful once upon a time when re-arranging the Python
>> } directory to behave like a package to ensure that the conf files were
>> } working correctly.
>>
>> Could this be culled now?
>>
>
> Maybe!
>
>
>>
>> Hmm, according to mypy(1), strict implies warn-unused-configs.
>>
>> The question does not block this patch.
>>
>
> Send me a patch to drop it O:-)

Done:

    [PATCH] python: Drop redundant warn_unused_configs =3D True
    Message-ID: <20250326071203.238931-1-armbru@redhat.com>

>> } namespace_packages: Needed for the python/ directory structure (nested
>> } packages under a namespace, "qemu"). Doesn't impact scripts/qapi at al=
l.
>> } Read up on PEP420 if you are curious. Details in commit message, see b=
elow
>> } if you're still curious.
>>
>> mypy(1) makes me suspect this is the default.  If that's true across the
>> versions we care for, this could be culled.
>>
>> Also does not block this patch.
>>
>
> It definitely wasn't once upon a time. It may still not be true on the
> oldest mypy we currently support. We don't have a clear policy for what
> versions of python libraries we need to support - this is a muddy, gray
> area. So far I just try to avoid breaking support on older versions
> needlessly, but I don't have an upgrade policy.

So what is the oldest mypy we currently support?  Unknown, best effort
to fix any breakage we see?  Wouldn't quite match my dictionary's
definition of "support"...

> If we want to integrate this directly into make check, we'll likely need =
to
> formalize this policy.

My gut feeling: supporting old mypy isn't worth much (if any) trouble.

>> } warn_unused_ignores: Needed once upon a time for cross-version mypy su=
pport
>> } where some versions would warn in some cases and others would not. Add=
ing
>> } an ignore would effectively just invert which versions complained. Pro=
bably
>> } still needed, but it's hard to measure.
>>
>> Harmless enough.
>>
>> } python_version: Changes mypy behavior regardless of the invoking python
>> } interpreter to check the file as if it were to be executed by Python 3=
.8. I
>> } actually want to remove this value from setup.cfg but haven't yet. I
>> } removed it from the python-qemu-qmp repo and never added it for qapi.
>> } Removing it is actually probably correct as it will catch errors speci=
fic
>> } to various python versions we support, but there are some nits to iron=
 out
>> } in my neck of the woods. This is a case where scripts/qapi/ is stricter
>> } than python/ :)
>> } (Not reasonable to solve for this series.)
>>
>> Also present in the deleted file, so no change.
>>
>> } lack of disallow_untyped_calls =3D False: I think this might be a remn=
ant
>> } from when we gradually typed qapi; it's evidently no longer needed sin=
ce
>> } qapi still checks fine without this affordance. The default under stri=
ct is
>> } True.
>>
>> Fair enough.
>>
>> Let's mention the differences in the commit message.  Here's my try:
>>
>>     Since the previous commit, python/setup.cfg applies to scripts/qapi/
>>     as well.  Configuration files in scripts/qapi/ override
>>     python/setup.cfg.
>>
>>     scripts/qapi/.flake8 and scripts/qapi/.isort.cfg actually match
>>     python/setup.cfg exactly, and can go.
>>
>>     The differences between scripts/qapi/mypy.ini and python/setup.cfg
>>     are harmless: [list the differences, explain why they're harmless as
>>     long as you can keep it brief, and if not, fall back to "trust me"].
>>     So scripts/qapi/mypy.ini can go, too.
>>
>>     The pylint config is being left in place because the settings differ
>>     enough from the python/ directory settings that we need a chit-chat =
on
>>     how to merge them O:-)
>>
>> With something like that
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>
> okey-dokey, let me integrate this feedback and I'll re-send, but I'm going
> to wait until we hash everything else out - you had some questions on oth=
er
> bits in this series.

Thanks!


