Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511ECCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13A0-0007Np-Nc; Tue, 23 Sep 2025 09:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v139y-0007M9-Ph
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 09:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v139m-0000Fs-Re
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 09:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758634444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTrWmxcETLJ2e8j3Sdnb4XPGKEp8ZerxUfv11lHxP3Q=;
 b=P7TqCZhtlB2ixEDTBo/fPHZLb7gSSGRQf3o+FlUGYGTKlEgkCiW0E4AvUZOzl5k0RIkp73
 qkvdMHMkPYeNjDL4+jDz+UKEPtRyY9GhTA3+oUWwPAJEfqAbnYV5wxl3V+scKHrHxJqQJ6
 I15dk++NgKiWWXJfJz5OgdNkbK7fAfE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-VKw0cr9vNL-gDPeZYCfjYA-1; Tue,
 23 Sep 2025 09:34:01 -0400
X-MC-Unique: VKw0cr9vNL-gDPeZYCfjYA-1
X-Mimecast-MFC-AGG-ID: VKw0cr9vNL-gDPeZYCfjYA_1758634440
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98B3518004D4; Tue, 23 Sep 2025 13:33:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18DCF19560BB; Tue, 23 Sep 2025 13:33:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 43DA921E6A27; Tue, 23 Sep 2025 15:33:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9?= <berrange@redhat.com>,  philmd@linaro.org
Subject: Re: [PATCH v2] virtio: Add function name to error messages
In-Reply-To: <CAKiXHKfQYKRu6MDCJdgiAhv2rxj8hnvQE+GXQsxtnK5R7F5d5g@mail.gmail.com>
 (Alessandro Ratti's message of "Tue, 23 Sep 2025 11:42:44 +0200")
References: <87a52wqa03.fsf@draig.linaro.org>
 <20250915162643.44716-1-alessandro@0x65c.net>
 <20250915162643.44716-2-alessandro@0x65c.net>
 <87h5wulqm2.fsf@pond.sub.org> <aNEpVhkZ2r5e2Z9X@redhat.com>
 <87wm5qoig7.fsf@draig.linaro.org> <877bxqk6vp.fsf@pond.sub.org>
 <CAKiXHKe07RKxBUCqfTFYkaGRj6T-avnS4C5=WcUqevD9eBQ4_g@mail.gmail.com>
 <87a52mh8hl.fsf@pond.sub.org>
 <CAKiXHKfQYKRu6MDCJdgiAhv2rxj8hnvQE+GXQsxtnK5R7F5d5g@mail.gmail.com>
Date: Tue, 23 Sep 2025 15:33:56 +0200
Message-ID: <87y0q58f97.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Alessandro Ratti <alessandro@0x65c.net> writes:

> On Mon, 22 Sept 2025 at 16:23, Markus Armbruster <armbru@redhat.com> wrot=
e:
>>
>> Alessandro Ratti <alessandro.ratti@gmail.com> writes:
>>
>> > Hi Markus, Alex, Daniel,
>> >
>> > Thanks again for the thoughtful feedback and for helping me see the bi=
gger
>> > picture. I now fully agree that adding function names to error message=
s (via
>> > __func__) doesn't really address the core issue, and I appreciate the
>> > push to rethink how error reporting can better serve both users and de=
velopers.
>> >
>> > I've taken a first stab at improving one of the messages in
>> > virtio_init_region_cache(), following your suggestions.
>> >
>> > Here's the updated call:

[...]

>> > With this change, the error output now reads:
>> >
>> >     qemu-system-x86_64: Failed to map used ring for device
>> > 0000:00:04.0 - possible guest misconfiguration or insufficient memory
>> >
>> > This feels like a clear improvement =E2=80=94 it gives context (what f=
ailed),
>> > identifies the device, and hints at likely causes.
>>
>> It's *much* better!
>>
>> Developers will appreciate "Failed to map used ring for device".  By
>> itself it would still be gobbledygook for users, but together with the
>> "possible guest misconfiguration or insufficient memory" clue it's fine.
>>
>> Perhaps we can still improve on "device 0000:00:04.0".  The device's ID
>> is a good way to identify it to the user, because it's chosen by the
>> user, and unique (among devices).  Sadly, devices without ID exist.  We
>> fall back to canonical QOM path in places.  Have a look at
>> qdev_get_human_name() to see whether it works here.
>
> I experimented with qdev_get_human_name(), but it usually returns paths l=
ike:
>
>   /machine/peripheral-anon/device[0]/virtio-backend
>
> =E2=80=A6which seems less user-friendly than the PCI address provided by
> qdev_get_dev_path().
> For now, I'm sticking to using the device ID when set (e.g. via -device=
=E2=80=A6,id=3Dfoo)
> and falling back to qdev_get_dev_path() otherwise =E2=80=94 which provide=
s predictable
> output for both PCI and non-PCI devices.

Note that qdev_get_dev_path() may return null.  You need another
fallback.

For what it's worth, "qdev ID or QOM path" is how users specify devices
in QMP.

[...]


