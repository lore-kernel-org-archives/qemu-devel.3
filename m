Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AD0C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 07:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twcT0-0007lg-HT; Mon, 24 Mar 2025 03:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1twcSz-0007lJ-4D
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 03:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1twcSv-00041C-VL
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 03:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742802199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jeCb8jK4b8UM6BUDqZ7E0UspaWiXS12m8DOy3Hn4Ve8=;
 b=TltWHQi3Xs8GWq5qrio8l8iRr/OOVmvHV6Zm4ExhYDWhZNO4TskZQBtusk8Rcy71KC42vR
 E8F9KiDx07vI+UQGwpAMrxmG3ZujuVLHru53I/ZFVLKHbSYmp+h39lRGaxRmO5/x/a/+lk
 c3wmNAUjaQO3WIjZ3lGZzXznZPfaks0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-wEBnqHqYNM2g0kZTCE1uBA-1; Mon,
 24 Mar 2025 03:43:13 -0400
X-MC-Unique: wEBnqHqYNM2g0kZTCE1uBA-1
X-Mimecast-MFC-AGG-ID: wEBnqHqYNM2g0kZTCE1uBA_1742802191
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DAB5196E007; Mon, 24 Mar 2025 07:43:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68034180A802; Mon, 24 Mar 2025 07:43:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C9E101800387; Mon, 24 Mar 2025 08:43:06 +0100 (CET)
Date: Mon, 24 Mar 2025 08:43:06 +0100
From: Gerd Hoffman <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
 Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
References: <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
 <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
 <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi,

> > Going ship the distro kernel as igvm image would work too.  Will
> > simplify the measurement pre-calculation.  Also there is no need to pass
> > around any parameters, everything (how the firmware finds the UKI etc)
> > can be arranged at igvm build time then.  Disadvantage: This introduces
> > a completely new boot workflow.  Will probably need a new set of cloud
> > images exclusively for the BYOF case.
> 
> What does all this mean for the hypervisor interface ?

That means we'll go scratch the region list idea and depend on igvm
instead.

Which means we are back to the single firmware image.  I think it makes
sense to continue supporting classic rom images (which can also be
loaded via -bios).  Any use case which needs more fine-grained control
must use igvm.  We can use format bits in both capabilities and control
fields to indicate what the hypervisor supports and what has been
uploaded to the firmware image region.  See interface header file draft
below.

'opaque' exists as before, even though I think it makes sense to also
specify the size for the opaque blob.  This gives the guest a bit more
flexibility in how this is used, for example it could pass the complete
UKI as opaque blob.

take care,
  Gerd

------------------------------ cut here -----------------------------
struct vmfwupdate {
    // VMM capabilities, see VMFWUPDATE_CAP_*, read-only.
    uint64_t capabilities;
    // control bits, see VMFWUPDATE_CTL_*
    uint64_t control;

    // firmware rom/flash storage size, read-only.
    uint64_t fw_rom_size;

    // address and size of the firmware update image.  Will be cleared on
    // firmware update and reset.
    uint64_t fw_image_addr;
    uint16_t fw_image_size;

    // address + size of opaque blob.  The guest can use this to pass on
    // information, for example which memory region the linux kernel has been
    // loaded to.  writable, will be kept intact on firmware update.
    uint64_t opaque_addr;
    uint64_t opaque_size;
};

// --- format bits, used by both 'capabilities' and 'control' ---
// igvm
#define VMFWUPDATE_FORMAT_IGVM           (1 << 32)
// rom/flash on platform-specific location
//  - x86: below 4G + 1G
//  - arm: 0
#define VMFWUPDATE_FORMAT_PLATFORM_ROM   (1 << 33)

// --- 'capabilities' field bits ---
// vmm supports resizing of x86 firmware memory
#define VMFWUPDATE_CAP_X86_RESIZE         (1 << 0)

// --- 'control' field bits ---
// disable vmfwupdate interface
#define VMFWUPDATE_CTL_DISABLE            (1 << 0)


