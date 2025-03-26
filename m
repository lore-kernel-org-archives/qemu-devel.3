Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED013C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txPrg-0007tq-HC; Wed, 26 Mar 2025 08:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1txPre-0007tb-PE
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1txPrY-0006oT-Br
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742992079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y41TtKI+zLtArU6fPk2brgQEN0JVguf4f9qRTSDRDkQ=;
 b=ObbJZrZP5wOdj7kpucEisHFh2P23Nfggwh1YSf116pYmDBWv5VGUZxbGan/N+ci4+TxIg+
 vihX2vFp1srIqOOXV9AxB6BgvQZBXpw8NYmcKk41Sq8aOciJsHUdascP2reX2w0aY5vbg4
 dRIZ5TmyUBIl11/nWWU3/ZxND9lBzho=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-d0cUcWEaObu9WaU6MGvrXA-1; Wed,
 26 Mar 2025 08:27:53 -0400
X-MC-Unique: d0cUcWEaObu9WaU6MGvrXA-1
X-Mimecast-MFC-AGG-ID: d0cUcWEaObu9WaU6MGvrXA_1742992072
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3791180882E; Wed, 26 Mar 2025 12:27:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 183FE180A803; Wed, 26 Mar 2025 12:27:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 94B941800787; Wed, 26 Mar 2025 13:27:47 +0100 (CET)
Date: Wed, 26 Mar 2025 13:27:47 +0100
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
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
References: <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
 <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
 <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
 <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
 <CAK3XEhPYmBsn2-=PMR7qVQHiu0ydoh3EfJOEuunLccriSkKipg@mail.gmail.com>
 <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
 <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
 <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
 <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> The problem is that add-ons are
> 
>   1) Separate binaries. So you need to match multiple files.
>   2) In this case, get generated out of the vendor (RH)'s control in a
> one-off fashion.
> 
> I don't think "signing" is the correct way to address the latter. It's
> rather hashing. But I agree with you that it could (should?) be hashing at
> the PE loader level similar or identical to Secure Boot rather than a
> separate hashing mechanism.

Secure boot offers signing and hashing.  You can add both signing
certificates and authenticode hashes to 'db'.

> > Not sure I understand the point you are trying to raise.  Add-ons
> > signatures are checked too.
> 
> 2 points here here:
> 
>   1) With add-ons, there are multiple binaries. We can't only pass a single
> one.

Sure.  You'll go need some container, say a cpio archive, but that is
something vmfwupdate loader and loaded firmware have to agree on and not
something we have to worry about too much for the vmfwupdate interface
design.

>   2) The security posture of the system may be different between 2 validly
> signed images. Think of Daniel's example of verbose kernel output. Maybe I
> consider verbose kernel output already inacceptable, while RH thinks it's an
> ok posture to have. The user needs to have the chance to differentiate
> between a system booted with or without verbose kernel output.

You easily get that by looking at the vTPM measurements.  So not sure
what you are asking for, do you want be able to also do that without a
vTPM?

> > > So we need some equivalent of a hash page.
> > Ok.  So two opaque blobs, one which is measured into the launch
> > measurement and one which is not?  That gives you the option to pass
> > around hashes (or any other data) and leave a trace in the launch
> > measurement should you need that.
> 
> Yes, I think you want to have one or multiple pages with what effectively is
> a db append variable update blob.

Makes sense to me.

> Or even a full variable store blob.

Hmm, not sure.  I'd rather go for passing efi signature database
appendix, probably for both allow ('db') and deny ('dbx').  That is
going to work better I think, variable store format is an
firmware-internal implementation detail I'd avoid encoding that in
some interface.

> The IGVM should dictate the physical location of that blob so that you
> can precalculate the launch digest with the blob included.

Hmm, right.  Physical location matters for the launch measurement, so
adding opaque_measured_addr to struct vmfwupdate isn't going to work
very well.

> Ukify.py then generates the blob along with the FUKI.

Doesn't fly from a distro point of view.  The UKI is signed, so RH ships
that and the customer can't modify it to update the blob, say with some
additional hashes for 'db'.

Effectively we need something roughly equivalent to shim's MokList.  The
distro ships a default configuration (like the cert compiled into the
shim binary) which works fine for most people.  For IGVM that would be a
default efi variable store compiled into the firmware binary.

If you need additional stuff (like the signer cert for the nvidia
driver) there must be some way to add hashes and certificates to db/dbx.

Does it make sense to simply move the firmware update sections from the
main UKI to an add-on?  That would allow customers to easily use their
own if they wish, without breaking the RH signature on the UKI.

> I agree, from a vmfwupdate point of view, we would basically have an IGVM.
> The IGVM describes 2 special page (ranges?): One for the CPUID special page,
> one for the variable store seed. To precalculate the launch digest you would
> need the firmware IGVM, and the seed blob.

Guess we'll have to update the IGVM format spec for that, so we have
page types for 'db' and 'dbx'.  With that it should be possible to load
the igvm, find + update the pages + write it out again.  Then wrap it
into an UKI add-on + copy to ESP.

RH default igvm/add-on would simply have empty 'db' and 'dbx' pages.

Looks workable to me.

> All unauthenticated data, such as locations of the UKI and its add-ons gets
> passed as parameter to the firmware IGVM.

i.e. have a IGVM parameter for opaque_addr + opaque_size instead of
placing this in the vmfwupdate struct?

take care,
  Gerd

PS: in Berlin tomorrow?


