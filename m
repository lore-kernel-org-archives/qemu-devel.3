Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A012C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 16:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubM8U-0002wg-8x; Mon, 14 Jul 2025 12:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubLCR-00036L-T3
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubLCP-0004VO-Q8
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752507274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qMUktZ3W6Hd9R0RM2Dxyy7jk9fiFT3p5cT6jYvg5Vcs=;
 b=GmLHtYkhyMI17C1hbo7eRCEWto6C45RuhLSk5LzdX4JZtUnpGiZehVzEtUHWxGunOZMSpV
 c1efl2lK9S4MLkm+ck1D4lTePXkUNviXijy3pw6p/rmqT8AEjeOJRR1zb+xDQrcXQTfr1M
 Y1UhoRIcqmQJFyyLI3PkJJsZhFIBJlU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-A-7PF9lQPiK-JonZU5oayA-1; Mon, 14 Jul 2025 11:34:33 -0400
X-MC-Unique: A-7PF9lQPiK-JonZU5oayA-1
X-Mimecast-MFC-AGG-ID: A-7PF9lQPiK-JonZU5oayA_1752507272
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f7ebfd00so1743224f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752507272; x=1753112072;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMUktZ3W6Hd9R0RM2Dxyy7jk9fiFT3p5cT6jYvg5Vcs=;
 b=Heay+XGj172aoDjt1kxl6c5IqOnxuoyPta9yzGBinMbPEBsYjHPCBMFOir4CpQyST8
 dypdsQQKUM3cOmgrvhttJciBTl/YkLbtjtzRLTuG4I6C1KQdVlSFMov+AAjOpcgJmhs5
 I42dsjosFu+SykXhNQU4zDQ8n2e0OToMoSLJ4wnI/CLvL5ELJY+erRO/r1qvmWNG2V2P
 22P3GfQt8DfrqVK/kzp+M6jSnEmpZM0e7NRN8ePKa5hyK/UF4HQy9HKVxHfqucJmn+yy
 JNZZ3HRddVXqpk4Ymym9zIeDtI5lzNZRmcNp+ZMbqAFY9Fk7WcXSq6CDrS2BBKDT3KNU
 /Ocg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIQSSbZ9LoJhOg8zvKh1gvigVq9+Qurzk4+vSIGz72PYBEF6CwHWxNbY/0rjGb/9QxO/MaRLC57e1t@nongnu.org
X-Gm-Message-State: AOJu0YzI88m9Cv4mU8ikG7aJARKnwjwDQ8vktioLJnmC6gDeasEctLr6
 j1qRaGN5/eBy7xdwZclcA2nIufwS+FjrKgABbxu/EEzVTXJGH1EO99OyFGla6HyYWyJysB6YE+G
 NohaGM1zKB7HPIcxeDOHmdd9aHWkifUUEceDXsEq0gAN9xMWYA1hBmGzC
X-Gm-Gg: ASbGncvZx73KpaqYro/qq1vU9CnSXJnN3XZjxfokGCQEieqqOSOwQH4kfdnzkPr50id
 FCBxyExlSxU+Aah8VALyihh0wkCKpAHOjTBlDJwq6uH/UVva8I1J9Q+Lw1PO/JDw7+I67wPLdNO
 FhPPK3AgIRAAy0OpocuEonUyNvWt3PkFvYr6dZfarD2yknDk6zI19BHn80GAsvB7eH2C3xQzL8W
 CNZHoXkqzV+GZf/+oAsO4YCj452VkECAH/YNNkGqnzLYcVrZZtl2tEU4oSjVJcVIxJrNg8uxZDM
 tcrdBMayAvwW7prFA3+3PnsfupjiQ4UrC43DXcMEX+WYxdVFx2Y3SEfGHHBm1DKkRDy3LxOZcoO
 TH/bn
X-Received: by 2002:a5d:5f55:0:b0:3a4:dcfb:3118 with SMTP id
 ffacd0b85a97d-3b5f187599dmr11139975f8f.10.1752507272203; 
 Mon, 14 Jul 2025 08:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRPPEQ/O+nx8slrLBlbNmLGWnscMamlItdS9EG5HUKNtZb2/UyPTTv5o1gQtS9yv9Rx1dfpg==
X-Received: by 2002:a5d:5f55:0:b0:3a4:dcfb:3118 with SMTP id
 ffacd0b85a97d-3b5f187599dmr11139953f8f.10.1752507271739; 
 Mon, 14 Jul 2025 08:34:31 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-106.pools.arcor-ip.net.
 [47.64.114.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45617dc1fccsm45392655e9.5.2025.07.14.08.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 08:34:31 -0700 (PDT)
Message-ID: <2c1bd3f0-731c-4ca7-9f43-50c3c572aaa6@redhat.com>
Date: Mon, 14 Jul 2025 17:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/28] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Jared Rossi <jrossi@linux.ibm.com>, Collin Walling
 <walling@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 berrange@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-21-zycai@linux.ibm.com>
 <eccbac31-7c1d-4b75-a284-a46ad98675db@linux.ibm.com>
 <80ebd632-5b56-4391-b60d-f6a64f311e7f@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <80ebd632-5b56-4391-b60d-f6a64f311e7f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 14/07/2025 16.54, Jared Rossi wrote:
> 
> [snip...]
>>> +
>>> +        entry++;
>>> +
>>> +        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
>>> +            puts("Wrong entry value");
>>> +            return -EINVAL;
>>> +        }
>> Can someone who is more informed than I am of the IPL process please
>> explain to me what is the purpose of the above check?  Why does it check
>> if the next entry, the one which isn't going to be inspected/loaded, is
>> within the bounds of tmp_sec?  This has been here since this file's
>> inception and I can't find any documentation or mention that supports it.
>>
>> This code precludes any of the secure IPL changes.
>>
>> Was this actually meant to be entry[0] to ensure the actual entry we
>> want to work on is not outside the bounds of tmp_sec?  Or perhaps it was
>> meant to be done before the increment to entry?
>>
> 
> I noticed that as well and came to the same conclusions as you, which is to 
> say,
> it has always been that way and it is not clear what the purpose is, but it 
> does
> not appear to have any impact on the proposed secure IPL functionality.

I think it's meant as a check for the *end* of entry[0], so it's likely just 
a quirky way of saying:

    if (((uint8_t *)entry) + sizeof(*entry) > tmp_sec + MAX_SECTOR_SIZE)

?

  Thomas


