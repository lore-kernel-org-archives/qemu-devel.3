Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34224EA810F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnS5-0006cv-S1; Tue, 10 Feb 2026 08:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpnS0-0006cQ-K4
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:06:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpnRs-0003ll-FL
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770728794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zw1pLKMRRyoFXYL+yDYEacnY/yXG+UeRh6B3FmT3j4M=;
 b=fB9qKzeqYyUympH9anGvhytqh7x6I+JyRX3RPpk936zVjpdc/3NQhnAEv1Bt2EDlpn53gk
 cr9rYgSxS3vAhRfLOqx/df8+kk7kD0n8K5cSVEHpAYSZrcRG6+9JeA/LhanCL0AkfNFXDB
 I9Z8N4EBlX+rGFyg1+suHhuEbGy2nlY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-NETD3BRzPW-Isy7DmBdnxQ-1; Tue,
 10 Feb 2026 08:06:33 -0500
X-MC-Unique: NETD3BRzPW-Isy7DmBdnxQ-1
X-Mimecast-MFC-AGG-ID: NETD3BRzPW-Isy7DmBdnxQ_1770728791
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 361211956095
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:06:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E76D630001A5
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:06:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6106421E692D; Tue, 10 Feb 2026 14:06:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/5] qobject: switch JSON parser to push
In-Reply-To: <CABgObfYD6cLmN_qgmro-O2wUPqnqTn3ZUYntbPrFQkX0xE=8AQ@mail.gmail.com>
 (Paolo Bonzini's message of "Fri, 30 Jan 2026 14:36:40 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <87ldhffe79.fsf@pond.sub.org>
 <CABgObfYD6cLmN_qgmro-O2wUPqnqTn3ZUYntbPrFQkX0xE=8AQ@mail.gmail.com>
Date: Tue, 10 Feb 2026 14:06:28 +0100
Message-ID: <87o6lw7nor.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Il ven 30 gen 2026, 14:00 Markus Armbruster <armbru@redhat.com> ha scritt=
o:
>
>> > Another benefit is that QEMU can report the first parsing error
>> > immediately, without waiting for delimiters to be balanced.
>>
>> Sounds promising!  Let's see...
>>
>> Before the series:
>>
>>      $ socat "READLINE,prompt=3DQMP> " UNIX-CONNECT:$HOME/work/images/te=
st-qmp
>>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 10},=
 "package": "v10.2.0-567-gfb6b66de43-dirty"}, "capabilities": ["oob"]}}
>>     QMP> [{"a"]
>>
>> Parse error not diagnosed right away, but ...
>>
>>     QMP> }
>>     {"error": {"class": "GenericError", "desc": "JSON parse error, missi=
ng : in object pair"}}
>>
>> .... only when the streamer decides the expression is complete.
>>
>> After the series:
>>
>>     QMP> [{"a"]
>>     {"error": {"class": "GenericError", "desc": "JSON parse error at lin=
e 1, column 6, expecting ':'"}}
>>
>> Cool!  However, if I do it again, things fall apart:
>>
>>     QMP> [{"a"
>>     QMP> }
>>     QMP> }
>>     QMP> }
>>     QMP> ]
>>     QMP> ]
>>     {"error": {"class": "GenericError", "desc": "JSON parse error at lin=
e 7, column 1, expecting value"}}
>>
>> Parse error recovery not quite right?
>
> Well, if you read the above very carefully :) the error is *reported*
> immediately, but recovery still waits for delimiters to be balanced.

Yes, but the recovery regressed a bit.

Having read the entire series now, I wonder whether it's related to
capping @brace_count and @bracket_count at zero [PATCH 3].

My example input [{"a"] puts the parser in error recovery state with
brace_count =3D=3D 1, bracket_count =3D=3D 0.  Your parser will silently th=
row
away further input until brace_count drops to zero.

The old parser additionally snaps out of this unresponsive state when
bracked_count goes negative.

> In testing, when I got an error I just typed a long enough variant on
> "]}]}]}" and that is enough to recover=E2=80=94just like in the old parse=
r.

With the old parser, I can park my finger on ']' or '}' for a moment,
hit return, and be good.  With the new one, I have to park on both.

More seriously, the new parser seems to break a recovery technique
documented in docs/interop/qmp-spec.rst:

    Forcing the JSON parser into known-good state
    ---------------------------------------------

    Incomplete or invalid input can leave the server's JSON parser in a
    state where it can't parse additional commands.  To get it back into
    known-good state, the client should provoke a lexical error.

    The cleanest way to do that is sending an ASCII control character
    other than ``\t`` (horizontal tab), ``\r`` (carriage return), or
    ``\n`` (new line).

Works with old parser:

    QMP> [{"a"]
    QMP> ^L
    {"error": {"class": "GenericError", "desc": "JSON parse error, stray '\=
f'"}}
    QMP> {}
    {"error": {"class": "GenericError", "desc": "QMP input lacks member 'ex=
ecute'"}}

Note: the ^L is a formfeed character.

New parser:

    QMP> [{"a"]
    {"error": {"class": "GenericError", "desc": "JSON parse error at line 1=
, column 6, expecting ':'"}}
    QMP> ^L
    QMP> {}

Good: the parse error is reported immediately.

Bad: the formfeed no longer forces the parser into known-good state.
This needs fixing.

>                                                                     Still
> the difference in error reporting matters, because it gives feedback that
> is immediately useful, rather than possibly delayed forever.

Reporting parse errors immediately is such a lovely quality of life
improvement.  May I have that without regressing error recovery?

> The policy is easy to change, either in v2 or in subsequent work, because
> recovery is layered on top of json-parser and its code is nothing more th=
an
> "if you believe it's a good time to recover, reset the parser".
>
> Paolo

>> > On top of the benefits intrinsic in the push architecture, it so happe=
ns
>> > that it's really easy to add a location to JSON parsing errors now, so
>> > do that as well.
>> >
>> > Paolo
>>
>>


