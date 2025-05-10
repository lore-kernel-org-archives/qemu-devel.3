Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F577C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDe9j-0004I7-L0; Sat, 10 May 2025 02:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uDe9h-0004Ce-Lt
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uDe9e-0002kc-SZ
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746860268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Ac08YkznWl+XZqkjo3ZhwohqKDN1orNzJcb1FQnR40=;
 b=SW73PTH4BgSqI5Ta2ToZBRYZxxUwMN/RxWpHWAYVahiU+j7e4+t4bW5te2tcZ9NhH7lSda
 1pMYn9O8wt3mwFskOhauUEV5McISNWGnWag2MW2d9O/GsB4ZHPKgheD8DBxU123Lt3wGzj
 FuOg781rzUQ3hCcox1InJe4KflR+76k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-t-R66p_WO1eoPM_DKDCRbw-1; Sat,
 10 May 2025 02:57:45 -0400
X-MC-Unique: t-R66p_WO1eoPM_DKDCRbw-1
X-Mimecast-MFC-AGG-ID: t-R66p_WO1eoPM_DKDCRbw_1746860263
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86C99180045B; Sat, 10 May 2025 06:57:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9B731953963; Sat, 10 May 2025 06:57:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60D8F21E66C2; Sat, 10 May 2025 08:57:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 alex.bennee@linaro.org,  stefanha@redhat.com,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  pbonzini@redhat.com,  jsnow@redhat.com,
 philmd@linaro.org,  thuth@redhat.com,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 09/13] qapi: transform target specific 'if' in runtime
 checks
In-Reply-To: <aBzCXNTebh8B5sQ_@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 8 May 2025 15:40:28 +0100")
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-10-pierrick.bouvier@linaro.org>
 <aBzCXNTebh8B5sQ_@redhat.com>
Date: Sat, 10 May 2025 08:57:40 +0200
Message-ID: <87msbl0x7f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, May 07, 2025 at 04:14:39PM -0700, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  qapi/machine-target.json | 84 ++++++++++++++++++++++++----------------
>>  qapi/misc-target.json    | 48 ++++++++++++-----------
>>  scripts/qapi/expr.py     |  9 +++--
>>  3 files changed, 81 insertions(+), 60 deletions(-)
>>=20
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index 541f93eeb78..6174b7291ca 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -96,7 +96,7 @@
>>  ##
>>  { 'struct': 'CpuModelBaselineInfo',
>>    'data': { 'model': 'CpuModelInfo' },
>> -  'if': 'TARGET_S390X' }
>> +  'runtime_if': 'target_s390x()' }
>
> The existing 'if' conditions are already slightly uncomfortable
> for QAPI when considering alternate code generators, because the
> definition of what  "CONFIG_xxx" or "TARGET_xxx" condition means,
> is essentially known only to our build system. While we expose
> the conditions in the docs, the meaning of those conditions is
> totally opaque to anyone reading the docs. Essentially our QAPI
> schema ceased to be self-documenting/self-describing when we
> introduced the 'if' conditions :-(
>
>
> In retrospect, IMHO, for 'if' conditions we probably should have
> created some kind of built-in QAPI concept of feature flag constants
> with well defined & documented meaning.=20
>
> eg hypothetically
>
>   ##
>   # @target-s390x
>   #
>   # Whether this is an s390x emulator target
>   { 'constant': 'target-s390x' }
>
>   ##
>   # @accel-kvm
>   #
>   # Whether the KVM accelerator is built
>   { 'constant': 'accel-kvm' }
>
> Then our 'if' conditions would have only been permitted to
> reference defined 'constant'.
>
>   { 'struct': 'CpuModelCompareInfo',
>     'data': { 'result': 'CpuModelCompareResult',
>               'responsible-properties': ['str'] },
>     'if': 'target-s390x' }

This adds mandatory declaration of identifiers used in conditions to the
QAPI schema language.

The declarations can then serve as hooks for doc comments.  These should
ineed result in a more complete and useful generated manual.  John,
thoughts?

The condition documentation would supplement / partially duplicate the
configure flag documentation in meson_options.txt.

We'd need to tie the two together to make the code work (see your next
paragraph).  We should also tie their documentation together somehow.
Feels like a solvable problem.

> The build system would need generate an input document for the
> QAPI visitor that defines whether each constant is set to true
> or false, based on suitable CONFIG/TARGET conditions from meson.

I think the conditions that are evaluated at build time in handwritten C
code (with #if) should also be evaluated at build time in generated C
code.

Certain conditions are evaluated at build time in target-specific code,
and at runtime in target-independent code.  Again, I think handwritten
and generated code should work the same way.

Thus, to eliminate target-specific QAPI-generated code, we either
evaluate them at runtime, or simply eliminate them.  Elsewhere, we've
come to the conclusion (I think) that the latter should do at least for
now, likely forever, so we should try that first.

> With this QAPI schemas would have remained fully self-contained.

Fortunately, this is merely a matter of filling a gap we left, not a
matter of replacing a fundamentally flawed design.

> Anyway, this is a long way of saying that having 'runtime_if'
> conditions directly referencing the names of internal C
> functions makes me even more uncomfortable than I already am
> with the 'if' conditions.
>
> The meaning of the QAPI schema now varies based on both the build
> system, and an arbitrary amount of C, and is thus (conceptually)
> even more opaque, even if you could infer some meaning from the
> 'target_s390x()' function name you've used. I think this is a very
> undesirable characteristic for what is our public API definition.

I don't see much of a difference, to be honest.

Both kinds of conditionals have the exact same argument structure:
expression tree where the leaves are identifiers.

The meaning of these identifiers is not documented in the QAPI schema
now, and barely documented in the code.

This defect could be remedied the exact same way whether the identifiers
are preprocessor macros or function names.

I actually find another argument of yours (not repeated above) more
compelling: that certain aspects of the external interface should not
vary at runtime.


