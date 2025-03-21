Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2EBC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 08:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvXf5-0006mZ-GN; Fri, 21 Mar 2025 04:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tvXf3-0006m1-Jv
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 04:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tvXez-0001Ev-Cf
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 04:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742545396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HyU3kp9o4PG0IjggR3EG2Wq7dzmm3PQDCEB8ncoYdng=;
 b=QG7tSX6ODsPp2LtBFViz4WgXLevz0g4NPPciu+JcLBsNmqxVhW4D1GWKNQRwRc1kuOmREq
 sJHNjLhGF8/09dA+9ZsoyD/YTnn/mwP9FzDhwSQpXCRXZEyueRKCkGv95gNA09WNpP76nr
 2hnr1urc7c6Sf8QGjFtllRoP2c9TnXk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-scG0tmc7MkyUFYSTkiuv_w-1; Fri,
 21 Mar 2025 04:23:10 -0400
X-MC-Unique: scG0tmc7MkyUFYSTkiuv_w-1
X-Mimecast-MFC-AGG-ID: scG0tmc7MkyUFYSTkiuv_w_1742545388
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46109195606E; Fri, 21 Mar 2025 08:23:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3DDE3001D16; Fri, 21 Mar 2025 08:23:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 39B461800390; Fri, 21 Mar 2025 09:22:59 +0100 (CET)
Date: Fri, 21 Mar 2025 09:22:59 +0100
From: Gerd Hoffman <kraxel@redhat.com>
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Alexander Graf <graf@amazon.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <mimxt26hwxn4kkdt6fgx4dpuejx2667edfenx6jirpuxtnkfqz@r3uybu6g5e44>
References: <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <6684f169-29d6-4f46-b274-1efd4c191b21@amazon.com>
 <ok6u7exmwmh7qsahp5o3udnbbzbsr2km22kpqod37t6mdsywcs@yhk2whhakl63>
 <fucfv6gf22t3sclhad4iwbmxi5tdg6a5dlhvl4kl4bzhnjkktu@dtn2eqh27k32>
 <Z9vTEoweLUsmxWMY@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9vTEoweLUsmxWMY@8bytes.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Mar 20, 2025 at 09:34:26AM +0100, Jörg Rödel wrote:
> On Tue, Mar 18, 2025 at 12:11:02PM +0100, Gerd Hoffman wrote:
> > Open questions:
> > 
> >  - Does the idea to use igvm parameters for the kernel hashes makes
> >    sense?  Are parameters part of the launch measurement?
> 
> Parameters itself are fully measured, their presence is, but not their
> data. This is to keep the same launch measurements across different
> platform configurations.
> 
> So for hashes it is best to put some on some measured page and let the
> parameters point to it.

Had a look at the kernel hashes details this week.

So, the story is this: It's essentially a private arrangement between
ovmf (the amdsev build variant only) and qemu.  The hashes are placed in
a specific page, together with "launch secrets" (that is not the sev-snp
"secrets" page).  That page is part of the lanuch measurement.  That
effectively makes the kernel + initrd + cmdline part of the launch
measurement too (ovmf verifies the hashes), but without the relatively
slow secure processor hashing kernel + initrd + cmdline, which reduces
the time needed to launch a VM.

The "launch secret" is intended to hold things like a luks secret to
unlock the root filesystem.  OVMF doesn't touch it but reserves the page
and registers a EFI table for it so the linux kernel can find it.

As far I know these are more experimental bits than something actually
used in production.  It's also clearly a pre-UKI design.  That IMHO
opens up the question whenever we actually want carry forward with that,
or if we better check out what alternatives we have.  We'll have a
signed UKI after all, so going for secure boot and/or measured boot for
the UKI verification looks attractive compared to passing around hashes
for the elements inside the UKI.

Not fully sure what to do about the "launch secrets".  IIRC the initial
design of this is for sev-es, i.e. pre-snp, so maybe the sev-snp secrets
page can be used instead.  I see the spec has 0x60 bytes (offset 0xa0)
reserved for guest os usage.  In any case this probably is only needed
as temporary stopgap until we have a complete vTPM implementation for
the svsm.

take care,
  Gerd


