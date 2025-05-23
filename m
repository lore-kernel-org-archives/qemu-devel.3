Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6864BC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 10:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIPhN-0008V0-FW; Fri, 23 May 2025 06:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIPhL-0008Tm-Tg
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:32:20 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIPhJ-000498-MP
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:32:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2322bace4ceso52321225ad.2
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747996336; x=1748601136;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PSEHWrmCxvZrWC9/38HxuQJStJPZ1c8I/b9ANXvBdQU=;
 b=w7suPzY3krRlqBV24vuDh14z8oaoDLzxTrAcFJg5iLUG4CciDf8NFDDCr+HNRcuw0i
 eEaZJC/c8fzEE1Dk38fKnh2S+PKav+N4kx4fpKyV8BbMX6OsXgsMXoVvR8Kayx+9aWm3
 k9HdP4rhR1Fi4gCg4+h5vuYNucke+RndyBTdD9/U1bbXwJ0vCi9Q/XvOXnBy6TpZLXDG
 +v2xcXmLdj9Hevtw80nMLh5JJKKk0Q2sN/trCMbeThzWuG6QDOTmkI/3ij4RBD0SOiQw
 X3Athu9p6vIX/hdYoFZJYY871ZD75hIl9P1SR+1XHx9k+WCs/qDonMF9y1b3fxCBWpaO
 9IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747996336; x=1748601136;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PSEHWrmCxvZrWC9/38HxuQJStJPZ1c8I/b9ANXvBdQU=;
 b=YDJWXxH2/U8qsI4U+uMSIrYlHgxDn9cTaxn3vGY8iXNX8NF39jH9jhwr3obFEvfQ3x
 MtH8o4U1sTxI9Ra7RjBk2VhKQr9eQQRT/F1XMEkDq3LtUK2idL93TPo1MDLpadTe+xr0
 UQ2yW3oQFmprvEpfl2sQ+Bf3lu2c2grBLUGx15lHk25LEavBmlG9Z5i8Gcr+4/GhAlGT
 2EpTA5HAjJ2GvoYbCL0Kf8J43udbqzjR2IVjYn/sxP3Of8yJVUCfiCU12Vnveqjx93mu
 X4DJMvZ+0obbqkH3N8blLihtEnfVQe8/zuQitzXvz43w8cpv+S3f0Z6JQYT3GnG+QWcO
 rXWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbl/I3+4gkA2WmRQqX3/qdhD69gMO4YWqot+scgY1AneXwDgk6PWZa3r70ODRNjBhwGGFhNClUtEc1@nongnu.org
X-Gm-Message-State: AOJu0Yx8OhWFj4xcDJiUs7RG018i/bDThhUBUM9etiLiAroCSDIIR86k
 9sJ8y7P5h+nB+2flpC3VcB01TFax1Lm3VP/Cfw/smVndO2QV12xH1bYR4CP2WNDsn58=
X-Gm-Gg: ASbGncujmCRLSxpWtNm0/xVBHHIxxOno7Y354nCajk2te1Z7qW3hTBMhzKwMmeBpjRS
 N37pwBKo1i5KFummUhb3iWnz0NzVrWrUPiWH9ItQPCJVbY+JlX/jQMLt299X6B8KedVhULlh5ak
 3oafLOsKho9quXshYh+jduFJyDcEXmcAi+a3sHAmc4mLiEkbRrbKEcfRhCaxQomKt+PS8x9FpNH
 oN80OlqDipTU0Ymcuv8aLylFJ/uxeaDhZrHAcgaurGTZtXrSa52ZtXoG1N/vEgbtHhjQ73/Tj6X
 XE4+gARtWLSyKLZpoc+YwXNMQpUeCBjAICyWfUOJPLi6vhGSyigdX2FI1VWJFw==
X-Google-Smtp-Source: AGHT+IHUAts1whuAmBAcxKdu9VmUUsda5AkP26Ugs2NogbMlTs94/R5fhVAih1FubrV11QC5cD8Pag==
X-Received: by 2002:a17:903:2301:b0:22e:364b:4f3e with SMTP id
 d9443c01a7336-231d4562cc5mr413880375ad.49.1747996335654; 
 Fri, 23 May 2025 03:32:15 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e978adsm121014415ad.119.2025.05.23.03.32.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 03:32:15 -0700 (PDT)
Message-ID: <5b6d42e8-572f-4eb2-bd1a-0d360713734f@daynix.com>
Date: Fri, 23 May 2025 19:32:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/16] net: implement tunnel probing
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <b0e5839ab3e723247b12ddecf36c75c51c5a0b83.1747825544.git.pabeni@redhat.com>
 <6c48edb8-082c-4474-8815-36ab4c64a228@daynix.com>
 <3f5b288c-af84-4bb9-996f-c77ab63bb020@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <3f5b288c-af84-4bb9-996f-c77ab63bb020@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/05/23 19:24, Paolo Abeni wrote:
> On 5/23/25 9:39 AM, Akihiko Odaki wrote:
>>> diff --git a/net/tap-linux.c b/net/tap-linux.c
>>> index 22ec2f45d2..2df601551e 100644
>>> --- a/net/tap-linux.c
>>> +++ b/net/tap-linux.c
>>> @@ -37,6 +37,14 @@
>>>    
>>>    #define PATH_NET_TUN "/dev/net/tun"
>>>    
>>> +#ifndef TUN_F_UDP_TUNNEL_GSO
>>> +#define TUN_F_UDP_TUNNEL_GSO       0x080
>>> +#endif
>>> +
>>> +#ifndef TUN_F_UDP_TUNNEL_GSO_CSUM
>>> +#define TUN_F_UDP_TUNNEL_GSO_CSUM  0x100
>>> +#endif
>>> +
>>
>> These should be added to net/tap-linux.h, which contains other UAPI
>> definitions.
>>
>> But perhaps it may be better to refactor it to add the real header file
>> using scripts/update-linux-headers.sh. Such a refactoring can be done
>> before this series gets ready to merge and will make this series a bit
>> smaller.
> 
> I may be missing something, but I don't think such refactor will make
> this series relevantly smaller?!? Also, it looks something quite
> orthogonal to me.
> 
> I propose to just move the above definition in net/tap-linux.h, if possible.

You can get rid of this 8 lines and that's all. Just moving to 
net/tap-linux.h is also fine.

Regards,
Akihiko Odaki

