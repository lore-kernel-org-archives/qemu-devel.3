Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D87E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 22:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKlwK-0006jx-4l; Mon, 09 Dec 2024 17:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tKlwF-0006jC-TH
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 17:09:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tKlwD-0005rf-Lm
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 17:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733782148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+dFsfuR3dq7gqJpTaVizbuHFRB2H+DxyhWCtbVLqB1k=;
 b=GpjGFfbGmHc/em3DJAo1KSMLYlqBcMZ9GtixAJD0mH3JV1h7QACqHtyaSLsOCWjFkEMiMv
 AwKW0QaX8bMAQgx/7qzhcgmJ4h/LU+ACJFmTZiHp+ztJD2zwz9o1jX2IzWQK4B+Op/ts7n
 FviPBVogzNR2AszdLCjaPFPxe2F+n2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-OJFB_1P6PSWG0uKyJxGkIg-1; Mon, 09 Dec 2024 17:09:05 -0500
X-MC-Unique: OJFB_1P6PSWG0uKyJxGkIg-1
X-Mimecast-MFC-AGG-ID: OJFB_1P6PSWG0uKyJxGkIg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e1fd40acso2595751f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 14:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733782144; x=1734386944;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+dFsfuR3dq7gqJpTaVizbuHFRB2H+DxyhWCtbVLqB1k=;
 b=hLVoIyX2iUijj7IAKt38oD6sWKwcRKF0xsWwCP58/Ff2TZ4X2ateLdzwimLZbyTWKc
 69mbCe7K6bUVpTVrSlwGor+cLWLKctn4pp3US4cLtgeYhjqFcj243mgxqM/ak9VHO6rP
 OxCE7NYYJJuzxnPfP6zM08+PxaphZrHVUPHgsz34Yr9Px1eJKOolGWwqMSjzxh6KaaaI
 UiBimLn/wzbZ3L9cHE7tZs0ROKWtoqsEDIEIFsjm09lmoFkb002vF2DQDD6HDRj2ea/B
 136nSSdJ8roBW9mews1dFl/j2WCWktrDvRn0jxrkXR5D4NUDZT1WTSHtTwIbd/nDnLob
 w4+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW27qjb9TemYyxF7Nz++2gCE2it3z8bi3RIbCrXc3gSmDkbI9Ca/Yzr/+wOu7l/EL7u5uenmKJmlnK@nongnu.org
X-Gm-Message-State: AOJu0YyyVUkTh0JqxVLthh3/y67Cn8+xtfBhn9nu7WJrYe/MqSit8lFE
 GgrS5bVGZCC7R0pj/RI6XG6pBVUcutfwICBaRYdruwb7OQuDVqVBJM0BPKbxkpJQQCheByNYu6A
 HT7Jyzljxr5vcWMYvgO43kF5Aq8VDlHIYhhaQIjTdBPffJq9JzMUY
X-Gm-Gg: ASbGnctaLa0EtEUUY5rKrlbDSBn1uT3BedR/fVlkdMKOQ98FsgCV8nJbJpNMrYd4gVY
 S/uJRF9R7pHCQX4M1+A+OH1PHAdzXQzpGzcVbxq42p90RdSzXYPVYMzF5LuvKCrQMxpy8/MbI27
 ObvtsSmVfwC+EngV29nxYDb7VknIc5nmOAEQoEkl9KrqaUsGcu+wFwewivtHizlQk9vJOJEIl7U
 0Kc7GLWVeV0GgKjky//bunDclivwPvN+/AAIKRMdw52XmdzpM2TmPWTpDO13RsKGF2lzDrAb0Vh
 kyqa/aF0WAeEtCxY5fjota3PnbEWerZ0wKAp2JzcjNCYhZhv5XqxPLmYc7CCsrNWHL924TVUO4I
 bZw==
X-Received: by 2002:a05:6000:4112:b0:382:47d0:64be with SMTP id
 ffacd0b85a97d-386453dff87mr1402355f8f.29.1733782144637; 
 Mon, 09 Dec 2024 14:09:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG8Qe96IOp5UspUE6Kdu1vcTkI5HExqAL8tSgp56lcaKiAwZ1aXEvBSTUV7tAdQANTaGmcnQ==
X-Received: by 2002:a05:6000:4112:b0:382:47d0:64be with SMTP id
 ffacd0b85a97d-386453dff87mr1402338f8f.29.1733782144249; 
 Mon, 09 Dec 2024 14:09:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65?
 (p200300cbc71b2c007bfb29fe9e6f2e65.dip0.t-ipconnect.de.
 [2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf40a0sm14070569f8f.13.2024.12.09.14.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 14:09:03 -0800 (PST)
Message-ID: <7bd2018a-df16-4ede-b7d7-dfdb9cbfc7c0@redhat.com>
Date: Mon, 9 Dec 2024 23:09:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: add support for guests that request direct
 mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <20241209192927.107503-2-mjrosato@linux.ibm.com>
 <f7451934-bf20-4c50-8780-4d5ebf932096@redhat.com>
 <31b6b62b-4656-4ca0-a8ac-99fe4293de45@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <31b6b62b-4656-4ca0-a8ac-99fe4293de45@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 09.12.24 22:45, Matthew Rosato wrote:
> On 12/9/24 4:01 PM, David Hildenbrand wrote:
>> On 09.12.24 20:29, Matthew Rosato wrote:
>>
>> Hi,
>>
>> Trying to wrap my head around that ... you mention that "pin the entirety of guest memory".
>>
>> Do you mean that we will actually end up longterm pinning all guest RAM in the kernel, similar to what vfio ends up doing?
> 
> Yes.  Actually, the usecase here is specifically PCI passthrough via vfio-pci on s390.  Unlike other platforms, the default s390 approach only pins on-demand and doesn't longterm pin all guest RAM, which is nice from a memory footprint perspective but pays a price via all those guest-2 RPCIT instructions.  The goal here is now provide the optional alternative to longterm pin like other platforms.

Okay, thanks for confirming. One more question: who will trigger this 
longterm-pinning? Is it vfio?

(the code flow from your code to the pinning code would be nice)

> 
>>
>> In that case, it would be incompatible with virtio-balloon (and without modifications with upcoming virtio-mem). Is there already a mechanism in place to handle that -- a call  to ram_block_discard_disable() -- or even a way to support coordinated discarding of RAM (e.g., virtio-mem + vfio)?
> 
> Good point, should be calling add ram_block_discard_disable(true) when set register + a corresponding (false) during deregister...  Will add for v2.
> 
> As for supporting coordinated discard, I was hoping to subsequently look at virtio-mem for this.

As long as discarding is blocked for now, we're good. To support it, the 
RAMDiscardManager would have to be wired up, similar to vfio.

I think the current way of handling it via

+    IOMMUTLBEvent event = {
+        .type = IOMMU_NOTIFIER_MAP,
+        .entry = {
+            .target_as = &address_space_memory,
+            .translated_addr = 0,
+            .perm = IOMMU_RW,
+        },
+    };


Is probably not ideal: it cannot cope with memory holes (which 
virtio-mem would create).

Likely, you'd instead want an address space notifier, and really only 
map the memory region sections you get notified about.

There, you can test for RAMDiscardManager and handle it like vfio does.

-- 
Cheers,

David / dhildenb


