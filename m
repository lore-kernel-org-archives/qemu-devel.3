Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB20C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 15:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tskTE-0000w7-VV; Thu, 13 Mar 2025 11:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tskTD-0000vV-3L
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tskTA-0002KF-Gw
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741879655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OkcTmdZ2iH379L7yTW7UmBizUVlQYlhzVJpqOoDPL0=;
 b=CefH41C8A+LsHrw8nLXJNqzWT21xkh6LYRAsj87ZsLV4EqVbjCGHph9vsOzqvlQWYThKaL
 g/3N0NrFwXEio8dIAzRBaEKLsF/7o/IIG0BYmhYUnQGVCI5cMpfMPphqGtDf9Jlt8CdYlf
 M3W41ZFBFYAaEVaKao6QF2AManxmVuE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600--Rj1Pv2ZMmCTgE7gBvRj_A-1; Thu,
 13 Mar 2025 11:27:33 -0400
X-MC-Unique: -Rj1Pv2ZMmCTgE7gBvRj_A-1
X-Mimecast-MFC-AGG-ID: -Rj1Pv2ZMmCTgE7gBvRj_A_1741879652
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BF5A195605A; Thu, 13 Mar 2025 15:27:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63C781828A83; Thu, 13 Mar 2025 15:27:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D14CE21E66C4; Thu, 13 Mar 2025 16:27:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 11/11] docs: enable transmogrifier for QSD and QGA
In-Reply-To: <CAFn=p-YBB-Qvmm4Tw2Kq4gNwLrjgY8-_sw7ZJAYnakQ7MDhc-Q@mail.gmail.com>
 (John Snow's message of "Thu, 13 Mar 2025 10:02:21 -0400")
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-12-jsnow@redhat.com>
 <87y0x9cte4.fsf@pond.sub.org>
 <CAFn=p-YBB-Qvmm4Tw2Kq4gNwLrjgY8-_sw7ZJAYnakQ7MDhc-Q@mail.gmail.com>
Date: Thu, 13 Mar 2025 16:27:26 +0100
Message-ID: <87ldt93q8x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Thu, Mar 13, 2025 at 2:54=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This also creates the `qapi-qsd-index` and `qapi-qga-index` QMP indice=
s.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> [...]
>>
>> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> > index 995594aaf43..35ec0e7db31 100644
>> > --- a/qga/qapi-schema.json
>> > +++ b/qga/qapi-schema.json
>> > @@ -3,6 +3,9 @@
>> >
>> >  ##
>> >  # =3D QEMU guest agent protocol commands and structs
>> > +#
>> > +# For a concise listing of all commands, events, and types in the QEMU
>> > +# guest agent, please consult the `qapi-qga-index`.
>> >  ##
>> >
>> >  { 'pragma': { 'doc-required': true } }
>> > diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qap=
i/qapi-schema.json
>> > index f10c9494906..2a562ee32e5 100644
>> > --- a/storage-daemon/qapi/qapi-schema.json
>> > +++ b/storage-daemon/qapi/qapi-schema.json
>> > @@ -13,6 +13,14 @@
>> >  # the array type in the main schema, even if it is unused outside of =
the
>> >  # storage daemon.
>> >
>> > +##
>> > +# =3D QEMU storage daemon protocol commands and structs
>> > +#
>> > +# For a concise listing of all commands, events, and types in the QEMU
>> > +# storage daemon, please consult the `qapi-qsd-index`.
>> > +##
>> > +
>> > +
>> >  { 'include': '../../qapi/pragma.json' }
>> >
>> >  # Documentation generated with qapi-gen.py is in source order, with
>>
>> Compare qapi/qapi-schema.json:
>>
>>    # =3D Introduction
>>    #
>>    # This document describes all commands currently supported by QMP.
>>    #
>>    # For locating a particular item, please see the `qapi-qmp-index`.
>>    #
>>
>> Suggest to pick one phrasing and stick to it, unless there's a reason
>> for more than one.
>>
>
> Nope, just free-handing it. What's your favorite? ;)

Let me see...

Alright, I saw, and I hate what I saw.  But addressing that should not
be coupled to this series.  I'm going to take your patch as is, and
improve on top.

"But what exactly do you hate?" you might ask.  Have a look at how the
three rendered manuals look like.

1. QMP (docs/manual/interop/qemu-qmp-ref.html)

    QEMU QMP Reference Manual
    *************************


    Contents
    ^^^^^^^^

    * QEMU QMP Reference Manual

      * Introduction

      * QMP errors

      [More entries at this level, namely all the modules...]


    Introduction
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    This document describes all commands currently supported by QMP.

    For locating a particular item, please see the QMP Index.

    Most of the time their usage is exactly the same as in the user
    Monitor, this means that any other document which also describe
    commands (the manpage, QEMU's manual, etc) can and should be
    consulted.

    QMP has two types of commands: regular and query commands.  Regular
    commands usually change the Virtual Machine's state someway, while
    query commands just return information.  The sections below are
    divided accordingly.

    It's important to observe that all communication examples are
    formatted in a reader-friendly way, so that they're easier to
    understand.  However, in real protocol usage, they're emitted as a
    single line.

    Also, the following notation is used to denote data flow:

    Example:

       -> data issued by the Client
       <- Server data response

    Please refer to the QEMU Machine Protocol Specification for detailed
    information on the Server command and response formats.


    QMP errors
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    [...]

The manual has a single top-level section, named like the manual.  WTF?

The introduction reads fine, except it should be "all commands and
events".

2. QSD

    QEMU Storage Daemon QMP Reference Manual
    ****************************************


    Contents
    ^^^^^^^^

    * QEMU Storage Daemon QMP Reference Manual

      * QEMU storage daemon protocol commands and structs

      * Common data types

      [More entries at this level, namely all the modules...]


    QEMU storage daemon protocol commands and structs
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

    For a concise listing of all commands, events, and types in the QEMU
    storage daemon, please consult the QSD Index.


    Common data types
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Same section structure WTF as above.

The introduction section is crap, starting with the title.

3. QGA

    QEMU Guest Agent Protocol Reference
    ***********************************


    Contents
    ^^^^^^^^

    * QEMU Guest Agent Protocol Reference

      * QEMU guest agent protocol commands and structs


    QEMU guest agent protocol commands and structs
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    For a concise listing of all commands, events, and types in the QEMU
    guest agent, please consult the QGA Index.

    Command guest-sync-delimited (Since: 1.1)

       Echo back a unique integer value, and prepend to response a leading
       sentinel byte (0xFF) the client can check scan for.

       [...]

    [More definitions...]

The section structure is completely useless.  Why bury the contents two
levels deep, with meaningless section titles?

Again, the introduction section is crap, starting with the title.


