Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80977C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2nt-0004pN-0D; Mon, 16 Jun 2025 01:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uR2nK-0004iA-GE
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uR2nI-0000Fa-PE
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750053248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMfRDTTd+z5rrx4+j/hPhKppRd2jNHrTWcCtgthdrCg=;
 b=JLa9kAk5P+EBIcw2e/FEmJL0bOWR2EDH4lOzX4Dbwg6CMw1MAkxw+5Ep451fEZWrv1ZGkc
 15kEPeqJ33oEXibywhwIBffaWabn/g337Omrn5KR1uumYim4bU7HZq98oiETpI6ccCJ+Rg
 h1Gbtczz9gFv8ia3C2KgzmavbzwG9XA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-fi_IzGRBM3e8qphOtRXlDg-1; Mon, 16 Jun 2025 01:54:04 -0400
X-MC-Unique: fi_IzGRBM3e8qphOtRXlDg-1
X-Mimecast-MFC-AGG-ID: fi_IzGRBM3e8qphOtRXlDg_1750053244
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-311f4f2e761so3995056a91.2
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 22:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750053243; x=1750658043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kMfRDTTd+z5rrx4+j/hPhKppRd2jNHrTWcCtgthdrCg=;
 b=Ra5gflxKIUzP9FLrSl00hclE9swB5hW0tLFv2uGDoe8Hn0pHl4SY4f1QrUUE4j9x6i
 a0/R+GRx7Qnuvt965+eQBVVPd0gCxsbJChCoK+al/GxqPk2FjjrUH4Llsq/ZS1iq2Kky
 sOqPNOfdCVRDcKGsN0NjyrFYKpkE4RH5g+z3wC6zG2NXiXovqTtKwdTeL2ZZbBLF9hsj
 MgCtsYy+2xXksWja65Nu3anCz62HhidWlrTTxf1rwJKn0RgGPZSobfxehKtNK8YcthFe
 UqC+ovKs8WbIlDKb0VO6qPFzHtPjJZIqwzbpqKmJDBFBLt3fPWM7E8naM74uBmv5CndF
 F+Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFXlEaTAb//jvRCnrID+3uLNS0N2vx3BYYWXKIz8oTUGmzuQtxbuHUD4biPYRff8xu43ipShtxK16r@nongnu.org
X-Gm-Message-State: AOJu0YwqVheyDude8S6npASG5RxcIEFZytz2v26LK5mjwYvg6j99Kd/7
 dM7w2T1P2+RBcw9eBjErj9CnaSl9uNbj8Sq4wUdoFHFo50DRKRvbYfSJS4GWeeXTD9KuDyZK48m
 lsV1KH4lNBqCzyfoi6vPQD1bkAN2oQFLzbuTspIy+JiwZhzyWUXv+9OyTpKgrUYke
X-Gm-Gg: ASbGncu7QYzwtqJMmON2yIVJVDp6+Uz1LD15VCP3lskTIPFuY2cWo8Z7Za4LfO6nPtB
 J4SEZJja1m3R34ZwsoCP5j8pfbW9eC5ZlmCWCxCv0Onq3rWuQzpcEpYG0t8ktZtaODOWRqqU22b
 MppAp3zn5XTe/H37U4uJPSHAQ5j5LFfPZFebs4dPtFt3PSmxfEpAjS6fZIjjU1A6O+lmZ5h+Rzl
 AeAM0rTMt3Xh+8P8A6NNYw6f5GAyTdptDKUwf8dxMpBg8BGJpekhrLechZSq0Bc7PkxjPinUaa2
 YqFXdqFGT4WBBiRE+mJhevEX7w==
X-Received: by 2002:a17:90b:5150:b0:312:1143:cf8c with SMTP id
 98e67ed59e1d1-313f1cafae6mr13251687a91.16.1750053243387; 
 Sun, 15 Jun 2025 22:54:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Tkziei6DrniR2lo0KCikc5LESJARfbBombyA95VD8XtmSM2NsnR29Mjz2VEXBMrEFZ7//Q==
X-Received: by 2002:a17:90b:5150:b0:312:1143:cf8c with SMTP id
 98e67ed59e1d1-313f1cafae6mr13251667a91.16.1750053243010; 
 Sun, 15 Jun 2025 22:54:03 -0700 (PDT)
Received: from [10.72.116.52] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313c1bcbb39sm7714920a91.8.2025.06.15.22.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Jun 2025 22:54:02 -0700 (PDT)
Message-ID: <2daf32b5-1279-444f-89fe-65633c1ec9f7@redhat.com>
Date: Mon, 16 Jun 2025 13:53:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hw/arm: Add the romfile compatatibility
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
References: <20250609073408.2083831-1-shahuang@redhat.com>
 <20250609073408.2083831-3-shahuang@redhat.com>
 <CAFEAcA8eA2wX1oQeNJfNBYq1NhHgoemYJ-ybOYAgBq2-t9ZPzw@mail.gmail.com>
 <aEak8utPPkHepVfR@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <aEak8utPPkHepVfR@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/9/25 5:10 PM, Daniel P. Berrangé wrote:
> On Mon, Jun 09, 2025 at 09:48:36AM +0100, Peter Maydell wrote:
>> On Mon, 9 Jun 2025 at 08:34, Shaoqin Huang <shahuang@redhat.com> wrote:
>>>
>>> On arm64, it doesn't use the vgabios-ramfb.bin, so set the property
>>> "use-legacy-x86-rom" to false, thus the ramfb won't load the
>>> vgabios-ramfb.bin.
>>>
>>> This can mitigate the problem that on release version the qemu can't
>>> find the vgabios-ramfb.bin if it use the ramfb.
>>>
>>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>>> ---
>>>   hw/arm/virt.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index a96452f17a..5f94f7a2ca 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -38,6 +38,7 @@
>>>   #include "hw/arm/primecell.h"
>>>   #include "hw/arm/virt.h"
>>>   #include "hw/block/flash.h"
>>> +#include "hw/vfio/pci.h"
>>>   #include "hw/vfio/vfio-calxeda-xgmac.h"
>>>   #include "hw/vfio/vfio-amd-xgbe.h"
>>>   #include "hw/display/ramfb.h"
>>> @@ -90,6 +91,8 @@
>>>
>>>   static GlobalProperty arm_virt_compat[] = {
>>>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "false" },
>>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "false" },
>>
>> I think we should find a way to make this default to "false"
>> and only be set "true" for x86. Otherwise every single non-x86
>> board that ever adds support for ramfb and virtio will have
>> to add these two lines, which is a source of future bugs.
>> (Whereas if you forget to mark a new x86 board as needing
>> the legacy rom you'll find out about it pretty quickly.)
> 
> Yes, going forward we this to default to true only on x86.
> 
> For non-x86, historical versioned machine types will need
> likely it set to true, in order to avoid the memory layout
> being changed IIUC.

Ok, I will set this to be true by default only on x86.

Thanks,
Shaoqin

> 
> 
> With regards,
> Daniel

-- 
Shaoqin


