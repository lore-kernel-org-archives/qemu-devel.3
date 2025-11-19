Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B94CF2588
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 07:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLchH-0001yN-72; Wed, 19 Nov 2025 02:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLcgo-0001wP-Kr
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:33:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLcgk-0000t9-Rq
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763537585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HWgQEJsOhMYfrcNiH7hgW62wNvTDMypRRmLvwz6fVCE=;
 b=U7+WbJRseUsfUrgcBbbfoTntKRc3iEr67fmqMQEGlVDW6spT3oqBVVIgFpEJJjQ6Pd1Nd7
 zSpqqQV0P3fKedDWF5DQ6vMiXekWhI7WlAjpij4m8ErfMzDC5pMZOCITImqVGD83n+do6M
 UiLvLwXn7kQHWlAI5tNGfkdwEJXgFyw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-DW6Qm65rMyOFyEGpX_T8_A-1; Wed, 19 Nov 2025 02:33:03 -0500
X-MC-Unique: DW6Qm65rMyOFyEGpX_T8_A-1
X-Mimecast-MFC-AGG-ID: DW6Qm65rMyOFyEGpX_T8_A_1763537582
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b3ed2c3e3so4407209f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 23:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763537582; x=1764142382; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HWgQEJsOhMYfrcNiH7hgW62wNvTDMypRRmLvwz6fVCE=;
 b=dAmcMEvxMVzN561VcvS0GSZkrD0iosM10FDgLlQVnhhvhPouhsuJ9fIMoWUfNsaEDp
 57SX3aGRglJ0aa14m/o3w2DFD7w3lRMfCcmBc13o7TTDP+QnOSCePuelnhk9jsNCVS6Q
 IfEPmKLBpBOPDIQOox8R8YMdP9vu4nVw840Iidc+0K1gAxnhDfyyXOUHW7UecXGmPuB0
 1sqqFAqY9u3JKNDZeNvzOA+C4PwoWE+UU0SuR0s/oN5plSPDHU3UlEJjkweQmDEqiucu
 XsTx2PoW4RyBoAkLkTUcf/T7IRRyhMm7kQFXhYm/NW7a5XmQ3lW69YKpiqw/l4hbfvJW
 TpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763537582; x=1764142382;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWgQEJsOhMYfrcNiH7hgW62wNvTDMypRRmLvwz6fVCE=;
 b=YQ4aBlflvZ3kGbbXI4twNbXrZs0caFCc8/E+8ME271go0DNNCyOzzctD6FPUZeWmoL
 Xhkj6YSZRgr2wgZNTqXrKdyRvlvjYM8fUdy/u7DZRfyymq9JV/9B6uQDkGQWrzfyg5Kc
 zzRWeWbObINmMGyzt3prL8lXK+P146FjYGzQwWf7XqFvTfFEqHD1DAN5Rca7+AdLC7cW
 ZrNG75Mzthxnh9txUDv8m9FanXBbn+QRbtxp+jwLq2RzgNZGu7r1KBX3P7ByEGg4HmEq
 bef/8uxTAx2YK/fo6QOZVOFqGfnfgHqfOvkAq3QlgCicxKlyecMLodiQC8quHtmMjNHm
 CICA==
X-Gm-Message-State: AOJu0Yx54/WKGRCyliNqnbRpGOU/Pph/tixkjk1RenzA3x5kxl4Fpx7L
 cZCICJj3rYR57r8HgkWJ7YJBvoej/k8k6CtFu/Kv6OLcCQaKabIQjdv94iC0r6hvhgzEdIZJUZS
 9qOqrHk3Xym8mMF8nU2tKy1hEdW5Wfuu+Ww9oo+3KrCgB8BXGGHpctpIf
X-Gm-Gg: ASbGnctbbcOrFQFqaHrLfgu0H5bwcmslDUFQ8dL0F/REYBYkOQzFppFWN4GZzkYgZkY
 +pFGqodtXqrBubah2pk0jzlLcKa+GrZvTV0d8u6LMK1PslaCfn7kBdvdKbfnQQyA3XIGZFVlEep
 OLEEAdOdiVKv2C3uX18MRQ9HK6eW1Hy0V4B7wXHdY+hFrvvbub3jR8T4QPRkoJTR4puUnBAhkXB
 AZ/pD8B2EHiXsKyeo2cAQ5JGJEYlOdZudiHmdUjZtokfJhwcC/rcQAeu4Vr2lwdufxW7S3DzWGD
 KAXak+DxQd3atJxZKD8Xzi1BerZ5kOrHEnUc3QBXN53gZwHGYAcMkFzyh7e54H19QREZ146/2wT
 lROGlGcHCPjToV7iRdmI8rQAcW0dFgvJVKUc=
X-Received: by 2002:a05:6000:26c3:b0:42b:5448:7ae8 with SMTP id
 ffacd0b85a97d-42b59372315mr18920266f8f.29.1763537582153; 
 Tue, 18 Nov 2025 23:33:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgUEcu8SFn37NRj5yJKAgRDktUvW6BimgonkownS4NaDFol48DDWFdzmF7d5xwcfAosKXR6A==
X-Received: by 2002:a05:6000:26c3:b0:42b:5448:7ae8 with SMTP id
 ffacd0b85a97d-42b59372315mr18920235f8f.29.1763537581782; 
 Tue, 18 Nov 2025 23:33:01 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e84b12sm38022240f8f.15.2025.11.18.23.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 23:33:01 -0800 (PST)
Message-ID: <e399cffc-155c-4846-9c68-5f449ab9a6f4@redhat.com>
Date: Wed, 19 Nov 2025 08:33:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/s390x: Fix a possible crash with passed-through
 virtio devices
To: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>
References: <20251118174047.73103-1-thuth@redhat.com>
 <8fd35be2f4d424f0093110a050c7e29830561012.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <8fd35be2f4d424f0093110a050c7e29830561012.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/11/2025 22.45, Eric Farman wrote:
> On Tue, 2025-11-18 at 18:40 +0100, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Consider the following nested setup: An L1 host uses some virtio device
>> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
>> device through to the L3 guest. Since the L3 guest sees a virtio device,
>> it might send virtio notifications to the QEMU in L2 for that device.
>> But since the QEMU in L2 defined this device as vfio-ccw, the function
>> handle_virtio_ccw_notify() cannot handle this and crashes: It calls
>> virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevice,
>> but since "sch" belongs to a vfio-ccw device, that driver_data rather
>> points to a CcwDevice instead. So as soon as QEMU tries to use some
>> VirtioCcwDevice specific data from that device, we've lost.
>>
>> We must not take virtio notifications for such devices. Thus fix the
>> issue by adding a check to the handle_virtio_ccw_notify() handler to
>> refuse all devices that are not our own virtio devices. Like in the
>> other branches that detect wrong settings, we return -EINVAL from the
>> function, which will later be placed in GPR2 to inform the guest about
>> the error.
> 
> I still think this is a good idea, but of course "let's try it" got me into the weeds. I
> reconstructed a configuration (dasd->virtio-blk-ccw->vfio-ccw->virtio-blk-ccw) that crashes the
> nested guest upon startup with today's master. Applying this patch generates that message to point
> out where it's broken (yay!), but the nested guest hangs during boot. Need to ponder this more
> tomorrow.

FWIW, we only tried to passthrough a virtio-input device to the L3 guest, we 
did not try a virtio-blk device here ... so that might be the reason why I 
did not see any further hangs after applying my fix.

  Thomas


