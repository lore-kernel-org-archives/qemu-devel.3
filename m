Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C470606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aD/eM5V2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQRQ-0008Tr-DP; Thu, 29 Oct 2026 09:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMQRJ-0008PN-2v
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMQRG-000212-O8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793281504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TExQVY8uJLu05cfh+DwKfx4cQV/q4bQj6zJwyO/danU=;
 b=aD/eM5V2C35TzD93L21JUeeJ5EIFQjsGLCdj75b+0QpIV076X2NNEEMqJ40RDv4cdBB+JN
 BuaPVUe/zn03E065oENITS9dLR0TmwfACarG6hftM9xAtJRe/vHyUhe49paTbFpXgfZDfz
 yCmZ8m5dLGAVCM/OZWfl8F9ZHqzzZlk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-ttN6_xG5Mqen6IX3VfwMAw-1; Thu,
 29 Oct 2026 09:44:56 -0400
X-MC-Unique: ttN6_xG5Mqen6IX3VfwMAw-1
X-Mimecast-MFC-AGG-ID: ttN6_xG5Mqen6IX3VfwMAw_1793281496
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5DBC1954206; Thu, 29 Oct 2026 13:44:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B0BF472; Thu, 29 Oct 2026 13:44:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D872D21E6A04; Thu, 29 Oct 2026 14:44:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  John Snow
 <jsnow@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: ObjectPropertyInfo design
In-Reply-To: <87pkwujbhf.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 28 Oct 2026 12:44:28 +0100")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <87ik2tj0g3.fsf@pond.sub.org>
 <CAMxuvazmyYb4d7neLQP4v4ZoKZfQfD1iDqA4gtC+QV5nBCging@mail.gmail.com>
 <87pkwujbhf.fsf@pond.sub.org>
Date: Thu, 29 Oct 2026 14:44:52 +0100
Message-ID: <871p98d3jf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> [Possible improvement to the QAPI/QMP QOM introspection interface...]
>
>>> Thoughts?
>>
>> I like it overall.
>>
>> But this goes beyond the intended scope of the series.
>> Blending/merging QOM type & QAPI type would warrant more design
>> research. So covering child<> & link<> are out of scope of the current
>> qom-qapi series. I think the addition of qapi-type shouldn't be
>> incompatible with a future proposal, after all all properties should
>> have some 'wire' type (link/child are paths). But we can drop it for
>> now or just rename it x-qapi-type until we agree on the new
>> introspection.
>>
>> my2c
>
> Adding @qapi-type with feature unstable means we don't have to worry
> about the external interface now.  One less hurdle for merging.  I like
> it.
>
> Whether changing the @type values is safe remains somewhat unclear.  See
>
>     Subject: Property types changed in this series (was: [PATCH v7 00/65]=
 Hi)
>     Date: Wed, 21 Oct 2026 18:29:40 +0200
>     Message-ID: <87tsmfkoej.fsf@pond.sub.org>

We're about to miss the soft freeze.  Not your fault; I've been awfully
slow reviewing this.

The series is quite big.  If we can't get it merged, we'll have to
rebase and update it.  Not good.

Here's a possible way forward:

1. We tweak this series to retain the existing @type values.

   As is, the series changes @type to the QAPI type where applicable.
   This is an improvement, and *probably* safe enough, but I'm reluctant
   to accept the risk this late in the development cycle.

   I can do the tweaking.  It'll be mildly icky, but should go away
   fairly soon.

2. We mark @qapi-type unstable for now.

3. Try hard to get it merged in time for 11.2.

We can then improve on top at our leisure:

* If we convince ourselves that changing @type values is worthwhile and
  safe enough, do so early in a development cycle.

* Hunt down the remaining properties that don't use a QAPI type.

* Explore more comprehensive improvements to QOM introspection.

* Settle on a new QOM introspection interface, deprecate the old crap.

What do you think, Marc-Andr=C3=A9?


