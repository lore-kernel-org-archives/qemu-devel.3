Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49772C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR8pl-0006gA-F6; Tue, 09 Jul 2024 07:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sR8pk-0006da-17
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sR8pi-0007f5-Kf
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720523789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkQWvUjGjiwH7C9s6BL6oVtvS2kZexrKemTj9B0psH4=;
 b=PZ7wTnphiwXsciRLmnAus2fE916/F7DT6JeVENpoix+YnYEIWmn9BGywyTi6AdUpTs+amd
 z2lEpg05nK97Ng/PRfO81o+I7CXoIS8KlkWiU3bX7KeTw4y0fD+sabVJJj61EED2nnRzge
 iFDrylkmWXgfwuw9ixBE4H3u0rtxsQE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-BHg6D-O9P96Pv9o7tCPRGQ-1; Tue,
 09 Jul 2024 07:16:25 -0400
X-MC-Unique: BHg6D-O9P96Pv9o7tCPRGQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE0871954207; Tue,  9 Jul 2024 11:16:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C1493000181; Tue,  9 Jul 2024 11:16:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 825C121E6757; Tue,  9 Jul 2024 13:16:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Peter Xu <peterx@redhat.com>,  Qemu-block
 <qemu-block@nongnu.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Stefan Hajnoczi <stefanha@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Lukas Straub <lukasstraub2@web.de>,  Ani
 Sinha <anisinha@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Hanna Reitz <hreitz@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,  Alex Williamson
 <alex.williamson@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 5/8] qapi: convert "Example" sections without titles
In-Reply-To: <CAFn=p-aeEYjCse3wiPEpwoXgm2R16U+MtZC83F=tkgy_wt8A1w@mail.gmail.com>
 (John Snow's message of "Sat, 6 Jul 2024 15:56:03 -0400")
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-6-jsnow@redhat.com>
 <87sewmtwdn.fsf@pond.sub.org>
 <CAFn=p-aeEYjCse3wiPEpwoXgm2R16U+MtZC83F=tkgy_wt8A1w@mail.gmail.com>
Date: Tue, 09 Jul 2024 13:16:19 +0200
Message-ID: <8734oihl30.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

John Snow <jsnow@redhat.com> writes:

> On Sat, Jul 6, 2024, 10:42=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Use the no-option form of ".. qmp-example::" to convert any Examples
>> > that do not have any form of caption or explanation whatsoever. Note
>> > that in a few cases, example sections are split into two or more
>> > separate example blocks. This is only done stylistically to create a
>> > delineation between two or more logically independent examples.
>> >
>> > See commit-3: "docs/qapidoc: create qmp-example directive", for a
>> >               detailed explanation of this custom directive syntax.
>> >
>> > See commit+3: "qapi: remove "Example" doc section" for a detailed
>> >               explanation of why.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> [...]
>>
>> > diff --git a/qapi/run-state.json b/qapi/run-state.json
>> > index 252d7d6afa7..718a3c958e9 100644
>> > --- a/qapi/run-state.json
>> > +++ b/qapi/run-state.json
>>
>> [...]
>>
>> > @@ -453,7 +453,7 @@
>> >  #
>> >  # Since: 5.0
>> >  #
>> > -# Example:
>> > +# .. qmp-example::
>> >  #
>> >  #     <- { "event": "GUEST_CRASHLOADED",
>> >  #          "data": { "action": "run" },
>>
>> Trivial semantic conflict, we need
>>
>
> Caught on rebase late Fri, already fixed locally and will be in v2 (which=
 I
> rebased on top of my sphinx 3.x patches, which change the do_parse() stuff
> too.)

With that fix
Reviewed-by: Markus Armbruster <armbru@redhat.com>

[...]


