Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA12C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 08:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJUWJ-00006z-3j; Tue, 18 Jun 2024 04:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJUWH-00006I-KD
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 04:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJUWG-00053s-0K
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 04:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718700527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHlu9laU4jTEsJvvo6frCAw2VVu9BPmy47QavXtLFRU=;
 b=iP8AcP0WUX4/s4FsIVbu5MQ2uN1sJuqNHXEszQ1wWXfs/vWK29SZRxu7XTEYjB25BKGoyq
 3xKN+1R8MCpb7SnL3b8quOc9SupW6hsCD+3byvzsDZ2pqYXxq14QPgQBsxE/NLHP1Vwxcg
 uaoKz38XrKUmJZoI2JkxKAKa4ylKcbQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-pAu4QOKAOT6tSAp8Q3RW0w-1; Tue,
 18 Jun 2024 04:48:42 -0400
X-MC-Unique: pAu4QOKAOT6tSAp8Q3RW0w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90D5419560B3; Tue, 18 Jun 2024 08:48:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D42E1956087; Tue, 18 Jun 2024 08:48:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D20B21E6621; Tue, 18 Jun 2024 10:48:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Ani Sinha <anisinha@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  Kevin Wolf <kwolf@redhat.com>,  Jiri Pirko
 <jiri@resnulli.us>,  Mads Ynddal <mads@ynddal.dk>,  Jason Wang
 <jasowang@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Qemu-block <qemu-block@nongnu.org>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Konstantin Kostiuk
 <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,  Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 14/20] qapi: fix non-compliant JSON examples
In-Reply-To: <CAFn=p-YKEnSW=EOqJGz=vne7FCh-4xth4eGtCKrp2ywEzdVTtQ@mail.gmail.com>
 (John Snow's message of "Mon, 17 Jun 2024 13:52:56 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-15-jsnow@redhat.com>
 <87frtf3iad.fsf@pond.sub.org>
 <CAFn=p-YKEnSW=EOqJGz=vne7FCh-4xth4eGtCKrp2ywEzdVTtQ@mail.gmail.com>
Date: Tue, 18 Jun 2024 10:48:31 +0200
Message-ID: <87frtaab6o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> On Fri, Jun 14, 2024, 6:55=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > If we parse all examples as QMP, we need them to conform to a standard
>> > so that they render correctly. Once the QMP lexer is active for
>> > examples, these will produce warning messages and fail the build.
>> >
>> > The QMP lexer still supports elisions, but they must be represented as
>> > the value "...", so two examples have been adjusted to support that
>> > format here.
>>
>> I think this could use a bit more context.  I believe you're referring
>> to docs/sphinx/qmp_lexer.py.  It describes itself as "a Sphinx extension
>> that provides a QMP lexer for code blocks."
>>
>
> That's our guy! I explain its use a bit more in ... some other patch,
> somewhere...
>
>
>> "If we parse all examples as QMP" and "Once the QMP lexer is active for
>> examples" suggests we're *not* using it for (some?) examples.  So what
>> are we using it for?
>>
>
> My incremental backup doc makes use of it; you have to "opt in" to using
> the QMP lexer instead of the generic lexer.

The ".. code-block:: QMP" lines I can see in a few files?  Namely:

    docs/devel/s390-cpu-topology.rst
    docs/interop/bitmaps.rst
    docs/interop/qmp-spec.rst

> The example conversion patch later in this series opts all of the qapi do=
cs
> into using it.
>
> ((Later, it's possible to make "Example::" choose the QMP lexer by default
> on any of our generated QMP pages. (and opting out would require explicit
> code-block syntax with the lexer of choice named.)))

The patch does two related things:

1. Fix invalid JSON.  Doesn't need justification.

2. Normalize elisions to ...  You pick ... because that's what
   qmp_lexer.py wants.

Doing both in one patch is fine.

Perhaps

    qapi: Fix invalid JSON in examples, and normalize elisions

    A few examples elide part of the output.  Normalize elision to
    exactly ...  Together with the JSON fixing, this enables use of
    docs/sphinx/qmp_lexer.py to highlight the examples in a later patch.

>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> Patch looks lovely.
>>
>> Hat tip to Victor Toso, who fixed up most examples two years ago.  Back
>> then we couldn't decide how to do elisions, so we left some unfixed.
>>
>
> Sorry I didn't chime in back then! "..." is arbitrary, but it's what we
> already use for the qmp lexer and in the incremental backup/bitmap docs, =
so
> I figured consistency was good.

It is.

> The QMP lexer has syntax support for ->, <- and ... and otherwise requires
> the examples to be valid JSON. It doesn't understand grammar, though, so
> it's kind of "dumb", but this is one small protection.


