Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59965E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 19:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVbvf-0007I1-Oe; Wed, 08 Jan 2025 14:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVbvd-0007Ho-Br
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 14:41:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVbvb-0003jz-9M
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 14:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736365277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=COCdi3bNqx25lBLwMhHjnrLj7lYQ+o4EMmPSgrINMBM=;
 b=HndH0KpOi/Jm/2n57ObcATWfiEJ2f1BD1G3tG1J5FTYSt8OOHmCeYaNwOKq7yMYAmqP/CP
 jy21Czy/gfXzleofriU1A2bnDvfVMYOU3/nqlmCB7lUJBlE3f7oGz0FrZXcEQag0o6zr+f
 Nr0f2QeWLzZUUknWpVBES3Y34lb17yY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-pnOpR-AyNcaNYECI0KYUPw-1; Wed, 08 Jan 2025 14:41:16 -0500
X-MC-Unique: pnOpR-AyNcaNYECI0KYUPw-1
X-Mimecast-MFC-AGG-ID: pnOpR-AyNcaNYECI0KYUPw
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d88833dffcso3412196d6.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 11:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736365275; x=1736970075;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=COCdi3bNqx25lBLwMhHjnrLj7lYQ+o4EMmPSgrINMBM=;
 b=q0av6B9jcXy9pDFYp2IusbxC9XakwhuWj0Js+ZFsLuJGQN8YF9OAn+g0szUqOMOpKN
 oceJMJ02ETewIJQY3E+BYp5CoSmW7rGOiaQ+cyVF6DtGRQ0PDcB1xOA55LKVa73CB29e
 lQuGNt7dm8KkHmupIGJAhZ0sQKRUGs/9+6aeqWON/fFpTMbOFne9wfFMFbns40bHPgc9
 4u9StkQKuTD4sp5gk7/Bw+/yY21SvFXMRt4OCQQ9mnvqTKToBTinw8udOZy51xcHyRF6
 MZAJLYnvmTSNd6kONkPNs2kAzlcm5KNPOv4y/9RHFgL9eS8pbOfgobZWQc4zwF/yBBwZ
 cvHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmhkSsB42AK6mS42pIyeFh8uUNbqbXJFd4W2S30G8VHg4mEx/uXLXnSwZMk9qU9QAf9hR5guDgcZ7j@nongnu.org
X-Gm-Message-State: AOJu0YykqJUHm7oSFSxr+XXhxKSuOrPN/Bc1sX2CXdjgBJhmIrYXJWQw
 7GUeGfLA3ZmTtLTwFvSSroUlTqVEwO+ulq2gm6ppYNkZFaEmt/B5kWcf/m4iEbELaDzQxWOQ5Jv
 eP/3mJmLQ3SUF6nGXWJYEbF+1DN2bxQWUC0dYXBNU+UMtvET+tBmcFQM1/0a2
X-Gm-Gg: ASbGnctLl6RKnKR2+i5aFsbKCZ2AIHL50fSYTYMhM4jFl87GA0C1xaNBquZ18mNhMvZ
 jY7RT0vJWRpaNALShXTqVMPutITrXYgmD+ItRTWp8vj5L6uToJhe0rsrnqvCjpRNdOEN6Ecmque
 SgMhkCzJ6ZmLABjG9dgwqbyTAP3wJr2i74SOt7hsdGP1eD05CyQ09e6icDS06oVyh+kEOSfd/MQ
 vMd5824Y2pbPUdvs+29jc5+to59k/R9rIpageL0jNn5hPLBDxUgR4YRHMHX5V62wA7qPIc0fNXQ
 5/X3g/PT+6XK
X-Received: by 2002:ad4:5dec:0:b0:6d4:1425:6d2d with SMTP id
 6a1803df08f44-6df9b2d62b2mr75917336d6.43.1736365275753; 
 Wed, 08 Jan 2025 11:41:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfssyuY5uWFmZ7Cgr/LHoKWwEMYC60orZ87e95FEuYFh9g92VZtCDYJhtE4CDZ5Zz84qVY1g==
X-Received: by 2002:ad4:5dec:0:b0:6d4:1425:6d2d with SMTP id
 6a1803df08f44-6df9b2d62b2mr75917056d6.43.1736365275441; 
 Wed, 08 Jan 2025 11:41:15 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-182.web.vodafone.de.
 [109.42.49.182]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfa4106cc7sm567136d6.122.2025.01.08.11.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 11:41:15 -0800 (PST)
Message-ID: <276d187a-d610-48f7-b450-95652d507575@redhat.com>
Date: Wed, 8 Jan 2025 20:41:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: fix bogus error benchmarking pbkdf on fast
 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Richard W.M. Jones" <rjones@redhat.com>
References: <20250108184354.997818-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250108184354.997818-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 08/01/2025 19.43, Daniel P. Berrangé wrote:
> We're seeing periodic reports of errors like:
> 
> $ qemu-img create -f luks --object secret,data=123456,id=sec0 \
>                    -o key-secret=sec0 luks-info.img 1M
>    Formatting 'luks-info.img', fmt=luks size=1048576 key-secret=sec0
>    qemu-img: luks-info.img: Unable to get accurate CPU usage
> 
> This error message comes from a recent attempt to workaround a
> kernel bug with measuring rusage in long running processes:
> 
>    commit c72cab5ad9f849bbcfcf4be7952b8b8946cc626e
>    Author: Tiago Pasqualini <tiago.pasqualini@canonical.com>
>    Date:   Wed Sep 4 20:52:30 2024 -0300
> 
>      crypto: run qcrypto_pbkdf2_count_iters in a new thread
> 
> Unfortunately this has a subtle bug on machines which are very fast.
> 
> On the first time around the loop, the 'iterations' value is quite
> small (1 << 15), and so will run quite fast. Testing has shown that
> some machines can complete this benchmarking task in as little as
> 7 milliseconds.
> 
> Unfortunately the 'getrusage' data is not updated at the time of
> the 'getrusage' call, it is done asynchronously by the schedular.
> The 7 millisecond completion time for the benchmark is short
> enough that 'getrusage' sometimes reports 0 accumulated execution
> time.
> 
> As a result the 'delay_ms == 0' sanity check in the above commit
> is triggering non-deterministically on such machines.
> 
> The benchmarking loop intended to run multiple times, increasing
> the 'iterations' value until the benchmark ran for > 500 ms, but
> the sanity check doesn't allow this to happen.
> 
> To fix it, we keep a loop counter and only run the sanity check
> after we've been around the loop more than 5 times. At that point
> the 'iterations' value is high enough that even with infrequent
> updates of 'getrusage' accounting data on fast machines, we should
> see a non-zero value.

Thanks, this seems to fix the issue for me:
Tested-by: Thomas Huth <thuth@redhat.com>


