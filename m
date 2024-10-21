Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA029D0E6C5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 17:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2w6d-00065P-Ur; Mon, 21 Oct 2024 13:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2w6c-00064c-KP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:22:10 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2w6a-0003E1-PL
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:22:10 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ea7ad1e01fso3166045a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729531327; x=1730136127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5OW56k7KvY/23/GJp3eCSB5coR+Ix4KDvh+wl5fZXnQ=;
 b=gRHfNowDiAfeI6+U/aYdQzzaw2TweOQ0HE6RYlGZXREmpO98Fu2G6nYZ5NqEB6xfz0
 nl65kjYgN07EJzHYkxz9oasVZaW/d1lD+tHxM6GomY1AvV7YjaUa/kGv1klcfi9vr3gY
 1OWQuHbgsNOiKFj3DPKyrVS0kD7Mvg7VCx38yl3sSgQz+48CEMPREQa5ypn3GUXR3RYJ
 3zPW5QKBwhO+EPedO3BTouytxbvDxQHN5nGx6HAlMkVVBs1Tdo0Sgir0tM6KIPdNeS3u
 AtBslvww84QhqmRYDlRjbtIYLtppAQsLl/GmflRWfedli1XK0rm05s3Y+CFSdYf3Flxl
 5HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729531327; x=1730136127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5OW56k7KvY/23/GJp3eCSB5coR+Ix4KDvh+wl5fZXnQ=;
 b=lMdRRZz166NE8XnL0b8ArQJHrgfDsfzIbYhGzSnBX2uBgR7vRzJcjDSQ+JZeGnImv8
 VCv2+tAsOOPUfcSXGNHzeGFhIAHOPXOimm2NhBMzYOelmqa8JwQzx86YcoKFOufnCwzx
 TrozL0KUNFlQ+iFtK+QmxXf7M6AahmqgbmDf1tLn2qVkT4w5oge5Im7Zjp6QrE92HYhx
 NFFheN3suQRToOaTQqt5agAqZLX0rnO4t2IbSEKSju4ZK6VzxrxPBy4ugrDGptbwEaBf
 jBH4oxIZPKDMdtenKqLmg1dghyZV8F/kpy1j+LmVZuaqDiL9x+Wyf/DQ3/t/fgdD91Yx
 ag7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUinDGIBCfjoKxjOExybyhtoq6IBEvsqavFDj1eJo463yFXpr60L6bDO4od41bDJdRh6dYdC1wvtl0T@nongnu.org
X-Gm-Message-State: AOJu0YxXAz9k52zmb9gaWvWcCToeiobqn0g9HCqIuZyYyQfskFvVW3Jl
 soJUBeX3XgW01f08aEGa+nY6VA87oqWVMNm/T9wZ5KOmeE8Sig+LqcoZpFUY4gA=
X-Google-Smtp-Source: AGHT+IEMRhrh+pjY96rFHN0sjBXmqmK2rUQtJo1tx3NiX++/H9ga/81BlRofTky1YrNpBI/SFX3M7w==
X-Received: by 2002:a05:6a21:998d:b0:1d4:e40b:3de6 with SMTP id
 adf61e73a8af0-1d96c437553mr482676637.16.1729531325973; 
 Mon, 21 Oct 2024 10:22:05 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeabddfd1sm3341461a12.84.2024.10.21.10.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 10:22:05 -0700 (PDT)
Message-ID: <1d24b1bd-0272-49d0-a9eb-9179462f22c1@linaro.org>
Date: Mon, 21 Oct 2024 10:22:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Remove unused CPUMIPSState::current_fpu field
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Aleksandar Rikalo
 <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241021151253.36443-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241021151253.36443-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

T24gMTAvMjEvMjQgMDg6MTIsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBU
aGUgJ2N1cnJlbnRfZnB1JyBmaWVsZCBpcyB1bnVzZWQgc2luY2UgY29tbWl0IGYwMWJlMTU0
NTg5DQo+ICgiTW92ZSB0aGUgYWN0aXZlIEZQVSByZWdpc3RlcnMgaW50byBlbnYgYWdhaW4s
IGFuZCB1c2UgbW9yZQ0KPiBUQ0cgcmVnaXN0ZXJzIHRvIGFjY2VzcyB0aGVtIikuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+DQo+IC0tLQ0KPiAgIHRhcmdldC9taXBzL2NwdS5oICAgICAgICAgICAgfCAxIC0N
Cj4gICB0YXJnZXQvbWlwcy9zeXNlbXUvbWFjaGluZS5jIHwgMiArLQ0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvdGFyZ2V0L21pcHMvY3B1LmggYi90YXJnZXQvbWlwcy9jcHUuaA0KPiBpbmRleCA2
YTRjNGVhNjgzYS4uM2MyMzVmMzlmZmMgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9taXBzL2Nw
dS5oDQo+ICsrKyBiL3RhcmdldC9taXBzL2NwdS5oDQo+IEBAIC01MzAsNyArNTMwLDYgQEAg
dHlwZWRlZiBzdHJ1Y3QgQ1BVQXJjaFN0YXRlIHsNCj4gICAgICAgQ1BVTUlQU0ZQVUNvbnRl
eHQgYWN0aXZlX2ZwdTsNCj4gICANCj4gICAgICAgdWludDMyX3QgY3VycmVudF90YzsNCj4g
LSAgICB1aW50MzJfdCBjdXJyZW50X2ZwdTsNCj4gICANCj4gICAgICAgdWludDMyX3QgU0VH
QklUUzsNCj4gICAgICAgdWludDMyX3QgUEFCSVRTOw0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0
L21pcHMvc3lzZW11L21hY2hpbmUuYyBiL3RhcmdldC9taXBzL3N5c2VtdS9tYWNoaW5lLmMN
Cj4gaW5kZXggOTFjZDlmMTkwMDIuLjhhZjExZmQ4OTZiIDEwMDY0NA0KPiAtLS0gYS90YXJn
ZXQvbWlwcy9zeXNlbXUvbWFjaGluZS5jDQo+ICsrKyBiL3RhcmdldC9taXBzL3N5c2VtdS9t
YWNoaW5lLmMNCj4gQEAgLTI0Miw3ICsyNDIsNyBAQCBjb25zdCBWTVN0YXRlRGVzY3JpcHRp
b24gdm1zdGF0ZV9taXBzX2NwdSA9IHsNCj4gICANCj4gICAgICAgICAgIC8qIENQVSBtZXRh
c3RhdGUgKi8NCj4gICAgICAgICAgIFZNU1RBVEVfVUlOVDMyKGVudi5jdXJyZW50X3RjLCBN
SVBTQ1BVKSwNCj4gLSAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LmN1cnJlbnRfZnB1LCBN
SVBTQ1BVKSwNCj4gKyAgICAgICAgVk1TVEFURV9VTlVTRUQoc2l6ZW9mKHVpbnQzMl90KSks
IC8qIHdhcyBjdXJyZW50X2ZwdSAqLw0KPiAgICAgICAgICAgVk1TVEFURV9JTlQzMihlbnYu
ZXJyb3JfY29kZSwgTUlQU0NQVSksDQo+ICAgICAgICAgICBWTVNUQVRFX1VJTlRUTChlbnYu
YnRhcmdldCwgTUlQU0NQVSksDQo+ICAgICAgICAgICBWTVNUQVRFX1VJTlRUTChlbnYuYmNv
bmQsIE1JUFNDUFUpLA0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBsaW5hcm8ub3JnPg0K

