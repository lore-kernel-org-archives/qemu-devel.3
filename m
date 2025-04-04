Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BB2C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZz-0003E4-IN; Fri, 04 Apr 2025 13:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZQ-0002Os-On
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:13 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZM-0005pJ-DC
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:06 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso1836012a91.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786662; x=1744391462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dlXs6fTN5u+ePlOjOTVZP9nOfYET9DgJZEsLb7Qh1mY=;
 b=JJoFWM6zVqmS98Psy57JztRt5Ulio32uwNiapsqFy4U0XiMbrB0jC61wQuKUqd+leG
 glMsaiKbyuW4+SjuY0qk+W944faW09ikNcmmNo12SGV1s4zM0W8m4HlL0pDaDqFX8w5W
 ZePn9GJCupIZ+y/eQ4HdFaLWJKPMma75E9lNv6ugEYMCMd5me3ElGERZ/KuxBaobJ6jb
 yr1fOFwabl7G1Hax/vtwEp1lkIhCvh+LmltVUWXCFJXr3TwnXlpSjIYmJtX6VPQBkDyv
 X+/JlsNvMEKRxzcWm7PKpurVUj9Cdxm7nEQq2OkUJR6H+i4aySDHrPGcbR/TfBkhMoAg
 ysrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786662; x=1744391462;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dlXs6fTN5u+ePlOjOTVZP9nOfYET9DgJZEsLb7Qh1mY=;
 b=ADdCVETqmbdfpkeZNh7pvrMz3pNb7PisnN3npwHxbpCgs/aAfV+YYuxx7BPWzQRf0Q
 hKFM0jEJ2G58Zw/q7MbtNmQ+hNpUbIi7sajYhWFrCQ07YWKN8WJWsIcxodcaIvZBsxkv
 J0TmSIzpEI+lG2KRu9vY5QGXriMa+IyHQhBTsEvFjrWmX8PXG7LEoOvTqevbekkA+AwO
 kSk9IATIEwIczBHOSxyE2O3VIsKizGM+X3xSt31n50uFFjn9PFhcGfhHdwemO1bqXiuK
 aOWcQFVDw7XFMu1YqVl09NiZVC4XgXyqrMzgDnJzeMc5XldV1mMxg3KclbBgbu3vaIoH
 Q7Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFPlRz0/hGw6YFkaaMvsIAJz3SjGdd7c9WJ53gZy6L3EJAyzgxzt3mwBeOHINMA9nkJZj2ffRWK2FC@nongnu.org
X-Gm-Message-State: AOJu0YzB9io8cY2EkV7ER2SJ+LwRt/wCKHpN8fCYEP9w2KlhcAe0yiHj
 si8c40/C5zD5E77z+o5qReZkMxZ6bS9ZezXMfiDcPT231ApJ9dLNyCydk1XmCGg=
X-Gm-Gg: ASbGncsmAmkJqMZlOHLnQtxAN2n+UyDBKIT7jQncazsWKtDYIeeD/1t7cc8gXXM8pvP
 mjaGigrGJHgQZk+KGLKxnZVNYZFEmLp1sLQ5bCUAn+Jds8murergu5KM24TR7XKOxEbhUKoPj3H
 ouSjb5juR2nppuoWPMBXVo8tJf/7/20meqUScUhwIcLPdRcWhupDLNG5CEdxJHvc9HvexNTkhMA
 gg3PyREvMwbNU3+9ReCLYzMPYAwAbEXzeKLL6LdIq5gSvbmiNZ083G1dKSdpVrnAK1x5d/0QZ5E
 Kbx/lPDuJqoJJEwptUdYRhVqDiVDxbx5L9ddBnPu5HyAt6vrXyQlsOqzLQ==
X-Google-Smtp-Source: AGHT+IHTr1eZAhfas9SO+BxZxhFU5KSV4N1peh4JE//mlosEK96g6qagV41pZMGYJ+kjwt6zEeAXYw==
X-Received: by 2002:a17:90b:4b8d:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-306a4836ed6mr5880632a91.5.1743786662444; 
 Fri, 04 Apr 2025 10:11:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca498c6sm4357416a91.13.2025.04.04.10.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:11:02 -0700 (PDT)
Message-ID: <aca0c957-1187-4b60-8093-eb7f0fb4f96f@linaro.org>
Date: Fri, 4 Apr 2025 10:04:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 18/19] qemu: Prepare per-binary QOM filter
 via TYPE_BINARY_PREFIX
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-19-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

T24gNC8zLzI1IDE2OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+
ICAgaW5jbHVkZS9ody9ib2FyZHMuaCAgICAgICAgICAgIHwgIDEgKw0KPiAgIGluY2x1ZGUv
cWVtdS90YXJnZXRfaW5mby1xb20uaCB8IDE0ICsrKysrKysrKysrKysrDQo+ICAgdGFyZ2V0
X2luZm8tcW9tLmMgICAgICAgICAgICAgIHwgMTUgKysrKysrKysrKysrKysrDQo+ICAgNCBm
aWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1xb20uaA0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0YXJnZXRfaW5mby1xb20uYw0KPiANCj4gZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIv
bWVzb24uYnVpbGQNCj4gaW5kZXggZGU5YzlkYWNkMzUuLmI5MzI1MzE2NmM4IDEwMDY0NA0K
PiAtLS0gYS9tZXNvbi5idWlsZA0KPiArKysgYi9tZXNvbi5idWlsZA0KPiBAQCAtMzgxNSw2
ICszODE1LDcgQEAgc3BlY2lmaWNfc3MuYWRkKGZpbGVzKCdwYWdlLXRhcmdldC5jJywgJ3Bh
Z2UtdmFyeS10YXJnZXQuYycpKQ0KPiAgIA0KPiAgIHNwZWNpZmljX3NzLmFkZChmaWxlcygn
dGFyZ2V0X2luZm8tc3R1Yi5jJykpDQo+ICAgY29tbW9uX3NzLmFkZChmaWxlcygndGFyZ2V0
X2luZm8uYycpKQ0KPiArc3lzdGVtX3NzLmFkZChmaWxlcygndGFyZ2V0X2luZm8tcW9tLmMn
KSkNCj4gICANCj4gICBzdWJkaXIoJ2JhY2tlbmRzJykNCj4gICBzdWJkaXIoJ2Rpc2FzJykN
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYm9hcmRzLmggYi9pbmNsdWRlL2h3L2JvYXJk
cy5oDQo+IGluZGV4IDAyZjQzYWM1ZDRkLi5iMWJiZjNjMzRkNCAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9ody9ib2FyZHMuaA0KPiArKysgYi9pbmNsdWRlL2h3L2JvYXJkcy5oDQo+IEBA
IC03LDYgKzcsNyBAQA0KPiAgICNpbmNsdWRlICJzeXN0ZW0vaG9zdG1lbS5oIg0KPiAgICNp
bmNsdWRlICJzeXN0ZW0vYmxvY2tkZXYuaCINCj4gICAjaW5jbHVkZSAicWFwaS9xYXBpLXR5
cGVzLW1hY2hpbmUuaCINCj4gKyNpbmNsdWRlICJxZW11L3RhcmdldF9pbmZvLXFvbS5oIg0K
PiAgICNpbmNsdWRlICJxZW11L21vZHVsZS5oIg0KPiAgICNpbmNsdWRlICJxb20vb2JqZWN0
LmgiDQo+ICAgI2luY2x1ZGUgImh3L2NvcmUvY3B1LmgiDQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3FlbXUvdGFyZ2V0X2luZm8tcW9tLmggYi9pbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8t
cW9tLmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAuLmM4
N2Q0N2FjZjY2DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5jbHVkZS9xZW11L3Rhcmdl
dF9pbmZvLXFvbS5oDQo+IEBAIC0wLDAgKzEsMTQgQEANCj4gKy8qDQo+ICsgKiBRRU1VIGJp
bmFyeSBoZWxwZXJzDQo+ICsgKg0KPiArICogIENvcHlyaWdodCAoYykgTGluYXJvDQo+ICsg
Kg0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4g
KyAqLw0KPiArDQo+ICsjaWZuZGVmIFFFTVVfVEFSR0VUX0lORk9fUU9NX0gNCj4gKyNkZWZp
bmUgUUVNVV9UQVJHRVRfSU5GT19RT01fSA0KPiArDQo+ICsjZGVmaW5lIFRZUEVfTEVHQUNZ
X0JJTkFSWV9QUkVGSVggImxlZ2FjeS1iaW5hcnktIg0KPiArDQoNCkhvdyBhYm91dCBUWVBF
X1RBUkdFVF9QUkVGSVggaW5zdGVhZD8NCkl0J3Mgbm90IHJlbGF0ZWQgdG8gYW55IGxlZ2Fj
eSBzdHVmZiwgYXMgdGhlIG5ldyBBUEkgd2lsbCBiZSB1c2VkIGluIHRoZSANCmZ1dHVyZSAo
YW5kIHdpbGwgc3RheSkuIEFzIHdlbGwsIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIG1lbnRp
b24gDQoiYmluYXJ5IiBpbiBhbnkgbmFtZSwgYmVjYXVzZSB3aGF0IHdlIHJlYWxseSB0YWxr
IGFib3V0IGFyZSB0YXJnZXRzIA0Ke3VzZXJ8c3lzdGVtLCBhcmNoaXRlY3R1cmV9LCBpbiB0
aGUgbWVhbmluZyBvZiBvdXIgYnVpbGQgc3lzdGVtIA0KKGNvbmZpZ3VyZSAtLXRhcmdldC1s
aXN0KS4NCg0KU28gcGxlYXNlIHJlcGxhY2UgW2xlZ2FjeSwgYmluYXJ5XSB3aXRoIHRhcmdl
dCBzaW1wbHksIHNvIHdlIGtlZXAgYSBzYW5lIA0Kdm9jYWJ1bGFyeSBpbiB0aGUgZnV0dXJl
Lg0KDQo+ICsjZW5kaWYNCj4gZGlmZiAtLWdpdCBhL3RhcmdldF9pbmZvLXFvbS5jIGIvdGFy
Z2V0X2luZm8tcW9tLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAw
MDAwMDAuLjY5NzBiOTVlZTBiDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGFyZ2V0X2lu
Zm8tcW9tLmMNCj4gQEAgLTAsMCArMSwxNSBAQA0KPiArLyoNCj4gKyAqIFFFTVUgbGVnYWN5
IGJpbmFyeSBoZWxwZXJzDQo+ICsgKg0KPiArICogIENvcHlyaWdodCAoYykgTGluYXJvDQo+
ICsgKg0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIN
Cj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiArI2luY2x1ZGUg
InFlbXUvdGFyZ2V0X2luZm8tcW9tLmgiDQo+ICsNCj4gK3N0YXRpYyBjb25zdCBUeXBlSW5m
byB0YXJnZXRfaW5mb190eXBlc1tdID0gew0KPiArfTsNCj4gKw0KPiArREVGSU5FX1RZUEVT
KHRhcmdldF9pbmZvX3R5cGVzKQ0K

