Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B86FC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7IU5-00086o-Of; Tue, 22 Apr 2025 14:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IU3-00086H-Tc
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:36:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IU1-00047W-IC
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:36:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227d6b530d8so57602595ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745346995; x=1745951795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oOYHUsbWD42mXPw1XZgIgezW5dIqJZVs5bzYLBbcpiw=;
 b=nIxhXuqIoZzAHThOVhnq62Poi4Bk04qQ05CF11hmotu3arTEIvrZeUI3Yyher0riQi
 Kn07py9olQR4Xk0aAcUrSVu+Lt2sxqoX4hOl1i7aEPQYUKGV85YTAKqdkoxs65tbTLmu
 8zemVrBLaP51cMfemcbp+CNsY91PdIKbDNJJuBP9m1Gdaq1aAkUES/zdRJZ/NAMkhokH
 87gbZuJ2ryMDRQOiVWxvohRbQ294mX2AiVHuBjjI0K//gM7tTPRZML3zJhzfyf3K/e2w
 lMVUH7ps5pL3zQr8+zB99PJidZldJzQXaNpuk7xAzL596OuSWdBWX0PxuZNJFbnNvyII
 QH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745346995; x=1745951795;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oOYHUsbWD42mXPw1XZgIgezW5dIqJZVs5bzYLBbcpiw=;
 b=BVVQJuLmdIqGRYVeMOfcHDrYPKbRiYDC8IEEShH9osCMBZQZrAn88VFCT997hpSqvU
 cKxJ7i8o9Ga7lI3y3DBqz2Zqe27CXd/CMJgMCyGf5RDn9lECO8nXwNEIpsxBUqWDsgCY
 I7EV0q5tiSJYUqt83O9ZByZegUap08PbVTAm8VJ+YHrPCk0/DriJXhiMZVkjaC0KMDz+
 WpvR1IotXnQB+dyDtUzdIcf8/vJK1kh8KxZOtuFBVvO4LkDojRqYWpwcZAWSzGXQedja
 ZbeJ93o1vDczdAP+/d4GsCU472wpKowhra0wF8BX1QZMYlDK9Mc9QdeHdFoUIIfdJ68n
 O20g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU76Szzar6o7dMxdrNKn12gSGM82u6NUpSE2IdrEog80lyhpWrK2eikAxAWr84vuHw3JnMM16TKCe2Q@nongnu.org
X-Gm-Message-State: AOJu0Yw7NjaK2X0PNpvtZTNJGag0GrMJ9idkAl0IOOmWAFBzA5+bQt/5
 miWsTUvUIg02GrEio2ZF5ThJJnbGgf1DB60+64KDCgdkr02/e2ZS1QJwBPtZlMM=
X-Gm-Gg: ASbGncv5M0mZfOOLlfch4T7rLS0zJRIIqkXpFei7hHicaH8jkBMDz7hN69Hu1VZxNzo
 a9Th5Bof8YYZ9yEVuZDaRAkJPbuLNx6IFUISUKY15HTvLqvJPWQKGT+4IfzrpEg5BheyVuAsnJg
 y6fX97wRdeeDHksGUM3q7F+K4z/jMczhD7o+zw/TJMSrtprbhzLQApC2dz62VxWSQfg/O/R86nP
 quaomoaWBtrZNpsRE7DxC6xBE/uskYHXyl7bcHmHYQPP0o0waUgqXE0P7psSpjtWZeA9YzYWVBo
 6HXp7R28YIj2ozG6bbyQfAV2qEChT2u+OMQ7OhzmF3BJt19nCj+lgnI5Ixov8Qnu
X-Google-Smtp-Source: AGHT+IF4uz+DeJY/nYR/Ec/VhBXK6cu0UPrc1fkRucNdPvNpEMiIOSDU3spXUWZrK41Qy+/jYDKkvg==
X-Received: by 2002:a17:902:e88f:b0:225:abd2:5e4b with SMTP id
 d9443c01a7336-22c53583dd1mr220689105ad.16.1745346995442; 
 Tue, 22 Apr 2025 11:36:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ecf33bsm88616085ad.191.2025.04.22.11.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:36:35 -0700 (PDT)
Message-ID: <7de6ad37-d62f-4e66-b660-034b69fb5938@linaro.org>
Date: Tue, 22 Apr 2025 11:36:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] buildsys: Disable 'unguarded-availability-new'
 warnings
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20250422171955.11791-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422171955.11791-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

T24gNC8yMi8yNSAxMDoxOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFdo
ZW4gdXNpbmcgVmlzdWFsIFN0dWRpbyBDb2RlICh2MS45OS4zKSBhbmQgQXBwbGUgY2xhbmdk
IHYxNy4wLjANCj4gSSBnZXQ6DQo+IA0KPiAgICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4v
Li4vcWFwaS9zdHJpbmctb3V0cHV0LXZpc2l0b3IuYzoxNDoNCj4gICAgcWVtdS9pbmNsdWRl
L3FlbXUvY3V0aWxzLmg6MTQ0OjEyOiBlcnJvcjogJ3N0cmNocm51bCcgaXMgb25seSBhdmFp
bGFibGUgb24gbWFjT1MgMTUuNCBvciBuZXdlciBbLVdlcnJvciwtV3VuZ3VhcmRlZC1hdmFp
bGFiaWxpdHktbmV3XQ0KPiAgICAgIDE0NCB8ICAgICByZXR1cm4gc3RyY2hybnVsKHMsIGMp
Ow0KPiAgICAgICAgICB8ICAgICAgICAgICAgXn5+fn5+fn5+DQo+ICAgIC9MaWJyYXJ5L0Rl
dmVsb3Blci9Db21tYW5kTGluZVRvb2xzL1NES3MvTWFjT1NYLnNkay91c3IvaW5jbHVkZS9f
c3RyaW5nLmg6MTk4Ojk6IG5vdGU6ICdzdHJjaHJudWwnIGhhcyBiZWVuIG1hcmtlZCBhcyBi
ZWluZyBpbnRyb2R1Y2VkIGluIG1hY09TIDE1LjQgaGVyZSwgYnV0IHRoZSBkZXBsb3ltZW50
IHRhcmdldCBpcyBtYWNPUyAxNS4wLjANCj4gICAgICAxOTggfCAgICAgICAgIHN0cmNocm51
bChjb25zdCBjaGFyICpfX3MsIGludCBfX2MpOw0KPiAgICAgICAgICB8ICAgICAgICAgXg0K
PiAgICBxZW11L2luY2x1ZGUvcWVtdS9jdXRpbHMuaDoxNDQ6MTI6IG5vdGU6IGVuY2xvc2Ug
J3N0cmNocm51bCcgaW4gYSBfX2J1aWx0aW5fYXZhaWxhYmxlIGNoZWNrIHRvIHNpbGVuY2Ug
dGhpcyB3YXJuaW5nDQo+ICAgICAgMTQ0IHwgICAgIHJldHVybiBzdHJjaHJudWwocywgYyk7
DQo+ICAgICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn4NCj4gICAgMSBlcnJvciBnZW5l
cmF0ZWQuDQo+IA0KPiBEaXNhYmxlIHRoaXMgLVd1bmd1YXJkZWQtYXZhaWxhYmlsaXR5LW5l
dyB3YXJuaW5nIGFzIGENCj4gc2hvcnQgdGVybSBiYW5kLWFpZCBmaXguDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+
DQo+IC0tLQ0KPiAgIG1lc29uLmJ1aWxkIHwgMiArKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29u
LmJ1aWxkDQo+IGluZGV4IDQxZjY4ZDM4MDY5Li41MzkzNjhmODJiMSAxMDA2NDQNCj4gLS0t
IGEvbWVzb24uYnVpbGQNCj4gKysrIGIvbWVzb24uYnVpbGQNCj4gQEAgLTczNSw2ICs3MzUs
NyBAQCB3YXJuX2ZsYWdzID0gWw0KPiAgICAgJy1Xc3RyaWN0LXByb3RvdHlwZXMnLA0KPiAg
ICAgJy1XdHlwZS1saW1pdHMnLA0KPiAgICAgJy1XdW5kZWYnLA0KPiArICAnLVd1bmd1YXJk
ZWQtYXZhaWxhYmlsaXR5JywNCj4gICAgICctV3ZsYScsDQo+ICAgICAnLVd3cml0ZS1zdHJp
bmdzJywNCj4gICANCj4gQEAgLTc0Nyw2ICs3NDgsNyBAQCB3YXJuX2ZsYWdzID0gWw0KPiAg
ICAgJy1Xbm8tc3RyaW5nLXBsdXMtaW50JywNCj4gICAgICctV25vLXRhdXRvbG9naWNhbC10
eXBlLWxpbWl0LWNvbXBhcmUnLA0KPiAgICAgJy1Xbm8tdHlwZWRlZi1yZWRlZmluaXRpb24n
LA0KPiArICAnLVduby11bmd1YXJkZWQtYXZhaWxhYmlsaXR5LW5ldycsDQo+ICAgXQ0KPiAg
IA0KPiAgIGlmIGhvc3Rfb3MgIT0gJ2RhcndpbicNCg0KSSBzb2x2ZWQgaXQgdGhlIHNhbWUg
d2F5IGxvY2FsbHksIGJ1dCBkaWRuJ3Qgc2VuZCBhIHBhdGNoIGJlY2F1c2UgSSdtIA0Kbm90
IHN1cmUgd2hhdCBoYXBwZW5zIGlmIHRoZSBjb2RlIHJ1bnMgb24gTWFjT1MgPCAxNS40LCBh
bmQgSSBkb24ndCBoYXZlIA0Kc3VjaCBhIG1hY2hpbmUgYXZhaWxhYmxlLg0KDQpJcyB0aGUg
c3ltYm9sIGFscmVhZHkgdGhlcmU/DQpEb2VzIGl0IGNyYXNoPw0KSSBndWVzcyB0aGUgd2Fy
bmluZyBpcyBoZXJlIGZvciBhIGdvb2QgcmVhc29uLg0KDQpZb3UgY2FuIGZpbmQgYSBsb3Qg
b2YgaXNzdWVzIG9wZW4gaW4gdmFyaW91cyBvcGVuIHNvdXJjZSBwcm9qZWN0cyB3aXRoIA0K
dGhpcyB3YXJuaW5nICh3aXRoIHZhcmlvdXMgZml4ZXMpIHNpbmNlIHRoaXMgdXBkYXRlIHdh
cyByZWxlYXNlZC4NCg==

