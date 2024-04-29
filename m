Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2847C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 07:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Luc-0000LV-Ob; Mon, 29 Apr 2024 03:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1Luc-0000LJ-2O
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1LuZ-00047P-Pe
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714377534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DO6e9FPjfwOasFz0oyALiZILCAaEmrr/iciRQpcZGxo=;
 b=PH6hDNwDdsbwz39rgsQsuZLHum5F8LOQfxaPKq6a7bCRe6e6Z4SYYBzdfloYoWvkzAv/oD
 bMn0BnqXdEYBLy1/EY50jk0uR2XtnwLX0+Mg3+8Ax4oYJUds3pSOk6I1Iajtady0YHVfbR
 25pR5RV79e3MEdUM9/wRdkNqUZOBAWc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-xYK8CLzdOc6KJRoaPdfTcw-1; Mon,
 29 Apr 2024 03:58:45 -0400
X-MC-Unique: xYK8CLzdOc6KJRoaPdfTcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52B6229ABA11;
 Mon, 29 Apr 2024 07:58:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CD1E2166B32;
 Mon, 29 Apr 2024 07:58:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 506B921E6680; Mon, 29 Apr 2024 09:58:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: fan <nifan.cxl@gmail.com>
Cc: qemu-devel@nongnu.org,  jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org,  gregory.price@memverge.com,
 ira.weiny@intel.com,  dan.j.williams@intel.com,
 a.manzanares@samsung.com,  dave@stgolabs.net,  nmtadam.samsung@gmail.com,
 jim.harris@samsung.com,  Jorgen.Hansen@wdc.com,  wj28.lee@gmail.com,  Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <Zivk37xBGPsL_yo5@debian> (fan's message of "Fri, 26 Apr 2024
 10:31:11 -0700")
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org> <Zivk37xBGPsL_yo5@debian>
Date: Mon, 29 Apr 2024 09:58:42 +0200
Message-ID: <87h6fkob0t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

fan <nifan.cxl@gmail.com> writes:

> On Fri, Apr 26, 2024 at 11:12:50AM +0200, Markus Armbruster wrote:
>> nifan.cxl@gmail.com writes:

[...]

>> > diff --git a/qapi/cxl.json b/qapi/cxl.json
>> > index 4281726dec..2dcf03d973 100644
>> > --- a/qapi/cxl.json
>> > +++ b/qapi/cxl.json
>> > @@ -361,3 +361,72 @@
>> >  ##
>> >  {'command': 'cxl-inject-correctable-error',
>> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
>> > +
>> > +##
>> > +# @CXLDCExtentRecord:
>>=20
>> Such traffic jams of capital letters are hard to read.  What about
>> CxlDynamicCapacityExtent?
>>=20
>> > +#
>> > +# Record of a single extent to add/release
>>=20
>> Suggest "A dynamic capacity extent."
>>=20
>> > +#
>> > +# @offset: offset to the start of the region where the extent to be o=
perated
>>=20
>> Blank line here, please.
>>=20
>>=20
>>=20
>> > +# @len: length of the extent
>> > +#
>> > +# Since: 9.1
>> > +##
>> > +{ 'struct': 'CXLDCExtentRecord',
>> > +  'data': {
>> > +      'offset':'uint64',
>> > +      'len': 'uint64'
>> > +  }
>> > +}
>> > +
>> > +##
>> > +# @cxl-add-dynamic-capacity:
>> > +#
>> > +# Command to start add dynamic capacity extents flow. The device will
>> > +# have to acknowledged the acceptance of the extents before they are =
usable.
>>=20
>> This text needs work.  More on that at the end of my review.
>
> Yes. I will work on it for the next version once all the feedbacks
> are collected and comments are resolved.
>
> See below.
>
>>=20
>> docs/devel/qapi-code-gen.rst:
>>=20
>>     For legibility, wrap text paragraphs so every line is at most 70
>>     characters long.
>>=20
>>     Separate sentences with two spaces.
>>=20
>> More elsewhere.
>>=20
>> > +#
>> > +# @path: CXL DCD canonical QOM path
>>=20
>> I'd prefer @qom-path, unless you can make a consistency argument for
>> @path.
>>=20
>> Sure the QOM path needs to be canonical?
>>=20
>> If not, what about "path to the CXL dynamic capacity device in the QOM
>> tree".  Intentionally close to existing descriptions of @qom-path
>> elsewhere.
>
> From the same file, I saw "path" was used for other commands, like
> "cxl-inject-memory-module-event", so I followed it.
> DCD is nothing different from "type 3 device" expect it can dynamically
> change capacity.=20
> Renaming it to "qom-path" is no problem for me, just want to make sure it
> will not break the naming consistency.

Both @path and @qom-path are used (sadly).  @path is used for all kinds
of paths, whereas @qom-path is only used for QOM paths.  That's why I
prefer it.

However, you're making a compelling local consistency argument: cxl.json
uses only @path.  Sticking to that makes sense.

>> > +# @hid: host id
>>=20
>> @host-id, unless "HID" is established terminology in CXL DCD land.
>
> host-id works.
>>=20
>> What is a host ID?
>
> It is an id identifying the host to which the capacity is being added.

How are these IDs assigned?

>> > +# @selection-policy: policy to use for selecting extents for adding c=
apacity
>>=20
>> Where are selection policies defined?
>
> It is defined in CXL specification: Specifies the policy to use for selec=
ting
> which extents comprise the added capacity

Include a reference to the spec here?

>> > +# @region-id: id of the region where the extent to add
>>=20
>> Is "region ID" the established terminology in CXL DCD land?  Or is
>> "region number" also used?  I'm asking because "ID" in this QEMU device
>> context suggests a connection to a qdev ID.
>>=20
>> If region number is fine, I'd rename to just @region, and rephrase the
>> description to avoid "ID".  Perhaps "number of the region the extent is
>> to be added to".  Not entirely happy with the phrasing, doesn't exactly
>> roll off the tongue, but "where the extent to add" sounds worse to my
>> ears.  Mind, I'm not a native speaker.
>
> Yes. region number is fine. Will rename it as "region"
>
>>=20
>> > +# @tag: Context field
>>=20
>> What is this about?
>
> Based on the specification, it is "Context field utilized by implementati=
ons
> that make use of the Dynamic Capacity feature.". Basically, it is a
> string (label) attached to an dynamic capacity extent so we can achieve
> specific purpose, like identifying or grouping extents.

Include a reference to the spec here?

>> > +# @extents: Extents to add
>>=20
>> Blank lines between argument descriptions, please.
>>=20
>> > +#
>> > +# Since : 9.1
>> > +##
>> > +{ 'command': 'cxl-add-dynamic-capacity',
>> > +  'data': { 'path': 'str',
>> > +            'hid': 'uint16',
>> > +            'selection-policy': 'uint8',
>> > +            'region-id': 'uint8',
>> > +            'tag': 'str',
>> > +            'extents': [ 'CXLDCExtentRecord' ]
>> > +           }
>> > +}
>> > +
>> > +##
>> > +# @cxl-release-dynamic-capacity:
>> > +#
>> > +# Command to start release dynamic capacity extents flow. The host wi=
ll
>> > +# need to respond to indicate that it has released the capacity befor=
e it
>> > +# is made unavailable for read and write and can be re-added.
>>=20
>> This text needs work.  More on that at the end of my review.
>
> Will do.
>
>>=20
>> > +#
>> > +# @path: CXL DCD canonical QOM path
>>=20
>> My comment on cxl-add-dynamic-capacity applies.
>>=20
>> > +# @hid: host id
>>=20
>> Likewise.
>>=20
>> > +# @flags: bit[3:0] for removal policy, bit[4] for forced removal, bit=
[5] for
>> > +#     sanitize on release, bit[7:6] reserved
>>=20
>> Where are these flags defined?
>
> Defined in the CXL specification, it defines the release behaviour.

Include a reference to the spec here?

Is the numeric encoding of flags appropriate?

In general, we prefer symbolic encodings.  Numeric encodings can make
sense when

=E2=80=A2 the encoding is stable, and

=E2=80=A2 QEMU doesn't need to decode it, only pass it on to something else=
, and

=E2=80=A2 both the QMP client and the "something else" prefer a numeric
  encoding.

>> > +# @region-id: id of the region where the extent to release
>>=20
>> My comment on cxl-add-dynamic-capacity applies.
>>=20
>> > +# @tag: Context field
>>=20
>> Likewise.
>>=20
>> > +# @extents: Extents to release
>> > +#
>> > +# Since : 9.1
>> > +##
>> > +{ 'command': 'cxl-release-dynamic-capacity',
>> > +  'data': { 'path': 'str',
>> > +            'hid': 'uint16',
>> > +            'flags': 'uint8',
>> > +            'region-id': 'uint8',
>> > +            'tag': 'str',
>> > +            'extents': [ 'CXLDCExtentRecord' ]
>> > +           }
>> > +}
>>=20
>> During review of v5, you wrote:
>>=20
>>     For add command, the host will send a mailbox command to response to
>>     the add request to the device to indicate whether it accepts the add
>>     capacity offer or not.
>>=20=20=20=20=20
>>     For release command, the host send a mailbox command (not always a
>>     response since the host can proactively release capacity if it does
>>     not need it any more) to device to ask device release the capacity.
>>=20
>> Can you briefly sketch the protocol?  Peers and messages involved.
>> Possibly as a state diagram.
>
> Need to think about it. If we can polish the text nicely, maybe the
> sketch is not needed. My concern is that the sketch may
> introduce unwanted complexity as we expose too much details. The two
> commands provide ways to add/release dynamic capacity to/from a host,
> that is all. All the other information, like what the host will do, or
> how the device will react, are consequence of the command, not sure
> whether we want to include here.

The protocol sketch is for me, not necessarily the doc comment.  I'd
like to understand at high level how this stuff works, because only then
can I meaningfully review the docs.

> @Jonathan, Any thoughts on this?

Thanks!


