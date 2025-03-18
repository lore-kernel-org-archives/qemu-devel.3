Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CE7C28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 11:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuUr6-0007dn-5q; Tue, 18 Mar 2025 07:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuUqt-0007a2-4p
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuUqq-0007wc-0B
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742296273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YwrA/oknCvCRiptFq7YnS3GiFeYbfrZc82tnmsqSe4w=;
 b=gstuun5OZUzXB/X0NkpQ/X96Hyw9CWTFjOfyMb2OsaqwWC04gMPZ6o8C3sGv705IMBH4Or
 4N8DLKJhwhjfo3J1nF84u1bsudLVAiGW6OxhUNkZHBIsiBTEjnalWHeZD1Lyt0rhnzAAyT
 U+vvbJXGggzhR6LDqq+Vnd3eINlWZ0U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-VM27ncwzPcmMydmbB4L7Vw-1; Tue,
 18 Mar 2025 07:11:08 -0400
X-MC-Unique: VM27ncwzPcmMydmbB4L7Vw-1
X-Mimecast-MFC-AGG-ID: VM27ncwzPcmMydmbB4L7Vw_1742296266
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE73A180025A; Tue, 18 Mar 2025 11:11:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B17961955BE4; Tue, 18 Mar 2025 11:11:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2260F18000AF; Tue, 18 Mar 2025 12:11:02 +0100 (CET)
Date: Tue, 18 Mar 2025 12:11:02 +0100
From: Gerd Hoffman <kraxel@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <fucfv6gf22t3sclhad4iwbmxi5tdg6a5dlhvl4kl4bzhnjkktu@dtn2eqh27k32>
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <6684f169-29d6-4f46-b274-1efd4c191b21@amazon.com>
 <ok6u7exmwmh7qsahp5o3udnbbzbsr2km22kpqod37t6mdsywcs@yhk2whhakl63>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ok6u7exmwmh7qsahp5o3udnbbzbsr2km22kpqod37t6mdsywcs@yhk2whhakl63>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> Maybe not from the user's point of view, but surely for the vmfwupdate
> interface design and for the launch measurement calculations.
> 
> When using igvm parameters for the kernel hashes we need to pass on (at
> least) two items via vmfwupdate API:  The igvm image itself and the
> kernel hashes, so the VMM can fill the parameters for launch.
> 
> I tend to think it makes sense to keep the region list, so we can
> actually pass on multiple items if needed, and simply add region flags
> to declare that a region is an IGVM image.

Went over the interface spec today, here it is.  Changes:

 - Moved descriptions into source code comments.
 - Added leftovers noticed in recent discussions, such as cpuid page.
 - Added capability flags and region flags for IGVM.

Open questions:

 - Does the idea to use igvm parameters for the kernel hashes makes
   sense?  Are parameters part of the launch measurement?
 - Do we want actually keep the complete interface (and the functional
   overlap with igvm)?

take care,
  Gerd

------------------------- cut here ---------------------------------

/*
 * Mar 2025 vmfwupdate interface rewrite
 */

struct vmfwupdate {
    // VMM capabilities, see VMFWUPDATE_CAP_*, read-only.
    uint64_t capabilities;
    // firmware storage size (below 4G on x86), read-only.
    uint64_t firmware_size;

    // address of opaque blob, the guest can use this to pass on information,
    // for example which memory region the linux kernel has been loaded to.
    // writable, will be kept intact on firmware update.
    uint64_t opaque_addr;

    // regions (see vmfwupdate_regions struct), memory location and length of
    // the list.  writable, will be cleared on firmware update and reset.
    uint64_t regions_addr;
    uint16_t regions_count;

    // control bits, see VMFWUPDATE_CTL_*
    // - disable bit can be set by the guest.
    // - disable bit can only be cleared by reset.
    uint16_t control;
};

// --- 'capabilities' field bits ---
// vmm supports resizing of firmware memory
#define VMFWUPDATE_CAP_BIOS_RESIZE    (1 << 0)
// vmm supports loading igvm images
#define VMFWUPDATE_CAP_IGVM_IMAGES    (2 << 0)

// --- 'control' field bits ---
// disable vmfwupdate interface
#define VMFWUPDATE_CTL_DISABLE        (1 << 0)

// 'regions_addr' field points to an array of this structure
struct vmfwupdate_regions {
    uint64_t size;           // size of the region
    uint64_t src_addr;       // source address (before update)
    uint64_t dst_addr;       // destination address (after update)
    uint64_t flags;          // control bits
};

// --- 'flags' field bits ---
// data must be copied
#define VMFWUPDATE_REGION_FLAG_COPY          (1 << 0)
// dest must be filled with zeros (src is not used)
#define VMFWUPDATE_REGION_FLAG_ZERO          (1 << 1)
// region must be measured
#define VMFWUPDATE_REGION_FLAG_MEASURE       (1 << 2)
// region must be (pre-)validated
#define VMFWUPDATE_REGION_FLAG_VALIDATE      (1 << 3)

// region contains igvm image
#define VMFWUPDATE_REGION_FLAG_IGVM_IMAGE    (1 << 8)
// region contains igvm parameters (TODO: details)
#define VMFWUPDATE_REGION_FLAG_IGVM_PARAM    (1 << 9)

// region is sev cpuid page
#define VMFWUPDATE_REGION_FLAG_SEV_CPUID     (1 << 16)
// region is sev secrets page
#define VMFWUPDATE_REGION_FLAG_SEV_SECRETS   (1 << 17)


