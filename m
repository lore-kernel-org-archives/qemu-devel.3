Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B147C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 01:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0rx2-0001iG-83; Fri, 04 Apr 2025 21:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0rwy-0001hY-Sp
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 21:03:57 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0rwx-0008Oi-1O
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 21:03:56 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-227d6b530d8so23663375ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 18:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743815033; x=1744419833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LxYJTeqZ8/SjKcsTVfhcfXUR1aNZKwdjZ1ATWqZQErU=;
 b=H6zeX4xZjm1ueBuSmJJ/tieieiiNiLn6XJR6dRJE7hRTMPe0doIhTBd8//1hiwZ6HO
 oZUvAnFIRFulA2Q8zE6iXijQyWhmCWH8z+ediCbZ0LMmnZ1xmNXFlOTZea4eXUR74vCC
 QIRl63mvpWM5ZkDciHcrkkCcr9BwMjdQiGGQLCpJJ394CFjdxRf1iv2yDjg5vgLGkbIf
 VVUx9ETaCEVtH+FNrwM9AqNmlR35+aIfkZmff6KTZY8ANS8whY/6zVXRd9zQWV7ZvOPq
 dFZVnhMTpbrMTjS5INs8fi+zvyUpe2K9yA7VgMwUPMAQTy3KYMWWwNuQbpOhyrfWyKt2
 KBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743815033; x=1744419833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LxYJTeqZ8/SjKcsTVfhcfXUR1aNZKwdjZ1ATWqZQErU=;
 b=QlEeurqm4o4aTdU5HSa6socxGjNdffmQvPcsuhwVjXbbCq0BRAgaQShcvB3Co3PpX5
 beJ134UNDS2gGVXgEx778qI0slZcuHUWaD20QLdD/olZg1IZCy5Rkxvkh9KlLZbcuY3v
 AyTowazroFTls8XZZxjbB+dKSr/Ej4PQGxs6JnGyHrmqK6GePzfYGGOolVr3nw8rPOmz
 Z2xuedvQr0TOJ5IBZR1UgkCZYYc+cNW3SV9I8YHCO4cP1UUvN7juijQK3MOGEkRZFdL2
 gp2SmvQWQ7lV9yw8RY6qtsU5Oisb3hRv6Rd9VqvwmCSgG51z+XFxYv4DFd2JBBFFMRUb
 XpAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAmWdzsP+ISvahujgTiiPdUZBMa6xjzMTT5/vjofsyGuNRkWP8ndDw8pS81K3OuoGXQeG6ZI+IMvzk@nongnu.org
X-Gm-Message-State: AOJu0YyjG3QOHihiemFbG28Ib626W17yQZwI9ExiaFwkvZXsVQBr3WQP
 ZdoYvYhF/f6hkjiAOQupcclfNCft7e+R98VLFyxEokvxG/OH+wbcxTFJpAp2PyA1FzWEThEZhEI
 E
X-Gm-Gg: ASbGncv1FX5d06y5FKer0QF6p9DpxO4KoXvTDHINQWwGBpsyN50WPbc2Vk49fWEbmg1
 oApzaoyikoNFrI8ly3sGtjeg60SdTRclOt9spjwBKxd4Oi8HwaclyVSwDb5P66YVNQy6t833hSA
 0YBLckhxWjANKv5fdWlrINcK4S5vTMbUygsy3I+noVF/bmYcWrS5kVnxkqMwcJYbOTc3eU/wtif
 Cm+i75NYzEaPi4Tp5hqNj8T7c7nP9IpVMzQNMGdPLfJ8A3d5SARUbJyRJupHKh/PMeTavk9vsYd
 YrTr9EjgQBn1H58k5gvO9GbBKfhTPVKtOIHExdhXiTPjTJBJbLrM7CwPBg==
X-Google-Smtp-Source: AGHT+IGXxYyheokAE3YE0Iubc441UJIB4O6TVXW4tQe3mOB/wtkftkV+Sbd8tfux9XzkumfjzkwNOg==
X-Received: by 2002:a17:903:2a88:b0:224:1074:63af with SMTP id
 d9443c01a7336-22a8a0a3963mr70483205ad.34.1743815033537; 
 Fri, 04 Apr 2025 18:03:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865e408sm38988685ad.144.2025.04.04.18.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 18:03:53 -0700 (PDT)
Message-ID: <04e14ec2-dbfc-4c92-b061-dd7108cd66f2@linaro.org>
Date: Fri, 4 Apr 2025 18:03:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 20/39] target/arm: Extract PSCI definitions
 to 'psci.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-21-philmd@linaro.org>
 <09bd795d-e62d-44fb-b80a-374efee32034@linaro.org>
 <49ff72e2-24ac-41a8-8aee-f923d9b48cee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <49ff72e2-24ac-41a8-8aee-f923d9b48cee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gNC80LzI1IDE0OjU0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
NC80LzI1IDIwOjIxLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gNC8zLzI1IDE2
OjU4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBFeHRyYWN0IFBTQ0kg
ZGVmaW5pdGlvbnMgKHdoaWNoIGFyZSBub3QgdGFyZ2V0IHNwZWNpZmljKQ0KPj4+IHRvIHRo
ZSBuZXcgInRhcmdldC9hcm0vcHNjaS5oIiwgc28gY29kZSBmcm9tIGh3L2FybS8gY2FuDQo+
Pj4gdXNlIHRoZW0gd2l0aG91dCBoYXZpbmcgdG8gaW5jbHVkZSB0aGUgdGFyZ2V0IHNwZWNp
ZmljDQo+Pj4gImNwdS5oIiBoZWFkZXIuDQo+Pj4NCj4+DQo+PiBJbmNsdWRpbmcgY3B1Lmgg
aXMgbm90IGEgcHJvYmxlbSB0byBoYXZlIGNvbW1vbiBjb2RlIChwZXIgYXJjaGl0ZWN0dXJl
KSwNCj4+IHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gZG8gYW55IGNoYW5nZSBoZXJlLg0KPiAN
Cj4gQWdhaW4sIHRoaXMgaXMgYW4gb2xkIHBhdGNoIGZyb20gbXkgaGV0ZXJvZ2VuZW91cyBQ
b0MgYnJhbmNoLg0KPiBJJ2xsIHJlbW92ZSBmcm9tIHRoaXMgc2VyaWVzIHRvIG5vdCBkaXN0
cmFjdCB5b3UuDQo+IA0KDQpJdCdzIG5vdCBkaXN0cmFjdGluZywgYnV0IHNpbXBseSBub3Qg
bmVlZGVkLg0KDQo+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4+PiBSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4+IC0tLQ0KPj4+ICDCoCBp
bmNsdWRlL2h3L2FybS9ib290LmjCoMKgwqDCoMKgIHzCoCAzICsrLQ0KPj4+ICDCoCB0YXJn
ZXQvYXJtL2NwdS5owqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYgLS0tLS0tDQo+Pj4gIMKg
IHRhcmdldC9hcm0vcHNjaS5owqDCoMKgwqDCoMKgwqDCoMKgIHwgMTggKysrKysrKysrKysr
KysrKysrDQo+Pj4gIMKgIGh3L2FybS9iYW5hbmFwaV9tMnUuY8KgwqDCoMKgwqAgfMKgIDEg
Kw0KPj4+ICDCoCBody9hcm0vYm9vdC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDEgKw0KPj4+ICDCoCBody9hcm0vaGlnaGJhbmsuY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MSArDQo+Pj4gIMKgIGh3L2FybS9pbXg4bXAtZXZrLmPCoMKgwqDCoMKgwqDCoCB8wqAgMSAr
DQo+Pj4gIMKgIGh3L2FybS9tY2lteDZ1bC1ldmsuY8KgwqDCoMKgwqAgfMKgIDEgKw0KPj4+
ICDCoCBody9hcm0vbWNpbXg3ZC1zYWJyZS5jwqDCoMKgwqAgfMKgIDEgKw0KPj4+ICDCoCBo
dy9hcm0vb3JhbmdlcGkuY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+Pj4gIMKgIGh3
L2FybS9zYnNhLXJlZi5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+PiAgwqAgaHcv
YXJtL3ZpcnQtYWNwaS1idWlsZC5jwqDCoCB8wqAgMSArDQo+Pj4gIMKgIGh3L2FybS92aXJ0
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+Pj4gIMKgIGh3L2FybS94
bG54LXZlcnNhbC12aXJ0LmPCoCB8wqAgMSArDQo+Pj4gIMKgIGh3L2FybS94bG54LXpjdTEw
Mi5jwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+PiAgwqAgaHcvdm1hcHBsZS92bWFwcGxlLmPC
oMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4+ICDCoCB0YXJnZXQvYXJtL2hlbHBlci5jwqDCoMKg
wqDCoMKgwqAgfMKgIDEgKw0KPj4+ICDCoCB0YXJnZXQvYXJtL2h2Zi9odmYuY8KgwqDCoMKg
wqDCoCB8wqAgMSArDQo+Pj4gIMKgIHRhcmdldC9hcm0vdGNnL29wX2hlbHBlci5jIHzCoCAx
ICsNCj4+PiAgwqAgdGFyZ2V0L2FybS90Y2cvcHNjaS5jwqDCoMKgwqDCoCB8wqAgMSArDQo+
Pj4gIMKgIDIwIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pDQo+Pj4gIMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvYXJtL3BzY2kuaA0KPiAN
Cg0K

