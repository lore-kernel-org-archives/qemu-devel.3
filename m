Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A96AC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 12:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBLN-0002yC-SI; Wed, 14 May 2025 08:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uFBLL-0002xe-8d
 for qemu-devel@nongnu.org; Wed, 14 May 2025 08:36:15 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uFBLD-00057o-U4
 for qemu-devel@nongnu.org; Wed, 14 May 2025 08:36:13 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b245ff89c99so4176492a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 05:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747226165; x=1747830965;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JG5in9bxyTdlAG1AwS0O/kgzNFoscLIf4DmNK1YSRAs=;
 b=Pc/9DHq5lWr5P8Rn+IIKrK0rA6ya1vZyLk5z6glvIWpRrOH83CLcD4YDFi2THNKeco
 my3aWj6EJQsveEBCsZdfgsg+ABx2aRe2J7hRGRila3A04jp5QSsxwUIqB2dYMij8Yg4b
 QEC3zBomoQQNi9i+lpPB6EeAxtF7SGQQ3Rg6TJSb8zas3ts0BPaTfjXdsGw7kz0hofOa
 CDXKmOwcnw+Fa3waUImhSxn72/jZk9KRV9rwgJuFVn2PTA9IwCPr9Z2cMN1/OfRLftDa
 DIu6x2/ARg+nevC7MZHEph/6pAm/brTCrG0X/oGeGdhhgtnIeTX6qFIKCLJU6N1UlY8G
 NYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747226165; x=1747830965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JG5in9bxyTdlAG1AwS0O/kgzNFoscLIf4DmNK1YSRAs=;
 b=N419xZ8VP13ABPj0QQ1H2x9hLcRdeue0ZelIrVRZOVuqvBf2S1RzSkRRW6jNXlqNYS
 FvXvgv9lLe0A0Oe5M9FRIxt19nEcx+uefzPtXH87vq3nqtwBYtSrhQty7ol6zCCjAtDb
 6zXNw+gbBkZTIi3m0MG+9Cmq2OZfWbMFfb4Vo/EHQX/0Jjtu7ujT4jRJtc1TsVntnlSA
 ZB8ykzm+XajF5BnsR9Bp9dkf0oM9Ob/jTSx70FGvWJAYV71CAoTJeb+R7XNuKnLXoxrQ
 MNbLPOakHKtVXDmTfHdcPejaocOTU7x+9YH8N7s9bjaPrXhixC5fkOFbTEaFBuRKR+K7
 YjIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFMndMGBoj26k6Oc7NH8EXB0+qK3+Ng5ejBfE9EGQZPJzW87l5tuI+FNaTkJ990QvganD7Jd1B1XNY@nongnu.org
X-Gm-Message-State: AOJu0YzVOAB5ryBdby6WhkpjhyuRe3xG6eKepgnEls27MdX9eUQBM48Y
 9M+GWAm1tHB2sdKaLMHSzRZsX4m6tD4RR2mQkqHhw0mf2v1dB7NGPvkYSgyzLjU=
X-Gm-Gg: ASbGncv/I9/SNDr567tKCDYtvCKPM4/npDZ6vuHmRZFVr6PrH91ODjQ6mN7C/vU4pqt
 eHP+v0i0tLwZGzPpqFeU7bwrNNvkgz5kh2aktUIQ3jX5rYtUw1mI7PhkejhHehyUmLLyeeqqb/h
 An1cWP2y2nIqtlAkaXAnqHPzEQz3anPoZ90BTznqnkOdEaZwMv4UFABUKo1GiBaS0upv3ylf7cI
 cqUmEDTIVbG2ELqFz9/7Was/nSYgW1WML/VJK7vsQsvokcpNMegDiqlhtqSnkgG6T5/SHWrEyxP
 WOhjvSX7jFGUlMEd/DkrH6yXzZKikYfy5zL4/3wmQDLIoSoDevF/GNNyOhgAA+/cX75IpU16ghU
 =
X-Google-Smtp-Source: AGHT+IFCGEYfwdlKwi8RNHSjFGKZRUX3zAGHpml4D0AXypRyOEUqCE5nxX1YLYaMmbZ0Q0Cq5TVmUg==
X-Received: by 2002:a17:90b:2e52:b0:2ff:62f8:9a12 with SMTP id
 98e67ed59e1d1-30e2e62aa0amr4488535a91.23.1747226165012; 
 Wed, 14 May 2025 05:36:05 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2351b7a87dsm7666622a12.70.2025.05.14.05.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 05:36:04 -0700 (PDT)
Message-ID: <85544638-b50a-4776-a6f7-134a256113ef@daynix.com>
Date: Wed, 14 May 2025 21:36:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] migration: Replace QemuSemaphore with QemuEvent
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-7-f7f69247d303@daynix.com> <aCOZ3SMr56NufUF0@x1.local>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <aCOZ3SMr56NufUF0@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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



On 2025/05/14 4:13, Peter Xu wrote:
> On Sun, May 11, 2025 at 03:08:24PM +0900, Akihiko Odaki wrote:
>> rp_pong_acks tells if it has ever received one pong. QemuEvent is
>> better suited for this usage because it represents a boolean rather
>> than integer and will not decrement with the wait operation.
>>
>> pause_event can utilize qemu_event_reset() to discard events.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   migration/migration.h |  6 +++---
>>   migration/migration.c | 29 +++++++++++++----------------
>>   2 files changed, 16 insertions(+), 19 deletions(-)
>>
>> diff --git a/migration/migration.h b/migration/migration.h
>> index d53f7cad84d8..11dba5f4da77 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -342,11 +342,11 @@ struct MigrationState {
>>            */
>>           QemuSemaphore rp_sem;
>>           /*
>> -         * We post to this when we got one PONG from dest. So far it's an
>> +         * We set this when we got one PONG from dest. So far it's an
>>            * easy way to know the main channel has successfully established
>>            * on dest QEMU.
>>            */
>> -        QemuSemaphore rp_pong_acks;
>> +        QemuEvent rp_pong_acks;
> 
> If to do the switch then it needs a rename too because "acks" imply a
> non-boolean.
> 
> For this one, when introduced it was indeed kept in mind that it might at
> some point be useful to count for more than one.
> 
> For the other one, it is definitely an improvement to use QemuEvent
> especially on the tricky reset..
> 
> How about keeping rp_pong_acks as-is, and keep the patch for replacing
> pause_sem?
I'll keep rp_pong_acks as is as you suggest with the next version. My 
objective in this series to replace QemuSemaphores with QemuEvents if 
QemuEvents are obviously more suited; this one is not that obvious.

Regards,
Akihiko Odaki

