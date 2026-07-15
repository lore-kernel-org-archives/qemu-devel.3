Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F868C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk0St-0004OZ-Ce; Wed, 15 Jul 2026 10:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wk0Ss-0004OH-3b
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wk0Sq-0005LQ-6v
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784125194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JB941LrGN/iBFnBCrtCyVDOY1ao0FdU1/fMLI0NBSIM=;
 b=XLg7XT7PXudDibE4LAzR3Xr0TuSxSGEBa4h6hFvVwD48EBpft9vovsMfdH15UUGrwsJ0MD
 mFOqorVleHgEGRdGwGVaAVTa9h961UvlrYClUwgvoGeUUEvG18Boo7Li9OGmJXPt+pDAsl
 u1Un81K3xgMICISyoEGBo6+LmL+G7+Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-y0Q63fhOMgWFXq8tYz7a2Q-1; Wed,
 15 Jul 2026 10:19:53 -0400
X-MC-Unique: y0Q63fhOMgWFXq8tYz7a2Q-1
X-Mimecast-MFC-AGG-ID: y0Q63fhOMgWFXq8tYz7a2Q_1784125191
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C9B81955F73; Wed, 15 Jul 2026 14:19:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCF0A30001B9; Wed, 15 Jul 2026 14:19:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4830B21E6920; Wed, 15 Jul 2026 16:19:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  linux-edac@vger.kernel.org,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>,  Alex Williamson
 <alex@shazbot.org>,  Paolo Bonzini <pbonzini@redhat.com>,  zhenwei pi
 <zhenwei.pi@linux.dev>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Eric Blake <eblake@redhat.com>,  =?utf-8?Q?C=C3=A9dr?=
 =?utf-8?Q?ic?= Le Goater
 <clg@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu
 <zhao1.liu@intel.com>,  Lukas Straub <lukasstraub2@web.de>,  Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 00/14] qapi: convert to explicit intro section syntax
In-Reply-To: <CAFn=p-Yu9OV0LJN8rGrc6GTkJZ38XAvP296tfwBxU6CnhLYR7A@mail.gmail.com>
 (John Snow's message of "Mon, 13 Jul 2026 16:34:07 -0400")
References: <20260629213624.936258-1-jsnow@redhat.com>
 <87ech7gi45.fsf@pond.sub.org>
 <CAFn=p-Yu9OV0LJN8rGrc6GTkJZ38XAvP296tfwBxU6CnhLYR7A@mail.gmail.com>
Date: Wed, 15 Jul 2026 16:19:47 +0200
Message-ID: <87ik6ggwsc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Mon, Jul 13, 2026 at 9:00=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2638342206
>> >
>> > Hi, this patchset converts some of the most trivial modules to use the
>> > new explicit intro syntax. This particular patchset does not
>> > differentiate between "trivial" conversions and those that take
>> > slightly more liberty in refactoring, but there are (debatably?) no
>> > such cases in this patchset.
>>
>> Looks entirely mechanical to me.  Am I missing anything?
>
> Honest answer: I am not sure; I have edited so many QAPI files that I
> cannot remember what is and what is not mechanical anymore. If there
> are instances of "non-mechanical" changes, it would be for cases where
> I decide to indent some paragraphs, but not others, effectively
> introducing a new split as to what appears before and what appears
> after the tabular data.
>
> I genuinely do not recall if there are any such cases in this mini-series.

It's only mostly mechanical.

Almost always, the patches change

  ##
  # @name:
  #
  # Single plain paragraph: Lorem ipsum dolor sit amet ut enim ad minim
  # veniam duis aute irure dolor.
  #
  # Something other than a plain paragraph

to

  ##
  # @name:
  #     Single plain paragraph: Lorem ipsum dolor sit amet ut enim ad
  #     minim veniam duis aute irure dolor.
  #
  # Something other than a plain paragraph

No decisions, thus mechanical.

I found two exceptions:

1. In qapi/compat.json

    @@ -39,8 +37,7 @@

     ##
     # @CompatPolicy:
    -#
    -# Policy for handling deprecated management interfaces.
    +#     Policy for handling deprecated management interfaces.
     #
     # This is intended for testing users of the management interfaces.
     #
     # Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
     # with feature 'deprecated' or 'unstable'.  We may want to extend it
     # to cover semantic aspects and CLI.
     #
     # Limitation: deprecated-output policy @hide is not implemented for
     # enumeration values.  They behave the same as with policy @accept.
     #
     # @deprecated-input: how to handle deprecated input (default 'accept')
     #
     # @deprecated-output: how to handle deprecated output (default
     #     'accept')
     #
     # @unstable-input: how to handle unstable input (default 'accept')
     #     (since 6.2)
     #
     # @unstable-output: how to handle unstable output (default 'accept')
     #     (since 6.2)
     #
     # Since: 6.0
     ##

   Here, we have multiple paragraphs, and only the first one becomes
   "intro".

2. In qapi/misc-arm.json

    @@ -29,9 +28,8 @@

     ##
     # @query-gic-capabilities:
    -#
    -# It will return a list of `GICCapability` objects that describe its
    -# capability bits.
    +#     It will return a list of `GICCapability` objects that describe
    +#     its capability bits.
     #
     # On non-ARM targets this command will report an error as the GIC
     # technology is not applicable.
     #
     # Since: 2.6
     #
     # .. qmp-example::
     #
     #     -> { "execute": "query-gic-capabilities" }
     #     <- { "return": [{ "version": 2, "emulated": true, "kernel": fals=
e },
     #                     { "version": 3, "emulated": false, "kernel": tru=
e } ] }
     ##

   Here, we have two paragraphs, and both become "intro".


