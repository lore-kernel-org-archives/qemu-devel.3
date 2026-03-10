Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ABAEB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 11:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzurn-0001d9-8C; Tue, 10 Mar 2026 07:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzurj-0001cU-B6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzurg-00049l-Ds
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773140582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06VdzrnGqfIaPqfmLt3aygF27v/kaYNW/vZppX8ksMw=;
 b=Pgd1lc2L1UbBNCK02pV6BGG2Wq/L7MqSpviGmiKomrDmG2cmJI2DGwgYqnd2ki1M6i0dgu
 qLM4psaFisajdNLr5X2yUoAt980PqWITeLIwCEXs49hjdawDIvy8oJjh+Cb+RustgxNZ2p
 RAfUEDLEHIgbkrGU/xu787C1CBU0I14=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-xJjdC0AUMhyOvMVn3__GNw-1; Tue,
 10 Mar 2026 07:02:59 -0400
X-MC-Unique: xJjdC0AUMhyOvMVn3__GNw-1
X-Mimecast-MFC-AGG-ID: xJjdC0AUMhyOvMVn3__GNw_1773140578
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48A9A1956094; Tue, 10 Mar 2026 11:02:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7069F19560A6; Tue, 10 Mar 2026 11:02:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 00BDE21E6614; Tue, 10 Mar 2026 12:02:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alessandro
 Ratti <alessandro@0x65c.net>,  alessandro.ratti@gmail.com,
 alex.bennee@linaro.org,  mst@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3] virtio: improve virtqueue mapping error messages
In-Reply-To: <CAFEAcA9oKbFi7hBvKcz_v_xWtHaPz4n3Q_cVEai1F1kZnr5PiA@mail.gmail.com>
 (Peter Maydell's message of "Sat, 7 Mar 2026 13:39:33 +0000")
References: <aNLIHOwcGB47qbUY@redhat.com>
 <20250924093138.559872-1-alessandro@0x65c.net>
 <20250924093138.559872-2-alessandro@0x65c.net>
 <aNO7J7Y6wsk1-wyw@redhat.com>
 <CAFEAcA9oKbFi7hBvKcz_v_xWtHaPz4n3Q_cVEai1F1kZnr5PiA@mail.gmail.com>
Date: Tue, 10 Mar 2026 12:02:54 +0100
Message-ID: <87a4wgc5gh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 24 Sept 2025 at 10:37, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>>
>> On Wed, Sep 24, 2025 at 11:14:04AM +0200, Alessandro Ratti wrote:
>> > Improve error reporting when virtqueue ring mapping fails by including=
 a
>> > device identifier in the error message.
>> >
>> > Introduce a helper qdev_get_printable_name() in qdev-core, which retur=
ns
>> > either:
>> >
>> >  - the device ID, if explicitly provided (e.g. -device ...,id=3Dfoo)
>> >  - the QOM path from qdev_get_dev_path(dev) otherwise
>> >  - "<unknown device>" as a fallback when no identifier is present
>> >
>> > This makes it easier to identify which device triggered the error in
>> > multi-device setups or when debugging complex guest configurations.
>> >
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
>> > Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
>> >
>> > Suggested-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
>> > ---
>> >  hw/core/qdev.c         | 29 +++++++++++++++++++++++++++++
>> >  hw/virtio/virtio.c     | 15 ++++++++++++---
>> >  include/hw/qdev-core.h |  1 +
>> >  3 files changed, 42 insertions(+), 3 deletions(-)
>>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Hi; I just found this commit (now e209d4d7a31b9) in the course
> of finding a memory leak in it. I'm about to send patches to fix
> that, but in the meantime:
>
> We now have two different functions for "give me a nice string
> that I can use in an error message about this device":
>
>  * qdev_get_human_name(), used only in hw/block/block.c
>  * qdev_get_printable_name(), used only in hw/virtio/virtio.c
>
> Can we please have *one* function for this purpose?

Sensible request.

> I see from the thread that the criticism of qdev_get_human_name()
> is that "it often returns opaque paths like
>
>    /machine/peripheral-anon/device[0]/virtio-backend
>
> which are less informative in user-facing logs compared to PCI IDs or
> user-specified names".
>
> So could we instead make block.c use qdev_get_printable_name(), and
> remove qdev_get_human_name() ? It also is using the result only
> to construct an error string for the user.

No, not without significant improvements to qdev_get_printable_name().

Let's have a closer look.


First qdev_get_human_name():

    char *qdev_get_human_name(DeviceState *dev)
    {
        g_assert(dev !=3D NULL);

        return dev->id ?
               g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
    }

This returns the device's ID if it has one, else its canonical QOM path.

Intepreting the value is easy enough: if it starts with '/', it's a
canonical QOM path, else a qdev ID.

Devices plugged by the user have an ID if the user specified one.  If
they don't have one, the canonical path will be
/machine/peripheral-anon/device[N], where N is a non-negative integer.
Gibberish, but easy enough to avoid: specify an ID.  Management
applications should do that always.

Onboard devices do not have an ID.  The return value could be something
relatively reasonable like /machine/soc/cpu, or gibberish like
/machine/unattached/device[N].


Next qdev_get_printable_name():

    const char *qdev_get_printable_name(DeviceState *vdev)

Nitpick: @vdev is an unusual identifier.  We normally use @dev around
here.

    {
        /*
         * Return device ID if explicity set
         * (e.g. -device virtio-blk-pci,id=3Dfoo)
         * This allows users to correlate errors with their custom device
         * names.
         */
        if (vdev->id) {
            return vdev->id;
        }

Same as qdev_get_human_name() so far.

        /*
         * Fall back to the canonical QOM device path (eg. ID for PCI
         * devices).
         * This ensures the device is still uniquely and meaningfully
         * identified.
         */
        const char *path =3D qdev_get_dev_path(vdev);
        if (path) {
            return path;
        }

This returns a "name" in a bus-specific format if the device is plugged
into a bus that provides the get_dev_path() method.  Many buses do.

For instance, the PCI bus's method is cibus_get_dev_path().  It appears
to return a path of the form

    Domain:00:Slot.Function:Slot.Function....:Slot.Function.

which is commonly just a PCI address.

The comment is nonsense: this has nothing to do with "the canonical QOM
device path".

        /*
         * Final fallback: if all else fails, return a placeholder string.
         * This ensures the error message always contains a valid string.
         */
        return "<unknown device>";

This fallback is is unnecessarily bad.  The canonical QOM path always
exists and would be far better.

    }

Intepreting the value can be difficult: we have some twenty
.get_dev_path() methods, and each of them can format however it wants.
You need to guess the format to make sense of the value.


Neither function is ideal.  But in their current state, I *strongly*
prefer qdev_get_human_name(), because I hate having to decipher a QOM
path less than having to guess what kind of device this might be, then
figure out what format its .get_dev_path() uses.

If someone posts a patch to fix the shortcomings of
qdev_get_printable_name() I outlined above, we can talk.


