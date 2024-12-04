Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6DFE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwmA-00011S-BX; Wed, 04 Dec 2024 16:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIwlz-00010f-DI
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:19:03 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIwlx-0001fO-I5
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:19:03 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-215d92702feso1537675ad.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733347140; x=1733951940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KTI/9IucZaFGkqc/5+leBrgyKsFBq4ZbaCj+m4V8J4g=;
 b=xyim2TqZJbVNGYfvFh/umAACy6DbTCcph3eSvczVcj6znbMbHV58szeJimeKnvaJ2M
 4h140WGhq2DfirFyNO2SJJ7xPK3CcIjfHSjTl/U2uRKA2T7Y2ExIdxLVaclXEzGzq5Fx
 e8gwQStE64Mj246bT8SBHUCYGIIrKBeqsP8kv7HTJ/rJvmOOgcKMWgcDU8TymakEGfVo
 evGYNxfY7epSqgycWCuMg6mA4SMVrke5gf8Aemh2RWrrpKB80/zs4AVIuXlgSLTFzS7C
 5CoRfebhHXfPtX913vt1lNgafIl7o3uG0LDI/yP4Vy/bn1j01cO+ciW+ukFfWU1bG+UV
 UbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733347140; x=1733951940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KTI/9IucZaFGkqc/5+leBrgyKsFBq4ZbaCj+m4V8J4g=;
 b=ZzSrYPRKrDolzToX7jELnGF1rjHX+KQwKfSPiHOK6lX+glySLXvCOBeMrl1GwQL8A7
 rWg/RlZyf3A6nTX7/0xKZmQ35J9PdzrbUeLKz6Jl5binmJpQmIKT1N5zk79+3Dh/V3Pv
 ZL3huo/EBJBwS5AzJh2J0d6QRwt7SYcGk5XsMffKYuho/lfbjYimF89ASTal6n+kazpr
 laTnRa9i/k8IpY3h4fwTfE3ly64nqtA2juqO7LT+mmCIBO+sve7nV6xcXOugeswGvEFk
 70zBerJ3HeYNCUjTTEdfjJCy2p/FNzF07w75uPwrD+QMlsYoLFHcc4gU9uLI01U0vX+3
 xuGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBShoXZpVrhNENq450zRjCE6Wn5iZKeVs54Xa9aqEhtfJCmG7QbmRLfnOML77mVJmvm/YHkTk6TaHq@nongnu.org
X-Gm-Message-State: AOJu0YyJBrE3SQTSOygRdIAczv0D5udFCceLQ1nOVFBVUNzV+s7P00b0
 WvQZEu/Q3B30SYdvK9ORdadl1rmbQhOHrVFFOAddON12CXSDm9zKoapuVAJ7HPI=
X-Gm-Gg: ASbGncsE7+T8mGGnVw8p9l6REDV6XUFlc/3wnIExW4m2Iu3bOI9qpHjE+b4dSBbPcCc
 oVvWWlk75Yvz0TWPSKUfivMjOmPSmEcZt/rbABBaicOwZxw4yoZMlbImS7YuvgphrGXRtRhM+Tb
 w15TmFUTDfthPLDH2SbkT1YIz4r+zkQP8+qTxiruYTiWQHGXxAV8agANzU+1sRfvxBNyC2Y1Mn5
 mG31FAgK+zOb/F4FTxFXhskhtoNaWH/3ZqDMvWqHiU7AksDMRouuLTTYsJgLh9B800k3pU00HeH
 6xUIdAtHafMCBbAS1+wg3A==
X-Google-Smtp-Source: AGHT+IFEw5UsjE5viUhJF2jEt2kwVQ4wsRUxV/+qoZjSH5H7JmN9QbQjZK3oNY+4urJnHu+PYYZiuA==
X-Received: by 2002:a17:903:1790:b0:215:96bc:b681 with SMTP id
 d9443c01a7336-215bd17a9c8mr109614425ad.52.1733347139960; 
 Wed, 04 Dec 2024 13:18:59 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254176f77dsm12805278b3a.53.2024.12.04.13.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 13:18:59 -0800 (PST)
Message-ID: <e1e78252-4f6f-4a2e-a980-f5fcd9a5f783@linaro.org>
Date: Wed, 4 Dec 2024 13:18:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/sbsa-ref: Require at least 2 GiB of RAM when
 RME feature enabled
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
References: <20241204205607.62592-1-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241204205607.62592-1-philmd@linaro.org>
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

T24gMTIvNC8yNCAxMjo1NiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFdl
IGFyZSB3b3JraW5nIG9uIGFkZGluZyBSTUUgc3VwcG9ydCB0byBTQlNBIFJlZmVyZW5jZSBQ
bGF0Zm9ybS4NCj4gV2hlbiBSTUUgaXMgZW5hYmxlZCB0aGVuIFJNTSAoUmVhbG0gTWFuYWdt
ZW50IE1vbml0b3IpIHRha2VzIDEwNzJNQiBvZg0KPiBtZW1vcnkgZm9yIG93biB1c2UuIFdo
aWNoIGVuZHMgd2l0aCBmaXJtd2FyZSBwYW5pYyBvbiAxR0IgbWFjaGluZS4NCj4gDQo+IFJl
cG9ydCBhbiBlcnJvciBzbyB1c2VycyBkaXJlY3RseSBzdGFydCB3aXRoIG1vcmUgUkFNIGlu
IHRoaXMgY2FzZToNCj4gDQo+ICAgICQgcWVtdS1zeXN0ZW0tYWFyY2g2NCAtTSBzYnNhLXJl
ZiAtbSAxRyAtY3B1IG1heCx4LXJtZT1vbg0KPiAgICBxZW11LXN5c3RlbS1hYXJjaDY0OiBz
YnNhLXJlZjogUk1FIGZlYXR1cmUgcmVxdWlyZXMgYXQgbGVhc3QgMkdCIG9mIFJBTQ0KPiAN
Cj4gUmVwb3J0ZWQtYnk6IE1hcmNpbiBKdXN6a2lld2ljeiA8bWFyY2luLmp1c3praWV3aWN6
QGxpbmFyby5vcmc+DQo+IFN1Z2dlc3RlZC1ieTogTGVpZiBMaW5kaG9sbSA8bGVpZi5saW5k
aG9sbUBvc3MucXVhbGNvbW0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiB2MTogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MTEyNjA4NDkyOC4yNTIwNjctMS1tYXJj
aW4uanVzemtpZXdpY3pAbGluYXJvLm9yZy8NCj4gLS0tDQo+ICAgaHcvYXJtL3Nic2EtcmVm
LmMgfCA3ICsrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3Nic2EtcmVmLmMgYi9ody9hcm0vc2JzYS1yZWYu
Yw0KPiBpbmRleCBlMzE5NWQ1NDQ5Ny4uNjY3NTFkMDgwNmMgMTAwNjQ0DQo+IC0tLSBhL2h3
L2FybS9zYnNhLXJlZi5jDQo+ICsrKyBiL2h3L2FybS9zYnNhLXJlZi5jDQo+IEBAIC01MSw2
ICs1MSw3IEBADQo+ICAgI2luY2x1ZGUgInFhcGkvcW1wL3FsaXN0LmgiDQo+ICAgI2luY2x1
ZGUgInFvbS9vYmplY3QuaCINCj4gICAjaW5jbHVkZSAidGFyZ2V0L2FybS9jcHUtcW9tLmgi
DQo+ICsjaW5jbHVkZSAidGFyZ2V0L2FybS9jcHUtZmVhdHVyZXMuaCINCj4gICAjaW5jbHVk
ZSAidGFyZ2V0L2FybS9ndGltZXIuaCINCj4gICANCj4gICAjZGVmaW5lIFJBTUxJTUlUX0dC
IDgxOTINCj4gQEAgLTc5NSw2ICs3OTYsMTIgQEAgc3RhdGljIHZvaWQgc2JzYV9yZWZfaW5p
dChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ICAgICAgICAgICBvYmplY3RfdW5yZWYoY3B1
b2JqKTsNCj4gICAgICAgfQ0KPiAgIA0KPiArICAgIGlmIChjcHVfaXNhcl9mZWF0dXJlKGFh
NjRfcm1lLCBBUk1fQ1BVKHFlbXVfZ2V0X2NwdSgwKSkpDQo+ICsgICAgICAgICAgICAmJiBt
YWNoaW5lLT5yYW1fc2l6ZSA8IDIgKiBHaUIpIHsNCj4gKyAgICAgICAgZXJyb3JfcmVwb3J0
KCJzYnNhLXJlZjogUk1FIGZlYXR1cmUgcmVxdWlyZXMgYXQgbGVhc3QgMkdCIG9mIFJBTSIp
Ow0KPiArICAgICAgICBleGl0KDEpOw0KPiArICAgIH0NCj4gKw0KPiAgICAgICBtZW1vcnlf
cmVnaW9uX2FkZF9zdWJyZWdpb24oc3lzbWVtLCBzYnNhX3JlZl9tZW1tYXBbU0JTQV9NRU1d
LmJhc2UsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYWNoaW5lLT5y
YW0pOw0KPiAgIA0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0KDQo=

