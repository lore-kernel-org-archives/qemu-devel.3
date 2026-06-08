Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAB6CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWXtl-0004Ef-Ll; Mon, 08 Jun 2026 07:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wWXtj-0004EA-Tt
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wWXtg-0001px-Ql
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780917119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSLsrDlw10OwN3fDYEb32S5Ttf8K+2H6J9xNILpK/ig=;
 b=GySBumxCnqq8uWYV6C7rwcOnZy4DV3R752d07y7p8G6b/0HFx2jZ505XsQ3GhTtLLsBsSj
 kq+PXj9rtYgl332agQRxuc4GojawX/13qxxA1Sp5dTlRnXmAPo3S+GXXB0XEc8N+xMOgtT
 io1vOJFcDGvhMkRIezm9vY3EP5C1Cr4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ke3pKTDPNcam04KEV3XH1g-1; Mon, 08 Jun 2026 07:11:57 -0400
X-MC-Unique: ke3pKTDPNcam04KEV3XH1g-1
X-Mimecast-MFC-AGG-ID: ke3pKTDPNcam04KEV3XH1g_1780917117
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf32259e0eso56855065ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780917117; x=1781521917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fSLsrDlw10OwN3fDYEb32S5Ttf8K+2H6J9xNILpK/ig=;
 b=UR6F9/m24FI2BCrWMyLn4KWGnITey2lHRNUcZfP88rPxRA7DEntzwDTVIplyUwfK+C
 DJFesNRYr3lw6RtYZTIcKPNzaOXM05UtZWYqKYrhT3/4zPPgoJVxX8SC/EqWlwVh3L79
 5+KgSAWN7IJLDbpTQHrqY6/GI13h9mvGK/RAE97/T6p2f1aR5ODZAsybDDX8I/aQTIUn
 mZXXnODYoh+X3MUkSI/svueTIHxazIkUmecIbQMBPJ//CGHfrC+kBXBuQCP/R3wFltpH
 RayiQbdw91cA+R2zfrsJVMQHA/xY79RELtC4DnRO1oQUfUfRqguKjZXfkmzdz5WU9eq8
 cJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780917117; x=1781521917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fSLsrDlw10OwN3fDYEb32S5Ttf8K+2H6J9xNILpK/ig=;
 b=I3abl1aMBp5+TS55dr6vrGthMoBgsvQJetoE++gHgwYhqW0ItIHPR4pdR2R2DTv8AP
 c8rdRlX29mgiqANGj92eDZ/i47Clx6PJNbK1XOaRL3X62mxBAydf0mCJ307+xZQLMIuD
 iBRVOYwIE6hOGD2iXW8VPiGltDP29FLcx17CTp5/F3qHzaE0+ydc2Flw65fLpd5kUQ17
 5pcV1Qqz9b3aqLSqAyDNWUT1DgWqH4qOyD/f2/tbbU17c0PimKXoAZ3oYwNuC0X1xYQR
 EKH6ZcNba+N/g4F251G5OeAj09+C30fHb8Pwmr2oXnQ/j5UQujc06NdUAW68OpteSW/c
 nLQg==
X-Gm-Message-State: AOJu0YxvoYF2Udsun0jRKQf2AknrGJcFwWRo5cjQ8ipgtBocHeW14TPH
 5VaUDsgv6hwkaotJsoa6Hq0HCAg9KSLb5Ix2rO76ORIGsRJdAkU/wHQ+ThF2tAN1pQvZ26sWbyW
 6Kw/66Nfe5+UfWtS+gt/FB/y0jbC6BD3/eDE/W5rFMb856h5m4NLuFl3+
X-Gm-Gg: Acq92OEh+lREgZvjbw4nQZQWe4CkndJFM7BpaSvay3n0qsFfVyOTRGCiE0oc71RX9uz
 /VQduwdhu6tdYb7qITx73tIJ7B+VSr3okupxz3Nn7XbDjNbq+aYZW9Mmn8KkYodlVweN1B7m0q2
 NdHAXvtVGCGcyd2OATTeZlYXmRJzPBeNeqN74441eZVxcNzM3sYyLyFHmCRXvF95aiUTI1ssxlG
 EfDdiIz8PeJG5RC9dqiTVt4AOpIz5nbPx5SrCFnGXI56C8qpAM2VP+Uq4CsoZsUwNADT70NnOzk
 403LdQARc7P+JxfAwAfKVMeWAhaAA80zzlsmWrtAhenpAQQ8q18bkd1kssH9P9HhaW9PrVeaaA4
 LVRbVjzxdYl03AcLgy+IPZ2kX3gGU2bAFjyfHTpoDgYC0v/8bIsxcJEfWTk/s7kwgl6WMmBG5oD
 A=
X-Received: by 2002:a17:903:41c7:b0:2c1:77cd:fb0b with SMTP id
 d9443c01a7336-2c1e85e04bbmr166144975ad.37.1780917116796; 
 Mon, 08 Jun 2026 04:11:56 -0700 (PDT)
X-Received: by 2002:a17:903:41c7:b0:2c1:77cd:fb0b with SMTP id
 d9443c01a7336-2c1e85e04bbmr166144715ad.37.1780917116335; 
 Mon, 08 Jun 2026 04:11:56 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f890b2sm180082895ad.26.2026.06.08.04.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 04:11:55 -0700 (PDT)
Message-ID: <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
Date: Mon, 8 Jun 2026 21:11:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jugraham@redhat.com, shan.gavin@gmail.com
References: <20260608001821.850921-1-gshan@redhat.com>
 <aiaDgG26a6TUrKuM@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <aiaDgG26a6TUrKuM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

On 6/8/26 6:55 PM, Daniel P. Berrangé wrote:
> On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
>> On the guest where a NVidia's GH100 card is passed from the host, the
>> guest system hang can be observed on attempt to compile 'cuda-samples',
>> as reported by Julia.
> 
> snip
> 

Thanks for looking into this.

>> By default, the max bounce buffer size is only 4096 bytes, even less
>> than one page when the guest page is 64KB. This tries to fix the issue
>> by inheriting the customized max bounce buffer size of the virtio bus's
>> parent through property 'x-max-bounce-buffer-size' when the customized
>> size is a larger one. With this applied, no guest system hang is seen
>> with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.
> 
> "x-max-bounce-buffer-size"  is an experimental / unsupported property.
> 
> We really shouldn't be expecting users to have to set this in a production
> deployment in order to stop a guest from hanging.  Even if we dropped the
> experimental marker from this property, users would still need to know to
> provide this magic setting, so it would still be broken out of the box.
> 
> How can we  get a solution that "just works" out of the box, which is
> fully supported, not relying on experimental properties ?
> 

How do we know that "x-max-bounce-buffer-size" is an experimental or unsupported
property? I guess the properties whose names start with "x-" are all treated as
experimental and unsupported?

For this case, the bounce buffer is inevitable as the memory region can't be
directly accessed. The memory region is initialized by memory_region_init_ram_device_ptr()
in hw/vfio/region.c::vfio_region_mmap(). So the question is how the allowed
bounce buffer size can be specified by users, and it's why the existing property
"x-max-bounce-buffer-size" is reused.

I even thought of a new property for MachineState (e.g. "limited-bounce-buffer"),
which is set to on by default, following the existing behavior. When it's set to
off by users, the max (allowed) buffer size won't be checked at all. However, I'm
not sure if this makes sense at all.

>>
>> Reported-by: Julia Graham <jugraham@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/virtio/virtio-bus.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
> 
> With regards,
> Daniel

Thanks,
Gavin


