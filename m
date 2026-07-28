Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C665EC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woiPT-0003g4-SS; Tue, 28 Jul 2026 10:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1woiPR-0003fT-OY
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1woiPQ-0002fY-7t
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785247431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PohtNST+Xy8qYme8Z1wQJAszUVDb0swxBNH2usSpkdU=;
 b=Z4wnkHYX0xDYn6qGQfjERYPTa7sqkxdPpJgCM6uYN0M1z6k7eeDs6cx3qS5LNslsF5Xkf7
 Fuvw/8J2T+xCyuzfNO3C5tSweDKL1RUbn1TZ7Ixheovb8zge6LV3eMh0oCSuzlyPN0gZFf
 bgWL5tXgHD741pv6yNXXq6CoGPTDrFI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-JnQILyFeNDG833Mv4P6lVw-1; Tue,
 28 Jul 2026 10:03:47 -0400
X-MC-Unique: JnQILyFeNDG833Mv4P6lVw-1
X-Mimecast-MFC-AGG-ID: JnQILyFeNDG833Mv4P6lVw_1785247423
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE94019560BE; Tue, 28 Jul 2026 14:03:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4DF21800480; Tue, 28 Jul 2026 14:03:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D74D21E6920; Tue, 28 Jul 2026 16:03:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Lukas Straub
 <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Zhao Liu
 <zhao1.liu@intel.com>,  Laurent Vivier <laurent@vivier.eu>,  "Gonglei
 (Arei)" <arei.gonglei@huawei.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Alex Williamson <alex@shazbot.org>,  zhenwei pi
 <zhenwei.pi@linux.dev>,  Hanna Reitz <hreitz@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  qemu-block@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  linux-cxl@vger.kernel.org,  Jiri Pirko
 <jiri@resnulli.us>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,
 Igor Mammedov <imammedo@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>,  linux-edac@vger.kernel.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
 qemu-trivial@nongnu.org,  Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 00/44] qapi: convert trivial intro sections
In-Reply-To: <CAFn=p-Z0Ys6FoUqRPY7d5CaN4YfHE4DUN6VLtMeWRJgUk3Khkg@mail.gmail.com>
 (John Snow's message of "Mon, 27 Jul 2026 13:16:13 -0400")
References: <20260723044805.527643-1-jsnow@redhat.com>
 <87ik65g8xm.fsf@pond.sub.org> <87h5lobypc.fsf@pond.sub.org>
 <CAFn=p-Z0Ys6FoUqRPY7d5CaN4YfHE4DUN6VLtMeWRJgUk3Khkg@mail.gmail.com>
Date: Tue, 28 Jul 2026 16:03:38 +0200
Message-ID: <87mrvbtdmt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Fri, Jul 24, 2026 at 4:04=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>> [...]
>>
>> > Converting single first paragraps is mechanical.  For it to be correct,
>> > this single paragraph must actually be the overview, and not some other
>> > crap.  I expect it to be almost always overview.  Not sure how to best
>> > look for the exceptions.
>>
>> The separation truly matters only when the inliner inlines the doc
>> comment.  It potentially matters when it would inline it if the type was
>> used differently.
>
> It also (potentially) matters for auto-generated docs, such as
> undocumented members, return types, features*, errors*. The break
> point is where these fields get inserted.

Right, I forgot about this.  There goes my review shortcut...

> (*Not currently performed. Not asserting that it will be performed, or
> that it is necessarily valuable to do so. Just fleshing out the
> category.)
>
>>
>> If I remember correctly, the inliner inlines doc of struct / union base
>> type, union branch type, command / event argument type.
>>
>> Argument can only be struct or union.  Base and branch can only be
>> struct.
>>
>> We talked about maybe inlining return types some day.  This would be
>> struct, union, or array of struct or union.
>>
>> So, for anything other than struct and union, the inliner doesn't get
>> involved, and separating the overview cleanly is just a matter of
>> writing style.  I'm not sure we care.  Even if we elect to care,
>> cleaning it up is hardly this series' business.  In short, your
>> mechanical conversion of single first paragraphs to overview syntax
>> should be fine even where a paragraph's contents isn't clearly overview.
>
> Except in cases where stub positioning matters, see also the former
> "TODO:" syntax used to delineate intro/details.
>
>>
>> Structs and unions, however, could use an eye-over.
>>
>> [...]
>>


