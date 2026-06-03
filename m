Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3E5CD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 10:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUim0-0000BB-4m; Wed, 03 Jun 2026 06:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUilw-0000AW-Df
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 06:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUilu-0006jF-SS
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 06:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780482265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6nHcwHbFEgFNU9EyDFxom5nyPaw7sIvXcWBeVhgwqU=;
 b=DCe+iTj6g/pkCwYAQ6SAEYh37qBFNHJp5yziiZvAj3mD5JyuE2Tf8BuSBwXemDvWOhInkq
 z7uuipNITYr/z4Y/em9+HWnjPA6I2PheJo+ZgJsgItBUaz4oPrDloiZ/5m/gBRiMWIjRII
 w888SUJPKGCVH+m+8Q6ksmht5mpQ4hQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-m8OMIHYYOAS6WUyNAAWYtg-1; Wed,
 03 Jun 2026 06:24:11 -0400
X-MC-Unique: m8OMIHYYOAS6WUyNAAWYtg-1
X-Mimecast-MFC-AGG-ID: m8OMIHYYOAS6WUyNAAWYtg_1780482251
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7137E19560A5; Wed,  3 Jun 2026 10:24:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1629630001A1; Wed,  3 Jun 2026 10:24:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 70FCA21E6A01; Wed, 03 Jun 2026 12:24:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Bin Guo <guobin@linux.alibaba.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] qobject/json-writer: preallocate output buffer
In-Reply-To: <ah_5WNdgge7hXXDW@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 3 Jun 2026 10:52:24 +0100")
References: <20260529023426.54680-1-guobin@linux.alibaba.com>
 <87ldcx5oik.fsf@pond.sub.org> <ah_5WNdgge7hXXDW@redhat.com>
Date: Wed, 03 Jun 2026 12:24:07 +0200
Message-ID: <878q8vly60.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jun 02, 2026 at 10:34:43AM +0200, Markus Armbruster wrote:
>> Bin Guo <guobin@linux.alibaba.com> writes:
>>=20
>> > json_writer_new() creates the output GString with g_string_new(NULL),
>> > which starts at the GLib default of 64 bytes.  Serializing typical
>> > QMP responses then requires multiple reallocations as the buffer
>> > grows -- for query-qmp-schema the GString is reallocated 12+ times.
>>=20
>> That's an extreme case.  Most responses are *much* smaller.  Still,
>> starting with a larger buffer makes sense.
>>=20
>> > Preallocate JSON_WRITER_INITIAL_SIZE (4096) bytes.  This covers
>> > most QMP responses without any reallocation.  4096 is one page on
>> > most systems, which is efficient for the allocator.
>>=20
>> I doubt "one page" matters.  How many QMP commands get executed in
>> practice?  A couple of hundred during startup, then tens per second?
>> Probably less than that.
>
> NB tens per second, repeated across possibly 100's or even 1000's of
> VMs on the single host though.
>
> If we want an arbitrary moderately size buffer, one page feels like
> a reasonable place to aim for

I think 4KiB is a reasonable initial size regardless of the host's page
size.  That was my argument.

If we care, we can instrument QEMU to gather response size statistics.

[...]


