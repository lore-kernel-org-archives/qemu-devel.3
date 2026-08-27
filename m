Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809DFC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZrj-0001c7-KX; Thu, 27 Aug 2026 09:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wzZri-0001bS-88
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:09:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wzZrf-0004OR-KF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787836194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgcwSWCrZbRExCG1nDIuragfxt37my/lthRM5rTtvYQ=;
 b=g4HD2po4vLFuX2KbiHuNbN0Fu8VdEW6twV/rGb/owBwrnhC0T4FVb4Sy8o6WnC56LIzkT7
 YE9OdRW9yLpo5psOooAUCy2/lxlW+fAjjKLxXKODEicXRO5ZiyP4Kx3E8WGxz+FGXl+Opr
 3PNTl3SFIZ9O2jJIj2VmylG5evr2emw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-DqGDgh-rM8iDR5_KutU8pw-1; Thu,
 27 Aug 2026 09:09:50 -0400
X-MC-Unique: DqGDgh-rM8iDR5_KutU8pw-1
X-Mimecast-MFC-AGG-ID: DqGDgh-rM8iDR5_KutU8pw_1787836182
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 616F81805A10; Thu, 27 Aug 2026 13:09:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AD7E1955F70; Thu, 27 Aug 2026 13:09:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 830C221E6920; Thu, 27 Aug 2026 15:09:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>,  qemu-devel@nongnu.org,  Alex Williamson
 <alex@shazbot.org>,  linux-cxl@vger.kernel.org,  Michael Tokarev
 <mjt@tls.msk.ru>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,  qemu-trivial@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Jonathan
 Cameron <jic23@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Lukas Straub
 <lukasstraub2@web.de>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 01/43] qapi: convert trivial intro sections for
 error.json
In-Reply-To: <ao_-_38raHK0rWkX@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 27 Aug 2026 10:10:23 +0100")
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-2-jsnow@redhat.com>
 <ao_-_38raHK0rWkX@redhat.com>
Date: Thu, 27 Aug 2026 15:09:35 +0200
Message-ID: <87jypb90c0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Aug 26, 2026 at 03:37:58PM -0400, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  qapi/error.json | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>=20
>> diff --git a/qapi/error.json b/qapi/error.json
>> index 54cb02fb880..a53b13e55c9 100644
>> --- a/qapi/error.json
>> +++ b/qapi/error.json
>> @@ -9,8 +9,7 @@
>>=20=20
>>  ##
>>  # @QapiErrorClass:
>> -#
>> -# QEMU error classes
>> +#     QEMU error classes
>
> Where is this need for indent coming from ?  From the POV of someone
> writing comments, the need to indent the introductory text like this
> feels very counter-intuitive, an exception from any other inline
> docs syntax I've typically used. Is there any way we can avoid this ?

The cover letter explains the need:

    This is being done primarily for the benefit of the forthcoming
    "inliner", a feature for the rendered HTML QMP documentation that
    seeks to "inline" QMP command argument documentation into the argument
    list for each command.

    There are two main motives here:

    (1) We want the split between the "introduction" and "details"
        sections to be mechanically obvious, so that auto-generated or
        inlined documentation has a well-defined, obvious spot to go.

    (2) We do not want to inline irrelevant, introductory text describing
        structures to be copied into command documentation.

But the need actually exists already, the inliner merely grows it.

Let me elaborate using an example: query-memory-size-summary

Its doc comment:

    ##
    # @query-memory-size-summary:
    #
    # Return the amount of initially allocated and present hotpluggable
    # (if enabled) memory in bytes.
    #
    # TODO: This line is a hack to separate the example from the body
    #
    # .. qmp-example::
    #
    #     -> { "execute": "query-memory-size-summary" }
    #     <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 }=
 }
    #
    # Since: 2.11
    ##

Looks like this in the generated QEMU QMP Reference Manual:

    Command query-memory-size-summary (Since: 2.11)

       Return the amount of initially allocated and present hotpluggable
       (if enabled) memory in bytes.

       Return:
          "MemoryInfo"

       Example::

          -> { "execute": "query-memory-size-summary" }
          <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 }=
 }

The "Return:" part is inserted by the generator.  Where?  The order we
want is roughly

    Intro (a brief description)
    Members / Arguments
    Returns
    Errors
    Features
    Details (additional information, examples, ...)
    Since
=20=20=20=20
Members / Arguments, Returns, Errors, and Features are all optional.
They are in fact all absent in query-memory-size-summary.  This makes
Intro and Details bleed together.

The TODO line keeps them separate, because it's a section (the doc
comment syntax is a sequence of sections, in this case Intro, TODO,
Details).  Not only is abusing TODO an ugly hack, it's also easy to
forget.  If we did forget it here, Return would be inserted in at the
very end:

    Command query-memory-size-summary (Since: 2.11)

       Return the amount of initially allocated and present hotpluggable
       (if enabled) memory in bytes.

       Example::

          -> { "execute": "query-memory-size-summary" }
          <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 }=
 }

       Return:
          "MemoryInfo"

Fortunately, the problem is uncommon: we have just five such TODOs right
now.

Unfortunately, the (still not merged) inliner makes it a lot more
common, and also more serious.

A preparatory series from John added 59 such markers, i.e. about one in
twenty doc comments needed one.  "Such markers" because he didn't abuse
TODO, but created proper syntax for it, namely a Details: line.

Why more serious?  Have a look at netdev_add.  Looks like this in the
generated QEMU QMP Reference Manual:

    Command netdev_add (Since: 0.14)

       Add a network backend.

       Additional arguments depend on the type.

       Arguments:
          * The members of "Netdev".

       [...]

To actually see the arguments, you need to follow the link to type
Netdev.  This is bad UX.  We want the arguments right there, so the
inliner inlines Netdev documentation:

    Object Netdev (Since: 1.2)

       Captures the configuration of a network device.

       Members:
          * **id** ("string") -- identifier for monitor commands.

          * **type** ("NetClientDriver") -- Specify the driver used for
            interpreting remaining arguments.

          * When "type" is "nic": The members of "NetLegacyNicOptions".

       [...]

into netdev_add documentation like this:

    Command netdev_add (Since: 0.14)

       Add a network backend.

       Additional arguments depend on the type.

       Arguments:
          * **id** ("string") -- identifier for monitor commands.

          * **type** ("NetClientDriver") -- Specify the driver used for
            interpreting remaining arguments.

          * When "type" is "nic": The members of "NetLegacyNicOptions".

       [...]

Note that the inliner elided Netdev's Intro "Captures the configuration
of a network device."

However, when Intro and Details bleed together, the inliner elides more
than it should.  I consider that a fairly serious issue.

I'm afraid forgetting to mark the end of Intro with "Details:" would be
a common mistake, easy to miss in review.  So I explored possible
alternatives:

    Subject: Re: [PATCH v2 00/10] qapi: enforce section ordering
    Date: Wed, 15 Apr 2026 11:43:45 +0200
    Message-ID: <87zf341ru6.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87zf341ru6.fsf@pond.sub.org/

John is working towards "3. Make the end of intro syntactically obvious"
always, specifically "3c. Indent intro like descriptions and tagged
sections" with the ultimate goal to reject unindented Intro.  That way,
we cannot write an Intro with an unclear end.  John, correct me if I'm
accidentally misrepresenting your work.

Questions?  Better ideas?

[...]


