Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26BBC88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7SQD-0005A4-C8; Fri, 18 Sep 2026 02:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7SQA-00058w-Rb
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 02:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7SQ9-0002Pv-29
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 02:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789714203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eyvUI+FjPeUCtG3KH6IPA7tERUT8Pr5p4tmUdY8PMNA=;
 b=JyqSvs20rTOGc0sPmX1dsyEkP2UvHNKEjSvHGkfbiD3S/tfXTx2SlxfIzyMyXOFx7PofLY
 PYZ3v1jINyf7Ob40QckNdOTuGxKSJ7FYNSrvcmG+2XLTpEc3JZxb81qAWAP/dQf4B9/Is6
 WsyqThKmsnnoshhU5tAfc3gL2P8GVnA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-rF3nsPFwPjGBu-DUAU_sDA-1; Fri,
 18 Sep 2026 02:49:59 -0400
X-MC-Unique: rF3nsPFwPjGBu-DUAU_sDA-1
X-Mimecast-MFC-AGG-ID: rF3nsPFwPjGBu-DUAU_sDA_1789714198
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6CEA1802141; Fri, 18 Sep 2026 06:49:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F32C7195604D; Fri, 18 Sep 2026 06:49:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 93B8D21E6A04; Fri, 18 Sep 2026 08:49:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Jason Wang
 <jasowangio@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org,  Eric Blake <eblake@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu <peterx@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH 3/9] qapi: convert multi-paragraph intros (enums)
In-Reply-To: <CAFn=p-Zzz0FFMeRgd7_7G0if5-CS7Trk=nX0P2w1i9NxfQ-mPA@mail.gmail.com>
 (John Snow's message of "Thu, 17 Sep 2026 16:13:07 -0400")
References: <20260911203002.305316-1-jsnow@redhat.com>
 <20260911203002.305316-4-jsnow@redhat.com>
 <87zexhbk8t.fsf@pond.sub.org>
 <CAFn=p-Zzz0FFMeRgd7_7G0if5-CS7Trk=nX0P2w1i9NxfQ-mPA@mail.gmail.com>
Date: Fri, 18 Sep 2026 08:49:53 +0200
Message-ID: <87fqz7oxym.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On Wed, Sep 16, 2026 at 5:47=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This patch converts some slightly-non-trivial intros with more than
>> > one paragraph, but doesn't create any new intro/details splits.
>> >
>> > Review notes: The "See also ..." texts here are prime candidates for
>> > moving into the details section with a ".. seealso::", but like the
>> > last patch, as these are for enums and not candidates as an inline
>> > source, I left them alone for now to keep patch sizes and motion down
>> > until after initial review.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  qapi/machine.json | 39 +++++++++++++++++++--------------------
>> >  1 file changed, 19 insertions(+), 20 deletions(-)
>> >
>> > diff --git a/qapi/machine.json b/qapi/machine.json
>> > index 0516112f8e8..710b638b3bf 100644
>> > --- a/qapi/machine.json
>> > +++ b/qapi/machine.json
>> > @@ -608,12 +608,12 @@
>> >
>> >  ##
>> >  # @HmatLBMemoryHierarchy:
>> > +#     The memory hierarchy in the System Locality Latency and
>> > +#     Bandwidth Information Structure of HMAT (Heterogeneous Memory
>> > +#     Attribute Table)
>> >  #
>> > -# The memory hierarchy in the System Locality Latency and Bandwidth
>> > -# Information Structure of HMAT (Heterogeneous Memory Attribute Table)
>> > -#
>> > -# For more information about `HmatLBMemoryHierarchy`, see chapter
>> > -# 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
>> > +#     For more information about `HmatLBMemoryHierarchy`, see chapter
>> > +#     5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
>>
>> This is one of the "see also" you discussed in the commit message.  Such
>> references tend to belong closer to the end, not in the intro.  Moving
>> involves a split.
>>
>> More of the same below.
>>
>> Not splitting now keeps the conversion simple, which is a plus.  It
>> reindents the entire unsplit intro, and if we do split it later, the
>> part split off gets reindented right back.
>>
>> I'm happy to leave this decision to you.  I'm adding to my notes on
>> future work:
>>
>> 8. Move "see also" out of intro
>>
>
> If you believe the ultimate destination for these is below the fold,
> I'm happy to do it now. I just *didn't* because I wasn't entirely
> sure. If you are, let's get it over with.

Having thought some more to reply to 2/9, I'd now draw the boundary like
this: if we believe the ultimate destination is above the fold, make it
intro, else keep it plain.

This kicks less than easy contents decisions down the road to "eliminate
plain sections after intro".

Right now we need to get the syntax conversion done and merged.  Doing
plain section elimination incrementally is less bad than doing syntax
conversion incrementally, I believe.

Makes sense?


