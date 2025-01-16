Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6A2C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 13:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQFG-0001K0-P1; Thu, 16 Jan 2025 08:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangboyang.id@gmail.com>)
 id 1tYPDb-0002As-UL
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:43:28 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangboyang.id@gmail.com>)
 id 1tYPDZ-00043r-JO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:43:27 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2163dc5155fso14067905ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 04:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737031402; x=1737636202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aSKlDldicr0NPKw/1Fmt2npHVP+r6gGLc5+AfBdHcnE=;
 b=c1S4Oj5P/R/A/xOXVHVUtm67EbmNQwdmgj3tl+jRVFcyEkZegHNzY4LMm7g5G7xcD+
 o7QNmkVT4I7t15bF7lAU55qJ1NprAx3rtl5+ty5/swMqWlMfXkx5P5g4t3I5YR83gvHc
 Jlfz8o/HwDqLjaHiWuW35JLY2XRaPBANhyzUdFWOjvQHw4yF2keFGXfOxVC6D/r6tiy0
 xiflbvjr08jb3qX4f8ZLAtQLcWl7VNqDOml7zy2mjqn4nshEOgRP0KFhH1YlmtR3846p
 iKx8FwkzNHz73VrBIdeyGRmEtxyYU4hHgxK+xuzVLRMub9SB9ePrXF6iXwOJgTmlOnEs
 G/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737031402; x=1737636202;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aSKlDldicr0NPKw/1Fmt2npHVP+r6gGLc5+AfBdHcnE=;
 b=PzIY+dX4Vymen/XqkPiFnzEKie0YG41tJ9eBnxO9eniHC2Ho1Aw75qlKsoEoxi1cNC
 Ij4ntucpXKBay1krPeTc5tFjPXlHSm7SrjvG+Y4dghQXpFwEWAKiSvWEccrp3FPJNQES
 YLoYHJbzkVg4JR9+rmiJ5fLQ/lDticCVKqPyKGgUCK/X842EDLqnK5THiiQRl1e9qoNv
 SDpsipvXfGUGla/MTkHhVUgVA3I5ynU2/oAE/urQyJnwGzJ5wqMTd14VI5da12fOEHOa
 m/+3bPY+omCKs06bkXuDvWIpg9A7eZBo12CPwso8rAbf74oO3PwiCgnMHuQl123sQsbw
 g0UA==
X-Gm-Message-State: AOJu0YwqvKQseOzVfNyGn2K7J0/WBvia9MXGIb7qnI4a5frB1dCiWNai
 DKkjljCTIEEtWZCWUvb2FBwE8UkRHA+FocOQDMmn7lQ6kU4oeSuQ
X-Gm-Gg: ASbGnct690RZyQYbeGpRFI49CiTEg9DVagqjoueTeM42OVNLY1m20Hwk84rrTuO2Emo
 sSKafz8zMcGjFnYqWLbonk5DFL/5PdZBE8CnEtfU/WbnZTLH3OocTMWs3SpA5uo7RagFrgBIlrR
 IQRRd0lCnKDVwy9peGpaPRWLIrjkjWibFKR1O/mc/65wnM9yjk/kxJlFDlKfZyZ8NXbmKTKnJm3
 aHW4kkvv9jPQmmCFJ+q4q8eKScZ3nYWmIhoVUA8VXZ0PIZasLTQE2bWK0N01OLg/vr/B9eqiG4s
 P/XB1d1HtlEv65Fte7m8CpWMiBzcRwUA
X-Google-Smtp-Source: AGHT+IEeiHgTbFTahtFFF6LN0u97qIsEOh7aRlVh0x3h5q8fELAQPSMGlWX53aj3uYbcwhAAYZS+/Q==
X-Received: by 2002:a05:6a21:329d:b0:1e3:cf57:5f5f with SMTP id
 adf61e73a8af0-1e88d043d3amr53940278637.27.1737031401062; 
 Thu, 16 Jan 2025 04:43:21 -0800 (PST)
Received: from [0.0.0.0]
 (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a31d5da4f97sm11207710a12.55.2025.01.16.04.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 04:43:20 -0800 (PST)
Message-ID: <c4f521f8-f29b-4634-9216-e8d922a521b0@gmail.com>
Date: Thu, 16 Jan 2025 20:43:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi/ui: Fix documentation of upper bound value in
 InputMoveEvent
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250116104433.12114-1-zhangboyang.id@gmail.com>
 <87ed136ifc.fsf@pond.sub.org>
Content-Language: en-US
From: Zhang Boyang <zhangboyang.id@gmail.com>
In-Reply-To: <87ed136ifc.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=zhangboyang.id@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Jan 2025 08:49:10 -0500
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



On 2025/1/16 20:40, Markus Armbruster wrote:
> Zhang Boyang <zhangboyang.id@gmail.com> writes:
> 
>> The upper bound of pointer position in InputMoveEvent should be 0x7fff,
>> according to INPUT_EVENT_ABS_MAX.
>>
>> Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
>> ---
>>   qapi/ui.json | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qapi/ui.json b/qapi/ui.json
>> index 460a26b981..7b18662018 100644
>> --- a/qapi/ui.json
>> +++ b/qapi/ui.json
>> @@ -1133,7 +1133,7 @@
>>   # @axis: Which axis is referenced by @value.
>>   #
>>   # @value: Pointer position.  For absolute coordinates the valid range
>> -#     is 0 -> 0x7ffff
>> +#     is 0 -> 0x7fff
> 
> Opportunity to replace "->" by "to" or "..".  If you agree, I'll squash
> that into your patch in my tree.
> 

OK, Thank you :)

Zhang Boyang

>>   #
>>   # Since: 2.0
>>   ##
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 


