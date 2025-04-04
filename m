Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2143EC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 11:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fS1-0005vy-Ay; Fri, 04 Apr 2025 07:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0fRy-0005v8-6Z
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0fRw-0001gx-Dw
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743766983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEG4skelI4XfkGUXBIylmZjaKJ8YH4MkdNVUF5MA/NU=;
 b=S5lprv+3jY43/qETxvMIgIuR9RPGWKfdTPP455RuYat9t4qpLHsnXV0YByD6iVTcTSb0db
 QQrS4MqwdihNHsFE/rwfWSnwmXaVdz1Y3h0CDdmP7byzonkZrtH54/SBx7pIM4mU4CvuNV
 ATNksWpBI9RopMPX/Wq/CnG2UNyiUhM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-Skth--Q-Me-YWwynuA79Lw-1; Fri, 04 Apr 2025 07:43:00 -0400
X-MC-Unique: Skth--Q-Me-YWwynuA79Lw-1
X-Mimecast-MFC-AGG-ID: Skth--Q-Me-YWwynuA79Lw_1743766979
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391492acb59so1196935f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 04:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743766979; x=1744371779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tEG4skelI4XfkGUXBIylmZjaKJ8YH4MkdNVUF5MA/NU=;
 b=OyrBqib2dBZk/9akl+X1Vzo3raaanoX0WTJoUT51stgnkzn2IzO6KzGnTHwL3d/wA8
 SzQJAmZ9qUg+59IVH/YlTDLT9J7aRP1vAVElZQvIsFyMs5/7zfPmJocLSvU6pMH63sbi
 yEHPCczH1PckbmLn8Xusm5Mv5LHz2YAFfpXukK+Jd4HNSlZCl67qcALRcy7at/GK2ZXH
 Ru1J1qcy4zeRBxcTAcq0UPw516+tGxsiEuSw806GgF27hliLr/fHtvURJQIJA1aya7zO
 d0Cbz1MTIvOnmaw1vdNAqvgAyiYOZvVSulPonbo1ZP9DNYqHlemzSq0dUuXb4weRR8No
 6rtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1nMiIkiZ6L8G6M5wokU059yXNc7I6ACgRcVLYDoyAWUmSL/Sbuory5wjSEeFiDwAaNdZLhesw1jJT@nongnu.org
X-Gm-Message-State: AOJu0YzC2aVBeaSOqF4yRqxdhaFNmDWowPjPsPKGeAFzeux9okLy59O4
 Tg/Ps5MTSV6tbXyf6Bof5GfpaKPMX6CPLBSGHSZdsIumodTKr9ZS7FFB1jXTBqS8duA3UCRDmc0
 DOcfLphCjNkHnVwYB4H52EiQIPKyHrQ+fzwOYS6tbvxn4jFSeVS0Q
X-Gm-Gg: ASbGncucN+XLtwi8CUt6LlpyidyTE10CuOs2LR328lpc4Q8hsLZXSnyCqF/X/Pskqm4
 29s+io3Irca3Y47RfiTfVcmK5Gc+ZNS4x4Aqjdd3zioyR2OD7BmOPjmO8SIjdLEbFTvyHWhLMKI
 s7LWYa10jb9gWtLu1fcw7GKZ3R2SyBS1kQiDkU45p469hH2FKIvSGaxQjpIIumRqjHvLqUbCHva
 FFri6g51byf4LYd/SP8RYrATPNYau+0xW1Nz/rWp0Tt+ecDOmIgZrxhbF6c3gDXdkDReXcFBGDI
 /gmHLITuIgBbI3vqMfny/NxL+x/RBBuRgq5nGVYBqj/oiwNfmWA4raJL4awx1YaWdy077JKY0N7
 gE6t2/mTsZ91uZqFmdZB1xkfcCqJCXFLctfKmEH/eGVXC
X-Received: by 2002:a05:6000:40db:b0:39c:1257:ccae with SMTP id
 ffacd0b85a97d-39d14765d70mr1939086f8f.57.1743766979297; 
 Fri, 04 Apr 2025 04:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIXppTqUAHqC2gQ44iKxLEfZMABw5JhXa6id6jjP1DMO3K1IBEcCDsv0HZPyLjgNB/btRQUQ==
X-Received: by 2002:a05:6000:40db:b0:39c:1257:ccae with SMTP id
 ffacd0b85a97d-39d14765d70mr1939066f8f.57.1743766978941; 
 Fri, 04 Apr 2025 04:42:58 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d66:d61a:f3cf:3494:9981?
 (p200300cfd74f9d66d61af3cf34949981.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d66:d61a:f3cf:3494:9981])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7045sm4213410f8f.39.2025.04.04.04.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 04:42:58 -0700 (PDT)
Message-ID: <de744eb3-ed52-4749-95cc-52dd2612b09a@redhat.com>
Date: Fri, 4 Apr 2025 13:42:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] fuse: Manually process requests (without libfuse)
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-10-hreitz@redhat.com>
 <pvipn7y6bo63qthkluaxinsz6cnlp4ld5frdhjcuwla2sknq25@sxvxxkhsx4zv>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <pvipn7y6bo63qthkluaxinsz6cnlp4ld5frdhjcuwla2sknq25@sxvxxkhsx4zv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Sorry, replied too early. :)

On 01.04.25 16:35, Eric Blake wrote:
> On Tue, Mar 25, 2025 at 05:06:51PM +0100, Hanna Czenczek wrote:
>> Manually read requests from the /dev/fuse FD and process them, without
>> using libfuse.  This allows us to safely add parallel request processing
>> in coroutines later, without having to worry about libfuse internals.
>> (Technically, we already have exactly that problem with
>> read_from_fuse_export()/read_from_fuse_fd() nesting.)
>>
>> We will continue to use libfuse for mounting the filesystem; fusermount3
>> is a effectively a helper program of libfuse, so it should know best how
>> to interact with it.  (Doing it manually without libfuse, while doable,
>> is a bit of a pain, and it is not clear to me how stable the "protocol"
>> actually is.)
>>
>> @@ -247,6 +268,14 @@ static int fuse_export_create(BlockExport *blk_exp,
>>   
>>       g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
>>   
>> +    exp->fuse_fd = fuse_session_fd(exp->fuse_session);
>> +    ret = fcntl(exp->fuse_fd, F_SETFL, O_NONBLOCK);
> fctnl(F_SETFL) should be used in a read-modify-write pattern with
> F_GETFL (otherwise, you are nuking any other flags that might have
> been important).
>
> See also block/file-posix.c:fcntl_setfl.  Maybe we should hoist that
> into a common helper in util/osdep.c?

Sounds good.

>>   /**
>> - * Handle client reads from the exported image.
>> + * Handle client reads from the exported image.  Allocates *bufptr and reads
>> + * data from the block device into that buffer.
> Worth calling out tht *bufptr must be freed with qemu_vfree...

Yep, I’ll add it.

Hanna


