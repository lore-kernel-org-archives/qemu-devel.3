Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E1DC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 19:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkplW-0007ZQ-6Q; Wed, 19 Feb 2025 14:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tkplS-0007XV-Nw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 14:29:46 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tkplQ-0003ZI-Rq
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 14:29:46 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220e6028214so2218385ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739993383; x=1740598183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=keEcohK3FJbRcCjxXYNoeSAw4NC9k7I88wLDRW8cdbM=;
 b=gP6/SX8KrBEJNCxRlK633Atu6m5tL3sv7CxIxk2ZMrXuh6s3HUTMPQvQkIFXc2GvvO
 AaXyHaiAWrbNx908HM4iSCbEhIkFUUtfBFIQNp7quuCX7OVLEkBjSrWCKcIi6iOWGm+k
 sJzBbe3Kvp+5rayvopT3XW9eznPjH5u5oeZ/iBVLdPR0zhO5dTCTfQ4ZAgTWEsUHw56Z
 SrMLWwxhr5H7nWY2mlIXVVvS2hp9fx7Pt9L3H0ofgb98A1TcYUWjvd4Uf9C791d02KWC
 51lGnvXOszrO0eldHjjDz1uGTl2dVx5IP4KE0aBbWzxgcBoZLe4rC5lkW0Fp22xf3fZc
 /pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739993383; x=1740598183;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=keEcohK3FJbRcCjxXYNoeSAw4NC9k7I88wLDRW8cdbM=;
 b=rOCf/88TF3kIH25ajeIT0vmlD0pytVSudG++qDaPhT1LtdJ/ZL4TOye2xwm+haB656
 w2EvO25K1EO4Mf4qAMUmEhT4UZ8VGgtrXRwHmnt7o602umUL6o2FDKCBjOxhMdyDnPSz
 QmSO1QySjC9QU7By502SkoNVQeEV6o+PNwmmGWki2soaAo4yIqwFV0ukpuLO46du9xTB
 Nfig8jx/pESM9tbbKF9N2ymoH1ApwrTAvw9yBNyNbVUa8GFyENp5T4gPEQzQHz67fImr
 qGRq5kKNp9+G+bPHXVV3vJocUaIQ+hrvKl6KcfH7Zj0VuFNfT/n8Kwi8dy48OGJSGmjL
 d1Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVjh5hEuPvuRC5HbQdboccCCfIoD7BrXLlZQtXLDks3hOOV+o1/doQl7tUyUqJ1iIgO1+2J/y+QEsQ@nongnu.org
X-Gm-Message-State: AOJu0Yyn6trT6hBRM6jdPEJlmRXGxXCHn19ob2qrcV+8lhnMkOFuFK0i
 8PirsDpKXR6LVx/7D6RZ6DHqHHMtMgcPecemrpiEx8p4uF7UX8L4vaiVreWs3UY=
X-Gm-Gg: ASbGncvqcJMWiZ3yzNv6rCn1ovA0VQPVeYWuaM3yfVs00b5Q17SHNWO6TtE9vm+fg7a
 g+wwFhQF+NKQ1Ad1BJq0utZz+DUk3Bmj7LECzi8Hf/Nq9oIrTj5wuUnlm+AhOFscVIwhSZ2aL/n
 9XPL0LzZI6p5QaJq55qFRIvSwxJmtwop9fPIdzObEbky6uPGPFibWr4qvKajwopplW3HqCGLvK6
 tWjkSvahqhW1xS5TIFrcv0J7Ba5xASRYEftYHIXY16ZZYeSRSaTSSr9JTYKFRKC3lN+iKCRO1+O
 XZzb4SELKxj56AYTjbZxxm3yJGS9
X-Google-Smtp-Source: AGHT+IFtpT9Bk5o5VUaiaqfo05n7Wp8UfowHiHoX1MqT7YTq3vUvwT2sP1w+m7Ox+zgNNVRF02GQRA==
X-Received: by 2002:a17:903:3a8d:b0:21f:3e2d:7d2e with SMTP id
 d9443c01a7336-22104057f00mr274146875ad.27.1739993383046; 
 Wed, 19 Feb 2025 11:29:43 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556da47sm108454395ad.187.2025.02.19.11.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 11:29:42 -0800 (PST)
Message-ID: <b038c55a-e069-4bf4-93ff-e88f066e7df7@linaro.org>
Date: Wed, 19 Feb 2025 11:29:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: Allow running TCG plugins tests on
 non-Linux/BSD hosts
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Yonggang Luo <luoyonggang@gmail.com>
References: <20250219192340.92240-1-philmd@linaro.org>
 <20250219192340.92240-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250219192340.92240-3-philmd@linaro.org>
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

T24gMi8xOS8yNSAxMToyMywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE5v
dCBhbGwgcGxhdGZvcm1zIHVzZSB0aGUgJy5zbycgc3VmZml4IGZvciBzaGFyZWQgbGlicmFy
aWVzLA0KPiB3aGljaCBpcyBob3cgcGx1Z2lucyBhcmUgYnVpbHQuIFVzZSB0aGUgcmVjZW50
bHkgaW50cm9kdWNlZA0KPiBkc29fc3VmZml4KCkgaGVscGVyIHRvIGdldCB0aGUgcHJvcGVy
IGhvc3Qgc3VmZml4Lg0KPiANCj4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11
LXByb2plY3QvcWVtdS8tL2lzc3Vlcy8yODA0DQo+IFN1Z2dlc3RlZC1ieTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPiBTdWdnZXN0ZWQtYnk6
IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4g
LS0tDQo+ICAgdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfdGNnX3BsdWdpbnMucHkg
fCAxMCArKysrKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL3Rl
c3RfYWFyY2g2NF90Y2dfcGx1Z2lucy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hYXJj
aDY0X3RjZ19wbHVnaW5zLnB5DQo+IGluZGV4IDdlOGJlYWNjODMzLi4zMDZlNDZjNzk3MiAx
MDA3NTUNCj4gLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfdGNnX3BsdWdp
bnMucHkNCj4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfdGNnX3BsdWdp
bnMucHkNCj4gQEAgLTE2LDcgKzE2LDcgQEANCj4gICBpbXBvcnQgcmUNCj4gICANCj4gICBm
cm9tIHFlbXUubWFjaGluZS5tYWNoaW5lIGltcG9ydCBWTUxhdW5jaEZhaWx1cmUNCj4gLWZy
b20gcWVtdV90ZXN0IGltcG9ydCBMaW51eEtlcm5lbFRlc3QsIEFzc2V0DQo+ICtmcm9tIHFl
bXVfdGVzdCBpbXBvcnQgTGludXhLZXJuZWxUZXN0LCBBc3NldCwgZHNvX3N1ZmZpeA0KPiAg
IA0KPiAgIA0KPiAgIGNsYXNzIFBsdWdpbktlcm5lbEJhc2UoTGludXhLZXJuZWxUZXN0KToN
Cj4gQEAgLTYyLDYgKzYyLDEwIEBAIGNsYXNzIFBsdWdpbktlcm5lbE5vcm1hbChQbHVnaW5L
ZXJuZWxCYXNlKToNCj4gICAgICAgICAgICgnaHR0cHM6Ly9zdG9yYWdlLnR1eGJvb3QuY29t
LzIwMjMwMzMxL2FybTY0L0ltYWdlJyksDQo+ICAgICAgICAgICAnY2U5NWE3MTAxYTVmZWNl
YmUwZmU2MzBkZWVlNmJkOTdiMzJiYTQxYmM4NzU0MDkwZTlhZDg5NjFlYTg2NzRjNycpDQo+
ICAgDQo+ICsgICAgZGVmIHBsdWdpbl9maWxlKHNlbGYsIHBsdWdpbl9uYW1lKToNCj4gKyAg
ICAgICAgc3VmZml4ID0gZHNvX3N1ZmZpeCgpDQo+ICsgICAgICAgIHJldHVybiBmJ3Rlc3Rz
L3RjZy9wbHVnaW5zL3twbHVnaW5fbmFtZX0ue3N1ZmZpeH0nDQo+ICsNCj4gICAgICAgZGVm
IHRlc3RfYWFyY2g2NF92aXJ0X2luc24oc2VsZik6DQo+ICAgICAgICAgICBzZWxmLnNldF9t
YWNoaW5lKCd2aXJ0JykNCj4gICAgICAgICAgIHNlbGYuY3B1PSdjb3J0ZXgtYTUzJw0KPiBA
QCAtNzQsNyArNzgsNyBAQCBkZWYgdGVzdF9hYXJjaDY0X3ZpcnRfaW5zbihzZWxmKToNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Vm
Zml4PSIubG9nIikNCj4gICANCj4gICAgICAgICAgIHNlbGYucnVuX3ZtKGtlcm5lbF9wYXRo
LCBrZXJuZWxfY29tbWFuZF9saW5lLA0KPiAtICAgICAgICAgICAgICAgICAgICAidGVzdHMv
dGNnL3BsdWdpbnMvbGliaW5zbi5zbyIsIHBsdWdpbl9sb2cubmFtZSwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgc2VsZi5wbHVnaW5fZmlsZSgnbGliaW5zbicpLCBwbHVnaW5fbG9nLm5h
bWUsDQo+ICAgICAgICAgICAgICAgICAgICAgICBjb25zb2xlX3BhdHRlcm4pDQo+ICAgDQo+
ICAgICAgICAgICB3aXRoIHBsdWdpbl9sb2cgYXMgbGYsIFwNCj4gQEAgLTEwMCw3ICsxMDQs
NyBAQCBkZWYgdGVzdF9hYXJjaDY0X3ZpcnRfaW5zbl9pY291bnQoc2VsZik6DQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN1ZmZpeD0i
LmxvZyIpDQo+ICAgDQo+ICAgICAgICAgICBzZWxmLnJ1bl92bShrZXJuZWxfcGF0aCwga2Vy
bmVsX2NvbW1hbmRfbGluZSwNCj4gLSAgICAgICAgICAgICAgICAgICAgInRlc3RzL3RjZy9w
bHVnaW5zL2xpYmluc24uc28iLCBwbHVnaW5fbG9nLm5hbWUsDQo+ICsgICAgICAgICAgICAg
ICAgICAgIHNlbGYucGx1Z2luX2ZpbGUoJ2xpYmluc24nKSwgcGx1Z2luX2xvZy5uYW1lLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgY29uc29sZV9wYXR0ZXJuLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgYXJncz0oJy1pY291bnQnLCAnc2hpZnQ9MScpKQ0KPiAgIA0KDQpSZXZp
ZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3Jn
Pg0K

