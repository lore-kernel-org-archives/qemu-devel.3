Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F77C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hTW-00086K-6T; Wed, 08 May 2024 09:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincentfu@gmail.com>)
 id 1s4hTR-00080e-A0; Wed, 08 May 2024 09:36:45 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vincentfu@gmail.com>)
 id 1s4hTP-0000HQ-56; Wed, 08 May 2024 09:36:45 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-792639cf4faso433058985a.1; 
 Wed, 08 May 2024 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715175401; x=1715780201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8LihZIzc+9B8G/EQx10yAwJSq3R6M50siTabof4/4MM=;
 b=H22gsfBtRbOSlqhMV9onDRR18hG7EoKQWCaaOjEUThbEKbj3uqoJl07U4BQY0oyH83
 5LHYUt5F26UHQE4hbeHoTpOycfD6psSGtsoDAyyoQMaEUgrC/WORr89IIiyIxi60Kjs0
 0IE50Q1uC7ACjcVPab4TqBwr+NH42MhTPwCu0mGCe5aKQFECTqVaRoPcI+S7dj02kaVR
 RsMIWlFq/QBhP7RmwS9QK9EY1kX0D/B2Yy7Wt+oOpNEEYfpsDuODegs2+2JK66fw/lS0
 eoMsnuOerkuadDpZUMxiuMRjsPyzh61NsRCAlIKQJHCtPa99R+spFeFqdRHkdA0O8A4e
 JpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715175401; x=1715780201;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8LihZIzc+9B8G/EQx10yAwJSq3R6M50siTabof4/4MM=;
 b=u8av3PU53WhGnYNRPzKt2ZycK6vSIJkF3ilH1/L9iOxQ8gfLD5g/8GUrSVagsT/5zX
 h6skd5Tx5Uo9Ru9MZ/YHnIvwTkCS6NnZrSL+tFlDGTThBO3QWDYIs9ACE9IBwcZAjrMq
 3zLEvJCx3fAaaqQQF3KrGz/Bq5XWFdchEOZX0xAtWkh0EMYq9XFyVn/sG6Vkd5wOP0QS
 /3f+8azMjYMFXH5Ls5Lkbp7EEeZ1Ex3UKOWhZABlKfYRypfqMQLdsSTHMihaVdnMqJ1H
 BevKj/aZf9vGHaEWiV4zv/7RF9Raeuh9j2lROFod4gMov0UXJ6jiZXqcxk5FhCKkH+ey
 3wrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqZ2EQMG1O8wmjygV8dVPBwdz0A6Y2w9UI26EJ5XBH1BGxZGfMh8aFi+7daYfhKJ3tEXe3sLkBzXXBWXLjwOJijM5S+H4=
X-Gm-Message-State: AOJu0Yz0kWX41md37iMdn0b9nuCV8fia3KAPIByYrm7vK99PIUShWEUS
 GEnp2+0Rrjbw7gCJ9zcxiLRKfiYDmNduaJ9tcSp7k7DEdbIS45tl
X-Google-Smtp-Source: AGHT+IHT7CEVIjza+R0ute6Ng1oE8XCKUNQD6UFCXJnmQ8hWa43bOYH+JlMgjdmZbehWrGoXhsXz6g==
X-Received: by 2002:a05:622a:43:b0:43a:ee6a:b1dc with SMTP id
 d75a77b69052e-43dbed1762emr26098751cf.21.1715175401131; 
 Wed, 08 May 2024 06:36:41 -0700 (PDT)
Received: from [192.168.1.206] (pool-173-79-40-147.washdc.fios.verizon.net.
 [173.79.40.147]) by smtp.gmail.com with ESMTPSA id
 ci22-20020a05622a261600b0043476c7f668sm7673915qtb.5.2024.05.08.06.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 06:36:40 -0700 (PDT)
Message-ID: <50c45bde-738e-4c1d-bf1f-5345eff814b2@gmail.com>
Date: Wed, 8 May 2024 09:36:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: fix mo field in io mgnt send
From: Vincent Fu <vincentfu@gmail.com>
To: Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20240506-fix-ioms-mo-v1-1-65c315531850@samsung.com>
 <888fce70-768e-474f-8526-fa05b41540c1@gmail.com>
Content-Language: en-US
In-Reply-To: <888fce70-768e-474f-8526-fa05b41540c1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=vincentfu@gmail.com; helo=mail-qk1-x72f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/7/24 10:05, Vincent Fu wrote:
> On 5/6/24 04:06, Klaus Jensen wrote:
>> The Management Operation field of I/O Management Send is only 8 bits,
>> not 16.
>>
>> Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>> ---
>>   hw/nvme/ctrl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>> index 9e7bbebc8bb0..ede5f281dd7c 100644
>> --- a/hw/nvme/ctrl.c
>> +++ b/hw/nvme/ctrl.c
>> @@ -4387,7 +4387,7 @@ static uint16_t nvme_io_mgmt_send(NvmeCtrl *n, 
>> NvmeRequest *req)
>>   {
>>       NvmeCmd *cmd = &req->cmd;
>>       uint32_t cdw10 = le32_to_cpu(cmd->cdw10);
>> -    uint8_t mo = (cdw10 & 0xff);
>> +    uint8_t mo = cdw10 & 0xf;
>>       switch (mo) {
>>       case NVME_IOMS_MO_NOP:
>>
>> ---
>> base-commit: 84b0eb1826f690aa8d51984644318ee6c810f5bf
>> change-id: 20240506-fix-ioms-mo-97098c6c5396
>>
>> Best regards,
> 
> Reviewed-by: Vincent Fu <vincent.fu@samsung.com>

Klaus, upon taking a second look, the original code is correct. The 
proposed change would only keep the least significant 4 bits of the MO 
field. The original code gives you the 8 bits needed.

Let me withdraw my Reviewed-by.

Vincent

