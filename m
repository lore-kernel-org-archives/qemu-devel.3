Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBD0C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 09:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdQrm-0006PI-EH; Thu, 30 Jan 2025 04:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tdQrl-0006Oj-QS
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 04:29:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tdQri-00012a-Mi
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 04:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738229377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FTZ0NNL4KbUZBcmZeeafUqWWmSADVE4sxskeASIgPyc=;
 b=DLMQV8/tY2EFdkXK53h1c8LXiMPD/4O4TfB1Lp1nH334U83S09x1oyDcM8HQqLTkevCHji
 gQZ9dFMHs7YiGl1C5RgE/Hoe5Gh1G92slasOB80KFRNzLKscoWJH8k3ae8mUhwFrfqVgOP
 yDYwmXJmmspaH315CF118SyywxQxi6M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-dzzzwQF5Md-kuVFVFGuc3A-1; Thu, 30 Jan 2025 04:29:35 -0500
X-MC-Unique: dzzzwQF5Md-kuVFVFGuc3A-1
X-Mimecast-MFC-AGG-ID: dzzzwQF5Md-kuVFVFGuc3A
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38c4a819c0aso334036f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 01:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738229373; x=1738834173;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTZ0NNL4KbUZBcmZeeafUqWWmSADVE4sxskeASIgPyc=;
 b=tFIzp3R0PmNOe90+0x/6TmBviJmEw7uloBxyj/69x+5uPnoOQ3++6J9Z5VRLYrDRAm
 86Mat1QRNkXV7NkXzcX5LKc87/c/Ag3nKm3NKgRv//vz9/3VpCi5u0wRK8yJu0pphiK5
 nI8FssnGdwJhYxu0w1RPnkOsItQUjV1XQba9TvfIhEXH9czVrcbaQXT1dc8gDUQVqgZM
 W9NWcXnnR3IdMjJ9KeRFSnzA9Z7DRhdMHWATfJrnUgzrW9jZ+A0CXrfzhxT1NmPj6Ef+
 hUYp/dH2bKwCEtsNo/MP/qtswqmbM9S30stWtgNJiZEq0kT2CDSaaf6EipR2eMnul6JM
 qHCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9xDLRwFqOXLNraC+xs7yHynMrBDVTkLzR/Yylcy4rGDrKdNROSGsY//Ujm3DY+g3aAkITleAW/0Xg@nongnu.org
X-Gm-Message-State: AOJu0YyYuxdfwq/zwYGCVelqAT3D/DsjiOlQ1Nx80xp+2752dg5+VqsB
 GuU3nTkwjsFF31nUTTTbtu6g/3StQCGSqyPT0yIm11tPM7Otw8fD4Sn66BQ1dQA7cAuWimdfVPC
 Tp031ePTBSK2dNhboQNLKLEkFIGxWQnQ4kI2FPZfkdkBGO2s/SI7EMMb/FSXj
X-Gm-Gg: ASbGnctb8h1VjnZa0WrJy7DDZIy1CnkAU80NEFh406I4ESF1/5MG7x42mafXvEP1AnL
 avJvgfeapa3GUdocU5uEISsA8zqJWKcP0Z2sOa8sFG9bZ5b2jytiwvw3uNxd8bu9XziR00d297D
 8NzolNcDuMPIRsaFLtiH3MizRzyaHcnX9eNvsxq5m2bBKTmU4Y4A7rTDg4g1zxHnfYnNRTngDUj
 HbOoRsdt/3y6f9LChoulHh93YL2HKLMLRtAeQlt3fSXNKRXAtUKf8b0Jm5V/KZtyTGcwz+WK0gR
 K/nyoSanBPuTN1P9HHwURAfFeSsLHgJDCbOcQ7ZfC+Y=
X-Received: by 2002:a5d:6487:0:b0:38b:669d:4dd4 with SMTP id
 ffacd0b85a97d-38c5192f1f4mr5166960f8f.11.1738229373694; 
 Thu, 30 Jan 2025 01:29:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMxR9PgftdD47rhI9MraZxXAXEV5YIUWLzbB7qIk8tJaroQrHgLBaN1W8Mx+eWinyN2ca7vw==
X-Received: by 2002:a5d:6487:0:b0:38b:669d:4dd4 with SMTP id
 ffacd0b85a97d-38c5192f1f4mr5166937f8f.11.1738229373349; 
 Thu, 30 Jan 2025 01:29:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ec35asm1441462f8f.15.2025.01.30.01.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 01:29:32 -0800 (PST)
Message-ID: <06f5b8c8-1d06-43aa-80ae-d7ef384d34a6@redhat.com>
Date: Thu, 30 Jan 2025 10:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] net: Fix announce_self with vhost
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, 
 qemu-stable <qemu-stable@nongnu.org>
References: <20250117111709.970789-1-lvivier@redhat.com>
 <f508fd5f-23c6-4f0c-8fdc-bfedd5a9e9e0@tls.msk.ru>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <f508fd5f-23c6-4f0c-8fdc-bfedd5a9e9e0@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 18/01/2025 21:20, Michael Tokarev wrote:
> 17.01.2025 14:17, Laurent Vivier wrote:
>> announce_self that sends a RARP packet after migration
>> or with announce_self QMP/HMP command doesn't work with
>> vhost because of the vnet headers.
>>
>> announce_self is the only user of QEMU_NET_PACKET_FLAG_RAW and
>> this flag is not correctly managed.
>>
>> This series fix a problem with this flag in filter-dump and in
>> qemu_deliver_packet_iov().
>>
>> Laurent Vivier (2):
>>    net: Fix announce_self
>>    net/dump: Correctly compute Ethernet packet offset
>>
>>   net/dump.c | 3 ++-
>>   net/net.c  | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> Applied to trivial-patches and queued for qemu-stable.
> 

When do you plan to send the PR for them?

Thanks,
Laurent


