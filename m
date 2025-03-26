Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599B8C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 21:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txYfV-0004Z0-Ac; Wed, 26 Mar 2025 17:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1txYfT-0004Yj-SB
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 17:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1txYfR-0006A8-Sa
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 17:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743025926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O/KJjPEUFO6VSFPCeLAUYDmna5YXjZW4bQ6oOhilAyU=;
 b=HHxCZK0vTP8YRpFGUuMbFtayF+0iX7mtRjFUnx7o6tsvYZRqPCwUflJ217hoO9JtEuSKis
 PCTcSBlbm3GMdKnRXzc/kBZmh48Mo32tyqi5jCvbWAOm+xnVcSqzNrxobvZJiAKF3Bvzq7
 6qPMVbJahLnwnsW3jmP2T9JL0NM5yeY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-XRAX2ciTOmmqP91ojRTsCg-1; Wed,
 26 Mar 2025 17:52:05 -0400
X-MC-Unique: XRAX2ciTOmmqP91ojRTsCg-1
X-Mimecast-MFC-AGG-ID: XRAX2ciTOmmqP91ojRTsCg_1743025924
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04989195606E; Wed, 26 Mar 2025 21:52:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E59091956095; Wed, 26 Mar 2025 21:52:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 92AEF1800787; Wed, 26 Mar 2025 22:51:58 +0100 (CET)
Date: Wed, 26 Mar 2025 22:51:58 +0100
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
Message-ID: <fwdk2pc4rfa5o22gdfqq4cfsqged4v6hmlrtqdwltgqj2bkpl4@bicazjx5d22l>
References: <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
 <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
 <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
 <CAK3XEhPYmBsn2-=PMR7qVQHiu0ydoh3EfJOEuunLccriSkKipg@mail.gmail.com>
 <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
 <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
 <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
 <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
 <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
 <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

  Hi,

> > >    2) The security posture of the system may be different between 2 validly
> > > signed images. Think of Daniel's example of verbose kernel output. Maybe I
> > > consider verbose kernel output already inacceptable, while RH thinks it's an
> > > ok posture to have. The user needs to have the chance to differentiate
> > > between a system booted with or without verbose kernel output.
> > You easily get that by looking at the vTPM measurements.  So not sure
> > what you are asking for, do you want be able to also do that without a
> > vTPM?
> 
> All of this should work without vTPMs. Why add complexity when you don't
> need it? The industry is already struggling to deal with TPMs alone. There
> are way too many potential holes in a solution where you first have to
> reason about the integrity of your TPM before you can trust it. All of the
> vTPM in SEV-SNP talk is a house of cards I'm happy to push (blow to keep the
> analogy?) against as hard as I can.

TPM is the only thing we have outside of confidential computing.  So
naturally there is alot of code and infrastructure for that despite the
complexity of TPMs.  So having vTPMs in CVMs allows to reuse that
infrastructure and it totally makes sense to support that.

That doesn't imply this is the only option to handle things.  Having the
option to tie everything to the launch measurement makes sense too.
Fair point.

> > > Ukify.py then generates the blob along with the FUKI.
> > Doesn't fly from a distro point of view.  The UKI is signed, so RH ships
> > that and the customer can't modify it to update the blob, say with some
> > additional hashes for 'db'.
> 
> I don't follow. Is RH going to ship a UKI or a FUKI?

How should I answer that one while we are still discussing the design?

> And if RH ships the UKI, ukify could still take a UKI as input and
> generate a FUKI based on it, no?

Of course you can, but it'll break the RH signature.

> During that process, it would generate a db which gets put at a fixed
> location in RAM so the (RH provided) firmware picks it up and validates the
> UKI it loads is exactly that one UKI.

Well.  If you want put the db into the igvm and the igvm into the uki
you've got a chicken-and-egg problem.  Moving the firmware from the main
UKI to UKI add-on would solve that.

> We can extend that with an additional signature flow, where the ukify
> generated db contains a signature for the UKI instead.

certificate, not signature.  But, yes, that would work.

> But I would generally advise against optimizing for certificate based
> flows until revocation is sorted out.

Well, if at the end of the day we'll go pass on a 'db' both signatures
and hashes can be used.

> > Effectively we need something roughly equivalent to shim's MokList.  The
> > distro ships a default configuration (like the cert compiled into the
> > shim binary) which works fine for most people.  For IGVM that would be a
> > default efi variable store compiled into the firmware binary.
> 
> This only makes sense in a world where RH ships an SVSM and that's all you
> want to attest. But that's a different flow from what we describe here. To
> actually get workload attestation, you need to include your rootfs in the
> attestation. And the only entity that can do that is the end customer. And
> they will typically do that through something like dm-verity or fs-verity
> and a hash provided on the kernel command line.

So you'll have the RH UKI + customer add-on with the kernel command
line.  And you need a customized igvm containing a 'db' which will allow
both, either via certificate+signature or via hash, whatever you prefer.

> > Does it make sense to simply move the firmware update sections from the
> > main UKI to an add-on?  That would allow customers to easily use their
> > own if they wish, without breaking the RH signature on the UKI.
> 
> I'm still not convinced "RH signature" is a useful marker at execution time
> of confidential workloads.

If the customer agrees they can go for hashes.  If not they should be
able to use certificates.  So patching the RH shipped UKI is not an
option.

> > RH default igvm/add-on would simply have empty 'db' and 'dbx' pages.
> > 
> > Looks workable to me.
> 
> I would personally consider the "RH binary adds RH signature into binary by
> default" a backdoor, but that's you call :).

It's surely possible to ship two variants, one with the RH certificates
and one blank, so customers can pick the latter if they want allow
specific hashes only.

> I agree with the plan to amend the IGVM spec with the UEFI variable update
> page. I don't think it should be "db" and "dbx" pages. It should be a more
> generic. In fact, why not make it a loader UEFI (PE) binary?

Not convinced a PE binary is a good idea.  Adds one more indirection for
no obvious gain.

> > > All unauthenticated data, such as locations of the UKI and its add-ons gets
> > > passed as parameter to the firmware IGVM.
> > i.e. have a IGVM parameter for opaque_addr + opaque_size instead of
> > placing this in the vmfwupdate struct?
> 
> It would be a pretty natural fit for it, no?

Absolutely.  Just wanted to make sure we are talking about the same thing.

take care,
  Gerd


