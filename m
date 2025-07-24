Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B98C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 12:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevAj-0002pI-CV; Thu, 24 Jul 2025 08:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uevAe-0002iI-Jy
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uevAZ-0007ti-W9
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753360530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aAoKy/U+1teVsXU//njaZVP1Q0B75XHaoEQs/4JkTN0=;
 b=OFcZjdBe/4NHQupW5IUvGjpf+ynhCqzlYBtHBvqJ4I1dFSEJtpcu3nEilYpcLyuI1FxTCQ
 3rfGE3VRjXmKSGHSw6LbDUGIcVe0YlRpDYiT2mqczHQZvbCr4mgwQmiDfvQ0rzsK5raaNo
 G/Gux1kv/bVh6T+FDGn8UUWUc8xSaiA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-86_UyUfIPtWX96t_Yoge5Q-1; Thu, 24 Jul 2025 08:35:28 -0400
X-MC-Unique: 86_UyUfIPtWX96t_Yoge5Q-1
X-Mimecast-MFC-AGG-ID: 86_UyUfIPtWX96t_Yoge5Q_1753360527
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eee2398bso359537f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753360527; x=1753965327;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAoKy/U+1teVsXU//njaZVP1Q0B75XHaoEQs/4JkTN0=;
 b=AH1Vck+ia9C7tQbcw2Ekfu3SRr8hka+iB6nGwj9QGqQnriVWZctHEs3Q3EPtUvVg0A
 y4fprS5UhlXe3GcMzcaoR3oyRNdpKhjRPHpj/4vsKHAJAp5LkxvoNlsatzf0S327Gxue
 VtZY+92Q4Bc7Ltn2x1ZBIJQxv2Uq8/vM61L/9vJVEJQhX4ADSiLZHm2q4QU5sUp2/A0e
 SKL+vtrq4TJeYa4asPa2svrH6ESkRn4SGGo/PbnvtGAJpxkMsoRwPJPKwFCSCytK18h3
 XAXkv4XaMOxEg375+0oAQ28BC/O2kumQWjeR3xKjYutgBIdew4RNsSzSsaLH7RuBNqqI
 /L+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtHm5nscRnyU9uXnSl/l2jSXKW8MTMl/+cYwAf13cTZ5bCZyJuUVJSNHP5mIzLbhB7IMYEuM7UCxi7@nongnu.org
X-Gm-Message-State: AOJu0Yw9jQKOn+sKwMN41JnxGwCr6DdAYJW0PFSXdBDbxsbFl3Z9HPif
 QaozWbM12HrJfVT8c7eGx1J+0lFE9CkZDVonkv/zZW6Cdih4lAlytYJiZHfT0nnmUjdPD+cMfGE
 A7GB0jLsMhzEMd4nE1NJLi2oI5wyIx5pMPlttymgPqrLDQfJLX9betGmu
X-Gm-Gg: ASbGncsl2zJRwS9NqPC9teIlE52dpbPy48h3r1pZZmqIKX7skVP2pNcGAYPBabAhpBG
 rIcCA3uos93aVeIasvKVk2WJ7+gYhonIbPlkHbnuSCOxE+kFkRVSok8aflk/ms6Zk2br/agj24T
 55uHF6pH09nbUHjI5f3rMjRIX4N0w6E7EGl07RwVALR9T8TvD7XDMV2rKHA8zkVPraagU9wLxvF
 tQ027UTRRNqlD5PMvawLATyVwIyBiNWTT3FlhOpyED0HXnZG7st2UFmcFouDiFySbWYn9weCjp2
 YnPcLePWcfqZ9S16e+48a6zGMmVnFBFXMGwfodHGCzBLK2VoMlMwcnFf+CESuQnaFG9RwjFUetE
 +ow==
X-Received: by 2002:a05:6000:2483:b0:3a6:d95e:f38c with SMTP id
 ffacd0b85a97d-3b768ef956bmr5459444f8f.33.1753360527221; 
 Thu, 24 Jul 2025 05:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBXQr2qWTzXd4np/LtY5AU6jYiUwJvS3eT0YF/9G8GaelqeVJ5qclSw0mVd+xBzkpeOX5GJA==
X-Received: by 2002:a05:6000:2483:b0:3a6:d95e:f38c with SMTP id
 ffacd0b85a97d-3b768ef956bmr5459418f8f.33.1753360526712; 
 Thu, 24 Jul 2025 05:35:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcad036sm2106362f8f.46.2025.07.24.05.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 05:35:26 -0700 (PDT)
Message-ID: <5dc19aea-115b-4af2-8854-f4433be541fc@redhat.com>
Date: Thu, 24 Jul 2025 14:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gTUFJTlRBSU5FUlM6IFJlbW92ZSBGcsOpZMOpcmlj?=
 =?UTF-8?Q?_as_reviewer?=
To: Frederic Barrat <fbarrat@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250724075916.1593420-1-clg@redhat.com>
 <d28741e9-1e47-4a83-a37e-20e516ec7deb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <d28741e9-1e47-4a83-a37e-20e516ec7deb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/24/25 10:05, Frederic Barrat wrote:
> 
> Le 24/07/2025 à 09:59, Cédric Le Goater a écrit :
>> Frédéric has moved to other tasks within IBM and no longer does QEMU
>> development.
>>
>> Cc: Frédéric Barrat<fbarrat@linux.ibm.com>
>> Signed-off-by: Cédric Le Goater<clg@redhat.com>
>> ---
> 
> 
> Acked-by: Frédéric Barrat<fbarrat@linux.ibm.com>

Curiously, this email is taking a long time to reach lore.

C.


> 
>>   MAINTAINERS | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f3f981f90deb..9481a21c8018 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1578,7 +1578,6 @@ F: tests/functional/test_ppc64_tuxrun.py
>>   
>>   PowerNV (Non-Virtualized)
>>   M: Nicholas Piggin<npiggin@gmail.com>
>> -R: Frédéric Barrat<fbarrat@linux.ibm.com>
>>   R: Aditya Gupta<adityag@linux.ibm.com>
>>   L:qemu-ppc@nongnu.org
>>   S: Odd Fixes
>> @@ -2780,7 +2779,6 @@ F: tests/qtest/fw_cfg-test.c
>>   T: githttps://github.com/philmd/qemu.git fw_cfg-next
>>   
>>   XIVE
>> -R: Frédéric Barrat<fbarrat@linux.ibm.com>
>>   R: Gautam Menghani<gautam@linux.ibm.com>
>>   L:qemu-ppc@nongnu.org
>>   S: Odd Fixes


