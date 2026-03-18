Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECD4FCD0C2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2kT3-0005S1-9C; Wed, 18 Mar 2026 02:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2kSz-0005RV-17
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2kSw-00084r-Ct
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773815592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RhnUJCsFP4+V67l0haM/Y96AFbcGNgGgT1BCamtFbk=;
 b=dl+7ie9zKbftj10IrT3JO8GyveTaNEjYtKZ2ockMrfu+Fyfl5GjTcm8h3ERuabKtctgjVh
 hC+wuAEGdoZUqZwKuzsoTc+MY9sPpbV15vL4Rxmicz48perC8yj1vzd/z2BJCFt2faZpIc
 yPlg4gQaHkgU6SgLVKhkUFw+ZNZPKJs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-xjE4GHBSM9uHWJWrFoVuSQ-1; Wed,
 18 Mar 2026 02:33:09 -0400
X-MC-Unique: xjE4GHBSM9uHWJWrFoVuSQ-1
X-Mimecast-MFC-AGG-ID: xjE4GHBSM9uHWJWrFoVuSQ_1773815588
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D9D419560AF; Wed, 18 Mar 2026 06:33:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 619B019560AB; Wed, 18 Mar 2026 06:33:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE85821E6937; Wed, 18 Mar 2026 07:33:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 peter.maydell@linaro.org,  berrange@redhat.com,  mst@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v2 2/2] hw/qdev: Remove qdev_get_human_name()
In-Reply-To: <CAKiXHKd15rFWk3qM+f_X2JXr29u1ygTumCcGrm9iDLEtwALQNQ@mail.gmail.com>
 (Alessandro Ratti's message of "Tue, 17 Mar 2026 22:38:48 +0100")
References: <20260311215003.664815-1-alessandro@0x65c.net>
 <20260311215003.664815-3-alessandro@0x65c.net>
 <87h5qflyqe.fsf@pond.sub.org>
 <CAKiXHKd15rFWk3qM+f_X2JXr29u1ygTumCcGrm9iDLEtwALQNQ@mail.gmail.com>
Date: Wed, 18 Mar 2026 07:33:04 +0100
Message-ID: <87bjglsl3z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This looks decent at a glance, but it's actually somewhat woolly.

>                               I detect delegation by comparing the
> child's path to the parent bus's path, and format as
> "<child-bus> on <parent-bus> device <path>".
>
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
>   usb-bus device 0000:00:03.0/1
>
> If my understanding is correct, VMBus delegates to sysbus which has
> no get_dev_path(), so it falls through to the QOM path.
>
> Note: object_get_typename() gives "PCI" on i440fx and "PCIE" on Q35
> for the same address format. Not sure if that's confusing enough to
> warrant normalizing.
>
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
>
> Thanks for your time and consideration.
>
> Best regards,
> Alessandro


