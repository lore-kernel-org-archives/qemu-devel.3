Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA98C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VCt-0001fS-4j; Tue, 15 Sep 2026 11:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6VCr-0001fA-I7
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6VCp-0006Vm-9G
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789486581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qrFxi3srHFbZEdW0yrpmSTfpyYy/h61z2hCU0Lpx4+E=;
 b=g7a+QB/npDwgHN2K96AOrVBlvw0AXVh3IXLFx8gMOamnrFb2ifRWm/Um5yDPfBMpRhC3bK
 4u7+jMTfP8g770B8QvVF9AwpymE1boIi69L5uqTRGUWvMJblmEpv3DQDXi7MWtUpnYb5q5
 W/hHaHjRHyE9JawK64VcdhTSCKs0oQ0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-1DcmsXXgN8aRmXqvIc17mw-1; Tue, 15 Sep 2026 11:36:19 -0400
X-MC-Unique: 1DcmsXXgN8aRmXqvIc17mw-1
X-Mimecast-MFC-AGG-ID: 1DcmsXXgN8aRmXqvIc17mw_1789486578
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486e8fb7d75so1633265f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789486578; x=1790091378; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qrFxi3srHFbZEdW0yrpmSTfpyYy/h61z2hCU0Lpx4+E=;
 b=LOI3RukPFOm3lCApGkn9S77DqxZm8sD/XZYaLAVMLPWVWKQlZiehH8T0iBoExOhZub
 XKd3YlibvTvXWFPsw/0ikJ54jWRv3fpGi1UfeDw91q6YchCajg39Ia1KvDQEmR2qOaVW
 zP0oTwl1CbJ/1wBUEaWIZIBCAX997+Hl7JSNW22VqbwQeJikj78BIrVZajzQnh6xzB5/
 GahILeIVkWK/4ugFObFJk/mOf+BC44m4H9LibBMmFDPcGtzk0eMdmH4Q8CDHdQm22+l7
 He/H+LKdzTQpA07b9D2ekYeW+KldjMSz8pto+TFe7HR+op4UAIXTuqQQqqd/14EAX30n
 rvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789486578; x=1790091378;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qrFxi3srHFbZEdW0yrpmSTfpyYy/h61z2hCU0Lpx4+E=;
 b=J8F3vQYo362mYN+JMYIXn6YVz8n8P704mVC+tc6dWYebktVnEejfYJ0IAj8TS4/azt
 yDFxeECSuOKxk3oCEAtfR6DW2Y3GduG09gUynExenruJINoBBOa0pVghJlDSR4HqawG/
 fsbbpbl1hktjHWf8VRsiWRxKEPfuJW6bqDoNbbfB4tfPG7lN5FyV5mFrzZPq48gULCMR
 iHlXVCoKoEJkfXpdiBkVjbMq9WYOommGOk/K0xK33164pJ04obiq/Qu2hByMNj6ONDK0
 5U9EgD6sUEa9DE1vbeB0K/4VuMpCldel5brnIZuz++wirgWLaYKA0DSSTNooDO1opvNA
 4RIw==
X-Gm-Message-State: AFuF++nQtouU6Lph+zzRlxMULJyDPnB+zc+TYGgJUN3+aubV5t0ImRjm
 sB8vk7ClU9XRqwEZTO1UMDLtnmIaLjCUihdP+g/2t5WJKLCDlRTRrYiCsqN2lw3TYrke5PEBQBl
 HqVHcASWMsfcX7AKtsAkKlfO1YNjZbcs2pbPiOu+jnTffUJc3qnY+CIJD
X-Gm-Gg: AYBFou28ZST6RrCZOosHU7SM52X4DuAmS6uhPKQMwP19A8pS4JIfGs99vaN72+GHo6x
 RbV6NIdQgtP9E4iP9urhlnbh2UM05MvAZQBxcWE838HJc3ANGoQQQVyEL2tJN7+AIxB+bB2S7UU
 MddOts6e8+q2SxUIwSeTn0hkeYroOpePsRyFsx3od6ab4ztIt8sxFsrhfwNse9vm8wjvjEK7F1z
 l1k+BMmPuiksDFvKS/nE0GNgCpvkBEGPLICNnVMYDcZeMZvyuZ+6HsShTSh00Hyne5pL7PE6Wf9
 Zn2A0R+IS3U/pgLfq/95i7RmNFilRHw4hHT6sOH1XvyhgN9QvDEo1qf3B2Czr91lQ+//6MveIhD
 BEFyt0R9HhBr3A0wHT1hiZB+qMP9gdRrjqviPcsACSA==
X-Received: by 2002:a05:6000:2dc5:b0:487:971:6b19 with SMTP id
 ffacd0b85a97d-4870a9cf7f6mr1601439f8f.36.1789486577985; 
 Tue, 15 Sep 2026 08:36:17 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc5:b0:487:971:6b19 with SMTP id
 ffacd0b85a97d-4870a9cf7f6mr1601386f8f.36.1789486577502; 
 Tue, 15 Sep 2026 08:36:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm32711419f8f.10.2026.09.15.08.36.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 08:36:16 -0700 (PDT)
Message-ID: <1ef3b146-88b6-4c34-96f1-a272cf9b52d9@redhat.com>
Date: Tue, 15 Sep 2026 17:36:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/pci-bridge: Add x-speed and x-width properties to
 xio3130 ports
To: "Michael S. Tsirkin" <mst@redhat.com>,
 David Vrabel <david.vrabel@nutanix.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260915072507.1230187-1-clg@redhat.com>
 <20260915060015-mutt-send-email-mst@kernel.org>
 <81c899d9-a9fb-4eb2-ad85-7dde2f626646@nutanix.com>
 <20260915102221-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260915102221-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/15/26 16:22, Michael S. Tsirkin wrote:
> On Tue, Sep 15, 2026 at 12:17:31PM +0100, David Vrabel wrote:
>> On 15/09/2026 11:01, Michael S. Tsirkin wrote:
>>>
>>> On Tue, Sep 15, 2026 at 09:25:05AM +0200, Cédric Le Goater wrote:
>>>> Hello,
>>>>
>>>> The xio3130-downstream and x3130-upstream devices lacks x-speed and
>>>> x-width device properties, making it impossible to configure PCIe link
>>>> speed/width when building PIX switch topologies for GPU/NIC passthrough.
>>>>
>>>> Fix that and preserve migration compatibility with a 2.5GT/s x1 default.
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>
>>> Given they are clearly intended for users, time to rename to width/speed
>>> everywhere?
>>
>> A more comprehensive series (hw/pci-bridge: Configurable apparent bandwidth
>> for the PCIe topology) is here:
>>
>> https://patchew.org/QEMU/20260908155223.164787-1-david.vrabel@nutanix.com/
>>
>> This adds new upstream and switch port devices with configurable speed/width
>> and renames the options so they are non-experimental (but do not the open
>> question about the usability of the speed option with the need to set 2.5
>> GT/s as the string "2_5").
>>
>> I did consider adding options to the XIO3130 device but since the real
>> hardware is Gen 1 only and does not support speeds/widths other 2.5GT/s/1x I
>> didn't consider it appropriate to claim these emulated ports are more
>> capable than the real hardware.
>>
>> David
> 
> Right that makes more sense to me.  Cédric what do you think?

I didn't know about it.

Regarding HW accuracy, I agree XIO3130 being Gen 1, the new speed
and link are inaccurate and this could confuse some tools checking
vendor/device ID.

Regarding the code size, user facing changes, existing topology,
migration, etc, boosting XIO3130 capabilities is safer. What is
worrisome is the downstream impact. backports will be a problem.
That said I didn't check.

David's proposal is preferable, as the device doesn't pretend
to be real HW and should be pursued for upstream. Mine would be
more a fallback solution for downstream. Hopefully not,

Cheers,

C.


