Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD12C531CA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmt1G-0007wP-Be; Thu, 23 Jul 2026 08:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmt13-0007vl-CK
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmt11-0003EW-Ib
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784811546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xh791XMNZ2xgXLQL8lfLW+JBeKd2Y0/8ifrPwfkyRUs=;
 b=RVPeNZRlulVw1jEqmU3KBzC9ZKVRr0kT7K3cOspQb+8dwzcxd3Tp1Bc49TDsrsn49VRNDu
 dH2wkRsdJUGSD/jtxIzolguEFxW0d8WVndMTsWWt5HAIgwrPoyUfWyXVp7fQM9L+tKxwei
 Wgc+Q3NA2jjIj8ogy4JZRUdoPTwjpq4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-yWYKGLyHPpeB9uaZg_Nlaw-1; Thu,
 23 Jul 2026 08:57:52 -0400
X-MC-Unique: yWYKGLyHPpeB9uaZg_Nlaw-1
X-Mimecast-MFC-AGG-ID: yWYKGLyHPpeB9uaZg_Nlaw_1784811469
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0909719540DC; Thu, 23 Jul 2026 12:57:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B6791956053; Thu, 23 Jul 2026 12:57:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A065821E6920; Thu, 23 Jul 2026 14:57:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Lukas
 Straub <lukasstraub2@web.de>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Zhao Liu <zhao1.liu@intel.com>,  Laurent
 Vivier <laurent@vivier.eu>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Alex
 Williamson
 <alex@shazbot.org>,  zhenwei pi <zhenwei.pi@linux.dev>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org,  Jiri Pirko <jiri@resnulli.us>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,  Igor
 Mammedov <imammedo@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  linux-edac@vger.kernel.org,  =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
 qemu-trivial@nongnu.org,  Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 00/44] qapi: convert trivial intro sections
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com> (John Snow's message
 of "Thu, 23 Jul 2026 00:47:21 -0400")
References: <20260723044805.527643-1-jsnow@redhat.com>
Date: Thu, 23 Jul 2026 14:57:41 +0200
Message-ID: <87ik65g8xm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

> GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2699067787
>
> Hi, this patchset converts trivial "introductory" sections in the QAPI
> documentation to use the new, explicit intro section syntax.
>
> This is being done primarily for the benefit of the forthcoming
> "inliner", a feature for the rendered HTML QMP documentation that
> seeks to "inline" QMP command argument documentation into the argument
> list for each command.
>
> There are two main motives here:
>
> (1) We want the split between the "introduction" and "details"
>     sections to be mechanically obvious, so that auto-generated or
>     inlined documentation has a well-defined, obvious spot to go.
>
> (2) We do not want to inline irrelevant, introductory text describing
>     structures to be copied into command documentation.

docs/devel/qapi-code-gen.rst until recently:

    Definition documentation starts with a line naming the definition,
    followed by an optional overview, a description of each argument (for
    commands and events), member (for structs and unions), branch (for
    alternates), or value (for enums), a description of each feature (if
    any), and finally optional tagged sections.

Recent commit ebb49d4bb6 (qapi: add doc comment "Intro" section parsing)
changed it to

    Definition documentation starts with a description naming the
    definition with an optional indented overview, a description of each
    argument (for commands and events), member (for structs and unions),
    branch (for alternates), or value (for enums), a description of each
    feature (if any), and finally optional tagged sections.

It didn't actually update the schema for this change.  This series does,
but only where it's "trivial":

> This patchset tackles "trivial" conversions: cases where the
> introduction is only a single paragraph and is immediately followed by
> a tagged section, the end of the documentation block, or some other
> pre-existing syntactical delineation.

I see the following right after conversions:

* A member description "# @name: ..."

* A "Features:" line

* A tagged section like "Returns: ...", "Since: ..."

End of documentation block ("##") also makes sense, but doesn't actually
occur, because we always have a Since: somewhere after the first
paragraph.

Converting single first paragraps is mechanical.  For it to be correct,
this single paragraph must actually be the overview, and not some other
crap.  I expect it to be almost always overview.  Not sure how to best
look for the exceptions.

When there's more than one paragraph, it could still all be overview.
But the risk of "other crap" is higher.  For instance:

    ##
    # @SecretProperties:
    #
    # Properties for secret objects.
    #
    # Either @data or @file must be provided, but not both.
    #
    # @data: the associated with the secret from
    #
    # @file: the filename to load the data associated with the secret from
    #
    # Since: 2.6
    ##

Two paragraphs, only the first is "overview".

That's why you leave checking and disentangling multiple paragraphs for
later.  Makes sense.

> Future patches that may require more scrutiny will handle the
> remaining conversions - I think this is enough for today, don't you?

Oh yes, it is.


