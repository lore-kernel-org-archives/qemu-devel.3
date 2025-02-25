Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA6EC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmqTQ-0004It-4U; Tue, 25 Feb 2025 03:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmqTO-0004Ik-B0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmqTM-0006eU-I1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740472762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=79QjrUuVHqOE88t6MAqRoXr0s8uZIQBcH2qHTOXcyw4=;
 b=cm5lUpL1TgpYYy9jpezM7iCCmtUqXJ/8W1zgMNKdfqMEaracSMzO3M5+QCDij3R09+Vwgt
 iP6tKtbQtoRyOtJCvIiBREIC09aVqkYDEfVkGOCRUiSK3faQ32BrSxFgFx57hVXRNO/axd
 MqwwzNTOl838/cWG7ILVuXTzMVsyVSA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-9T_4TL14OrW0KiMQarTw5A-1; Tue,
 25 Feb 2025 03:39:18 -0500
X-MC-Unique: 9T_4TL14OrW0KiMQarTw5A-1
X-Mimecast-MFC-AGG-ID: 9T_4TL14OrW0KiMQarTw5A_1740472757
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A84A3193578F; Tue, 25 Feb 2025 08:39:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.219])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18042180035E; Tue, 25 Feb 2025 08:39:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8F2AF1800091; Tue, 25 Feb 2025 09:39:12 +0100 (CET)
Date: Tue, 25 Feb 2025 09:39:12 +0100
From: Gerd Hoffman <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
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
Message-ID: <6t76cizlvnhufhg7j6v5dpyjj3k6ba4urd3r7563d3g3e6wnsf@7aenaqnc5d5a>
References: <20250214153443.159889-1-anisinha@redhat.com>
 <xhprkjs2yj5yli65opi7md7gfylqxgdkiwap76stcxcx7jdpub@fauqiqm5giyi>
 <CAK3XEhMs=Do_3FA+Tyb9u4u+9XELvJUk3-SKAeuxciM-bsvDhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3XEhMs=Do_3FA+Tyb9u4u+9XELvJUk3-SKAeuxciM-bsvDhQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 25, 2025 at 10:51:08AM +0530, Ani Sinha wrote:
> On Mon, Feb 24, 2025 at 9:17 PM Gerd Hoffman <kraxel@redhat.com> wrote:
> >
> > Works nicely for me.  Test case:
> >   https://kraxel.gitlab.io/uefi-tools-rs/seabios.efi
> 
> yeah if I can't get my unit test working we can make this an
> integration test. or best case scenario, we can have both.

Do you have a branch with your unit test somewhere?

> > Also this adds five fw_cfg files.  Given that the number of fw_cfg files
> > we can have is limited I'm not convinced this is the best idea to move
> > forward.
> 
> Right, For implementation, I suggest we combine FILE_VMFWUPDATE_OBLOB
> and FILE_VMFWUPDATE_FWBLOB together and also make
> FILE_VMFWUPDATE_CONTROL part of the same structure. These are all
> writable by the guest so makes sense to have one fwcfg for it. We can
> have another read-only fwcfg for FILE_VMFWUPDATE_BIOS_SIZE and
> FILE_VMFWUPDATE_CAP.

I'd prefer to put everything into one file.  Maybe except the opaque
blob page.  A struct along the lines of:

struct vmfwupdate {
    u64 capabilities;   // 'cap' file
    u64 firmware_size;  // 'bios-size' file
    u64 control;        // disable bit etc. 
    u64 update_paddr;   // 'fw-blob' file, paddr field
    u64 update_size;    // 'fw-blob' file, size field
}

On the host side you'll need two copies of the struct then: one where
the guest can read from and write to, and one shadow struct where the
actual values are stored.  The write callback goes sanity-check the
guest-written data, takes everything which passes into the shadow
struct, finally goes copy back the shadow struct to the guest struct
so the guest can see what the host has accepted.

Part of the verification process can be that you already copy the
firmware to a host buffer.  Best using dma_* functions, these return
errors in case something went wrong (say the paddr passed is not backed
by guest ram).  Which gives you the chance to propagate those errors
back to the guest before it'll actually try to launch the updated
firmware via reset.

take care,
  Gerd


