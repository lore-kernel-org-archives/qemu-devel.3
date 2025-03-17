Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4B2C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuD1h-0008PX-Ti; Mon, 17 Mar 2025 12:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuD0x-0007yK-J9
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:08:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuD0u-0002oU-C7
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:08:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223fb0f619dso76051135ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742227705; x=1742832505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mzbTl5nkQKFBnmZRI2ae2XnEho9KAwozFu9d7AODj48=;
 b=QTaKELa8fDaj2sCINvLexXtsdrZeFVmZEH4Hy1ZpFL72aZHCdiHmkaQNjlUGuH7oAv
 ejg/Lv51tspbEpcHJulFQphHJMFirfy+IOgbVywLhVcY7xLq4lFOcLSrJ/uLZonxhCi5
 9Pu60I4hRmbq7xKzl3CRkZmDlkTzndFIl7angZd3e6hqkm/gWZXwbe/IbdLDzK7oNxbo
 s3vNhCLOIAz5ydCIrhoxnhjVx7LyXnqD6X0dUSMKJH6IOS8C5Lu23hUvRd9r+tBaUl0n
 kLYKCZmrFrcO/orWGMAkyWRioGtZtlKVDOpOGCvqLuWjeke7mUhLLSfQGdkFE4PMpKf/
 w3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742227705; x=1742832505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mzbTl5nkQKFBnmZRI2ae2XnEho9KAwozFu9d7AODj48=;
 b=sLBb2CmDpYl986yDKDLansB2Jal2LayvNNyAaI2q8kaWD8LdsO3yf33InM2IRRGK8e
 ZYVsXXTl9brgCSh1XArwBTw6SveYqlB+L7ttoFncu5KlQqxV6umjUa94oTHB5K7ZKkbo
 4LvYWlsqLGWe+ublXVPWYmJ1SXV2sAGhbwY+zaoWlZJe4oGdNvVTMAdkD6zE8LiUIj+S
 qXzrI4qsC13Hu870dISzFi4ICNdqZxsz4V1w6DSnWSO0Cp+cQmpXBWqLH+wQV3wLPoGv
 wkrPHfsLdeF6/2EvXM6s7ZLAW2iWQlZFURej/hVGxMXwJ6W4xM5QqxyW32GgNFkI2Rnu
 dacA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/+bYO/XR08Qusir2yfCnV5jGczg06RVVdBrGSq5ZJ5PS7sJ7BsxojilCV7+NeATnqyIdW87yvWY89@nongnu.org
X-Gm-Message-State: AOJu0Yzej7OeXu7B9w0p+bVXSuOJl9Cxzy7njbwF6BcqEqs80ANKMv/1
 Ed9iSRnh2Ms2mRS4Oaw16oP2yrWNmesK7RTi10HjJyoe23V5yZHjQHsDXQfYSgY=
X-Gm-Gg: ASbGncvoZ4p6BK0N1qQeOcAYr0G0HYKIsIE4JvW3VBpjCNnO8qjx0Xo5NMsZkAZxHN8
 l4ENlH2lTwS3fXrhK9Kz73yl+C1Mho4qzi6k3BX4mcPQ3yfEcgsHg49elknOiRObAIxNIAzWEjv
 c20O97B7zA79SNvaG6Xq+f8h4YKJg1jl9rfC6PAjgB54xtIr/HkQyydcTasDxymlyGj7Rmrl+cv
 fBHegdkd4EKOcyEI63E17I1LjbXq533J8rTUFM6gu4tnZOlOM8V4wTDFxHBYuhLmP63mDMB7rP9
 xCikaO2kQf0xNJ4qN//2GX5xIcdUH/xIrMJjgpmG/VqUaB7Qv7j4l1YGNw==
X-Google-Smtp-Source: AGHT+IF6KgkWQt4kB3+J3NVrqV33E3W11zYKhfEgS1LyTWV2K7KDq8lWeWA7BEGG4QAbFg5GBaiRXg==
X-Received: by 2002:a05:6a20:cf8a:b0:1f5:80a3:b006 with SMTP id
 adf61e73a8af0-1f5c1201c3fmr19005019637.21.1742227704759; 
 Mon, 17 Mar 2025 09:08:24 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea7c718sm7406992a12.62.2025.03.17.09.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:08:24 -0700 (PDT)
Message-ID: <7430b4de-284b-46b9-b29d-f018d0639431@linaro.org>
Date: Mon, 17 Mar 2025 09:08:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/17] exec/memory.h: make devend_memop "target
 defines" agnostic
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
 <20250314173139.2122904-6-pierrick.bouvier@linaro.org>
 <d5e2aa98-5b9c-4521-927f-86585b7b2cfa@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <d5e2aa98-5b9c-4521-927f-86585b7b2cfa@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gMy8xNy8yNSAwODo0OCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE0LzMvMjUgMTg6MzEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBXaWxsIGFsbG93
IHRvIG1ha2Ugc3lzdGVtL21lbW9yeS5jIGNvbW1vbiBsYXRlci4NCj4+DQo+PiBSZXZpZXdl
ZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAgIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCB8IDE2
ICsrKystLS0tLS0tLS0tLS0NCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDEyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMv
bWVtb3J5LmggYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCj4+IGluZGV4IGRhMjFlOTE1MGI1
Li4wNjkwMjFhYzNmZiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0K
Pj4gKysrIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQo+PiBAQCAtMzEzOCwyNSArMzEzOCwx
NyBAQCBhZGRyZXNzX3NwYWNlX3dyaXRlX2NhY2hlZChNZW1vcnlSZWdpb25DYWNoZSAqY2Fj
aGUsIGh3YWRkciBhZGRyLA0KPj4gICAgTWVtVHhSZXN1bHQgYWRkcmVzc19zcGFjZV9zZXQo
QWRkcmVzc1NwYWNlICphcywgaHdhZGRyIGFkZHIsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50OF90IGMsIGh3YWRkciBsZW4sIE1lbVR4QXR0cnMgYXR0cnMp
Ow0KPj4gICAgDQo+PiAtI2lmZGVmIENPTVBJTElOR19QRVJfVEFSR0VUDQo+PiAgICAvKiBl
bnVtIGRldmljZV9lbmRpYW4gdG8gTWVtT3AuICAqLw0KPj4gICAgc3RhdGljIGlubGluZSBN
ZW1PcCBkZXZlbmRfbWVtb3AoZW51bSBkZXZpY2VfZW5kaWFuIGVuZCkNCj4+ICAgIHsNCj4+
ICAgICAgICBRRU1VX0JVSUxEX0JVR19PTihERVZJQ0VfSE9TVF9FTkRJQU4gIT0gREVWSUNF
X0xJVFRMRV9FTkRJQU4gJiYNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBERVZJQ0Vf
SE9TVF9FTkRJQU4gIT0gREVWSUNFX0JJR19FTkRJQU4pOw0KPj4gICAgDQo+PiAtI2lmIEhP
U1RfQklHX0VORElBTiAhPSBUQVJHRVRfQklHX0VORElBTg0KPj4gLSAgICAvKiBTd2FwIGlm
IG5vbi1ob3N0IGVuZGlhbm5lc3Mgb3IgbmF0aXZlICh0YXJnZXQpIGVuZGlhbm5lc3MgKi8N
Cj4+IC0gICAgcmV0dXJuIChlbmQgPT0gREVWSUNFX0hPU1RfRU5ESUFOKSA/IDAgOiBNT19C
U1dBUDsNCj4+IC0jZWxzZQ0KPj4gLSAgICBjb25zdCBpbnQgbm9uX2hvc3RfZW5kaWFubmVz
cyA9DQo+PiAtICAgICAgICBERVZJQ0VfTElUVExFX0VORElBTiBeIERFVklDRV9CSUdfRU5E
SUFOIF4gREVWSUNFX0hPU1RfRU5ESUFOOw0KPj4gLQ0KPj4gLSAgICAvKiBJbiB0aGlzIGNh
c2UsIG5hdGl2ZSAodGFyZ2V0KSBlbmRpYW5uZXNzIG5lZWRzIG5vIHN3YXAuICAqLw0KPj4g
LSAgICByZXR1cm4gKGVuZCA9PSBub25faG9zdF9lbmRpYW5uZXNzKSA/IE1PX0JTV0FQIDog
MDsNCj4+IC0jZW5kaWYNCj4+ICsgICAgYm9vbCBiaWdfZW5kaWFuID0gKGVuZCA9PSBERVZJ
Q0VfTkFUSVZFX0VORElBTg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgPyB0YXJnZXRf
d29yZHNfYmlnZW5kaWFuKCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIDogZW5kID09
IERFVklDRV9CSUdfRU5ESUFOKTsNCj4gDQo+IFVubmVjZXNzYXJ5IHBhcmVudGhlc2lzPw0K
PiANCg0KTm90IHN0cmljdGx5IG5lZWRlZCBpbmRlZWQuDQpDb2RlIGlzIHJlZmFjdG9yZWQg
aW4gcGF0Y2ggMTQgYW55d2F5cy4NCg0KPj4gKyAgICByZXR1cm4gYmlnX2VuZGlhbiA/IE1P
X0JFIDogTU9fTEU7DQo+PiAgICB9DQo+PiAtI2VuZGlmIC8qIENPTVBJTElOR19QRVJfVEFS
R0VUICovDQo+PiAgICANCj4+ICAgIC8qDQo+PiAgICAgKiBJbmhpYml0IHRlY2hub2xvZ2ll
cyB0aGF0IHJlcXVpcmUgZGlzY2FyZGluZyBvZiBwYWdlcyBpbiBSQU0gYmxvY2tzLCBlLmcu
LA0KPiANCg0K

