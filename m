Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CA610A88E1
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5n0O-0000Sg-Vc; Thu, 26 Mar 2026 11:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5n0N-0000SQ-QH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5n0M-0007VG-3a
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774540337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V+oCW4ug5vGxbdQn01leFVxP9sEeBxWFiIXtOC+kYiU=;
 b=OegxGCgyDJlsPXItjhoA3HcVnRCMzREyv1mFzbDL15UWJA3RepgCtmFMz2Dx/curUy1xUg
 COCs89/NJuu/zLkonpTNY5e+jlHg5Z7wS59bj2EWe9QYuMKVij+Y+9Aqy36QHUkF2SwwrS
 UQXpqJWJay2qERjBc9R0DrwN526aPpY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-8PpT0CbTPK-mEOOyzy5M9w-1; Thu, 26 Mar 2026 11:52:15 -0400
X-MC-Unique: 8PpT0CbTPK-mEOOyzy5M9w-1
X-Mimecast-MFC-AGG-ID: 8PpT0CbTPK-mEOOyzy5M9w_1774540334
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48378df3469so7013825e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774540334; x=1775145134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=V+oCW4ug5vGxbdQn01leFVxP9sEeBxWFiIXtOC+kYiU=;
 b=POTX24RTPs5Ak/X5fOh0epG1fL43iCbIqtQst3bJtcXKDoXbRQZeFuKAq05RXZbNv4
 8JK2UMtjZNhJjtx3JjKkc/Q6eaFb/No+pGsTUKkT7q+aUwdHCHYmaF/6DbAPWrzPXjtt
 3BIOhov1jZeXk1WtLAV55KGzp6q28ISBdcMkseG4u8etpc/y26AEUSbVfpEBR9H2Y2/M
 HPDT9AjfJVheXE3Z8i9hs8a9WXEWvpwUPen/+Prfy5XiMyQmr52mBHcHTqbR+IgXBRfU
 JVDglbMnmlTU9mWdxBZUKVF7aeI0Ox7f6vilvlrWZHIataD0sWvr2I51mqhXjnYDK598
 x37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774540334; x=1775145134;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+oCW4ug5vGxbdQn01leFVxP9sEeBxWFiIXtOC+kYiU=;
 b=rO791g0iw572KX22YVf8QvTqsINVE4FUJREmaVZeRBNDbB5SCWlPhu7G2u2wSF+h0B
 h3jgTbCE1UeWvLYbz2QmLddEnNUCTER/qcG/iXTNbcWk6+ffMPVxQlw02EuZUMwuGLXG
 z9d7SLLADL0R/MSLnG5+sawL33Sq4B7xthD4y0y33+Y7t9qThSv3OWLnhvvOONmNXbEQ
 tj/nEhxIqWX2lRRjILEQrVdJhkaAatjqn6jJDmnXi3UHeKUtm6v4O9dSqKZkchjaaWev
 ypoFjdUA7qEoj01L4niZ4ggnTf5HnfjWrY1rR3KjCe/fYNXR+b7lUt8a5on6lhqnaIn9
 tCkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhs6c+9EjySbaKiWx48EyDuLHJqMqsV0+YxTm2SPkO6Qo8XvZsQ2eLgtgC5xiBVFenD/NsOyjj4rBk@nongnu.org
X-Gm-Message-State: AOJu0Yw1c7qWrwXLxVFggAanIUjsm/obOkbNQjkAWcww4gPpbgJWCKHv
 GQ7odeRPVdntKzhLKZKDBWMz5psEZ1kOlY+7S/Zu/7Dfc/Cc1Ki658fP7isxgsepZGO6dKAJzyf
 8eV75LDRK+HPnzZqsXu0VBJSVLdPA+Y+rKtEM26+clXQTKUpflIUrlgYy
X-Gm-Gg: ATEYQzw+lY23pEE89RRWN3x5x950NcJ+aVxawCm863xkZ3/Bx/iMrBXynVYaFVZx5dg
 2+gbvGg8Eo1TL3DvLAf3bJ9UYkKdS9sqmTsctqe6VAWbNEqRDBkgwiA23kiYtHroCFT7l1ff9A0
 mqQV5hgWPyqszHZxTjIa6YPSJnJOGLGmgKYIQInX+lsAqyhb+VHqe6M8XGcJltRVLHsW5ZhX/1Y
 JG/VL6ytKuFU9zza/i9byZmqLQDJSz44Zgw9o0ynMXcrRI7Anwg19cFDTgBNqSbRnz3xYe2dB2P
 LhihjKiOsvsMQgEvrJGXAoXy4wM4ES/WU+99k42GNoRdCqHxNhL0WEbOszXtepW5vowsO6ts6yc
 1fUJj/asOVdQZJSm9pQ==
X-Received: by 2002:a05:600c:3e8e:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-48722ba925amr34083725e9.6.1774540334440; 
 Thu, 26 Mar 2026 08:52:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3e8e:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-48722ba925amr34083285e9.6.1774540333900; 
 Thu, 26 Mar 2026 08:52:13 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.85]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722fa8dc6sm68777035e9.1.2026.03.26.08.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 08:52:13 -0700 (PDT)
Message-ID: <2a024c3b-7a4a-4ab1-92bd-1011fadf2c9c@redhat.com>
Date: Thu, 26 Mar 2026 16:52:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/vga-isa: Fix migration of the isa-vga device
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260326113457.159065-1-thuth@redhat.com>
 <CAFEAcA-xWtr=Xgst=MOVcm+TxegSvNVXmDP_RDVDOvJJW76Qeg@mail.gmail.com>
 <f6045fed-60fb-47b8-8241-a6fcb0af7292@redhat.com>
 <CAFEAcA_VoSX2JK-HRpAN0P0LT2dj_WvSRyP2dom3ZQK76mtyfA@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_VoSX2JK-HRpAN0P0LT2dj_WvSRyP2dom3ZQK76mtyfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/03/2026 15.57, Peter Maydell wrote:
> On Thu, 26 Mar 2026 at 12:04, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 26/03/2026 12.59, Peter Maydell wrote:
>>> On Thu, 26 Mar 2026 at 11:35, Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> QEMU currently crashes when migrating a guest that uses the
>>>> isa-vga device as display. This happens because vga_isa_class_initfn()
>>>> registers a vmsd for vmstate_vga_common that operates on VGACommonState.
>>>> But the isa-vga device is derived from ISADevice, not from VGACommonState,
>>>> so the migration code tries to fill in the data for VGACommonState to
>>>> the memory that is a ISADevice instead, which is of cause causing trouble.
>>>>
>>>> We need an indirection here as it's also e.g. done in vga-pci.c, so
>>>> that the migration data gets filled into the right location.
>>>>
>>>> While we're at it, also drop the "global_vmstate = true" here. Since
>>>> migration was broken for this device during the last 15 years (!) anyway,
>>>> we don't have to worry about maintaining backward compatibility with this
>>>> switch for older versions of QEMU anymore.
>>>
>>> That means the only remaining users of global_vmstate = true are:
>>>    * TYPE_VGA_MMIO : used only by the MIPS Jazz board, which is not
>>>      versioned, so we are OK with migration compat breaks
>>>    * TYPE_ISA_CIRRUS_VGA
>>>
>>> I don't suppose that migration is also currently broken for Cirrus ? :-)
>>
>> No, Cirrus seems to be fine. But I think we should likely do something like
>> commit 1fcfdc435a3e25ab9037f6f7b8ab for the isa-cirrus-vga device, too, so
>> we can at least get rid of this in a couple of years...
> 
> If we're going to do that it would be nice to get that in for 11.0.

I agree. Patch suggested here:

https://lore.kernel.org/qemu-devel/20260326154850.301609-1-thuth@redhat.com/

  Thomas


