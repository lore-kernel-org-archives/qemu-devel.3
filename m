Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7120C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3V8u-0006iM-Oy; Mon, 07 Sep 2026 04:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3V8s-0006hU-Pm
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 04:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3V8q-00067K-7L
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 04:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788771350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5bsH4JVOIdSG44t0GSgJUXlu2Xpc7hHFUMLKgNg5Gg=;
 b=VvKIO4SQ64CWg7Dlsie7LC00If58JGEBJ10v7R13ocdlJ5Zi1LaJeaaUDsS/0uGEJPc4v6
 FQ6PQE+A5IwkjszpouY32jYpGd7bdSlWMpzL4+/uOMxO41ArwZCHuDCF8IqUoJOkfaogRA
 Zi4L4JPZgYB4yLjmbQnk4yBEE/mSXZw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-1tFEOTevPM6jckgr49Cdsg-1; Mon, 07 Sep 2026 04:55:49 -0400
X-MC-Unique: 1tFEOTevPM6jckgr49Cdsg-1
X-Mimecast-MFC-AGG-ID: 1tFEOTevPM6jckgr49Cdsg_1788771348
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4859233a9a4so1138907f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788771348; x=1789376148; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z5bsH4JVOIdSG44t0GSgJUXlu2Xpc7hHFUMLKgNg5Gg=;
 b=aF2ivTIqPRM3JrRauv9wUeUDEH9+pqzkLgfi/r5HqBo26t6gqx3TiYf5V6LEuGJWXk
 aYRVU3uAyjE1xRLitW7MKBbnZ9zW7TLtiVkio9t3QOdmgFn8Vw/cFmYjka+RpKopqMKK
 cXKjei21TyXuehZxD0CsgspqL5erSDWu7zUpnHvv9ozkgvf87vA4XuwM3ePugNUSzsVW
 fYBUZfZzdfcrOwK9Pl/43Sn67fzdakeKgbKltfY9jlqpxK+lcinNwxVO7xJVu9NfIz7l
 aQ0uv7d9z9povS/EQ3yswht707QIsy/ct2ffOtq06YFw2h5DHbPtMHKhR9nQHYwcamDt
 fBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788771348; x=1789376148;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z5bsH4JVOIdSG44t0GSgJUXlu2Xpc7hHFUMLKgNg5Gg=;
 b=FflAAe9VrWkMa2uPrtg+4pW/B2qrAOUEq+XlNrhNgx8+ruS01XX2tubHQJj4ae7/k7
 S4QEP5oXxyrOP0UfBg7ClkTgKj786o4XRv3myk20stCceprX79UMFdv5lVfdInHmQrBe
 IaS7g0qx4SyR9eMsPRMQz4NuPXVIw1WwikgdQ5smddhx++z+yx8Nobh6UQBO9wvj753l
 55xnns8q5az1NXSTCN5UsVbFJMTlCBVKkZDGexmYrkdnGNR36MZ+4qsHXZBOgB9PKRKr
 pjMtSxt+ixGK9x7TFAq/ZI9rST0H828lwFLkb8uC9X6ubvTQTgV9kZPS/Cp94cXbUh+X
 VZig==
X-Forwarded-Encrypted: i=1;
 AKwUvByhMAlKZk6yErgr+Ldo8iWHzf69o//Qt66ixunNa/qyoDfgQON9CRmYBbuYnyEEhGfSQPK6vU7PXPIb@nongnu.org
X-Gm-Message-State: AFuF++ljiemtbcE0FGcanYOnIA07ynFedrR2h+YNp0PGB5GhJUOJQ/fg
 CdYq8e66CFKtZm3JBpSIB54Twor1mRF2qV5pCWd0LXa/SifrNnfTCswP6mZwCWGtlNiqG7Ig76v
 bHnpHGFFs+x6Vf46YpnhiH03Rgh+2vE+RgH9qVcVMiohZlVT9TgzzQFwX
X-Gm-Gg: AYBFou2IQTZjNtedOiWW4ZAwXYyC4TaJPPiWyDyVhxeKOsz/2m6j7+MXgFKcH4Ch1BT
 dCUCiDGvh412iWG/ao//ihMZNc38JIlEXNW5F3Of1tZMGsV1Vw4feNOIbIkAQhdIK6xnSHEUUTv
 jspylc8CWM6mOi+uCaRM/YplmtHE4BgtIr6ZsdOxRzdwEFJGJrG8DDPeSeJJsA0lRtkBMiFTrzN
 MFj3GqIhyXYLZZik13WHXHJEkxSOrzcvxNDMUkZeZ2fA2H9Zl+IV8HrrBRTZJbwmOLM2ehJDhPo
 ztkJWnmMKn+uHtPTB417Ht8vyEG3d3cQ4MZePQZigzjSP1Xky270KJd71HpBSVhLRvZwcD/zGNu
 IOIFOb6QS2BwGJZ4HX5LGu+8=
X-Received: by 2002:a05:6000:1acb:b0:485:8b5d:96d with SMTP id
 ffacd0b85a97d-4858b5d0d2dmr33824040f8f.19.1788771347756; 
 Mon, 07 Sep 2026 01:55:47 -0700 (PDT)
X-Received: by 2002:a05:6000:1acb:b0:485:8b5d:96d with SMTP id
 ffacd0b85a97d-4858b5d0d2dmr33823972f8f.19.1788771347225; 
 Mon, 07 Sep 2026 01:55:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c5bc5sm28593436f8f.24.2026.09.07.01.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 01:55:46 -0700 (PDT)
Date: Mon, 7 Sep 2026 04:55:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, dave@treblig.org,
 anisinha@redhat.com, philmd@mailo.com, aurelien@aurel32.net,
 mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com, akrowiak@linux.ibm.com,
 jjherne@linux.ibm.com, sstabellini@kernel.org,
 anthony@xenproject.org, edgar.iglesias@gmail.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 joe.jin@oracle.com
Subject: Re: [PATCH 0/8] Force detach PCI devices for ACPI-based and PCIe
 native hot-unplug
Message-ID: <20260907044608-mutt-send-email-mst@kernel.org>
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <aoxY4Rxst2qAyn5z@redhat.com>
 <01ee4841-76d8-4749-a80e-eb945ab8799a@oracle.com>
 <20260903172835.0e253a25@imammedo>
 <6154b857-16b3-476b-a2cb-8837464dd4cb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6154b857-16b3-476b-a2cb-8837464dd4cb@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 07, 2026 at 01:26:57AM -0700, Dongli Zhang wrote:
> 
> 
> On Thu, Sep 3, 2026 8:28:35AM -0700, Igor Mammedov wrote:
> > On Wed, 26 Aug 2026 09:15:47 -0700
> > Dongli Zhang <dongli.zhang@oracle.com> wrote:
> > 
> >> On Mon, Aug 24, 2026 7:44:49AM -0700, Daniel P. Berrangé wrote:
> >> > On Sun, Aug 23, 2026 at 06:13:30PM -0700, Dongli Zhang wrote:  
> >> >> Hot-unplugging a PCI device can require cooperation from the guest. For
> >> >> ACPI PCI hotplug, QEMU notifies the guest through ACPI and the guest
> >> >> eventually writes the ACPI PCI eject register. For PCIe native hotplug,
> >> >> QEMU notifies the guest through the PCIe hotplug mechanism and waits for
> >> >> the slot unplug flow to complete. Only after that completion does QEMU
> >> >> unrealize the device and emit DEVICE_DELETED.
> >> >> 
> >> >> This can leave a device stuck in the unplug pending state when the guest
> >> >> does not cooperate. Examples include:
> >> >> 
> >> >> 1. The guest has panicked, or the relevant ACPI/PCI hotplug driver is
> >> >> unavailable.
> >> >> 
> >> >> 2. The guest is stalled and cannot handle the hot-unplug event. For
> >> >> example, stalling the Linux [irq/9-acpi] kernel thread can reproduce this
> >> >> for ACPI-based hot-unplug.
> >> >> 
> >> >> 3. The device was attached to a slot that the guest cannot use. For
> >> >> example, a pcie-root-port only supports slot 0. If a device is added to a
> >> >> non-zero slot below a pcie-root-port, the guest may never discover the
> >> >> device and therefore may never complete the unplug request.
> > 
> > all of above is actually expected, no (functioning) driver => no hotplug/unplug.
> > it's the guest problem. Once device it exposed to guest its life-cycle
> > not longer owned by QEMU.
> > 
> > That's what one would see in real hw as well, you press eject button
> > but it will not do anything if OS doesn't process it.
> > also see comment at the end.
> 
> Users are generally more tolerant of issues with real hardware.
> 
> In virtualization and cloud environments, PCI hotplug is more commonly used for
> NICs and storage devices. Users are less tolerant of disruption or unexpected
> failures.


Simply put, surprise removal exists in the hardware.  Emulating that
makes sense, at a high level. Nor is it too hard.
However, guests, especially Linux, do not
handle it all that well generally. Exactly because users
would tend to impatiently reach for that tool, then
blame QEMU after a crash, we avoided emulating that.


I'd expect much more in the way of research into how guests behave,
perhaps some ways to limit it to devices that work well, and
likely some linux patches to make it work better, before we commit to
supporting such interfaces.


> > 
> >> >> 
> >> >> The non-zero slot case has also been discussed in:
> >> >> 
> 
> [snip]
> 
> >> >   
> >> 
> >> Thank you very much!
> >> 
> >> I see that the issue has been fixed. The ticket mentions the following.
> >> 
> >> "What I am observing is that it seems when the slot ID != 0, the guest OS seems
> >> to ignore this and we never seem to hit ich9_pm_device_unplug_cb()."
> >> 
> >> Based on my experience and evaluation, ACPI-based hotplug is more likely to
> >> encounter an issue where the guest VM does not respond to an unplug operation.
> > 
> > I'm not sure it's a good idea to delete device when guest still thinks it's there
> > (you can make guesses on QEMU side if it's in use, how useful those are is questionable).
> 
> By instrumenting the QEMU functions related to device hotplug and PCI
> initialization, we may be able to make informed assumptions.

So try. But just know that pci initialization is commonly done by firmware, not
the driver.

> > 
> > as far as I know, ACPI hotplug has no notion of surprise removal (pls educate me if it's not the case),
> > so I wouldn't do what you are proposing here at all, it's basically asking for disaster to happen.
> > And all this is basically for dealing with abused qemu flexibility.
> > 
> > Please (re)formulate usecase and make it more clear as what is eludes me
> > no matter how many times i've read this cover letter.
> 
> Here are some use cases in virtualization and cloud environments:
> 
> 1. Suppose there is a QEMU user configuration error and a PCI device is attached
> to slot 1 of a pcie-root-port that uses ACPI-based hotplug. The device may not
> be detected or ejected. As a result, there is no way to detach it from the
> user's QEMU instance until the guest VM reboots.

sounds vague. if users can not configure qemu what are the chances
they will use force detach responsibly?

> 2. For an unknown reason in the customer's guest kernel (Linux, Windows, or
> BSD), a PCI device may still be referenced by the guest kernel or its services.
> As a result, the guest never writes the eject register for ACPI-based hotplug,
> and QEMU cannot detach the device. The customer may blame QEMU for not removing
> it. A force-detach option could provide an escape hatch, with a warning that it
> may make the VM unstable or insecure.

So just reboot the guest.

> 3. Suppose a VM is stuck because of a guest kernel bug, such as a Linux kernel
> panic without a kdump kernel being triggered. The guest kernel is unresponsive.
> Force detach could allow the block device to be temporarily attached to another
> VM without resetting the currently panicked VM.

So just reboot the guest.

> 4. Provide a mechanism to demonstrate that force detach is unsafe. Otherwise,
> users may repeatedly attempt it and mistakenly conclude that QEMU is at fault :)

We have that - we don't support unsafe detach.

> Thank you very much!
> 
> Dongli Zhang
> 
> > 
> > On positive note:
> > 
> > What you can try to implement is native PCI-E support for surprise removal.
> > How hard that would be I don't know. And I would well expect if one deviates from
> > real hw expectations/configs (such as not 0 slot/partial func removal),
> > one would quickly stumble upon issues as  that's not what what vendors write/test
> > drivers for.
> > 
> > Even if it's not likely to be used in practice (guest still might not support it),
> > it may serve as test-bed for guest drivers.
> > 
> >> Thank you very much!
> >> 
> >> Dongli Zhang
> >> 
> > 


