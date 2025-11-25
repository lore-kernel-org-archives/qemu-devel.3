Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F78ED0EE00
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 17:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNwx7-0007xF-9A; Tue, 25 Nov 2025 12:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNwx3-0007tw-9K
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:35:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNwx0-0001ph-9J
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764092135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6u3kuFPYxyXQs54QLHTbV0ReFH0dCtc+4hHbEPrnMbY=;
 b=Lt6fGu7mecqSLC43F2yKuxk0NC0VJWmiwcOuwSThmZ0CXWyRoe7RdLUgCLewzqj1jImvK+
 X63eyA5aF+xcHr9hSuMtOxRHru6O9mHCmVPA19uFHPwUzO3yJ+Kb+gDCsVFKSZi2Mo3qBL
 UiTZrBNrATE0JHV1mae/S6+m8BOdBWs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-XWXVNUSCPw6NCjkEPINoNA-1; Tue, 25 Nov 2025 12:35:32 -0500
X-MC-Unique: XWXVNUSCPw6NCjkEPINoNA-1
X-Mimecast-MFC-AGG-ID: XWXVNUSCPw6NCjkEPINoNA_1764092131
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47106720618so72904885e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 09:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764092131; x=1764696931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6u3kuFPYxyXQs54QLHTbV0ReFH0dCtc+4hHbEPrnMbY=;
 b=RmuZ3pCPP2ts7Vkt6/4LBWOaNRPL9WuvBh6DxjNzbVGuiz6irmSxIlzcbT2YkG+PK1
 4Ji5qNKQHCnW0MPoAm6ZBbvgPuPWH2OS9fdyw0urmNdjhnhPJDnUuxpzDlry4rjaC731
 f5cGhonJxypVHNjeQ9LRasKCoKZq5xoeNuReQ4+nKXY32KXVcZ9PwcZkNLuLuH2HMADj
 xYqDe+wrBwPZu1aiDdUwaNpV9uOquvflvrNKIU/tIAqJ8y1Sas+NYSLa7Z1oROWYvZoy
 +ncA+JEaSOJb1fOB1qrJQitNvh+POUg3wIf9MCaQs2rQc2Lfrci3h/V7Wxux/Kya96RT
 4VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764092131; x=1764696931;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6u3kuFPYxyXQs54QLHTbV0ReFH0dCtc+4hHbEPrnMbY=;
 b=Wg5ClOY4/I1A7OYAJ154a9Be285NYo3L12c87DbFWGfAMwN2spkCc66tN0uRqlTECd
 Cpv8SIbLMU0UbXMry7QQbnamSp46bXoAgB7XYvjcvNrjCqXE4OFkZq8FhUROFKZoxr7f
 vuYiFxG12eIl3QHAtutIgN5NMpJ5J2XPKFcFHQ0OHv1IRs8oEMv+KAJ42GXX5rDtjywP
 2rZZANMR/kjCYcAQxv3uzbKrS45PYC8zFgJNu0nTrXJ+JMAgJeLDM23d98gGvus1Mu4K
 KuURwb1qlc8g1FxoCKEmoRh2BLcKPXsDzcw2XP010bcJfJAw5Ql9i3rlh+nxtt/tVDJ7
 I16w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeJrBNSKWTxLvF4FlTQx+tm0B3Ehj/KaWQ+7Lq2xGoG2lDFxAwiMrMfdmp5qk2EEmLM0f1Hta4hW9I@nongnu.org
X-Gm-Message-State: AOJu0Yx8WLenZvn1QwZT46ZbnRnoeKxkSzYiq2/3fAIVcTELJu4d6z7A
 +4CuBm+3mWtQdbNABAiwpeoVjJU056aDtMJ9fNj+lvVsGu3qTmWxzGI1WSXfJUoi/sygWvX/4Fs
 JESPbz8xuLIeFq+goQMYGKhxCehDZa3nAytcxxf4j3mTI7jTfaWU8tTG2
X-Gm-Gg: ASbGncs6SZ2CM0k86fYqedLCvLQrp9n97cWyNfy4aBFSZJi+P2y9Qx/B3yjXo3Q95U6
 TBKkWg6noQTupma6yNskR8Oz1llhWQ/lLcKAieyiyP361N4/9x+hN3CLGnvXGWKwqIWmvAunJzQ
 pfcJMMiadW37ZG/d17XVY7tO18MMbGX05BDJ/ZRv1iTYUNsTCAqvAIUzqU+pDYEJbuxikrnMDmU
 FhSoIUVwrCq6nBlToZG71SKdVtQmH5b2Fdzcc7gBwGpSSMsJ+qzYZHmkdWIMInGJO44Ri881+F8
 kM5f4RDD6m72hBRwi5Op42aPl+Uy+5xyGxn38vwccj8xsg/B6A8ZUtSbabspKY9SKE1cUxFHXfa
 RYzEbU0S4JaJm+f3Zb6lCq3NbLYr4GRvwHA==
X-Received: by 2002:a05:600c:524d:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-477c01d44b4mr152250065e9.19.1764092131095; 
 Tue, 25 Nov 2025 09:35:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZZ+PiPY28ZFoSzjbJHN3I1r5SqYKuzsUpmXL4SbI6h71peCYTZyuG38NwC9V+QKBA0tffJA==
X-Received: by 2002:a05:600c:524d:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-477c01d44b4mr152249775e9.19.1764092130649; 
 Tue, 25 Nov 2025 09:35:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479052cf8d9sm20259725e9.9.2025.11.25.09.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 09:35:29 -0800 (PST)
Message-ID: <4d59c999-29bc-48f0-b409-c877f5dd6ff6@redhat.com>
Date: Tue, 25 Nov 2025 18:35:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed/{xdma,rtc,sdhci}: Fix endianness to
 DEVICE_LITTLE_ENDIAN
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20251125142631.676689-1-clg@redhat.com>
 <8caeba48-95be-4944-8c0b-5fbfe5b13774@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8caeba48-95be-4944-8c0b-5fbfe5b13774@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/25/25 16:38, Philippe Mathieu-Daudé wrote:
> On 25/11/25 15:26, Cédric Le Goater wrote:
>> When the XDMA, RTC and SDHCI device models of the Aspeed SoCs were
>> first introduced, their MMIO regions inherited of a DEVICE_NATIVE_ENDIAN
>> endianness. It should be DEVICE_LITTLE_ENDIAN. Fix that.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/misc/aspeed_xdma.c | 2 +-
>>   hw/rtc/aspeed_rtc.c   | 2 +-
>>   hw/sd/aspeed_sdhci.c  | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> \o/
> 
> Thanks for the help :)

Only 379 left !

Cheers,

C.


