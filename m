Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A497BC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 08:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twzHQ-0002Hj-Eg; Tue, 25 Mar 2025 04:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=172191a1e=graf@amazon.de>)
 id 1twzHP-0002HZ-19
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 04:04:59 -0400
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=172191a1e=graf@amazon.de>)
 id 1twzHM-0002sm-VI
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 04:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1742889896; x=1774425896;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xHULfJdpCjNNf+K8/84ojUi1JsIvOLMizSVmCF8JGDk=;
 b=F/Kg4yTBpijqy76LNrVyqRQFwS+kyZGTa5v8c2aZGVItFlXszKjOFXpD
 pbI+c9bQv7QfSTMQ0YkYW7/WGWXRzx+rr7lJHnu3o09RqLSHujH8s7ij4
 hNLRsSypfuYmLimCO7/9SekXQiwwaf1VbhkPO7sZbLBXfPMISrTNHaHuk Y=;
X-IronPort-AV: E=Sophos;i="6.14,274,1736812800"; d="scan'208";a="181615274"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:04:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:16962]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.16:2525]
 with esmtp (Farcaster)
 id 01270109-b87e-4178-9dbe-fa5d0cab68dd; Tue, 25 Mar 2025 08:04:51 +0000 (UTC)
X-Farcaster-Flow-ID: 01270109-b87e-4178-9dbe-fa5d0cab68dd
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 08:04:51 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Tue, 25 Mar 2025
 08:04:47 +0000
Message-ID: <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
Date: Tue, 25 Mar 2025 09:04:45 +0100
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
References: <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
 <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
 <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
 <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
 <CAK3XEhPYmBsn2-=PMR7qVQHiu0ydoh3EfJOEuunLccriSkKipg@mail.gmail.com>
 <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
 <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
 <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=99.78.197.219;
 envelope-from=prvs=172191a1e=graf@amazon.de; helo=smtp-fw-80008.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 24.03.25 18:53, Gerd Hoffman wrote:
> On Mon, Mar 24, 2025 at 05:31:30PM +0100, Alexander Graf wrote:
>>>>>> What does all this mean for the hypervisor interface ?
>>>>> That means we'll go scratch the region list idea and depend on igvm
>>>>> instead.
>>>>> Which means we are back to the single firmware image.
>>>> So in this model, how are we passing the hashes of kernel, initrd and cmdline?
>>>> Are they going to be part of the firmware image as was previously thought?
>>> Either scratch the idea of using hashes to verify kernel + initrd +
>>> cmdline and use a secure boot signed UKI instead, or use IGVM firmware
>>> images and add the kernel hashes page to the igvm.
>> It's a nice idea to have a firmware IGVM file that contains a signature, so
>> you can for example have a RHEL provided IGVM that only runs UKIs that are
>> signed by Red Hat.
> Yep, that is what should be possible when all this is ready.
>
>>    - Attestable Bootable Containers. In that case, the command line contains
>> a hash of the target fs-verity protected partition. Red Hat can not be the
>> entity signing that UKI. It must be the user.
> Well, add-ons have been created to address exactly that:  Allow the UKI
> being configured without changing it, so the UKI can be signed by redhat.
> You'll go add user-signed add-on for the command line.


The problem is that add-ons are

   1) Separate binaries. So you need to match multiple files.
   2) In this case, get generated out of the vendor (RH)'s control in a 
one-off fashion.

I don't think "signing" is the correct way to address the latter. It's 
rather hashing. But I agree with you that it could (should?) be hashing 
at the PE loader level similar or identical to Secure Boot rather than a 
separate hashing mechanism.


>
>>    - Add-ons. How do you provide a "debug add-on" and prevent it to gain any
>> access to confidential data?
> Not sure I understand the point you are trying to raise.  Add-ons
> signatures are checked too.


2 points here here:

   1) With add-ons, there are multiple binaries. We can't only pass a 
single one.
   2) The security posture of the system may be different between 2 
validly signed images. Think of Daniel's example of verbose kernel 
output. Maybe I consider verbose kernel output already inacceptable, 
while RH thinks it's an ok posture to have. The user needs to have the 
chance to differentiate between a system booted with or without verbose 
kernel output.


>> So we need some equivalent of a hash page.
> Ok.  So two opaque blobs, one which is measured into the launch
> measurement and one which is not?  That gives you the option to pass
> around hashes (or any other data) and leave a trace in the launch
> measurement should you need that.


Yes, I think you want to have one or multiple pages with what 
effectively is a db append variable update blob. Or even a full variable 
store blob. Then a built-in always-on UEFI Secure Boot that runs in 
kernel mode rather than SMM. The IGVM should dictate the physical 
location of that blob so that you can precalculate the launch digest 
with the blob included. Ukify.py then generates the blob along with the 
FUKI.

>> That can absolutely integrate more deeply into UEFI and be actual PE
>> hashes rather than the icky thing the OVMF code does today.
> How the measured opaque blob is actually used is not something
> vmfwupdate needs to care about.


I agree, from a vmfwupdate point of view, we would basically have an 
IGVM. The IGVM describes 2 special page (ranges?): One for the CPUID 
special page, one for the variable store seed. To precalculate the 
launch digest you would need the firmware IGVM, and the seed blob.

All unauthenticated data, such as locations of the UKI and its add-ons 
gets passed as parameter to the firmware IGVM.


>> But we need to support a way to embed the hash in the ukify.py
>> generated IGVM on the fly. With add-ons, maybe even multiple ones.
> I'd prefer not patch the IGVM on the fly at boot time.


Does the flow above align with your preferences? :)


Alex


