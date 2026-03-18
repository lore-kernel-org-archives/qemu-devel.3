Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DED0FCD0C1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2kxD-0004Va-V0; Wed, 18 Mar 2026 03:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2kx7-0004P0-Q4
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 03:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2kx5-0002CB-4a
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 03:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773817459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6W/bWXTuFUqd3Xy1AArmgNcL8Adju5I7FKYhUPJ9Te4=;
 b=BSCx9qENQOUU14rn6N1LE0YPn/6Chr+4WsEzlA5yp2jHl6bmo7c3W45Ng9JG39ivSUn/mo
 H7FsGAfY9HQ+O6REZa5jTk30wb0MI6sIrVzoLKz656xAeMw2gLz6VK9ac0P4DdLy2LY897
 ByL7hIE0r61lVIrUMCWS/7IId9hn4c0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-9ff9mFV9O3mKLmBNM0Ygig-1; Wed,
 18 Mar 2026 03:04:13 -0400
X-MC-Unique: 9ff9mFV9O3mKLmBNM0Ygig-1
X-Mimecast-MFC-AGG-ID: 9ff9mFV9O3mKLmBNM0Ygig_1773817452
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EEC41800283; Wed, 18 Mar 2026 07:04:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E18030001A1; Wed, 18 Mar 2026 07:04:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2A3E21E6937; Wed, 18 Mar 2026 08:04:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  berrange@redhat.com,
 mst@redhat.com,  pbonzini@redhat.com
Subject: Re: [PATCH v2 2/2] hw/qdev: Remove qdev_get_human_name()
In-Reply-To: <CAKiXHKd15rFWk3qM+f_X2JXr29u1ygTumCcGrm9iDLEtwALQNQ@mail.gmail.com>
 (Alessandro Ratti's message of "Tue, 17 Mar 2026 22:38:48 +0100")
References: <20260311215003.664815-1-alessandro@0x65c.net>
 <20260311215003.664815-3-alessandro@0x65c.net>
 <87h5qflyqe.fsf@pond.sub.org>
 <CAKiXHKd15rFWk3qM+f_X2JXr29u1ygTumCcGrm9iDLEtwALQNQ@mail.gmail.com>
Date: Wed, 18 Mar 2026 08:04:08 +0100
Message-ID: <87wlz9r53r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Alessandro Ratti <alessandro@0x65c.net> writes:

> On Tue, 17 Mar 2026 at 08:08, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Alessandro Ratti <alessandro@0x65c.net> writes:
>>
>> > Remove qdev_get_human_name() and switch its two callers in
>> > hw/block/block.c to qdev_get_printable_name().
>> >
>> > qdev_get_printable_name() subsumes qdev_get_human_name(): both
>> > return the device ID when set and fall back to the canonical QOM
>> > path, but qdev_get_printable_name() also tries the bus-specific
>> > device path first, providing more informative output.
>> >
>> > Narrow the scope of dev_id in blk_check_size_and_read_all() to the
>> > blocks where it is actually used.
>> >
>> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
>>
>> This replaces two ways to describe a device to the user by one.  Good.
>>
>> One half of the uses is unchanged.  Good.
>>
>> The other half can now show a bus-specific device path instead of the
>> canonical QOM path.  This path can be difficult to interpret: we have
>> some twenty .get_dev_path() methods, and each of them can format however
>> it wants.  I need to guess the format to make sense of the value.  I'm
>> inclined to call this a regression.
>>
>> To address this, please insert another patch before this one that
>> changes
>>
>>         device <dev-path>
>>
>>   to
>>
>>         <bus> device <dev-path>
>>
>> This removes the guesswork, and actually satisfies the claim "more
>> informative output".
>>
>
> Will do. I've prototyped this using object_get_typename() on
> dev->parent_bus to get the bus type.
>
> A complication: a few buses (virtio-pci-bus, ufs-bus) delegate
> get_dev_path() to their parent unchanged,

Like so:

    static char *ufs_bus_get_dev_path(DeviceState *dev)
    {
        BusState *bus = qdev_get_parent_bus(dev);

        return qdev_get_dev_path(bus->parent);
    }

>                                           so the path format doesn't
> match the immediate bus type.

Well, what *is* the immediate bus type's path format?

Does it even have one?

>                               I detect delegation by comparing the
> child's path to the parent bus's path, and format as
> "<child-bus> on <parent-bus> device <path>".

Hmm.

> Tested with i440fx + virtio-blk + UFS + USB + SCSI:
>
>   PCI device 0000:00:04.0
>   virtio-pci-bus on PCI device 0000:00:04.0
>   ufs-bus on PCI device 0000:00:04.0
>   SCSI device 0000:00:04.0/0:0:0
>   usb-bus device 0000:00:03.0/1
>
> And with Q35:
>
>   PCIE device 0000:00:04.0
>   virtio-pci-bus on PCIE device 0000:00:04.0
>   ufs-bus on PCIE device 0000:00:04.0
>   SCSI device 0000:00:04.0/0:0:0

Note the dev path format PARENT-DEV-PATH/BUS-ADDRESS.

The parent device happens to be a PCI device, so PARENT-DEV-PATH is a
PCI address, which is unique within the machine.

>   usb-bus device 0000:00:03.0/1

Likewise.

ufs-bus does just PARENT-DEV-PATH.  Clashes with the parent device's dev
path, and also with sibling buses if the parent device provides more
than one ufs-bus.  Prefixing with the bus type disambiguates parent and
child, but not siblings.  I don't like this at all.

The stupidest patch I can think of: PARENT-DEV-PATH/NUMBER, where NUMBER
enumerates the siblings.

> If my understanding is correct, VMBus delegates to sysbus which has
> no get_dev_path(), so it falls through to the QOM path.

.get_dev_path()'s contract:

    /**
     * qdev_get_dev_path(): Return the path of a device on its bus
     * @dev: device to get the path of
     *
     * Returns: A newly allocated string containing the dev path of
     * @dev. The caller must free this with g_free().
     * The format of the string depends on the bus; for instance a
     * PCI device's path will be in the format::
     *
     *   Domain:00:Slot.Function:Slot.Function....:Slot.Function
     *
     * and a SCSI device's path will be::
     *
     *   channel:ID:LUN
     *
     * (possibly prefixed by the path of the SCSI controller).
     *
     * If @dev is NULL or not on a bus, returns NULL.
     */

This looks decent at first glance, but it's actually quite woolly.

What's a "path on a bus"?

Is it unique within the machine?

For what it's worth, the PCI device path shown as example is.

The SCSI device path isn't, unless it's actually "prefixed by the path
of the SCSI controller", *and* that path is unique.  Code:

    static char *scsibus_get_dev_path(DeviceState *dev)
    {
        SCSIDevice *d = SCSI_DEVICE(dev);
        DeviceState *hba = dev->parent_bus->parent;
        char *id;
        char *path;

        id = qdev_get_dev_path(hba);
        if (id) {
            path = g_strdup_printf("%s/%d:%d:%d", id, d->channel, d->id, d->lun);
        } else {
            path = g_strdup_printf("%d:%d:%d", d->channel, d->id, d->lun);
        }
        g_free(id);
        return path;
    }

The returned path is unique within the machine only when
get_dev_path(hba) is non-null and unique.

I smell a dung pile.

I think your idea to add "on PARENT-DEV-PATH" papers over
.get_dev_path() defects we should fix instead.  I'm not demanding *you*
fix them all.

How would you code qdev_get_printable_name() if qdev_get_dev_path()
either returns null or a string that together with the bus type uniquely
identifies the device?

> Note: object_get_typename() gives "PCI" on i440fx and "PCIE" on Q35
> for the same address format. Not sure if that's confusing enough to
> warrant normalizing.

Feels okay to me.

>> qdev_get_human_name() is a better name than qdev_get_printable_name().
>> Please consider renaming the function so we keep the better name.
>>
>
> Ack, will rename.
>
> If my proposal to add "<bus> device" prefix sounds solid,
> I'll send a v3 with the series restructured as:
>
>   1. Replace "<unknown device>" with canonical QOM path, clean up comments
>   2. Add "<bus> device" prefix to bus-specific paths
>   3. Consolidate into qdev_get_human_name()

Sounds good!

> Thanks for your time and consideration.
>
> Best regards,
> Alessandro

Thank you!


