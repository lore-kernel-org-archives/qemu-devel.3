Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225CBC4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljV6-0003kB-Is; Mon, 20 Jul 2026 04:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wljV4-0003hQ-6Q
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wljV1-0002wH-8t
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784536637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M4EBWw4z3eeYUAUWdu5hR2+y3jdwDOwsItnJ/vRY0zk=;
 b=eTrJDvk8zZiVDa4EhPVf6cgvbdXDx1QnSIIJzl4m8M7SqL7HQSjQI+fjIfZzVx/EySEm/Z
 NiWNCaZfAokyM9czFKZ5HVdWoj3Wt6WSfwPXEVzqwp1zzXzbgwEIDKawy3xyUDFxZjAG4m
 VCLnwKv/NHzyf/ErH+e0bxw3dCoAD9k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-luEqq5uBO5Ofie4TgGl26Q-1; Mon, 20 Jul 2026 04:37:16 -0400
X-MC-Unique: luEqq5uBO5Ofie4TgGl26Q-1
X-Mimecast-MFC-AGG-ID: luEqq5uBO5Ofie4TgGl26Q_1784536635
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49559af7b97so7384305e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784536635; x=1785141435; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M4EBWw4z3eeYUAUWdu5hR2+y3jdwDOwsItnJ/vRY0zk=;
 b=gbLRB323HS4h8GEgfd8r8fm5AP4BYZxKztZ7ovPh/wRtmwPMx2Lr9IbJI73SCDvI3U
 X7xH1kA5UroO+jQ9lzL+szxBwhDzM66wyL7rLRBYLGPEjlDLXyizN//ex2VUa4wKpw1K
 yorgoLb2oxi2Z8W+pTDwjsA2j4So+7CXzOrRke0i/6PxymaPGdt3JKAtcsOV8L2vx6pA
 rackhqY0WiniVlM13CCm8XnuGlfTP+qddxhNrPJTqyB2s0n5SSfp7JlUW2D4CHMjqLCa
 o6T6qSl6j+fMiByPK/WFrwqh7iaYeoi+dxKg74ASaAOSCsJsJ/IUG+4vmdAFGamnwnee
 VeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536635; x=1785141435;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M4EBWw4z3eeYUAUWdu5hR2+y3jdwDOwsItnJ/vRY0zk=;
 b=WmqYMIOTngDPKLaICJLgdCMBLBcWDx5NyHNGgoHTVPrqGdOUFcD/4z0qaTMCFqlKv6
 wsZi5KzbmzvFCQN6o0EfWQf1MWJYVsPVdgFUnLLnuzi4rK53S+S6LbPZOoCqHUlnW4j3
 xR8vhUkBasOMmjgI4WsjgatoLNd0A/QbkMdgYMHVVtnIwXVycWvJOll1SyHuinuSoUT7
 DMe7ifLeONNcICML42jKBKgfwyNAlfJ8M4llFCX9dOT9UhuHl0LceT98rOqAXTu2g6Un
 4t91IEh+lk7DQkLo6P6YdBH5QD9nYS6WSbRygesi4h9nLm7ahWXSYOC2LauIlpTGSnWz
 m+Dw==
X-Gm-Message-State: AOJu0YxjXhi0C0p8pvj+c+BxeYzQfNSetkcYwKu5bx1WCk7V4bOsxzi2
 OE8yVxWU9MQfuZxqLCERIW5bcB+vMy85mk5fYk+Xx3FjosXmXLHeKumE45ugGSRSstzpviuz5//
 m03IZPc1xnNSOHaiL0zO1PIsx1meyV178UL7Oz94hq33c6gle+mnzIg6V
X-Gm-Gg: AfdE7cmQ0TqZ+s79GYdqVdikzlgOxwbW4UXlNV8KWX3L03+IpvJZA0sQjGvHpDGXE8A
 B1FV5WVLhSyRUjdZUZi20laZwvxy6v3Y3E7R+7IlfuLhkBwiwINiKEUCGPfAQ6iS7uE7oQsX9N1
 0PYRW9Lyh5UMJdVEhjDdXbj0/9bklkfXZ3QsN/U5NGAQmxnIU++P8UPY7iHrdzmFZ/ktZBORCVZ
 xiR25RBsFMtTM3lfVPudFKfVV098kaeiz7ovPGBCMn6tOiUguUKXbE/O5jJhU16esOJeRzHUNUs
 mdJVx2nGFuKicf7JCIGEdsCIPmgTMAcq443Iu1XcgyAq59XG5HoSY9a9Fy+lbPYX48DW+jVXag=
 =
X-Received: by 2002:a05:600c:3512:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-4954a3ef7dbmr136907465e9.9.1784536634752; 
 Mon, 20 Jul 2026 01:37:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3512:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-4954a3ef7dbmr136907145e9.9.1784536634370; 
 Mon, 20 Jul 2026 01:37:14 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955df9d2f6sm49138605e9.4.2026.07.20.01.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:37:13 -0700 (PDT)
Message-ID: <f8f6b689-eb5f-442b-ae69-f09c226ea9f2@redhat.com>
Date: Mon, 20 Jul 2026 10:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/xhci: clamp interval exponent to avoid UB shift in
 xhci_init_epctx()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <sXJQOREScD4G6fYInirO2wbLtvZf6EK1yuTrP6U3GQBM5dIq7dhRnCm9uxSSiRRK0b4m7OEZRqEgjzHCTFoS0DruFvYUXh-UUXhkY0x786A=@proton.me>
 <CAJ+F1CK=jxw1Nf8UYa6jx344HknSXyj5A4MaoUWr5xJSK-ohjg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJ+F1CK=jxw1Nf8UYa6jx344HknSXyj5A4MaoUWr5xJSK-ohjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/04/2026 16.54, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Apr 24, 2026 at 4:37 PM Feifan Qian <bea1e@proton.me> wrote:
>>
>> The xHCI endpoint context dword 0 bits 23:16 ("Interval") are written
>> by the guest and passed directly as the shift amount in:
>>
>>      epctx->interval = 1 << ((ctx[0] >> 16) & 0xff);
>>
>> The shift amount can be 0-255.  Shifting a 32-bit `int` left by >= 32
>> is undefined behaviour under C11 §6.5.7p4.  With UBSan
>> (halt_on_error=1) this causes QEMU to abort; with aggressive compiler
>> optimisations that assume UB is unreachable the result is
>> unpredictable.
>>
>> Clamp the exponent to [0, 31] with MIN() before the shift, and use
>> `1u` (unsigned) to avoid shifting a signed integer.  The xHCI
>> specification defines a maximum meaningful Interval value of 15 for
>> most endpoint types; clamping to 31 is the minimal safe fix that
>> preserves the full unsigned 32-bit range for any compliant value.
> 
> I think we should clamp it to 15, to comply with the spec.
> Otherwise, the patch looks fine.

Some endpoint types seem also to allow up to 18, so I'm going to pick up 
this patch with 31 replaced by 18.

  Thomas

>>
>> Reported-by: Feifan Qian <bea1e@proton.me>
>> Signed-off-by: Feifan Qian <bea1e@proton.me>
>> ---
>> hw/usb/hcd-xhci.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index 0000000000..0000000001 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -1119,8 +1119,8 @@ static void xhci_init_epctx(XHCIEPContext *epctx,
>>          xhci_ring_init(epctx->xhci, &epctx->ring, dequeue);
>>          epctx->ring.ccs = ctx[2] & 1;
>>      }
>>
>> -    epctx->interval = 1 << ((ctx[0] >> 16) & 0xff);
>> +    epctx->interval = 1u << MIN((ctx[0] >> 16) & 0xffu, 31u);
>> }
>>
>> static TRBCCode xhci_enable_ep(XHCIState *xhci, unsigned int slotid,
>> --
>> 2.43.0
>>
> 
> 


