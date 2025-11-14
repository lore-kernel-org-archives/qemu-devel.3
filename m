Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B999CDE00A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 06:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJn1x-00017x-DV; Fri, 14 Nov 2025 01:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJn1u-00016Q-Fo
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 01:11:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJn1s-0004m3-4S
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 01:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763100686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6YsJYSI801dpV8bDwEIMDwEUT1fDGxyQIigvHMmZW1s=;
 b=f+sWZge1toOj8CQ2UgyK9OuuZCCHkRRJY54SP4fEERKqDv/dRrlrl727TAYsWqpeOc64UV
 Cj9mYLZ0HLW+eaIg2+AmzFJIkA1/GI0EZi2QbsjHAY+YfvBIQx6TBxL7jatjW+Zf3G6gp5
 HM4OtAW9TWMXm2Ufx7LtIw6GCL51CSI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-bpm-GvxAPxWp2inxp2mUHA-1; Fri, 14 Nov 2025 01:11:24 -0500
X-MC-Unique: bpm-GvxAPxWp2inxp2mUHA-1
X-Mimecast-MFC-AGG-ID: bpm-GvxAPxWp2inxp2mUHA_1763100683
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4710d174c31so15912245e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 22:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763100683; x=1763705483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6YsJYSI801dpV8bDwEIMDwEUT1fDGxyQIigvHMmZW1s=;
 b=gUbSoB/2apbdTFvZEDtQYkiQA9mC6+YkX9r1flK8GqwteRPLGLXU9LRFV8EeEKxyVi
 /ELEbrLfdO9DX27ERKQoAJnNhsJKx67aRh4uWY0NCbpsVr5a+SeyEVbWQxGav202gOUk
 qxg4J4e4zfqLoLoJHAuv6E95gZfD3oeQbrQ8uZdrec9NWT4RFE0GvsPdoqd7rv7Pl6TP
 nTDC/mjHzweTLrf0zYi9cOAfd3GVtYcIMU9QH3c/gP97Z+6s5l1ht9nYXEama//LHLKM
 m2NYxmJ/vs68P6cGDo8tmcSLTLPb614HHPsWga6RV0OprlSW6+qO7plWupCFwRL37w+j
 MjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763100683; x=1763705483;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YsJYSI801dpV8bDwEIMDwEUT1fDGxyQIigvHMmZW1s=;
 b=dS60390Hd8ppONWWk161UMkU3d+cDPtgb4TDdQneIDDmwH9LkRHeddVTIvZUNHhkTn
 34zH5VXK1fjVE+f+SyfAn98Cu4MCrnm+AzRFs90jp+q9we4Tz7zffQQj6iuuG0eqqRPi
 4MDSHcGkeZIFmkNEFOYURk2DaczAlbGt95ya2mhoCY0qmjOUbd4OTTH9zJHs2ZD3mypk
 4F8S4gfyRUdMQCNPDArjpm34Oia7JbzPdUDWuZkB7J5QZaq4D5V0zK2eCMP5KTOvalgz
 njmL++Wa27U+2DyvFsGD896E0mr/0LavrZ+B4dnUyYz33Q4tFWL9ZxY850FKmdafD0Bc
 Vbpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2HAb4FDVU8v79fwaYpm7+VNDL66z4/hiyQM+GaUNyElEU7krsJoQ2IyM6kJCIhgp5gOuQGWA71Omg@nongnu.org
X-Gm-Message-State: AOJu0YwtwqWRRx2Yb4YW5mf2wS4t4JF0KxgyOtMe8URLb0POnbDzc3BS
 gTmuhCxvD3qNXw+6nzm9OJXvoyXs23/Im9nSpho7O5vWuDumX1P96/CyBjz1GKq0Nb6vCevbVbo
 Z/As+tifKFkYlAhIvF9YJQWotk1XTUFx6aKvbzcfFM+IxeOhbILPNiYF3
X-Gm-Gg: ASbGncuSqsKzD7lB7AVXhgR2x6+sh1RV4IS/E+YCv5ELctM8ebbkLN4ZpfVR7jRonrt
 9CYyrPf5i0BUrAxPb/PMuyCIopu5H48Dnmk73dhebLYkOKDakuu226Z9lONllHyg1iyyfYbfOUI
 uYT6915omiAYJ/poe4EXyL66pEdrTKABgiUKmLJEh3fyavGpE7bgxL8fwlClKqmCt7xc3y7Z1vE
 2dgyPQ02KKvWaAzOUx49L5m5hFHcUuJc2luuGDwnv0xkD8VrwIkUtsX7uRE4jSed5xXVMv3ZFBM
 A9D+sOdw2WLeIfEgrAq78jT5Gm/W1i6PmpBwxpTCMFslmOuwRq032Jy1I+gyzB+LDFKPmFE=
X-Received: by 2002:a05:600c:3b19:b0:471:989:9d7b with SMTP id
 5b1f17b1804b1-4778fe95fe2mr17030115e9.21.1763100683471; 
 Thu, 13 Nov 2025 22:11:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJzaEiYmJ9iVo6V9w4aVzVjTovC5oFykKyk1gT2ZYxfvVrcgFn/ufRDYtP+QjizYXr4/63Mg==
X-Received: by 2002:a05:600c:3b19:b0:471:989:9d7b with SMTP id
 5b1f17b1804b1-4778fe95fe2mr17029925e9.21.1763100683052; 
 Thu, 13 Nov 2025 22:11:23 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778c850000sm70759715e9.4.2025.11.13.22.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Nov 2025 22:11:22 -0800 (PST)
Message-ID: <ec0110b7-5d63-481a-8d8f-3eefbe366129@redhat.com>
Date: Fri, 14 Nov 2025 07:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression with the "replay" test on target alpha
To: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-4-pbonzini@redhat.com>
 <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
 <ebb0ac51-fbf0-4f93-8a9b-12880d2a0126@rsg.ci.i.u-tokyo.ac.jp>
 <30a9e854-e37b-4494-b372-f76ce6bdce25@redhat.com>
 <d9db8f08-f207-45b4-9637-9f13a04ab606@rsg.ci.i.u-tokyo.ac.jp>
 <81072e45-182f-419a-a44e-fca22ed54167@redhat.com>
 <d4921688-b3b3-45f2-a3c9-dee2977750cd@redhat.com>
 <889e6be6-0cef-4a23-9d57-2e0611f9588a@rsg.ci.i.u-tokyo.ac.jp>
 <185927c2-9386-4935-8bfb-64eeb87f06a7@redhat.com>
 <84bd1674-4a38-4864-9297-fef628b51cb8@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <84bd1674-4a38-4864-9297-fef628b51cb8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 07/11/2025 08.49, Paolo Bonzini wrote:
> On 11/7/25 08:41, Thomas Huth wrote:
>> On 05/11/2025 07.29, Akihiko Odaki wrote:
>>> On 2025/11/04 21:18, Paolo Bonzini wrote:
>>>> In this backtrace the CPU is waking up the main loop (thread 1), but the 
>>>> main loop is running so I don't think it's really a deadlock. It's more 
>>>> likely that the replay is not matching the record, or there's a similar 
>>>> reason why the replay is not proceeding.
>>>
>>> I agree. It is more likely that debugging the replay code instead of the 
>>> RCU change will lead to the real cause.
>>
>> This now also impacts the Gitlab-CI :
>>
>>   https://gitlab.com/qemu-project/qemu/-/jobs/11984309870
>>
>> How do we tackle this? It feels bad that we have such a subtle problem at 
>> the beginning of the freeze period. Shall we revert the RCU patch 'til the 
>> problem is understood?
> 
> I'll look at it today; if I can't make heads or tails of it we'll revert it, 
> yes.

Sorry if I missed it, but did you find out anything? ... the test is still 
failing for me, which is somewhat annoying ...

  Thomas


