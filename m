Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D59C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ljW-0003oH-Ta; Fri, 04 Apr 2025 14:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0ljK-0003k9-2X
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:25:27 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0ljD-00009i-Cb
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:25:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2295d78b433so24044125ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743791116; x=1744395916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pvay4Om/NSflNXjlH+EQjYUpj7sAqVl5jkaxsjONStw=;
 b=AuqIvMf4HgGx+HzjjHBJYxINpqeECkCMrGoE1e0ckwZ5Ex/L/uvTeRvRGIfL4NF9GS
 46Tt/ehBE8+mAWT3yHUwpDScNmENmXJIofTI2DNuNeMQt4llcO9ZcSP0WntNe6kHg1OZ
 tVkikymUlJ4Wvfm5pmhZ/LfjAfTT5vF24ZoXGnWkcyi7Wx6kA94sVmkiHm/W6AbY8uWD
 Pqmt+e4RFVp45vDw79dxFIqcBMU350XLfN03+daJ3TnExNXopEjak5iiEn+VOhHecWSe
 0DJ3J+YfKuK/32YOERdgF9Le/YQsQZze5sL6m02Bdxa4Lz0Yj9Hpvqdi/ohHcZqv+4tZ
 rpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743791116; x=1744395916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pvay4Om/NSflNXjlH+EQjYUpj7sAqVl5jkaxsjONStw=;
 b=RzUH4YAEzgz0UocjydwyBMZhQ9yULncsZ44C4MtBazD3EHdIUijlk9pbc8mSmucdMM
 C2/pp4Hy0mrgZlcKWJzR9PkadicLP7mOqxVBtonkG+IlwkYqaHYTuoao0cvkPrQcQzEr
 hEsEzolcziffPuWwsrVetAXI+nMmvcITISkekFGxlU4IaUgSUvPgpcOGZD00miozTMbZ
 JJ78459zNOuXLVzKCgojWvA5Lpg2S7/QKfJvvN3fOZx0+l6h1u01oyuFvG9r61OK/mHC
 ZN8Jgk2LxYuGnLrp6N4huU6O8HftS6vchkfm+W+5zw1LG6XtF9bdua90xq5958PlKgP9
 Phew==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1JJvE8GqhCfDcIeKwUKlWX06yKUW6yLHaLU7nABRNXE/iDggY+Pas3vSbyoMQaXHsdLOYr2zjQ/RK@nongnu.org
X-Gm-Message-State: AOJu0YzM5qy5orruGbNfZlPuzvaco4EruxajGBJXp382Yt2GjM7x0pRW
 CpwurMIvfmeXVO7nEJNnmdp+PtCIzBUyNHcjqTCDhM19LTwdnRaDDg4E8nblzcY=
X-Gm-Gg: ASbGnct9RXXMZO/iM2+djnbEdnPietTksuzo/tj45jwICnc4cNv2SRCXqc1aI8i2DLk
 nmE/GCGWMYZyPrOM5p8L0kBmyMoXmcVDnlSTd1DC2iZ2/422wZIq8ON53IzPsy6dJ7X+DwI427t
 fAxcdwksFSdqK2lSujua8m5cxnt5h8qqmXOYcFVp1QAGmQPwtmIkH+CCDqsuq6v1gzwQudoNV+4
 bLJqThEBysgtC2VWJRXNwZyP14OHMnAdnnU13pDAlGrI3uKzmSLxw9wqLHKcS4Txivf+1OlIWVo
 FzCQ+9ogR3XN26qvPKaiZPx3N14TMouPhkaNO9Tee00ggAmMelTFFaQK8w==
X-Google-Smtp-Source: AGHT+IGe0AGk3vAaqd/xJg6gz7tI/iZNR5A7GtxZi51Mg44cynvaGwXCiEgAJyMd8UtMPFf34aHKEw==
X-Received: by 2002:a17:902:e546:b0:21f:7880:8472 with SMTP id
 d9443c01a7336-22a8a0a297fmr63293045ad.35.1743791116371; 
 Fri, 04 Apr 2025 11:25:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c0148sm35788465ad.82.2025.04.04.11.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 11:25:15 -0700 (PDT)
Message-ID: <c1418cb6-1c92-4f7d-a4f8-85099fc2f6dc@linaro.org>
Date: Fri, 4 Apr 2025 11:25:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 28/39] exec: Do not poison hardware
 accelerators
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-29-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403235821.9909-29-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

T24gNC8zLzI1IDE2OjU4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gSGFy
ZHdhcmUgYWNjZWxlcmF0b3JzIGRlcGVuZHMgb24gdGhlIGhvc3QsIG5vdCB0aGUgZ3Vlc3Qu
DQo+IA0KDQpXaGlsZSB0aGlzIGlzIHRydWUsIG5vIHdlIGNhbid0IHVucG9pc29uIHRob3Nl
IGRlZmluZS4NClRoZXkgYXJlIGFwcGxpZWQgcGVyIHRhcmdldCwgYW5kIG5vdCBpbiBjb25m
aWctaG9zdC4gU28gdW5wb2lzb2luaW5nIA0KdGhlbSBvcGVucyB0aGUgcG9zc2liaWxpdHkg
dG8gbWlzcyBzb21ldGhpbmcuDQoNCkkgd291bGQgc3RpY2sgdG8gY2xlYW4gdXAgdGhvc2Ug
aWZkZWYgaW5zdGVhZCwgYnkgZXhwb3NpbmcgaW50ZXJmYWNlIHRvIA0KYWxsIGNvZGUsIGFu
ZCBsaW5rIGFwcHJvcHJpYXRlIHN0dWJzIGRlcGVuZGluZyBvbiB0aGUgdmFyaWFudCBidWls
dC4NCg0KPiBTdWdnZXN0ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvZXhlYy9wb2lz
b24uaCAgICAgICAgIHwgNCAtLS0tDQo+ICAgc2NyaXB0cy9tYWtlLWNvbmZpZy1wCW9pc29u
LnNoIHwgNCArKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL3BvaXNvbi5o
IGIvaW5jbHVkZS9leGVjL3BvaXNvbi5oDQo+IGluZGV4IDAwYWVkYzQxZDgyLi4wNTc0ZDY4
M2Y2YSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9leGVjL3BvaXNvbi5oDQo+ICsrKyBiL2lu
Y2x1ZGUvZXhlYy9wb2lzb24uaA0KPiBAQCAtNjIsMTEgKzYyLDcgQEANCj4gICAjcHJhZ21h
IEdDQyBwb2lzb24gQ09ORklHX1NQQVJDX0RJUw0KPiAgICNwcmFnbWEgR0NDIHBvaXNvbiBD
T05GSUdfWFRFTlNBX0RJUw0KPiAgIA0KPiAtI3ByYWdtYSBHQ0MgcG9pc29uIENPTkZJR19I
VkYNCj4gICAjcHJhZ21hIEdDQyBwb2lzb24gQ09ORklHX0xJTlVYX1VTRVINCj4gLSNwcmFn
bWEgR0NDIHBvaXNvbiBDT05GSUdfS1ZNDQo+IC0jcHJhZ21hIEdDQyBwb2lzb24gQ09ORklH
X1dIUFgNCj4gLSNwcmFnbWEgR0NDIHBvaXNvbiBDT05GSUdfWEVODQo+ICAgDQo+ICAgI2lm
bmRlZiBDT01QSUxJTkdfU1lTVEVNX1ZTX1VTRVINCj4gICAjcHJhZ21hIEdDQyBwb2lzb24g
Q09ORklHX1VTRVJfT05MWQ0KPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9tYWtlLWNvbmZpZy1w
b2lzb24uc2ggYi9zY3JpcHRzL21ha2UtY29uZmlnLXBvaXNvbi5zaA0KPiBpbmRleCAyYjM2
OTA3ZTIzOS4uMDlkMjM4NDc0NWYgMTAwNzU1DQo+IC0tLSBhL3NjcmlwdHMvbWFrZS1jb25m
aWctcG9pc29uLnNoDQo+ICsrKyBiL3NjcmlwdHMvbWFrZS1jb25maWctcG9pc29uLnNoDQo+
IEBAIC04LDYgKzgsMTAgQEAgZmkNCj4gICAjIGJ1dCBmaWx0ZXIgb3V0IHNldmVyYWwgd2hp
Y2ggYXJlIGhhbmRsZWQgbWFudWFsbHkuDQo+ICAgZXhlYyBzZWQgLW4gXA0KPiAgICAgLWUn
IC9DT05GSUdfVENHL2QnIFwNCj4gKyAgLWUnIC9DT05GSUdfSFZGL2QnIFwNCj4gKyAgLWUn
IC9DT05GSUdfS1ZNL2QnIFwNCj4gKyAgLWUnIC9DT05GSUdfV0hQWC9kJyBcDQo+ICsgIC1l
JyAvQ09ORklHX1hFTi9kJyBcDQo+ICAgICAtZSAnL0NPTkZJR19VU0VSX09OTFkvZCcgXA0K
PiAgICAgLWUgJy9DT05GSUdfU09GVE1NVS9kJyBcDQo+ICAgICAtZSAnL14jZGVmaW5lIC8g
eycgXA0KDQo=

