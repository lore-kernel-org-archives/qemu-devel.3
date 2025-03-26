Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9655C3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txSaz-00082w-Ff; Wed, 26 Mar 2025 11:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1730b573f=graf@amazon.de>)
 id 1txSac-00080T-36
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:22:47 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1730b573f=graf@amazon.de>)
 id 1txSaZ-0004kH-Pr
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1743002564; x=1774538564;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MN7z+ckdGP8EJRkgczaLcgdYnC+StRwniSc9vh1qZ/Q=;
 b=OIc8Gf+WKwMijUQCrMnNVAvF56hnL05UArq7AodxEdkB7XbZo4Xf2PTa
 xveVQ06DKT8sllhKsmIaf9oft1vM1ogqO2qh9WBmjtIVTWfy5LF1Q9/Un
 1KlcGp0nLE7fFp1F/RA51eGpDWIzhOB0td0waIY5CJds0wrXzBuVDKTwt 0=;
X-IronPort-AV: E=Sophos;i="6.14,278,1736812800"; d="scan'208";a="35357037"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 15:22:38 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:19506]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.232:2525]
 with esmtp (Farcaster)
 id 2afffc63-6a00-48e4-aba7-5352e417cd1c; Wed, 26 Mar 2025 15:22:37 +0000 (UTC)
X-Farcaster-Flow-ID: 2afffc63-6a00-48e4-aba7-5352e417cd1c
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Mar 2025 15:22:37 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Wed, 26 Mar 2025
 15:22:33 +0000
Message-ID: <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
Date: Wed, 26 Mar 2025 16:22:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Gerd Hoffman <kraxel@redhat.com>
CC: Ani Sinha <anisinha@redhat.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
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
 <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=99.78.197.217;
 envelope-from=prvs=1730b573f=graf@amazon.de; helo=smtp-fw-80006.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.007, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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


On 26.03.25 13:27, Gerd Hoffman wrote:
>    Hi,
>
>> The problem is that add-ons are
>>
>>    1) Separate binaries. So you need to match multiple files.
>>    2) In this case, get generated out of the vendor (RH)'s control in a
>> one-off fashion.
>>
>> I don't think "signing" is the correct way to address the latter. It's
>> rather hashing. But I agree with you that it could (should?) be hashing at
>> the PE loader level similar or identical to Secure Boot rather than a
>> separate hashing mechanism.
> Secure boot offers signing and hashing.  You can add both signing
> certificates and authenticode hashes to 'db'.
>
>>> Not sure I understand the point you are trying to raise.  Add-ons
>>> signatures are checked too.
>> 2 points here here:
>>
>>    1) With add-ons, there are multiple binaries. We can't only pass a single
>> one.
> Sure.  You'll go need some container, say a cpio archive, but that is
> something vmfwupdate loader and loaded firmware have to agree on and not
> something we have to worry about too much for the vmfwupdate interface
> design.
>
>>    2) The security posture of the system may be different between 2 validly
>> signed images. Think of Daniel's example of verbose kernel output. Maybe I
>> consider verbose kernel output already inacceptable, while RH thinks it's an
>> ok posture to have. The user needs to have the chance to differentiate
>> between a system booted with or without verbose kernel output.
> You easily get that by looking at the vTPM measurements.  So not sure
> what you are asking for, do you want be able to also do that without a
> vTPM?


All of this should work without vTPMs. Why add complexity when you don't 
need it? The industry is already struggling to deal with TPMs alone. 
There are way too many potential holes in a solution where you first 
have to reason about the integrity of your TPM before you can trust it. 
All of the vTPM in SEV-SNP talk is a house of cards I'm happy to push 
(blow to keep the analogy?) against as hard as I can.


>
>>>> So we need some equivalent of a hash page.
>>> Ok.  So two opaque blobs, one which is measured into the launch
>>> measurement and one which is not?  That gives you the option to pass
>>> around hashes (or any other data) and leave a trace in the launch
>>> measurement should you need that.
>> Yes, I think you want to have one or multiple pages with what effectively is
>> a db append variable update blob.
> Makes sense to me.
>
>> Or even a full variable store blob.
> Hmm, not sure.  I'd rather go for passing efi signature database
> appendix, probably for both allow ('db') and deny ('dbx').  That is
> going to work better I think, variable store format is an
> firmware-internal implementation detail I'd avoid encoding that in
> some interface.
>
>> The IGVM should dictate the physical location of that blob so that you
>> can precalculate the launch digest with the blob included.
> Hmm, right.  Physical location matters for the launch measurement, so
> adding opaque_measured_addr to struct vmfwupdate isn't going to work
> very well.
>
>> Ukify.py then generates the blob along with the FUKI.
> Doesn't fly from a distro point of view.  The UKI is signed, so RH ships
> that and the customer can't modify it to update the blob, say with some
> additional hashes for 'db'.


I don't follow. Is RH going to ship a UKI or a FUKI? And if RH ships the 
UKI, ukify could still take a UKI as input and generate a FUKI based on 
it, no? During that process, it would generate a db which gets put at a 
fixed location in RAM so the (RH provided) firmware picks it up and 
validates the UKI it loads is exactly that one UKI.

We can extend that with an additional signature flow, where the ukify 
generated db contains a signature for the UKI instead. But I would 
generally advise against optimizing for certificate based flows until 
revocation is sorted out. And since revocation requires a new dbx in 
this scheme and that means a different launch digest per revocation, you 
may as well just directly only use hashes.


> Effectively we need something roughly equivalent to shim's MokList.  The
> distro ships a default configuration (like the cert compiled into the
> shim binary) which works fine for most people.  For IGVM that would be a
> default efi variable store compiled into the firmware binary.


This only makes sense in a world where RH ships an SVSM and that's all 
you want to attest. But that's a different flow from what we describe 
here. To actually get workload attestation, you need to include your 
rootfs in the attestation. And the only entity that can do that is the 
end customer. And they will typically do that through something like 
dm-verity or fs-verity and a hash provided on the kernel command line.


>
> If you need additional stuff (like the signer cert for the nvidia
> driver) there must be some way to add hashes and certificates to db/dbx.
>
> Does it make sense to simply move the firmware update sections from the
> main UKI to an add-on?  That would allow customers to easily use their
> own if they wish, without breaking the RH signature on the UKI.


I'm still not convinced "RH signature" is a useful marker at execution 
time of confidential workloads. It may be an interesting one at assembly 
time, but after that we're folding everything into a single launch 
digest anyway, for good reasons.


>
>> I agree, from a vmfwupdate point of view, we would basically have an IGVM.
>> The IGVM describes 2 special page (ranges?): One for the CPUID special page,
>> one for the variable store seed. To precalculate the launch digest you would
>> need the firmware IGVM, and the seed blob.
> Guess we'll have to update the IGVM format spec for that, so we have
> page types for 'db' and 'dbx'.  With that it should be possible to load
> the igvm, find + update the pages + write it out again.  Then wrap it
> into an UKI add-on + copy to ESP.
>
> RH default igvm/add-on would simply have empty 'db' and 'dbx' pages.
>
> Looks workable to me.


I would personally consider the "RH binary adds RH signature into binary 
by default" a backdoor, but that's you call :).

I agree with the plan to amend the IGVM spec with the UEFI variable 
update page. I don't think it should be "db" and "dbx" pages. It should 
be a more generic. In fact, why not make it a loader UEFI (PE) binary? 
The binary installs the db/dbx updates and chain loads the actual 
payload UKIs using a file format that's private between the loader 
binary and the sd-boot stub.


>
>> All unauthenticated data, such as locations of the UKI and its add-ons gets
>> passed as parameter to the firmware IGVM.
> i.e. have a IGVM parameter for opaque_addr + opaque_size instead of
> placing this in the vmfwupdate struct?


It would be a pretty natural fit for it, no?


>
> take care,
>    Gerd
>
> PS: in Berlin tomorrow?


Yup, let's sync up! :)


Alex



