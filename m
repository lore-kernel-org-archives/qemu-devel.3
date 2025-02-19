Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61218C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 19:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkpkJ-0006ya-DP; Wed, 19 Feb 2025 14:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tkpkI-0006yI-7S
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 14:28:34 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tkpkG-0003L7-7s
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 14:28:33 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso3194715ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 11:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739993310; x=1740598110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y8qFNOJCSSM15gz+34oqzZxpU1C4/gMczfNovDPOQSc=;
 b=mqVpSieMZeltmD5AjptEhIO4zL7q907p6ijfn+99+WjcGcvvkuAabqTnXqD8K0EuoG
 ISBf22Lwh9f23U84UdOicc61LCpT0CtxXk/lCsGoUqfLOahSbxNMXDeTRmIOppgjEnfO
 i6w0FJ9b1e4VT/4F2FM0vcs3OUdh1V+xDevIADpSk//HsLAEWZP7jVPoXzUIC8awoM1y
 szuk08J1HHSSd7/pqRPD7tqkJ1P+3cCXxL2+rDUFE5t8ogZihblmoDBm+xZDuJcfZeKx
 LePXgEq/N6np4IQ5q7MINNDN2fzeGU7LHuXD0TX9rdgwhW8sTl8zMdTIWMWjxHYeFMKp
 x/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739993310; x=1740598110;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y8qFNOJCSSM15gz+34oqzZxpU1C4/gMczfNovDPOQSc=;
 b=wYpEEQ4cTQ9Gy4OhdFPR9WxtvwyaIvJwaaujXN8vAASmI9df1hRQws4gYXAzp7oxTS
 7Z1xx7WSr7+71TaCDYKtQov99sH2ojZ08dwfagHUyG9II39BSotpgfE2pvNaDlSdQegB
 jWX/z2qJNgKWSGdaQvyP3Jk63hN3U84wk5R97UKAQofuy9N8N6H+scDwqDZ6aTYLHvd6
 vWttLKTlclBPRWWkvl1IKf+bvJfx24ZSUGt467zLr7LgZEng5yHI+ARojaS80j5qbz4J
 LN0013nmUV114FVj48G6j6+kU9q6A/oQDMwo5GhPjuf5jC2uyOfHVwC3iXcRkX+Gfa5r
 CNUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWqME8Kz3PCqlV4Bb4Hl/FVCzxcLnlR/eD+ytUXU2hRsbFplpsj/rLbO1Tfe0nyUbw8cTI6/t9vD5q@nongnu.org
X-Gm-Message-State: AOJu0YyBFbK3doDbQXyUDET3201pc5/FuaURbW8QsvaE9I5Fdz5MXxbe
 9wzCbxXe7vC5UfxitDuPRgX/yR6maMbc8OZNKfPIYMKzP+mIUc/r8UFwjRyupXo=
X-Gm-Gg: ASbGnctDWToLgvGLJxeAiLukAumz2OzZBMtRqvE2qHWO/YsVUfeNMs7TTK5fAASSjOA
 M3BiErNQhoYiD7H1tZz0Sx75e89oECM10sIfZxU07rrO3RMAmHt3OCbMv0k4Bk+LqbZnPi7mHiZ
 2xbOQ/XVYw833T3g6RYaXhA6GXqpIBhkQ7Rwk7LzQGSbkLXrq1by73sQSGnSJut0n5PZ92Nfemx
 n0ghLgWZUb1jsrxlFTJ7VtS47uynwb+Bse9yb+4As2Iw2//whOWcu8m2G5dYd9q6CW+HptuP6r9
 u7PR4NMtltuxWa9lMlPKyPj8h4EW
X-Google-Smtp-Source: AGHT+IEP2iu5q4c9Wi0B3UxFEniYrn/JHLn9UHDL9hfngIQxOR7jJsKiLHcw94+Eh7CUisM6chpr5g==
X-Received: by 2002:a17:902:d54e:b0:21f:3d0d:2408 with SMTP id
 d9443c01a7336-2218c3e3876mr8310185ad.10.1739993308726; 
 Wed, 19 Feb 2025 11:28:28 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2210005641dsm80027525ad.210.2025.02.19.11.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 11:28:28 -0800 (PST)
Message-ID: <6159c3ef-c2b4-48cf-b853-5b02be7d013b@linaro.org>
Date: Wed, 19 Feb 2025 11:28:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: Introduce the dso_suffix() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Yonggang Luo <luoyonggang@gmail.com>
References: <20250219192340.92240-1-philmd@linaro.org>
 <20250219192340.92240-2-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250219192340.92240-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gMi8xOS8yNSAxMToyMywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IElu
dHJvZHVjZSBhIGhlbHBlciB0byBnZXQgdGhlIGRlZmF1bHQgc2hhcmVkIGxpYnJhcnkNCj4g
c3VmZml4IHVzZWQgb24gdGhlIGhvc3QuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFBpZXJyaWNr
IEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4gU2lnbmVkLW9mZi1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0N
Cj4gICB0ZXN0cy9mdW5jdGlvbmFsL3FlbXVfdGVzdC9fX2luaXRfXy5weSB8IDIgKy0NCj4g
ICB0ZXN0cy9mdW5jdGlvbmFsL3FlbXVfdGVzdC9jbWQucHkgICAgICB8IDYgKysrKysrDQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL3FlbXVfdGVzdC9fX2luaXRfXy5w
eSBiL3Rlc3RzL2Z1bmN0aW9uYWwvcWVtdV90ZXN0L19faW5pdF9fLnB5DQo+IGluZGV4IDVj
OTcyODQzYTZkLi5lMjUzMjg4ZWU3ZiAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvZnVuY3Rpb25h
bC9xZW11X3Rlc3QvX19pbml0X18ucHkNCj4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9xZW11
X3Rlc3QvX19pbml0X18ucHkNCj4gQEAgLTgsNyArOCw3IEBADQo+ICAgDQo+ICAgZnJvbSAu
YXNzZXQgaW1wb3J0IEFzc2V0DQo+ICAgZnJvbSAuY29uZmlnIGltcG9ydCBCVUlMRF9ESVIN
Cj4gLWZyb20gLmNtZCBpbXBvcnQgaXNfcmVhZGFibGVfZXhlY3V0YWJsZV9maWxlLCBcDQo+
ICtmcm9tIC5jbWQgaW1wb3J0IGlzX3JlYWRhYmxlX2V4ZWN1dGFibGVfZmlsZSwgZHNvX3N1
ZmZpeCwgXA0KPiAgICAgICBpbnRlcnJ1cHRfaW50ZXJhY3RpdmVfY29uc29sZV91bnRpbF9w
YXR0ZXJuLCB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4sIFwNCj4gICAgICAgZXhlY19jb21t
YW5kLCBleGVjX2NvbW1hbmRfYW5kX3dhaXRfZm9yX3BhdHRlcm4sIGdldF9xZW11X2ltZywg
d2hpY2gNCj4gICBmcm9tIC50ZXN0Y2FzZSBpbXBvcnQgUWVtdUJhc2VUZXN0LCBRZW11VXNl
clRlc3QsIFFlbXVTeXN0ZW1UZXN0DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFs
L3FlbXVfdGVzdC9jbWQucHkgYi90ZXN0cy9mdW5jdGlvbmFsL3FlbXVfdGVzdC9jbWQucHkN
Cj4gaW5kZXggZGM1ZjQyMmI3N2QuLmM0NzA0ZGZiN2JjIDEwMDY0NA0KPiAtLS0gYS90ZXN0
cy9mdW5jdGlvbmFsL3FlbXVfdGVzdC9jbWQucHkNCj4gKysrIGIvdGVzdHMvZnVuY3Rpb25h
bC9xZW11X3Rlc3QvY21kLnB5DQo+IEBAIC0xNCw2ICsxNCwxMiBAQA0KPiAgIGltcG9ydCBs
b2dnaW5nDQo+ICAgaW1wb3J0IG9zDQo+ICAgaW1wb3J0IG9zLnBhdGgNCj4gK2ltcG9ydCBw
bGF0Zm9ybQ0KPiArDQo+ICtkZWYgZHNvX3N1ZmZpeCgpOg0KPiArICAgICcnJ1JldHVybiB0
aGUgZHluYW1pYyBsaWJyYXJpZXMgc3VmZml4IGZvciB0aGUgY3VycmVudCBwbGF0Zm9ybScn
Jw0KPiArICAgIERTT19TVUZGSVhFUyA9IHsgJ0xpbnV4JzogJ3NvJywgJ0Rhcndpbic6ICdk
eWxpYicsICdXaW5kb3dzJzogJ2RsbCcgfQ0KPiArICAgIHJldHVybiBEU09fU1VGRklYRVNb
cGxhdGZvcm0uc3lzdGVtKCldDQo+ICAgDQo+ICAgDQo+ICAgZGVmIHdoaWNoKHRvb2wpOg0K
DQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5h
cm8ub3JnPg0KDQo=

