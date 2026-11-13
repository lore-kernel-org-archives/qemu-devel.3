Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245F1607E04F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N90JS6Cg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRuuS-0004Z2-QM; Fri, 13 Nov 2026 12:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xRuuN-0004We-Fg
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:17:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xRuuL-0001NN-Aw
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794590267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9zbfOVSAUnnvwsSo+YPdq9k4QWPhu8J0AUAIv8AfFyI=;
 b=N90JS6CgckjvJlrHk9HuvbzVr6sLYreSnks52ffWA78uCAkPIWsK64tj7B3gSes9f4HxNF
 tzNeBD9HiiG1PGDgO0QijTKM8NserKuJentp/kGh8aVfVLyb1ACJq6j+U2fyzGpvxFhxrq
 Z+FO1pZkdCFW6XdAMC8UP3s1613Kn+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-fhz4iGnqN7WqKVNDvmTMKA-1; Fri,
 13 Nov 2026 12:17:46 -0500
X-MC-Unique: fhz4iGnqN7WqKVNDvmTMKA-1
X-Mimecast-MFC-AGG-ID: fhz4iGnqN7WqKVNDvmTMKA_1794590265
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A049E1955F22; Fri, 13 Nov 2026 17:17:44 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.62])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BC1618004F5; Fri, 13 Nov 2026 17:17:41 +0000 (UTC)
Date: Fri, 13 Nov 2026 18:17:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com,
 mst@redhat.com, devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/4] virtio-blk: Deprecate silent truncation of serial
Message-ID: <avdGMxK84fVmXLFr@redhat.com>
References: <20261029231001.194240-1-kwolf@redhat.com>
 <259057b5-d900-4388-a4fc-b698860ba158@linux.ibm.com>
 <avcRG6PtcXbB0KvJ@redhat.com>
 <c853e800-00a8-4cea-afe9-dd00777bceeb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c853e800-00a8-4cea-afe9-dd00777bceeb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 13.11.2026 um 17:39 hat Christian Borntraeger geschrieben:
> Am 13.11.26 um 06:31 schrieb Kevin Wolf:
> > Am 09.11.2026 um 14:21 hat Christian Borntraeger geschrieben:
> > > Am 30.10.26 um 00:09 schrieb Kevin Wolf via Devel:
> > > > QEMU has allowed the user to specify serials of arbitrary length for
> > > > virtio-blk devices, even though the virtio-blk protocol can only
> > > > communicate 20 characters of the serial to the guest. This means that a
> > > > longer serial number on the command line is silently truncated to 20
> > > > characters from the guest perspective.
> > > > 
> > > > As a first step to fix this, deprecate the silent truncation and turn it
> > > > into a warning; we can later make this a hard error. While touching
> > > > GET_ID, let's make it more spec compliant and clean up the internal
> > > > state.
> > > > 
> > > > Another part is planned that will actually enable users to use longer
> > > > serials and additional device identifiers. This will need spec changes
> > > > and would take more time than we have until the QEMU 11.2 freeze anyway,
> > > > so I'll address this later. For now, the important thing is to get the
> > > > deprecation period started.
> > > 
> > > Consider me interested for future extensions.
> > > Additional information via virtio-blk would be really helpful. e.g. when
> > > forwarding a scsi LUN having the WWID visible for virtio-blk would be really
> > > nice. One usecase is that the guest visible WWID can be used to talk to
> > > the storage server to create snapshots without having to have a translation
> > > table from guest virtio-blk device to WWID. This was actually a real ask from
> > > a customer.
> > 
> > So let's talk about what specific information to add while we touch the
> > spec. My first thought was adding whatever two or three things scsi-disk
> > offers in qdev, but after actually looking at the code and the spec I'm
> > not so sure any more. We seem to have:
> > 
> > - vendor, product (standard INQUIRY data)
> > - serial (VPD page 0x80)
> > - device_id (VPD page 0x83, vendor-specific descriptor for LUN)
> > - wwn (VPD page 0x83, 64 bit NAA descriptor for LUN)
> > - port_wwn (VPD page 0x83, 64 bit NAA descriptor for SAS target port)
> > - port_index (VPD page 0x83, relative target port identifier for SAS target port)
> > 
> > For comparison, IDE seems to have:
> > 
> > - serial
> > - model
> > - wwn (64 bit NAA descriptor)
> > 
> > As virtio-blk is a single-disk device, it probably makes sense to leave
> > out the non-LUN descriptors from SCSI.
> > 
> > It's also unclear to me that serial vs. device_id is something that
> > would make sense in the context of virtio-blk. I don't really know how
> > to explain an additional device_id in the spec and what would make it
> > different from serial.
> > 
> > Maybe something like vendor/product/model would make sense where we
> > would return "QEMU" and other implementations can return a different
> > string (e.g. if guest drivers have to work around bugs in a specific
> > implementation). Probably just a single field.
> > 
> > And then finally the WWID, where scsi-hd and ide-hd agree that it's a
> > 64 bit number, but the SCSI spec is a lot more complicated. I think we
> > want to have this, but the exact format to use in the virtio spec isn't
> > entirely obvious. I've been thinking of maybe just referencing the SPC
> > and adding the SCSI name string to the spec, which can represent the
> > 64 bit NAA identifiers supported by scsi-hd and ide-hd, but can also
> > express a few more things.
> > 
> > Any thoughts on all of this?
> So I think the wwn is the most critical one.
> For example
> So the KVM host has scsi disks that appear in the guest as
> /dev/disk/by-id/wwn-0x6005076307ffd72c0000000000002079
> /dev/disk/by-id/dm-uuid-mpath-36005076307ffd72c0000000000002179
> 
> passing that through via virtio-blk does not provide this number in the guest.
> passing it along via virtio-scsi as lun I have the same udev device in the
> guest. Having the same for virtio-blk (maybe optionally) would be awesome.

I don't think having it passed through automatically would be a good
idea (migration compatibility etc.). I'm thinking of a qdev property
that lets you specify it, like the existing -device scsi-hd,wwn=...

> > > virtio SCSI LUN passthru has that but it is significantly slower
> > > (factors) and that was also real feedback from that customer.
> > 
> > Does this mean that what the emulated scsi-hd offers is actually not
> > good enough, but you have to use passthrough to enable this use case?
> > What is the additional information they need?

I can see above that your WWID is 128 bits, so what scsi-hd can pass to
the guest is probably not good enough (it's only 64 bit).

That seems to support the idea of using a SCSI name string instead, so
that you could specify something like:

    -device virtio-blk,drive=mydisk,scsi-name=naa.6005076307ffd72c0000000000002079

> It does mean that virtio-blk seems good enough (bandwidth and cpu
> wise) to consolidate database workloads in KVM and virtio-scsi is not.
> Just try fio on the same host nvme with virtio-blk, scsi disk and scsi
> lun. Its getting slower with each step. And only the last variant
> (lun) uses SG_IO to pass along then wwn.

Yes, of course, performance was not my question.

The question was if only passing the wwn gives the guest all the
information it needs or if other parts of the VPD pages or other
information is needed to achieve what you need.

If the existing -scsi-hd,wwn=... were working for you, I would know for
sure that we just need to enable the same thing in virtio-blk and it
will work. If we're comparing with LUN passthrough (scsi-block or
scsi-generic), you're giving the guest access to everything and not just
this one piece of information.

Kevin


