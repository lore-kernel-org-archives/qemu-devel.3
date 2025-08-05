Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E39AC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 20:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujNwy-0004TL-Ki; Tue, 05 Aug 2025 16:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujNws-0004N7-5Y
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujNwp-0004LD-EI
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754424466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZL6SbOmwpntP0R7EfdXbGTdLD5X/fiNx26agbIaoVVE=;
 b=fyk4z4iCwAhxlJT/gx3XG0r8EK9Ka+GFgjWZAS466vI0EHSTg535CyHTMZ6479coB0U6gR
 If5R33KnYgSAjJaFu3dSJ3S11BWjVvJHcistO0qStFvhLOIE/oBgqQPJt9Im5FCYXGu7qY
 erTbJwKcV5bNzn8Vw/Qc5T8BC1Mf0YY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-CT_8LYJnNECKUBQ8NKgYBg-1; Tue, 05 Aug 2025 16:07:43 -0400
X-MC-Unique: CT_8LYJnNECKUBQ8NKgYBg-1
X-Mimecast-MFC-AGG-ID: CT_8LYJnNECKUBQ8NKgYBg_1754424462
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-459dfbece11so9369335e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 13:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754424462; x=1755029262;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZL6SbOmwpntP0R7EfdXbGTdLD5X/fiNx26agbIaoVVE=;
 b=hPj0InVEpPPcCpKr9+sUYlemDJTbscm6dga7jJgVaqRbQUuH5NFYjTfFrCsWUgm7Wy
 ZYZkFP8s/jg+Na2nLRJYC7KGX6AqyKbD6wps8tYJzTsEA4yeQU6fpGRqiK2bu7I8VG/X
 UzG9K5OpToBC76nBpBHj/3VRkWtneB0Xj01RvF2v3K+WLNm+2xUMCGlgADCQGfJDKkTF
 cF4MWZ1nACS1bHCdS1N6DOC69sHOGgb/qeS7zTG/9ziGx6bQqo8bNXqkn/sZDjtyC3LC
 oUewIWDWBTuLzo2QK2MDI1cZUSbM5bUZ1gNA3dnj4f4I7oMAxYm06so9P6owa6kK/eE9
 +muw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHbMx+Y0ZABr6DVYfkNjJBkNxuOZw1mV14G41HJBm+szIdeiXzhTzSbH/voTif99BcDeTiHYdPQHAp@nongnu.org
X-Gm-Message-State: AOJu0YywY4mh5NCqNGWurfW6FYq5byLb89BJ81981PAp1JjqIQPQJ93r
 Jibl9VV0nAQt9q7zT6JjiD4CriJLrrIjrbmHLdeGcl0+sl05NXDQZFebYBoAQdj3TBiSrPgh042
 qQoFsBXBOUmkMZ1LUjivykg6CB8QjbesFIGJ9cDDqnj/TjEE/JPYNvC55
X-Gm-Gg: ASbGncvE7/L5g4/7Xz+FVV+cU5q72D8UM6J7WC6gZpE9eWGjXpULx8fcrytY5/4Ocr9
 s0p12TsQyNWXtGpr0dteitplrfluTjal/d3lkcP5wxqw+b8bh8pJu3ow+5QQWhwNfBOD++q6Y7e
 r9AzpbR2Y662jxwUJig5pvovScL80GEZDxRPumn459twXxhiKJ3/FZ33ZCwv1jbzg0XtqIonIuv
 NYz0Srzgf5Ard573K/I/PCjqSDIGpVDyGNlgoI0Ks9gW8vksysr1bmy/PGg6uYlqgSu1LO7br2Q
 Y1Piw+hlpKT2C41VQBdjgM8Z9sabTWgasPFFoNsNQSERwzRPA+5o0dbNzmETxozaxJRAM6+pdoA
 =
X-Received: by 2002:a05:600c:4e8c:b0:459:d709:e5b0 with SMTP id
 5b1f17b1804b1-459e707b412mr1451165e9.5.1754424462263; 
 Tue, 05 Aug 2025 13:07:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+gp4PbzR8W1vSukbKCHsIx6NqUgIK4eJ93vmInMW67DXW4YPRjms/Ei6B40Xfszh55cKpNQ==
X-Received: by 2002:a05:600c:4e8c:b0:459:d709:e5b0 with SMTP id
 5b1f17b1804b1-459e707b412mr1451065e9.5.1754424461845; 
 Tue, 05 Aug 2025 13:07:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm6135358f8f.19.2025.08.05.13.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 13:07:39 -0700 (PDT)
Message-ID: <4468aea8-b8cc-4313-abbe-8a5f58a35adc@redhat.com>
Date: Tue, 5 Aug 2025 22:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/50] ppc queue
To: milesg@linux.ibm.com, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Kowal <kowal@linux.ibm.com>, Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20250721162233.686837-1-clg@redhat.com>
 <10177005-d549-41bc-b0eb-c98b7e475f97@tls.msk.ru>
 <ce863981-3d5e-4ec4-94ee-e35d773eab78@redhat.com>
 <fe6a0924-aff9-4881-9c2a-5665776d619f@tls.msk.ru>
 <dc796c6ae712a1a63eba2c6ab9c5c59b03942f50.camel@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <dc796c6ae712a1a63eba2c6ab9c5c59b03942f50.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 8/5/25 18:26, Miles Glenn wrote:
> On Tue, 2025-07-22 at 17:25 +0300, Michael Tokarev wrote:
>> On 22.07.2025 16:37, Cédric Le Goater wrote:
>>> + Glenn, Michael, Caleb, Gautam
>>>
>>> On 7/22/25 13:44, Michael Tokarev wrote:
>>>> 21.07.2025 19:21, Cédric Le Goater wrote:
>>>>
>>>>> ----------------------------------------------------------------
>>>>> ppc/xive queue:
>>>>>
>>>>> * Various bug fixes around lost interrupts particularly.
>>>>> * Major group interrupt work, in particular around redistributing
>>>>>     interrupts. Upstream group support is not in a complete or usable
>>>>>     state as it is.
>>>>> * Significant context push/pull improvements, particularly pool and
>>>>>     phys context handling was quite incomplete beyond trivial OPAL
>>>>>     case that pushes at boot.
>>>>> * Improved tracing and checking for unimp and guest error situations.
>>>>> * Various other missing feature support.
>>>>
>>>> Is there anything in there which should be picked up for
>>>> stable qemu branches?
>>>
>>> May be the IBM simulation team can say ?
>>> I think this would also require some testing before applying.
>>>
>>> Which stable branch are you targeting ? 7.2 to 10.0 ?
>>
>> There are currently 2 active stable branches, 7.2 and 10.0.
>> Both are supposed to be long-term maintenance.  I think 7.2
>> can be left behind already.
>>
>> Thanks,
>>
>> /mjt
> 
> Michael T.,
> 
> All of the XIVE fixes/changes originating from myself were made in an
> effort to get PowerVM firmware running on PowerNV with minimal testing
> of OPAL firmware.  However, even with those fixes, running PowerVM on
> PowerNV is still pretty unstable.  While backporting these fixes would
> likely increase the stability of running PowerVM on PowerNV, I do think
> it could pose significant risk to the stability of running OPAL on
> PowerNV.  With that in mind, I think it's probably best if we did not
> backport any of my own XIVE changes.

These seem to be interesting to have :

ppc/xive2: Fix treatment of PIPR in CPPR update
ppc/xive2: Fix irq preempted by lower priority group irq
ppc/xive: Fix PHYS NSR ring matching
ppc/xive2: fix context push calculation of IPB priority
ppc/xive2: Remote VSDs need to match on forwarding address
ppc/xive2: Fix calculation of END queue sizes
ppc/xive: Report access size in XIVE TM operation error logs
ppc/xive: Fix xive trace event output

?

Thanks,

C.


