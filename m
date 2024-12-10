Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53779E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 09:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKwXP-0002sz-9x; Tue, 10 Dec 2024 04:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tKwXF-0002sK-4i
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 04:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tKwXD-0007iJ-1o
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 04:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733822878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jj8ygUKim3bwhCIBeej2EaHIDcCt6g0ff1mKismGfkY=;
 b=I4cYWKsMTabZzfCSGiPghLpbXyrIBR1Ba9kznpYTLqgo9HertyUeRbTbNGK+ABaZsXfvAa
 0XS9QvfN7bqVTk14sRTJ9ara9aqn1g1Sv5bMqllakJH5vREaHDXMujrCE3ckCY1O8wBJJd
 Jj0h77w+QqSI737A265Vdj1ty2NyLOw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-Z51rdHRSPliSoxvD1XM8AA-1; Tue,
 10 Dec 2024 04:27:55 -0500
X-MC-Unique: Z51rdHRSPliSoxvD1XM8AA-1
X-Mimecast-MFC-AGG-ID: Z51rdHRSPliSoxvD1XM8AA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A0D519560B6; Tue, 10 Dec 2024 09:27:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D37F41956089; Tue, 10 Dec 2024 09:27:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 99F8921E6740; Tue, 10 Dec 2024 10:27:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Andrew Keesler <ankeesler@google.com>,  Roque Arcudia Hernandez
 <roqueh@google.com>,  mst@redhat.com,  marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org,  venture@google.com
Subject: Re: [PATCH 2/2] hw/display: Allow injection of virtio-gpu EDID name
In-Reply-To: <Z1HcCOG6cqDWNNW5@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 5 Dec 2024 16:59:52 +0000")
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-3-roqueh@google.com>
 <Z0RnuVKPHO1T2BfV@redhat.com>
 <CAGZECHOTT1bs0frj-QDyRtudFNb+VzD4tZsnk4Fj=Q0OH+1v3Q@mail.gmail.com>
 <Z0XxYpvj49colIIy@redhat.com>
 <CAGZECHMEYjL56AZebqOK4dTgQbLtwA=9=yZ0qi0ymSpMS2x7Gw@mail.gmail.com>
 <CAGZECHO0HmkM+zPudFKU-dYZi9LqhfgVqaONn09DRW07sNkLVg@mail.gmail.com>
 <Z1HcCOG6cqDWNNW5@redhat.com>
Date: Tue, 10 Dec 2024 10:27:51 +0100
Message-ID: <87frmv99bc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> CC Markus to keep me honest in my comments below
>
> On Mon, Dec 02, 2024 at 03:31:53PM -0500, Andrew Keesler wrote:
>> Hi again Daniel. I have a follow up question. Can you help me
>> understand how I can declare this "outputs" property?
>>=20
>>    -device '{"driver":"virtio-vga",
>>              "max_outputs":2,
>>              "id":"vga",
>>              "outputs":[
>>                {
>>                   "name":"AAA",
>>                },
>>                {
>>                   "name":"BBB",
>>                },
>>              ]}'
>>=20
>> I thought DEFINE_PROP_ARRAY would do it, but I can't tell what PropertyI=
nfo
>> implementation I should pass. All of the PropertyInfo implementations I =
can
>> find use scalar types, or simple text decoding. I am wondering if I am
>> missing
>> some sort of "JSON" encoding capabilities that can happen behind the sce=
nes.
>
> I could have sworn we had an example of how to handle this already,
> but I'm not finding any Device class with a non-scalar property
> that isn't merely an array of scalars.

I found a few:

* TYPE_X86_CPU properties "feature-words" and "filtered-features" have
  struct type X86CPUFeatureWordInfo.  Defined in target/i386/cpu.c
  x86_cpu_initfn().

* TYPE_X86_CPU property "crash-information" has union type
  GuestPanicInformation.  Defined in target/i386/cpu.c
  x86_cpu_common_class_init().

* TYPE_VIRTIO_BLK property "iothread-vq-mapping" has type
  IOThreadVirtQueueMappingList, which is a list of struct
  IOThreadVirtQueueMapping.  Property defined in hw/block/virtio-blk.c
  virtio_blk_properties[] using macro
  DEFINE_PROP_IOTHREAD_VQ_MAPPING_LIST defined in
  qdev-properties-system.[ch].

In case you're curious how I fond them...  First, I collected device
help:

    $ for i in `upstream-qemu -nodefaults -S -display none -device help | s=
ed -n 's/^name "\([^"]*\)".*/\1/p'`; do upstream-qemu -nodefaults -S -displ=
ay none -device $i,help; done >dev-help

Then I extracted the type names:

    $ sed -n 's/.*=3D<\([^>]*\)>.*/\1/p' <dev-help | sort -u

Most of them "obviously" name scalars, QOM children or QOM links.
There's also crap like "list".  The promising ones are the ones
conforming to QAPI naming rules for types.

Look for them in the schema, drop the enums, and what's left are
non-scalar properties.

Since the type names are whatever the developer made up on the spot, my
search *can* miss non-scalar properties.

I didn't look at targets other than x86_64.

> We definitely have some examples elsewhere for exmaple "Machine" class
> has an SmpCacheProperties array property, and the QAuthZList class
> has an array of "QAuthZListRule" property.
>
> In both cases the struct is defined in th qapi/<blah>.json, which
> auto-generates code eg visit_type_QAuthZListRuleList, which can
> then get called from qauthz_list_prop_get_rules and
> qauthz_list_prop_set_rules, for the property.
>
> Devices use a slightly higher level wrapper so instead of calling
> object_class_property_add directly, then define the PropertyInfo
> and object_class_property_add gets called indirectly for them.
> I'm thinking it should still be possible to use the QAPI code
> generator to help though. You could either just define the struct,
> and thn use that to create  PropertyInfo to be used in combination
> with DEFINE_PROP_ARRAY, of you could define a list of structs at
> the QAPI level and use plain DEFINE_PROP. I guess the former is
> probably better aligned with other Device code.

Of the three instances I found, one uses such a qdev property machinery
(what you called "a slightly higher level wrapper"), and two do not.

Not sure what to recommend.


