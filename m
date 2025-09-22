Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4C5CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hRr-0005DQ-SN; Mon, 22 Sep 2025 10:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0hRp-0004wy-Rz
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0hRh-0007Yr-Hq
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758550991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BSZkpSpiwrlLPfnAJecu98l//DJ4VKORCIQRn5Jnh6E=;
 b=EUW2kNQ9T6XpjA0r2BQ54T3eibXqvPMhP7BoIxURktcqJGaZ9paIUSTEKuXKKqf6JxUAJz
 WCrADzT0345ErUdr3AAWqdeB/JV/9vxjvsjdz4KcaJ7fUHdnc7zKs73LLmjoi+yT0upIRX
 SvPtTkTWF8utgnqxhhbO5EOuemKQG6A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-eUXbtIDxPw-4edaH7J6OJQ-1; Mon,
 22 Sep 2025 10:23:07 -0400
X-MC-Unique: eUXbtIDxPw-4edaH7J6OJQ-1
X-Mimecast-MFC-AGG-ID: eUXbtIDxPw-4edaH7J6OJQ_1758550986
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B3A1180057F; Mon, 22 Sep 2025 14:23:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 594203000198; Mon, 22 Sep 2025 14:23:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E60121E6A27; Mon, 22 Sep 2025 16:23:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alessandro Ratti <alessandro.ratti@gmail.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alessandro Ratti
 <alessandro@0x65c.net>, philmd@linaro.org
Subject: Re: [PATCH v2] virtio: Add function name to error messages
In-Reply-To: <CAKiXHKe07RKxBUCqfTFYkaGRj6T-avnS4C5=WcUqevD9eBQ4_g@mail.gmail.com>
 (Alessandro Ratti's message of "Mon, 22 Sep 2025 15:37:47 +0200")
References: <87a52wqa03.fsf@draig.linaro.org>
 <20250915162643.44716-1-alessandro@0x65c.net>
 <20250915162643.44716-2-alessandro@0x65c.net>
 <87h5wulqm2.fsf@pond.sub.org> <aNEpVhkZ2r5e2Z9X@redhat.com>
 <87wm5qoig7.fsf@draig.linaro.org> <877bxqk6vp.fsf@pond.sub.org>
 <CAKiXHKe07RKxBUCqfTFYkaGRj6T-avnS4C5=WcUqevD9eBQ4_g@mail.gmail.com>
Date: Mon, 22 Sep 2025 16:23:02 +0200
Message-ID: <87a52mh8hl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Alessandro Ratti <alessandro.ratti@gmail.com> writes:

> On Mon, 22 Sept 2025 at 14:29, Markus Armbruster <armbru@redhat.com> wrot=
e:
>>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >
>> >> On Mon, Sep 22, 2025 at 12:37:57PM +0200, Markus Armbruster wrote:
>> >>> Alessandro Ratti <alessandro@0x65c.net> writes:
>> >>>
>> >>> > Replace virtio_error() with a macro that automatically prepends the
>> >>> > calling function name to error messages. This provides better cont=
ext
>> >>> > for debugging virtio issues by showing exactly which function
>> >>> > encountered the error.
>> >>> >
>> >>> > Before: "Invalid queue size: 1024"
>> >>> > After:  "virtio_queue_set_num: Invalid queue size: 1024"
>> >>> >
>> >>> > The implementation uses a macro to insert __func__ at compile time,
>> >>> > avoiding any runtime overhead while providing more specific error
>> >>> > context than a generic "virtio:" prefix.
>> >>>
>> >>> A need for function names and such in error messages suggests the er=
ror
>> >>> messages are crap.
>> >>
>> >> I pretty much agree. If we take that view forwards, then I think our
>> >> coding guidelines should explicitly state something like
>> >>
>> >>  "Function names must never be included in error messages.
>> >>
>> >>   The messages need to be sufficiently descriptive in their
>> >>   text, such that including function names is redundant"
>>
>> I'm in favor.
>>
>> > Ahh I missed the fact this ends up as an error_report. I think having
>> > function names in debug output is fine.
>>
>> No argument!
>>
>> > It does however miss important information like which VirtIO device is
>> > actually failing, despite having vdev passed down to the function.
>>
>> Yes, which device failed should definitely be reported.
>>
>> [...]
>
> Hi Markus, Alex, Daniel,
>
> Thanks again for the thoughtful feedback and for helping me see the bigger
> picture. I now fully agree that adding function names to error messages (=
via
> __func__) doesn't really address the core issue, and I appreciate the
> push to rethink how error reporting can better serve both users and devel=
opers.
>
> I've taken a first stab at improving one of the messages in
> virtio_init_region_cache(), following your suggestions.
>
> Here's the updated call:
>
> ---8<--- Example diff --8<---
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -240,6 +240,7 @@ void virtio_init_region_cache(VirtIODevice *vdev, int=
 n)
>      VirtQueue *vq =3D &vdev->vq[n];
>      VRingMemoryRegionCaches *old =3D vq->vring.caches;
>      VRingMemoryRegionCaches *new =3D NULL;
> +    DeviceState *dev =3D DEVICE(vdev);
>      hwaddr addr, size;
>      int64_t len;
>      bool packed;
> @@ -264,7 +265,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, in=
t n)
>      len =3D address_space_cache_init(&new->used, vdev->dma_as,
>                                     vq->vring.used, size, true);
>      if (len < size) {
> -        virtio_error(vdev, "Cannot map used");
> +        virtio_error(vdev,
> +                    "Failed to map used ring for device %s - "
> +                    "possible guest misconfiguration or insufficient mem=
ory",
> +                    qdev_get_dev_path(dev));
>          goto err_used;
>      }
>
> With this change, the error output now reads:
>
>     qemu-system-x86_64: Failed to map used ring for device
> 0000:00:04.0 - possible guest misconfiguration or insufficient memory
>
> This feels like a clear improvement =E2=80=94 it gives context (what fail=
ed),
> identifies the device, and hints at likely causes.

It's *much* better!

Developers will appreciate "Failed to map used ring for device".  By
itself it would still be gobbledygook for users, but together with the
"possible guest misconfiguration or insufficient memory" clue it's fine.

Perhaps we can still improve on "device 0000:00:04.0".  The device's ID
is a good way to identify it to the user, because it's chosen by the
user, and unique (among devices).  Sadly, devices without ID exist.  We
fall back to canonical QOM path in places.  Have a look at
qdev_get_human_name() to see whether it works here.

Should we spell out that the device is now broken (whatever vdev->broken
means)?

> If this is more in line with what you'd expect, I'd be happy to submit a =
new
> patch focused solely on improving a few key virtio error messages in this
> direction, starting with the worst offenders in virtio_init_region_cache(=
).
>
> Thanks again for your time and guidance =E2=80=94 I'm learning a lot from=
 this process.

You're welcome!  And thank you for accepting my little rant as
constructive criticism :)


