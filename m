Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64040C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnCa-0006cA-Ee; Mon, 24 Mar 2025 15:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnCX-0006aT-Go
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:11:09 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnCV-0003Cf-Sx
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:11:09 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224191d92e4so92396915ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742843466; x=1743448266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2xVmnCxZJP4ygbC4A2PJ1N+7INPfeCLpfcW+TcE8zr0=;
 b=HXEMNrvePPETihbxlfuS7sHmN2XBY7w1BzLup32w6hVmUkHpvX9fyiNSjFd2iReXaM
 gZFcqC1TfqWqbCb6GqWwfUJeWYVK7ny4CPHMte24cSNiEEs/pwU1CkJtjXtPdcIfsOS7
 KZaKpLtsL7JAv6NDVc29NZqoiEg0G+GBzKsWbF8jEu3YtKxPzTy70Njb0YP8Q05K1Lxa
 lEz2JKm7kWNRsUdYiV8Szb6iDE9ZWWuZ9NF45iBBDsjiIp8IU+qSIu0P+VF4wD0As4qM
 xxQTCNmmtzPGHG2IF2KLsvXTXGiqjuupNEsmqfB6LUEzyjRU1Y7Py5ANRFqxMv5LKUhj
 SggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742843466; x=1743448266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2xVmnCxZJP4ygbC4A2PJ1N+7INPfeCLpfcW+TcE8zr0=;
 b=JCZYdaGq8Vh+9CCjC+6MApS2SkK/I8FxUgxBqnkdnn3w5V+iRUEX9kbJfrnjNzJKHh
 mN6ZyAPOOiQF8kZYqAC3j7hbgEhSovhmeX1F6BoLHGyfLKPEdfBGcMdmtvZ0MAlCQV2i
 VvojeNSJnZ+PtbZiUaiTSESwmbDqIBn3RKNY9Dj3bKRfBm6Y1sEJfVVRPPXa7bh5NQKR
 rYF1i4r4fay6B6W4MAqCK+mCwalVpW23lXiBU1+NaeliRI9/RxZp4sWwtKxjIeSeJ5Nq
 9tS46qdiC737txjTwM6DbFi+HZMEbccvRn/FFOGb0iunbeqEWoiMFLFdPSjyoM60nWep
 vfkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6XBGqRGwWBnnUFqATgzFO/S8Sj5cEOGGbwn6RpHtxwvWM42ZT52vhf3Pz7KlqZ+Q4EnOLHSW71GSI@nongnu.org
X-Gm-Message-State: AOJu0YwNMEgRlBlLlbGXDiWyDl4Fk28b7exPsh7Jb+JApJCYz0b4E17a
 jrIcNf4KpC6KbHlQlW7iCqKwhCUeYBKxbAhYnei+C0k/inZj9vCU7tMEFmUz3Qk=
X-Gm-Gg: ASbGncsgN0lIUkQnTX52ZIgfFyqCvCdljXnsgcuhyP7L2RbRREq6jDXbTiJPUBP0Ol2
 9SQ0T+sU4R2PHC0NHybyuhrxU57oqpT2K6d5iPmFt8eAwMKaS+zMIMSVKbFzhgm8Ru8T/08rg05
 2YgkOc3SxyCrJmkaL8ff6UJ3pVWnyeoYE6VGn4WMLgpcdvIZW/z3yp2lS059gyloUl7dAEzG9N2
 B4ECNr3HDR9bqIkw3sa0/YmCAasGUSU3TLLRnQg26huscvQgnNks0H8ZmJ7SxMz49n20OXSXtDt
 /9zx6UipqOnHrVa2a3uGOcQdUA7GsiQa7E8wfhM4HPmIs2nsC5Hr6y02GA==
X-Google-Smtp-Source: AGHT+IHhPWLdYfjAxijNWXaYSdLRs8IHHkcTrZU0+P39u2W4KQV+NC9aL99hESpTQ0VimI57MJWSEg==
X-Received: by 2002:a17:90b:1f86:b0:2fe:baa3:b8b9 with SMTP id
 98e67ed59e1d1-3030fe552b6mr20409869a91.4.1742843466281; 
 Mon, 24 Mar 2025 12:11:06 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5d4e46sm8612035a91.14.2025.03.24.12.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:11:05 -0700 (PDT)
Message-ID: <5ac2becc-a8eb-4b88-aad1-47937cd9b953@linaro.org>
Date: Mon, 24 Mar 2025 12:11:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] include/gdbstub: fix include guard in commands.h
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-3-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250324102142.67022-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gMy8yNC8yNSAwMzoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBSZXZpZXdlZC1ieTog
UGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPiBSZXZp
ZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0K
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+
DQo+IC0tLQ0KPiAgIGluY2x1ZGUvZ2Ric3R1Yi9jb21tYW5kcy5oIHwgMiArLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvZ2Ric3R1Yi9jb21tYW5kcy5oIGIvaW5jbHVkZS9nZGJzdHVi
L2NvbW1hbmRzLmgNCj4gaW5kZXggNDBmMDUxNGZlOS4uYmZmMzY3NDg3MiAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9nZGJzdHViL2NvbW1hbmRzLmgNCj4gKysrIGIvaW5jbHVkZS9nZGJz
dHViL2NvbW1hbmRzLmgNCj4gQEAgLTEsNSArMSw1IEBADQo+ICAgI2lmbmRlZiBHREJTVFVC
X0NPTU1BTkRTX0gNCj4gLSNkZWZpbmUgR0RCU1RVQg0KPiArI2RlZmluZSBHREJTVFVCX0NP
TU1BTkRTX0gNCj4gICANCj4gICB0eXBlZGVmIHZvaWQgKCpHZGJDbWRIYW5kbGVyKShHQXJy
YXkgKnBhcmFtcywgdm9pZCAqdXNlcl9jdHgpOw0KPiAgIA0KDQpSZXZpZXdlZC1ieTogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

