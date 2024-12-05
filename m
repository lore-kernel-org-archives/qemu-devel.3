Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30B6E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFMM-0005U1-TL; Thu, 05 Dec 2024 12:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJFMM-0005Tk-5E
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:09:50 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJFMK-0007zh-FJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:09:49 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-72599fc764bso1134025b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733418587; x=1734023387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QdqjY5o7C6HfgDwgCxC48ptiE4t2cU+Jk0v9zUE/c9Q=;
 b=ts2iOx5QI/ruMqwzJyaQGLhMLt9FnpTg9ipRt7K5L6XrMwxhDeaWtaaTc+Hx0cRgiO
 29kryxPqS+d7X/3S8DDGgrvUA/U6eHrqFRBd2Q//mgnOfBongvwwuwk5KFU8qDRGoHjw
 PzzYVbMdKlA0FVChZrILjGYYGk90WzDiPzIlJwxZ11aFMvsSJjvoR/E+3ZZyDScnQ+Cf
 vaW36bY05QExIO9V8JAXtmR6fzqrvUt6x+UzJ4EMFIokDjYqr4S09l2v9Aj1Z5i1GqiA
 ScpPOIBDjAeHNzqE8GAIjfGUCIkg3iR/Vrc9nPyGmf2p8LzhA6SvkCVvcjjtDHowD5+Z
 gMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733418587; x=1734023387;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QdqjY5o7C6HfgDwgCxC48ptiE4t2cU+Jk0v9zUE/c9Q=;
 b=D7w05X2KOlLFXQvcB/GMoMAO0SpistutggayzXmdPemwpdAe1kakSaATu8wrjncXtq
 s1WNX1xOQxPjifQJgL5lx2Ave6SmaZV/ZbRlfafXBzc9Oo6TJ5nL8IjQiQ1WtDyq7gzg
 uqkg75IrYZ3FDJk3rReMazjodE6sjMusCkpydI1pNKTV0Zhva6vWDuRHd8jznVU2ZmH/
 Jo79zbmizRgv5+6CRaxqslERx7d/9pzNVEIGqcjXowy4xQdWpODg74aLrVt6SqOhESth
 mbxKV7Wy1+8psm7A4GXyiNc1tQqbca1e2FVF1ndmz7Amc++CGnxLHCiyxA2XBk5utsnv
 houA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh2RIWRWgAhrCYYief+82DTV8LVxUc9seAsBsIxxEgMVmdoC0UY3mpeoVnnM/nfKOIXrrjmtwSiEEP@nongnu.org
X-Gm-Message-State: AOJu0YyD8ZiANOxjEAKUACGdwdSjHRkeL6RzSqBGKwQyGax38DftImG9
 O2MZiTV/3lJvljz6eSwBoO/0DfLRWqZWnVaUMCWj1R4YwVka/McgoahQyEjyFMDPCQHduMSwy46
 qMmo=
X-Gm-Gg: ASbGncsrKPXfH6Tb5bakOdg2eorEtqTgM5mWeN6IXTWvX2X48cGYR3aqURWrV90I0HA
 V705B6uUx73SbdUV88LLYMhFe9m+QHhcmkCCN53AMKHT6UCY0JLOjgy/q1xRLCkdxesPTCx4V+O
 QQ6nqvyrAJ+hr0a1kcD02CXz3uYiEdXq+c0NnWBC3VgS7P89l63lcW92SQID1Qeq/w/OID7O2tZ
 /902ERbN4fxyh7wcYro1KktGhpmWEXqBYIFT1s+3bY2zOpEdCjHATuZNi8cuxNU8h2tSrPmV1tJ
 BXOYKpqxMVb2/xBfzLQriw==
X-Google-Smtp-Source: AGHT+IHyR+p/pw0t1FX5qmBmkXjMspSRbcz9tNGXpq8UQkzv+/9SOEzMuTlQCXsLstisueKplxlC9A==
X-Received: by 2002:a17:903:ca:b0:215:bd3e:613b with SMTP id
 d9443c01a7336-215f3cfb9dcmr45012905ad.27.1733418586967; 
 Thu, 05 Dec 2024 09:09:46 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e61ef7sm14977085ad.95.2024.12.05.09.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 09:09:46 -0800 (PST)
Message-ID: <3ba7dabb-67cf-450f-828c-5adf7332fc91@linaro.org>
Date: Thu, 5 Dec 2024 09:09:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] docs/system/arm/fby35: document execute-in-place
 property
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 alex.bennee@linaro.org, Alistair Francis <alistair@alistair23.me>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
 <20241204203912.3037515-3-pierrick.bouvier@linaro.org>
 <c2e4c538-2e0b-4882-8a92-6ff439cebd09@kaod.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c2e4c538-2e0b-4882-8a92-6ff439cebd09@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

T24gMTIvNS8yNCAwMDoxOCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+IEhlbGxvIFBp
ZXJyaWNrLA0KPiANCj4gVGhhbmtzIGZvciBpbXByb3ZpbmcgdGhlIGRvY3VtZW50YXRpb24g
IQ0KPiANCj4gT24gMTIvNC8yNCAyMTozOSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+
IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGlu
YXJvLm9yZz4NCj4+IC0tLQ0KPj4gICAgZG9jcy9zeXN0ZW0vYXJtL2ZieTM1LnJzdCB8IDMg
KysrDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2FybS9mYnkzNS5yc3QgYi9kb2NzL3N5c3RlbS9hcm0v
ZmJ5MzUucnN0DQo+PiBpbmRleCBiZjZkYTZiYWEyYS4uZWQ5ZmFlZjM2M2MgMTAwNjQ0DQo+
PiAtLS0gYS9kb2NzL3N5c3RlbS9hcm0vZmJ5MzUucnN0DQo+PiArKysgYi9kb2NzL3N5c3Rl
bS9hcm0vZmJ5MzUucnN0DQo+PiBAQCAtNDUsMyArNDUsNiBAQCBwcm9jZXNzIHN0YXJ0cy4N
Cj4+ICAgICAgICAkIHNjcmVlbiAvZGV2L3R0eTAgIyBJbiBhIHNlcGFyYXRlIFRNVVggcGFu
ZSwgdGVybWluYWwgd2luZG93LCBldGMuDQo+PiAgICAgICAgJCBzY3JlZW4gL2Rldi90dHkx
DQo+PiAgICAgICAgJCAocWVtdSkgYwkJICAgIyBTdGFydCB0aGUgYm9vdCBwcm9jZXNzIG9u
Y2Ugc2NyZWVuIGlzIHNldHVwLg0KPj4gKw0KPj4gK1RoaXMgbWFjaGluZSBtb2RlbCBzdXBw
b3J0cyBlbXVsYXRpb24gb2YgdGhlIGJvb3QgZnJvbSB0aGUgQ0VPIGZsYXNoIGRldmljZSBi
eQ0KPj4gK3NldHRpbmcgb3B0aW9uIGBgZXhlY3V0ZS1pbi1wbGFjZWBgLg0KPiANCj4gQ291
bGQgd2UgYWRkIGEgbGluayB0byB0aGUgIkJvb3Qgb3B0aW9ucyIgc2VjdGlvbiBvZiB0aGUN
Cj4gIkFzcGVlZCBmYW1pbHkgYm9hcmRzIiBkb2N1bWVudCBpbnN0ZWFkID8NCj4NCg0KVGhl
IHByb2JsZW0gaXMgdGhhdCB0aGUgYXNwZWVkIGJvYXJkIGhhcyBvdGhlciBvcHRpb25zIChm
bWMtbW9kZWwsIA0Kc3BpLW1vZGVsKSwgc28gaXQgd291bGQgYmUgY29uZnVzaW5nIGZvciB0
aGUgcmVhZGVyLg0KDQpJdCdzIHdvcnRoIHJlcGVhdGluZyB3aGF0IHRoZSBvcHRpb24gbWVh
bnMgSU1ITy4NCg0KPiBDLg0KDQo=

