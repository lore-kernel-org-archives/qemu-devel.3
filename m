Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A94D3941D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8IKz-0007Xn-0a; Thu, 02 Apr 2026 09:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8IKr-0005fW-Uw
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8Hgt-0002fS-K3
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775134942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hIpy885MicAx2xIZcS6eU3RGt0iplQw5LRV2ayQ7Obk=;
 b=AnYsKJeXvhEKyLb10WjcHk8I618Q9jDOe7JS727nBbSioJL9m1CIqwWYKQPl/RUb+4plHe
 QPPnoPLLymNqFhZsTeCK94pOT2kroe8hgH3hIoHg1WSCAUbvZflaAckH8Km4KNjMz7vMGH
 o761pV3Hk6W0jZjxLiy4Gt6Hi7gjn30=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-PTt0m0i2OtOTCCcBI4qqLA-1; Thu, 02 Apr 2026 09:02:21 -0400
X-MC-Unique: PTt0m0i2OtOTCCcBI4qqLA-1
X-Mimecast-MFC-AGG-ID: PTt0m0i2OtOTCCcBI4qqLA_1775134940
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-486fa07f2bbso7380035e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775134940; x=1775739740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hIpy885MicAx2xIZcS6eU3RGt0iplQw5LRV2ayQ7Obk=;
 b=B3lyAFT3f7QFGTQc7hCQi7H0wIMPQg0TK0Gmdy1KmUyBgmPKPPq07fyvLotKENVWkc
 NzbV8T0vy2dp9qDfLDhokV7wmprjVQHOOOS71XEmtyQocnPVXMGA9INziksGIihGim2r
 h0A8KCc4Kn6dVD+StBReT0uL0B/bFagzy27gpieEf9cPPv76mg8+0yxD0AUcNoLRnI+O
 GBFUEJa2wLcfinfdyEgwV3w+v1EGO3Vz23FIQTA/n2Kvj45Lm4YeElWLXYzoF6ffqGzf
 ZnYpLhSuC8Qe39XY1yMxw7lczF3Graun7yqQoSo8l8yuPlregX0y95EpxaEh8DCNfGsg
 ZJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134940; x=1775739740;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIpy885MicAx2xIZcS6eU3RGt0iplQw5LRV2ayQ7Obk=;
 b=fjS63oFofKutZuyKumO7aFb5zc9SxzrvYFJZWb1EovscDyjiL04IV6o6Jqps+BdAsa
 HE5bfmuLEkEGxP1vwgvsFsiW+r8DPYTU3nzM0Dit642bkv+g4+KQs5LPYqGK+J8eNtAu
 i0crxDEnHKZICC9725SaypG8AEgJAf0p0V4ZEuD2uu2eFEUKrjKT1700V30NsuR8JC2K
 MoyrmNTHDYI7Q/LFX7Pept8II5BDtVOzQFkj5lu5uyQo0BIHnR8P3sRSDKdd21VQEM18
 AkergLOX/1NU/40pb4gpUIhbJbgusfmY0g9tETbkqolKlB9R8UObCZMaixGTdMdutdyD
 HQpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9gILja1GBxYyHlu93EhZBIeEHxatV8i5KEx18EJ3MTEEJIMIiQFCRsFCUhz4wzmzQNH4Ibi+998wg@nongnu.org
X-Gm-Message-State: AOJu0YxgjcUlh/VdDjoPVEt96rKYmhaamBAocbX5As9rRymWasSPXhdb
 rF91g0Xs4/3sG7pPWIP8SO6UOdWwbA/B0AColuqeZxf846ziHAxQxuhGsmHoz3BREr3mU0SS5hq
 hcWm8u56MCqks+K7c4zVz6z+2bE8CSZN9ae3MMxwA0+4CoXUMLHnwJ1Ri
X-Gm-Gg: ATEYQzyI9OZBf5IvdIXo1yOo8Jfy6icyL7q7yG0PDy4HMpLUnaLDSYCUgklp1tWOVb9
 FjTUYZmiVz0zEEYIM2rcwmWErf04q7nQRgI4PwNCQujbK/iBktNTt9J7mgGuWUeFafoTf6rQ9Mr
 JpwUUU83ocbC2M2P5JHAPEvSaREyvxy+f3v/TmVGXbwUfcHksMBWqoWMTN8Flet6awbDCbFSdzC
 at3Xn/MmvF85gEjEpLADtxABctnHfAcZ8rzK1ebDNHlSbsMs6KQwpvMCI1NfwtoihavEavCyBq9
 4GsweYF4sgpPI2lPGPhnRJGp+wyQQdDUHJcg/SXKPbVbbfe404/iuH+F+Ato00ReQpQxOaNIEqa
 vfrVX0kO7hjSxyp01jpw=
X-Received: by 2002:a05:600d:8:b0:487:575:5e1 with SMTP id
 5b1f17b1804b1-488835b7615mr114945155e9.24.1775134939761; 
 Thu, 02 Apr 2026 06:02:19 -0700 (PDT)
X-Received: by 2002:a05:600d:8:b0:487:575:5e1 with SMTP id
 5b1f17b1804b1-488835b7615mr114944665e9.24.1775134939230; 
 Thu, 02 Apr 2026 06:02:19 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a626100sm121638675e9.1.2026.04.02.06.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 06:02:18 -0700 (PDT)
Message-ID: <988641b4-9e93-40eb-9742-63d8c1e17547@redhat.com>
Date: Thu, 2 Apr 2026 15:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1 00/10] Deprecate the qemu-system-i386 binary
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260402095132.29245-1-thuth@redhat.com>
 <CAFEAcA8EyCn83zEcysm=4Py-BsQKSBV0KcBUMjMm4Df-pF2BoA@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8EyCn83zEcysm=4Py-BsQKSBV0KcBUMjMm4Df-pF2BoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 02/04/2026 13.20, Peter Maydell wrote:
> On Thu, 2 Apr 2026 at 10:52, Thomas Huth <thuth@redhat.com> wrote:
>>
>> This is a follow-up to my 3-years old patch series here, now with the
>> universal binary initiative in mind:
>>
>>   https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg04541.html
>>
>> This patch series allows to run qemu-system-x86_64 in 32-bit-only mode
>> (by renaming or symlinking the binary to "qemu-system-i386" or something
>> similar with a "-i386" suffix). After doing this, qemu-system-x86_64
>> should be a full superset of qemu-system-i386 (apart from 32-bit KVM
>> support, which however is not required anymore now that we removed support
>> for 32-bit hosts). It is now possible to migrate a guest that has been
>> started with an old "qemu-system-i386" binary to a qemu-system-x86_64
>> binary that has been renamed with a "-i386" suffix.
> 
> I think my reaction here is similar to what it has been when
> the similar idea has been raised for qemu-system-arm : we should
> have a coordinated plan that is considering all architectures,
> not just dropping a single binary for one architecture where
> it happens to be more straightforward.

Sure, I'm open for suggestions ... how should that coordinated plan look like?
Maybe we could simply stop adding new versioned machine types to the 32-bit 
flavor binaries, and then let the old machine types expire? And when there 
is no versioned machine type left anymore, we could remove the 32-bit binaries?

  Thomas


