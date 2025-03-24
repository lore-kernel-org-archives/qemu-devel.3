Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C888C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkM3-0005lK-42; Mon, 24 Mar 2025 12:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1twkLp-0005kt-DZ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1twkLi-0004hJ-1X
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742832504;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6B17BP+6vjFR+jms0kp9zlEiAvke2uO5Ah/U9zfSDgI=;
 b=b+TLHn6eZ8hrEtNbT+g1nkGalNqR+Kv/zh7bzt3l4tebs+MiS76ENBKDs7ooEi/nWKYhCO
 KltmY1fQqmYjS9jbS/xlLm+UGHQy8BzLswJF62MyFBP5YPgkawZa9JxwE9r6i9+8gb9NZN
 gacenxb2+8d3T6q9wreWSYgyMGn4xM8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-HOmb9XerOWyN7mLsCdNZjA-1; Mon,
 24 Mar 2025 12:08:18 -0400
X-MC-Unique: HOmb9XerOWyN7mLsCdNZjA-1
X-Mimecast-MFC-AGG-ID: HOmb9XerOWyN7mLsCdNZjA_1742832496
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E1591809CA5; Mon, 24 Mar 2025 16:08:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBBDC30001A1; Mon, 24 Mar 2025 16:08:09 +0000 (UTC)
Date: Mon, 24 Mar 2025 16:08:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffman <kraxel@redhat.com>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Alexander Graf <graf@amazon.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <Z-GDZkkyLsXFzk5b@redhat.com>
References: <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <6684f169-29d6-4f46-b274-1efd4c191b21@amazon.com>
 <ok6u7exmwmh7qsahp5o3udnbbzbsr2km22kpqod37t6mdsywcs@yhk2whhakl63>
 <fucfv6gf22t3sclhad4iwbmxi5tdg6a5dlhvl4kl4bzhnjkktu@dtn2eqh27k32>
 <Z9vTEoweLUsmxWMY@8bytes.org>
 <mimxt26hwxn4kkdt6fgx4dpuejx2667edfenx6jirpuxtnkfqz@r3uybu6g5e44>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mimxt26hwxn4kkdt6fgx4dpuejx2667edfenx6jirpuxtnkfqz@r3uybu6g5e44>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 21, 2025 at 09:22:59AM +0100, Gerd Hoffman wrote:
> On Thu, Mar 20, 2025 at 09:34:26AM +0100, Jörg Rödel wrote:
> > On Tue, Mar 18, 2025 at 12:11:02PM +0100, Gerd Hoffman wrote:
> > > Open questions:
> > > 
> > >  - Does the idea to use igvm parameters for the kernel hashes makes
> > >    sense?  Are parameters part of the launch measurement?
> > 
> > Parameters itself are fully measured, their presence is, but not their
> > data. This is to keep the same launch measurements across different
> > platform configurations.
> > 
> > So for hashes it is best to put some on some measured page and let the
> > parameters point to it.
> 
> Had a look at the kernel hashes details this week.
> 
> So, the story is this: It's essentially a private arrangement between
> ovmf (the amdsev build variant only) and qemu.  The hashes are placed in
> a specific page, together with "launch secrets" (that is not the sev-snp
> "secrets" page).  That page is part of the lanuch measurement.  That
> effectively makes the kernel + initrd + cmdline part of the launch
> measurement too (ovmf verifies the hashes), but without the relatively
> slow secure processor hashing kernel + initrd + cmdline, which reduces
> the time needed to launch a VM.
> 
> The "launch secret" is intended to hold things like a luks secret to
> unlock the root filesystem.  OVMF doesn't touch it but reserves the page
> and registers a EFI table for it so the linux kernel can find it.
> 
> As far I know these are more experimental bits than something actually
> used in production.  It's also clearly a pre-UKI design.  That IMHO
> opens up the question whenever we actually want carry forward with that,
> or if we better check out what alternatives we have.  We'll have a
> signed UKI after all, so going for secure boot and/or measured boot for
> the UKI verification looks attractive compared to passing around hashes
> for the elements inside the UKI.

Although it has been extended to SNP in QEMU, personally I'd consider
the QEMU 'kernel hashes' functionality to be an niche feature.

From a virt mgmt POV we know in general that direct kernel boot while
useful, is somewhat limited in usage. Most of the time it is saner to
have the guest decide what kernel to boot without interaction of the
host. So by extension, the kernel hashes feature is also going to be
a similarly (or even more) niche use case. The UKI with system extensions
and secureboot model gives much greater flexibility for defining policy
around valid configurations than using fixed hashes - especially when
it comes to kernel command line which has potentially many valid configs.


> Not fully sure what to do about the "launch secrets".  IIRC the initial
> design of this is for sev-es, i.e. pre-snp, so maybe the sev-snp secrets
> page can be used instead.  I see the spec has 0x60 bytes (offset 0xa0)
> reserved for guest os usage.  In any case this probably is only needed
> as temporary stopgap until we have a complete vTPM implementation for
> the svsm.

I view the launch secrets feature as a crutch to cope with the HW
limitations of SEV/SEV-ES. You have the host initiated attestation
dance and after verification can pass data back to the host, which
will inject it into the guest. The inability to have a secure TPM
in SEV/SEV-ES forces you down this road. It is highly undesirable
as a feature going forward because we're better served by having
a boot workflow that is common to traditional virt, confidential
virt, and bare metal, and TPM delivers on that.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


