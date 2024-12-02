Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC0ED78318
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 12:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI5oW-0002QK-7g; Mon, 02 Dec 2024 07:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI5oE-0002PD-Gz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:45:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI5oB-00023g-04
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733143545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4s6ISwIIFCtddtWNdMr3i7tzh2F5qtk1IT46LH/vzkU=;
 b=AoWDzDpPp+vvSWF1ODtxbQFI53t3W53LwTak+MopO9yLt17if3tvwFHKNSwGhq/vZIonpQ
 8nzeQ9BFJ//Bh2thm5H5pJSUsSlD5nfS6xhexgoSSbhCDpLeGjr+rkwbcpRHSM0ScqMVO1
 QD04UbJHOEEh5xVWJheBz01ocrz25yw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-CTroFFeRNQmzlfzPJWdMIg-1; Mon, 02 Dec 2024 07:45:43 -0500
X-MC-Unique: CTroFFeRNQmzlfzPJWdMIg-1
X-Mimecast-MFC-AGG-ID: CTroFFeRNQmzlfzPJWdMIg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43499388faaso29449145e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 04:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733143542; x=1733748342;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4s6ISwIIFCtddtWNdMr3i7tzh2F5qtk1IT46LH/vzkU=;
 b=Hc1G96YjK6FBajz2BfZbIy+yp2dZPsbroPdktL6PVIbT+owAtEpmzUdW1LixrdZras
 SVSm+kjqmjjBCA2oMnIy8Dlpyk8S+9pUxJmCH3j4vZ92dauEo1bf505+KlJuwks3vhoE
 8Bixemnz789y1uPPEe00G4e+GjM0I4sQJrYgqQBzLyIlTDeGBS5KmhMUvbQBE8qMl/qP
 /EJATZCJA85qteemg63kgfB3uIf3Gf8l0ZluJASnkZQR3FJ+v5+YsZnW0fvIDdIgp574
 ll8Oqe0e0ID3G+ZMi7GybzXKq6Sq5NzM8hq/ifLLJEwN9QcQtu6edfcWTitTo8t+FALZ
 Dvvw==
X-Gm-Message-State: AOJu0YzK1CYNXD6mwYHhV6/ys8xUMz5dFzhqah/Yss7WrjNiD05VvK5h
 /ikOCr7RAiLhjt4+wVlboNR0ssv/44SHvpdrh6OArDdYTY0F5q763ddawv/t6zODqADqdPfkAQR
 1ZE7ffakvVkVHV8Dc3VLHe+6goQr4L0z4QOtF8+iQNAvZsXmtNTyx
X-Gm-Gg: ASbGnct5gBvPzffXpQBRmH0MyBY3WTyprXuXFHdCRKWWrbimL60eD22U8vwiz0BGaby
 GwCz1gbjXSBrcBnRWUOHl1WLA/MCl7jtNJQT+OFc9iul9qYcDwJATae5bk68qVNQuKgaXBG4ooC
 oWRk9BaS2vZW33N+i0mElE06BpsBFC41P+V32n0V2qeIQ9cZ/JQPggKgdr4csoaaaqQ87KJRvwk
 P2mPqR3800+Y1QiYOWAHoqeMkBZJ+bbWHBeX+WHwgdnb6QcxvtGFOGli7QEjaRjx1jcXpHVwd0=
X-Received: by 2002:a05:6000:401e:b0:385:f6c7:90c6 with SMTP id
 ffacd0b85a97d-385f6c792f1mr1775854f8f.20.1733143542658; 
 Mon, 02 Dec 2024 04:45:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0ypULkKNJPJOQSlGBiXR2qRs0a2cXzeGjzEk1B4dUdMOVCLBP2a8x23PNGE6yvtCkyTTqOQ==
X-Received: by 2002:a05:6000:401e:b0:385:f6c7:90c6 with SMTP id
 ffacd0b85a97d-385f6c792f1mr1775812f8f.20.1733143542194; 
 Mon, 02 Dec 2024 04:45:42 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385db37debdsm11035493f8f.2.2024.12.02.04.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 04:45:41 -0800 (PST)
Message-ID: <3f5fdaef-61a1-4dc3-afec-e05bf34d384d@redhat.com>
Date: Mon, 2 Dec 2024 13:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] tests/functional: remove duplicated 'which'
 function impl
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-6-berrange@redhat.com>
 <23b4e458-b46d-4b7f-a6a0-16e58e3e5f2a@redhat.com>
 <Z02djVGVj-ZX2kV9@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z02djVGVj-ZX2kV9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 02/12/2024 12.44, Daniel P. Berrangé wrote:
> On Sat, Nov 30, 2024 at 11:16:30AM +0100, Thomas Huth wrote:
>> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
>>> Put the 'which' function into shared code.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    tests/functional/qemu_test/__init__.py |  2 +-
>>>    tests/functional/qemu_test/cmd.py      | 10 ++++++++++
>>>    tests/functional/test_acpi_bits.py     | 13 +------------
>>>    tests/functional/test_ppc64_hv.py      | 13 +------------
>>>    4 files changed, 13 insertions(+), 25 deletions(-)
>>
>> None of the callers really seem to be interested in the location of the
>> command, only whether it is available in the $PATH or not ... so could we
>> maybe rather drop this function and use the has_cmd() function everywhere
>> instead?
>>
>> Hmm, thinking about it twice - has_cmd() uses the "which" program
>> internally, but AFAIK this program is optional in Linux installations
>> nowadays ... so maybe it's still a good idea to move our Python which() to
>> cmd.py, but has_cmd() should maybe rather be changed to use it, too?
> 
> This reminds me I meant to ask about 'has_cmd' - it looks rather
> over-engineered to me to be trying to invoke the command with
> args.
> 
> Perhaps there was some reason to check support for individual
> args in the past, but none of the current tests need that AFAICT.
> 
> So if anything I'd be looking to delete 'has_cmd' and 'has_cmds'
> entirely, and rely only on the pure python 'which'.

Deleting has_cmd is fine for me, too! Especially since this function already 
caused confusion in the past (see 
https://gitlab.com/qemu-project/qemu/-/commit/59d100243d23451e66d2274d34edab7be6dab473 
).

  Thomas


