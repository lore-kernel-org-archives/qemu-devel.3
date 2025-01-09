Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73125E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 18:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxZj-00083G-9l; Thu, 09 Jan 2025 13:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVxZi-000836-Aq
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:48:10 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVxZg-0005Fr-HM
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:48:09 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so1929506a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 10:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736448486; x=1737053286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NQdCrRejvwZeYsPkqnnhAbyN8ZD2I87hYKfg7l5ayUE=;
 b=ukthqzq8KJyKA9tzH71R3AN4RT3gyJWcqyji7LobQ0vX4VDLQMSCQ1cGh6Djk11RW+
 BsQeRYTZGtih5kUnahLxDPubVHeXwHeS8a/u1RPc0+RmuH4jNsIuqA+t31rSLrU6drYe
 eNHM3XHezr3wZr3tDd9y5Zy0ptIABdEc5jKc12CtMzh2mZu3405qc8p5W9n6D+T4+oKP
 bWpqCFrFtoHN4mJBIFOvey+2dqWrAMcYXjqIAV0GsjKZm0w7mxYBFQ3T5+9fMKLAbBIR
 9SZkQU3+z0wKq4FZsOapaaSZDv8LWC6aEbcwOqKah3rYgocOw/TVbeFiB41mavHrPShA
 D63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736448486; x=1737053286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NQdCrRejvwZeYsPkqnnhAbyN8ZD2I87hYKfg7l5ayUE=;
 b=uPQN0tPgiyec2CI++u8c1MQy/FNVJoDczalsmw3zKSIeP6uFTje08PusbxMFGAsbw3
 pPzu9+966I519a1+63+jn067eoBG1fu7IB74dMSLr/fKXFDBZBQBY46vLu63L2p+8OGm
 nlMCtK5IqnwnFAGIkqT1lfWVYsqXdtCctwoo1vmxbwyqN5ZBRr7I0VtgFRp9qrDML4Pi
 Yyb6u/spG+jdj55mFQTHpwnPbGBXBdGLnKVtJIwdWp5yRLTaLmXnGvd87yK64yVWENQh
 7yQ/HQYdrmR3cc8wXxxnfLAQMibutZIi2XBGS5cWH1C1UoM4aDqV9fc44fceT8bcmxPZ
 1JoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB5xz0W0rPvS/WMmY32TgI2VfjYXJ5PePk5paffCDYEFSbrAcVmivxQfWmNZH3gEo8++3sE+Fn+YZ4@nongnu.org
X-Gm-Message-State: AOJu0YyVuihNW6h7jszHks2SXbpcwcPfi7S8icnTy8De55c3nOERRT07
 qRTFnePLe2a7B+JP7WgGOib4CRw5miWLqgz9G+G1gWTJ8tUj4ADxg/L/XoRHdMA=
X-Gm-Gg: ASbGnctfxWDLJj5Gw6k+RgS/m1SaNi9Cmv3SHUmZrhFa+gpAa47QgHDd8EPzP5A8+g5
 1ebZRcZWIy+wUW4X7NXaV5JRx1F516/ohokNv+LvuB0DJIOtbRXcH/f+bBhcQjJKeaUaOueWd4H
 bbbDhIpNCDm/55HlgQj2RrfiXmf5aRoHGf2tm+ZxPwNqCOOBHiw1NtQhW5dSRR6JhpfKUcZpW/j
 AwxDNNWeMTorocbs6hp08xoGkgQ2ufO84c2L/VSQHvqnVpaRQ7iae/uAXlXXi8Js7jj8Q==
X-Google-Smtp-Source: AGHT+IGUGSmOA8Nt6u5IwBqhDhDVWadb6osL2pxQ69u7SE5gVC3V2Mr8BjyNEvF4zRtkOfVeOH88Mg==
X-Received: by 2002:a17:90a:e706:b0:2ee:cbd0:4910 with SMTP id
 98e67ed59e1d1-2f5583139d7mr5018598a91.1.1736448486165; 
 Thu, 09 Jan 2025 10:48:06 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f5593feab5sm1816167a91.14.2025.01.09.10.48.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 10:48:05 -0800 (PST)
Message-ID: <c87dbb31-9ab4-4132-baaa-18eed0607bb4@linaro.org>
Date: Thu, 9 Jan 2025 10:48:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] accel/tcg: also suppress asynchronous IRQs for
 cpu_io_recompile
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Julian Ganz <neither@nut.email>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-23-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250109170619.2271193-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

T24gMS85LzI1IDA5OjA2LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFdoaWxlIGl0IHdvdWxk
IGJlIHRlY2huaWNhbGx5IGNvcnJlY3QgdG8gYWxsb3cgYW4gSVJRIHRvIGhhcHBlbiAoYXMN
Cj4gdGhlIG9mZmVuZGluZyBpbnN0cnVjdGlvbiBuZXZlciByZWFsbHkgY29tcGxldGVkKSBp
dCBtZXNzZXMgdXANCj4gaW5zdHJ1bWVudGF0aW9uLiBXZSBhbHJlYWR5IHRha2UgY2FyZSB0
byBvbmx5IHVzZSBtZW1vcnkNCj4gaW5zdHJ1bWVudGF0aW9uIG9uIHRoZSBibG9jaywgd2Ug
c2hvdWxkIGFsc28gc3VwcHJlc3MgSVJRcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXgg
QmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gQ2M6IFJpY2hhcmQgSGVuZGVy
c29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPiBDYzogSnVsaWFuIEdhbnog
PG5laXRoZXJAbnV0LmVtYWlsPg0KPiAtLS0NCj4gICBhY2NlbC90Y2cvdHJhbnNsYXRlLWFs
bC5jIHwgNSArKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwvdGNnL3RyYW5zbGF0ZS1h
bGwuYyBiL2FjY2VsL3RjZy90cmFuc2xhdGUtYWxsLmMNCj4gaW5kZXggNDUzZWIyMGVjOS4u
ZDU2Y2ExM2NkZCAxMDA2NDQNCj4gLS0tIGEvYWNjZWwvdGNnL3RyYW5zbGF0ZS1hbGwuYw0K
PiArKysgYi9hY2NlbC90Y2cvdHJhbnNsYXRlLWFsbC5jDQo+IEBAIC02MzMsOSArNjMzLDEw
IEBAIHZvaWQgY3B1X2lvX3JlY29tcGlsZShDUFVTdGF0ZSAqY3B1LCB1aW50cHRyX3QgcmV0
YWRkcikNCj4gICAgICAgICogRXhpdCB0aGUgbG9vcCBhbmQgcG90ZW50aWFsbHkgZ2VuZXJh
dGUgYSBuZXcgVEIgZXhlY3V0aW5nIHRoZQ0KPiAgICAgICAgKiBqdXN0IHRoZSBJL08gaW5z
bnMuIFdlIGFsc28gbGltaXQgaW5zdHJ1bWVudGF0aW9uIHRvIG1lbW9yeQ0KPiAgICAgICAg
KiBvcGVyYXRpb25zIG9ubHkgKHdoaWNoIGV4ZWN1dGUgYWZ0ZXIgY29tcGxldGlvbikgc28g
d2UgZG9uJ3QNCj4gLSAgICAgKiBkb3VibGUgaW5zdHJ1bWVudCB0aGUgaW5zdHJ1Y3Rpb24u
DQo+ICsgICAgICogZG91YmxlIGluc3RydW1lbnQgdGhlIGluc3RydWN0aW9uLiBBbHNvIGRv
bid0IGxldCBhbiBJUlEgc25lYWsNCj4gKyAgICAgKiBpbiBiZWZvcmUgd2UgZXhlY3V0ZSBp
dC4NCj4gICAgICAgICovDQo+IC0gICAgY3B1LT5jZmxhZ3NfbmV4dF90YiA9IGN1cnJfY2Zs
YWdzKGNwdSkgfCBDRl9NRU1JX09OTFkgfCBuOw0KPiArICAgIGNwdS0+Y2ZsYWdzX25leHRf
dGIgPSBjdXJyX2NmbGFncyhjcHUpIHwgQ0ZfTUVNSV9PTkxZIHwgQ0ZfTk9JUlEgfCBuOw0K
PiAgIA0KPiAgICAgICBpZiAocWVtdV9sb2dsZXZlbF9tYXNrKENQVV9MT0dfRVhFQykpIHsN
Cj4gICAgICAgICAgIHZhZGRyIHBjID0gY3B1LT5jYy0+Z2V0X3BjKGNwdSk7DQoNClRoYW5r
cyBmb3IgdGhlIGZpeCBBbGV4LCBJIGNvbmZpcm0gaXQgc29sdmVkIHRoZSBpc3N1ZSBvYnNl
cnZlZCB3aXRoIA0KZGlzY29uIHBsdWdpbiB3aXRoIGFhcmNoNjQgZ3Vlc3QuDQoNClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+
DQoNCg==

