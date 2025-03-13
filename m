Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A2AC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 14:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsjk5-0000Wb-AJ; Thu, 13 Mar 2025 10:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsjju-0000VF-Kh
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 10:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsjjs-0003Mb-Iz
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 10:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741876846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MKdHi9NNWtq/Jb1PksEUmfpcjmiG2ZfM21KTZr04FS4=;
 b=dSfgQo6UPNHSUIXmcKV7DiBfLY/W49KSo4s16NKv2RUPXFp7AwqLlrZwNEdyL6lvr3AYr1
 dMhJeFIMulQEo4jT+rXEIJgwzsUwe8dTaOx53+u4G8fXe4yJwsUaQink6gM+qVrAYEzzG7
 EhaSAR8HsMwZS5tNy/emBbrQgvpWQc8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-aAlvsZCxOYOrbjAoHP55JA-1; Thu,
 13 Mar 2025 10:40:45 -0400
X-MC-Unique: aAlvsZCxOYOrbjAoHP55JA-1
X-Mimecast-MFC-AGG-ID: aAlvsZCxOYOrbjAoHP55JA_1741876844
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDF7219560BC; Thu, 13 Mar 2025 14:40:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A9C71801762; Thu, 13 Mar 2025 14:40:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 03BD621E66C1; Thu, 13 Mar 2025 15:40:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 07/11] docs/qapi_domain: add namespace support to
 cross-references
In-Reply-To: <CAFn=p-b2LUBzn-JE6P41wCxnW-vAB1moHWcw66d9Ta=tt_H1gQ@mail.gmail.com>
 (John Snow's message of "Thu, 13 Mar 2025 09:58:31 -0400")
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-8-jsnow@redhat.com>
 <8734fhe8ag.fsf@pond.sub.org>
 <CAFn=p-b2LUBzn-JE6P41wCxnW-vAB1moHWcw66d9Ta=tt_H1gQ@mail.gmail.com>
Date: Thu, 13 Mar 2025 15:40:36 +0100
Message-ID: <87ikod56zf.fsf@pond.sub.org>
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

> On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This patch does three things:
>> >
>> > 1. Record the current namespace context in pending_xrefs so it can be
>> >    used for link resolution later,
>> > 2. Pass that recorded namespace context to find_obj() when resolving a
>> >    reference, and
>> > 3. Wildly and completely rewrite find_obj().
>> >
>> > cross-reference support is expanded to tolerate the presence or absence
>> > of either namespace or module, and to cope with the presence or absence
>> > of contextual information for either.
>> >
>> > References now work like this:
>> >
>> > 1. If the explicit reference target is recorded in the domain's object
>> >    registry, we link to that target and stop looking. We do this lookup
>> >    regardless of how fully qualified the target is, which allows direct
>> >    references to modules (which don't have a module component to their
>> >    names) or direct references to definitions that may or may not belo=
ng
>> >    to a namespace or module.
>> >
>> > 2. If contextual information is available from qapi:namespace or
>> >    qapi:module directives, try using those components to find a direct
>> >    match to the implied target name.
>> >
>> > 3. If both prior lookups fail, generate a series of regular expressions
>> >    looking for wildcard matches in order from most to least
>> >    specific. Any explicitly provided components (namespace, module)
>> >    *must* match exactly, but both contextual and entirely omitted
>> >    components are allowed to differ from the search result. Note that =
if
>> >    more than one result is found, Sphinx will emit a warning (a build
>> >    error for QEMU) and list all of the candidate references.
>> >
>> > The practical upshot is that in the large majority of cases, namespace
>> > and module information is not required when creating simple `reference=
s`
>> > to definitions from within the same context -- even when identical
>> > definitions exist in other contexts.
>>
>> Can you illustrate this this examples?
>>
>
> do wha?

Sorry, I went into the curve too fast.

The stuff under "References now work like this" confuses me.  I guess it
describes a series of lookups to try one after the other.

I understand a cross-reference consists of namespace (optional), module
(optional), name, and role.

Let's assume role is "any" for simplicity's sake.

Regarding "1. If the explicit ...":

    What is a reference's "explicit reference target"?  Examples might
    help me understand.

    What is "recorded in the domain's object registry"?

    Can you show me a reference where this lookup succeeds?

Regarding "2. If contextual information ...":

    I guess "contextual information" is the context established by
    qapi:namespace and qapi:module directives, i.e. the current
    namespace and module, if any.

    If the cross reference lacks a namespace, we substitute the current
    namespace.  Same for module.

    We then use that "to find a direct match to the implied target
    name".  Sounds greek to me.  Example(s) might help.

Regarding "3. If both prior lookups fail ...":

    I guess we get here when namespace or module are absent, and
    substituting the current namespace or module doesn't resolve.  We
    then substitute a wildcard, so to speak, i.e. look in all namespaces
    / modules, and succeed if we find exactly one resolution.  Fair?

[...]


