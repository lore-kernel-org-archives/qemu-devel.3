Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0ECC71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 06:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRmBF-0007GR-Id; Wed, 18 Jun 2025 02:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRmBE-0007G2-0N
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRmBB-0006UK-8N
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750227706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WprEbIX45ycvIXXkk3cZDXtOVPeXzZhkN9DAwhdEtLM=;
 b=DUtNzSxGxsNi+4M1wSqE6Dbg9wV/wvMUaK2X6HO27rxwOcmF45+MipOvVcuH8PQsoj3mfw
 Uxc9nCfhf0nuPiflc6Sc2WJpRXLmFZdcMotk9QCyS4l3pqPRLquGNSpJwFfMBXHoCoQgMX
 yEDPa1Xu6ewieXI07vgK+0828w3BCI8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-UVcGOon0OrahWT-vIY6lOg-1; Wed,
 18 Jun 2025 02:21:42 -0400
X-MC-Unique: UVcGOon0OrahWT-vIY6lOg-1
X-Mimecast-MFC-AGG-ID: UVcGOon0OrahWT-vIY6lOg_1750227700
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C2571956089; Wed, 18 Jun 2025 06:21:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BFF119560A3; Wed, 18 Jun 2025 06:21:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8679221E6A27; Wed, 18 Jun 2025 08:21:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhenwei Pi <pizhenwei@bytedance.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Jiri Pirko <jiri@resnulli.us>,  Ani
 Sinha <anisinha@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Zhao Liu <zhao1.liu@intel.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Kashyap Chamarthy <kchamart@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Hanna Reitz <hreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org,  Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Eric Blake <eblake@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Fan Ni <fan.ni@samsung.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 2/3] docs: remove legacy QAPI manual generator
In-Reply-To: <CAFn=p-bwa7ETp9znOQ_zMD5icJz2e7=Lj+uLWNctADwLrtqnhA@mail.gmail.com>
 (John Snow's message of "Tue, 17 Jun 2025 15:54:07 -0400")
References: <20250612221051.1224565-1-jsnow@redhat.com>
 <20250612221051.1224565-3-jsnow@redhat.com>
 <87ldprho83.fsf@pond.sub.org>
 <CAFn=p-bwa7ETp9znOQ_zMD5icJz2e7=Lj+uLWNctADwLrtqnhA@mail.gmail.com>
Date: Wed, 18 Jun 2025 08:21:34 +0200
Message-ID: <87o6ulr2mp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On Mon, Jun 16, 2025 at 8:20=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Thanks for your service!
>> >
>> > Remove the old qapidoc and the option to enable the transmogrifier,
>> > leaving the "transmogrifier" as the ONLY qapi doc generator. This in
>> > effect also converts the QAPI test to use the new documentation
>> > generator, too.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> Fails "make check", because tests/qapi-schema/doc-good.txt needs an
>> update.
>>
>> Unfortunately, the diff of the update is less than useful.  To make
>> sense of what changes, I split doc-good.txt into parts before and after,
>> and diffed those.
>>
>>
>>   diff -rupw o/01 n/01
>>   --- o/01      2025-06-16 13:53:05.036940854 +0200
>>   +++ n/01      2025-06-16 13:49:07.167435996 +0200
>>   @@ -1,11 +1,13 @@
>>    Section
>>    *******
>>
>>   +Just text, no heading.
>>   +
>>
>> Looks like a bug fix.  Needs a mention in the commit message then.
>>
>
> I think before, these sections just got ... discarded?

Looks like it.  Definitely a bug.

>                                                        but with no special
> formatting, they just get copied through. You could call it a bugfix, you
> could call it an unintentional side effect.

I'm calling it a bug fix.  Where was it broken?  Dig, dig, dig, ...

commit b61a4eb3f32ce74c5ffe001806f9e786788a546f
Author: John Snow <jsnow@redhat.com>
Date:   Sun Feb 23 22:37:35 2025 -0500

    docs/qapidoc: support header-less freeform sections
=20=20=20=20
    The code as written crashes when a free-form documentation block doesn't
    start with a heading or subheading, for example:
=20=20=20=20
    | ##
    | # Just text, no heading.
    | ##
=20=20=20=20
    The code will attempt to use the `node` variable uninitialized. To fix,
    create a generic block to insert the doc text into.
=20=20=20=20
    (This patch also removes a lingering pylint warning in the QAPIDoc
    implementation that prevents getting a clean baseline to use for
    forthcoming additions.)
=20=20=20=20
    Fixes: 43e0d14ee09a (docs/sphinx: fix extra stuff in TOC after freeform=
 QMP sections)
    Signed-off-by: John Snow <jsnow@redhat.com>
    Message-ID: <20250224033741.222749-5-jsnow@redhat.com>
    Reviewed-by: Markus Armbruster <armbru@redhat.com>
    [Test updated to cover this]
    Signed-off-by: Markus Armbruster <armbru@redhat.com>

The patch adds such a block to doc-good.json.  It shows up in expected
output doc-good.out, but not in doc-good.txt.  Review fail.

Please mention the fix in the commit message, and add the Fixes: tag.

[...]


