Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB7ACF07A5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 05:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sylzp-0005CW-Vy; Thu, 10 Oct 2024 01:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sylzm-0005BK-Fy
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 01:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sylzj-0005RV-Fx
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 01:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728539149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Lnh8njgHvzOJMnQbUUgo9D/0zEeWTxODyuvxrQJK11U=;
 b=I2ua++bMZb7D3ZJTpTOlfCdw46HLkowGPiTe9ycuyp0IXJe+8Y/Byac40KJgLkqubsrVSq
 r2SPGnhDINPrCyxe06ltr3PWIU5t0HtPp5DMvcwV9y/vIm2XL9coqSm+jZUbokKA0C5AU3
 bKdoOUrf42T0n3Hy36J+Go+8yqI2OJ0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-76uRNlzoMhCmZXYGyBuvKQ-1; Thu, 10 Oct 2024 01:45:47 -0400
X-MC-Unique: 76uRNlzoMhCmZXYGyBuvKQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a994cd8089aso43409266b.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 22:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728539146; x=1729143946;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lnh8njgHvzOJMnQbUUgo9D/0zEeWTxODyuvxrQJK11U=;
 b=s9GsqU1nHKUYSp5iNH48bJptkIs5UUacLShNKLVv0onjlyMsX1z3mn79s25Dyg87Ft
 TT99Q84AT07tdaqhAN1Uw022NlXMdm5vLn3Rl/bjaMVannpHl9JyPrDMtaBbnpuV0Xaa
 +zSR2U7T25xRhbixe5V/Z3s8UeQqpO/bX4O+wLzbhyI7YbdLINWCmgtrjQcqj3LA8B5n
 oEOb0puGfnL9HRd9fu/Lq5VEt0ATFeIdOAexUDQ73bHs5/ybUwCBokktGpmykcSE6hKJ
 yY30MBHYse3CUam/rU+TVB9Tp/fF7odI2PvKMGsulSoPhwI8Vleim0GGxWIk+slxl48h
 mcdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYgx8Hvk30vA8olOxQYjofko/YUIq/nVrXY979CjBJxctgK1xYYSW3UlyTBq8tPu13kiZ1gANu09rT@nongnu.org
X-Gm-Message-State: AOJu0YyAY6PWq9nc6PtCsFeJ5AW8eohbpVFzbgh9udL6LKuLEWZyGWiI
 BJbw+TVsXW0N0YblV/9bIw/ASy0AEBFa90eQDVDaQYEY3TS/EI/fh+0k2OtrLoEVnIbaPUpLNUC
 Mp0z3YORQlH/PLPBIc57hvEbljgv0jyFiXv8y6yoHYJj/na/CGplpUjiLqAvYkrM=
X-Received: by 2002:a17:907:96a2:b0:a99:59c6:3265 with SMTP id
 a640c23a62f3a-a998d122dd6mr413202066b.9.1728539146583; 
 Wed, 09 Oct 2024 22:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy6FpYkc5icbVLX1yxXfn5SWeqM3mtE/er46H5501Fp+o9o4SNfANhaw0stVfxKxWsr68esQ==
X-Received: by 2002:a17:907:96a2:b0:a99:59c6:3265 with SMTP id
 a640c23a62f3a-a998d122dd6mr413199966b.9.1728539146060; 
 Wed, 09 Oct 2024 22:45:46 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-26.web.vodafone.de. [109.42.51.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80ef8c1sm34644566b.195.2024.10.09.22.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 22:45:45 -0700 (PDT)
Message-ID: <cde51c74-3e40-4ca8-b315-a0340168ab2f@redhat.com>
Date: Thu, 10 Oct 2024 07:45:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/19] pc-bios/s390-ccw: Remove panics from ECKD IPL
 path
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
 <20241008011552.2645520-9-jrossi@linux.ibm.com>
 <704bffd2-09b7-4ce0-8fb4-d6f33145bcca@redhat.com>
 <a3717113-4961-4dc2-935f-96399ec904e2@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a3717113-4961-4dc2-935f-96399ec904e2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/10/2024 03.37, Jared Rossi wrote:
> 
> 
> On 10/9/24 6:53 AM, Thomas Huth wrote:
>> On 08/10/2024 03.15, jrossi@linux.ibm.com wrote:
>>> [snip...]
>>
>> load_eckd_segments() returns a value of type block_number_t which is an 
>> unsigned type, so returning a negative error value will likely not work as 
>> expected...
>>
>> ...
>>> @@ -317,21 +352,28 @@ static void run_eckd_boot_script(block_number_t 
>>> bmt_block_nr,
>>>             do {
>>>               block_nr = load_eckd_segments(block_nr, ldipl, &address);
>>> -        } while (block_nr != -1);
>>> +        } while (block_nr >= 0);
>> [snip...]
> 
> There already exists a special block number defined in bootmap.h, 
> NULL_BLOCK_NR 0xffffffffffffffffULL. Therefore I would propose simply adding 
> another as ERROR_BLOCK_NR 0xfffffffffffffffeULL.
> 
> ERROR_BLOCK_NR would replace the negative error codes and NULL_BLOCK_NR 
> would represent expected end of chunk.  Does this seem reasonable?

Sounds like a good idea.

Alternatively, you could do casting to signed long here and there, but 
that's ugly, too.

  Thomas


