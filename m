Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7879BD16816
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veAji-00009u-ED; Fri, 09 Jan 2026 06:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veAjQ-00007K-JQ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:32:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veAjN-00026E-FG
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767958355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qV9D9tpDFlsoFsFy+s2hc5y3qukMaAHKjzlJEmQcbYI=;
 b=JSUJN0tD8eGr2NVl/c/WWLn8GCKA2fRb457GkLbCBpnEVi/KJQTH5gcciJ/y4uyCl5dKCw
 nxmXjLzBRX6Uu5nImQJhr+xZbw2Gr81nUdN+NcoSjnR2Moi0xUtcchhPOogEaeXMwmKWzI
 HnIZOuTjirU7PEg+ka8MF+QbMU8LvPk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-krZVG_k-NxqFpvrrDwJNlw-1; Fri, 09 Jan 2026 06:32:33 -0500
X-MC-Unique: krZVG_k-NxqFpvrrDwJNlw-1
X-Mimecast-MFC-AGG-ID: krZVG_k-NxqFpvrrDwJNlw_1767958352
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b79fcc35ab2so339506766b.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 03:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767958352; x=1768563152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qV9D9tpDFlsoFsFy+s2hc5y3qukMaAHKjzlJEmQcbYI=;
 b=klVE6fEN5ZuRi51j0vN/G8lNcRfC2z7tWgfKQsZgI3Xd6L4fekG4olS/7icOc0LgnV
 ITFzkg6nR/vn1h8orq8LQnXVF6Hf1TvjkYMzEVgzoeQiQJ+0QbtJJDSbfW5mT1nQbIsH
 8O36WkQH2ko+ZJcp4zE4oxiLBSI+UTGzE+4nynoAC+caT8UlY4HB74lVDksrQ1lHWm32
 usOmCBq+wG7UNB2p7kx889wmvPZZLWSvp24/jZ1MWcgQRXaxRq8hduDACo1R5OnKwbCi
 ns2/6kUbx7qddTvprGm9NrJ/G5Yn88WXxOpgAd9wnoL3HKMWxwMTYqBPKT8pR1vTE9K1
 yZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958352; x=1768563152;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qV9D9tpDFlsoFsFy+s2hc5y3qukMaAHKjzlJEmQcbYI=;
 b=OV9I11K842rw0q+rzaStCpg5/sL70eyF3AjvFEJJctOksi0gV14QFUFIeupoNmF8ab
 wmnK2q5GC2HmaXXiioZnWYDdUVQngys7XdGd5bcyCSVheXigoKxYY8Mf737UMUpQWclp
 Ro3amTOBIzKgF2evuK4sRfkiAib45898bQlu67apmKZmyIZ4uPi/ALVwHl5ad83dqNT2
 i6U1hUrhTUAa0kKuIXEwsNOWbF1LUlHdVfpn46EcocuaRnK2CI7iZ5FVgxViJEB6TxJN
 ebxkXikIzBVMrStE/KHNlW3YWMmZVZP4Rgys0MakwEagpAc7lAWLJcqtn3vZ6yUFDqBe
 bwRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9kNXpfD3rld1wRso/z5UQQpawnf8GnSnOCh9Qr4CD4xQ3nOPRJJMgdHArcG/3sOFsEtKlWInbpC3w@nongnu.org
X-Gm-Message-State: AOJu0Yz4shyoKUSZzDmju/MKm59ak0/5XM8TqN3YFhpcLvdYjEIxYS5V
 pfpOh72FmvvNt13KxnpqhU9ohEvsLXUR/ftlQBNyN2+QPUbNQ4FiEFkLHNcE9g7N0ieq8xbOzrg
 0ygdkUcf7aJQUBFTnlnM+KR0QvAotXY8jZOvZ80fFyG6Zz6GTFkHZEsSa
X-Gm-Gg: AY/fxX4HbeNgJ3NnUOIyFr5HM+V5kf1qRyikRh97eLaZCe7uE0Mpb9enpzhBGHHOFRg
 7WAo9S2lKruAn4AE3YB9+49j2mUOqohBTy8s5tK8+W8r5BkW5jmAz9QF/cTKtiRviYOAfVUPPyW
 a9sZT2kB9ZTk+h6mxVBjvTznezjIkBR5CCWrXHtsGZVdY2InQQRRjAuKxCQHOipVwK7o9LouQyp
 bU7B2CyzoOorYztfUXV93aOYep8MD/yWy/sJpda3yTTqG/LxUi3dRHDb/FKL3vjssmDMjm1n67z
 ysCfe/AuEgFoUQpmFpi3eK+RWV3yL+EQxNBz1Xjdjw47lIE878wAXfTSfCUcofHPhmVNn1ZBvX0
 CKrXmFB4=
X-Received: by 2002:a17:907:70c:b0:b80:4108:f826 with SMTP id
 a640c23a62f3a-b8445179ecemr988860866b.36.1767958352180; 
 Fri, 09 Jan 2026 03:32:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb/3KES9EBGEaduNnKrBYwX6+kZQXkejuNFfpOToqJ1d/+S5nVH8toYBzkhZojxou6LA+5fg==
X-Received: by 2002:a17:907:70c:b0:b80:4108:f826 with SMTP id
 a640c23a62f3a-b8445179ecemr988858466b.36.1767958351724; 
 Fri, 09 Jan 2026 03:32:31 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4d31e7sm1118178566b.42.2026.01.09.03.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 03:32:31 -0800 (PST)
Message-ID: <27476b00-d248-40a0-8432-39dec070e290@redhat.com>
Date: Fri, 9 Jan 2026 12:32:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-8-jrossi@linux.ibm.com>
 <386824c5-d0f9-4384-a4de-d2ff5a3445d7@redhat.com>
 <2f2bb112-34d7-4a5f-aad0-c5d0630bb064@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2f2bb112-34d7-4a5f-aad0-c5d0630bb064@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 07/01/2026 19.32, Jared Rossi wrote:
> 
> 
> On 1/7/26 9:44 AM, Thomas Huth wrote:
>> On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> Enable virt-queue PCI configuration and add routines for virtio-blk-pci 
>>> devices.
>>>
>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>> ---
>>>   include/hw/s390x/ipl/qipl.h      |  10 +
>>>   pc-bios/s390-ccw/virtio-pci.h    |  79 +++++++
>>>   pc-bios/s390-ccw/virtio.h        |   1 +
>>>   pc-bios/s390-ccw/main.c          |  60 +++++-
>>>   pc-bios/s390-ccw/virtio-blkdev.c |   3 +
>>>   pc-bios/s390-ccw/virtio-pci.c    | 360 +++++++++++++++++++++++++++++++
>>>   pc-bios/s390-ccw/virtio.c        |   5 +
>>>   pc-bios/s390-ccw/Makefile        |   2 +-
>>>   8 files changed, 517 insertions(+), 3 deletions(-)
>>>   create mode 100644 pc-bios/s390-ccw/virtio-pci.h
>>>   create mode 100644 pc-bios/s390-ccw/virtio-pci.c
>>>
>>> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
>>> index 8199b839f0..5c7779a1c3 100644
>>> --- a/include/hw/s390x/ipl/qipl.h
>>> +++ b/include/hw/s390x/ipl/qipl.h
>>> @@ -22,6 +22,7 @@
>>>     #define S390_IPL_TYPE_FCP 0x00
>>>   #define S390_IPL_TYPE_CCW 0x02
>>> +#define S390_IPL_TYPE_PCI 0x04
>>>   #define S390_IPL_TYPE_PV 0x05
>>>   #define S390_IPL_TYPE_QEMU_SCSI 0xff
>>>   @@ -105,6 +106,14 @@ struct IplBlockQemuScsi {
>>>   } QEMU_PACKED;
>>>   typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>>>   +struct IplBlockPci {
>>> +    uint32_t reserved0[80];
>>> +    uint8_t  opt;
>>> +    uint8_t  reserved1[3];
>>> +    uint32_t fid;
>>> +} QEMU_PACKED;
>>> +typedef struct IplBlockPci IplBlockPci;
>>
>> Is this supposed to have the same positions for "fid" and "opt" as in the 
>> ipl_pb0_nvme structure in the kernel (arch/s390/include/uapi/asm/ipl.h)?
> 
> Yes, I think.  That was my intention anyway. Are you suggesting it shouldn't?

Having the same positions sound like a good idea. But if I'm counting right, 
it currently does not match:

In the code above, there are 80 * 4 = 320 bytes between the end of the 
loadparm[] array and the "opt" field.

In the kernel, there is the reserved2 field with 304 bytes between the end 
of the loadparm[] array and the "opt" field.

So either I'm counting wrong, or your reserved0 field should be decreased in 
size?

  Thomas


