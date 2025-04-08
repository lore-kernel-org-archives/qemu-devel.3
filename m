Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C376CC369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 08:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u244C-0000qp-SY; Tue, 08 Apr 2025 04:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1u2442-0000qJ-8w
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1u2440-0007Je-3a
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744099920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rXk77wnDA+GDw5mLn8FDn1OiHklNOm6Aa65B1Nz5LJo=;
 b=CZ+ZWLQI229H4Jw6eoDMjhXHRG1zG6tZMqtx3VeBYLRF9VA4CQFEPEAczLbsq7g42NymlL
 0K2teSO19/nlqiLy6x9tFLwRvd4mVNlVEEV3Tl2fYfohC2J0bCeF1oIqdWXNaHSMVAvw7C
 YUXBXuVh7pJLNKWjfypaMAyKEv0Alzk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-P3blUlgfPvmUYITh3SsrTw-1; Tue,
 08 Apr 2025 04:11:55 -0400
X-MC-Unique: P3blUlgfPvmUYITh3SsrTw-1
X-Mimecast-MFC-AGG-ID: P3blUlgfPvmUYITh3SsrTw_1744099913
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B99C180AB19; Tue,  8 Apr 2025 08:11:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.107])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 624F1180B486; Tue,  8 Apr 2025 08:11:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1C3201800094; Tue, 08 Apr 2025 10:11:48 +0200 (CEST)
Date: Tue, 8 Apr 2025 10:11:48 +0200
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
Message-ID: <63vckbpscnedivwx3qgucmhi6xiyebtpwqhkft4jelklujy6dz@wp6ibjvbtbox>
References: <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
 <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
 <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
 <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> Which means we are back to the single firmware image.  I think it makes
> sense to continue supporting classic rom images (which can also be
> loaded via -bios).  Any use case which needs more fine-grained control
> must use igvm.  We can use format bits in both capabilities and control
> fields to indicate what the hypervisor supports and what has been
> uploaded to the firmware image region.  See interface header file draft
> below.

Updated draft.  Idea is to go all-in on IGVM and support IGVM only.  We
keep the format bit, but more to make things future-proof (have the
option to support other formats should the need arise at some point in
the future) and not because we plan to support multiple formats today.

So we are down to this:

--------------------------- cut here ------------------------

/*
 * igvm only vmfwupdate interface rewrite
 */

struct vmfwupdate {
    // VMM capabilities, see VMFWUPDATE_CAP_*, read-only.
    uint64_t capabilities;
    // control bits, see VMFWUPDATE_CTL_*
    uint64_t control;

    // address and size of the firmware update image.  Will be cleared on
    // firmware update and reset.
    uint64_t fw_image_addr;
    uint16_t fw_image_size;
};

// --- format bits, used by both 'capabilities' and 'control' ---
// igvm
#define VMFWUPDATE_FORMAT_IGVM           (1 << 32)

// --- 'control' field bits ---
// disable vmfwupdate interface
#define VMFWUPDATE_CTL_DISABLE            (1 << 0)

--------------------------- cut here ------------------------

All other details will be offloaded to IGVM.  We will need some IGVM
format updates for that:

 * Add a parameter to specify the location of the payload (i.e.
   the UKI, or some container format in case we want pass on more
   than just one efi binary).
 * Add a page types for db/dbx signature databases where we can
   store either the signing key or the authenticode hash of the
   payload.

take care,
  Gerd


