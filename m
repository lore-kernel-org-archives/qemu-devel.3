Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE21C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmix-0005Sc-9B; Mon, 20 Jul 2026 08:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlmit-0005SU-Eh
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlmiq-0005J0-BD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784549026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8IokdkFKEL3BZYgs9ozNHruAircTy0iWrbOGUeBmhxk=;
 b=cfIacdUVbZbbgDxr15dKQihtZhKRARSmBmWTdta1ws0HRtoHXUDc8yOyrVcyW7aFJzyXgB
 +s7RBsgawmINm3BEIgqU6ket7HoDj8391resrc/PgdpY9LWDMY6LNrhWZFO283Hk1oMGw3
 /Tj/AFeNsLhAl7PWcEUgeaI/RspJCIQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-WHsXlTxUN1a6ngBGOirHjA-1; Mon, 20 Jul 2026 08:03:45 -0400
X-MC-Unique: WHsXlTxUN1a6ngBGOirHjA-1
X-Mimecast-MFC-AGG-ID: WHsXlTxUN1a6ngBGOirHjA_1784549024
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-473e18559b2so4238201f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784549024; x=1785153824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8IokdkFKEL3BZYgs9ozNHruAircTy0iWrbOGUeBmhxk=;
 b=g+QBDE0UDzhb+1xmenasy4K9GXUB0sX7EOEmXOfMaHglvw80abccI9cdu62t5VQ7Gu
 lof7pvYNkvJWIOZCGriMy77W+fSXwT27dhjsaj/9MW3d8bzeZ2ml2p2IkS+bxdBaS8og
 Lk96bM6PdV1uqJHXQU5SDirWhAkyDi3YfT3jj8P/fEd8acted1C7cFluEaRh0BXMEUxe
 /BDlgKPpXdOYBTsqDyT8Kkt8MihIz5WwbzmpJ91B46+O98BKZKpB53lTKYV25kHgL4zN
 30B8MHHWEfIbHrpqsA7wHmWbuyz4rDEyk5hy4S5b/lQUMU7GB+BfxYEGed2crm8DWH7k
 3N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784549024; x=1785153824;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8IokdkFKEL3BZYgs9ozNHruAircTy0iWrbOGUeBmhxk=;
 b=Ry4x5Y8vMeZW2gJaiVC72h+Crz2Hv0GsX+MGOugln6c1sRtHIfQZXYMYQo0EQKwHLp
 9u/axpsOLcv9/xA0GzcSrPEo1Arh3AotcgjLkquQG5dsDOhcLRsEdea8cpK6RCPwhJpX
 2sGoDHx5E9OKLQ5Kl1xOF7MjED2aD5zn90QZd1YGXwqECRsGJQuHIitqQ5++JnfbQG41
 ClMK8r8J5hSZSd7zeTXta2TjudfXK4jZUVA0hWKP/SatC39YRgZ+D3Z6h2GiBYLQOBhl
 BR5cG3h2vc3v+1YMyIIWrYP9sNw2ar6NTBvvp0CKNSKCEd39rN8uDJuN8toMws2oaV6u
 PQ8Q==
X-Gm-Message-State: AOJu0YwtHgWY6Kzok6wNrm1Wb0rpDWHavGElbCKqGt2KJH9WEciv5daq
 NHeQHSmNZ4ievLyv/AJGlVBmBdxBgsFrzZOx3X2hTYgQ2qsRu2aS5/JynyP7zcbGesWAKgOmQwj
 JGrUGnQZMd8kd0TshfxJXxzOn6BM8QnfsH2PYIAQY6Yb8yWDC65VTi4rO
X-Gm-Gg: AR+sD11e8A0/BrkPLwIHBt0GQaPyMPZOBVsLAOL6jlkgY59sUtYlREJgeouZHpcmOcV
 80aK/P1Seln+zUD0Q6CBvtD/7oTsAe8GM1QUPEoPTsNT04N5GyT9+FPBz8xHqneZTKFavAyTJgd
 lOBArLyf6K7K6BJUmEXrtj2PvFEIj58qxdW5LUNyTh2/MKDzhjVIiK7V/m5IWHGqSmnGTkHAk2r
 l6yj9YjT1043MGa6kzibPZFb2fVj5bUZG48Dv/L3jJ3DFmKf7ZP5yCI2V6lM+8M8+I1hi4VDode
 4+Lmjmc8IopTraovsuMIi2tZXcBXSNJBG7oLXJchpCMhqkaOHreW/biXpQ2T2e3i64b0Wxiu0g=
 =
X-Received: by 2002:a05:6000:471d:b0:47d:ec60:6578 with SMTP id
 ffacd0b85a97d-47f6233b433mr15758515f8f.50.1784549023931; 
 Mon, 20 Jul 2026 05:03:43 -0700 (PDT)
X-Received: by 2002:a05:6000:471d:b0:47d:ec60:6578 with SMTP id
 ffacd0b85a97d-47f6233b433mr15758463f8f.50.1784549023366; 
 Mon, 20 Jul 2026 05:03:43 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed1911sm31347177f8f.22.2026.07.20.05.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:03:42 -0700 (PDT)
Message-ID: <d815f5a5-f3bd-422e-98fd-eeb12f8bb91e@redhat.com>
Date: Mon, 20 Jul 2026 14:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/xhci: clamp interval exponent to avoid UB shift in
 xhci_init_epctx()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <sXJQOREScD4G6fYInirO2wbLtvZf6EK1yuTrP6U3GQBM5dIq7dhRnCm9uxSSiRRK0b4m7OEZRqEgjzHCTFoS0DruFvYUXh-UUXhkY0x786A=@proton.me>
 <CAJ+F1CK=jxw1Nf8UYa6jx344HknSXyj5A4MaoUWr5xJSK-ohjg@mail.gmail.com>
 <f8f6b689-eb5f-442b-ae69-f09c226ea9f2@redhat.com>
 <56a25874-cb6f-4510-8946-bd60e11fde43@oss.qualcomm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <56a25874-cb6f-4510-8946-bd60e11fde43@oss.qualcomm.com>
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

On 20/07/2026 13.42, Philippe Mathieu-Daudé wrote:
> On 20/7/26 10:37, Thomas Huth wrote:
>> On 24/04/2026 16.54, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Fri, Apr 24, 2026 at 4:37 PM Feifan Qian <bea1e@proton.me> wrote:
>>>>
>>>> The xHCI endpoint context dword 0 bits 23:16 ("Interval") are written
>>>> by the guest and passed directly as the shift amount in:
>>>>
>>>>      epctx->interval = 1 << ((ctx[0] >> 16) & 0xff);
>>>>
>>>> The shift amount can be 0-255.  Shifting a 32-bit `int` left by >= 32
>>>> is undefined behaviour under C11 §6.5.7p4.  With UBSan
>>>> (halt_on_error=1) this causes QEMU to abort; with aggressive compiler
>>>> optimisations that assume UB is unreachable the result is
>>>> unpredictable.
>>>>
>>>> Clamp the exponent to [0, 31] with MIN() before the shift, and use
>>>> `1u` (unsigned) to avoid shifting a signed integer.  The xHCI
>>>> specification defines a maximum meaningful Interval value of 15 for
>>>> most endpoint types; clamping to 31 is the minimal safe fix that
>>>> preserves the full unsigned 32-bit range for any compliant value.
>>>
>>> I think we should clamp it to 15, to comply with the spec.
>>> Otherwise, the patch looks fine.
>>
>> Some endpoint types seem also to allow up to 18, so I'm going to pick up
> 
> Which ones? I agree with Marc-André they are using illegal values.

According to the XHCI spec, the "FS Isoch" endpoints are using values up to 18.

>> this patch with 31 replaced by 18.
> 
> If we don't want to report the illegal value as GUEST_ERROR, I'd
> just clamp to the spec and call it a day:
> 
>      epctx->interval = 1u << extract32(ctx[0], 16, 4);
The spec says that the interval field is 8 bit, so this is certainly also 
not right.

I'd say let's fix now the undefined behavior with the current patch, and if 
someone feels like implementing the spec more precisely, this can be done 
with a separate patch later.

  Thomas


