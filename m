Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF98D132DF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7z6M-0002sB-RW; Mon, 04 Nov 2024 10:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t7z6J-0002rj-U3
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t7z6H-0003Sc-AR
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730734480;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nSzC8fuhrTYfNX2e1clLraq8/0hvYKlTSC3OeLDtmLQ=;
 b=Ei9Z55JXPIpFHw5HPcqtevndB/cCQSZaKmMQ1Gy0zyOLwbV9rCWDZR6LPu5nlvrSto+JH2
 aPPCbq86KpftiTu/jbxtRcRgdsTkRII9Wk8q6mZgMTW1WQAYIkO17lxSmxdBcVQe3N5nF7
 tTh6rjEVU0ZXVG5s0W2VmBK5IaY+nI8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-gOTti7e8N5moe3bUtJrOmw-1; Mon, 04 Nov 2024 10:34:38 -0500
X-MC-Unique: gOTti7e8N5moe3bUtJrOmw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d47127e69so1842858f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 07:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730734477; x=1731339277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nSzC8fuhrTYfNX2e1clLraq8/0hvYKlTSC3OeLDtmLQ=;
 b=ZuPhSUpkEjO1q7pTUZlFwDTxUjAoH21zC4JiZDYJ7eEog+c2wYFz+wmRYsWOlPkanD
 0bTeKbvACRDhipvuvCtrfEK0O59ySnp5+JhkTDLt6IiM87yaOoZy0ONj/bmTGtOq6qhz
 S4cD4FNu/+4kOKCGQKqHvNONca6K8vzp4i5iEAcCC1dx6HCsyDWxllsqRP74xXtBM/zV
 SLeRvCBrwBUUqSKUyXRsRM49yFvtSYDJE8PDxvj0lE0BuOf3JXrHT59/qWTqkz3F1SME
 emPOwbOA7GTsd5VdPlvVj9AQwatKAtYS6gP7G2Tp8jlSX30J7/fOqMyz4LjieOwcrZiy
 Jlpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl+qzD39R6aMpRibCE0C5gZ39w3hlSDMyk+ZtaWH5EmMi0VBSWlaueR3FVJvBAk22plSBIUzAyKX0Z@nongnu.org
X-Gm-Message-State: AOJu0Yy28SASYlIcQIWtpUCRjAlQKrqzmy9UKbURglGPZT14EByNknMW
 DTo2BfPm2UX3LKwgx34BwBpF20TNdoOVJbe7fwYFtxZYciBkdc1GUL0WIIghMH4zmNVGMtX8uvL
 5Z6vV2ZW+VnRpLT2fGpOBM/8pl9UuVhnG/RjPiU7U3Mml/dEKGxJ4
X-Received: by 2002:adf:ebd2:0:b0:37d:3f42:9b59 with SMTP id
 ffacd0b85a97d-380610f7ea7mr22023338f8f.11.1730734476716; 
 Mon, 04 Nov 2024 07:34:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHye8TT8MTrXCSMQ9mkus4MGj+FiLhpS9zRuPDmehNe0w/kgz6ZwC8PSbE0EzuU1gXHNIBaJQ==
X-Received: by 2002:adf:ebd2:0:b0:37d:3f42:9b59 with SMTP id
 ffacd0b85a97d-380610f7ea7mr22023318f8f.11.1730734476312; 
 Mon, 04 Nov 2024 07:34:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b32sm13547570f8f.18.2024.11.04.07.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 07:34:35 -0800 (PST)
Message-ID: <52690aae-55b6-47d5-a308-dd75475f8377@redhat.com>
Date: Mon, 4 Nov 2024 16:34:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 21/21] arm/cpu-features: Document custom vcpu model
Content-Language: en-US
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: eric.auger.pro@gmail.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com> <Zx__Zi3Zpg1AspnE@pinwheel>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Zx__Zi3Zpg1AspnE@pinwheel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Kashyap,

On 10/28/24 22:17, Kashyap Chamarthy wrote:
> On Fri, Oct 25, 2024 at 12:17:40PM +0200, Eric Auger wrote:
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> Add some documentation for the custom model.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  docs/system/arm/cpu-features.rst | 55 +++++++++++++++++++++++++++-----
>>  1 file changed, 47 insertions(+), 8 deletions(-)
>>
>> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
>> index a5fb929243..962a2c6c26 100644
>> --- a/docs/system/arm/cpu-features.rst
>> +++ b/docs/system/arm/cpu-features.rst
>> @@ -2,7 +2,10 @@ Arm CPU Features
> [...]
>
>> +Using the ``host`` type means the guest is provided all the same CPU
>> +features as the host CPU type has.  And, for this reason, the ``host``
>> +CPU type should enable all CPU features that the host has by default.
>> +
>> +In case some features need to be hidden to the guest, ``custom`` model
>> +shall be used instead. This is especially useful for migration purpose.
>> +
>> +The ``custom`` CPU model generally is the better choice if you want more
>> +flexibility or stability across different machines or with different kernel
>> +versions. 
> Does "more flexibility or stability across different machines" also
> imply "live migration compatiblity across host CPUs"?
yes that's the goal
>
>> However, even the ``custom`` CPU model will not allow configuring
>> +an arbitrary set of features; the ID registers must describe a subset of the
>> +host's features, and all differences to the host's configuration must actually
>> +be supported by the kernel to be deconfigured.
> [...]
>
>> +The ``custom`` CPU model needs to be configured via individual ID register
>> +field properties, for example::
>> +
>> +  $ qemu-system-aarch64 -M virt -cpu custom,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
> If possible, it would be really helpful (and user-friendly) to be able
> to specify the CPU feature names as you see under /proc/cpuinfo, and be
> able to turn the flags on or off:
>     
>         -M virt -cpu franken,rndr=on,ts=on,fhm=off
>
> (... instead of specifying long system register IDs that groups together
> a bunch of CPU features.  If I understand it correctly, the register
> "ID_AA64ISAR0_EL1" maps to a set of visible features listed here:
> https://docs.kernel.org/arch/arm64/cpu-feature-registers.html)
Not all the writable ID regs are visible through the above technique.
But indeed I think we converged on the idea to use higher level feature
names than ID reg field values.
However we need to study the feasibility and mappings between those high
level features and ID reg field values.
The cons is that we need to describe this mapping manually. Besides
being cumbersome this is also error prone.
>
>
> Next, I prefix the below by noting that I wrote it before seeing
> Cornelia's reply that the name "custom" is not set in stone:
> https://lists.nongnu.org/archive/html/qemu-arm/2024-10/msg00987.html.
>
> I wonder if the word "custom" is starting to get overloaded; on x86:
>
>   - Libvirt itself uses the term "custom" this way, to quote its
>     documentation[1] for the 'custom' XML attribute:
>
>       custom
>     
>       In this mode, the 'cpu' element describes the CPU that should be
>       presented to the guest. This is the default when no 'mode'
>       attribute is specified. This mode makes it so that a persistent
>       guest will see the same hardware no matter what host the guest is
>       booted on.
>
>   - Some management tools also follow libvirt and use the term "custom"
>     to refer to one of two things, (a) a specific named CPU model that
>     libvirt and QEMU recognize, e.g. "Cascadelake-Server"; or (b) a
>     named CPU model + extra CPU flags, e.g. this is how OpenStack
>     uses[2] "custom" to configure CPU models, and flags that can be
>     enabled or disabled via "+" or "-":
>
>       [libvirt]
>       cpu_mode = custom
>       cpu_model = IvyBridge-IBRS
>       cpu_model_extra_flags="ss,+vmx,-pcid [...]"
>
>     (Note the "cpu_mode" there: it is referring to the three possible
>     modes that libvirt and QEMU support today: 'host-passthrough',
>     'host-model', and named CPU models via "custom".)
>
>     The above config translates to this QEMU command-line:
>
>         -cpu IvyBridge-IBRS,ss=on,vmx=on,pcid=off [...]
>
> Now if QEMU introduces "custom", it is likely to create some confusion.
> But luckily, as referenced above, it is open to change. :)
Agreed! Thank you for the references!

Eric
>
>     * * *
>
> FWIW, I agree with Dan here[3] that it would cause less future pain if
> Arm's named CPU models also decides on a "baseline that matches some
> corresponding real world silicon".  I've experienced plenty of such
> debugging pain in x86-land from years of troubleshooting live migration
> bugs involving CPU model (in)compatibility.  (Often, with help from
> DanPB and Jiri Denemark).
>
> [1] https://docs.openstack.org/nova/latest/admin/cpu-models.html#cpu-modes
> [2] https://libvirt.org/formatdomain.html#cpu-model-and-topology
> [3] https://lists.nongnu.org/archive/html/qemu-arm/2024-10/msg00888.html
>     — [RFC 21/21] arm/cpu-features: Document custom vcpu model
>
> [...]
>


