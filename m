Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C84C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 07:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txheQ-0004qf-Ae; Thu, 27 Mar 2025 03:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txheP-0004qU-17
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 03:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txheN-0000uf-3A
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 03:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743060456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DubE5UoFWzPzzHp3H+HUqKhUqK7dYazF7KVKriZzk6s=;
 b=aHD5qz+1xD2YWJbiH6I0pOZaIy5FX6+o6OnyTyFjuGD87eXWgRhcUuARBwCxsUGjg6DvN0
 w9RGxKrGkEXxcFhThVVKNCt0ZhUT1fCL9eIkExXjGNY1+q8LBBnHI98C25CtdXrJHAWRvk
 tRJ9v/iFSK8GwugwmIHrcscLXr0mHsE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-aCW0x2PcNTGyxPlKO4SNbg-1; Thu,
 27 Mar 2025 03:27:35 -0400
X-MC-Unique: aCW0x2PcNTGyxPlKO4SNbg-1
X-Mimecast-MFC-AGG-ID: aCW0x2PcNTGyxPlKO4SNbg_1743060452
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 563421801A12; Thu, 27 Mar 2025 07:27:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF3091801751; Thu, 27 Mar 2025 07:27:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 11ADB21E66C5; Thu, 27 Mar 2025 08:27:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Peter Xu <peterx@redhat.com>,  "Gonglei
 (Arei)" <arei.gonglei@huawei.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Michael
 Tokarev <mjt@tls.msk.ru>,  Lukas Straub <lukasstraub2@web.de>,  Fabiano
 Rosas <farosas@suse.de>,  Eduardo Habkost <eduardo@habkost.net>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  qemu-trivial@nongnu.org,  Jason Wang
 <jasowang@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Peter Maydell
 <peter.maydell@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,  Yanan
 Wang <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  qemu-block@nongnu.org,  Zhenwei Pi
 <pizhenwei@bytedance.com>,  Mads Ynddal <mads@ynddal.dk>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Eric Blake
 <eblake@redhat.com>,  Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 3/4] qapi: remove trivial "Returns:" sections
In-Reply-To: <CAFn=p-ZJT0p7LHiBPn5deZnGSq6vtyF5b8G7pmmzUyRPtDURtQ@mail.gmail.com>
 (John Snow's message of "Wed, 26 Mar 2025 15:46:32 -0400")
References: <20250322010857.309490-1-jsnow@redhat.com>
 <20250322010857.309490-4-jsnow@redhat.com>
 <87bjtpmop6.fsf@pond.sub.org>
 <CAFn=p-ZJT0p7LHiBPn5deZnGSq6vtyF5b8G7pmmzUyRPtDURtQ@mail.gmail.com>
Date: Thu, 27 Mar 2025 08:27:19 +0100
Message-ID: <8734ez2aso.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Tue, Mar 25, 2025 at 5:42=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > The new qapidoc transmogrifier can generate "Returns" statements with
>> > type information just fine, so we can remove it from the source where =
it
>> > doesn't add anything particularly novel or helpful and just repeats the
>> > type info.
>> >
>> > This patch does not touch Returns: lines that add some information
>> > (potentially helpful, potentially not) but repeats the type information
>> > to remove that type.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> This is a clear improvement for the generated docs.  For instance,
>> blockdev-snapshot-delete-internal-sync goes from
>>
>>     Return:
>>        "SnapshotInfo" -- SnapshotInfo
>>
>> to
>>
>>     Return:
>>        "SnapshotInfo"
>>
>> However, I see that *triplicated* in my testing.  I observed similar
>> issues with the previous patch, so let's discuss that there and ignore
>> it here.
>>
>> The impact on schema file egonomics is less clear.
>>
>> This patch removes a bunch of "Returns:" sections that make the
>> generated docs look bad.  How can we stop people from writing such
>> sections?

Plan A: catch it in review.  If that turns out to be overly bothersome,
we need to think about better tooling.

>> Developers tend to refer to the schema file instead of the generated
>> documentation.  Information is spread across doc comment and schema
>> code.  Both describe the syntactic structure.  Only the schema code has
>> types, optional, and such.  The doc comment describes semantics.  In
>> practice, skimming the doc comment is often enough.
>>
>> Except for the return value.  The doc comment's "Returns:" section is
>> optional.  When it's absent, the generated docs are bad (but this patch
>> fixes that).  Moreover, the doc comment doesn't fully describe the
>> syntactic structure then.  Unwary readers may not be aware of that trap,
>> and miss the return value.

I've since pondered this some more, and also talked with John.

When doc comments look like they provide a certain kind of information,
but they are actually unrealiable, that's less than ideal for its
readers.

This has always been the case for member / argument descriptions.  We
didn't require them initially, and when we started to, things had gotten
so bad that I had to provide an escape hatch: pragma
documentation-exceptions still lists 44 offenders in qapi/ and one in
qga/.

Most of the offenders are doc bugs.  But not all: documenting the
members of QKeyCode one by one would be silly.

It has also always been the case for return value descriptions.  We
still don't require them.  Your series uncovered ten in qapi/ and one in
qga/.  Your series adds 46 in qapi/.  Possibly more after review of the
last patch.  Missing Returns goes from rare to common.

This does not create doc bugs.  Generated documentation actually
improves.

I figure developers just have to mind that the doc comment need not be
complete.

>> The inliner you posted before needs to know where the inlined stuff
>> goes.  Obvious when there are argument descriptions or a "Returns:".
>> For the cases where we have nothing useful, you proposed an explicit
>> marker "Details:" (how exactly it's spelled doesn't matter here, only
>> that an explicit marker can be necessary).  Could removing "Returns:"
>> make the marker necessary more often?  Can our tooling reliably detect
>> the need for the marker?
>>
>
> Well, tooling can at least be certain when it isn't certain.
>
> The warning I have in my inliner branch-fork-whatever now basically just
> looks at the sections and if there's non-plaintext sections between the
> start and the ending, it treats the beginning as intro and the ending as
> details.

The non-plaintext sections are: Returns, Errors, Since, TODO.

Returns and Errors are reliable anchors for the inliner.  The inliner
inlines argument sections.  They need to go next to Returns / Errors
sections, if any, because they get rendered together in as single
two-column thing.

Since feels useless as an anchor.  Does the inline ignore it?  I don't
remember.  Every definition doc should have it, and we commonly put it
at the very end (currently 776 out of 984 times).  When we don't, it's
usually followed by examples only, and occasionally by notes.  Putting
it always last would be better.  If we manage to replace handwritten by
computed since information, Since goes away.

TODO is the odd duck.  It can go anywhere, which makes its use as anchor
questionable.  It's rare (I count 7 instances).  One of them presses it
into service to separate intro and example (commit 14b48aaab92).  Your
inliner series has a replacement for this hack; I believe the
replacement can serve as a reliable anchor.

> In the case there is *nothing else at all*, i.e. no returns, no
> arguments/members, no errors, no features - i.e. it's a single QAPIDoc
> Section - the inliner will count the *paragraphs*. If it's *one* paragrap=
h,
> it deduces that it's an intro section and does not consider it ambiguous.
> If there are multiple paragraphs, however, that's when it emits a warning.

This is a heuristic.  We'll discuss it in review of the inliner.

> A computer is never going to be able to reliably determine *intent*, but
> syntactically I think that's a pretty narrow circumstance to yelp over:
> "Documentation contains only a single plaintext section that consists of
> two or more paragraphs". In practice, that's a reasonably rare occurrence
> and is most likely to occur with query commands that take no arguments,

... or refer to a complex type for their arguments ...

> have no features, and do not document return value semantics.

... and do not document errors.

I'd be interested in the existing instances if you can track them down
easily.


