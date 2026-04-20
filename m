Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F58FF588C1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEo34-0007Ss-5e; Mon, 20 Apr 2026 08:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wEo2q-0007QZ-1L
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wEo2k-0005uP-N8
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776689281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5jCru2M02gDzCQ5PxoOrAKmJVk9Vc28SFHAqFc0f7w=;
 b=cDexU/OFD5uEI80p0McgD+QoiThnKyX51Iqs4W2LL+L1ylEbnRLU2zM3JMdxMNZolo2jdc
 il3X4hGE6xc3wscOqEWHzhixY/+ZcYqn4jhhw48RbIemPG+s8b+9hCCCgstFWQwPIDFT76
 36et1NSC0frm675JgG2KImjcWXAZ6Gg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-lMR7Q9Q3Me6R1H3vmnojYg-1; Mon,
 20 Apr 2026 08:47:57 -0400
X-MC-Unique: lMR7Q9Q3Me6R1H3vmnojYg-1
X-Mimecast-MFC-AGG-ID: lMR7Q9Q3Me6R1H3vmnojYg_1776689276
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 607601954B33; Mon, 20 Apr 2026 12:47:55 +0000 (UTC)
Received: from localhost (dhcp-192-224.str.redhat.com [10.33.192.224])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BE2C1801546; Mon, 20 Apr 2026 12:47:54 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Jaehoon Kim
 <jhkim@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com
Subject: Re: [PATCH RFC v1 1/1] hw/s390x/ccw: Disable legacy virtio-pci by
 default (v11.1+)
In-Reply-To: <530e4dc5-3a3f-4556-bfd6-d6e9e5b5da0e@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260417154332.849664-1-jhkim@linux.ibm.com>
 <20260417154332.849664-2-jhkim@linux.ibm.com> <877bq2szx1.fsf@redhat.com>
 <530e4dc5-3a3f-4556-bfd6-d6e9e5b5da0e@linux.ibm.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Mon, 20 Apr 2026 14:47:52 +0200
Message-ID: <874il5u7bb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 20 2026, Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 4/20/26 6:12 AM, Cornelia Huck wrote:
>> On Fri, Apr 17 2026, Jaehoon Kim <jhkim@linux.ibm.com> wrote:
>> 
>>> On the s390 Linux kernel, IO_SPACE_LIMIT has been 0 since the initial
>>> zPCI implementation (commit cd24834130ac "s390/pci: base support"),
>>> making I/O BARs unusable.
>>>
>>> However, when virtio-pci devices operate in transitional mode, QEMU
>>> unconditionally exposes the legacy interface via BAR0. This results in
>>> firmware warnings during PCI enumeration, such as:
>>>
>>>   pci 0005:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size
>>>
>>> even though BAR0 is never usable on the s390 kernel.
>>>
>>> Close this gap by disabling legacy virtio-pci support starting from
>>> machine version 11.1. This effectively makes virtio-pci devices
>>> non-transitional and prevents the creation of the unusable legacy I/O
>>> BAR.
>>>
>>> This introduces s390x-specific global compatibility properties that
>>> set disable-legacy=on as the default for virtio-pci devices. Machine
>>> versions v11.0 and earlier set disable-legacy=off to maintain their
>>> original default behavior (legacy support enabled), ensuring VMs
>>> created with those versions continue to work identically.
>>>
>>> Users can override the default on the command line if needed:
>>>   - On v11.1+: -global virtio-pci.disable-legacy=off (to enable legacy)
>>>   - On v11.0-: -global virtio-pci.disable-legacy=on (to disable legacy)
>> 
>> Makes sense to disable legacy virtio-pci devices, if they cannot work
>> anyway. I'm wondering if we want to have a generic "no legacy" switch as
>> well. I remember a patch from some time ago, but that was concerned with
>> endianness IIRC.
>
> Thanks Connie, I was hoping to get your input on this idea.
>
> By generic, do you mean disabling legacy virtio-pci (and legacy
> virtio-ccw?) across QEMU for all platforms vs only disabling it for s390x?

If we are moving towards multi-arch binaries, it would need to be the
latter; another benefit would be removing legacy bits from the virtio
core. But I think we'd still need quite some time before we get there
(virtio-pci switched to modern by default later than virtio-ccw.)

>
>> 
>> Anyway, we cannot turn off pre-1.0 for virtio-ccw at the moment, because
>> the bios still uses legacy virtio. Would be a bit of an effort to change
>> that, but still sounds like a good idea to me.
>> 
>
> Good point, hadn't thought about that and I guess it would be a pre-req
> if you really wanted to disable legacy virtio everywhere; we can
> certainly put this on our todo list for later, but I'd still like a
> patch like this one to fix the awkward s390x virtio-pci situation now.

Yep, this patch is fine for the current situation, I guess legacy
virtio-ccw will stay around for a bit longer (and there's no urgent need
to remove support for it as long as the virtio core still supports
legacy easily.)


