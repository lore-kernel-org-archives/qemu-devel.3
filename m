Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2DBC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbfMx-0007Jo-3q; Wed, 07 Aug 2024 08:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbfMQ-00077g-GS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbfML-0006OT-1E
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723032099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OvNl7eEjmY1ItI/iTJbyr7s5KzzeYJZgmWgUrg/01Q=;
 b=e9d1y8ZuRnce4Um1F0XeJDl1CoG1G0Uig3Lo7ci1O/yNRY4PM2bq8Xt/D6H6atsqOeeahM
 44f2UMazxqdhxOkD3hWkhLX1vvRUDhk/yiHUKsQumWS0nx3FwyZXvWao7JHfoVTrz6H/fA
 CbIlhdjmcLPn0QT80qv+LA/U1EBCDiI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-bHgOzIvvMBu8J63fKJhoWQ-1; Wed,
 07 Aug 2024 08:01:35 -0400
X-MC-Unique: bHgOzIvvMBu8J63fKJhoWQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 712511977035; Wed,  7 Aug 2024 12:01:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C358619560A7; Wed,  7 Aug 2024 12:01:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C83B621E668F; Wed,  7 Aug 2024 14:01:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] qapi: Generate QAPI files using qapi/ for generated
 header paths
In-Reply-To: <ZrNZmFL_HjuKrque@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 7 Aug 2024 12:25:12 +0100")
References: <20240807093406.40360-1-philmd@linaro.org>
 <ZrNB5C7Ta-Qg-9HT@redhat.com> <87ttfwwqrx.fsf@pond.sub.org>
 <ZrNTxb8go0xqfE3R@redhat.com> <8734ngwpca.fsf@pond.sub.org>
 <ZrNZmFL_HjuKrque@redhat.com>
Date: Wed, 07 Aug 2024 14:01:31 +0200
Message-ID: <87ed70v8x0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Wed, Aug 07, 2024 at 01:21:25PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Wed, Aug 07, 2024 at 12:50:26PM +0200, Markus Armbruster wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> [...]
>>=20
>> >> > It is confusing that we have both shared stuff and QMP schema
>> >> > only stuff under the same location.
>> >>=20
>> >> Which stuff in which location?
>> >
>> > There are multiple directories with 'qapi' in their name
>> >
>> >  - $SRC/include/qapi - all generic stuff for any consumer of QAPI
>> >  - $SRC/qapi - impl of generic stuff from $SRC/include/qapi, but
>> >                also the QMP schema for machine emulator
>> >  - $BUILD/qapi - generated code for QMP schema for machine emulator
>>=20
>>    - scripts/qapi - the generator code
>>=20
>> >
>> > I find it confusing that we have both generic QAPI code and the main
>> > machine emulator QMP schema in directories sharing the same 'qapi'
>> > name.
>>=20
>> Got it.
>>=20
>> Lack of separation between generic C infrastructure and specific schema
>> hasn't really annoyed me.  Possibly because the two are, for better or
>> worse, joined at the hip.  Except for the use of "qapi:" in commit
>> message titles; there I've at times felt a slight urge to distinguish
>> between schema work, C infrastructure work, and generator work.
>>=20
>> Of course, other people's confusion trumps my non-annoyance.
>
> When we first introduced the QAPI/QMP schema for system emulator of
> course it was fine, since we didn't have QGA usage.

Actually, qga's QAPI schema (commit e3d4d25206a) predates the main QAPI
schema (commit e3193601c84) by a few weeks.

>                                                     Now days we have
> a dedicate $SRCDIR/system directory for the system emulators, so I
> wonder if its worth putting the system emulator schemas in there
> instead ? Caveat is that the QSD also uses some of this schema.

Another caveat is that much QAPI code, both infrastructure and
generated, has bled into programs other than qemu-system-FOO.

$ gdb -batch -ex "info sources" bld/qemu-i386 | tr ',' '\012' | sed -n '/qa=
pi/s,^.*/qemu/,,p'
bld/qapi/qapi-types-machine-common.h
bld/qapi/qapi-types-machine.h
include/qapi/util.h
bld/qapi/qapi-builtin-types.h
bld/qapi/qapi-types-error.h
bld/qapi/qapi-types-common.h
bld/qapi/qapi-types-run-state.h
include/qapi/error.h
bld/qapi/qapi-visit-machine.h
include/qapi/visitor.h
bld/qapi/qapi-builtin-visit.h
bld/qapi/qapi-types-replay.h
include/qapi/qmp/qobject.h
include/qapi/qmp/qlist.h
include/qapi/qmp/qdict.h
bld/qapi/qapi-events-qdev.h
include/qapi/qmp/qbool.h
include/qapi/qmp/qnum.h
include/qapi/qmp/qstring.h
include/qapi/forward-visitor.h
include/qapi/string-output-visitor.h
include/qapi/string-input-visitor.h
include/qapi/qobject-input-visitor.h
bld/qapi/qapi-types-authz.h
bld/qapi/qapi-types-crypto.h
bld/qapi/qapi-types-sockets.h
bld/qapi/qapi-types-block-core.h
bld/qapi/qapi-types-qom.h
include/qapi/qmp/qjson.h
bld/qapi/qapi-visit-qom.h
include/qapi/qobject-output-visitor.h
bld/qapi/qapi-builtin-visit.c
bld/qapi/qapi-types-common.c
bld/qapi/qapi-visit-common.h
include/qapi/dealloc-visitor.h
bld/qapi/qapi-visit-common.c
bld/qapi/qapi-visit-machine.c
bld/qapi/qapi-visit-machine-common.h
bld/qapi/qapi-types-qom.c
bld/qapi/qapi-visit-qom.c
bld/qapi/qapi-visit-crypto.h
bld/qapi/qapi-visit-block-core.h
bld/qapi/qapi-visit-authz.h
bld/qapi/qapi-visit-sockets.h
bld/qapi/qapi-visit-sockets.c
bld/qapi/qapi-events-qdev.c
bld/qapi/qapi-emit-events.h
bld/qapi/qapi-types-qdev.h
bld/qapi/qapi-visit-qdev.h
include/qapi/compat-policy.h
include/qapi/qmp-event.h
qapi/qapi-dealloc-visitor.c
include/qapi/qmp/qnull.h
include/qapi/visitor-impl.h
bld/qapi/qapi-types-compat.h
qapi/qapi-forward-visitor.c
qapi/qapi-util.c
qapi/qapi-visit-core.c
bld/trace/trace-qapi.h
qapi/trace-events
bld/trace/trace-dtrace-qapi.h
qapi/qobject-input-visitor.c
qapi/qobject-output-visitor.c
qapi/string-input-visitor.c
qapi/string-output-visitor.c
qapi/qmp-dispatch.c
include/qapi/qmp/dispatch.h
qapi/qmp-event.c
qapi/qmp-registry.c
include/qapi/qmp/json-parser.h
include/qapi/qmp/json-writer.h
bld/qapi/qapi-builtin-types.c
bld/qapi/qapi-visit-authz.c
bld/qapi/qapi-visit-block-core.c
bld/qapi/qapi-types-job.h
bld/qapi/qapi-visit-job.h
bld/qapi/qapi-visit-crypto.c
bld/qapi/qapi-types-error.c
bld/qapi/qapi-visit-job.c
bld/qapi/qapi-visit-machine-common.c
bld/qapi/qapi-types-machine.c
bld/qapi/qapi-types-sockets.c
bld/qapi/qapi-visit-qdev.c
bld/trace/trace-qapi.c
bld/qapi/qapi-types-authz.c
bld/qapi/qapi-types-block-core.c
bld/qapi/qapi-types-crypto.c
bld/qapi/qapi-types-job.c
bld/qapi/qapi-types-machine-common.c


